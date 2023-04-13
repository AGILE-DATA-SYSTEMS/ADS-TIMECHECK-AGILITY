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
    public partial class ViewOrganizationSummary : BasePage
    {
        public string hdyID = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("vieworganizationsummary.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/vieworganizationsummary.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("common/organizationstructure"));
            try
            {
                if (Session["ID"] + "" != "")
                {
                    OrgNode obj = new OrgNode();
                    //divGraph.InnerHtml = obj.GetGraphString(Session["ID"] + "");
                }
            }
            catch (Exception ex)
            {
            }
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