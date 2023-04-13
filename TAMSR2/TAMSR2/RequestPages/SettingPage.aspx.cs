using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework.DAL;

namespace TAMSR2.RequestPages
{
    public partial class SettingPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Culture = Session["Language"] + "";
            Page.UICulture = Session["Language"] + "";

            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/SettingPage.aspx"));

            string data = "";

            if (Session["ID"] + "" == "" && Request["key"] + "" != "changeLanguage")
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "changeLanguage")
            {
                data = ChangeLanguage();
            }
            else if (Request["key"] + "" == "toggleSidebar")
            {
                data = ToggleSidebar();
            }
            else if (Request["key"] + "" == "changeTheme")
            {
                data = ChangeTheme();
            }
            else
            {
                data = "";
            }

            //Response.Clear();
            //Response.ClearHeaders();
            //Response.ClearContent();
            Response.Write(data);
            Response.Flush();
            //Response.End();

        }

        public string ChangeLanguage()
        {
            bool chk = false;
            HttpCookie cookie = Request.Cookies["tamsCulture"];
            try
            {
                if (cookie == null)
                {
                    cookie = new HttpCookie("tamsCulture");
                    cookie.Values.Add("pullDirection", AppSetting.defaultPullDirection + "");
                    cookie.Values.Add("language", AppSetting.defaultLanguage + "");
                    cookie.Values.Add("culture", AppSetting.defaultCulture + "");
                    cookie.Values.Add("timeZone", AppSetting.defaultTimeZone + "");
                    cookie.Values.Add("dateFormat", AppSetting.dateFormat + "");
                    cookie.Values.Add("dateTimeFormat", AppSetting.dateTimeFormat + "");

                    DateTime dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(7);
                    cookie.Expires = dt;
                    Response.Cookies.Add(cookie);
                }
                else
                {
                    if (cookie.Values["language"] + "" == "ar")
                    {
                        cookie = new HttpCookie("tamsCulture");
                        cookie.Values.Add("pullDirection", "right");
                        cookie.Values.Add("language", "en");
                        cookie.Values.Add("culture", "en-US");
                    }
                    else
                    {
                        cookie = new HttpCookie("tamsCulture");
                        cookie.Values.Add("pullDirection", "left");
                        cookie.Values.Add("language", "ar");
                        cookie.Values.Add("culture", "ar-AE");
                    }
                    chk = new EmployeePreference().Save(Session["ID"] + "", Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + "", cookie.Values["language"] + "", "10", Session["sidebar"] + "", Session["theme"] + "");
                    cookie.Values.Add("timeZone", AppSetting.defaultTimeZone + "");
                    cookie.Values.Add("dateFormat", AppSetting.dateFormat + "");
                    cookie.Values.Add("dateTimeFormat", AppSetting.dateTimeFormat + "");

                    DateTime dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(7);
                    cookie.Expires = dt;
                    Response.Cookies.Add(cookie);
                    Request.Cookies.Add(cookie);
                }
                Page.UICulture = cookie.Values["culture"] + "";
                Page.Culture = cookie.Values["culture"] + "";
            }
            catch (Exception ex)
            {
                Page.UICulture = AppSetting.defaultCulture + "";
                Page.Culture = AppSetting.defaultCulture + "";
            }
            return "1";
        }

        public string ToggleSidebar()
        {
            bool chk = false;
            try
            {
                Session["sidebar"] = (Request["status"] + "").Trim();
                EmployeePreference obj = new EmployeePreference().GetEmployeePreference(Session["ID"] + "", Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + "");
                obj.Sidebar = Session["sidebar"] + "";
                chk = new EmployeePreference().Save(Session["ID"] + "", Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + "", obj.Language, obj.PageSize + "", obj.Sidebar, obj.Theme);
                
            }
            catch (Exception ex)
            {
                Page.UICulture = AppSetting.defaultCulture + "";
                Page.Culture = AppSetting.defaultCulture + "";
            }
            return Numerics.GetInt(chk) + "";
        }

        public string ChangeTheme()
        {
            bool chk = false;
            try
            {
                Session["theme"] = (Request["theme"] + "").Trim();
                EmployeePreference obj = new EmployeePreference().GetEmployeePreference(Session["ID"] + "", Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + "");
                obj.Theme = Session["theme"] + "";
                chk = new EmployeePreference().Save(Session["ID"] + "", Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + "", obj.Language, obj.PageSize + "", obj.Sidebar, obj.Theme);

            }
            catch (Exception ex)
            {
                Page.UICulture = AppSetting.defaultCulture + "";
                Page.Culture = AppSetting.defaultCulture + "";
            }
            return Numerics.GetInt(chk) + "";
        }


    }
}