using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class DataReprocessStack
    {
        public int Stack_id { get; set; }

        public int Timecheck_Module_Id { get; set; }
        public int Company_Id { get; set; }
        public int Org_id { get; set; }
        public int Employee_id { get; set; }
        public string From_date { get; set; }
        public string To_date { get; set; }
        public int UpdateAll { get; set; }
        public int Status { get; set; }
        public string Error { get; set; }
        public int CreatedBy { get; set; }

        public string CreatedOn { get; set; }

        public int UpdatedBy { get; set; }

        public string UpdatedOn { get; set; }


        public string ModuleName { get; set; }











    }
}