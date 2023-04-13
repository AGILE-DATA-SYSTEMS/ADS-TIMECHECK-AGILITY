using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Management;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using TAMSR2.ObjectClasses;
namespace TAMSR2
{
    public partial class ApplyLicense : System.Web.UI.Page
    {
        public string url = "";
        public string path = "";
        public string languageStr = "en";
        public string MachineID = "en";
        public string pullDirectionStr = "right";
        public string username = "";
        public string password = "";
        public string companyID = "";
        public string companyCode = "";
        public bool remember = false;
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
                new ExceptionLog().WriteLog("Login.aspx.SetCultureValues()", 0, ex);
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
            Request.Cookies.Add(cookie);
            Response.Cookies.Add(cookie);
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {


            //if (TAMSR2Licence.ValidateLicense())
            //{
                url = Request.Url.AbsoluteUri;
                if (url.ToLower().Contains("applylicense.aspx"))
                    path = url.Substring(0, url.ToLower().IndexOf("applylicense.aspx"));
                else
                    path = url.Substring(0, url.ToLower().IndexOf("license/applylicense"));
                MachineID = TAMSR2.ObjectClasses.TAMSR2Licence.CPUID();
                //if (Page.RouteData.Values["code"] != null)
                //{
                //    companyCode = (Page.RouteData.Values["code"] + "").Trim().ToLower();
                //}
                //else
                //{
                //    companyCode = (Request["code"] + "").Trim().ToLower();
                //}

                //SetCultureValues();
                ////string prvURL = "";
                //HttpCookie cookie = Request.Cookies["TAMSR2"];
                ////companyCode = "";
                //if (cookie != null && companyCode == "")
                //{
                //    companyCode = Encryption.Decrypt_AES(cookie.Values["companyCode"] + "").Trim();
                //    if (companyCode != "")
                //        Response.Redirect("Login/" + companyCode);
                //}
                //if (cookie != null)
                //{
                //    username = Encryption.Decrypt_AES(cookie.Values["username"] + "");
                //    password = Encryption.Decrypt_AES(cookie.Values["password"] + "");
                //    companyID = Encryption.Decrypt_AES(cookie.Values["companyID"] + "");
                //    remember = Numerics.GetBool(cookie.Values["remember"] + "");
                //}
            //}
            //else
            //{
            //    Response.Write("License expired ! Contact your vendor.");
            //    Response.End();
            //}
        }
    }
}