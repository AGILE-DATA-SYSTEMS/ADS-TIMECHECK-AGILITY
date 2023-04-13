using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework.DAL;

namespace TAMSR2.Handlers
{
    /// <summary>
    /// Summary description for EmployeeProfileImage
    /// </summary>
    /// 
    public class EmployeeProfileImage : IHttpHandler, System.Web.SessionState.IRequiresSessionState 
    {
        bool LoadEmployeeImageFromFolder = false;
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                
                decimal userID = -1;
                string temp = "";
                string Code = "";
                if (context.Request.QueryString["id"] != null)
                    temp = context.Request.QueryString["id"];
                else if (context.Request["id"] + "" != "")
                    temp = (context.Request["id"] + "").Trim();
                else
                    throw new ArgumentException("No parameter specified");
                temp = temp.Replace(".jpg", "");
                try
                {
                    if (context.Request.QueryString["Type"] != "Code")
                    {
                        userID = Numerics.GetDecimal(Encryption.Decrypt(temp));
                        Code = "";
                    }
                    else
                        Code = temp;

                }
                catch (Exception ex)
                {
                    userID = Numerics.GetDecimal(temp);
                }
                string server = ConfigurationManager.AppSettings["dbServer"];
                string connectionString = "Data Source=" + server + ";Initial Catalog=" + context.Session["dbName"] + ";uid=" + context.Session["dbUser"] + ";pwd=" + context.Session["dbPassword"] + "";
                
                //Employee objEmp = new Employee(userID, Convert.ToDecimal(context.Session["ID"] + ""));
                if (context.Session["LoadEmployeeImageFromFolder"] + "" != "true")
                {
                    LoadEmployeeImageFromFolder = new DBAppSetting().GetEmployeeImageFromFolder(userID, connectionString);
                    context.Session["LoadEmployeeImageFromFolder"] = "true";
                }
                else
                    LoadEmployeeImageFromFolder = true;
                try
                {

                    if (LoadEmployeeImageFromFolder == false)
                    {
                        EmployeeImage obj = new EmployeeImage().GetImageByEmployeeID(userID, connectionString);
                        if (obj != null && obj.ProfileImage != null)
                        {
                            byte[] buffer = obj.ProfileImage;
                            context.Response.ContentType = obj.Ext;
                            context.Response.BinaryWrite(buffer);
                        }
                        else
                        {
                            byte[] buffer = ImageToByteArray();
                            context.Response.ContentType = obj.Ext;
                            context.Response.BinaryWrite(buffer);
                        }
                    }
                    else
                    {
                        //string virtualPath = "/Uploads/ProfileImages/" + objEmp.Code + ".jpg";

                        if (Code == "")
                        {
                            Employee objEmp = new Employee(userID, Convert.ToDecimal(context.Session["ID"] + ""));
                            Code = objEmp.Code;
                        }

                        string virtualPath = "/EmployeeImages/" + Code + ".jpg";
                        if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(virtualPath)))
                        {
                            byte[] buffer = System.IO.File.ReadAllBytes(HttpContext.Current.Server.MapPath(virtualPath));
                            context.Response.ContentType = ".jpg";
                            context.Response.BinaryWrite(buffer);
                        }
                        else
                        {
                            byte[] buffer = ImageToByteArray();
                            context.Response.ContentType = ".jpg";
                            context.Response.BinaryWrite(buffer);
                        }

                        //Session["EmployeeCode"] = (rw["employee_code"] + "").Trim();
                    }
                }
                catch (Exception ex)
                {
                }
            } 
            catch (Exception ee)
            {
                 
            }
        }
        byte[] ImageToByteArray()
        {

            return System.IO.File.ReadAllBytes(HttpContext.Current.Server.MapPath("~/images/default_member.jpg"));
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