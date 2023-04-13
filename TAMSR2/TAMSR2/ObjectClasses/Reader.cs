using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Reader : BaseClass
    {
        public decimal ConnectionID { get; set; }

        public decimal ReaderTypeID { get; set; }
        public string ReaderTypeName { get; set; }

        public decimal ConnectionTypeID { get; set; }
        public decimal GroupID { get; set; }
        public decimal LocationID { get; set; }
        public decimal RegionID { get; set; }
        public decimal DirectionID { get; set; }
        public decimal building_id { get; set; }
        public string IPAddress { get; set; }
        public string Port { get; set; }
        public string BaudRate { get; set; }
        public string Timeout { get; set; }

        public int EnableFlag { get; set; }
        public int WebPunchFlag { get; set; }

        public string ReaderLocation { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }

        
    }
}