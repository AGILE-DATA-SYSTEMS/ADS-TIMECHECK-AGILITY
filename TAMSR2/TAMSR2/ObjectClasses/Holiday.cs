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
    public class Holiday : BaseClass
    {
        public string Remarks { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public string FromDateStr { get; set; }
        public string ToDateStr { get; set; }
        public int RecurringFlag { get; set; }


        public List<IdDateRangeList> GetHolidaysByMonth(string sessionID, string startDate, string endDate)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            List<IdDateRangeList> list = new List<IdDateRangeList>();
            DateTime dt = Numerics.GetDateTime(startDate);
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                Hashtable ht = new Hashtable();
                ht.Add("action", "getHolidayList");
                ht.Add("sessionID", sessionID);
                ht.Add("fromDate", startDate);
                ht.Add("toDate", endDate);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_HolidayOps", ht);
                
                foreach (DataRowView row in dv)
                {
                    IdDateRangeList obj = new IdDateRangeList();
                    obj.ID = Numerics.GetDecimal(row["holiday_id"] + "");
                    obj.FromDate = Numerics.GetDateTime(row["from_date"] + "");
                    obj.ToDate = Numerics.GetDateTime(row["to_date"] + "");
                    obj.Reccuring = Numerics.GetInt(row["recurring_flag"] + "");
                    if (obj.Reccuring == 1)
                    {
                        obj.FromDate = obj.FromDate.AddYears(dt.Year - obj.FromDate.Year);
                        obj.ToDate = obj.ToDate.AddYears(dt.Year - obj.ToDate.Year);
                    }
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


        public int PublicHolidayFlag { get; set; }
    }
}