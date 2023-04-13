using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class BaseClass
    {
        public decimal ID { get; set; }
        public string Code { get; set; }
        public string NameEn { get; set; }
        public string NameAr { get; set; }
        public string DescriptionEn { get; set; }
        public string DescriptionAr { get; set; }
        public DateTime CreatedOn { get; set; }
        public decimal CreatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
        public decimal UpdatedBy { get; set; }
    }
}