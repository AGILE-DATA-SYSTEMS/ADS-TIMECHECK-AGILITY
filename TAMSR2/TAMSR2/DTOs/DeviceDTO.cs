using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADS_IRIS.DTOs
{
    public class DeviceDTO
    {
        public string id { get; set; }
        public string status { get; set; }
        public string name { get; set; }
        public string bioClientID { get; set; }
        public string ipAddress { get; set; }
        public string macAddress { get; set; }
        public string type { get; set; }
        public string sync { get; set; }
        public string login_method { get; set; }
        public string punch_method { get; set; }
    }
}
