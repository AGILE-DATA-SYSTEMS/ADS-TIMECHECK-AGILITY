using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace ADS_IRIS.Utilities
{
    public static class HttpClientUtility
    {
        private static string RugboBaseURL = ConfigurationManager.AppSettings["RugboBaseURL"];
        private static string accessToken;
        //public static async Task<HttpResponseMessage> SendRequest(string url, string method, StringContent content)
        public static HttpResponseMessage SendRequest(string url, string method, StringContent content)
        {
            using (var client = new HttpClient())
            {
                bool refreshToken = true;
                //Passing service base url  
                UMXClientUtility.AddLog("TIMECHECK", "baseURL:" + RugboBaseURL);

                client.BaseAddress = new Uri(RugboBaseURL);
            tryAgain:
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                if (string.IsNullOrEmpty(accessToken))
                {
                    var user_name = ConfigurationManager.AppSettings["user_name"];
                    var password = ConfigurationManager.AppSettings["password"];

                    //var ip = GetIP();
                    //var mac = GetMACAddress();

                    var data = new
                    {
                        user_name = user_name,
                        password = password,
                        //DeviceMAC = mac,
                        //DeviceIP = ip
                    };

                    var stringContent = new StringContent(JsonConvert.SerializeObject(data), UnicodeEncoding.UTF8, "application/json");

                    HttpResponseMessage Res1 =  client.PostAsync("api/Auth/tokenformovement", stringContent).Result;

                    UMXClientUtility.AddLog("TIMECHECK", "api/Auth/tokenformovement ->" + JsonConvert.SerializeObject(Res1));

                    if (Res1.IsSuccessStatusCode)
                    {

                        var ObjResponse = Res1.Content.ReadAsStringAsync().Result;
                        var parsed = JsonConvert.DeserializeObject<dynamic>(ObjResponse);
                        accessToken = parsed.token;
                        UMXClientUtility.AddLog("TIMECHECK", "accessToken:" + accessToken);
                    }
                }

                client.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", accessToken.ToString());

                HttpResponseMessage response = null;
                switch (method)
                {
                    case "Post":
                        //return await client.PostAsync(url, content);
                        return client.PostAsync(url, content).Result;
                    case "Put":
                        //response = await client.PutAsync(url, content);
                        response = client.PutAsync(url, content).Result;
                        break;
                    case "Get":
                        //response = await client.GetAsync(url);
                        response = client.GetAsync(url).Result;
                        break;
                }

                if (response.IsSuccessStatusCode == false && refreshToken == true)
                {
                    accessToken = null;
                    refreshToken = false;
                    goto tryAgain;
                }

                return response;
            }

        }


        private static string GetIP()
        {
            string strHostName = "";
            strHostName = Dns.GetHostName();

            IPHostEntry ipEntry = Dns.GetHostEntry(strHostName);

            IPAddress[] addr = ipEntry.AddressList;

            return addr[addr.Length - 1].ToString();
        }

        private static string GetMACAddress()
        {
            string mac_src = "";
            string macAddress = "";

            foreach (System.Net.NetworkInformation.NetworkInterface nic in System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces())
            {
                if (nic.OperationalStatus == System.Net.NetworkInformation.OperationalStatus.Up)
                {
                    mac_src += nic.GetPhysicalAddress().ToString();
                    break;
                }
            }

            while (mac_src.Length < 12)
            {
                mac_src = mac_src.Insert(0, "0");
            }

            for (int i = 0; i < 11; i++)
            {
                if (0 == (i % 2))
                {
                    if (i == 10)
                    {
                        macAddress = macAddress.Insert(macAddress.Length, mac_src.Substring(i, 2));
                    }
                    else
                    {
                        macAddress = macAddress.Insert(macAddress.Length, mac_src.Substring(i, 2)) + "-";
                    }
                }
            }
            return macAddress;
        }
    }
}
