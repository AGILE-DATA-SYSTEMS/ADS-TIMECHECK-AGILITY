/* **************************************************************
 * File Name        : ExceptionLog.cs
 * Description      : Log all applications into file as XML format
 * 
 * Author		    : Muhammad Aqeel Abbas @linktoaqeel
 * Created		    : May 22, 2013
 * Dependency	    : 
 * 
 * Revision History :
 * 
 * 
 * *************************************************************/

/* **************************************************************
 * File Name        : ExceptionLog.cs
 * Description      : Log All applications exceptions to file in XML format
 * 
 * Author		    : Muhammad Aqeel Abbas @linktoaqeel
 * Created		    : May 22, 2013
 * 
 * Revision History :
 * 
 * 
 * *************************************************************/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using TAMSR2Framework.DAL;

namespace TAMSR2Framework
{
    public class ExceptionLog
    {
        public string GetFilenameYYYMMDD(string suffix, string extension)
        {
            return System.DateTime.Now.ToString("yyyy-MM-dd ") + suffix + extension;
        }

        public void WriteLog(string message, int errorNumber, Exception ex)
        {
            //just in case: we protect code with try.
            try
            {
                string filename = AppSetting.errorLogPath + "\\" + GetFilenameYYYMMDD("_LOG", ".log");
                filename = filename.Replace("\\", @"\");
                System.IO.StreamWriter sw = new System.IO.StreamWriter(filename, true);
                XElement xmlEntry = new XElement("LogEntry",
                    new XElement("Date", System.DateTime.Now.ToString()),
                    new XElement("Exception",
                        new XElement("Module", message),
                        new XElement("ErrorNumber", errorNumber),
                        new XElement("Source", ex.Source),
                        new XElement("Message", ex.Message),
                        new XElement("Stack", ex.StackTrace)
                     )//end exception
                );
                //has inner exception?
                if (ex.InnerException != null)
                {
                    xmlEntry.Element("Exception").Add(
                            new XElement("InnerException",
                            new XElement("Module", message),
                            new XElement("ErrorNumber", errorNumber),
                            new XElement("Source", ex.InnerException.Source),
                            new XElement("Message", ex.InnerException.Message),
                            new XElement("Stack", ex.InnerException.StackTrace))
                        );
                }
                sw.WriteLine(xmlEntry);
                sw.Close();
            }
            catch (Exception)
            {
            } 
        }
    }
}
