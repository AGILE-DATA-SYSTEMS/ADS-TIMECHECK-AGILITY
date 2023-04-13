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
    public partial class DashboardTeamStatsPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        string IsArabic = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/DashboardTeamStatsPage.aspx"));


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
            else if (Request["key"] + "" == "getGroupVoilations")
            {
                data = GetGroupVoilations();
            } 
            else if (Request["key"] + "" == "getPendingRequests")
            {
                data = GetAllPendingApprovalRequests();
            }
            else if (Request["key"] + "" == "getAllPendingRequests")
            {
                data = GetAllPendingRequests();
            }
            else if (Request["key"] + "" == "getPercentageDepartment")
            {

                data = GetPercentageDepartment();
            }
            else if (Request["key"] + "" == "getDepartmentViolationDetails")
            {

                data = GetDepartmentViolations();
            }
            else if (Request["key"] + "" == "getPercentage")
            {
                data = GetPercentage();
            }
            else if (Request["key"] + "" == "getMyViolations")
            {
                data = GetMyViolations();
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


        #region GetGroupVoilations
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetGroupVoilations()
        {
            GroupStats obj = new GroupStats();

            string dt = (Request["dt"] + "").Trim();
            string emp = (Request["emp"] + "").Trim();
            string mgr = (Request["mgr"] + "").Trim();
            string org = (Request["org"] + "").Trim();

            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getGroupStats");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamStatsOps", ht);

                if (dv != null)
                {
                    obj.MonthlyLate = dv[0]["GroupLate"] + "";
                    obj.MonthlyEarly = dv[0]["GroupEarly"] + "";
                    obj.MonthlyLeave = dv[0]["GroupLeave"] + "";
                    obj.MonthlyAbsent = dv[0]["GroupAbsent"] + "";
                    obj.MonthlyMissedIn = dv[0]["GroupMissedIN"] + "";
                    obj.MonthlyMissedOut = dv[0]["GroupMissedOut"] + "";
                    obj.MonthlyPermissions = dv[0]["GroupPermission"] + "";

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



        #region GetPercentage
        /// <summary>
        /// GetPercentage function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetPercentage()
        {
            ViolationTrend obj = new ViolationTrend();

            string dt = (Request["dt"] + "").Trim();
            string emp = (Request["emp"] + "").Trim();
            string mgr = (Request["mgr"] + "").Trim();
            string org = (Request["org"] + "").Trim();

            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getPercentage");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamStatsOps", ht);

                if (dv != null)
                {
                    obj.LatePercentage = Numerics.GetDecimal(dv[0]["LatePercentage"] + "");
                    obj.EarlyPercentage = Numerics.GetDecimal(dv[0]["EarlyPercentage"] + "");
                    obj.AbsentPercentage = Numerics.GetDecimal(dv[0]["AbsentPercentage"] + "");
                    obj.LeavePercentage = Numerics.GetDecimal(dv[0]["LeavePercentage"] + "");
                    obj.PresentPercentage = Numerics.GetDecimal(dv[0]["PresentPercentage"] + "");
                    obj.MissedInPercentage = Numerics.GetDecimal(dv[0]["MissedInPercentage"] + "");
                    obj.MissedOutPercentage = Numerics.GetDecimal(dv[0]["MissedOutPercentage"] + "");
                    obj.PresentPercentage = 100 - (obj.LatePercentage + obj.EarlyPercentage + obj.AbsentPercentage + obj.LeavePercentage + obj.MissedInPercentage + obj.MissedOutPercentage);

                }
                //obj.LatePercentage = 10;
                //obj.EarlyPercentage = 15;
                //obj.AbsentPercentage = 5;
                //obj.LeavePercentage = 10;
                //obj.PresentPercentage = 100 - (obj.LatePercentage + obj.EarlyPercentage + obj.AbsentPercentage + obj.LeavePercentage);
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

        public string GetPercentageDepartment()
        {
            List<object> obj = new List<object>();

            string dt = (Request["dt"] + "").Trim();
            string emp = (Request["emp"] + "").Trim();
            string mgr = (Request["mgr"] + "").Trim();
            string org = (Request["org"] + "").Trim();

            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getPercentageDepartment");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("organizationcode", Request["code"] + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + "");
                ht.Add("type", Request["type"] + "");

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamStatsOps", ht);

                if (dv != null)
                {
                    foreach (DataRowView item in dv)
                    {
                        object tempObj = new { OrganizationCode = item["OrganizationCode"], PercentageValue = item["OrganizationPercentage"], OrganizationName = item["OrganizationName"] };
                        obj.Add(tempObj);
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamStatsOps", ht);

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
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_DashboardTeamStatsOps", ht));
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
                    tempList.Add((obj["sch"] + "")); 
                    if (type == "Absent")
                    {

                        tempList.Add("&nbsp;");
                        tempList.Add(obj["remarks" + languagePostfix] + "");
                    }
                    else
                    { 
                        tempList.Add((obj["punch"] + "")); 
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
                new ExceptionLog().WriteLog("RequestPages/DashboardTeamStatsPage.aspx.GetMyViolations()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion

        #region GetDepartmentViolations
        public string GetDepartmentViolations()
        {
            string dt = (Request["dt"] + "").Trim(); string emp = (Request["emp"] + "").Trim();
            string mgr = (Request["mgr"] + "").Trim();
            string org = (Request["org"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");

            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string type = "";
                string scope = Request["scope"] + "";

                if (Request["type"] + "" == "early")
                {
                    type = "Early";
                }
                else if (Request["type"] + "" == "late")
                {
                    type = "Late";
                }
                else if (Request["type"] + "" == "leave")
                {
                    type = "Leave";
                }
                else if (Request["type"] + "" == "absent")
                {
                    type = "Absent";
                }
                else if (Request["type"] + "" == "missed in")
                {
                    type = "Missed In";
                }
                else if (Request["type"] + "" == "missed out")
                {
                    type = "Missed Out";
                }
                else
                    type = "";

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "Ddate", "employee_code", "EmployeeNameEng", "Time_In", "ActualSchInPerMove", type };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;

                ht = new Hashtable();
                ht.Add("action", "getDepartmentViolationDetails");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("organizationcode", Request["code"] + "");
                ht.Add("date", dt);
                ht.Add("type", type);
                ht.Add("scope", scope);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + "");
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamStatsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getDepartmentViolationCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("organizationcode", Request["code"] + "");
                ht.Add("date", dt);
                ht.Add("type", type);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + "");
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_DashboardTeamStatsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add((obj["date"] + "") == "" ? "" : Numerics.GetDateTime(obj["date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["employeecode"] + "");
                    tempList.Add(obj["name" + languagePostfix] + "");

                    if (obj.Row.Table.Columns.Contains("schin"))
                    {
                        tempList.Add((obj["schin"] + "") == "" ? "" : Numerics.GetDateTime(obj["schin"] + "").ToString(AppSetting.shortTimeFormat));
                    }
                    else
                    {

                        tempList.Add("&nbsp;");

                    }

                    if (type != "Absent" && type != "Leave" && type != "missed in")
                    {
                        tempList.Add((obj["Time_In"] + "") == "" ? "" : Numerics.GetDateTime(obj["Time_In"] + "").ToString(AppSetting.dateTimeFormat24));

                    }
                    else if (type == "missed in")
                    {
                        tempList.Add((obj["Time_Out"] + "") == "" ? "" : Numerics.GetDateTime(obj["Time_Out"] + "").ToString(AppSetting.dateTimeFormat24));

                    }
                    else
                    {
                        tempList.Add("&nbsp;");
                    }
                    tempList.Add(obj[@type] + "");

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
                new ExceptionLog().WriteLog("RequestPages/DashboardPage.aspx.GetDepartmentViolations()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }

        #endregion


        #region GetAllPendingApprovalRequests

        public string GetAllPendingApprovalRequests()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DashboardStat obj = new DashboardStat();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string emp = (Request["emp"] + "").Trim();
                string mgr = (Request["mgr"] + "").Trim();
                string org = (Request["org"] + "").Trim();

                Hashtable ht = new Hashtable();
                ht.Add("action", "getAllPendingRequest");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamStatsOps", ht);

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

                string[] cols = { "employee_code", "name" + languagePostfix, "type", "description" + languagePostfix, "from_date", "to_date", "from_time", "to_time",  "approve_reject_flag" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];


                string emp = (Request["emp"] + "").Trim();
                string mgr = (Request["mgr"] + "").Trim();
                string org = (Request["org"] + "").Trim();
                string Type = (Request["type"] + "").Trim();

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getAllPendingRequestDetails");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + ""); 

                if(Type != "")
                    ht.Add("Type", Type + ""); 

                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamStatsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getAllPendingRequestDetailsCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("OrganizationID", org + "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + "");

                if (Type != "")
                    ht.Add("Type", Type + ""); 

                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_DashboardTeamStatsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["Name" + languagePostfix] + "").Length > 100 ? (obj["Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Name" + languagePostfix] + "")); 
                    tempList.Add(obj["type"] + "");
                    tempList.Add((obj["Description" + languagePostfix] + "").Length > 100 ? (obj["Description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Description" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["from_time"] + "");
                    tempList.Add(obj["to_time"] + "");
                    //tempList.Add(Numerics.FormatMinsToHHmm((obj["minutes"] + "").Trim()));
                    //tempList.Add((obj["remarks"] + "").Trim());
                    if (obj["type"] + "" == "Manaul Movement")
                        tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    else
                        tempList.Add(obj["approval_status"] + "");

                    string tempAction = "";
                    tempAction = "";
                    tempAction = "<img src='" + path + "images/approve.png' title='approve' alt='approve' onclick='return Approve(\"" + Numerics.GetDecimal(obj["transaction_id"]) + "\",\"" + obj["type"] + "\");'  /> &nbsp; ";
                    tempList.Add(tempAction);
                    tempAction = "";
                    tempAction = "<img src='" + path + "images/reject.png' title='reject' alt='approve' onclick='return Reject(\"" + Numerics.GetDecimal(obj["transaction_id"]) + "\",\"" + obj["type"] + "\");' /> &nbsp; ";
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DashboardTeamStats.aspx.GetAllPendingRequests()", 0, ex);
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