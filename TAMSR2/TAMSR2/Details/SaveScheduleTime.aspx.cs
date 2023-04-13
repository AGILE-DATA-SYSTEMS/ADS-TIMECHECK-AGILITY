using System;
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
    public partial class SaveScheduleTime : BasePage
    {
        public string schID = "0";
        //public string orgID = "1";
        //public string empID = "";
        //public string groupID = "";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("savescheduletime.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/savescheduletime.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("sch/save-schedule-time"));

            if (Page.RouteData.Values["sch"] != null)
            {
                schID = (Page.RouteData.Values["sch"] + "").Trim();
                //orgID = (Page.RouteData.Values["org"] + "").Trim();
                //empID = (Page.RouteData.Values["emp"] + "").Trim();
                //groupID = (Page.RouteData.Values["group"] + "").Trim();
            }
            else
            {
                schID = (Request["sch"] + "").Trim();
                //orgID = (Request["org"] + "").Trim();
                //empID = (Request["emp"] + "").Trim();
                //groupID = (Request["group"] + "").Trim();
            }
            if (schID.Trim() == "")
                schID = "0";

            divHiddenValues.InnerHtml = "<span id='spnSch' style='display: none;'>" + schID + "</span> &nbsp;";

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