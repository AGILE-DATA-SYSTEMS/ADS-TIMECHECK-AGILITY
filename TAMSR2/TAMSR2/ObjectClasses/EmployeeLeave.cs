using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class EmployeeLeave : BaseClass
    {
        public decimal LeaveID { get; set; }
        public decimal LeaveCode { get; set; }
        public decimal LeaveDescriptionEn { get; set; }
        public decimal LeaveDescriptionAr { get; set; }

        public decimal EmployeeID { get; set; }
        public decimal EmployeeCode { get; set; }
        public decimal EmployeeNameEn { get; set; }
        public decimal EmployeeNameAr { get; set; }

        public decimal NoOfLeaves { get; set; }
        public string Remarks { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public string FromDateStr { get; set; }
        public string ToDateStr { get; set; }
        public int ApproveRejectFlag { get; set; }
        public decimal ApprovedBy { get; set; }
        public DateTime ApprovedOn { get; set; }


        public List<IdDateRangeList> GetEmployeeLeavesByMonth(string sessionID, string startDate, string endDate)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            List<IdDateRangeList> list = new List<IdDateRangeList>();

            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                Hashtable ht = new Hashtable();
                ht.Add("action", "getEmployeeLeaveList");
                ht.Add("sessionID", sessionID);
                ht.Add("fromDate", startDate);
                ht.Add("toDate", endDate);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeLeaveOps", ht);

                foreach (DataRowView row in dv)
                {
                    IdDateRangeList obj = new IdDateRangeList();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.FromDate = Numerics.GetDateTime(row["from_date"] + "");
                    obj.ToDate = Numerics.GetDateTime(row["to_date"] + "");
                    obj.Reccuring = 0;

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

    }
}