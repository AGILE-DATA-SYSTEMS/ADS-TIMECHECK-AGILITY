using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Designation : BaseClass
    {
        public string Code { get; set; }
        public int Vacancy { get; set; }
        public string Remarks { get; set; }
    }
}