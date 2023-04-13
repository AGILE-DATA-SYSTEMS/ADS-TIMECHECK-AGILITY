using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;

namespace TAMSR2.EmployeeScheduleWorkFlow
{
    public partial class ApplyEmployeeSchedule : BasePage
    {
        public string schID = "0";
        public string orgID = "1";
        public string empID = "";
        public string groupID = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("applyemployeeschedule.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("employeescheduleworkflow/applyemployeeschedule.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("sch/apply-employee-schedules"));

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