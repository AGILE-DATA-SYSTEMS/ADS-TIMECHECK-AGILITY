using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Device
    {
            
           public string DeviceID { get; set; } 
           public string DeviceCode { get; set; } 
           public string DeviceName { get; set; } 
           public string MACAddress { get; set; } 
           public string IPAddress { get; set; } 
           public string Status { get; set; } 
           public bool IsActive { get; set; } 
           //public string Sync { get; set; }
        //public int isAuthorized { get; set; }
        public string Actions { get; set; } 

    }
}