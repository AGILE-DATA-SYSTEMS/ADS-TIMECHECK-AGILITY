using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;

namespace TAMSR2.Details
{
    public partial class SaveWebpunchExcludeList : BasePage
    {
        public string punchID = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("saveholiday.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/savewebpunchexcludelist.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("emp/employee-webpunch-exception"));

            if (Page.RouteData.Values["webpunch"] != null)
            {
                punchID = (Page.RouteData.Values["webpunch"] + "").Trim();
            }
            else
            {
                punchID = (Request["webpunch"] + "").Trim();
            }
            if (punchID == "")
                punchID = "0";

            divHiddenValues.InnerHtml = "<span id='spnWebpunch' style='display: none;'>" + punchID + "</span> &nbsp;";

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