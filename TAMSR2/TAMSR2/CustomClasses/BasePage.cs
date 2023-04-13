using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.CustomClasses
{
    public class BasePage : System.Web.UI.Page
    {
        public string url = "";
        public string path = "";
        public string languageStr = "en";
        public string pullDirectionStr = "right";
        public string floatStr = "left";

        /// <summary>
        /// Set page culture values according to user selection
        /// </summary>
        #region SetCultureValues()
        public void SetCultureValues()
        {
            HttpCookie cookie = Request.Cookies["tamsCulture"];
            try
            {
                EmployeePreference obj = new EmployeePreference().GetEmployeePreference(Session["ID"] + "", Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + "");
                Session["sidebar"] = obj.Sidebar;
                Session["theme"] = obj.Theme;
                //if (cookie == null)
                //{
                //    cookie = new HttpCookie("tamsCulture");
                //}
                cookie = new HttpCookie("tamsCulture");
                if (obj != null && obj.ID > 0)
                {
                    if (obj.Language.Trim().ToLower() == "ar")
                    {
                        cookie.Values.Add("pullDirection", "left");
                        cookie.Values.Add("language", "ar");
                        cookie.Values.Add("culture", "ar-AE");
                    }
                    if (obj.Language.Trim().ToLower() == "en")
                    {
                        cookie.Values.Add("pullDirection", "right");
                        cookie.Values.Add("language", "en");
                        cookie.Values.Add("culture", "en-US");
                    }
                    cookie.Values.Add("pageSize", obj.PageSize + "");
                }
                else
                {
                    cookie.Values.Add("pullDirection", AppSetting.defaultPullDirection + "");
                    cookie.Values.Add("language", AppSetting.defaultLanguage + "");
                    cookie.Values.Add("culture", AppSetting.defaultCulture + "");
                    cookie.Values.Add("pageSize", "10");
                }
                cookie.Values.Add("timeZone", AppSetting.defaultTimeZone + "");
                cookie.Values.Add("dateFormat", AppSetting.dateFormat + "");
                cookie.Values.Add("dateTimeFormat", AppSetting.dateTimeFormat + "");
                DateTime dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(7);
                cookie.Expires = dt;
                Response.Cookies.Add(cookie);
                pullDirectionStr = cookie.Values["pullDirection"] + "";
                languageStr = cookie.Values["language"] + "";
                Page.UICulture = cookie.Values["culture"] + "";
                Page.Culture = cookie.Values["culture"] + "";

                if (Session["ID"] + "" != "")
                {
                    if (obj.Language.Trim().ToLower() == "ar")
                        Session["companyName"] = Session["companyNameAr"] + "";
                    else
                        Session["companyName"] = Session["companyNameEn"] + "";
                }
            }
            catch (Exception ex)
            {
                pullDirectionStr = AppSetting.defaultPullDirection + "";
                languageStr = AppSetting.defaultLanguage + "";
                Page.UICulture = AppSetting.defaultCulture + "";
                Page.Culture = AppSetting.defaultCulture + "";

                if (Session["ID"] + "" != "")
                {
                    if (languageStr.Trim().ToLower() == "ar")
                        Session["companyName"] = Session["companyNameAr"] + "";
                    else
                        Session["companyName"] = Session["companyNameEn"] + "";
                }
                new ExceptionLog().WriteLog(url + ".SetCultureValues()", 0, ex);
            }
            if (pullDirectionStr == "left")
                floatStr = "right";
            else
                floatStr = "left";
            
        }
        #endregion


        public bool UserAuthentication()
        {
            //if (!License.CheckAppValidation())
            //{
            //    Response.Write("License expired ! Contact your vendor.");
            //    Response.End();
            //    return false;
            //}
            if (!TAMSR2Licence.ValidateLicense())  //if (!License.CheckAppValidation())
            {

             //   Response.Write("License expired ! Contact your vendor.");
                Response.Redirect(Page.ResolveClientUrl("~/License/ApplyLicense"));
               // Response.End();
                return false;
            }
            bool chk = false;
            if (ConfigurationManager.AppSettings["ADLogin"] + "" != "1" && Session["ID"] + "" == "")
            {
                return false;
            }
            else if (ConfigurationManager.AppSettings["ADLogin"] + "" == "1" && Session["ID"] + "" != "")
            {
                return true;
            }
            else if (ConfigurationManager.AppSettings["ADLogin"] + "" != "1" && Session["ID"] + "" != "")
            {
                return true;
            }
            string DomainRegUSerName = Request.LogonUserIdentity.Name + "";
            string RegUSerName = Request.LogonUserIdentity.Name + "";
            string UserName = RegUSerName.Substring(RegUSerName.IndexOf(@"\", 1));
            RegUSerName = UserName.Replace(UserName.Substring(0, 1), "");

            System.Security.Principal.IPrincipal user;

            user = System.Web.HttpContext.Current.User;

            System.Security.Principal.IIdentity identity;

            identity = user.Identity;


            new ExceptionLog().WriteLog(DomainRegUSerName, 0, new System.Exception());
            new ExceptionLog().WriteLog(RegUSerName, 0, new System.Exception());
            new ExceptionLog().WriteLog(UserName, 0, new System.Exception());

            new ExceptionLog().WriteLog("Identity.Name=" + System.Web.HttpContext.Current.User.Identity.Name + "", 0, new System.Exception());
            new ExceptionLog().WriteLog("MachineName=" + System.Environment.MachineName + "", 0, new System.Exception());
            new ExceptionLog().WriteLog("MachineName=" + System.Environment.MachineName + "", 0, new System.Exception());
            new ExceptionLog().WriteLog("OSVersion=" + System.Environment.OSVersion + "", 0, new System.Exception());
            new ExceptionLog().WriteLog("UserName=" + System.Environment.UserName + "", 0, new System.Exception());
            new ExceptionLog().WriteLog("UserDomainName=" + System.Environment.UserDomainName + "", 0, new System.Exception());
            new ExceptionLog().WriteLog("DomainRegUSerName=" + DomainRegUSerName, 0, new System.Exception());
            //new ExceptionLog().WriteLog("DomainRegUSerName=" + DomainRegUSerName, 0, new System.Exception());
            //if (!DomainRegUSerName.Contains(ConfigurationManager.AppSettings["ADPath"] + "\\"))
            //    return false;
            Hashtable ht = new Hashtable();
            ht.Add("action", "windowLogin");
            ht.Add("username", RegUSerName);
            //ht.Add("companyID", (Request["companyID"] + "").Trim());
            decimal companyID = Numerics.GetDecimal(ConfigurationManager.AppSettings["ADComp"]);
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                //if (new LdapAuthentication(ConfigurationManager.AppSettings["ADPath"]).IsAuthenticated(DomainRegUSerName, RegUSerName, "") == false)
                //    return chk;
                TAMSR2Company cmpObj = new TAMSR2Company(companyID);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(cmpObj.DbType, cmpObj.DbName, cmpObj.DbUser, cmpObj.DbPassword));
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);//TAMSR2_OrgTypeOps

                //TAMSUser obj = new UserData().objConnection.GetByUserNamePassword(Request["userName"] + "", Request["password"] + "");
                if (objDataView != null)
                {
                    DataRow rw = objDataView[0].Row;
                    chk = true;
                    Session["companyNameEn"] = cmpObj.NameEn;
                    Session["companyNameAr"] = cmpObj.NameAr;
                    Session["ID"] = Numerics.GetDecimal(rw["employee_id"]);
                    Session["userID"] = Numerics.GetDecimal(rw["user_id"]);
                    Session["Username"] = (rw["login"] + "").Trim();
                    Session["orgID"] = (rw["organization_id"] + "").Trim();
                    Session["rptOrgDrillDown"] = (rw["rptOrgDrillDown"] + "").ToUpper().Trim();
                    Session["companyID"] = Request["companyID"] + "";
                //    Session["SystemDateFormat"] = rw["SystemDateFormat"] + "";
                    Session["dbType"] = cmpObj.DbType;
                    Session["dbName"] = cmpObj.DbName;
                    Session["dbUser"] = cmpObj.DbUser;
                    Session["dbPassword"] = cmpObj.DbPassword;
                    Session["chkPrivileges"] = false;
                    if (Numerics.GetBool(Request["remember"] + "") == true)
                    {
                        HttpCookie cookie = Request.Cookies["TAMSR2"];
                        if (cookie == null)
                        {
                            cookie = new HttpCookie("TAMSR2");
                        }
                        cookie.Values["username"] = Encryption.Encrypt_AES(RegUSerName + "");
                        cookie.Values["password"] = (rw["password"] + "").Trim();
                        cookie.Values["companyID"] = Encryption.Encrypt_AES(Request["companyID"] + "");
                        cookie.Values["remember"] = Request["remember"] + "";
                        cookie.Expires = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(7);
                        Response.Cookies.Add(cookie);
                        Request.Cookies.Add(cookie);
                    }
                    else
                    {
                        HttpCookie cookie = Request.Cookies["TAMSR2"];
                        if (cookie == null)
                        {
                            cookie = new HttpCookie("TAMSR2");
                        }
                        cookie.Expires = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(-7);
                        Response.Cookies.Add(cookie);
                        Request.Cookies.Add(cookie);
                    }
                    LoadUserPrivileges();
                }
                else
                {
                    chk = false;
                }
            }
            catch (Exception ex)
            {
                chk = false;

                Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(ex));
                new ExceptionLog().WriteLog("RequestPages/Default.aspx.CompanyLogin()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Login Function*********//

        #region LoadUserPrivileges
        /// <summary>
        /// LoadUserPrivileges function
        /// </summary>
        void LoadUserPrivileges()
        {
            StringBuilder sb = new StringBuilder();
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                sb.Append("");
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                Hashtable ht = new Hashtable();
                ht.Add("action", "getAllPrivilegesByUser");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);

                foreach (DataRowView obj in dv)
                {
                    sb.Append(Numerics.GetDecimal(obj["privilege_id"] + "") + ",");
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/BasePage.aspx.LoadUserPrivileges()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            if (sb.ToString() != "")
                Session["privileges"] = sb.ToString();
            else
                Session["privileges"] = "";
        }
        //*********End Of LoadUserPrivileges Function*********//
        #endregion

    }
}