using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;

namespace TAMSR2.Details
{
    public partial class AssignUserRoles : BasePage
    {
        public string roleID = "0";
        public string roleName = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("assignuserroles.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/assignuserroles.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("security/assign-employees-to-roles"));

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

            if (Page.RouteData.Values["roleName"] != null)
            {
                roleName = (Page.RouteData.Values["roleName"] + "").Trim();
            }
            else
            {
                roleName = (Request["roleID"] + "").Trim();
            }

            if (Page.RouteData.Values["roleID"] != null)
            {
                roleID = (Page.RouteData.Values["roleID"] + "").Trim();
            }
            else
            {
                roleID = (Request["roleID"] + "").Trim();
            }
            if (roleID == "")
                roleID = "0";

            divHiddenValues.InnerHtml = "<span id='spnRoleID' style='display: none;'>" + roleID + "</span> &nbsp;";

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.ASSIGN_ROLE) == false)
            {
                Response.Redirect(path + "Home/Common");
            }

        }
    }
}