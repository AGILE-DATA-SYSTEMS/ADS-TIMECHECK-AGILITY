using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.CustomControls
{
    public partial class Header : System.Web.UI.UserControl
    {
        public static string url2 = "";
        public static string languageStr = "en";
        public static string pullDirectionStr = "right";
        public static bool IsWindowsLogin = false;
        public static bool IsActiveDirectoryLogin = false;
        public bool IsMultiLang = false;
        public static int LicenseLeftDays = 0;

        /// <summary>
        /// Set page culture values according to user selection
        /// </summary>
        #region
        public void SetCultureValues()
        {
            HttpCookie cookie = Request.Cookies["tamsCulture"];
            try
            {
                if (cookie == null)
                {
                    cookie = new HttpCookie("tamsCulture");
                    cookie.Values.Add("pullDirection", AppSetting.defaultPullDirection + "");
                    cookie.Values.Add("language", AppSetting.defaultLanguage + "");
                    cookie.Values.Add("culture", AppSetting.defaultCulture + "");
                    cookie.Values.Add("timeZone", AppSetting.defaultTimeZone + "");
                    cookie.Values.Add("dateFormat", AppSetting.dateFormat + "");
                    cookie.Values.Add("dateTimeFormat", AppSetting.dateTimeFormat + "");
                    DateTime dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(7);
                    cookie.Expires = dt;
                    Response.Cookies.Add(cookie);
                }
                pullDirectionStr = cookie.Values["pullDirection"] + "";
                languageStr = cookie.Values["language"] + "";
                Page.UICulture = cookie.Values["culture"] + "";
                Page.Culture = cookie.Values["culture"] + "";


            }
            catch (Exception ex)
            {
                pullDirectionStr = AppSetting.defaultPullDirection + "";
                languageStr = AppSetting.defaultLanguage + "";
                Page.UICulture = AppSetting.defaultCulture + "";
                Page.Culture = AppSetting.defaultCulture + "";
                new ExceptionLog().WriteLog("CustomControls/Header.asax.SetCultureValues()", 0, ex);
            }
            if (languageStr == "en")
            {
                pullDirectionStr = "right";
                Session["changeLanguage"] = (String)GetGlobalResourceObject("Resource", "changeLanguage");
            }
            else
            {
                pullDirectionStr = "left";
                Session["changeLanguage"] = (String)GetGlobalResourceObject("Resource", "changeLanguage");
            }



        }
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            SetCultureValues();
            SetHeaderValue(); 
            
            string LicenseValidDays = new TAMSR2Licence().GetLicenseRemainigDays();
            if (Convert.ToInt32(LicenseValidDays + "") > 0)
                LicenseLeftDays = Convert.ToInt32(LicenseValidDays + "");
            else
                LicenseLeftDays = 0;
        }


        #region SetHeaderValue

        void SetHeaderValue()
        {
            IsMultiLang = false;
            TAMSR2.ObjectClasses.DBAppSetting objApp = new TAMSR2.ObjectClasses.DBAppSetting();
            TAMSR2Data objDALApp = new TAMSR2Data();
            DataView dvApp = new DataView();
            string windowsLogin = string.Empty;
            string ActiveDirectoryLogin = string.Empty;
            string MultipLang = string.Empty;
            try
            {
                windowsLogin = (ConfigurationManager.AppSettings["ADLogin"] + "").ToLower();
                ActiveDirectoryLogin = (ConfigurationManager.AppSettings["ActieDirectoryFormLogin"] + "").ToLower();
                objDALApp.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                Hashtable htApp = new Hashtable();
                htApp.Add("action", "getByName");
                htApp.Add("sessionID", Session["ID"] + "");
                htApp.Add("vname", "ENABLE_MULTI_LANGUAGE" + "");
                dvApp = objDALApp.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", htApp);

                if (dvApp != null)
                {
                    objApp.Value = dvApp[0]["value"] + "" == "" ? "No" : dvApp[0]["value"] + "";
                }

                MultipLang = objApp.Value.ToLower();
                if (!string.IsNullOrEmpty(windowsLogin) && windowsLogin == "1")
                    IsWindowsLogin = true;
                if (!string.IsNullOrEmpty(ActiveDirectoryLogin) && ActiveDirectoryLogin == "true")
                    IsActiveDirectoryLogin = true;
                if (!string.IsNullOrEmpty(MultipLang) && MultipLang == "true")
                    IsMultiLang = true;
            }
            catch (Exception ex)
            { new ExceptionLog().WriteLog("Header.ascx.cs", 0, ex); }
            finally
            {

                objDALApp.CloseConnection();

            }

        }


        #endregion


    }
}