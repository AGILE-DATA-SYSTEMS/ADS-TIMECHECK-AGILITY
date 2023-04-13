using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Reports
{
    public partial class ViewSAPHCM : BasePage
    {
        public string noOfDays = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewsaphcm.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/viewsaphcm.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("reports/sap-hcm-extract"));

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
            getNumberOfDaysSetting();
        }

        public void getNumberOfDaysSetting()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

            Hashtable ht = new Hashtable();
            ht.Add("action", "getByName");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("vname", "CONSIDER_ABSENT_AFTER_DAYS");
            noOfDays = objDAL.Connection.GetValueProcedure("TAMSR2_AppSettingOps", ht);
        }

    }
}