using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class UserActivityLog
    {
        public string employee_id { get; set; }
        public string employee_code { get; set; }
        public string employee_name_eng { get; set; }
        public string employee_name_arb { get; set; }
        public string mac_address { get; set; }
        public string ip_address { get; set; }
        public string channel { get; set; }
        public string login_time { get; set; }
    }
}