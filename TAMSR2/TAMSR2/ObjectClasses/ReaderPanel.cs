using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class ReaderPanel : BaseClass
    {
        public decimal OrgID { get; set; }
        public string Code { get; set; }
        public int InuseFlag { get; set; }
    }
}