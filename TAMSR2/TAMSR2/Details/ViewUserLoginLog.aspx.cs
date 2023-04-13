using System;
using TAMSR2.CustomClasses;

namespace TAMSR2.Details
{
    public partial class ViewUserLoginLog : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewuserloginlog.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/viewuserloginlog.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("security/view-login-log"));

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
            #endregion

        }
    }
}