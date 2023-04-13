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

namespace TAMSR2.Reports
{
    public partial class ViewRosterReport : BasePage
    {
        
        protected void Page_Init(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewrosterreport.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/viewrosterreport.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("reports/generate-roster-report"));

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

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        
    }
}