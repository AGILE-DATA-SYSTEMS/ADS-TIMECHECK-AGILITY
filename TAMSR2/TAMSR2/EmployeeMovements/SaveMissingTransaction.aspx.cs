using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.EmployeeMovements
{
    public partial class SaveMissingTransaction : BasePage
    {
        public string transID = "";
        public string emp = "";
        public string mode = "";
        public string transDate = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("savemissingtransaction.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("employeemovements/savemissingtransaction.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("events/save-missing-transaction"));

            if (Page.RouteData.Values["tid"] != null)
            {
                transID = (Page.RouteData.Values["tid"] + "").Trim();
                emp = (Page.RouteData.Values["emp"] + "").Trim();
                mode = (Page.RouteData.Values["mode"] + "").Trim();
                transDate = (Page.RouteData.Values["transDate"] + "").Trim();
            }
            else
            {
                transID = (Request["tid"] + "").Trim();
                emp = (Request["emp"] + "").Trim();
                mode = (Request["mode"] + "").Trim();
                transDate = (Request["transDate"] + "").Trim();
            }
            if (transID == "")
                transID = "0";
            divHiddenValues.InnerHtml = "<span id='spnTrans' style='display: none;'>" + transID + "</span> &nbsp;";

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