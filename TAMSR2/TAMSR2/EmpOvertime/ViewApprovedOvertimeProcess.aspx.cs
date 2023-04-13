using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;

namespace TAMSR2.EmpOvertime
{
    public partial class ViewApprovedOvertimeProcess : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewapprovedovertimeprocess.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("empovertime/viewapprovedovertimeprocess.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("emp/employee-approve-overtime-process"));

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


            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.APPROVED_OVERTIME_PROCESS) == false)
            {
                Response.Redirect((Request.UrlReferrer != null) ? Request.UrlReferrer.AbsoluteUri + "" : Page.ResolveClientUrl("~/Common/Home"));
            }
            //if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.APPROVE_OVERTIME) == false)
            //{
            //    spnApproveButton.Visible = false;
            //}
            //if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.APPROVE_OVERTIME) == false)
            //{
            //    spnRejectButton.Visible = false;
            //}

        }
    }
}