using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class TabNotification : BaseClass
    {
        public decimal Leave { get; set; }
        public decimal Permission { get; set; }
        public decimal Movement { get; set; }
        public decimal MissTime { get; set; }
        public decimal ExtraTime { get; set; }
        public decimal Late { get; set; }
        public decimal Early { get; set; }
        public decimal Absent { get; set; }

    }
}