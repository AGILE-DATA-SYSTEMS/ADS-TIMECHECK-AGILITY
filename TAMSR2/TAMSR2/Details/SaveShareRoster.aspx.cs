﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework.DAL;

namespace TAMSR2.Details
{
    public partial class SaveShareRoster : BasePage
    {
        public string schID = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("SaveShareRoster.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/saveshareroster.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("sch/save-share-schedule-roster"));

            if (Page.RouteData.Values["sch"] != null)
            {
                schID = (Page.RouteData.Values["sch"] + "").Trim();
            }
            else
            {
                schID = (Request["sch"] + "").Trim();
            }
            if (schID == "")
                schID = "0";

            divHiddenValues.InnerHtml = "<span id='spnShrRoster' style='display: none;'>" + schID + "</span> &nbsp;";

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

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_SHARE_ROSTER) == false && 
                    new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_SHARE_ROSTER) == false)
            {
                Response.Redirect(path + "ErrorPages/error-403.aspx", true);
            }
            else
            {
                //if (Numerics.GetDecimal(schID) < 0)
                //    Response.Redirect(path + "ErrorPages/error-403.aspx", true);
            }

        }
    }
}