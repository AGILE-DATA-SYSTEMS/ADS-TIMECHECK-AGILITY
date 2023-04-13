using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
namespace TAMSR2.CustomClasses
{
    public class DownloadClass
    {
           //string file = @"D:\release2.appdigi.com\TAMSR2\TAMSR2\Uploads\Roster\Faileduploads\2016_9_RosterExcel_19_09_2016 06_34_29.xlsx";
           // System.IO.FileStream sourceFile = new System.IO.FileStream(file, System.IO.FileMode.Open);
           // float FileSize;
           // FileSize = sourceFile.Length;
           // byte[] getContent = new byte[(int)FileSize];
           // sourceFile.Read(getContent, 0, (int)sourceFile.Length);
           // sourceFile.Close();
           // Response.ClearContent();
           // Response.ClearHeaders();
           // Response.Buffer = true;
           // Response.Charset = "";
           // Response.ContentType = "application/vnd.xls";
           // Response.AddHeader("Content-Length", getContent.Length.ToString());
           // Response.AddHeader("Content-Disposition", "attachment; filename=" + sourceFile.Name);
           // Response.BinaryWrite(getContent);
           // Response.Flush();
           // Response.End();

         public void DownloadFile(HttpContext Context, string FullServerPath)
         {
             if (File.Exists(FullServerPath))
             {
                 
                 string FileActualName = Path.GetFileName(FullServerPath);
                 FileStream SourceFile = new System.IO.FileStream(FullServerPath, System.IO.FileMode.Open);
                 float FileSize = SourceFile.Length;
                 byte[] getContent = new byte[(int)FileSize];
                 SourceFile.Read(getContent, 0, (int)SourceFile.Length);
                 SourceFile.Close();
                 Context.Response.ClearContent();
                 Context.Response.ClearHeaders();
                 Context.Response.Buffer = true;
                 Context.Response.Charset = "";
                 Context.Response.ContentType = GetMimeType(FileActualName);
                 Context.Response.AddHeader("Content-Length", getContent.Length.ToString());
                 Context.Response.AddHeader("Content-Disposition", "attachment; filename=" + FileActualName);
                 Context.Response.BinaryWrite(getContent);
                 Context.Response.Flush();
                 Context.Response.End();
             }
             
         }
         public static string GetMimeType(string FileName)
         {
             if (FileName == null)
             {
                 throw new ArgumentNullException("extension");
             }


             string mime;
             mime = MimeMapping.GetMimeMapping(FileName);
             return mime;
         }
       
    }
   
}