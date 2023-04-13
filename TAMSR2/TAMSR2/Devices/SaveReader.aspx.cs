using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;



namespace TAMSR2.Devices
{
    public partial class SaveReader : BasePage
    {
        public string rdrID = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("saveholiday.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/saveholiday.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("common/save-holiday"));

            if (Page.RouteData.Values["rdr"] != null)
            {
                rdrID = (Page.RouteData.Values["rdr"] + "").Trim();
            }
            else
            {
                rdrID = (Request["rdr"] + "").Trim();
            }
            if (rdrID == "")
                rdrID = "0";

            divHiddenValues.InnerHtml = "<span id='spnRdr' style='display: none;'>" + rdrID + "</span> &nbsp;";

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