﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL; 

namespace TAMSR2.Dashboard
{
    public partial class TeamStats : BasePage
    {
        string languagePostfix = "_eng"; 
        protected void Page_Load(object sender, EventArgs e)
        {

            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_TEAM_DASHBOARD) == false)
            {
                Response.Redirect(ResolveClientUrl("~/Common/Home"));
            }

            DBAppSetting AppStng = new DBAppSetting();
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("teamstats.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("dashboard/teamstats.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("dashboard/team-stats"));

            #region User Authentication and Preferences
            /// <summary>
            /// Checks Session variable for login, if windows login is not activate 
            /// otherwise Authenticate user by windows login if Windows Login is activated in Web.config
            /// And also Set Page Culture Variables for user preffered language.
            /// </summary>
            if (UserAuthentication() == false)
            {
                if (ConfigurationManager.AppSettings["ADLogin"] + "" == "1")
                    Response.Redirect(path + "Login/" + Request.LogonUserIdentity.Name + "");
                else
                    Response.Redirect(path + "Logout");
                return;
            }
            SetCultureValues();
            #endregion

            string welcome = (String)GetGlobalResourceObject("Resource", "welcome");
             
        }
    }
}