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
    public partial class AssignGroupEmployees : BasePage
    {
        public string gID = "0";
        public string groupName = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("assigngroupemployees.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/assigngroupemployees.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("emp/assign-employees-to-groups"));

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

            if (Page.RouteData.Values["name"] != null)
            {
                groupName = (Page.RouteData.Values["name"] + "").Trim();                
            }
            else
            {
                groupName = (Request["name"] + "").Trim();
            }
            try
            {
                groupName = Encryption.Decrypt(groupName);
            }
            catch (Exception ex)
            {
            }
            if (Page.RouteData.Values["gid"] != null)
            {
                gID = (Page.RouteData.Values["gid"] + "").Trim();
            }
            else
            {
                gID = (Request["gid"] + "").Trim();
            }
            if (gID == "")
                gID = "0";

            divHiddenValues.InnerHtml = "<span id='spnHdy' style='display: none;'>" + gID + "</span> &nbsp;";

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_ORGANIZATION) == false)
            {
                //spnDeleteButton.Visible = false;
            }
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_ORGANIZATION) == false)
            {
                //spnAddButton.Visible = false;
            }

        }
    }
}