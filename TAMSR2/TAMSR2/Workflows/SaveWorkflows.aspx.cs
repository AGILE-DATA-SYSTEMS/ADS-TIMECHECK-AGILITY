using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Workflows
{
    public partial class SaveWorkflows : BasePage
    {
        public string LeaveID = "0"; 

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("saveworkflows.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("workflows/saveworkflows.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("workflows/save-workflow"));

            if (Page.RouteData.Values["Workflow"] != null)
            {
                LeaveID = (Page.RouteData.Values["Workflow"] + "").Trim();             }
            else
            {
                LeaveID = (Request["Leave"] + "").Trim(); 
            }
            if (LeaveID == "")
                LeaveID = "0";

            divHiddenValues.InnerHtml = "<span id='spnLeave' style='display: none;'>" + LeaveID + "</span> &nbsp;"; 

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