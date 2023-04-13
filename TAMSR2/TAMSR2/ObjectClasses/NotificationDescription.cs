using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class NotificationDescription : BaseClass
    {
      
        public decimal NotificationTypeID { get; set; }
        public int Status { get; set; }
        public string NotificationType { get; set; }

    }
}