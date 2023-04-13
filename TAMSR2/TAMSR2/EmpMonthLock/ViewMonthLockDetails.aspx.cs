﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.EmpMonthLock
{
    public partial class ViewMonthLockDetails : BasePage
    {
        public string ID = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewmonthlockdetails.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("empmonthlock/viewmonthlockdetails.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("freeze/month-lock-details"));

            if (Page.RouteData.Values["id"] != null)
            {
                 ID = (Page.RouteData.Values["id"] + "").Trim(); 
            }
            divHiddenValues.InnerHtml = "<span id='spnID' >" +  ID + "</span> &nbsp;";
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

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_SCHEDULE) == false)
            {
                // spnDeleteButton.Visible = false;
            }
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_SCHEDULE) == false)
            {
                 spnAddButton.Visible = false;
            }

        }
    }
}