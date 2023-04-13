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
    public partial class DashboardSelfStatsPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        string IsArabic = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/DashboardSelfStatsPage.aspx"));


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
            else if (Request["key"] + "" == "getAllTrans")
            {
                data = GetAllTransactions();
            }
            else if (Request["key"] + "" == "getDashboardStat")
            {
                data = GetDashboardStatistics();
            }  
            else if (Request["key"] + "" == "getMyViolations")
            {
                data = GetMyViolations();
            }
            else if (Request["key"] + "" == "getMyPendingRequests")
            {
                data = GetMyPendingRequests();
            }
            else if (Request["key"] + "" == "getAllPendingRequests")
            {
                data = GetAllPendingRequests();
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


        #region GetDashboardStatistics
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetDashboardStatistics()
        {
            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DashboardStat obj = new DashboardStat();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getStats");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardSelfStatsOps", ht);

                if (dv != null)
                {
                    obj.SchCode = dv[0]["SchCode"] + "";
                    obj.Flexible = dv[0]["Flexible"] + "";
                    obj.GraceIn = dv[0]["GraceIn"] + "";
                    obj.GraceOut = dv[0]["GraceOut"] + "";
                    obj.TimeIn = (dv[0]["TimeIn"] + "").Length > 5 ? (dv[0]["TimeIn"] + "").Substring(0, 5) : dv[0]["TimeIn"] + "";
                    obj.TimeOut = (dv[0]["TimeOut"] + "").Length > 5 ? (dv[0]["TimeOut"] + "").Substring(0, 5) : dv[0]["TimeOut"] + "";


                    obj.MissedIn = dv[0]["MissedIN"] + "";
                    obj.MissedOut = dv[0]["MissedOut"] + "";

                    obj.Late = dv[0]["Late"] + "";
                    obj.Early = dv[0]["Early"] + "";
                    obj.Absent = dv[0]["Absent"] + "";
                    obj.Leave = dv[0]["Leave"] + "";
                    obj.LateMinutes = dv[0]["LateMinutes"] + "";
                    obj.EarlyMinutes = dv[0]["EarlyMinutes"] + "";
                    obj.AbsentMinutes = dv[0]["AbsentMinutes"] + "";

                    obj.MonthlyLate = dv[0]["MonthlyLate"] + "";
                    obj.MonthlyEarly = dv[0]["MonthlyEarly"] + "";
                    obj.MonthlyAbsent = dv[0]["MonthlyAbsent"] + "";
                    obj.MonthlyLateMinutes = dv[0]["MonthlyLateMinutes"] + "";
                    obj.MonthlyEarlyMinutes = dv[0]["MonthlyEarlyMinutes"] + "";
                    obj.MonthlyAbsentMinutes = dv[0]["MonthlyAbsentMinutes"] + "";

                    obj.GroupLate = dv[0]["GroupLate"] + "";
                    obj.GroupEarly = dv[0]["GroupEarly"] + "";
                    obj.GroupAbsent = dv[0]["GroupAbsent"] + "";
                    obj.GroupLateMinutes = dv[0]["GroupLateMinutes"] + "";
                    obj.GroupEarlyMinutes = dv[0]["GroupEarlyMinutes"] + "";
                    obj.GroupAbsentMinutes = dv[0]["GroupAbsentMinutes"] + "";

                    obj.MonthlyGroupLate = dv[0]["MonthlyGroupLate"] + "";
                    obj.MonthlyGroupEarly = dv[0]["MonthlyGroupEarly"] + "";
                    obj.MonthlyGroupAbsent = dv[0]["MonthlyGroupAbsent"] + "";
                    obj.MonthlyGroupLateMinutes = dv[0]["MonthlyGroupLateMinutes"] + "";
                    obj.MonthlyGroupEarlyMinutes = dv[0]["MonthlyGroupEarlyMinutes"] + "";
                    obj.MonthlyGroupAbsentMinutes = dv[0]["MonthlyGroupAbsentMinutes"] + "";


                    obj.Permission = dv[0]["Permission"] + "";
                    obj.PermissionMinutes = dv[0]["PermissionMinutes"] + "";
                    obj.MonthlyPermission = dv[0]["MonthlyPermission"] + "";
                    obj.MonthlyPermissionMinutes = dv[0]["MonthlyPermissionMinutes"] + "";

                    obj.InTime1 = (dv[0]["InTime1"] + "").Length > 5 ? (dv[0]["InTime1"] + "").Substring(0, 5) : dv[0]["InTime1"] + "";
                    obj.OutTime1 = (dv[0]["OutTime1"] + "").Length > 5 ? (dv[0]["OutTime1"] + "").Substring(0, 5) : dv[0]["OutTime1"] + "";
                    //obj.Shift1 = obj.InTime1 + " - " + obj.OutTime1;
                    obj.Shift1 = obj.InTime1 + " - " + Convert.ToString(Convert.ToDateTime(obj.InTime1).AddMinutes(Convert.ToDouble(obj.Flexible)).TimeOfDay).Substring(0, 5) + " <b>" + Resources.Resource.to + " <b>";
                    obj.RequireTime1 = Numerics.GetInt(dv[0]["RequireTime1"] + "");

                    obj.InTime2 = (dv[0]["InTime2"] + "").Length > 5 ? (dv[0]["InTime2"] + "").Substring(0, 5) : dv[0]["InTime2"] + "";
                    obj.OutTime2 = (dv[0]["OutTime2"] + "").Length > 5 ? (dv[0]["OutTime2"] + "").Substring(0, 5) : dv[0]["OutTime2"] + "";
                    obj.Shift2 = obj.InTime2 + " - " + obj.OutTime2;
                    obj.RequireTime2 = Numerics.GetInt(dv[0]["RequireTime2"] + "");

                    obj.InTime3 = (dv[0]["InTime3"] + "").Length > 5 ? (dv[0]["InTime3"] + "").Substring(0, 5) : dv[0]["InTime3"] + "";
                    obj.OutTime3 = (dv[0]["OutTime3"] + "").Length > 5 ? (dv[0]["OutTime3"] + "").Substring(0, 5) : dv[0]["OutTime3"] + "";
                    obj.Shift3 = obj.InTime3 + " - " + obj.OutTime3;
                    obj.RequireTime3 = Numerics.GetInt(dv[0]["RequireTime3"] + "");

                    obj.TotalScheduleRequireTime = obj.RequireTime1 + obj.RequireTime2 + obj.RequireTime3;
                    obj.ExpectedTimeOut = (dv[0]["ExpectedTimeOut"] + "").Length > 5 ? (dv[0]["ExpectedTimeOut"] + "").Substring(0, 5) : dv[0]["ExpectedTimeOut"] + "";
                    obj.SchWithFlexible = dv[0]["SchWithFlexible"] + "";
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

        #region GetAllTransactions
        /// <summary>
        /// GetAllTransactions function
        /// Get All Transactions 
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetAllTransactions()
        {
            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data(); 
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "emp.employee_code", "emp.name" + languagePostfix, "rdr.reader_name", "rg.description" + languagePostfix, "rsn.description" + languagePostfix, "empTrans.transaction_time" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getTransactions");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardSelfStatsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getTransactionsCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_DashboardSelfStatsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add((obj["employee_code"] + "").Trim());
                    tempList.Add((obj["name" + languagePostfix] + "").Trim());
                    tempList.Add((obj["reader_name"] + "").Trim());
                    tempList.Add((obj["region" + languagePostfix] + "").Trim());
                    tempList.Add((obj["reason" + languagePostfix] + "").Trim());
                    tempList.Add(Numerics.GetDateTime(obj["transaction_time"] + "").ToString(AppSetting.dateTimeFormat24));

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DashboardSelfStatsOps.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion
        
        #region GetMyViolations
        /// <summary>
        /// GetMyViolations function
        /// Get My Violations
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetMyViolations()
        {
            string dt = (Request["dt"] + "").Trim();
            string emp = (Request["emp"] + "").Trim();
            string mgr = (Request["mgr"] + "").Trim();
            string org = (Request["org"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string type = "";
                string scope = Request["scope"] + "";

                if (Request["type"] + "" == "early")
                {
                    type = "Early";
                }
                if (Request["type"] + "" == "late")
                {
                    type = "Late";
                }
                if (Request["type"] + "" == "leave")
                {
                    type = "Leave";
                }
                if (Request["type"] + "" == "absent")
                {
                    type = "Absent";
                }
                if (Request["type"] + "" == "missedin")
                {
                    type = "MissedIn";
                }
                if (Request["type"] + "" == "missedOut")
                {
                    type = "MissedOut";
                }
                if (Request["type"] + "" == "permissions")
                {
                    type = "Permissions";
                }

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "Ddate", "employee_code", "name" + languagePostfix, "sch", "punch", "remarks" + languagePostfix };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;

                ht = new Hashtable();
                ht.Add("action", "getMyLateDetails");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("type", type);
                ht.Add("scope", scope);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                if (scope.ToLower() == "group")
                {
                    ht.Add("OrganizationID", org + "");
                    ht.Add("ManagerID", mgr + "");
                    ht.Add("EmployeeID", emp + "");
                }
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardSelfStatsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getMyLateDetailsCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("type", type);
                ht.Add("scope", scope);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                if (scope.ToLower() == "group")
                {
                    ht.Add("OrganizationID", org + "");
                    ht.Add("ManagerID", mgr + "");
                    ht.Add("EmployeeID", emp + "");
                }
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_DashboardSelfStatsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if (type == "Permissions")
                        tempList.Add((obj["Ddate"] + ""));
                    else
                        tempList.Add((obj["Ddate"] + "") == "" ? "" : Numerics.GetDateTime(obj["Ddate"] + "").ToString(AppSetting.dateFormat));

                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add(obj["name" + languagePostfix] + "");

                    //     if (type == "Permissions")
                    tempList.Add((obj["sch"] + ""));
                    //    else
                    //        tempList.Add((obj["sch"] + "") == "" ? "" : Numerics.GetDateTime(obj["sch"] + "").ToString(AppSetting.shortTimeFormat));
                    if (type == "Absent")
                    {

                        tempList.Add("&nbsp;");
                        tempList.Add(obj["remarks" + languagePostfix] + "");
                    }
                    else
                    {

                        //      if (type == "Permissions")
                        tempList.Add((obj["punch"] + ""));
                        //        else
                        //            tempList.Add((obj["punch"] + "") == "" ? "" : Numerics.GetDateTime(obj["punch"] + "").ToString(AppSetting.dateTimeFormat24));

                        tempList.Add(obj["remarks" + languagePostfix] + "");
                    }
                    json.aaData.Add(tempList);
                }
                if (json.iTotalDisplayRecords == 0)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SelfStatsPage.aspx.GetMyViolations()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion

        #region GetMyPendingRequests

        public string GetMyPendingRequests()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DashboardStat obj = new DashboardStat();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getMyPendingRequest");
                ht.Add("sessionID", Session["ID"] + ""); 
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardSelfStatsOps", ht);

                if (dv != null)
                {
                    if (dv.Count > 0)
                    {
                        if (dv[0]["Leaves"] + "" != "")
                            obj.LeavesCount = dv[0]["Leaves"] + "";
                        else
                            obj.LeavesCount = "0";
                        if (dv[0]["ShortPermission"] + "" != "")
                            obj.PermissionCount = dv[0]["ShortPermission"] + "";
                        else
                            obj.PermissionCount = "0";
                        if (dv[0]["MissingMovements"] + "" != "")
                            obj.MissingMovementCount = dv[0]["MissingMovements"] + "";
                        else
                            obj.MissingMovementCount = "0";
                        if (dv[0]["ManualMovements"] + "" != "")
                            obj.ManualMovementCount = dv[0]["ManualMovements"] + "";
                        else
                            obj.ManualMovementCount = "0";
                    }
                    else
                    {
                        obj.LeavesCount = "0";
                        obj.PermissionCount = "0";
                        obj.MissingMovementCount = "0";
                        obj.ManualMovementCount = "0";
                    }
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
        #endregion

        #region GetAllPending
        /// <summary>
        /// Get All Pending function
        /// Get all pending permissions
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllPendingRequests()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                //string[] cols = { "sngPerm.single_permissions_id", "emp.employee_code", "emp.name" + languagePostfix, "sngPerm.created_date", "permType.description" + languagePostfix, "sngPerm.from_date", "sngPerm.to_date", "sngPerm.from_time", "sngPerm.to_time", "sngPerm.minutes", "sngPerm.approve_reject_flag", "sngPerm.created_date", "sngPerm.single_permissions_id" };
                string[] cols = { "type", "description" + languagePostfix, "from_date", "to_date", "from_time", "to_time", "minutes", "approve_reject_flag" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();
                string type = (Request["type"] + "").Trim();


                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getMyPendingRequestDetails");
                ht.Add("sessionID", Session["ID"] + ""); 
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardSelfStatsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getMyPendingRequestDetailsCount");
                ht.Add("sessionID", Session["ID"] + ""); 
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_DashboardSelfStatsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();   
                    tempList.Add(obj["type"] + "");
                    tempList.Add((obj["Description" + languagePostfix] + "").Length > 100 ? (obj["Description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Description" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["from_time"] + "");
                    tempList.Add(obj["to_time"] + "");
                    tempList.Add(Numerics.FormatMinsToHHmm((obj["minutes"] + "").Trim()));
                    tempList.Add((obj["remarks"] + "").Trim());
                    if(obj["type"] + "" == "Manaul Movement")
                        tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    else
                        tempList.Add( obj["approval_status"] + "");

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion

        public string GetApplyApporveRejectStatus(int temp)
        {
            if (temp == 0)
                return (String)GetGlobalResourceObject("Resource", "applied") + "";
            else if (temp == 1)
                return (String)GetGlobalResourceObject("Resource", "approved") + "";
            else if (temp == 2)
                return (String)GetGlobalResourceObject("Resource", "rejected") + "";
            else
                return "";
        }

    }
}