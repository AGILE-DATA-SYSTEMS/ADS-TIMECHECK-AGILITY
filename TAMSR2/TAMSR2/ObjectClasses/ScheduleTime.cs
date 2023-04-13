
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class ScheduleTime : BaseClass
    {
        public decimal SchID { get; set; }
        public decimal SchLocationID { get; set; }
        public decimal OrgID { get; set; }
        public string Code { get; set; }
        public string InTime1 { get; set; }
        public string OutTime1 { get; set; }
        public int OpenShift { get; set; }
        public int NightShift { get; set; }
        public string RequiredWorkHours { get; set; }
        
        public string InTime2 { get; set; }
        public string OutTime2 { get; set; }
        public int OpenShift2 { get; set; }
        public int NightShift2 { get; set; }
        public string RequiredWorkHours2 { get; set; }

        public string InTime3 { get; set; }
        public string OutTime3 { get; set; }
        public int OpenShift3 { get; set; }
        public int NightShift3 { get; set; }
        public string RequiredWorkHours3 { get; set; }

        public long SchTotalWorkMinutes { get; set; }
        public string SchTotalWorkHours { get; set; }
        public int FlexibleMinutes { get; set; }
        public int GraceInMinutes { get; set; }
        public int GraceOutMinutes { get; set; }
        public string SchColor { get; set; }

        public int TransactionType { get; set; }
        public int NotificationType { get; set; }

        public int EnableOvertime { get; set; }
        public int OvertimeMinutes { get; set; }

        public int EnableBreakHours { get; set; }
        public int BreakHours { get; set; }

        public int CalculateWorkHoursFromSchStartTime { get; set; }
        public int ProcessTransaction { get; set; }
        public int ScheduleOverride { get; set; }
         
        public string InTime1Spl { get; set; }
        public string OutTime1Spl { get; set; }
        public int OpenShiftSpl { get; set; }
        public int NightShiftSpl { get; set; }
        public string RequiredWorkHoursSpl { get; set; }
        
        public string InTime2Spl { get; set; }
        public string OutTime2Spl { get; set; }
        public int OpenShiftSpl2 { get; set; }
        public int NightShiftSpl2 { get; set; }
        public string RequiredWorkHoursSpl2 { get; set; }

        public string InTime3Spl { get; set; }
        public string OutTime3Spl { get; set; }
        public int OpenShiftSpl3 { get; set; }
        public int NightShiftSpl3 { get; set; }
        public string RequiredWorkHoursSpl3 { get; set; }

        public long SchTotalWorkMinutesSpl { get; set; }
        public string SchTotalWorkHoursSpl { get; set; }
        public int FlexibleMinutesSpl { get; set; }
        public int GraceInMinutesSpl { get; set; }
        public int GraceOutMinutesSpl { get; set; }

        public DateTime InactiveDate { get; set; }
        public string InactiveDateStr { get; set; }

        public List<IdName> GetSchColorList(string sessionID)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            List<IdName> list = new List<IdName>();
            double schWorkHours = 0;
            string fromTimeStr = "";
            string toTimeStr = "";
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListAll");
                ht.Add("sessionID", sessionID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                foreach (DataRowView row in dv)
                {
                    IdName obj = new IdName();
                    schWorkHours = 0;
                    obj.ID = Numerics.GetDecimal(row["schedule_id"] + "");
                    obj.Name = row["sch_color"] + "";
                    obj.Code = row["schedule_code"] + "";
                    fromTimeStr = row["in_time1"] + "";
                    toTimeStr = row["out_time1"] + "";
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
                    fromTimeStr = row["in_time2"] + "";
                    toTimeStr = row["out_time2"] + "";
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
                    fromTimeStr = row["in_time3"] + "";
                    toTimeStr = row["out_time3"] + "";
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
                    else
                        schWorkHours -= Convert.ToInt32(row["Break_Hours"]);

                    obj.value = schWorkHours + "";
                    list.Add(obj);
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return list;
        }

        public List<ScheduleTime> GetAllSchList(string sessionID)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            List<ScheduleTime> list = new List<ScheduleTime>();
            double schWorkHours = 0;
            string fromTimeStr = "";
            string toTimeStr = "";
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListAll");
                ht.Add("sessionID", sessionID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                foreach (DataRowView row in dv)
                {
                    ScheduleTime obj = new ScheduleTime();
                    schWorkHours = 0;
                    obj.ID = Numerics.GetDecimal(row["schedule_id"] + "");
                    obj.SchLocationID = Numerics.GetDecimal(row["schedule_location_id"] + "");
                    obj.CreatedBy = Numerics.GetDecimal(row["created_id"] + "");
                    obj.CreatedOn = Numerics.GetDateTime(row["created_date"] + "");
                    obj.UpdatedBy = Numerics.GetDecimal(row["last_updated_id"] + "");
                    obj.UpdatedOn = Numerics.GetDateTime(row["last_updated_date"] + "");
                    obj.OpenShift = Numerics.GetInt(row["open_shift"] + "");
                    obj.NightShift = Numerics.GetInt(row["night_shift"] + "");
                    obj.FlexibleMinutes = Numerics.GetInt(row["flexible_min"] + "");
                    obj.GraceInMinutes = Numerics.GetInt(row["grace_in_min"] + "");
                    obj.GraceOutMinutes = Numerics.GetInt(row["grace_out_min"] + "");
                    obj.Code = row["schedule_code"] + "";
                    obj.SchColor = row["sch_color"] + "";
                    obj.InTime1 = (row["in_time1"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time1"] + "").ToString("HH:mm") : "";
                    obj.OutTime1 = (row["out_time1"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time1"] + "").ToString("HH:mm") : "";
                    obj.InTime2 = (row["in_time2"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time2"] + "").ToString("HH:mm") : "";
                    obj.OutTime2 = (row["out_time2"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time2"] + "").ToString("HH:mm") : "";
                    obj.InTime3 = (row["in_time3"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time3"] + "").ToString("HH:mm") : "";
                    obj.OutTime3 = (row["out_time3"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time3"] + "").ToString("HH:mm") : "";
                    
                    fromTimeStr = row["in_time1"] + "";
                    toTimeStr = row["out_time1"] + "";
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
                    fromTimeStr = row["in_time2"] + "";
                    toTimeStr = row["out_time2"] + "";
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
                    fromTimeStr = row["in_time3"] + "";
                    toTimeStr = row["out_time3"] + "";
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
                    obj.SchTotalWorkMinutes = Convert.ToInt64(schWorkHours);
                    obj.SchTotalWorkHours = Numerics.FormatMinsToHHmm(Convert.ToInt64(schWorkHours));
                    list.Add(obj);
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return list;
        }

        public List<ScheduleTime> GetAllSchListByOrgName(string sessionID, string orgName)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            List<ScheduleTime> list = new List<ScheduleTime>();
            double schWorkHours = 0;
            string fromTimeStr = "";
            string toTimeStr = "";
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListAllByOrgName");
                ht.Add("sessionID", sessionID);
                ht.Add("orgName", orgName);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                foreach (DataRowView row in dv)
                {
                    ScheduleTime obj = new ScheduleTime();
                    schWorkHours = 0;
                    obj.ID = Numerics.GetDecimal(row["schedule_id"] + "");
                    obj.SchLocationID = Numerics.GetDecimal(row["schedule_location_id"] + "");
                    obj.CreatedBy = Numerics.GetDecimal(row["created_id"] + "");
                    obj.CreatedOn = Numerics.GetDateTime(row["created_date"] + "");
                    obj.UpdatedBy = Numerics.GetDecimal(row["last_updated_id"] + "");
                    obj.UpdatedOn = Numerics.GetDateTime(row["last_updated_date"] + "");
                    obj.OpenShift = Numerics.GetInt(row["open_shift"] + "");
                    obj.NightShift = Numerics.GetInt(row["night_shift"] + "");
                    obj.FlexibleMinutes = Numerics.GetInt(row["flexible_min"] + "");
                    obj.GraceInMinutes = Numerics.GetInt(row["grace_in_min"] + "");
                    obj.GraceOutMinutes = Numerics.GetInt(row["grace_out_min"] + "");
                    obj.Code = row["schedule_code"] + "";
                    obj.SchColor = row["sch_color"] + "";
                    obj.InTime1 = (row["in_time1"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time1"] + "").ToString("HH:mm") : "";
                    obj.OutTime1 = (row["out_time1"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time1"] + "").ToString("HH:mm") : "";
                    obj.InTime2 = (row["in_time2"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time2"] + "").ToString("HH:mm") : "";
                    obj.OutTime2 = (row["out_time2"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time2"] + "").ToString("HH:mm") : "";
                    obj.InTime3 = (row["in_time3"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time3"] + "").ToString("HH:mm") : "";
                    obj.OutTime3 = (row["out_time3"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time3"] + "").ToString("HH:mm") : "";

                    fromTimeStr = row["in_time1"] + "";
                    toTimeStr = row["out_time1"] + "";
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
                    fromTimeStr = row["in_time2"] + "";
                    toTimeStr = row["out_time2"] + "";
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
                    fromTimeStr = row["in_time3"] + "";
                    toTimeStr = row["out_time3"] + "";
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
                    
                        schWorkHours -= Convert.ToInt32(row["Break_Hours"]);

                    obj.SchTotalWorkMinutes = Convert.ToInt64(schWorkHours);
                    obj.SchTotalWorkHours = Numerics.FormatMinsToHHmm(Convert.ToInt64(schWorkHours));
                    list.Add(obj);
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return list;
        }


        public List<ScheduleTime> GetAllSchListByFilters(string sessionID, string OrgID, string GroupID, string ManagerID, string EmpID, string FromDate, string ToDate)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            List<ScheduleTime> list = new List<ScheduleTime>();
            double schWorkHours = 0;
            string fromTimeStr = "";
            string toTimeStr = "";
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListAllByFilters");
                ht.Add("sessionID", sessionID);
                ht.Add("OrgID", OrgID);
                ht.Add("GroupID", GroupID);
                ht.Add("MgrID", ManagerID);
                ht.Add("EmployeeID", EmpID);
                ht.Add("FromDate", FromDate);
                ht.Add("ToDate", ToDate);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleTimeOps", ht);

                foreach (DataRowView row in dv)
                {
                    ScheduleTime obj = new ScheduleTime();
                    schWorkHours = 0;
                    obj.ID = Numerics.GetDecimal(row["schedule_id"] + "");
                    obj.SchLocationID = Numerics.GetDecimal(row["schedule_location_id"] + "");
                    obj.CreatedBy = Numerics.GetDecimal(row["created_id"] + "");
                    obj.CreatedOn = Numerics.GetDateTime(row["created_date"] + "");
                    obj.UpdatedBy = Numerics.GetDecimal(row["last_updated_id"] + "");
                    obj.UpdatedOn = Numerics.GetDateTime(row["last_updated_date"] + "");
                    obj.OpenShift = Numerics.GetInt(row["open_shift"] + "");
                    obj.NightShift = Numerics.GetInt(row["night_shift"] + "");
                    obj.FlexibleMinutes = Numerics.GetInt(row["flexible_min"] + "");
                    obj.GraceInMinutes = Numerics.GetInt(row["grace_in_min"] + "");
                    obj.GraceOutMinutes = Numerics.GetInt(row["grace_out_min"] + "");
                    obj.Code = row["schedule_code"] + "";
                    obj.SchColor = row["sch_color"] + "";
                    obj.InTime1 = (row["in_time1"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time1"] + "").ToString("HH:mm") : "";
                    obj.OutTime1 = (row["out_time1"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time1"] + "").ToString("HH:mm") : "";
                    obj.InTime2 = (row["in_time2"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time2"] + "").ToString("HH:mm") : "";
                    obj.OutTime2 = (row["out_time2"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time2"] + "").ToString("HH:mm") : "";
                    obj.InTime3 = (row["in_time3"] + "").Trim() != "" ? Numerics.GetDateTime(row["in_time3"] + "").ToString("HH:mm") : "";
                    obj.OutTime3 = (row["out_time3"] + "").Trim() != "" ? Numerics.GetDateTime(row["out_time3"] + "").ToString("HH:mm") : "";

                    fromTimeStr = row["in_time1"] + "";
                    toTimeStr = row["out_time1"] + "";
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
                    fromTimeStr = row["in_time2"] + "";
                    toTimeStr = row["out_time2"] + "";
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
                    fromTimeStr = row["in_time3"] + "";
                    toTimeStr = row["out_time3"] + "";
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

                    schWorkHours -= Convert.ToInt32(row["Break_Hours"]);

                    obj.SchTotalWorkMinutes = Convert.ToInt64(schWorkHours);
                    obj.SchTotalWorkHours = Numerics.FormatMinsToHHmm(Convert.ToInt64(schWorkHours));
                    list.Add(obj);
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return list;
        }



        public int EnablePunchInReminder { get; set; }

        public int PunchInReminderMinutes { get; set; }

        public int EnablePunchOutReminder { get; set; }

        public int PunchOutReminderMinutes { get; set; }

        public int ReduceWorkMts { get; set; }
    }
}