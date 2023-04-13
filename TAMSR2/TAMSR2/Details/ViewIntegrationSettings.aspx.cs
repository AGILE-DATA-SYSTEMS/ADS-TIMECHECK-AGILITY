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

namespace TAMSR2.Details
{
    public partial class ViewIntegrationSettings : BasePage
    {
        public string perm = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            //if (url.ToLower().Contains("saveshortpermission.aspx"))
            //    path = url.Substring(0, url.ToLower().IndexOf("details/saveshortpermission.aspx"));
            //else
            //    path = url.Substring(0, url.ToLower().IndexOf("leaves/save-short-permission"));

            if (url.ToLower().Contains("viewintegrationsettings.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/viewintegrationsettings.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("security/integration-settings"));

            if (Page.RouteData.Values["perm"] != null)
            {
                perm = (Page.RouteData.Values["perm"] + "").Trim();
            }
            else
            {
                perm = (Request["perm"] + "").Trim();
            }
            if (perm == "")
                perm = "0";

            divHiddenValues.InnerHtml = "<span id='spnPerm' style='display: none;'>" + perm + "</span> &nbsp;";

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

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_APPLICATION_SETTINGS) == false)
            {
                Response.Redirect(path + "Common/Home");
            }
        }
    }
}