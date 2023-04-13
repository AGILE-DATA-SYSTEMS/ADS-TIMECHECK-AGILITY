using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Admin
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        public static string url = "";
        public static string languageStr = "en";
        public static string pullDirectionStr = "right";
        public static string username = "";
        public static string password = "";
        public static string companyID = "";
        public static bool remember = false;
        /// <summary>
        /// Set page culture values according to user selection
        /// </summary>
        #region
        public void SetCultureValues()
        {
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
                pullDirectionStr = cookie.Values["pullDirection"] + "";
                languageStr = cookie.Values["language"] + "";
                Page.UICulture = cookie.Values["culture"] + "";
                Page.Culture = cookie.Values["culture"] + "";
            }
            catch (Exception ex)
            {
                pullDirectionStr = AppSetting.defaultPullDirection + "";
                languageStr = AppSetting.defaultLanguage + "";
                Page.UICulture = AppSetting.defaultCulture + "";
                Page.Culture = AppSetting.defaultCulture + "";
                new ExceptionLog().WriteLog("AdminLogin.aspx.SetCultureValues()", 0, ex);
            }
            if (languageStr == "en")
            {
                pullDirectionStr = "right";
                Session["changeLanguage"] = (String)GetGlobalResourceObject("Resource", "changeLanguage"); 
            }
            else
            {
                pullDirectionStr = "left";
                Session["changeLanguage"] = (String)GetGlobalResourceObject("Resource", "changeLanguage"); 
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            SetCultureValues();

            HttpCookie cookie = Request.Cookies["TAMSR2"];
            if (cookie != null)
            {
                username = Encryption.Decrypt(cookie.Values["username"] + "");
                password = Encryption.Decrypt(cookie.Values["password"] + "");
                companyID = Encryption.Decrypt(cookie.Values["companyID"] + "");
                remember = Numerics.GetBool(cookie.Values["remember"] + "");
            }

        }
    }
}