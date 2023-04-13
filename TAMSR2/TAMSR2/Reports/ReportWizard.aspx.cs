using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using TAMSR2.ObjectClasses;

namespace TAMSR2.Reports
{
    public partial class ReportWizard1 : BasePage
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Filters"] = "";

            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("reportwizard.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/reportwizard.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("reports/generate-report"));

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