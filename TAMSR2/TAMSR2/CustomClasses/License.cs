using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;
using System.Management;

namespace TAMSR2.CustomClasses
{
    public static class License
    {


        public static bool CheckAppValidation()
        {
            return true;
            string MBID = String.Empty;
            string PSID = String.Empty;

            ManagementObjectSearcher MOS = new ManagementObjectSearcher("Select * From Win32_BaseBoard");

            foreach (ManagementObject getserial in MOS.Get())
                MBID = getserial["SerialNumber"].ToString();

            MOS = new ManagementObjectSearcher("Select * From Win32_processor");

            foreach (ManagementObject getPID in MOS.Get())
                PSID = getPID["ProcessorID"].ToString();

            string[] CompanyLicenses = new string[2];

            CompanyLicenses[0] = ConfigurationManager.AppSettings["License-Primary"];
            CompanyLicenses[1] = ConfigurationManager.AppSettings["License-Secondry"];

            LicenseObject lObject = new LicenseObject();

            bool valid = false;
            string checkstring = "ENILYKS" + MBID + PSID;
            foreach (var item in CompanyLicenses)
            {
                var temp = License.Decrypt(item, true);

                if (!string.IsNullOrEmpty(temp))
                {
                    int index = temp.IndexOf("Date=");
                    string originallicense = temp.Substring(0, index);
                    string licenseDate = temp.Substring(index + 5);
                    lObject.EndTime = Convert.ToDateTime(licenseDate);
                    if (originallicense == checkstring)
                    {
                        if (lObject.EndTime > DateTime.Now)
                        {
                            valid = true;
                            break;
                        }
                    }
                }
            }
            return valid;

        }

        public static string Decrypt(string cipherString, bool useHashing)
        {
            if (string.IsNullOrEmpty(cipherString))
                return "";

            try { 
            byte[] keyArray;
            byte[] toEncryptArray = Convert.FromBase64String(cipherString);

            System.Configuration.AppSettingsReader settingsReader = new AppSettingsReader();
            //Get your key from config file to open the lock!
            string key = "SCIMANYDENILYKS";
            
            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                hashmd5.Clear();
            }
            else
                keyArray = UTF8Encoding.UTF8.GetBytes(key);

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
                        
            tdes.Clear();
            return UTF8Encoding.UTF8.GetString(resultArray);
            }
            catch (Exception ex)
            {

            }
            return string.Empty;
        }
        
       
    }
    class LicenseObject
    {

        public string Key { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string BoolTime { get; set; }
    }
}