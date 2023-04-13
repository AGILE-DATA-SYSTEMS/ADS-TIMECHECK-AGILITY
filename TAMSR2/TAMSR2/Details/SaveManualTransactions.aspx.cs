using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;

namespace TAMSR2.Details
{
    public partial class SaveManualTransactions : BasePage
    {
        public string tid = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("savemanualtransactions.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/savemanualtransactions.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("events/save-manual-movement"));

            if (Page.RouteData.Values["tid"] != null)
            {
                tid = (Page.RouteData.Values["tid"] + "").Trim();
            }
            else
            {
                tid = (Request["tid"] + "").Trim();
            }
            if (tid == "")
                tid = "0";

            divHiddenValues.InnerHtml = "<span id='spnTid' style='display: none;'>" + tid + "</span> &nbsp;";

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

            
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.ALLOW_TRANSACTION_TIME_EMP_MANUAL_MOVEMENT) == false)
            {
                spnTransactionTime.Visible = false;
            }
            //if (Numerics.GetBool(Session["CanAdd"]) == false)
            //    spnAddButton.Visible = false;
        }
    }
}