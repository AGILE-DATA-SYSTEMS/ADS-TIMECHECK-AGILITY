using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using TAMSR2.ObjectClasses;
using TAMSR2Framework.DAL;

namespace TAMSR2.Handlers
{
    /// <summary>
    /// Summary description for AjaxFileUpload
    /// </summary>
    public class AjaxFileUpload : IHttpHandler, System.Web.SessionState.IRequiresSessionState 
    {

        public void ProcessRequest(HttpContext context)
        {
            decimal id = Numerics.GetDecimal(context.Request["id"] + "");
            decimal updateUserID = Numerics.GetDecimal(context.Request["userID"] + "");
            TAMSR2Company obj = new TAMSR2Company(id);


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
                    //string fileExtension = Path.GetExtension(file.FileName) + "||" + file.ContentType;
                    Random rand = new Random();
                    string dirPath = "";
                    do
                    {
                        obj.Logo = "Logo_" + rand.Next(1000) + extension;
                        dirPath = context.Server.MapPath("../Uploads/Logo/" + obj.Logo);
                    } while (File.Exists(dirPath));

                    file.SaveAs(dirPath);
                    //int imageLength = file.ContentLength;
                    //byte[] picbyte = new byte[imageLength];
                    //file.InputStream.Read(picbyte, 0, imageLength);
                    //obj.Logo = picbyte;
                }
                else
                {
                    obj.Logo = "";
                }
            }
            
            string result = new TAMSR2Company().UpdateLogo(obj, updateUserID);
            
        
            string msg = "{";

            msg += string.Format("error:'{0}',\n", string.Empty);

            msg += string.Format("msg:'{0}'\n", result);

            msg += "}";

            context.Response.Write(msg);
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