using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
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
    public partial class DashboardActivityMonitorPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        string IsArabic = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/DashboardActivityMonitorPage.aspx"));


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


            if (cookie.Values["language"] + "" == "ar")
            {
                languagePostfix = "_arb";
                IsArabic = "1";
            }
            else
                languagePostfix = "_eng";

            string data = "";

            if (Session["ID"] + "" == "")
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "getAttendanceActivity")
            {
                data = GetAttendanceActivity();
            }
            else if (Request["key"] + "" == "getTransactionCount")
            {
                data = GetTransactionCount();
            }
            else
            {
                data = "";
            }
            
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Write(data);
            Response.Flush();
            //Response.End();

        }


        #region GetAttendanceActivity
        /// <summary>
        /// GetAttendanceActivity function
        /// Get Attendance Activity
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetAttendanceActivity()
        {
            string dt = (Request["dt"] + "").Trim();
            string ActivityLastTransactionTime = (Request["activityLastTransactionTime"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            List<object> tempList = new List<object>();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string type = "";
                string scope = Request["scope"] + "";


                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "Ddate", "employee_code", "name" + languagePostfix, "sch", "punch", "remarks" + languagePostfix };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;

                ht = new Hashtable();
                ht.Add("action", "GetAttendanceActivity");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("type", type);
                ht.Add("scope", scope);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                ht.Add("IsArabic", IsArabic);
                ht.Add("activityLastTransactionTime", ActivityLastTransactionTime);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardActivityMonitorOps", ht);


                foreach (DataRowView obj in objDataView)
                {

                    object tempObj = new
                    {
                        Transaction_Time = DateTime.Parse(obj["Transaction_Time"] + "").ToString("yyyy-MM-dd HH:mm:ss"),
                        Ddate = (obj["Ddate"] + "") == "" ? "" : Numerics.GetDateTime(obj["Ddate"] + "").ToString(AppSetting.dateFormat),
                        EmployeeId = (obj["Employee_Id"] + ""),
                        EmployeeName = (obj["EmployeeName"] + ""),
                        ReasonId = (obj["ReasonId"] + ""),
                        ReasonDesc = (obj["Reason"] + ""),
                        ReasonMode = (obj["ReasonMode"] + "")
                    };
                    tempList.Add(tempObj); 
                } 
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DashboardPage.aspx.GetAttendanceActivity()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(tempList);
        }
        //*********End Of GetAll Function*********//
        #endregion

        #region GetTransactionCount


        public string GetTransactionCount()
        {
            string dt = (Request["dt"] + "").Trim(); 
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");

            string emp = (Request["emp"] + "").Trim();
            string mgr = (Request["mgr"] + "").Trim();
            string org = (Request["org"] + "").Trim();

            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            object tempObj = null;
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "GetTransactionCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + ""); 
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardActivityMonitorOps", ht);


                foreach (DataRowView obj in objDataView)
                { 
                    tempObj = new
                    {
                        InCount = obj["InCount"] + "",
                        OutCount = obj["OutCount"] + ""  
                    }; 
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DashboardPage.aspx.TransactionCount()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(tempObj);
        }

        #endregion

        

    }
}