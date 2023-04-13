using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Zones : BaseClass
    {
      //  public int ID { get; set;}
        public string Code { get; set; }
        public string is_active { get; set; }
        public string is_deleted { get; set; }
        //public string DescriptionEn { get; set; }
        //public string DescriptionAr { get; set; }
        //public string CreatedOn { get; set; }
        //public string CreatedBy { get; set; }
        //public string UpdatedOn { get; set; }
        //public string UpdatedBy { get; set; }
    }
}