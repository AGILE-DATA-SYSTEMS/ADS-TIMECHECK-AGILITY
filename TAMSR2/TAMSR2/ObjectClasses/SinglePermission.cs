using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class SinglePermission : BaseClass
    {
        public decimal PermissionTypeID { get; set; }
        public string PermissionTypeEn { get; set; }
        public string PermissionTypeAr { get; set; }

        public decimal EmployeeID { get; set; }
        public string EmployeeNameEn { get; set; }
        public string EmployeeNameAr { get; set; }

        public DateTime FromDate { get; set; }
        public string FromTime { get; set; }
        public DateTime ToDate { get; set; }
        public string ToTime { get; set; }

        public string FromDateTimeStr { get; set; }
        public string ToDateTimeStr { get; set; }

        public int Minutes { get; set; }
        public string Remarks { get; set; }

        public string ApproverRemarks { get; set; }
        public int ApproveRejectFlag { get; set; }
        public decimal ApproverID { get; set; }
        public string ApproverNameEn { get; set; }
        public string ApproverNameAr { get; set; }
        public DateTime ApproveDate { get; set; }
        public string ApproveDateStr { get; set; }

        public string Saturday { get; set; }
        public string Sunday { get; set; }
        public string Monday { get; set; }
        public string Tuesday { get; set; }
        public string Wednesday { get; set; }
        public string Thursday { get; set; }
        public string Friday { get; set; }

        public string CategoryID { get; set; } 



    }
}