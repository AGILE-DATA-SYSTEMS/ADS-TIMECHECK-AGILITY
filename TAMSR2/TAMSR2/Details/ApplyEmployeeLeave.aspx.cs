using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Details
{
    public partial class ApplyEmployeeLeave : BasePage
    {
        public string empLv = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("applyemployeeleave.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/applyemployeeleave.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("leaves/save-employee-leave"));

            if (Page.RouteData.Values["empLv"] != null)
            {
                empLv = (Page.RouteData.Values["empLv"] + "").Trim();
            }
            else
            {
                empLv = (Request["empLv"] + "").Trim();
            }
            if (empLv == "")
                empLv = "0";

            divHiddenValues.InnerHtml = "<span id='spnEmpLv' style='display: none;'>" + empLv + "</span> &nbsp;";

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

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_EMP_LEAVE) == false)
            {
                //spnDeleteButton.Visible = false;
            }
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_EMP_LEAVE) == false)
            {
                //spnAddButton.Visible = false;
            }

        }
    }
}