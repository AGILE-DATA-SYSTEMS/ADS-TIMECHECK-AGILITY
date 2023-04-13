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
    public class PatchHandler : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {


            if (context.Request["key"] != null && context.Request["key"].Trim() == "applyPatch" && !string.IsNullOrEmpty(context.Request["ticketnumber"] + ""))
            {

                SavePatchFile(context);
            }
        }
        private string SavePatchFile(HttpContext context)
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
                    string extension = Path.GetExtension(file.FileName);

                    string AllowedPatchedFile = ConfigurationManager.AppSettings["SupportFileExts"];

                    if (!string.IsNullOrEmpty(AllowedPatchedFile) && AllowedPatchedFile.IndexOf(extension) != -1)
                    {
                        string dirPath = "";
                        string virtualPath = "../Uploads/Support/Patches/";
                        if (!Directory.Exists(virtualPath))
                        {
                            Directory.CreateDirectory(context.Server.MapPath(virtualPath));
                        }
                        string OriginalList = "_Patch_Original_" + DateTime.Now.ToString("dd_MM_yyyy hh_mm_ss") + extension;
                        dirPath = context.Server.MapPath(virtualPath + OriginalList);
                        file.SaveAs(dirPath);
                        ExecuteScriptFromFile(dirPath, context);
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
            return ResultJSON;
        }
        public void ExecuteScriptFromFile(string ActualFilePath, HttpContext Context)
        {

            object ResultObj = new { };
            string TicketNumber = string.Empty;
            string ConnectionString = string.Empty;
            string query = string.Empty;
            int result = 0;

            TicketNumber = Context.Request["ticketnumber"] + "";

            try
            {
                ConnectionString = Connection.GetConnectionStrinng(Context.Session["dbType"] + "", Context.Session["dbName"] + "", Context.Session["dbUser"] + "", Context.Session["dbPassword"] + "");
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    Server server = new Server(new ServerConnection(conn));
                    query = File.ReadAllText(ActualFilePath);
                    query = Decrypt(query);
                    result = server.ConnectionContext.ExecuteNonQuery(query);
                    string ObjectDetail = string.Empty;
                    if (result != 0)
                    {
                        TAMSR2Data objDAL = new TAMSR2Data();
                        try
                        {
                             string objectname = string.Empty;
                            //if (query.Contains("procedure"))
                            //{
                            //    int index_proc_key = query.IndexOf("procedure");
                            //    int index_First_Param = query.IndexOf("@");
                            //    objectname = query.Substring(index_proc_key + 1, index_First_Param - 1);
                            //}
                            objDAL.OpenConnection(Connection.GetConnectionStrinng(Context.Session["dbType"] + "", Context.Session["dbName"] + "", Context.Session["dbUser"] + "", Context.Session["dbPassword"] + ""));
                            Hashtable ht;
                            ht = new Hashtable();
                            ht.Add("sessionID", Context.Session["ID"] + "");
                            ht.Add("action", "save");
                            ht.Add("TicketNumber", TicketNumber);
                            ht.Add("FileLocation", ActualFilePath);
                            ht.Add("PatchObject", objectname);
                            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                            ht.Add("createdBy", Context.Session["ID"] + "");

                            string resultxx = objDAL.Connection.GetValueProcedure("xx_patch_logs_ops", ht);

                            if (Numerics.GetDecimal(resultxx) >= 0)
                            {


                            }
                            else
                            {

                            }

                        }
                        catch (Exception ex)
                        {
                            new ExceptionLog().WriteLog("RequestPages/EmailLogs.aspx.ExecuteScriptFromFile()", 0, ex);

                        }
                        finally
                        {
                            objDAL.CloseConnection();

                        }

                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/PatchHandler.ExecuteScriptFromFile()", 0, ex);
            }
            finally
            {

            }

            Context.Response.ContentType = "text/plain";
            Context.Response.Write("Completed");
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