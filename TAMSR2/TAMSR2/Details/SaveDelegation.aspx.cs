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
    public partial class SaveDelegation : BasePage
    {
        public string dlgID = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("savedelegation.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/savedelegation.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("emp/save-employee-delegate"));

            if (Page.RouteData.Values["dlg"] != null)
            {
                dlgID = (Page.RouteData.Values["dlg"] + "").Trim();
            }
            else
            {
                dlgID = (Request["dlg"] + "").Trim();
            }
            if (dlgID == "")
                dlgID = "0";

            divHiddenValues.InnerHtml = "<span id='spnDlg' style='display: none;'>" + dlgID + "</span> &nbsp;";


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

            //if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_DELEGATE) == false)
            //{
            //    //spnDeleteButton.Visible = false;
            //}
            //if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_DELEGATE) == false)
            //{
            //    //spnAddButton.Visible = false;
            //}
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_DELEGATE) == false
                && (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_DELEGATE) == false 
                        && dlgID != "" && dlgID != "0" && dlgID != "MA=="
                    )
                )
            {
                Response.Redirect(Request.UrlReferrer.AbsoluteUri, true);
                //spnAddButton.Visible = false;
            }
        }
    }
}