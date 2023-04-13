using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;

namespace TAMSR2.Details
{
    public partial class SaveEmployeeGroup : BasePage
    {
        public string groupID = "0";
        protected void Page_Load(object sender, EventArgs e)
        {

            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("saveemployeegroup.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/saveemployeegroup.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("emp/save-employee-group"));

            if (Page.RouteData.Values["gid"] != null)
            {
                groupID = (Page.RouteData.Values["gid"] + "").Trim();
            }
            else
            {
                groupID = (Request["gid"] + "").Trim();
            }
            if (groupID.Trim() == "")
                groupID = "0";

            divHiddenValues.InnerHtml = "<span id='spnGroup' style='display: none;'>" + groupID + "</span> &nbsp;";

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