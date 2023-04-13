using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Notification : BaseClass
    {
        public decimal ReceiverEmployeeID { get; set; }
        public decimal ReceiverEmployeeNameEn { get; set; }
        public decimal ReceiverEmployeeNameAr { get; set; }

        public decimal NotificationTypeID { get; set; }
        public decimal NotificationTypeEn { get; set; }
        public decimal NotificationTypeAr { get; set; }

        public int Status { get; set; }
        public string StatusEn { get; set; }
        public string StatusAr { get; set; }

        public bool MarkRead { get; set; }
    }
}