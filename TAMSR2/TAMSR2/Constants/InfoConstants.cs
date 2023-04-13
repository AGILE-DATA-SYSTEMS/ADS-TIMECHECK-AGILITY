using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WMD.Constants
{
    public static class InfoConstants
    {
        public enum DeviceType
        {
            RUGBO_ID = 1,
            CMI_IRIS
        }

        public struct DeviceStatuses
        {
            public const string Online = "Online";
            public const string Offline = "Offline";
            public const string UnAuthorized = "UnAuthorized";
        }
        public enum FunctionKeys
        {
            F1 = 1,
            F2 = 2,
            F3 = 3,
            F4,
            F5
        }

        public struct FunctionKeyTitles
        {
            public const string F1 = "launcher.auth.customkey.f1.message";
            public const string F2 = "launcher.auth.customkey.f2.message";
            public const string F3 = "launcher.auth.customkey.f3.message";
            public const string F4 = "launcher.auth.customkey.f4.message";
            public const string F5 = "launcher.auth.customkey.f5.message";
        }

        public struct MessageKeys
        {
            public const string DEVICE_NOT_FOUND = "Device not found.";
        }
    }
}