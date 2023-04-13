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
    public class PendingCount : BaseClass
    {
        public string LeaveCount { get; set; }
        public string ShortPermissionCount { get; set; }
        public string ManualMovementCount { get; set; }
        public string MissingMovementCount { get; set; }
        public string TotalPendingCount { get; set; }


        public PendingCount GetAllPendingCounts(string sessionID)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            PendingCount obj = new PendingCount(); 
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());

                Hashtable ht = new Hashtable();
                ht.Add("action", "PendingCount");
                ht.Add("sessionID", sessionID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_PendingApprovalOps", ht);

                if (dv != null)
                { 
                    foreach (DataRowView row in dv)
                    {
                         obj.ShortPermissionCount = row["ShortPermission"] + "";
                         obj.ManualMovementCount = row["ManualMovements"] + "";
                         obj.MissingMovementCount = row["MissingMovements"] + "";
                         obj.TotalPendingCount = row["TotalPending"] + "";
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
            return obj;
        }
    }
}