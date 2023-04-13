using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class EmployeeGroup : BaseClass
    {
        public string Code { get; set; }
        public bool ScheduleFlag { get; set; }

        public DateTime FromDate { get; set; }
        public string FromDateStr { get; set; }

        public DateTime ToDate { get; set; }
        public string ToDateStr { get; set; }
        public bool ReportFlag { get; set; }
        public int EmployeeID { get; set; }
    }
}