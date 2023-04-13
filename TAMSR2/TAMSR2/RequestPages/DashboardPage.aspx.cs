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
    public partial class DashboardPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        string IsArabic = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/DashboardPage.aspx"));


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
            else if (Request["key"] + "" == "getGroupVoilations")
            {
                data = GetGroupVoilations();
            }
            else if (Request["key"] + "" == "getTrends")
            {
                data = GetTrends();
            }
            else if (Request["key"] + "" == "getTrendsPercentage")
            {
                data = GetTrendsPercentage();
            }
            else if (Request["key"] + "" == "getPercentage")
            {
                data = GetPercentage();
            }
            else if (Request["key"] + "" == "getMyViolations")
            {
                data = GetMyViolations();
            }
            else if (Request["key"] + "" == "getAttendanceActivity")
            {
                data = GetAttendanceActivity();
            }
            else if (Request["key"] + "" == "getPercentageDepartment")
            {

                data = GetPercentageDepartment();
            }
            else if (Request["key"] + "" == "getDepartmentViolationDetails")
            {

                data = GetDepartmentViolations();
            }
            else if (Request["key"] + "" == "getDataReprocessActivity")
            {

                data = GetDataReprocessActivity();
            }
            else if (Request["key"] + "" == "getIdNameTeamList")
            {

                data = GetIdNameTeamList();
            }
            else if (Request["key"] + "" == "GetReaderTransactionsCount")
            {

                data = GetReaderTransactionsCount();
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
        
        
        public string GetIdNameTeamList()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();
              List<Employee> TeamList = new List<Employee>();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string emp = (Request["emp"] + "").Trim();
                string mgr = (Request["mgr"] + "").Trim();
                string org = (Request["org"] + "").Trim(); 

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameTeamList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", org + "");
                ht.Add("managerID", mgr + "");
                ht.Add("ID", emp + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);
                foreach (DataRowView row in dv)
                {
                    Employee newTeamMember = new Employee();
                    newTeamMember.EncryptedID = Encryption.Encrypt((row["employee_id"] + "").Trim());
                    newTeamMember.Code =   row["employee_code"] + "";
                    newTeamMember.NameEn = row["name_eng"] + "";
                    newTeamMember.NameAr =  row["name_arb"] + "";
                    TeamList.Add(newTeamMember);
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(TeamList);
        }
        
        public string GetDataReprocessActivity()
        {

            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            List<object> ResponseObject = new List<object>();
            try
            {

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                Hashtable ht = new Hashtable();
                ht.Add("action", "getDataStackStatuses");
                ht.Add("date", dt);
                ht.Add("language", cookie.Values["language"] + "");

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DataReprocessStackOPS", ht);
                List<DataReprocessStackStatus> listStatus = new List<DataReprocessStackStatus>();
                List<DataReprocessStack> listStack = new List<DataReprocessStack>();

                if (dv != null)
                {

                    foreach (DataRowView dr in dv)
                    {

                        DataReprocessStackStatus obj = new DataReprocessStackStatus();
                        obj.StatusId = Numerics.GetInt(dr["Data_Reprocess_Stack_Status_Id"]);
                        obj.Description = dr["Description"] + "".ToString();
                        listStatus.Add(obj);

                    }

                    if (listStatus.Count > 0)
                    {
                        ht = new Hashtable();
                        dv = new DataView();
                        ht.Add("action", "getRecords");
                        ht.Add("date", dt);
                        ht.Add("language", cookie.Values["language"] + "");
                        dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DataReprocessStackOPS", ht);


                        if (dv != null)
                        {
                            foreach (DataRowView dr in dv)
                            {

                                DataReprocessStack objStack = new DataReprocessStack();

                                objStack.Stack_id = Numerics.GetInt(dr["Stack_id"]);
                                objStack.Timecheck_Module_Id = Numerics.GetInt(dr["Timecheck_Module_Id"]);
                                objStack.Company_Id = Numerics.GetInt(dr["Company_Id"]);
                                objStack.Org_id = Numerics.GetInt(dr["Org_id"]);
                                objStack.Employee_id = Numerics.GetInt(dr["Employee_id"]);
                                objStack.From_date = dr["From_date"] + "".ToString();
                                objStack.To_date = dr["To_date"] + "".ToString();
                                objStack.UpdateAll = Numerics.GetInt(dr["UpdateAll"]);
                                objStack.Status = Numerics.GetInt(dr["Status"]);
                                objStack.Error = dr["Error"] + "".ToString();
                                objStack.CreatedBy = Numerics.GetInt(dr["CreatedBy"]);
                                objStack.CreatedOn = dr["CreatedOn"] + "".ToString();
                                objStack.UpdatedBy = Numerics.GetInt(dr["UpdatedBy"]);
                                objStack.UpdatedOn = dr["UpdatedOn"] + "".ToString();
                                objStack.ModuleName = dr["ModuleName"] + "".ToString();

                                listStack.Add(objStack);
                            }
                            ResponseObject.Add(listStatus);
                            ResponseObject.Add(listStack);


                        }

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

            return new JavaScriptSerializer().Serialize(ResponseObject);
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

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
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getTransactionsCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_MYDailytimeAttendence", ht));
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
                new ExceptionLog().WriteLog("RequestPages/DashboardPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


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
                ht.Add("OrganizationID", org+ "");
                ht.Add("ManagerID", mgr + "");
                ht.Add("EmployeeID", emp + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

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


        #region GetTrends
        /// <summary>
        /// GetTrends function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetTrends()
        {
            ViolationTrend obj = new ViolationTrend();

            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getTrends");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

                if (dv != null)
                {
                    obj.Late = (dv[0]["Late"] + "").Trim();
                    obj.Early = (dv[0]["Early"] + "").Trim();
                    obj.Leave = (dv[0]["Leave"] + "").Trim();
                    obj.Absent = (dv[0]["Absent"] + "").Trim();
                    obj.Average = (dv[0]["Average"] + "").Trim();

                    string[] lateStr = obj.Late.Split(',');
                    string[] earlyStr = obj.Early.Split(',');
                    string[] leaveStr = obj.Leave.Split(',');
                    string[] absentStr = obj.Absent.Split(',');
                    string[] averageStr = obj.Late.Split(',');

                    for (int k = 0; k < 12; k++)
                    {
                        averageStr[k] = (
                                    (Numerics.GetDecimal(lateStr[k]) + Numerics.GetDecimal(earlyStr[k]) +
                                    Numerics.GetDecimal(leaveStr[k]) + Numerics.GetDecimal(absentStr[k])) / 4
                                    ) + "";
                    }

                    obj.Average = string.Join(",", averageStr, 0, 12);

                }

                //obj.Late = "25,20,14,12,25,20,14,12,25,20,14,12";
                //obj.Early = "15,18,29,12,15,18,29,12,15,18,29,12";
                //obj.Absent = "20,12,26,12,20,12,26,12,20,12,26,12";
                //obj.Leave = "0,0,0,0,0,12,0,0,0,0,0,0";
                //obj.Average = "20,16,23,12,20,16,23,12,20,16,23,12";


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


        #region GetTrendsPercentage
        /// <summary>
        /// GetTrendsPercentage function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetTrendsPercentage()
        {
            ViolationTrend obj = new ViolationTrend();

            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getTrendsPercentage");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

                if (dv != null)
                {
                    obj.Late = (dv[0]["Late"] + "").Trim();
                    obj.Early = (dv[0]["Early"] + "").Trim();
                    obj.Leave = (dv[0]["Leave"] + "").Trim();
                    obj.Absent = (dv[0]["Absent"] + "").Trim();
                    obj.Average = (dv[0]["Average"] + "").Trim();

                    string[] lateStr = obj.Late.Split(',');
                    string[] earlyStr = obj.Early.Split(',');
                    string[] leaveStr = obj.Leave.Split(',');
                    string[] absentStr = obj.Absent.Split(',');
                    string[] averageStr = obj.Late.Split(',');

                    for (int k = 0; k < 12; k++)
                    {
                        averageStr[k] = (
                                    (Numerics.GetDecimal(lateStr[k]) + Numerics.GetDecimal(earlyStr[k]) +
                                    Numerics.GetDecimal(leaveStr[k]) + Numerics.GetDecimal(absentStr[k])) / 4
                                    ) + "";
                    }

                    obj.Average = string.Join(",", averageStr, 0, 12);

                }

                //obj.Late = "25,20,14,12,25,20,14,12,25,20,14,12";
                //obj.Early = "15,18,29,12,15,18,29,12,15,18,29,12";
                //obj.Absent = "20,12,26,12,20,12,26,12,20,12,26,12";
                //obj.Leave = "0,0,0,0,0,12,0,0,0,0,0,0";
                //obj.Average = "20,16,23,12,20,16,23,12,20,16,23,12";


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
        //*********End Of GetTrendsPercentage Function*********//
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

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

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

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
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_MYDailytimeAttendence", ht));
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
                new ExceptionLog().WriteLog("RequestPages/DashboardPage.aspx.GetMyViolations()", 0, ex);
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

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
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_MYDailytimeAttendence", ht));
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

                    if (type != "Absent" && type != "Leave" && type !="missed in")
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

        #region GetAttendanceActivity
        /// <summary>
        /// GetAttendanceActivity function
        /// Get Attendance Activity
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetAttendanceActivity()
        {
            string dt = (Request["dt"] + "").Trim();
            string ActivityLastTransactionTime =  (Request["activityLastTransactionTime"] + "").Trim();
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

               
                foreach (DataRowView obj in objDataView)
                {

                    object tempObj = new {
                                     Transaction_Time = DateTime.Parse(obj["Transaction_Time"]+"").ToString("yyyy-MM-dd HH:mm:ss"),
                                     Ddate=(obj["Ddate"] + "") == "" ? "" : Numerics.GetDateTime(obj["Ddate"] + "").ToString(AppSetting.dateFormat),
                                     EmployeeId=(obj["Employee_Id"] + ""),
                                     EmployeeName=(obj["EmployeeName"] + ""),
                                     ReasonId = (obj["ReasonId"] + ""),
                                     ReasonDesc=(obj["Reason"] + ""),
                                     ReasonMode = (obj["ReasonMode"] + "")
                                     };
                    tempList.Add(tempObj);
                    //json.aaData.Add(tempObj);
                }
                //if (json.iTotalDisplayRecords == 0)
                //{
                //    List<string> tempList = new List<string>();
                //    tempList.Add("&nbsp;");
                //    tempList.Add("&nbsp;");
                //    tempList.Add("&nbsp;");
                //    tempList.Add("&nbsp;");
                //    tempList.Add("&nbsp;");
                //    tempList.Add("&nbsp;");

                //    json.aaData.Add(tempList);
                //}
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



        #region LoadReaderTransactions
        /// <summary>
        /// LoadReaderTransactions function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetReaderTransactionsCount()
        {
            IList<Reader> ReaderList = new List<Reader>();
            DBAppSetting AppStng = new DBAppSetting();
            string DefaultLocation = "";
            string location = "";
            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DefaultLocation =  AppStng.GetDefaultLocation(Session["ID"] + "",Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "GetReaderTransactionsCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

                if (dv != null)
                {
                    foreach (DataRowView row in dv)
                    {
                        Reader obj = new Reader();
                        obj.NameEn = (row["reader_Name"] + "").Trim();
                        if ((row["reader_location"] + "").Trim() != "")
                        {
                            location = (row["reader_location"] + "").Trim();
                        }
                        else
                        {
                            location = DefaultLocation;
                        }
                        string[] str = location.Split(',');
                        obj.Latitude = decimal.Round(Numerics.GetDecimal( str[0].Trim()),5);
                        obj.Longitude = decimal.Round(Numerics.GetDecimal(str[1].Trim()),5);
                        ReaderList.Add(obj);
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
            return new JavaScriptSerializer().Serialize(ReaderList);
        }
        //*********End Of GetAll Function*********//
        #endregion

    }
}
