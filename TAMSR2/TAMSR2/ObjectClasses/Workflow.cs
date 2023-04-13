using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Workflow
    {
        public decimal ID  { get; set; }
        public string Code { get; set; }
        public string Category { get; set; }
        public int Level { get; set; }
        public string Type1 { get; set; }
        public string Value1 { get; set; }
        public string OnSuccess1 { get; set; }
        public string OnFailure1 { get; set; }
        public string StatusText1 { get; set; }
        public string Type2 { get; set; }
        public string Value2 { get; set; }
        public string OnSuccess2 { get; set; }
        public string OnFailure2 { get; set; }
        public string StatusText2 { get; set; }
        public string Type3 { get; set; }
        public string Value3 { get; set; }
        public string OnSuccess3 { get; set; }
        public string OnFailure3 { get; set; }
        public string StatusText3 { get; set; }
        public string Type4 { get; set; }
        public string Value4 { get; set; }
        public string OnSuccess4 { get; set; }
        public string OnFailure4 { get; set; }
        public string StatusText4 { get; set; }
    } 
}