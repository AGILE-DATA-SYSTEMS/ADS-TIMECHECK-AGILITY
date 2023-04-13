using System;
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
    public partial class ViewAllApproval : BasePage
    {
        public string orgID = "0";
        public string mgrID = "0";
        public string empID = "0";
        public string typeID = "";
        protected void Page_Load(object sender, EventArgs e)
        { 

            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewallapproval.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/viewallapproval.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("approval/pending-approval"));
            

                if (Page.RouteData.Values["org"] + "" != "0")
                {
                    orgID = (Page.RouteData.Values["org"] + "").Trim();
                }
                else
                {
                    orgID = "";
                }

             
            if (Page.RouteData.Values["mgr"] + "" != "0")
            {
                mgrID = (Page.RouteData.Values["mgr"] + "").Trim();
            }
            else
            {
                mgrID = "";
            }

            if (Page.RouteData.Values["emp"] + "" != "0")
            {
                empID = (Page.RouteData.Values["emp"] + "").Trim();
            }
            else
            {
                empID = "";
            }

            if (Page.RouteData.Values["typ"] + "" != "")
            {
                typeID = (Page.RouteData.Values["typ"] + "").Trim();
            }
            else
            {
                typeID = "";
            } 

            divHiddenValues.InnerHtml = "<span id='spnOrg' style='display: none;'>" + orgID + "</span> &nbsp;";
            divHiddenValues.InnerHtml += "<span id='spnMgr' style='display: none;'>" + mgrID + "</span> &nbsp;";
            divHiddenValues.InnerHtml += "<span id='spnEmp' style='display: none;'>" + empID + "</span> &nbsp;";
            divHiddenValues.InnerHtml += "<span id='spnType' style='display: none;'>" + typeID + "</span> &nbsp;";
            
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

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_PENDING_APPROVAL) == false)
            {
                Response.Redirect((Request.UrlReferrer != null) ? Request.UrlReferrer.AbsoluteUri + "" : Page.ResolveClientUrl("~/Common/Home"));
            }
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_PENDING_APPROVAL) == false)
            {
                spnApproveButton.Visible = false;
            }
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_PENDING_APPROVAL) == false)
            {
                spnRejectButton.Visible = false;
            }
        }
    }
}