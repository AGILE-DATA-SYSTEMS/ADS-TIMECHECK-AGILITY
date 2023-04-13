using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class DeptAdmin
    {

        public decimal ID { get; set; }
        public decimal DeptID { get; set; }
        public decimal OrgID { get; set; }
        public decimal EmployeeID { get; set; }
        
        public string Status { get; set; }
        public string EmployeeCode { get; set; }
        public string EmployeeName_Eng { get; set; }
        public string EmployeeName_Arb { get; set; }
        public string remarks { get; set; }
        public string Description_Arb { get; set; }
        public string Description_Eng { get; set; }

        public string FromDateStr { get; set; }
        public string ToDateStr { get; set; }
        
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        


    }
}