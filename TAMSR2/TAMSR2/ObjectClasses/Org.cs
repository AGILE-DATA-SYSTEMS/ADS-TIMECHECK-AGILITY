using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class Org : BaseClass
    {
        public decimal OrgTypeID { get; set; }
        public decimal ParentID { get; set; }
        public decimal ParentTypeID { get; set; }
        public string Code { get; set; }
        public string BranchFlag { get; set; }
        public int OpenShiftFlag { get; set; }
        public int InActiveFlag { get; set; }
        public int CalculateMonthlyMissedHours { get; set; }

        public DateTime InactiveDate { get; set; }
        public string InactiveDateStr { get; set; }
    }
}