using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class EmployeeVerification : BaseClass
    {
        public string Code { get; set; }
        public string VerificationTime { get; set; }
        public DateTime TransactionDate { get; set; }
        public string TransactionDateStr { get; set; }
        public string ApprovedByNameEn { get; set; }
        public string ApprovedByNameEng { get; set; }
        public DateTime ApprovedDate { get; set; }
        public string ApprovedDateStr { get; set; }
        public int status { get; set; }

    }
}