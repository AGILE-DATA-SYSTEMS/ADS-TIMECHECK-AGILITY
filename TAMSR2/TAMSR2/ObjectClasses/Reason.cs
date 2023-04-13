using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Reason : BaseClass
    {
        public string Code { get; set; }
        public int ReasonMode { get; set; }
        public string PromptMsg { get; set; }
        public bool WebPunch { get; set; }
        public decimal Deleteable { get; set; }
        public decimal NormalIn { get; set; }
        public decimal NormalOut { get; set; }
    }
}