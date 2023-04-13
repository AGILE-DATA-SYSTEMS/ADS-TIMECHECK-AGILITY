using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Grade : BaseClass
    {
        public string Code { get; set; }
        public int NoOfCl { get; set; }
        public int NoOfSl { get; set; }
        public int NoOfAl { get; set; }
        public string OvertimeEligible { get; set; }
        public string SeniorFlag { get; set; }
    }
}
