using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class GroupStats
    {
        public decimal AchievedHours { get; set; }
        public decimal MonthlyAchievedHours { get; set; }
        public string MonthlyAchievedHoursColor { get; set; }
        public string MonthlyLate { get; set; }
        public string MonthlyEarly { get; set; }
        public string MonthlyLeave { get; set; }
        public string MonthlyAbsent { get; set; }
        public string MonthlyMissedIn { get; set; }
        public string MonthlyMissedOut { get; set; } 
        public string MonthlyPermissions { get; set; }
        public GroupStats()
        {
            AchievedHours = 0;
            MonthlyAchievedHours = 0;
        }
    }
}