using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.RequestPages
{
    public partial class UserPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        HttpCookie cookie;
        string ActiveDirectoryLogin = string.Empty;
        bool isActiveDirectoryLogin = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/UserPage.aspx"));
            // Added By Wajahat For Ad Login

            ActiveDirectoryLogin = ConfigurationManager.AppSettings["ActiveDirectoryFormLogin"] + "";
            Boolean.TryParse(ActiveDirectoryLogin, out isActiveDirectoryLogin);

            //End
            cookie = Request.Cookies["tamsCulture"];
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

            Page.UICulture = cookie.Values["culture"] + "";
            Page.Culture = cookie.Values["culture"] + "";



            string data = "";

            if (Session["ID"] + "" == "" && Request["key"] + "" != "login")
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "login")
            {
                if (Request.UrlReferrer.AbsoluteUri.ToLower().Contains("admin/adminlogin.aspx"))
                {
                    data = Login();
                }
                else if (isActiveDirectoryLogin)
                {

                    data = LoginFromActiveDirectory();
                }

                else
                {
                    data = CompanyLoginByCode();
                }
            }
            else if (Request["key"] + "" == "changePassword")
            {
                data = ChangePassword();
            }
            else if (Request["key"] + "" == "save")
            {
                data = Save();
            }
            else if (Request["key"] + "" == "getAll")
            {
                data = GetAll();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByID();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if (Request["key"] + "" == "getAllLogs")
            {
                data = GetAllUserLogs();
            }
            else
            {
                data = "";
            }

            if (Request["key"] + "" != "login")
            {
                Response.Clear();
                Response.ClearHeaders();
                Response.ClearContent();
            }
            Response.Write(data);
            Response.Flush();
            //Response.End();

        }

        private string LoginFromActiveDirectory()
        {
            string chk = "0";
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                //string DomainRegUSerName = Request.LogonUserIdentity.Name + "";
                //string RegUSerName = Request.LogonUserIdentity.Name + "";
                //string UserName = RegUSerName.Substring(RegUSerName.IndexOf(@"\", 1));
                //RegUSerName = UserName.Replace(UserName.Substring(0, 1), "");

                //System.Security.Principal.IPrincipal user;

                //user = System.Web.HttpContext.Current.User;

                //System.Security.Principal.IIdentity identity;

                //identity = user.Identity;
                var employeeID = 0;
                var employeeCode = "";
                var employeeNameEng = "";
                var employeeNameArb = "";

                string PathToAD = ConfigurationManager.AppSettings["ADPath"];
                if (!string.IsNullOrEmpty(PathToAD))
                    PathToAD = "LDAP://" + PathToAD;

                LdapAuthentication ldap = new LdapAuthentication(PathToAD);
                string Domain = ConfigurationManager.AppSettings["ADPath"];
                string AdUser = (Request["userName"] + "").Trim();
                string ADPass = Encryption.Decrypt_AES((Request["password"] + "").Trim());
                if (ldap.IsAuthenticated(Domain, AdUser, ADPass))
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("action", "windowLogin");
                    ht.Add("username", AdUser);
                    string companyCode = (Request["companyCode"] + "").Trim() != "" ? (Request["companyCode"] + "").Trim() : ConfigurationManager.AppSettings["ADCompString"] + "";
                    decimal companyID = Numerics.GetDecimal(ConfigurationManager.AppSettings["ADComp"]);


                    TAMSR2Company cmpObj = new TAMSR2Company(companyCode);

                    objDAL.OpenConnection(Connection.GetConnectionStrinng(cmpObj.DbType, cmpObj.DbName, cmpObj.DbUser, cmpObj.DbPassword));
                    DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);
                    if (objDataView != null && objDataView.Count > 0)
                    {
                        DataRow rw = objDataView[0].Row;
                        chk = "1";
                        Session["companyCode"] = cmpObj.Code;
                        Session["companyNameEn"] = cmpObj.NameEn;
                        Session["companyNameAr"] = cmpObj.NameAr;

                        employeeID = Numerics.GetInt(rw["user_id"]);
                        employeeNameEng = cmpObj.NameEn;
                        employeeCode = (rw["login"] + "").Trim();
                        employeeNameArb = cmpObj.NameAr;

                        Session["ID"] = Numerics.GetDecimal(rw["employee_id"]);
                        Session["userID"] = Numerics.GetDecimal(rw["user_id"]);
                        Session["Username"] = (rw["login"] + "").Trim();
                        Session["UserRoles"] = (rw["RoleNames"] + "").Trim();
                        Session["orgID"] = (rw["organization_id"] + "").Trim();
                        Session["rptOrgDrillDown"] = (rw["rptOrgDrillDown"] + "").ToUpper().Trim();
                        Session["companyID"] = Request["companyID"] + "";
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
                            cookie.Values["username"] = Encryption.Encrypt_AES(Request["Username"] + "");
                            cookie.Values["password"] = Encryption.Encrypt_AES(Request["password"] + "");
                            cookie.Values["companyID"] = Encryption.Encrypt_AES(Request["companyID"] + "");
                            cookie.Values["companyCode"] = Encryption.Encrypt_AES(Session["companyCode"] + "");
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
                        UserLoginLogSave(employeeID.ToString(), employeeCode, employeeNameEng, employeeNameArb);
                        LoadUserPrivileges();
                    }
                    else
                    {
                        chk = "0";
                    }

                }
            }
            catch (Exception ex)
            {
                chk = "0";
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.cs.LoginFromActiveDirectory", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }


        #region Login
        /// <summary>
        /// Login function
        /// Get username and password from request 
        /// and validate this user from database using data access layer
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of not exists/matched and -1 in case of inactive</returns>

        public string Login()
        {
            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "login");
            ht.Add("username", (Request["userName"] + "").Trim());
            ht.Add("password", Encryption.Encrypt_AES((Request["password"] + "").Trim()));
            //ht.Add("companyID", (Request["companyID"] + "").Trim());
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection();
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_UserOps", ht);//TAMSR2_CompanyUserOps

                //TAMSUser obj = new UserData().objConnection.GetByUserNamePassword(Request["userName"] + "", Request["password"] + "");
                if (objDataView != null)
                {
                    DataRow rw = objDataView[0].Row;
                    if (Numerics.GetBool(rw["IsActive"]) == false)
                    {
                        chk = "-1";
                    }
                    else
                    {
                        chk = "1";
                        Session["ID"] = Numerics.GetDecimal(rw["ID"]);
                        Session["companyID"] = Numerics.GetDecimal(rw["CompanyID"]);
                        Session["Username"] = (rw["Username"] + "").Trim();
                        Session["CanView"] = Numerics.GetBool(rw["CanView"] + "");
                        Session["CanAdd"] = Numerics.GetBool(rw["CanAdd"] + "");
                        Session["CanUpdate"] = Numerics.GetBool(rw["CanUpdate"] + "");
                        Session["CanDelete"] = Numerics.GetBool(rw["CanDelete"] + "");
                        Session["IsActive"] = Numerics.GetBool(rw["IsActive"]);
                        Session["RootUser"] = true;
                        if (Numerics.GetBool(Request["remember"] + "") == true)
                        {
                            HttpCookie cookie = Request.Cookies["TAMSR2"];
                            if (cookie == null)
                            {
                                cookie = new HttpCookie("TAMSR2");
                            }
                            cookie.Values["username"] = Encryption.Encrypt_AES(Request["Username"] + "");
                            cookie.Values["password"] = Encryption.Encrypt_AES(Request["password"] + "");
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
                    }
                }
                else
                {
                    chk = "0";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.Login()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Login Function*********//
        #endregion




        #region CompanyLogin
        /// <summary>
        /// Login function
        /// Get username and password from request 
        /// and validate this user from database using data access layer
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of not exists/matched and -1 in case of inactive</returns>

        public string CompanyLogin()
        {
            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "login");
            ht.Add("username", (Request["userName"] + "").Trim());
            ht.Add("password", Encryption.Encrypt_AES((Request["password"] + "").Trim()));
            //ht.Add("companyID", (Request["companyID"] + "").Trim());
            decimal companyID = Numerics.GetDecimal(Request["companyID"] + "");
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                TAMSR2Company cmpObj = new TAMSR2Company(companyID);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(cmpObj.DbType, cmpObj.DbName, cmpObj.DbUser, cmpObj.DbPassword));
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);//TAMSR2_OrgTypeOps

                //TAMSUser obj = new UserData().objConnection.GetByUserNamePassword(Request["userName"] + "", Request["password"] + "");
                if (objDataView != null)
                {
                    DataRow rw = objDataView[0].Row;
                    chk = "1";
                    Session["companyNameEn"] = cmpObj.NameEn;
                    Session["companyNameAr"] = cmpObj.NameAr;
                    Session["ID"] = Numerics.GetDecimal(rw["employee_id"]);
                    Session["userID"] = Numerics.GetDecimal(rw["user_id"]);
                    Session["Username"] = (rw["login"] + "").Trim();
                    Session["UserPassword"] = (rw["password"] + "").Trim();
                    Session["OrganizationNameArb"] = cmpObj.NameAr;
                    Session["OrganizationNameEng"] = cmpObj.NameEn;
                    Session["EmployeeNameEng"] = (rw["name_eng"] + "").Trim();
                    Session["EmployeeNameArb"] = (rw["name_arb"] + "").Trim();
                    Session["orgID"] = (rw["organization_id"] + "").Trim();
                    Session["rptOrgDrillDown"] = (rw["rptOrgDrillDown"] + "").ToUpper().Trim();
                    Session["companyID"] = Request["companyID"] + "";
                    Session["dbType"] = cmpObj.DbType;
                    Session["dbName"] = cmpObj.DbName;
                    Session["dbUser"] = cmpObj.DbUser;
                    Session["dbPassword"] = cmpObj.DbPassword;
                    Session["chkPrivileges"] = false;
                    Session["UserRoles"] = (rw["RoleNames"] + "").Trim();
                    if (Numerics.GetBool(Request["remember"] + "") == true)
                    {
                        HttpCookie cookie = Request.Cookies["TAMSR2"];
                        if (cookie == null)
                        {
                            cookie = new HttpCookie("TAMSR2");
                        }
                        cookie.Values["username"] = Encryption.Encrypt_AES(Request["Username"] + "");
                        cookie.Values["password"] = Encryption.Encrypt_AES(Request["password"] + "");
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
                    chk = "0";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.CompanyLogin()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Login Function*********//
        #endregion




        #region CompanyLogin
        /// <summary>
        /// Login function
        /// Get username and password from request 
        /// and validate this user from database using data access layer
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of not exists/matched and -1 in case of inactive</returns>

        public string CompanyLoginByCode()
        {
            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "login");
            ht.Add("username", (Request["userName"] + "").Trim());
            ht.Add("password", Encryption.Encrypt_AES((Request["password"] + "").Trim()));
            //ht.Add("companyID", (Request["companyID"] + "").Trim());
            string companyCode = (ConfigurationManager.AppSettings["CompCode"] + "").Trim() ;
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                TAMSR2Company cmpObj = new TAMSR2Company(companyCode);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(cmpObj.DbType, cmpObj.DbName, cmpObj.DbUser, cmpObj.DbPassword));
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);//TAMSR2_OrgTypeOps
                var employeeID = 0;
                var employeeCode = "";
                var employeeNameEng = "";
                var employeeNameArb = "";
                //TAMSUser obj = new UserData().objConnection.GetByUserNamePassword(Request["userName"] + "", Request["password"] + "");
                if (objDataView != null && objDataView.Count > 0)
                {
                    DataRow rw = objDataView[0].Row;
                    chk = "1";
                    
                    Session["companyCode"] = cmpObj.Code;
                    Session["companyNameEn"] = cmpObj.NameEn;
                    Session["companyNameAr"] = cmpObj.NameAr;
                    employeeID = Numerics.GetInt(rw["employee_id"]);
                    Session["ID"] = Numerics.GetDecimal(rw["employee_id"]);
                    Session["UserRoles"] = (rw["RoleNames"] + "").Trim();
                    Session["userID"] = Numerics.GetDecimal(rw["user_id"]);
                    Session["Username"] = (rw["login"] + "").Trim();
                    Session["UserPassword"] = (rw["password"] + "").Trim();
                    Session["OrganizationNameArb"] = cmpObj.NameAr;
                    Session["OrganizationNameEng"] = cmpObj.NameEn;
                    employeeNameEng = (rw["name_eng"] + "").Trim();
                    employeeCode = (rw["employee_code"] + "").Trim();
                    Session["EmployeeNameEng"] = (rw["name_eng"] + "").Trim();
                    employeeNameArb = (rw["name_arb"] + "").Trim();
                    Session["EmployeeNameArb"] = (rw["name_arb"] + "").Trim();
                    Session["orgID"] = (rw["organization_id"] + "").Trim();
                    Session["rptOrgDrillDown"] = (rw["rptOrgDrillDown"] + "").ToUpper().Trim();
                    Session["companyID"] = Request["companyID"] + "";
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
                        cookie.Values["username"] = Encryption.Encrypt_AES(Request["Username"] + "");
                        cookie.Values["password"] = Encryption.Encrypt_AES(Request["password"] + "");
                        cookie.Values["companyID"] = Encryption.Encrypt_AES(Request["companyID"] + "");
                        cookie.Values["companyCode"] = Encryption.Encrypt_AES(Session["companyCode"] + "");
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

                    UserLoginLogSave(employeeID.ToString(),employeeCode,employeeNameEng,employeeNameArb);
                    LoadUserPrivileges();
                }
                else
                {
                    chk = "0";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.CompanyLogin()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Login Function*********//
        #endregion




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
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.LoadUserPrivileges()", 0, ex);
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



        #region GetByID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            TAMSR2User obj = new TAMSR2User();
            try
            {
                objDAL.OpenConnection();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_UserOps", ht);

                if (dv != null)
                {
                    obj.NameEn = dv[0]["NameEn"] + "";
                    obj.NameAr = dv[0]["NameAr"] + "";
                    obj.Username = dv[0]["Username"] + "";
                    obj.Password = dv[0]["Password"] + "";
                    try
                    {
                        obj.Password = Encryption.Decrypt(obj.Password);
                    }
                    catch (Exception ex)
                    {
                    }

                    obj.Email = dv[0]["Email"] + "";
                    obj.CompanyID = Numerics.GetDecimal(dv[0]["CompanyID"]);
                    obj.CanView = Numerics.GetBool(dv[0]["CanView"]);
                    obj.CanAdd = Numerics.GetBool(dv[0]["CanAdd"]);
                    obj.CanUpdate = Numerics.GetBool(dv[0]["CanUpdate"]);
                    obj.CanDelete = Numerics.GetBool(dv[0]["CanDelete"]);
                    obj.IsActive = Numerics.GetBool(dv[0]["IsActive"]);
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["CreatedOn"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["CreatedBy"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["UpdatedOn"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["UpdatedBy"]);
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(obj);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region DeleteByID
        /// <summary>
        /// DeleteByID function
        /// Delete user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteByID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("action", "deleteByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                objDAL.OpenConnection();
                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_UserOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAll
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAll()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            if (Numerics.GetBool(Session["CanView"]) == false)
            {
                return new JavaScriptSerializer().Serialize(json);
            }
            try
            {
                objDAL.OpenConnection();

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "ID", "Name" + cookie.Values["language"], "Username", "CanView", "CanAdd", "CanUpdate", "CanDelete", "IsActive", "ID" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_UserOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_UserOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["ID"]) + "' />");
                    if (cookie.Values["language"] == "ar")
                    {
                        tempList.Add((obj["NameAr"] + "").Length > 30 ? (obj["NameAr"] + "").Substring(0, 30) + "..." : (obj["NameAr"] + ""));
                    }
                    else
                    {
                        tempList.Add((obj["NameEn"] + "").Length > 30 ? (obj["NameEn"] + "").Substring(0, 30) + "..." : (obj["NameEn"] + ""));
                    }
                    tempList.Add((obj["UserName"] + "").Length > 30 ? (obj["UserName"] + "").Substring(0, 30) + "..." : (obj["UserName"] + ""));

                    if (Numerics.GetBool(obj["CanView"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    if (Numerics.GetBool(obj["CanAdd"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    if (Numerics.GetBool(obj["CanUpdate"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    if (Numerics.GetBool(obj["CanDelete"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    if (Numerics.GetBool(obj["IsActive"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    string tempAction = "";
                    if (Numerics.GetDecimal(obj["ID"]) == Numerics.GetDecimal(Session["ID"]))
                    {
                        if (Numerics.GetBool(Session["CanUpdate"]) == true)
                        {
                            tempList.Add("<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["ID"]) + ");' />  ");
                        }
                        else
                        {
                            tempList.Add("&nbsp;");
                        }
                    }
                    else
                    {
                        tempAction = "";
                        if (Numerics.GetBool(Session["CanUpdate"]) == true)
                        {
                            tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["ID"]) + ");' /> &nbsp; ";
                        }
                        if (Numerics.GetBool(Session["CanDelete"]) == true)
                        {
                            tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='return Delete(" + Numerics.GetDecimal(obj["ID"]) + ");' /> ";
                        }
                        tempList.Add(tempAction);
                    }
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region Save
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string Save()
        {
            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("nameEn", (Request["nameEn"] + "").Trim());
            ht.Add("nameAr", (Request["nameAr"] + "").Trim());
            ht.Add("username", (Request["userName"] + "").Trim());
            ht.Add("password", Encryption.Encrypt((Request["password"] + "").Trim()));

            ht.Add("email", (Request["email"] + "").Trim());
            ht.Add("companyID", (Request["companyID"] + "").Trim());
            ht.Add("canView", (Request["view"] + "").Trim());
            ht.Add("canAdd", (Request["add"] + "").Trim());
            ht.Add("canUpdate", (Request["update"] + "").Trim());
            ht.Add("canDelete", (Request["del"] + "").Trim());

            ht.Add("IsActive", (Request["isActive"] + "").Trim());

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                if (Session["ID"] + "" != "")
                {
                    ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
                    ht.Add("createdBy", Session["ID"] + "");
                    ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
                    ht.Add("updatedBy", Session["ID"] + "");
                }
                objDAL.OpenConnection();
                string result = objDAL.Connection.GetValueProcedure("TAMSR2_UserOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result;
                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region ChangePassword
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string ChangePassword()
        {
            string chk = "0";
            string oldPassword = Encryption.Encrypt_AES((Request["oldPassword"] + "").Trim());
            string newPassword = Encryption.Encrypt_AES((Request["newPassword"] + "").Trim());
            if (Session["UserPassword"] + "" != oldPassword)
            {
                return "-1";
            }
            Hashtable ht = new Hashtable();
            ht.Add("action", "changePassword");
            ht.Add("sessionID", (Session["id"] + "").Trim());
            ht.Add("password", newPassword);

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_SecUserOps", ht);
                if (Numerics.GetDecimal(result) > 0)
                {
                    Session["UserPassword"] = newPassword;
                    chk = result;
                }
                else
                {
                    chk = "0";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

        #region UserLoginLogSave
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string UserLoginLogSave(string employeeID, string employeeCode,string employeeNameEng,string employeeNameArb)
        {
            string hostName = Dns.GetHostName();
            string ip_address = Dns.GetHostByName(hostName).AddressList[0].ToString();
            var macAddr =(from nic in NetworkInterface.GetAllNetworkInterfaces() where nic.OperationalStatus == OperationalStatus.Up
                            select nic.GetPhysicalAddress().ToString()).FirstOrDefault();
            var channel = GetBrowser();
            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("employee_id", employeeID);
            ht.Add("employee_code", employeeCode);
            ht.Add("employee_name_arb", employeeNameEng);
            ht.Add("employee_name_eng", employeeNameArb);
            ht.Add("mac_address", macAddr);
            ht.Add("ip_address", ip_address);
            ht.Add("channel", channel);
            ht.Add("channelType", "web");

            string companyCode = (ConfigurationManager.AppSettings["CompCode"] + "").Trim();

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                TAMSR2Company cmpObj = new TAMSR2Company(companyCode);
                objDAL.OpenConnection(Connection.GetConnectionStrinng(cmpObj.DbType, cmpObj.DbName, cmpObj.DbUser, cmpObj.DbPassword));
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_UserLogs", ht);

            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }

        //*********End Of Save Function*********//

        protected string GetIPAddress()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }

        private string GetBrowser()
        {
            System.Web.HttpBrowserCapabilities browser = Request.Browser;
            string s = "Browser Capabilities\n"
                + "Type = " + browser.Type + "\n"
                + "Name = " + browser.Browser + "\n"
                + "Version = " + browser.Version
                      + "\n";
            return s;
        }
        #endregion

        #region GetAllUserLogs
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetAllUserLogs()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            List<UserActivityLog> userActivityLogs = new List<UserActivityLog>();
            try
            {
                string companyCode = (ConfigurationManager.AppSettings["CompCode"] + "").Trim();
                var session = Session["ID"] + "";
                TAMSR2Company cmpObj = new TAMSR2Company(companyCode);
                objDAL.OpenConnection(Connection.GetConnectionStrinng(cmpObj.DbType, cmpObj.DbName, cmpObj.DbUser, cmpObj.DbPassword));
                var minutes = new DBAppSetting().GetUserActiveSessionLastMinutes(session, Connection.GetConnectionStrinng(cmpObj.DbType, cmpObj.DbName, cmpObj.DbUser, cmpObj.DbPassword));
                Hashtable ht = new Hashtable();
                ht.Add("action", "getAllLogs");
                ht.Add("channelType", "web");
                ht.Add("minutes", minutes);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_UserLogs", ht);
                foreach(DataRowView obj in objDataView)
                {
                    UserActivityLog tempObj = new UserActivityLog();
                    tempObj.employee_id = obj["employee_id"] + "";
                    tempObj.employee_code = obj["employee_code"] + "";
                    tempObj.employee_name_arb = obj["employee_name_arb"] + "";
                    tempObj.employee_name_eng = obj["employee_name_eng"] + "";
                    tempObj.mac_address = obj["mac_address"] + "";
                    tempObj.ip_address = obj["ip_address"] + "";
                    tempObj.channel = obj["channel"] + "";
                    tempObj.login_time = Numerics.GetDateTime(obj["login_time"]).ToString(AppSetting.dateTimeFormat);
                    userActivityLogs.Add(tempObj);
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(userActivityLogs);
        }
        //*********End Of GetAll Function*********//
        #endregion


    }
}