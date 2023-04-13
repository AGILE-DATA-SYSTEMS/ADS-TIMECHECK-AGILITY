using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class ScheduleRoster : BaseClass
    {
        public decimal EmpID { get; set; }
        public decimal Version { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public decimal SchID {get; set; }
        public decimal Day { get; set; }
        public string EmpCode { get; set; }
        public string SchCode { get; set; }
    }
}