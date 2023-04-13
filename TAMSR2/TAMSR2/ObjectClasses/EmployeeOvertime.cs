using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class EmployeeOvertime : BaseClass
    {
        public decimal EmployeeID { get; set; }
        public string EmployeeNameEn { get; set; }
        public string EmployeeNameAr { get; set; }

        public string OrganizationEn { get; set; }
        public string OrganizationAr { get; set; }

        public string MonthDesc { get; set; }
        public DateTime TransactionDate { get; set; }
        public int OT1 { get; set; }
        public int OT2 { get; set; }
        public string OT1_HHmm { get; set; }
        public string OT2_HHmm { get; set; }

        public int OT1_Processed { get; set; }
        public int OT2_Processed { get; set; }
        public string OT1_HHmm_Processed { get; set; }
        public string OT2_HHmm_Processed { get; set; }

        public int RequestStatus { get; set; }
        public decimal RequestUserID { get; set; }
        public string RequestUserNameEn { get; set; }
        public string RequestUserNameAr { get; set; }
        public string RequestDate { get; set; }

        public int ActionStatus { get; set; }
        public decimal ActionUserID { get; set; }
        public string ActionUserNameEn { get; set; }
        public string ActionUserNameAr { get; set; }
        public string ActionDate { get; set; }

        public int ProcessedStatus { get; set; }
        public decimal ProcessedUserID { get; set; }
        public string ProcessedUserNameEn { get; set; }
        public string ProcessedUserNameAr { get; set; }
        public string ProcessedDate { get; set; }

    }
}