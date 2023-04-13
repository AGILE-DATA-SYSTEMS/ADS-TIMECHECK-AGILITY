using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class Schedule : BaseClass
    {
        public decimal OrgID { get; set; }
        public decimal EmpID { get; set; }
        public decimal GroupID { get; set; }

        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public string FromDateStr { get; set; }
        public string ToDateStr { get; set; }

        public int Sunday { get; set; }
        public int Monday { get; set; }
        public int Tuesday { get; set; }
        public int Wednesday { get; set; }
        public int Thursday { get; set; }
        public int Friday { get; set; }
        public int Saturday { get; set; }

        public Schedule GetOrganizationScheduleByID(decimal id, string sessionID, string constr)
        {
            Schedule obj = new Schedule();
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getOrgSchByID");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrganizationScheduleOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal((dv[0]["schedule_id"] + "").Trim());
                    obj.OrgID = Numerics.GetDecimal((dv[0]["organization_id"] + "").Trim());
                    obj.GroupID = -1;
                    obj.EmpID = -1;
                    obj.Sunday = Numerics.GetInt((dv[0]["sunday_schedule_id"] + "").Trim());
                    obj.Monday = Numerics.GetInt((dv[0]["monday_schedule_id"] + "").Trim());
                    obj.Tuesday = Numerics.GetInt((dv[0]["tuesday_schedule_id"] + "").Trim());
                    obj.Wednesday = Numerics.GetInt((dv[0]["wednesday_schedule_id"] + "").Trim());
                    obj.Thursday = Numerics.GetInt((dv[0]["thursday_schedule_id"] + "").Trim());
                    obj.Friday = Numerics.GetInt((dv[0]["friday_schedule_id"] + "").Trim());
                    obj.Saturday = Numerics.GetInt((dv[0]["saturday_schedule_id"] + "").Trim());
                    obj.FromDate = Numerics.GetDateTime((dv[0]["from_date"] + "").Trim());
                    obj.ToDate = Numerics.GetDateTime((dv[0]["to_date"] + "").Trim());
                    obj.CreatedBy = Numerics.GetDecimal((dv[0]["created_id"] + "").Trim());
                    obj.CreatedOn = Numerics.GetDateTime((dv[0]["created_date"] + "").Trim());
                    obj.UpdatedBy = Numerics.GetDecimal((dv[0]["updated_id"] + "").Trim());
                    obj.UpdatedOn = Numerics.GetDateTime((dv[0]["updated_date"] + "").Trim());
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return obj;
        }

        public Schedule GetGroupScheduleByID(decimal id, string sessionID, string constr)
        {
            Schedule obj = new Schedule();
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getOrgSchByID");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_GroupScheduleOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal((dv[0]["schedule_id"] + "").Trim());
                    obj.GroupID = Numerics.GetDecimal((dv[0]["group_id"] + "").Trim());
                    obj.OrgID = -1;
                    obj.EmpID = -1;
                    obj.Sunday = Numerics.GetInt((dv[0]["sunday_schedule_id"] + "").Trim());
                    obj.Monday = Numerics.GetInt((dv[0]["monday_schedule_id"] + "").Trim());
                    obj.Tuesday = Numerics.GetInt((dv[0]["tuesday_schedule_id"] + "").Trim());
                    obj.Wednesday = Numerics.GetInt((dv[0]["wednesday_schedule_id"] + "").Trim());
                    obj.Thursday = Numerics.GetInt((dv[0]["thursday_schedule_id"] + "").Trim());
                    obj.Friday = Numerics.GetInt((dv[0]["friday_schedule_id"] + "").Trim());
                    obj.Saturday = Numerics.GetInt((dv[0]["saturday_schedule_id"] + "").Trim());
                    obj.FromDate = Numerics.GetDateTime((dv[0]["from_date"] + "").Trim());
                    obj.ToDate = Numerics.GetDateTime((dv[0]["to_date"] + "").Trim());
                    obj.CreatedBy = Numerics.GetDecimal((dv[0]["created_id"] + "").Trim());
                    obj.CreatedOn = Numerics.GetDateTime((dv[0]["created_date"] + "").Trim());
                    obj.UpdatedBy = Numerics.GetDecimal((dv[0]["updated_id"] + "").Trim());
                    obj.UpdatedOn = Numerics.GetDateTime((dv[0]["updated_date"] + "").Trim());
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return obj;
        }

        public Schedule GetEmployeeScheduleByID(decimal id, string sessionID, string constr)
        {
            Schedule obj = new Schedule();
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getOrgSchByID");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeScheduleOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal((dv[0]["schedule_id"] + "").Trim());
                    obj.EmpID = Numerics.GetDecimal((dv[0]["employee_id"] + "").Trim());
                    obj.OrgID = -1;
                    obj.GroupID = -1;
                    obj.Sunday = Numerics.GetInt((dv[0]["sunday_schedule_id"] + "").Trim());
                    obj.Monday = Numerics.GetInt((dv[0]["monday_schedule_id"] + "").Trim());
                    obj.Tuesday = Numerics.GetInt((dv[0]["tuesday_schedule_id"] + "").Trim());
                    obj.Wednesday = Numerics.GetInt((dv[0]["wednesday_schedule_id"] + "").Trim());
                    obj.Thursday = Numerics.GetInt((dv[0]["thursday_schedule_id"] + "").Trim());
                    obj.Friday = Numerics.GetInt((dv[0]["friday_schedule_id"] + "").Trim());
                    obj.Saturday = Numerics.GetInt((dv[0]["saturday_schedule_id"] + "").Trim());
                    obj.FromDate = Numerics.GetDateTime((dv[0]["from_date"] + "").Trim());
                    obj.ToDate = Numerics.GetDateTime((dv[0]["to_date"] + "").Trim());
                    obj.CreatedBy = Numerics.GetDecimal((dv[0]["created_id"] + "").Trim());
                    obj.CreatedOn = Numerics.GetDateTime((dv[0]["created_date"] + "").Trim());
                    obj.UpdatedBy = Numerics.GetDecimal((dv[0]["updated_id"] + "").Trim());
                    obj.UpdatedOn = Numerics.GetDateTime((dv[0]["updated_date"] + "").Trim());
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return obj;
        }

    }
}