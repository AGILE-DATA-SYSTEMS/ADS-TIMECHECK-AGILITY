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
    public partial class ViewScheduleLocations : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewschedulelocations.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/viewschedulelocations.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("sch/schedule-locations"));

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

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_ORGANIZATION) == false)
            {
                //spnDeleteButton.Visible = false;
            }
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_ORGANIZATION) == false)
            {
                spnAddButton.Visible = false;
            }

        }
    }
}