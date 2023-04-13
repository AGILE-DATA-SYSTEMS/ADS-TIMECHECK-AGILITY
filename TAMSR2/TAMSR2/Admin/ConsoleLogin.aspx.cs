using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Admin
{
    public partial class ConsoleLogin : System.Web.UI.Page
    {
        string url = "";
        string path = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"Admin/ConsoleLogin.aspx"));

            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Login() != "1")
            {
                Response.Redirect(path + "ErrorPages/error-404.aspx");
            }
            else
            {
                Response.Redirect(path + "Security/Console");
            }
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
            ht.Add("username", txtUser.Text.Trim());
            ht.Add("password", Encryption.Encrypt_AES(txtPassword.Text.Trim()));
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

    }
}