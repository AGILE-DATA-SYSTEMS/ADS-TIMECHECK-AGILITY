using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class DashboardStat
    {
        public string TimeIn { get; set; }
        public string TimeOut { get; set; }

        public string SchCode { get; set; }
        public string Flexible { get; set; }
        public string GraceIn { get; set; }
        public string GraceOut { get; set; } 
        public string MissedIn { get; set; }
        public string MissedOut { get; set; }
        public string Permission { get; set; }

        public string Late { get; set; }
        public string Early { get; set; }
        public string Absent { get; set; }
        public string Leave { get; set; }
        public string LateMinutes { get; set; }
        public string EarlyMinutes { get; set; }
        public string AbsentMinutes { get; set; }
        public string PermissionMinutes { get; set; }

        public string MonthlyLate { get; set; }
        public string MonthlyEarly { get; set; }
        public string MonthlyAbsent { get; set; }
        public string MonthlyLateMinutes { get; set; }
        public string MonthlyEarlyMinutes { get; set; }
        public string MonthlyAbsentMinutes { get; set; }
        public string MonthlyPermission { get; set; } 

        public string GroupLate { get; set; }
        public string GroupEarly { get; set; }
        public string GroupLeave { get; set; }
        public string GroupAbsent { get; set; }
        public string GroupLateMinutes { get; set; }
        public string GroupEarlyMinutes { get; set; }
        public string GroupAbsentMinutes { get; set; } 
        
        public string MonthlyGroupLate { get; set; }
        public string MonthlyGroupEarly { get; set; }
        public string MonthlyGroupAbsent { get; set; }
        public string MonthlyGroupLateMinutes { get; set; }
        public string MonthlyGroupEarlyMinutes { get; set; }
        public string MonthlyGroupAbsentMinutes { get; set; }
        public string MonthlyPermissionMinutes { get; set; }

        public string InTime1 { get; set; }
        public string OutTime1 { get; set; }
        public string Shift1 { get; set; }
        public int RequireTime1 { get; set; }

        public string InTime2 { get; set; }
        public string OutTime2 { get; set; }
        public string Shift2 { get; set; }
        public int RequireTime2 { get; set; }

        public string InTime3 { get; set; }
        public string OutTime3 { get; set; }
        public string Shift3 { get; set; }
        public int RequireTime3 { get; set; }

        public int TotalScheduleRequireTime { get; set; }
        public string ExpectedTimeOut { get; set; }

        public string SchWithFlexible { get; set; }


        public string LeavesCount { get; set; }
        public string PermissionCount { get; set; }
        public string MissingMovementCount { get; set; }
        public string ManualMovementCount { get; set; }
    }
}