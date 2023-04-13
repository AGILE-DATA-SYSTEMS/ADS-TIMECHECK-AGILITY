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
    public partial class SavePermissionTypes : BasePage
    {
        public string perm = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("savepermissiontypes.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("common/savepermissiontypes.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("common/save-permission-types"));

            if (Page.RouteData.Values["perm"] != null)
            {
                perm = Encryption.Decrypt( (Page.RouteData.Values["perm"] + "").Trim());
            }
            else
            {
                perm = Encryption.Decrypt((Request["perm"] + "").Trim());
            }
            if (perm == "")
                perm = "0";

            divHiddenValues.InnerHtml = "<span id='spnPerm' style='display: none;'>" + perm + "</span> &nbsp;";

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

            //if (Numerics.GetBool(Session["CanAdd"]) == false)
            //    spnAddButton.Visible = false;
        }
    }
}