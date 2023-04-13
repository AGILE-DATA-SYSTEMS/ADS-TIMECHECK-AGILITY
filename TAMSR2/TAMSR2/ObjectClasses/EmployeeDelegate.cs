using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class EmployeeDelegate : BaseClass
    {
        public decimal EmployeeID { get; set; }
        public decimal DelegatedEmployeeID { get; set; }
        public decimal FeatureID { get; set; }
        public DateTime FromDate { get; set; }
        public string FromDateStr { get; set; }
        public DateTime ToDate { get; set; }
        public string ToDateStr { get; set; }
        public string Remarks { get; set; }
        public bool Status { get; set; }

    }
}