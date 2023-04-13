using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class BussinessIntelligence
    {
        public int employee_id { get; set; }
        public string employee_code { get; set; }
        public string employee_name { get; set; }
        public string join_date { get; set; }
        public string inactive_date { get; set; }
        public int expected_work_days { get; set; }
        public int expected_hours { get; set; }
        public int actual_work_days { get; set; }
        public int actual_work_hours { get; set; }
        public int absentcount { get; set; }
        public int missingIN { get; set; }
        public int missingOUT { get; set; }
        public int delaycount { get; set; }
        public int delaysum { get; set; }
        public int earlycount { get; set; }
        public int earlysum { get; set; }
    }

    public class BussinessIntelligenceDetails
    {
        public string Transaction_date { get; set; }
        public string day_name { get; set; }
        public string Punch_In { get; set; }
        public string Punch_Out { get; set; }
        public string Late_HH_MM { get; set; }
        public string Early_HH_MM { get; set; }
        public string Required_Work_HH_MM { get; set; }
        public string Work_Time_HH_MM { get; set; }
        public string Missing_Time_HH_MM { get; set; }
        public string ExtraWorkedTime_HH_MM { get; set; }
        public string Comment_English { get; set; }
        public string Remarks_English { get; set; }
        public string employee_code { get; set; }
        public string Employee_Name_English { get; set; }
    }
}