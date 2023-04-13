using System;
using CMITech.Client;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ADS_IRIS
{
    public class UMXClientInfo
    {
        public string IPAddress { get; set; }
        public string MacAddress { get; set; }
        public string DeviceName { get; set; }
        public UMXClientUtility uMXClientUtility { get; set; }
    }

    /// <summary>
    /// UMXClientUtility Multi-Manager
    /// </summary>
    public static class UMXClientManager
    {
        static List<UMXClientInfo> _clientList = new List<UMXClientInfo>();
        static object _syncLock = new object();

        public static UMXClientInfo Get(string ipAddress)
        {
            lock (_syncLock)
            {
                foreach (UMXClientInfo item in _clientList)
                {
                    if (item.IPAddress == ipAddress)
                        return item;
                }
            }
            return null;
        }

        public static List<UMXClientInfo> GetAll()
        {
            List<UMXClientInfo> clientList = new List<UMXClientInfo>();
            foreach (var client in _clientList)
            {
                UMXClientInfo ct = new UMXClientInfo();
                ct.IPAddress = client.IPAddress;
                ct.MacAddress = client.MacAddress;
                ct.DeviceName = client.DeviceName;
                ct.uMXClientUtility = client.uMXClientUtility;

                clientList.Add(ct);
            }

            return clientList;
        }

        public static void Add(string ipAddress, string macAddress, string deviceName, UMXClientUtility uMXClientUtility)
        {
            UMXClientInfo ct = new UMXClientInfo();
            ct.IPAddress = ipAddress;
            ct.IPAddress = macAddress;
            ct.DeviceName = deviceName;
            ct.uMXClientUtility = uMXClientUtility;

            Add(ct);
        }

        public static void Add(UMXClientInfo client)
        {
            lock (_syncLock)
            {
                if (Get(client.IPAddress) == null)
                    _clientList.Add(client);
            }
        }

        public static bool Remove(string ipAddress)
        {
            if (string.IsNullOrEmpty(ipAddress)) return false;
            lock (_syncLock)
            {
                return _clientList.Remove(Get(ipAddress));
            }
        }

        public static void Clear()
        {
            lock (_syncLock)
            {
                _clientList.Clear();
            }
        }

    }

}