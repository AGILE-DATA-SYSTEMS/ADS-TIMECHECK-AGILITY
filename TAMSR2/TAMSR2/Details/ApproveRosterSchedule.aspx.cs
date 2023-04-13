﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;

namespace TAMSR2.Details
{
    public partial class ApproveRosterSchedule : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("approverosterschedule.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/approverosterschedule.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("sch/approve-monthly-roster"));

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

            //if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_SCHEDULE_ROSTER) == false)
            //{
            //    //spnDeleteButton.Visible = false;
            //}
            //if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_SCHEDULE_ROSTER) == false)
            //{
            //    spnAddButton.Visible = false;
            //}


        }
    }
}