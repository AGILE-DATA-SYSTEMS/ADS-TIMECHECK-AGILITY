using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL; 

namespace TAMSR2.Common
{
    public partial class Default : BasePage
    {
        string languagePostfix = "_eng";
        public string EnabledGeoLocation = "false";
        protected void Page_Load(object sender, EventArgs e)
        {
            DBAppSetting AppStng = new DBAppSetting();
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("default.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("common/default.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("common/home"));

            #region User Authentication and Preferences
            /// <summary>
            /// Checks Session variable for login, if windows login is not activate 
            /// otherwise Authenticate user by windows login if Windows Login is activated in Web.config
            /// And also Set Page Culture Variables for user preffered language.
            /// </summary>
            if (UserAuthentication() == false)
            {
                if (ConfigurationManager.AppSettings["ADLogin"] + "" == "1")
                    Response.Redirect(path + "Login/" + Request.LogonUserIdentity.Name + "");
                else
                    Response.Redirect(path + "Logout");
                return;
            }
            SetCultureValues();
            #endregion

            string welcome = (String)GetGlobalResourceObject("Resource", "welcome");
            if (languageStr == "ar")
            {
                languagePostfix = "_arb";
                pgTitle.InnerHtml = welcome + " " + Session["EmployeeNameArb"] + "";
            }
            else
            {
                pgTitle.InnerHtml = welcome + " " + Session["EmployeeNameEng"] + "";
            }
            EnabledGeoLocation = AppStng.IsGeoLocationEnabled(Session["ID"] + "", Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
            WebpunchAccess();
            GetAllAvailableFeatures();
        }

        public string VerificationWidget()
        {
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_VIOLATION))
                return "block";
            else
                return "none";
        }
        public string TeamEfficiencyWidget()
        {
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_TEAM_EFFICIENCY))
                return "block";
            else
                return "none";
        }

        #region WebpunchAccess
        /// <summary>
        /// WebpunchAccess function
        /// </summary>
        public void WebpunchAccess()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            WebpunchExclude obj = new WebpunchExclude();
            try
            {
                Session["WebPunch"] = "0";
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                Hashtable ht = new Hashtable();
                ht.Add("action", "getWebPunchAccess");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_WebpunchExcludeListOps", ht);

                if (dv != null)
                {
                    if (Numerics.GetBool(dv[0]["webpunch"]) == true)
                    {
                        Session["WebPunch"] = "1";
                        Session["WebPunchDelay"] = Numerics.GetDecimal(dv[0]["WebPunchDelay"] + "");
                        Session["LastPunchTime"] = Numerics.GetDateTime(dv[0]["transaction_time"] + "").ToString("yyyy-MM-dd HH:mm:ss");
                        Session["LastPunchMode"] = Numerics.GetDecimal(dv[0]["reason_mode"] + "");
                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/Default.aspx.WebpunchAccess()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            //if (Session["WebPunch"] + "" == "1")
            //    WebpunchReasons();
        }
        //*********End Of WebpunchAccess Function*********//
        #endregion




        #region WebpunchReasons
        /// <summary>
        /// WebpunchReasons function
        /// </summary>
        public void WebpunchReasons()
        {
            StringBuilder sb = new StringBuilder();
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                sb.Append("");
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                Hashtable ht = new Hashtable();
                ht.Add("action", "getWebPunchReasons");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ReasonOps", ht);

                foreach (DataRowView obj in dv)
                {
                    if (Numerics.GetDecimal(obj["reason_mode"] + "") == 1 && Session["LastPunchMode"] + "" != "1")
                    {
                        sb.Append("<a class='btn icn-only green' style='color: #FFF; font-weight: bold;' href='javascript:void(0);' ");
                        sb.Append("onclick='return EmpWebPunch(" + Numerics.GetDecimal(obj["reason_id"] + "") + ", \"" + obj["prompt_message"] + "\")'>");
                        sb.Append("<i class='m-icon-swap" + pullDirectionStr + " m-icon-white'></i> " + (obj["description" + languagePostfix] + "").Trim());
                        sb.Append("</a>   ");
                    }
                    else
                        if (Numerics.GetDecimal(obj["reason_mode"] + "") == 2 && Session["LastPunchMode"] + "" != "2")
                        {
                            sb.Append("<a class='btn icn-only red' style='color: #FFF; font-weight: bold;' href='javascript:void(0);' ");
                            sb.Append("onclick='return EmpWebPunch(" + Numerics.GetDecimal(obj["reason_id"] + "") + ", \"" + obj["prompt_message"] + "\")'>");
                            sb.Append("<i class='m-icon-swap" + pullDirectionStr + " m-icon-white'></i> " + (obj["description" + languagePostfix] + "").Trim());
                            sb.Append("</a>   ");
                        }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/Default.aspx.WebpunchReasons()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
        }
        //*********End Of WebpunchReasons Function*********//
        #endregion


        public string IsFeatureAvailable(string str)
        {
            str = str.Trim().ToUpper();
            if (ViewState["features"] + "" != "")
            {
                string[] arr = (ViewState["features"] + "").Split(',');
                if (arr.Contains(str))
                    return "block";
            }
            return "none";
        }

        #region GetAllAvailableFeatures
        /// <summary>
        /// WebpunchAccess function
        /// </summary>
        public void GetAllAvailableFeatures()
        {
            StringBuilder sb = new StringBuilder();
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            WebpunchExclude obj = new WebpunchExclude();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList"); 
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_FeatureOps", ht);

                foreach (DataRowView row in dv)
                {
                    sb.Append((row["code"] + "").Trim().ToUpper() + ",");
                }
                ViewState["features"] = sb.ToString();
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/Default.aspx.GetAllAvailableFeatures()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
        }
        //*********End Of GetAllAvailableFeatures Function*********//
        #endregion



        public string IsSuperAdmin()
        {
            //if (Session["ID"] + "" == "-1")
            //    return "none";
            //else
            //    return "block";
            return "none";
        }
    }
}