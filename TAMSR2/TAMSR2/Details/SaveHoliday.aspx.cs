﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Details
{
    public partial class SaveHoliday : BasePage
    {
        public string hdyID = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("saveholiday.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/saveholiday.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("common/save-holiday"));

            if (Page.RouteData.Values["hdy"] != null)
            {
                hdyID = (Page.RouteData.Values["hdy"] + "").Trim();
            }
            else
            {
                hdyID = (Request["hdy"] + "").Trim();
            }
            if (hdyID == "")
                hdyID = "0";

            divHiddenValues.InnerHtml = "<span id='spnHdy' style='display: none;'>" + hdyID + "</span> &nbsp;";

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