using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADS_IRIS.DTOs
{
    public class LogDTO
    {
        public DateTime TransactionDateTime { get; set; }
        public string PersonID { get; set; }
        public string EventType { get; set; }
        public string DeviceIP { get; set; }
        public string DeviceMAC { get; set; }
        public string Remarks { get; set; }
        public string CreatedBy { get; set; }
        public string AdditionalData { get; set; }
    }
}
