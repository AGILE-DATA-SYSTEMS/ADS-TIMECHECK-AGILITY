using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using TAMSR2.CustomClasses;
using System.Globalization;

namespace TAMSR2.Reports
{
    public partial class StandardReports : BasePage
    {
        public DateTime FirstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
         public string format = CultureInfo.CurrentCulture.ToString();

        
        /// <summary>
        /// Set page culture values according to user selection
        /// </summary>
        /// 
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
                new ExceptionLog().WriteLog("reports/ViewMonthlyRosterView.aspx.SetCultureValues()", 0, ex);
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("standardreports.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/standardreports.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("reports/standard-reports"));

            #region User Authentication and Preferences
            /// <summary>
            /// Checks Session variable for login, if windows login is not activate 
            /// otherwise Authenticate user by windows login if Windows Login is activated in Web.config
            /// And also Set Page Culture Variables for user preffered language.
            /// </summary>
            if (UserAuthentication() == false)
            {
                Response.Redirect(path + "Login");
            }
            SetCultureValues();

            string cul = CultureInfo.CurrentCulture.ToString();
            #endregion

        }

        public string CheckInactivePrivilege()
        {
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.INCLUDE_INACTIVE_STAFF_IN_REPORTS) == true)
                return "";
            else
                return "display:none;";
        }
        
    }
}