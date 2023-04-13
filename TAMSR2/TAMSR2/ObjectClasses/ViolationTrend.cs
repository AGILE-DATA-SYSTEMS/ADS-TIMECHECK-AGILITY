using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class ViolationTrend
    {
        public string Late { get; set; }
        public string Early { get; set; }
        public string Absent { get; set; }
        public string Leave { get; set; }
        public string MissedIn { get; set; }
        public string MissedOut { get; set; }
        public string Permission { get; set; }
        public string Average { get; set; }

        public decimal LatePercentage { get; set; }
        public decimal EarlyPercentage { get; set; }
        public decimal AbsentPercentage { get; set; }
        public decimal LeavePercentage { get; set; }
        public decimal PresentPercentage { get; set; }
        public decimal MissedInPercentage { get; set; }
        public decimal MissedOutPercentage { get; set; }
        public decimal PermissionPercentage { get; set; }

        public ViolationTrend()
        {
            Late = "0,0,0,0,0,0,0,0,0,0,0,0";
            Early = "0,0,0,0,0,0,0,0,0,0,0,0";
            Absent = "0,0,0,0,0,0,0,0,0,0,0,0";
            Leave = "0,0,0,0,0,0,0,0,0,0,0,0";
            MissedIn = "0,0,0,0,0,0,0,0,0,0,0,0";
            MissedOut = "0,0,0,0,0,0,0,0,0,0,0,0";
            Permission = "0,0,0,0,0,0,0,0,0,0,0,0";
            Average = "0,0,0,0,0,0,0,0,0,0,0,0";

            LatePercentage = 0;
            EarlyPercentage = 0;
            AbsentPercentage = 0;
            LeavePercentage = 0;
            PresentPercentage = 0;
            MissedInPercentage = 0;
            MissedOutPercentage = 0;
            PermissionPercentage = 0;

        }
    }
}