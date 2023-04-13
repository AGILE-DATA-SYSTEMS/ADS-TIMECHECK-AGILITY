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
    public partial class ScheduleTimePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/ScheduleTimePage.aspx"));


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
            else if (Request["key"] + "" == "getAllTags")
            {
                data = GetAllTags();
            }
            else if (Request["key"] + "" == "getAllTagsRosterPage")
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["schedule_id"]);
                    obj.OrgID = Numerics.GetDecimal(dv[0]["organization_id"]);
                    obj.SchLocationID = Numerics.GetInt(dv[0]["schedule_location_id"] + "");

                    obj.OpenShift = Numerics.GetInt(dv[0]["open_shift"] + "");
                    obj.NightShift = Numerics.GetInt(dv[0]["night_shift"] + "");
                    obj.OpenShift2 = Numerics.GetInt(dv[0]["open_shift2"] + "");
                    obj.NightShift2 = Numerics.GetInt(dv[0]["night_shift2"] + "");
                    obj.OpenShift3 = Numerics.GetInt(dv[0]["open_shift3"] + "");
                    obj.NightShift3 = Numerics.GetInt(dv[0]["night_shift3"] + "");
                    obj.FlexibleMinutes = Numerics.GetInt(dv[0]["flexible_min"] + "");
                    obj.GraceInMinutes = Numerics.GetInt(dv[0]["grace_in_min"] + "");
                    obj.GraceOutMinutes = Numerics.GetInt(dv[0]["grace_out_min"] + "");
                    obj.TransactionType =  Convert.ToInt32(Convert.ToBoolean(dv[0]["Transaction_type"] + ""));
                    obj.NotificationType = Convert.ToInt32(Convert.ToBoolean(dv[0]["Notification_type"] + ""));
                    obj.EnableOvertime = Convert.ToInt32(Convert.ToBoolean(dv[0]["enable_overtime"] + ""));
                    obj.EnableBreakHours = Convert.ToInt32(Convert.ToBoolean(dv[0]["enable_break_hours"] + ""));
                    obj.CalculateWorkHoursFromSchStartTime = Convert.ToInt32(Convert.ToBoolean(dv[0]["calculate_WorkHours_From_SchStartTime"] + ""));
                    obj.ProcessTransaction = Convert.ToInt32(Convert.ToBoolean(dv[0]["ProcessTransactionForNextDayOrPreviousDay"] + ""));
                    obj.ScheduleOverride = Convert.ToInt32(Convert.ToBoolean(dv[0]["schedule_override"] + ""));
                  
                    obj.ReduceWorkMts = Convert.ToInt32(Convert.ToBoolean(dv[0]["Reduce_Work_Mts"] + ""));

                    obj.OvertimeMinutes = Convert.ToInt32(dv[0]["overtime_minutes"] + "");
                    obj.BreakHours = Convert.ToInt32(dv[0]["break_hours"] + "");

                    obj.InactiveDate = Numerics.GetDateTime(dv[0]["inactive_date"]);
                    obj.InactiveDateStr = (dv[0]["inactive_date"] + "").Trim() != "" ? obj.InactiveDate.ToString("yyyy-MM-dd") : "";

                    obj.Code = dv[0]["schedule_code"] + "";
                    obj.SchColor = dv[0]["sch_color"] + "";

                    obj.InTime1 = (dv[0]["in_time1"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time1"] + "").ToString("HH:mm"));
                    obj.OutTime1 = (dv[0]["out_time1"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time1"] + "").ToString("HH:mm"));
                    obj.RequiredWorkHours = (dv[0]["required_work_hours"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["required_work_hours"] + "").ToString("HH:mm"));
                    
                    obj.InTime2 = (dv[0]["in_time2"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time2"] + "").ToString("HH:mm"));
                    obj.OutTime2 = (dv[0]["out_time2"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time2"] + "").ToString("HH:mm"));
                    obj.RequiredWorkHours2 = (dv[0]["required_work_hours2"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["required_work_hours2"] + "").ToString("HH:mm"));
                    
                    obj.InTime3 = (dv[0]["in_time3"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time3"] + "").ToString("HH:mm"));
                    obj.OutTime3 = (dv[0]["out_time3"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time3"] + "").ToString("HH:mm"));
                    obj.RequiredWorkHours3 = (dv[0]["required_work_hours3"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["required_work_hours3"] + "").ToString("HH:mm"));
                    
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_date"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["last_updated_id"]);

                    ht = new Hashtable();
                    ht.Add("action", "getByParentID");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("schParentID", Numerics.GetDecimal(id));
                    dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);
                    if (dv != null)
                    {
                        obj.OpenShiftSpl = Numerics.GetInt(dv[0]["open_shift"] + "");
                        obj.NightShiftSpl = Numerics.GetInt(dv[0]["night_shift"] + "");
                        obj.OpenShiftSpl2 = Numerics.GetInt(dv[0]["open_shift2"] + "");
                        obj.NightShiftSpl2 = Numerics.GetInt(dv[0]["night_shift2"] + "");
                        obj.OpenShiftSpl3 = Numerics.GetInt(dv[0]["open_shift3"] + "");
                        obj.NightShiftSpl3 = Numerics.GetInt(dv[0]["night_shift3"] + "");
                        obj.FlexibleMinutesSpl = Numerics.GetInt(dv[0]["flexible_min"] + "");
                        obj.GraceInMinutesSpl = Numerics.GetInt(dv[0]["grace_in_min"] + "");
                        obj.GraceOutMinutesSpl = Numerics.GetInt(dv[0]["grace_out_min"] + "");
                        //obj.TransactionType = Numerics.GetInt(dv[0]["Transaction_type"] + "");
                        //obj.NotificationType = Numerics.GetInt(dv[0]["Notification_type"] + "");

                        obj.InactiveDate = Numerics.GetDateTime(dv[0]["inactive_date"]);
                        obj.InactiveDateStr = (dv[0]["inactive_date"] + "").Trim() != "" ? obj.InactiveDate.ToString("yyyy-MM-dd") : "";

                        obj.InTime1Spl = (dv[0]["in_time1"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time1"] + "").ToString("HH:mm"));
                        obj.OutTime1Spl = (dv[0]["out_time1"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time1"] + "").ToString("HH:mm"));
                        obj.RequiredWorkHoursSpl = (dv[0]["required_work_hours"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["required_work_hours"] + "").ToString("HH:mm"));

                        obj.InTime2Spl = (dv[0]["in_time2"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time2"] + "").ToString("HH:mm"));
                        obj.OutTime2Spl = (dv[0]["out_time2"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time2"] + "").ToString("HH:mm"));
                        obj.RequiredWorkHoursSpl2 = (dv[0]["required_work_hours2"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["required_work_hours2"] + "").ToString("HH:mm"));

                        obj.InTime3Spl = (dv[0]["in_time3"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["in_time3"] + "").ToString("HH:mm"));
                        obj.OutTime3Spl = (dv[0]["out_time3"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["out_time3"] + "").ToString("HH:mm"));
                        obj.RequiredWorkHoursSpl3 = (dv[0]["required_work_hours3"] + "") == "" ? "" : (Convert.ToDateTime(dv[0]["required_work_hours3"] + "").ToString("HH:mm"));
                                        
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
                string InactiveDate = (Request["dt"] + "").Trim();
                 
                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("InactiveDate", InactiveDate + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string schedule = (String)GetGlobalResourceObject("Resource", "schedule");

                int start = 0;
                int end = 30;

                double schWorkHours = 0;
                string toolTip = "";
                string fromTimeStr = "";
                string fromTime = "";
                string toTimeStr = "";
                string toTime = "";
                string fromTimeLabel = (String)GetGlobalResourceObject("Resource", "fromTime");
                string toTimeLabel = (String)GetGlobalResourceObject("Resource", "toTime");
                string createdBy = (String)GetGlobalResourceObject("Resource", "createdBy");
                string updatedBy = (String)GetGlobalResourceObject("Resource", "updatedBy");
                string andLabel = (String)GetGlobalResourceObject("Resource", "and");
                sb.Append("<option value=''>" + chooseStr + " " + schedule + "</option>");

                foreach (DataRowView obj in dv)
                {
                    toolTip = "";
                    string code = (obj["schedule_code"] + "").Trim();
                    string color = (obj["sch_color"] + "").Trim();
                    string id = (obj["schedule_id"] + "").Trim();
                    fromTimeStr = obj["in_time1"] + "";
                    toTimeStr = obj["out_time1"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    fromTimeStr = obj["in_time2"] + "";
                    toTimeStr = obj["out_time2"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    fromTimeStr = obj["in_time3"] + "";
                    toTimeStr = obj["out_time3"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    if (schWorkHours < 0)
                        schWorkHours = 0;
                    string attr = " id='" + id + "' schId='" + id + "' color='" + color + "' code='" + code + "' schmin='" + Numerics.GetLong(schWorkHours) + "' schhrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(schWorkHours)) + "' ";
                    
                    PermissionType obj1 = new PermissionType();
                    obj1.ID = Numerics.GetDecimal(obj["schedule_id"] + "");
                    obj1.Code = (obj["schedule_code"] + "").Trim();
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option "+attr+" value='" + obj1.ID + "'>" + obj1.Code + "(" + Convert.ToDateTime(obj["in_time1"] + "").ToString("HH:mm") + " - " + Convert.ToDateTime(obj["out_time1"] + "").ToString("HH:mm") + ")" + " </option>");
                    else
                        sb.Append("<option  " + attr + " value='" + obj1.ID + "'>" + obj1.Code + "(" + Convert.ToDateTime(obj["in_time1"] + "").ToString("HH:mm") + " - " + Convert.ToDateTime(obj["out_time1"] + "").ToString("HH:mm") + ")" + "  </option>");
                    schWorkHours = 0;
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

                int temp = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleTimeOps", ht));
                if (temp > 0)
                    return "1";
                else if (temp < 0)
                    return "-1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleTimePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
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
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}

            StringBuilder sb = new StringBuilder();

            try
            {

                string InactiveDate = (Request["dt"] + "").Trim();

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = 0;
                int end = 30;

                double schWorkHours = 0;
                string toolTip = "";
                string fromTimeStr = "";
                string fromTime = "";
                string toTimeStr = "";
                string toTime = "";
                string fromTimeLabel = (String)GetGlobalResourceObject("Resource", "fromTime");
                string toTimeLabel = (String)GetGlobalResourceObject("Resource", "toTime");
                string createdBy = (String)GetGlobalResourceObject("Resource", "createdBy");
                string updatedBy = (String)GetGlobalResourceObject("Resource", "updatedBy");
                string andLabel = (String)GetGlobalResourceObject("Resource", "and");

                string[] cols = { "sch.schedule_id", "sch.schedule_code", "sch.schedule_color", "org.description" + languagePostfix, "schLocation.description" + languagePostfix, "in_time1", "out_time1", "in_time2", "out_time2", "in_time3", "out_time3", "per.last_updated_time", "per.schedule_id" };

                string orderByClause = " sch.schedule_code ";

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getAllCompanyTags");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("InactiveDate", InactiveDate + "");
                ////ht.Add("orderBy", orderByClause);
                ////ht.Add("startRow", start);
                ////ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                foreach (DataRowView obj in objDataView)
                {
                    toolTip = "";
                    string code = (obj["schedule_code"] + "").Trim();
                    string color = (obj["sch_color"] + "").Trim();
                    string id = (obj["schedule_id"] + "").Trim();
                    fromTimeStr = obj["in_time1"] + "";
                    toTimeStr = obj["out_time1"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    fromTimeStr = obj["in_time2"] + "";
                    toTimeStr = obj["out_time2"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    fromTimeStr = obj["in_time3"] + "";
                    toTimeStr = obj["out_time3"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                      
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    if (schWorkHours < 0)
                        schWorkHours = 0;
                    else
                        schWorkHours -= Convert.ToInt32(obj["Break_Hours"]);
                    toolTip += " Break Minutes: " + Numerics.FormatMinsToHHmm(Convert.ToInt32(obj["Break_Hours"]))  + " \n";
                    string attr = " id='" + id + "' schId='" + id + "' color='" + color + "' code='" + code + "' schmin='" + Numerics.GetLong(schWorkHours) + "' schhrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(schWorkHours)) + "' ";
                    sb.Append("<span id='spnSchedule" + id + "' " + attr + " title='" + toolTip + createdBy + ": " + obj["CreatedName_Eng"] + "' class='draggable' style='color: #FFF; background-color:" + color + ";'>");
                    sb.Append(code);
                    sb.Append("</span>");
                    sb.Append(" &nbsp; &nbsp; ");
                    schWorkHours = 0;
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleTimePage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            if (sb.Length > 0)
                sb.Insert(0, @"<table style='width: 100%; border: 1px solid #CCC;'><tr><td valign='top' style='border: 1px solid #CCC;'> 
                                <h4>" + (String)GetGlobalResourceObject("Resource", "orgSchedule") + "</h4>");
            sb.Append("</td>");
            sb.Append(GetAllUnitTags());
            sb.Append("</tr></table>");
            return sb.ToString();
        }
        //*********End Of GetAllTags Function*********//
        #endregion



        #region GetAllUnitTags
        /// <summary>
        /// Get All Unit Tags function
        /// Get all unit schedules from schedules table 
        /// </summary>
        /// <returns>it will return html string</returns>
        public string GetAllUnitTags()
        {
            TAMSR2Data objDAL = new TAMSR2Data();

            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string InactiveDate = (Request["dt"] + "").Trim();


                double schWorkHours = 0;
                string toolTip = "";
                string fromTimeStr = "";
                string fromTime = "";
                string toTimeStr = "";
                string toTime = "";
                string fromTimeLabel = (String)GetGlobalResourceObject("Resource", "fromTime");
                string toTimeLabel = (String)GetGlobalResourceObject("Resource", "toTime");
                string createdBy = (String)GetGlobalResourceObject("Resource", "createdBy");
                string updatedBy = (String)GetGlobalResourceObject("Resource", "updatedBy");
                string andLabel = (String)GetGlobalResourceObject("Resource", "and");

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getAllUnitTags");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["org"] + "");
                ht.Add("InactiveDate", InactiveDate + "");

                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                foreach (DataRowView obj in objDataView)
                {
                    toolTip = "";
                    string code = (obj["schedule_code"] + "").Trim();
                    string color = (obj["sch_color"] + "").Trim();
                    string id = (obj["schedule_id"] + "").Trim();
                    fromTimeStr = obj["in_time1"] + "";
                    toTimeStr = obj["out_time1"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    fromTimeStr = obj["in_time2"] + "";
                    toTimeStr = obj["out_time2"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    fromTimeStr = obj["in_time3"] + "";
                    toTimeStr = obj["out_time3"] + "";
                    if (fromTimeStr != "" && toTimeStr != "")
                    {
                        fromTime = Numerics.GetDateTime(fromTimeStr).ToString("HH:mm");
                        toTime = Numerics.GetDateTime(toTimeStr).ToString("HH:mm");
                        if (Numerics.GetDateTime(toTimeStr) == Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += 0;
                        else if (Numerics.GetDateTime(toTimeStr) > Numerics.GetDateTime(fromTimeStr))
                            schWorkHours += (Numerics.GetDateTime(toTimeStr) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;
                        else
                            schWorkHours += (Numerics.GetDateTime(toTimeStr).AddDays(1) - Numerics.GetDateTime(fromTimeStr)).TotalMinutes;

                        toolTip += " " + fromTimeLabel + ": " + fromTime + " " + andLabel + " " + toTimeLabel + ": " + toTime + " \n";
                       
                        fromTimeStr = "";
                        toTimeStr = "";
                    }
                    if (schWorkHours < 0)
                        schWorkHours = 0;
                    else
                        schWorkHours -= Convert.ToInt32(obj["Break_Hours"]);
                    toolTip += " Break Minutes: " + Numerics.FormatMinsToHHmm(Convert.ToInt32(obj["Break_Hours"])) + " \n";
                    string attr = " id='" + id + "' schId='" + id + "' color='" + color + "' code='" + code + "' schmin='" + Numerics.GetLong(schWorkHours) + "' schhrs='" + Numerics.FormatMinsToHHmm(Numerics.GetLong(schWorkHours)) + "' ";
                    sb.Append("<span id='spnSchedule" + id + "' " + attr + " title='" + toolTip + createdBy + ": " + obj["CreatedName_Eng"] + "' class='draggable' style='color: #FFF; background-color:" + color + ";'>");
                    sb.Append(code);
                    sb.Append("</span>");
                   // sb.Append(" &nbsp; &nbsp; ");
                    schWorkHours = 0;
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleTimePage.aspx.GetAllUnitTags()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            if (sb.Length > 0)
            {
                sb.Insert(0, @"<td valign='top' style='border: 1px solid #CCC;'>
                            <h4 style='clear: both;'>" + (String)GetGlobalResourceObject("Resource", "unitSchedule") + "</h4>");
                sb.Append("</td>");
            }
            return sb.ToString();
        }
        //*********End Of GetAllUnitTags Function*********//
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

                string[] cols = { "sch.schedule_id", "sch.schedule_code", "sch.sch_color", "org.description" + languagePostfix, "schLocation.description" + languagePostfix, "in_time1", "out_time1", "in_time2", "out_time2", "in_time3", "out_time3", "sch.inactive_date", "sch.last_updated_date", "sch.schedule_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleTimeOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;
                /*
                { "sch.schedule_id", "sch.schedule_code", "sch.schedule_color", "schLocation.description" + languagePostfix, "org.description" + languagePostfix, "in_time1", "out_time1", "in_time2", "out_time2", "in_time3", "out_time3", "per.last_updated_time", "per.schedule_id" };

                */
                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if ((new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_SCHEDULE_TIME) == true && (obj["created_id"] + "" == Session["ID"] + "" || obj["isAdmin"] + "" == "1")) || Numerics.GetBool(Session["CanDelete"]) == true)
                    {
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["schedule_id"]) + "' />");
                    }
                    else
                    {
                        tempList.Add(" &nbsp;");
                    }
                    tempList.Add(obj["schedule_code"] + "");
                    tempList.Add("<span style='background-color:" + (obj["sch_color"] + "").Trim() + "; width: 100%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>");
                    //tempList.Add((obj["LocDesc" + languagePostfix] + "").Length > 100 ? (obj["LocDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["LocDesc" + languagePostfix] + ""));
                    tempList.Add((obj["OrgDesc" + languagePostfix] + "").Length > 100 ? (obj["OrgDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["OrgDesc" + languagePostfix] + ""));
                    tempList.Add((obj["in_time1"] + "") == "" ? "" : Convert.ToDateTime(obj["in_time1"] + "").ToString("HH:mm"));
                    tempList.Add((obj["out_time1"] +"") == "" ? "" : Convert.ToDateTime(obj["out_time1"] + "").ToString("HH:mm"));
                    tempList.Add((obj["in_time2"] + "") == "" ? "" : Convert.ToDateTime(obj["in_time2"] + "").ToString("HH:mm"));
                    tempList.Add((obj["out_time2"] + "") == "" ? "" : Convert.ToDateTime(obj["out_time2"] + "").ToString("HH:mm"));
                    tempList.Add((obj["in_time3"] + "") == "" ? "" : Convert.ToDateTime(obj["in_time3"] + "").ToString("HH:mm"));
                    tempList.Add((obj["out_time3"] + "") == "" ? "" : Convert.ToDateTime(obj["out_time3"] + "").ToString("HH:mm"));


                    if (obj["inactive_date"] + "" != "")
                        tempList.Add(Numerics.GetDateTime(obj["inactive_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("");
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if ((new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_SCHEDULE_TIME) == true
                        && ((obj["created_id"] + "" == Session["ID"] + "" || obj["isAdmin"] + "" == "1") || Numerics.GetInt(obj["AllowShareEdit"] + "") == 1)) || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<a style='text-decoration: none;' href='" +  path + "Sch/Save-Schedule-Time/" + 
                                        Encryption.Encrypt(obj["schedule_id"] + "") + "'>" + 
                                        "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["schedule_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleTimePage.aspx.GetAll()", 0, ex);
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
            string openShift = "0";
            string nightShift = "0";
            string openShift2 = "0";
            string nightShift2 = "0";
            string openShift3 = "0";
            string nightShift3 = "0";

            string openShiftSpl = "0";
            string nightShiftSpl = "0";
            string openShiftSpl2 = "0";
            string nightShiftSpl2 = "0";
            string openShiftSpl3 = "0";
            string nightShiftSpl3 = "0";
            string EnableOvertime = "0";
            string EnableBreakHours = "0";
            string CalculateWorkHoursFromSchStartTime = "0";
            string ProcessTransaction = "0";
            string ScheduleOverride = "0";
            string ReduceWorkMts = "0";

            if ((Request["EnableOvertime"] + "").ToLower() == "true")
                EnableOvertime = "1";

            if ((Request["EnableBreakHours"] + "").ToLower() == "true")
                EnableBreakHours = "1";

            if ((Request["CalculateWorkHoursFromSchStartTime"] + "").ToLower() == "true")
                CalculateWorkHoursFromSchStartTime = "1";

            if((Request["ScheduleOverride"] + "").ToLower() == "true")
                ScheduleOverride = "1";

            if ((Request["ReduceWorkMts"] + "").ToLower() == "true")
                ReduceWorkMts = "1";


            string inactiveDate = ((Request["inactive"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["inactive"] + "";
              
             ProcessTransaction = Request["ProcessTransaction"] + "" ;

            

            if ((Request["openShift"] + "").ToLower() == "true")

            if ((Request["openShift"] + "").ToLower() == "true")
            if ((Request["openShift"] + "").ToLower() == "true")
                openShift = "1";
            if ((Request["nightShift"] + "").ToLower() == "true")
                nightShift = "1";
            if ((Request["openShift2"] + "").ToLower() == "true")
                openShift2 = "1";
            if ((Request["nightShift2"] + "").ToLower() == "true")
                nightShift2 = "1";
            if ((Request["openShift3"] + "").ToLower() == "true")
                openShift3 = "1";
            if ((Request["nightShift3"] + "").ToLower() == "true")
                nightShift3 = "1";

            if ((Request["openShiftSpl"] + "").ToLower() == "true")
                openShiftSpl = "1";
            if ((Request["nightShiftSpl"] + "").ToLower() == "true")
                nightShiftSpl = "1";
            if ((Request["openShiftSpl2"] + "").ToLower() == "true")
                openShiftSpl2 = "1";
            if ((Request["nightShiftSpl"] + "").ToLower() == "true")
                nightShiftSpl2 = "1";
            if ((Request["openShiftSpl3"] + "").ToLower() == "true")
                openShiftSpl3 = "1";
            if ((Request["nightShiftSpl3"] + "").ToLower() == "true")
                nightShiftSpl3 = "1";
            string id = "0";
            try
            {
                if (Request["id"] + "" == "undefined" || Request["id"] + "" == "")
                    id = "0";
                else
                    id = Encryption.Decrypt(Request["id"] + "");
            }
            catch (Exception ex)
            {
                id = (Request["id"] + "").Trim();
                if (id == "undefined" || id == "")
                    id = "0";
            }
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", id);
            ht.Add("orgID", (Request["orgID"] + "").Trim());
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("color", (Request["color"] + "").Trim());
            ht.Add("schLocationID", (Request["schLocationID"] + "").Trim());

            ht.Add("inTime1", (Request["inTime1"] + "").Trim());
            ht.Add("outTime1", (Request["outTime1"] + "").Trim());
            ht.Add("requiredWorkHours", (Request["rwHours"] + "").Trim());
            ht.Add("openShift", openShift);
            ht.Add("nightShift", nightShift);

            ht.Add("inTime2", (Request["inTime2"] + "").Trim());
            ht.Add("outTime2", (Request["outTime2"] + "").Trim());
            ht.Add("requiredWorkHours2", (Request["rwHours2"] + "").Trim());
            ht.Add("openShift2", openShift2);
            ht.Add("nightShift2", nightShift2);

            ht.Add("inTime3", (Request["inTime3"] + "").Trim());
            ht.Add("outTime3", (Request["outTime3"] + "").Trim());
            ht.Add("requiredWorkHours3", (Request["rwHours3"] + "").Trim());
            ht.Add("openShift3", openShift3);
            ht.Add("nightShift3", nightShift3);

            ht.Add("flexible", Numerics.GetInt((Request["flexible"] + "").Trim()));
            ht.Add("graceIn", Numerics.GetInt((Request["graceIn"] + "").Trim()));
            ht.Add("graceOut", Numerics.GetInt((Request["graceOut"] + "").Trim()));

            ht.Add("specialShift", "");

            ht.Add("inTime1Spl", (Request["inTime1Spl"] + "").Trim());
            ht.Add("outTime1Spl", (Request["outTime1Spl"] + "").Trim());
            ht.Add("requiredWorkHoursSpl", (Request["rwHoursSpl"] + "").Trim());
            ht.Add("openShiftSpl", openShiftSpl);
            ht.Add("nightShiftSpl", nightShiftSpl);

            ht.Add("inTime2Spl", (Request["inTime2Spl"] + "").Trim());
            ht.Add("outTime2Spl", (Request["outTime2Spl"] + "").Trim());
            ht.Add("requiredWorkHoursSpl2", (Request["rwHoursSpl2"] + "").Trim());
            ht.Add("openShiftSpl2", openShiftSpl2);
            ht.Add("nightShiftSpl2", nightShiftSpl2);

            ht.Add("inTime3Spl", (Request["inTime3Spl"] + "").Trim());
            ht.Add("outTime3Spl", (Request["outTime3Spl"] + "").Trim());
            ht.Add("requiredWorkHoursSpl3", (Request["rwHoursSpl3"] + "").Trim());
            ht.Add("openShiftSpl3", openShiftSpl3);
            ht.Add("nightShiftSpl3", nightShiftSpl3);

            ht.Add("flexibleSpl", Numerics.GetInt((Request["flexibleSpl"] + "").Trim()));
            ht.Add("graceInSpl", Numerics.GetInt((Request["graceInSpl"] + "").Trim()));
            ht.Add("graceOutSpl", Numerics.GetInt((Request["graceOutSpl"] + "").Trim()));

            ht.Add("TransactionType", Numerics.GetInt((Request["TransactionType"] + "").Trim()));
            ht.Add("NotificationType", Numerics.GetInt((Request["NotificationType"] + "").Trim()));
            ht.Add("CalculateWorkHoursFromSchStartTime", CalculateWorkHoursFromSchStartTime);
            ht.Add("EnableOvertime", EnableOvertime);
            ht.Add("OvertimeMinutes", Numerics.GetInt((Request["OvertimeMinutes"] + "").Trim()));
            ht.Add("EnableBreakHours", EnableBreakHours);
            ht.Add("BreakHours", Numerics.GetInt((Request["BreakHours"] + "").Trim()));
            ht.Add("ProcessTransaction", ProcessTransaction);
            ht.Add("ScheduleOverride", ScheduleOverride);
            ht.Add("ReduceWorkMts", ReduceWorkMts);
            ht.Add("inactiveDate", inactiveDate);

            ht.Add("specialShiftSpl", "");
            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleTimeOps", ht);
                if (Numerics.GetDecimal(result) <= 0)
                {
                    chk = result;
                } 
                else
                {
                    chk = result;
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ScheduleTimePage.aspx.Save()", 0, ex);
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