using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Handlers
{
    /// <summary>
    /// Summary description for PatchHandler
    /// </summary>
    public class ApplyLicense : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {


            if (context.Request["key"] != null && context.Request["key"].Trim() == "applyLicense")// && context.Request["LicenseType"] + "" =="AppLicense")
            {

                SaveLicenseFile(context);
            }
            //else if (context.Request["key"] != null && context.Request["key"].Trim() == "applyLicense" && context.Request["LicenseType"] + "" == "SupportLicense")
            //{
            //}
        }
        private void SaveLicenseFile(HttpContext context)
        {
            decimal id = Numerics.GetDecimal(context.Request["id"] + "");
            decimal updateUserID = Numerics.GetDecimal(context.Request["userID"] + "");
            TAMSR2Company obj = new TAMSR2Company(id);

            string ResultJSON = string.Empty;
            if (context.Request.Files.Count > 0)
            {
                var file = context.Request.Files[0];
                string fileName;
                if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                {
                    string[] files = file.FileName.Split(new char[] { '\\' });
                    fileName = files[files.Length - 1];
                }
                else
                {
                    fileName = file.FileName;
                }
                if (fileName.Trim() != "")
                {
                    string extension = Path.GetExtension(file.FileName).ToLower();

                    string AllowedPatchedFile = ConfigurationManager.AppSettings["SupportFileExts"];

                    if (!string.IsNullOrEmpty(AllowedPatchedFile) && AllowedPatchedFile.IndexOf(extension) != -1)
                    {
                        string dirPath = "";
                        string virtualPath = "../License/";
                        if (!Directory.Exists(virtualPath))
                        {
                            Directory.CreateDirectory(context.Server.MapPath(virtualPath));
                        }
                        string OriginalList = fileName + DateTime.Now.ToString("dd_MM_yyyy hh_mm_ss") + extension;
                        dirPath = context.Server.MapPath(virtualPath + OriginalList);
                        file.SaveAs(dirPath);
                        ResultJSON = ExecuteScriptFromFile(dirPath, context);
                    }
                    else
                    {
                        ResultJSON = "";
                    }
                }
                else
                {
                    obj.Logo = "";
                }
            }

            context.Response.ContentType = "text/plain";
            context.Response.Write(ResultJSON);
        }
        public string ExecuteScriptFromFile(string ActualFilePath, HttpContext Context)
        {

            object ResultObj = new { };
            string LicenseType = "Primary";
            string CompanyCode = "";
            string ConnectionString = string.Empty;
            string query = string.Empty;
            string result = "0";
            bool res = false;

            TAMSR2Licence obj = new TAMSR2Licence();

            try
            {
                ConnectionString = Connection.GetConnectionStrinng(ConfigurationManager.AppSettings["dbType"] + "", ConfigurationManager.AppSettings["dbName"] + ""  ,ConfigurationManager.AppSettings["dbUser"] + "", ConfigurationManager.AppSettings["dbPassword"] + "" );

                CompanyCode = ConfigurationManager.AppSettings["CompCode"] + "";

                query = File.ReadAllText(ActualFilePath);

                if (Context.Request["LicenseType"] + "" == "SupportLicense")
                {
                    obj = new TAMSR2Licence(query);
                    res = obj.isValid;
                }
                else
                {
                    LicenseType = Context.Request["Cat"] + "";
                    res = new TAMSR2Licence().IsValidLicense(query);
                    obj.isValid = res;
                }
                 
                if (res == false || obj.isValid == false)
                    {
                        result = "2";
                        return result;
                    }
                        TAMSR2Data objDAL = new TAMSR2Data();
                        try
                        {
                            string objectname = string.Empty;

                            objDAL.OpenConnection(ConnectionString);
                            Hashtable ht;
                            ht = new Hashtable();
                            ht.Add("sessionID", "1");
                            if (Context.Request["LicenseType"] + "" != "SupportLicense")
                            {
                                ht.Add("action", "AddLicense");
                                ht.Add("LicenseType", LicenseType);
                                ht.Add("LicenseKey", query);
                            }
                            else
                            {
                                ht.Add("action", "save");
                                ht.Add("NameEn", obj.Name);
                                ht.Add("FromDate", Convert.ToDateTime(obj.StartDate).ToString("yyyy-MM-dd"));
                                ht.Add("ToDate", Convert.ToDateTime(obj.EndDate).ToString("yyyy-MM-dd"));
                                
                            }
                            ht.Add("CompanyCode", CompanyCode);
                            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                            ht.Add("createdBy", "1");

                             result = objDAL.Connection.GetValueProcedure("TAMSR2_LicenseOps", ht);

                            if (Numerics.GetDecimal(result) <= 0)
                            {
                                result = "0";

                            } 

                        }
                        catch (Exception ex)
                        {
                            new ExceptionLog().WriteLog("RequestPages/EmailLogs.aspx.ExecuteScriptFromFile()", 0, ex);
                            result = "0";
                        }
                        finally
                        {
                            objDAL.CloseConnection();

                        }
                        return result;
                    
                 
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/PatchHandler.ExecuteScriptFromFile()", 0, ex);
                return "-1";
            }
            finally
            {
                
            }
             
        }
        string Decrypt(string encryptedText)
        {
            string PasswordHash = "P@@@Sw0rd";
            string SaltKey = "S@LT&KEYY";
            string VIKey = "@1B2c3D4e5F6g7H9";
            byte[] cipherTextBytes = Convert.FromBase64String(encryptedText);
            byte[] keyBytes = new Rfc2898DeriveBytes(PasswordHash, Encoding.ASCII.GetBytes(SaltKey)).GetBytes(256 / 8);
            var symmetricKey = new RijndaelManaged() { Mode = CipherMode.CBC, Padding = PaddingMode.None };

            var decryptor = symmetricKey.CreateDecryptor(keyBytes, Encoding.ASCII.GetBytes(VIKey));
            var memoryStream = new MemoryStream(cipherTextBytes);
            var cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read);
            byte[] plainTextBytes = new byte[cipherTextBytes.Length];

            int decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);
            memoryStream.Close();
            cryptoStream.Close();
            return Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount).TrimEnd("\0".ToCharArray());
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}