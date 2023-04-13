using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class TAEvent : BaseClass
    {
        public decimal EmployeeID { get; set; }
        public decimal ReasonID { get; set; }
        public decimal ReaderID { get; set; }

        public DateTime TransactionDateTime { get; set; }
        public string TransactionDateTimeStr { get; set; }
        public string TransactionDateStr { get; set; }
        public string TransactionTimeStr { get; set; }

        public string Remarks { get; set; }
        public int UserEntryFlag { get; set; }
        public string Status { get; set; }
    }
}