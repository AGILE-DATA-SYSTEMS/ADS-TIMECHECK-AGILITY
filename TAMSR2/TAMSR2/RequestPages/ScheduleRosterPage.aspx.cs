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
    public partial class ScheduleRosterPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/ScheduleRosterPage.aspx"));


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
                languagePostfix = "_arb";
            else
                languagePostfix = "_eng";

            string data = "";

            if (Session["ID"] + "" == "")
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "save")
            {
                data = Save();
            }
            else if (Request["key"] + "" == "finalizeRoster")
            {
                data = FinalizeRoster();
            }
            else if (Request["key"] + "" == "unfinalizeRoster")
            {
                data = UnFinalizeRoster();
            }
            else if (Request["key"] + "" == "getAll")
            {
                data = GetAll();
            }
            else if (Request["key"] + "" == "getAllRecordsGrid")
            {
                data = GetAllRecordsGrid();
            }
            else if (Request["key"] + "" == "getMyMonthlyRecords")
            {
                data = GetMyAllRecordsGrid();
            }
            else if (Request["key"] + "" == "getAllTags")
            {
                data = GetAllTags();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByID();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if (Request["key"] + "" == "getIdNameListString")
            {
                data = GetIdNameListString();
            }
            else if (Request["key"] + "" == "borrowEmployee")
            {
                data = BorrowEmployee();
            }
            else if (Request["key"] + "" == "getVersionList")
            {
                data = GetAllVersionsOfSelectedFilters();
            }
            else if (Request["key"] + "" == "saveBorrowEmp")
            {
                data = SaveBorrowEmployee();
            }
            else if (Request["key"] + "" == "copyRosterVersion")
            {
                data = CopyRosterVersion();
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


        #region GetByID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByID()
        {
            string id = "0";
            try
            {
                id = Encryption.Decrypt(Request["id"] + "");
            }
            catch (Exception ex)
            {
                id = Request["id"] + "";
            }
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            ScheduleTime obj = new ScheduleTime();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(id));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["schedule_id"]);
                    obj.OrgID = Numerics.GetDecimal(dv[0]["organization_id"]);
                    obj.SchLocationID = Numerics.GetInt(dv[0]["schedule_location_id"] + "");

                    obj.OpenShift = Numerics.GetInt(dv[0]["open_shift"] + "");
                    obj.NightShift = Numerics.GetInt(dv[0]["night_shift"] + "");
                    obj.FlexibleMinutes = Numerics.GetInt(dv[0]["flexible_min"] + "");
                    obj.GraceInMinutes = Numerics.GetInt(dv[0]["grace_in_min"] + "");
                    obj.GraceOutMinutes = Numerics.GetInt(dv[0]["grace_out_min"] + "");

                    obj.Code = dv[0]["schedule_code"] + "";
                    obj.SchColor = dv[0]["sch_color"] + "";

                    obj.InTime1 = (dv[0]["in_time1"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time1"] + "").ToString("HH:mm"));
                    obj.OutTime1 = (dv[0]["out_time1"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time1"] + "").ToString("HH:mm"));
                    obj.InTime2 = (dv[0]["in_time2"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time2"] + "").ToString("HH:mm"));
                    obj.OutTime2 = (dv[0]["out_time2"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time2"] + "").ToString("HH:mm"));
                    obj.InTime3 = (dv[0]["in_time3"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time3"] + "").ToString("HH:mm"));
                    obj.OutTime3 = (dv[0]["out_time3"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time3"] + "").ToString("HH:mm"));

                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_date"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["last_updated_id"]);
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



        #region GetIdNameListString
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string permissionTypeStr = (String)GetGlobalResourceObject("Resource", "permissionType");

                sb.Append("<option value=''>" + chooseStr + " " + permissionTypeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    PermissionType obj = new PermissionType();
                    obj.ID = Numerics.GetDecimal(row["schedule_id"] + "");
                    obj.DescriptionEn = row["description_eng"] + "";
                    obj.DescriptionAr = row["description_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.DescriptionAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.DescriptionEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
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
                int count = Numerics.GetInt(Request["count"] + "");
                string ids = "";
                for (int k = 1; k <= count; k++)
                {
                    ids += Request["chk" + k] + ",";
                }
                ids = ids.TrimEnd(',');
                Hashtable ht = new Hashtable();
                ht.Add("action", "deleteByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ScheduleRosterOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region CopyRosterVersion
        /// <summary>
        /// CopyRosterVersion function
        /// </summary>
        /// <returns>it will return 1 if successfully roster copied 0 incase of roster copy failed.</returns>
        public string CopyRosterVersion()
        {
            string chk = "0";
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                string versionNo = Request["versionNo"] + "";
                string year = Request["year"] + "";
                string month = Request["month"] + "";
                string copyRosterYear = Request["copyRosterYear"] + "";
                string copyRosterMonth = Request["copyRosterMonth"] + "";
                if (copyRosterYear == "" || copyRosterMonth == "")
                    return "0";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";
                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + noOfDays;

                int noOfDaysCopyRoster = DateTime.DaysInMonth(Numerics.GetInt(copyRosterYear), Numerics.GetInt(copyRosterMonth));
                string fromDateCopyRoster = copyRosterYear + "-" + copyRosterMonth + "-" + "01";
                string toDateCopyRoster = copyRosterYear + "-" + copyRosterMonth + "-" + noOfDaysCopyRoster;

                Hashtable ht = new Hashtable();
                ht.Add("action", "copyRosterVersion");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("mgrID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("versionNo", versionNo);
                ht.Add("fromDateCopyRoster", fromDateCopyRoster);
                ht.Add("toDateCopyRoster", toDateCopyRoster);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRosterOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of GetAll Function*********//
        #endregion

        #region GetAllTags
        /// <summary>
        /// Get All Tags function
        /// Get all schedules from schedules table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllTags()
        {
            TAMSR2Data objDAL = new TAMSR2Data();

            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = 0;
                int end = 30;

                double schWorkHours = 0;
                string fromTimeStr = "";
                string toTimeStr = "";

                string[] cols = { "sch.schedule_id", "sch.schedule_code", "sch.schedule_color", "org.description" + languagePostfix, "schLocation.description" + languagePostfix, "in_time1", "out_time1", "in_time2", "out_time2", "in_time3", "out_time3", "per.last_updated_time", "per.schedule_id" };

                string orderByClause = " sch.schedule_code ";

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", "");
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterOps", ht);

                foreach (DataRowView obj in objDataView)
                {
                    string code = (obj["schedule_code"] + "").Trim();
                    string color = (obj["sch_color"] + "").Trim();
                    string id = (obj["schedule_id"] + "").Trim();
                    fromTimeStr = obj["in_time1"] + "";
                    toTimeStr = obj["out_time1"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    fromTimeStr = obj["in_time2"] + "";
                    toTimeStr = obj["out_time2"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    fromTimeStr = obj["in_time3"] + "";
                    toTimeStr = obj["out_time3"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    if (schWorkHours < 0)
                        schWorkHours = 0;
                    schWorkHours -= Convert.ToInt32(obj["Break_Hours"]);

                    string attr = " id='" + id + "' schId='" + id + "' color='" + color + "' code='" + code + "' schmin='" + Numerics.GetLong(schWorkHours) + "' schhrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(schWorkHours)) + "' ";
                    sb.Append("<span id='spnSchedule" + id + "' " + attr + " class='draggable' style='color: #FFF; background-color:" + color + ";'>");
                    sb.Append(code);
                    sb.Append("</span>");
                    sb.Append(" &nbsp; &nbsp; ");
                    schWorkHours = 0;
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllVersionsOfSelectedFilters
        /// <summary>
        /// GetAllVersionsOfSelectedFilters function
        /// Get all version no from SCHEDULE_MONTHLY_ROSTER table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllVersionsOfSelectedFilters()
        {
            StringBuilder sb = new StringBuilder();
            TAMSR2Data objDAL = new TAMSR2Data();
            Hashtable ht;
            
            string orgID = Request["orgID"] + "";
            string empID = Request["empID"] + ""; 

            string year = Request["year"] + "";
            string month = Request["month"] + "";
            if (year == "")
                year = DateTime.Now.Year + "";
            if (month == "")
                month = DateTime.Now.Month + "";
            int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
            string fromDate = year + "-" + month + "-" + "01";
            string toDate = year + "-" + month + "-" + noOfDays;

            DataView objDataView;
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                
                ht = new Hashtable();
                ht.Add("action", "getVersionList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID); 
                ht.Add("empID", empID);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                objDataView = new DataView();
                objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterOps", ht);

                foreach (DataRowView obj in objDataView)
                {
                    sb.Append("<option value='" + obj["version_no"] + "'>" + obj["version_no"] + "</option>");
                }
                if (sb.Length <= 0)
                    sb.Append("<option value=''></option>");
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.GetAllVersionsOfSelectedFilters()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }

            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllRecordsGrid
        /// <summary>
        /// GetAllRecordsGrid function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllRecordsGrid()
        {
            StringBuilder sb = new StringBuilder();
            TAMSR2Data objDAL = new TAMSR2Data();

            string year = Request["year"] + "";
            string month = Request["month"] + "";
            if (year == "")
                year = DateTime.Now.Year + "";
            if (month == "")
                month = DateTime.Now.Month + "";
            int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
            string fromDate = year + "-" + month + "-" + "01";
            string toDate = year + "-" + month + "-" + noOfDays;
            
            List<IdName> schColorList = new ScheduleTime().GetSchColorList(Session["ID"] + "");
            List<IdDateRangeList> empLeavesList = new EmployeeLeave().GetEmployeeLeavesByMonth(Session["ID"] + "", fromDate, toDate);
            List<IdDateRangeList> holidayList = new Holiday().GetHolidaysByMonth(Session["ID"] + "", fromDate, toDate);
            List<ScheduleTime> schList = new ScheduleTime().GetAllSchList(Session["ID"] + "");
            Hashtable ht;
            int start = Numerics.GetInt(Request["iDisplayStart"]);
            int end = Numerics.GetInt(Request["iDisplayLength"]);
            string orgID = Request["orgID"] + "";
            string empID = Request["empID"] + "";
            string managerID = Request["managerID"] + "";

            DateTime dtStartDate = Numerics.GetDateTime(fromDate);

            string workingDayEmployees = (Request["workingDayEmployees"] + "").Trim();
            string groupID = (Request["groupID"] + "").Trim();

            string[] cols = { "employee_id", "name" + languagePostfix, "code" };
            string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];
            
            long employeeWorkHours = 0;
            long tempSchWorkHours = 0;
            decimal schID = -1;
            DataView objDataView;

            string tempSchColor = "";
            string tempSchCode = "";
            string managerCode = "";
            string desigCode = "";
            string holidayOverwrite = "";
            string leaveOverwrite = "";
            string rosterGroupBy = "";
            string TimeIN1 = "";
             string TimeOut1= "";
             string TimeIN2 = "";
            string TimeOut2 = "";
            string TimeIN3 = "";
            string TimeOut3 = "";
            string SchTime = "";
            string showUnfinalizeButton = "0";
            
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                orderByClause = " name" + languagePostfix  + " ";

                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("empID", empID);
                ht.Add("mgrID", managerID);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                ht.Add("versionNo", (Request["version"] + "").Trim());
                ht.Add("workingDayEmployees", workingDayEmployees);
                ht.Add("groupID", groupID);
                objDataView = new DataView();
                objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterOps", ht);

                foreach (DataRowView obj in objDataView)
                {
                    holidayOverwrite = (obj["HolidayOverwrite"] + "").Trim() == "1" ? "droppable" : "";
                    leaveOverwrite = (obj["LeaveOverwrite"] + "").Trim() == "1" ? "droppable" : "";
                    rosterGroupBy = (obj["RosterGroupBy"] + "").Trim().Replace("_Code,", "");
                    
                    if (managerCode != (obj["manager_code"] + "").Trim())
                    {
                        managerCode = (obj["manager_code"] + "").Trim();
                        sb.Append("<tr>");
                        sb.Append("<th style='background-color: #878787; line-height: normal;' colspan='37'>" + (obj["manager_code"] + "").Trim() + "  -  " + (obj["manager_name" + languagePostfix] + "").Trim() + "</th>");
                        sb.Append("</tr>");
                        if (rosterGroupBy != "" && rosterGroupBy.ToLower() != "none" && desigCode == (obj[rosterGroupBy + "_code"] + "").Trim())
                        {
                            sb.Append("<tr>");
                            sb.Append("<th style='background-color: #B3B3B3; padding-left: 40px; line-height: normal;' colspan='37'><span style='width:40px;'>&nbsp;</span>" + (obj[rosterGroupBy + "_code"] + "").Trim() + "  -  " + (obj[rosterGroupBy + languagePostfix] + "").Trim() + "</th>");
                            sb.Append("</tr>");
                        }
                    }
                    if (rosterGroupBy != "" && rosterGroupBy.ToLower() != "none" && desigCode != (obj[rosterGroupBy + "_code"] + "").Trim())
                    {
                        desigCode = (obj[rosterGroupBy + "_code"] + "").Trim();
                        sb.Append("<tr>");
                        sb.Append("<th style='background-color: #B3B3B3; padding-left: 40px; line-height: normal; max-height:15px !important; max-width: 10px !important;' colspan='37'><span style='width:40px;'>&nbsp;</span>" + (obj[rosterGroupBy + "_code"] + "").Trim() + "  -  " + (obj[rosterGroupBy + languagePostfix] + "").Trim() + "</th>");
                        sb.Append("</tr>");
                    }
                    sb.Append("<tr id='sample_1_" + obj["EID"] + "' eid='" + obj["EID"] + "'>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important;  max-height:15px !important; max-width: 10px !important;'>");
                    //sb.Append("<div class='checker' id='uniform-undefined'><span>");
                    sb.Append("<input type='checkbox' class='checkboxes' id='chk_1_" + obj["EID"] + "' value='" + Numerics.GetDecimal(obj["EID"]) + "'  style=''></span></div>");
                    sb.Append(" </td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; max-height:15px !important; max-width: 10px !important; '>" + obj["code"] + "</td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; max-height:15px !important; max-width: 10px !important; '>" + ((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + "")) + "</td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important;  max-height:15px !important; max-width: 10px !important;'>" + obj["version_no"] + "</td>");

                    if (obj["finalizeflag"] + "" == "1")
                    {

                        sb.Append("<td class='ui-droppable'><i class='icon-lock'></td>");
                        showUnfinalizeButton = "1";

                        // r.spnUnfinalizeButton.Visible = true;
                    }
                    else
                    {
                        sb.Append("<td class='ui-droppable'><i class='icon-unlock'></td>");
                        showUnfinalizeButton = "0";

                    }
                    int k = 1;
                    employeeWorkHours = 0;
                    dtStartDate = Numerics.GetDateTime(fromDate);
                    string FullSchCode = string.Empty;
                    while (k <= 31)
                    {
                        schID = -1;
                        schID = (obj["D" + k] + "" != "") ? Numerics.GetDecimal(obj["D" + k] + "") : -1;
                        tempSchColor = schID != -1 ? ("background-color: " + schColorList.FirstOrDefault(p => p.ID == schID).Name) : "";
                        FullSchCode = schID != -1 ? (schColorList.FirstOrDefault(p => p.ID == schID).Code) : "";
                        try
                        {
                            tempSchCode = schID != -1 ? (schColorList.FirstOrDefault(p => p.ID == schID).Code) : "";
                            if(tempSchCode.Length > 3)
                                tempSchCode = tempSchCode.Substring(0, 3);

                             TimeIN1 = schID != -1 ? (schList.FirstOrDefault(p => p.ID == schID).InTime1) : "";
                             TimeOut1 = schID != -1 ? (schList.FirstOrDefault(p => p.ID == schID).OutTime1) : "";
                             TimeIN2 = schID != -1 ? (schList.FirstOrDefault(p => p.ID == schID).InTime2) : "";
                             TimeOut2 = schID != -1 ? (schList.FirstOrDefault(p => p.ID == schID).OutTime2) : "";
                             TimeIN3 = schID != -1 ? (schList.FirstOrDefault(p => p.ID == schID).InTime3) : "";
                             TimeOut3 = schID != -1 ? (schList.FirstOrDefault(p => p.ID == schID).OutTime3) : "";
                             SchTime = "";

                            SchTime = TimeIN1 + " " + TimeOut1 + " " + TimeIN2 + " " + TimeOut2 + " " + TimeIN3 + " " + TimeOut3;
                            SchTime = SchTime.Trim();

                        }
                        catch(Exception ex)
                        {
                        }
                      
                            FullSchCode = FullSchCode + " (" +SchTime + ")";        
                        if (k > noOfDays)
                        {
                            sb.Append("<td id='td_" + obj["EID"] + "_" + k + "' colspan='" + (32 - k) + "' d='" + k + "' schId='-1' code='' schHrs='0' schMin='0' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC; max-height:15px !important; max-width: 10px !important;'> &nbsp; </td>");
                            //sb.Append("<td id='td_" + obj["EID"] + "_" + k + "' colspan='" + (32 - k) + "' d='" + k + "' schId='-1' code='' schHrs='0' schMin='0' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC;'>" + obj["D" + k] + "</td>");
                            break;
                        }
                        else
                        {
                            if (schID != -1)
                            {
                                employeeWorkHours += Numerics.GetLong(schColorList.FirstOrDefault(p => p.ID == schID).value);
                                tempSchWorkHours = Numerics.GetLong(schColorList.FirstOrDefault(p => p.ID == schID).value);
                            }
                            else
                            {
                                tempSchWorkHours = 0;
                            }

                            if (empLeavesList.FirstOrDefault(p => p.ID == Numerics.GetDecimal(obj["EID"] + "") && p.FromDate.Date <= dtStartDate.Date && p.ToDate.Date >= dtStartDate.Date) != null)
                            {
                                sb.Append("<td  title = '" + FullSchCode + "' id='td_" + obj["EID"] + "_" + k + "' class='" + leaveOverwrite + "' d='" + k + "' code='' schMin='" + 0 + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(0)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important; max-height:15px !important; max-width: 10px !important; color: Black !important; " + tempSchColor + "'>L</td>");
                                employeeWorkHours -= tempSchWorkHours;
                            }
                            else if (holidayList.FirstOrDefault(p => p.FromDate.Date <= dtStartDate.Date && p.ToDate.Date >= dtStartDate.Date) != null  )
                            {
                                if (obj["HolidayOverwrite"] + "" != "1")
                                {
                                    sb.Append("<td  title = '" + FullSchCode + "' id='td_" + obj["EID"] + "_" + k + "' class='" + holidayOverwrite + "' d='" + k + "' code='' schMin='" + 0 + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(0)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important;  max-height:15px !important; max-width: 10px !important; color: Black !important; " + tempSchColor + "'>H</td>");
                                    employeeWorkHours -= tempSchWorkHours;
                                }
                                else
                                {
                                    sb.Append("<td title = '" + FullSchCode + "' id='td_" + obj["EID"] + "_" + k + "' class='droppable' d='" + k + "' code='' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important;  max-height:15px !important; max-width: 10px !important; color: Black !important; " + tempSchColor + "'>H</td>");
                                }
                                
                            }
                            else
                            {
                                sb.Append("<td title = '" + FullSchCode + "' id='td_" + obj["EID"] + "_" + k + "' class='droppable' d='" + k + "' code='' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important; " + tempSchColor + "'>" + tempSchCode + "</td>");
                            }
                        }
                        dtStartDate = dtStartDate.AddDays(1);
                        k++;
                    }
                    sb.Append("<td class='totalWorkHours' schmin='" + employeeWorkHours + "' style='color: Blue; font-weight: bold;'>" + Numerics.FormatMinsToHHmm(employeeWorkHours) + "</td>");
                    
                    sb.Append("</tr>");
                }
                if (sb.Length <= 0)
                    sb.Append("<tr><td colspan='35'> &nbsp; </td></tr>");
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }

            try
            {
                ht = new Hashtable();
                ht.Add("action", "getAllApprovedRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("borrowerID", Session["ID"] + "");
                ht.Add("statusFlag", 0);
                ht.Add("empID", empID);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                objDataView = new DataView();
                objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);

                employeeWorkHours = 0;
                tempSchWorkHours = 0;
                schID = -1;

                foreach (DataRowView obj in objDataView)
                {
                    sb.Append("<tr id='sample_1_" + obj["EID"] + "' eid='" + obj["EID"] + "'>");
                    sb.Append("<td style='background-color: #D6698E; padding: 3px !important; line-height: 15px !important; '>");
                    //sb.Append("<div class='checker' id='uniform-undefined'><span>");
                    //sb.Append("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["schedule_roster_id"]) + "'  style=''></span></div>");
                    sb.Append(" </td>");
                    sb.Append("<td style='background-color: #D6698E; padding: 3px !important; line-height: 15px !important; '>" + obj["code"] + "</td>");
                    sb.Append("<td style='background-color: #D6698E; padding: 3px !important; line-height: 15px !important; '>" + ((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + "")) + "</td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + obj["version_no"] + "</td>");
                    int k = 1;
                    employeeWorkHours = 0;
                    while (k <= 31)
                    {
                        schID = -1;
                        schID = (obj["D" + k] + "" != "") ? Numerics.GetDecimal(obj["D" + k] + "") : -1;
                        string tempColor = schID != -1 ? ("background-color: " + schColorList.FirstOrDefault(p => p.ID == schID).Name) : "";
                        if (k > noOfDays)
                        {
                            sb.Append("<td colspan='" + (32 - k) + "' d='" + k + "' schId='-1' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC;'> &nbsp; </td>");
                            //sb.Append("<td colspan='" + (32 - k) + "' d='" + k + "' schId='-1' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC;'>" + obj["D" + k] + "</td>");
                            break;
                        }
                        else
                        {
                            if (schID != -1)
                            {
                                employeeWorkHours += Numerics.GetLong(schColorList.FirstOrDefault(p => p.ID == schID).value);
                                tempSchWorkHours = Numerics.GetLong(schColorList.FirstOrDefault(p => p.ID == schID).value);
                            }
                            else
                            {
                                tempSchWorkHours = 0;
                            }
                            sb.Append("<td d='" + k + "' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='color: White; text-align: center !important; padding: 3px !important; line-height: 15px !important; " + tempColor + "'>&nbsp;</td>");
                        }
                        k++;
                    }
                    sb.Append("<td class='_totalWorkHours' schmin='" + employeeWorkHours + "' style='color: Blue; font-weight: bold;'>" + Numerics.FormatMinsToHHmm(employeeWorkHours) + "</td>");
                    sb.Append("</tr>");
                }
                if (sb.Length <= 0)
                    sb.Append("<tr><td colspan='35'> &nbsp; </td></tr>");
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.GetAll()->load-borrow->", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetMyAllRecordsGrid
        /// <summary>
        /// GetMyAllRecordsGrid function
        /// Get all my records from TAMSR2_Schedule_Monthly_Roster and TAMSR2_Schedule_Roster_Borrow tables
        /// </summary>
        /// <returns>it will return html string for Schedule_Monthly_Roster Grid</returns>
        public string GetMyAllRecordsGrid()
        {
            StringBuilder sb = new StringBuilder();
            TAMSR2Data objDAL = new TAMSR2Data();

            int start = Numerics.GetInt(Request["iDisplayStart"]);
            int end = Numerics.GetInt(Request["iDisplayLength"]);
            string orgID = Request["orgID"] + "";
            string empID = ""; // Session["ID"] + "";
            if ((Request["empID"] + "").Trim() != "")
                empID = (Request["empID"] + "").Trim();
            string year = Request["year"] + "";
            string month = Request["month"] + "";
            if (year == "")
                year = DateTime.Now.Year + "";
            if (month == "")
                month = DateTime.Now.Month + "";
            int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
            string fromDate = year + "-" + month + "-" + "01";
            string toDate = year + "-" + month + "-" + noOfDays;
            
            List<IdName> schColorList = new ScheduleTime().GetSchColorList(Session["ID"] + "");
            List<IdDateRangeList> empLeavesList = new EmployeeLeave().GetEmployeeLeavesByMonth(Session["ID"] + "", fromDate, toDate);
            List<IdDateRangeList> holidayList = new Holiday().GetHolidaysByMonth(Session["ID"] + "", fromDate, toDate);
            List<ScheduleTime> schList = new List<ScheduleTime>();
            Hashtable ht;
            
            DateTime dtStartDate = Numerics.GetDateTime(fromDate);
     
            string[] cols = { "employee_id", "name" + languagePostfix, "code" };
            string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

            long employeeWorkHours = 0;
            long tempSchWorkHours = 0;
            decimal schID = -1;
            DataView objDataView;

            string tempSchColor = "";
            string tempSchCode = "";
            string managerCode = "";
            string desigCode = "";
            string holidayOverwrite = "";
            string leaveOverwrite = "";
            string rosterGroupBy = "";
            
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                orderByClause = " name" + languagePostfix + " ";

                ht = new Hashtable();
                ht.Add("action", "getMyMonthlyRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("empID", empID);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                objDataView = new DataView();
                objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterOps", ht);

                foreach (DataRowView obj in objDataView)
                {
                    holidayOverwrite = (obj["HolidayOverwrite"] + "").Trim() == "1" ? "droppable" : "";
                    leaveOverwrite = (obj["LeaveOverwrite"] + "").Trim() == "1" ? "droppable" : "";
                    rosterGroupBy = (obj["RosterGroupBy"] + "").Trim().Replace("_Code,", "");
                    
                    if (managerCode != (obj["manager_code"] + "").Trim())
                    {
                        managerCode = (obj["manager_code"] + "").Trim();
                        sb.Append("<tr>");
                        sb.Append("<th style='background-color: #878787; line-height: normal;' colspan='36'>" + (obj["manager_code"] + "").Trim() + "  -  " + (obj["manager_name" + languagePostfix] + "").Trim() + "</th>");
                        sb.Append("</tr>");
                        if (rosterGroupBy != "" && rosterGroupBy.ToLower() != "none" && desigCode == (obj[rosterGroupBy + "_code"] + "").Trim())
                        {
                            sb.Append("<tr>");
                            sb.Append("<th style='background-color: #B3B3B3; padding-left: 40px; line-height: normal;' colspan='36'><span style='width:40px;'>&nbsp;</span>" + (obj[rosterGroupBy + "_code"] + "").Trim() + "  -  " + (obj[rosterGroupBy + languagePostfix] + "").Trim() + "</th>");
                            sb.Append("</tr>");
                        }
                    }
                    if (rosterGroupBy != "" && rosterGroupBy.ToLower() != "none" && desigCode != (obj[rosterGroupBy + "_code"] + "").Trim())
                    {
                        desigCode = (obj[rosterGroupBy + "_code"] + "").Trim();
                        sb.Append("<tr>");
                        sb.Append("<th style='background-color: #B3B3B3; padding-left: 40px; line-height: normal;' colspan='36'><span style='width:40px;'>&nbsp;</span>" + (obj[rosterGroupBy + "_code"] + "").Trim() + "  -  " + (obj[rosterGroupBy + languagePostfix] + "").Trim() + "</th>");
                        sb.Append("</tr>");
                    }
                    sb.Append("<tr id='sample_1_" + obj["EID"] + "' eid='" + obj["EID"] + "'>");
                    //sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>");
                    ////sb.Append("<div class='checker' id='uniform-undefined'><span>");
                    //sb.Append("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["schedule_roster_id"]) + "'  style=''></span></div>");
                    //sb.Append(" </td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + obj["code"] + "</td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + ((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + "")) + "</td>");
                    int k = 1;
                    employeeWorkHours = 0;
                    dtStartDate = Numerics.GetDateTime(fromDate);
                    while (k <= 31)
                    {
                        schID = -1;
                        schID = (obj["D" + k] + "" != "") ? Numerics.GetDecimal(obj["D" + k] + "") : -1;
                        tempSchColor = schID != -1 ? ("background-color: " + schColorList.FirstOrDefault(p => p.ID == schID).Name) : "";
                        tempSchCode = schID != -1 ? (schColorList.FirstOrDefault(p => p.ID == schID).Code.Substring(0, 3)) : "";
                        if (k > noOfDays)
                        {
                            sb.Append("<td colspan='" + (32 - k) + "' d='" + k + "' schId='-1' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC;'>" + obj["D" + k] + "</td>");
                            break;
                        }
                        else
                        {
                            if (schID != -1)
                            {
                                employeeWorkHours += Numerics.GetLong(schColorList.FirstOrDefault(p => p.ID == schID).value);
                                tempSchWorkHours = Numerics.GetLong(schColorList.FirstOrDefault(p => p.ID == schID).value);
                            }
                            else
                            {
                                tempSchWorkHours = 0;
                            }
                            string dtf = dtStartDate.ToString("mm/dd/yyyy");

                            if (empLeavesList.FirstOrDefault(p => p.ID == Numerics.GetDecimal(obj["EID"] + "") && p.FromDate.Date <= dtStartDate.Date && p.ToDate.Date >= dtStartDate.Date) != null)
                            {
                                sb.Append("<td d='" + k + "' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='color: " + (tempSchColor == "" ? "Black" : "White") + "; padding: 3px !important; line-height: 15px !important; " + tempSchColor + "'> " + tempSchCode + " </td>");
                            }
                            else if (holidayList.FirstOrDefault(p => p.FromDate.Date <= dtStartDate.Date && p.ToDate.Date >= dtStartDate.Date) != null)
                            {
                                sb.Append("<td d='" + k + "' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='color: " + (tempSchColor == "" ? "Black" : "White") + "; padding: 3px !important; line-height: 15px !important; " + tempSchColor + "'> H </td>");
                            }
                            else
                            {
                                sb.Append("<td d='" + k + "' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='color: White; padding: 3px !important; line-height: 15px !important; " + tempSchColor + "'> " + tempSchCode + " </td>");
                            }
                            
                        }
                        dtStartDate = dtStartDate.AddDays(1);
                        k++;
                    }
                    sb.Append("<td class='totalWorkHours' schmin='" + employeeWorkHours + "' style='color: Blue; font-weight: bold;'>" + Numerics.FormatMinsToHHmm(employeeWorkHours) + "</td>");
                    sb.Append("</tr>");
                }
                if (sb.Length <= 0)
                    sb.Append("<tr><td colspan='35'> &nbsp; </td></tr>");
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }

            try
            {
                ht = new Hashtable();
                ht.Add("action", "getMyMonthlyRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("statusFlag", 1);
                ht.Add("empID", empID);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                objDataView = new DataView();
                objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);

                employeeWorkHours = 0;
                tempSchWorkHours = 0;
                schID = -1;

                foreach (DataRowView obj in objDataView)
                {
                    sb.Append("<tr id='sample_1_" + obj["EID"] + "' eid='" + obj["EID"] + "'>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>");
                    //sb.Append("<div class='checker' id='uniform-undefined'><span>");
                    sb.Append("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["schedule_roster_id"]) + "'  style=''></span></div>");
                    sb.Append(" </td>");
                    sb.Append("<td style='background-color: #D6698E; padding: 3px !important; line-height: 15px !important; '>" + obj["code"] + "</td>");
                    sb.Append("<td style='background-color: #D6698E; padding: 3px !important; line-height: 15px !important; '>" + ((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + "")) + "</td>");
                    int k = 1;
                    employeeWorkHours = 0;
                    while (k <= 31)
                    {
                        schID = -1;
                        schID = (obj["D" + k] + "" != "") ? Numerics.GetDecimal(obj["D" + k] + "") : -1;
                        string tempColor = schID != -1 ? ("background-color: " + schColorList.FirstOrDefault(p => p.ID == schID).Name) : "";
                        if (k > noOfDays)
                        {
                            sb.Append("<td colspan='" + (32 - k) + "' d='" + k + "' schId='-1' eid='" + obj["EID"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC;'>" + obj["D" + k] + "</td>");
                            break;
                        }
                        else
                        {
                            if (schID != -1)
                            {
                                employeeWorkHours += Numerics.GetLong(schColorList.FirstOrDefault(p => p.ID == schID).value);
                                tempSchWorkHours = Numerics.GetLong(schColorList.FirstOrDefault(p => p.ID == schID).value);
                                sb.Append("<td d='" + k + "' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' eid='" + obj["EID"] + "' style='color: White; text-align: center !important; padding: 3px !important; line-height: 15px !important; " + tempColor + "'> &nbsp; </td>");
                            }
                            else
                            {
                                tempSchWorkHours = 0;
                                sb.Append("<td d='" + k + "' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='' eid='" + obj["EID"] + "' style='color: White; padding: 3px !important; line-height: 15px !important; background-color: #CCC;'> &nbsp; </td>");
                            }
                        }
                        k++;
                    }
                    sb.Append("<td class='_totalWorkHours' schmin='" + employeeWorkHours + "' style='color: Blue; font-weight: bold;'>" + Numerics.FormatMinsToHHmm(employeeWorkHours) + "</td>");
                    sb.Append("</tr>");
                }
                if (sb.Length <= 0)
                    sb.Append("<tr><td colspan='35'> &nbsp; </td></tr>");
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.GetAll()->load-borrow->", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
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
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);
                string orgID = Request["orgID"] + "";
                
                string year = Request["year"] + "";
                string month = Request["month"] + "";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";
                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + (noOfDays - 1);

                string[] cols = { "employee_id", "name" + languagePostfix, "code" };
                
                

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRosterOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;
                /*
                { "sch.schedule_id", "sch.schedule_code", "sch.schedule_color", "schLocation.description" + languagePostfix, "org.description" + languagePostfix, "in_time1", "out_time1", "in_time2", "out_time2", "in_time3", "out_time3", "per.last_updated_time", "per.schedule_id" };

                */
                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_id"]) + "' />");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                    tempList.Add((obj["code"] + "").Length > 100 ? (obj["code"] + "").Substring(0, 100) + "..." : (obj["code"] + ""));
                    int k = 1;
                    while(k <= noOfDays || k <= 31)
                    {
                        tempList.Add(obj["D" + k] + "");
                        k++;
                    }
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.GetAll()", 0, ex);
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
            List<ScheduleRoster> roster = new List<ScheduleRoster>();
            int count = Numerics.GetInt(Request["count"] + "");
            string year = Request["year"] + "";
            string month = Request["month"] + "";
            if (year == "")
                year = DateTime.Now.Year + "";
            if (month == "")
                month = DateTime.Now.Month + "";
            int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
            string fromDate = year + "-" + month + "-" + "01";
            string toDate = year + "-" + month + "-" + noOfDays;
            List<IdName> empList = new List<IdName>();
            for (int k = 1; k < count; k++)
            {
                ScheduleRoster temp;
                string rowEID = ((Request["rowEID" + k] + "").Trim()).TrimEnd(',');
                string[] rowDays = ((Request["rowDay" + k] + "").Trim()).TrimEnd(',').Split(',');
                string[] rowSch = ((Request["rowSch" + k] + "").Trim()).TrimEnd(',').Split(',');
                int strLength = rowSch.Length;
                int index = 0;
                while (index < strLength)
                {
                    temp = new ScheduleRoster();
                    temp.EmpID = Numerics.GetInt(rowEID);
                    temp.Day = Numerics.GetDecimal(rowDays[index]);
                    temp.SchID = Numerics.GetDecimal(rowSch[index]);
                    if (empList.FirstOrDefault(p => p.ID == temp.EmpID) == null || empList.Count == 0)
                    {
                        if( temp.EmpID  != 0)
                             empList.Add(new IdName() { ID = temp.EmpID });
                    }
                    roster.Add(temp);
                    index++;
                }
                
                //temp.EmpID = Numerics.GetInt(Request["eid" + k] + "");
                //temp.Day = Numerics.GetDecimal(Request["d" + k] + "");
                //temp.SchID = Numerics.GetDecimal(Request["sch" + k] + "");
            }
             
            string chk = "0";

            string createdDateStr = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            string updatedDateStr = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            foreach (IdName emp in empList)
            {
                Hashtable ht = new Hashtable();
                ht.Add("action", "save");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("mgrID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("empID", emp.ID);
                ht.Add("createdBy", Session["ID"] + "");
                ht.Add("createdOn", createdDateStr);
                ht.Add("updatedBy", Session["ID"] + "");
                ht.Add("updatedOn", updatedDateStr);
                int j = 1;
                try
                {
                    decimal rosterEmpID = emp.ID;
                    List<ScheduleRoster> tempSchList = new List<ScheduleRoster>();
                    tempSchList.AddRange(roster.Where(p => p.EmpID == rosterEmpID).ToList());
                    foreach (ScheduleRoster obj in tempSchList)
                    {
                        ht.Add("d" + obj.Day, obj.SchID);
                        j++;
                    }
                }
                catch (Exception ex)
                {
                    int k = j;
                }

                TAMSR2Data objDAL = new TAMSR2Data();
                try
                {
                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRosterOps", ht);
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
                    new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.Save()", 0, ex);
                }
                finally
                {
                    objDAL.CloseConnection();
                }
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

        #region FinalizeRoster
        /// <summary>
        /// FinalizeRoster function
        /// Finalize Roster by Manager ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string FinalizeRoster()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                string year = Request["year"] + "";
                string month = Request["month"] + "";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";
                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + noOfDays;
                int count = Numerics.GetInt(Request["count"] + "");

                List<IdName> empList = new List<IdName>();

                ScheduleRoster temp1;
                string rowEID = ((Request["empID"] + "").Trim()).TrimEnd(',');
                string[] empEID = rowEID.Split(',');
                int strLength = empEID.Length;
                int index = 0;
                while (index < strLength)
                {
                    temp1 = new ScheduleRoster();
                    temp1.EmpID = Numerics.GetInt(empEID[index]);
                    if (empList.FirstOrDefault(p => p.ID == temp1.EmpID) == null || empList.Count == 0)
                    {
                        empList.Add(new IdName() { ID = temp1.EmpID });
                    }
                    index++;
                }

                //temp.EmpID = Numerics.GetInt(Request["eid" + k] + "");
                //temp.Day = Numerics.GetDecimal(Request["d" + k] + "");
                //temp.SchID = Numerics.GetDecimal(Request["sch" + k] + "");

                int temp = 0;
                int result = 0;
                foreach (IdName emp in empList)
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("action", "finalizeRoster");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("EmpID", emp.ID);
                    ht.Add("fromDate", fromDate);
                    ht.Add("toDate", toDate);

                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ScheduleRosterOps", ht);
                    if (temp > 0)
                        result = 1;
                }
                if (result > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.FinalizeRoster()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion

        #region UnFinalizeRoster
        /// <summary>
        /// FinalizeRoster function
        /// Finalize Roster by Manager ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string UnFinalizeRoster()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                string year = Request["year"] + "";
                string month = Request["month"] + "";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";
                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + noOfDays;
                int count = Numerics.GetInt(Request["count"] + "");

                List<IdName> empList = new List<IdName>();

                ScheduleRoster temp1;
                string rowEID = ((Request["empID"] + "").Trim()).TrimEnd(',');
                string[] empEID = rowEID.Split(',');
                int strLength = empEID.Length;
                int index = 0;
                while (index < strLength)
                {
                    temp1 = new ScheduleRoster();
                    temp1.EmpID = Numerics.GetInt(empEID[index]);
                    if (empList.FirstOrDefault(p => p.ID == temp1.EmpID) == null || empList.Count == 0)
                    {
                        empList.Add(new IdName() { ID = temp1.EmpID });
                    }
                    index++;
                }

                int temp = 0;
                foreach (IdName emp in empList)
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("action", "unfinalizeroster");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("EmpID", emp.ID);
                    ht.Add("fromDate", fromDate);
                    ht.Add("toDate", toDate);

                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ScheduleRosterOps", ht);
                }
                if (temp > 0)
                    return "1";
                else if (temp < 0)
                    return "-1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.UnFinalizeRoster()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region BorrowEmployee
        /// <summary>
        /// SaveBorrowEmployee function
        /// To save borrowed employee record in schedule_roster_borrow table
        /// </summary>
        /// <returns>it will return html string in success, empty string in case of failed </returns>

        public string BorrowEmployee()
        {
            string chk = "0";
            string remarks = Request["remarks"] + "";
            string year = Request["year"] + "";
            string month = Request["month"] + "";
            if (year == "")
                year = DateTime.Now.Year + "";
            if (month == "")
                month = DateTime.Now.Month + "";
            int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
            //string fromDate = year + "-" + month + "-" + "01";
            //string toDate = year + "-" + month + "-" + noOfDays;
            string fromDate = Request["fromDate"] + "";
            string toDate = Request["toDate"] + "";
            string empID = Request["empID"] + "";
            Employee objEmp = new Employee(Numerics.GetDecimal(empID), Session["ID"] + "", Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

            int tempFromDay = 0;
            int tempToDay = 0;
            try
            {
                tempFromDay = Convert.ToDateTime(fromDate).Day;
                tempToDay = Convert.ToDateTime(toDate).Day;
            }
            catch (Exception ex)
            {
                if (fromDate.Trim() != "")
                {
                    tempFromDay = Numerics.GetInt(fromDate.Substring(6, 2));
                }
                if (toDate.Trim() != "")
                {
                    tempToDay = Numerics.GetInt(toDate.Substring(6, 2));
                }
            }
            string createdDateStr = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            string updatedDateStr = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("fromDate", fromDate);
            ht.Add("toDate", toDate);
            ht.Add("empID", empID);
            ht.Add("versionNo", 1);
            ht.Add("statusFlag", 0);
            ht.Add("remarks", remarks);
            ht.Add("borrowerID", Session["ID"] + "");
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("createdOn", createdDateStr);
            ht.Add("updatedBy", Session["ID"] + "");
            ht.Add("updatedOn", updatedDateStr);

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    //chk = result;
                    StringBuilder sb = new StringBuilder();
                    try
                    {
                        sb.Append("<tr id='sample_2_" + objEmp.ID + "' eid='" + objEmp.ID + "'>");
                        sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>");
                        sb.Append("<div class='checker' id='uniform-undefined'><span>");
                        sb.Append("<input type='checkbox' class='checkboxes' value='" + objEmp.ID + "'  style='opacity: 0;'></span></div>");
                        sb.Append(" </td>");
                        sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + objEmp.Code + "</td>");
                        sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + (languagePostfix == "arb" ? objEmp.NameAr : objEmp.NameEn) + "</td>");
                        int k = 1;
                        while (k <= 31)
                        {
                            decimal schID = -1;
                            //schID = (obj["D" + k] + "" != "") ? Numerics.GetDecimal(obj["D" + k] + "") : -1;
                            string tempColor = ""; // schID != -1 ? ("background-color: " + schColorList.FirstOrDefault(p => p.ID == schID).Name) : "";

                            if (k > noOfDays)
                            {
                                sb.Append("<td colspan='" + (32 - k) + "' d='" + k + "' schId='-1' fromDate='" + fromDate + "' toDate='" + toDate + "' eid='" + objEmp.ID + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC;'>" + "" + "</td>");
                                break;
                            }
                            else if (k < tempFromDay || k > tempToDay)
                            {
                                sb.Append("<td d='" + k + "' schId='-1' fromDate='" + fromDate + "' toDate='" + toDate + "' eid='" + objEmp.ID + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC;'>" + "" + "</td>");
                            }
                            else
                            {
                                sb.Append("<td class='droppable' d='" + k + "' schMin='' schHrs='' schId='" + "" + "' fromDate='" + fromDate + "' toDate='" + toDate + "' eid='" + objEmp.ID + "' style='padding: 3px !important; line-height: 15px !important; " + tempColor + "'></td>");
                            }
                            k++;
                        }
                        sb.Append("<td class='totalWorkHours' schmin='0' style='color: Blue; font-weight: bold;'>" + "" + "</td>");
                        sb.Append("</tr>");
                        chk = sb.ToString();
                    }
                    catch (Exception ex)
                    {
                        chk = "";
                    }
                    finally
                    {
                    }
                }
                else
                {
                    //chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRosterPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

        #region SaveBorrowEmployee
        /// <summary>
        /// SaveBorrowEmployee function
        /// To save borrowed employee record in schedule_roster_borrow table
        /// </summary>
        /// <returns>it will return html string in success, empty string in case of failed </returns>

        public string SaveBorrowEmployee()
        {
            string chk = "0";
            string year = Request["year"] + "";
            string month = Request["month"] + "";
            if (year == "")
                year = DateTime.Now.Year + "";
            if (month == "")
                month = DateTime.Now.Month + "";
            int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
            string fromDate = year + "-" + month + "-" + "01";
            string toDate = year + "-" + month + "-" + noOfDays;

            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("descriptionEng", (Request["descriptionEn"] + "").Trim());
            ht.Add("descriptionArb", (Request["descriptionAr"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleLocationOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ScheduleLocationPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

    }
}