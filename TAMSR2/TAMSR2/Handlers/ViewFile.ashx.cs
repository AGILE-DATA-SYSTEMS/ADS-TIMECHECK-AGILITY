using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using TAMSR2.CustomClasses;

namespace TAMSR2.Handlers
{
    /// <summary>
    /// Summary description for ViewFile
    /// </summary>
    public class ViewFile : IHttpHandler, System.Web.SessionState.IRequiresSessionState 
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            try
            {
                if (context.Request["type"] + "" == "encr")
                {
                    string temp = context.Request["val"] + "";
                    temp = Encryption.Encrypt(temp);
                    context.Response.Write(temp);
                }
                else
                {
                    string fileName = ConfigurationManager.AppSettings["fileName"] + "";
                    FileInfo obj = new FileInfo(context.Server.MapPath("~/Uploads/" + fileName));
                    context.Response.ContentType = "image/png";

                    switch (obj.Extension.ToLower())
                    {
                        case ".pdf":
                            context.Response.ContentType = "application/pdf";
                            break;
                        case ".doc":
                            context.Response.ContentType = "application/msword";
                            break;
                        case ".docx":
                            context.Response.ContentType = "application/vnd.ms-word.document.12";
                            break;
                        case ".xls":
                            context.Response.ContentType = "application/vnd.ms-excel";
                            break;
                        case ".xlsx":
                            context.Response.ContentType = "application/vnd.ms-excel.12";
                            break;
                        default:
                            context.Response.ContentType = "image/jpeg";
                            break;
                    }
                    context.Response.WriteFile(obj.FullName);
                }
            }
            catch (Exception ex)
            {
                context.Response.WriteFile("");
            }
        
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