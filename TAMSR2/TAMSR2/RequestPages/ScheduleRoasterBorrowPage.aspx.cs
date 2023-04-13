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
    public partial class ScheduleRoasterBorrowPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/ScheduleRoasterBorrowPage.aspx"));


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
            else if (Request["key"] + "" == "getAll")
            {
                data = GetAll();
            }
            else if (Request["key"] + "" == "approve")
            {
                data = Approve();
            }
            else if (Request["key"] + "" == "reject")
            {
                data = Reject();
            }
            else if (Request["key"] + "" == "getAllRecordsGrid")
            {
                data = GetAllRecordsGrid();
            }
            else if (Request["key"] + "" == "getAllPendingApprovalRecordsGrid")
            {
                data = GetAllRecordsGridByManagerID();
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
            List<IdName> schColorList = new ScheduleTime().GetSchColorList(Session["ID"] + "");
            List<ScheduleTime> schList = new List<ScheduleTime>();
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);
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

                string[] cols = { "employee_id", "name" + languagePostfix, "code" };



                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];
                orderByClause = " name" + languagePostfix + " ";

                int tempFromDay = 0;
                int tempToDay = 0;
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);

                long employeeWorkHours = 0;
                long tempSchWorkHours = 0;
                decimal schID = -1;
                int k = 1;
                foreach (DataRowView obj in objDataView)
                {
                    sb.Append("<tr id='sample_2_" + obj["employee_id"] + "' class='sample_2_" + obj["schedule_roster_id"] + "' eid='" + obj["employee_id"] + "'>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>"); 
                    //sb.Append("<div class='checker' id='uniform-undefined'><span>");
                    sb.Append("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["schedule_roster_id"]) + "'  style=''></span></div>");
                    sb.Append(" </td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + obj["code"] + "</td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + ((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + "")) + "</td>");
                    k = 1;
                    employeeWorkHours = 0;
                    while (k <= 31)
                    {
                        string tempFromDate = Numerics.GetDateTime(obj["from_date"] + "").ToString("yyyy-MM-dd");
                        string tempToDate = Numerics.GetDateTime(obj["to_date"] + "").ToString("yyyy-MM-dd");
                        schID = -1;
                        schID = (obj["D" + k] + "" != "") ? Numerics.GetDecimal(obj["D" + k] + "") : -1;
                        string tempColor = schID != -1 ? ("background-color: " + schColorList.FirstOrDefault(p => p.ID == schID).Name) : "";

                        tempFromDay = Numerics.GetDateTime(obj["from_date"] + "").Day;
                        tempToDay = Numerics.GetDateTime(obj["to_date"] + "").Day;

                        if (k > noOfDays)
                        {
                            sb.Append("<td colspan='" + (32 - k) + "' d='" + k + "' schId='-1'  fromDate='" + tempFromDate + "' toDate='" + tempToDate + "' eid='" + obj["employee_id"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC; width: 12px !important;'>" + "" + "</td>");
                            break;
                        }
                        else if (k < tempFromDay || k > tempToDay)
                        {
                            sb.Append("<td d='" + k + "' schId='-1'  fromDate='" + tempFromDate + "' toDate='" + tempToDate + "' eid='" + obj["employee_id"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC; width: 12px !important;'>" + "" + "</td>");
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
                            sb.Append("<td class='droppable' d='" + k + "' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' fromDate='" + tempFromDate + "' toDate='" + tempToDate + "' eid='" + obj["employee_id"] + "' style='padding: 3px !important; line-height: 15px !important; width: 12px !important; " + tempColor + "'>X</td>");
                        }
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
                new ExceptionLog().WriteLog("RequestPages/ScheduleRoasterBorrowPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllRecordsGridByManagerID
        /// <summary>
        /// GetAllRecordsGrid function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllRecordsGridByManagerID()
        {
            StringBuilder sb = new StringBuilder();
            TAMSR2Data objDAL = new TAMSR2Data();
            List<IdName> schColorList = new ScheduleTime().GetSchColorList(Session["ID"] + "");
            List<ScheduleTime> schList = new List<ScheduleTime>();
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);
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

                string[] cols = { "employee_id", "name" + languagePostfix, "code" };



                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];
                orderByClause = " name" + languagePostfix + " ";

                int tempFromDay = 0;
                int tempToDay = 0;
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecordsByManager");
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);

                long employeeWorkHours = 0;
                long tempSchWorkHours = 0;
                decimal schID = -1;
                int k = 1;
                foreach (DataRowView obj in objDataView)
                {
                    sb.Append("<tr id='sample_3_" + obj["schedule_roster_id"] + "' eid='" + obj["employee_id"] + "'>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>");
                    //sb.Append("<div class='checker' id='uniform-undefined'><span>");
                    sb.Append("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["schedule_roster_id"]) + "'  style=''></span></div>");
                    sb.Append(" </td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + obj["code"] + "</td>");
                    sb.Append("<td style='padding: 3px !important; line-height: 15px !important; '>" + ((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + "")) + "</td>");
                    k = 1;
                    employeeWorkHours = 0;
                    while (k <= 31)
                    {
                        string tempFromDate = Numerics.GetDateTime(obj["from_date"] + "").ToString("yyyy-MM-dd");
                        string tempToDate = Numerics.GetDateTime(obj["to_date"] + "").ToString("yyyy-MM-dd");
                        schID = -1;
                        schID = (obj["D" + k] + "" != "") ? Numerics.GetDecimal(obj["D" + k] + "") : -1;
                        string tempColor = schID != -1 ? ("background-color: " + schColorList.FirstOrDefault(p => p.ID == schID).Name) : "";

                        tempFromDay = Numerics.GetDateTime(obj["from_date"] + "").Day;
                        tempToDay = Numerics.GetDateTime(obj["to_date"] + "").Day;

                        if (k > noOfDays)
                        {
                            sb.Append("<td colspan='" + (32 - k) + "' d='" + k + "' schId='-1'  fromDate='" + tempFromDate + "' toDate='" + tempToDate + "' eid='" + obj["employee_id"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC; width: 12px !important;'>" + "" + "</td>");
                            break;
                        }
                        else if (k < tempFromDay || k > tempToDay)
                        {
                            sb.Append("<td d='" + k + "' schId='-1'  fromDate='" + tempFromDate + "' toDate='" + tempToDate + "' eid='" + obj["employee_id"] + "' style='padding: 3px !important; line-height: 15px !important; background-color: #CCC; width: 12px !important;'>" + "" + "</td>");
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
                            sb.Append("<td d='" + k + "' schMin='" + tempSchWorkHours + "' schHrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(tempSchWorkHours)) + "' schId='" + obj["D" + k] + "' fromDate='" + tempFromDate + "' toDate='" + tempToDate + "' eid='" + obj["employee_id"] + "' style='padding: 3px !important; line-height: 15px !important; width: 12px !important; color: White; " + tempColor + "'>&nbsp;</td>");
                        }
                        k++;
                    }
                    sb.Append("<td class='totalWorkHours' schmin='" + employeeWorkHours + "' style='color: Blue; font-weight: bold;'>" + Numerics.FormatMinsToHHmm(employeeWorkHours) + "</td>");
                    sb.Append("<td style='color: Blue; font-weight: bold;'>");
                    sb.Append("<img title='Approve' src='../Images/approve.png' onclick='return ApprovePendingRequest(" + obj["schedule_roster_id"] + ");' style='border: 0px; text-decoration: none; cursor: pointer; width: 16px; height: 16px;' />");
                    sb.Append("<span style='min-width: 10px;'>&nbsp; </span>");
                    sb.Append("<img title='Reject' src='../Images/reject.png' onclick='return RejectPendingRequest(" + obj["schedule_roster_id"] + ");' style='border: 0px; text-decoration: none; cursor: pointer; width: 16px; height: 16px;' />");
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }
                if (sb.Length <= 0)
                    sb.Append("<tr><td colspan='36'> &nbsp; </td></tr>");
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRoasterBorrowPage.aspx.GetAll()", 0, ex);
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);

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
                    tempList.Add((obj["code"] + "").Length > 100 ? (obj["code"] + "").Substring(0, 100) + "..." : (obj["code"] + ""));
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                    int k = 1;
                    while (k <= noOfDays || k <= 31)
                    {
                        tempList.Add(obj["D" + k] + "");
                        k++;
                    }
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleRoasterBorrowPage.aspx.GetAll()", 0, ex);
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
                if (k == 1 && rowEID.ToLower() == "undefined")
                {
                    return "1";
                }
                string[] rowDays = ((Request["rowDay" + k] + "").Trim()).TrimEnd(',').Split(',');
                string[] rowSch = ((Request["rowSch" + k] + "").Trim()).TrimEnd(',').Split(',');
                fromDate = Request["fromDate" + k] + "";
                toDate = Request["toDate" + k] + "";
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
            int tempCount = 1;
            foreach (IdName emp in empList)
            {
                fromDate = Request["fromDate" + tempCount] + "";
                toDate = Request["toDate" + tempCount] + "";
                tempCount++;
                Hashtable ht = new Hashtable();
                ht.Add("action", "save");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("borrowerID", Session["ID"] + "");
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

                    string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);
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
                    new ExceptionLog().WriteLog("RequestPages/ScheduleRoasterBorrowPage.aspx.Save()", 0, ex);
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


        #region Approve Pending Approval Request
        /// <summary>
        /// Reject function
        /// TAMSR2_ScheduleRosterBorrowOps to APPROVE Pending request for borrowing employee
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of failure </returns>

        public string Approve()
        {
            string chk = "";
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("action", "approve");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Request["rID"] + "");
                ht.Add("updatedBy", Session["ID"] + "");
                ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ScheduleRoasterBorrowPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region Reject Pending Approval Request
        /// <summary>
        /// Reject function
        /// TAMSR2_ScheduleRosterBorrowOps to REJECT Pending request for borrowing employee
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of failure </returns>

        public string Reject()
        {
            string chk = "";
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("action", "reject");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Request["rID"] + "");
                ht.Add("updatedBy", Session["ID"] + "");
                ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRosterBorrowOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ScheduleRoasterBorrowPage.aspx.Save()", 0, ex);
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