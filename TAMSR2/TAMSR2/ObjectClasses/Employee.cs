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
    public class Employee : BaseClass
    {
        public decimal OrgID { get; set; }
        public decimal GradeID { get; set; }
        public decimal DesignationID { get; set; }
        public decimal CountryID { get; set; }
        public decimal EmpTypeID { get; set; }
        public decimal RegionID { get; set; }
        public decimal BuildingID { get; set; }
        public decimal ScheduleTypeID { get; set; }
        public decimal ManagerID { get; set; }

        public string Username { get; set; }
        public string Password { get; set; }
        
        public string Code { get; set; }
        public string SalutationEn { get; set; }
        public string SalutationAr { get; set; }
        public string CardNo { get; set; }
        public string ReaderPassword { get; set; }
        public string Email { get; set; }
        public string Remarks { get; set; }
        public string PhotoFileName { get; set; }

        public string Mobile { get; set; }

        public DateTime JoinDate { get; set; }
        public DateTime InactiveDate { get; set; }
        public string JoinDateStr { get; set; }
        public string InactiveDateStr { get; set; }

        public int StatusFlag { get; set; }
        public int SexFlag { get; set; }
        public int LocalFlag { get; set; }
        public int PunchFlag { get; set; }
        public int ShiftFlag { get; set; }
        public int OvertimeFlag { get; set; }
        public int OnReportFlag { get; set; }
        public int ShareRoster { get; set; }
        public int OpenShiftFlag { get; set; }
        public int WebPunchFlag { get; set; }
        public int CalculateMonthlyMissedHours { get; set; }
        
        public bool ManagerFlag { get; set; }
        public bool Inpayroll { get; set; }

        public bool NotifyFlag { get; set; }
        public bool IncludeNotification { get; set; }
        public bool NofityReportinStaffFlag { get; set; } 

        public string EncryptedID { get; set; }
        public string Grade { get; set; }
        public string Designation_description { get; set; }
        public string Organization { get; set; }
        public Employee()
        {
        }

        public Employee(decimal id, decimal sessionID)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByID");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                if (dv != null)
                {
                    ID = id;
                    Code = dv[0]["employee_code"] + "";
                    SalutationEn = dv[0]["salutation_eng"] + "";
                    SalutationAr = dv[0]["salutation_arb"] + "";
                    NameEn = dv[0]["name_eng"] + "";
                    NameAr = dv[0]["name_arb"] + "";
                    CardNo = dv[0]["card_number"] + "";
                    ReaderPassword = dv[0]["reader_password"] + "";
                    Email = dv[0]["email"] + "";
                    PhotoFileName = dv[0]["pgoto_file_name"] + "";
                    Remarks = dv[0]["remarks"] + "";

                    Mobile = dv[0]["mobile"] + "";

                    JoinDate = Numerics.GetDateTime(dv[0]["join_date"] + "");
                    InactiveDate = Numerics.GetDateTime(dv[0]["inactive_date"] + "");
                    JoinDateStr = dv[0]["join_date"] + "";
                    InactiveDateStr = dv[0]["inactive_date"] + "";

                    SexFlag = Numerics.GetInt(dv[0]["sex_flag"] + "");
                    StatusFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    LocalFlag = Numerics.GetInt(dv[0]["local_flag"] + "");
                    PunchFlag = Numerics.GetInt(dv[0]["punch_flag"] + "");
                    ShiftFlag = Numerics.GetInt(dv[0]["shift_flag"] + "");
                    OvertimeFlag = Numerics.GetInt(dv[0]["overtime_flag"] + "");
                    OnReportFlag = Numerics.GetInt(dv[0]["on_reports_flag"] + "");
                    OpenShiftFlag = Numerics.GetInt(dv[0]["open_shift_flag"] + "");
                    WebPunchFlag = Numerics.GetInt(dv[0]["web_punch_flag"] + "");

                    ManagerFlag = Numerics.GetBool(dv[0]["manager_flag"] + "");
                    Inpayroll = Numerics.GetBool(dv[0]["inpayroll"] + "");

                    NotifyFlag = Numerics.GetBool(dv[0]["notify_flag"] + "");
                    IncludeNotification = Numerics.GetBool(dv[0]["include_notifications"] + "");

                    CreatedOn = Numerics.GetDateTime(dv[0]["CreatedOn"] + "");
                    CreatedBy = Numerics.GetDecimal(dv[0]["CreatedBy"] + "");
                    UpdatedOn = Numerics.GetDateTime(dv[0]["UpdatedOn"] + "");
                    UpdatedBy = Numerics.GetDecimal(dv[0]["UpdatedBy"] + "");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
        }

        public Employee(decimal id, string sessionID, string constr)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr); 
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByID");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                if (dv != null)
                {
                    ID = id;
                    Code = dv[0]["employee_code"] + "";
                    SalutationEn = dv[0]["salutation_eng"] + "";
                    SalutationAr = dv[0]["salutation_arb"] + "";
                    NameEn = dv[0]["name_eng"] + "";
                    NameAr = dv[0]["name_arb"] + "";
                    CardNo = dv[0]["card_number"] + "";
                    ReaderPassword = dv[0]["reader_password"] + "";
                    Email = dv[0]["email"] + "";
                    PhotoFileName = dv[0]["pgoto_file_name"] + "";
                    Remarks = dv[0]["remarks"] + "";

                    Mobile = dv[0]["mobile"] + "";

                    JoinDate = Numerics.GetDateTime(dv[0]["join_date"] + "");
                    InactiveDate = Numerics.GetDateTime(dv[0]["inactive_date"] + "");
                    JoinDateStr = dv[0]["join_date"] + "";
                    InactiveDateStr = dv[0]["inactive_date"] + "";

                    SexFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    StatusFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    LocalFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    PunchFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    ShiftFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    OvertimeFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    OnReportFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    WebPunchFlag = Numerics.GetInt(dv[0]["web_punch_flag"] + "");

                    ManagerFlag = Numerics.GetBool(dv[0]["status_flag"] + "");
                    Inpayroll = Numerics.GetBool(dv[0]["status_flag"] + "");

                    NotifyFlag = Numerics.GetBool(dv[0]["notify_flag"] + "");
                    IncludeNotification = Numerics.GetBool(dv[0]["include_notifications"] + "");

                    CreatedOn = Numerics.GetDateTime(dv[0]["CreatedOn"] + "");
                    CreatedBy = Numerics.GetDecimal(dv[0]["CreatedBy"] + "");
                    UpdatedOn = Numerics.GetDateTime(dv[0]["UpdatedOn"] + "");
                    UpdatedBy = Numerics.GetDecimal(dv[0]["UpdatedBy"] + "");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
        }


        public DateTime SystemActivationDate { get; set; }

        public string SystemActivationDateStr { get; set; }
    }
}