
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using Portable.Licensing;
using Portable.Licensing.Security;
using Portable.Licensing.Validation;
using System.Management;
using TAMSR2.CustomClasses;
using System.Text;
using System.Collections;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using System.Configuration;
using System.Data;
using System.Reflection;
using System.Web.Configuration;
namespace TAMSR2.ObjectClasses
{
    public class TAMSR2Licence : BaseClass
    {

        public decimal ID { get; set; }
        public string Name { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string ActiveDate { get; set; }
        public string Type { get; set; }
        public string CompName { get; set; }
        public bool IsActive { get; set; }
        public bool isValid { set; get; }
        public int Days { get; set; }
        public string ProductVersion { get; set; }
        public string LastBuildDate { get; set; }

        public string Primary_License { get; set; }
        public string Secondary_License { get; set; }

        public TAMSR2Licence()
        {
        }

        #region KeyGenerator

        public void GenerateKey(LicenseType Type, DateTime ExpiryDate, TAMSR2Licence LicenseFeature, string UserLicsenceID, string Username, string UserEmail)
        {


            try
            {
                var keyGenerator = Portable.Licensing.Security.Cryptography.KeyGenerator.Create();
                var keyPair = keyGenerator.GenerateKeyPair();
                var privateKey = keyPair.ToEncryptedPrivateKeyString(UserLicsenceID);
                //var publicKey = keyPair.ToPublicKeyString();
                var license = Portable.Licensing.License.New().WithUniqueIdentifier(Guid.NewGuid()).As(Type).ExpiresAt(ExpiryDate)
                                //.WithProductFeatures(new Dictionary<string, string>
                                //    {
                                //    {"ENABLE_ZONES", LicenseFeature.ENABLE_ZONES.ToString()},
                                //    {"MAX_ZONES_ALLOWED", LicenseFeature.MAX_ZONES_ALLOWED.ToString()},
                                //    {"ENABLE_DEVICE_MANAGEMENT", LicenseFeature.ENABLE_DEVICE_MANAGEMENT.ToString()},
                                //    {"MAX_DEVICES_ALLOWED", LicenseFeature.MAX_DEVICES_ALLOWED.ToString()},
                                //    {"MAX_USERS_ALLOWED", LicenseFeature.MAX_USERS_ALLOWED.ToString()}
                                //    })
                                .LicensedTo(Username, UserEmail)
                                .CreateAndSignWithPrivateKey(privateKey, UserLicsenceID);

                string file = HttpContext.Current.Server.MapPath("~/App_Data/License/") + "License.lic";
                File.WriteAllText(file, Encryption.Encrypt_AES(license.ToString()), System.Text.Encoding.UTF8);
            }
            catch (Exception ex)
            {

            }

        }

        #endregion

        #region ValidateLicense

        public static bool ValidateLicense()
        {
            return true;
            bool result = false;
            string LicenseValidDays = "0";
            
            try
            {


                if (HttpContext.Current.Session["PRIMARY_LICENSE"] + "" == "")
                {

                   
                   // string Primarylicensexml = "";
                   // string Secondarylicensexml = "";

                   // var licPrimaryPath = HttpContext.Current.Server.MapPath("~/License/") + "Primary.Skyline";
                   // var licSecondaryPath = HttpContext.Current.Server.MapPath("~/License/") + "Secondary.Skyline";

                   //if (File.Exists(licPrimaryPath))
                   //{
                   //    Primarylicensexml = File.ReadAllText(licPrimaryPath, System.Text.Encoding.UTF8);
                   //    HttpContext.Current.Session["PRIMARY_LICENSE"] = Primarylicensexml + "";
                   //}
                   //else if (File.Exists(licSecondaryPath))
                   //{
                   //    Secondarylicensexml = File.ReadAllText(licSecondaryPath, System.Text.Encoding.UTF8);
                   //    HttpContext.Current.Session["SECONDARY_LICENSE"] = Secondarylicensexml + "";
                   //}
                   //else
                   //{
                   //    HttpContext.Current.Session["VALID_LICENSE"] = false;
                   //    return false;
                   //}


                    Hashtable ht = new Hashtable();
                    ht.Add("action", "getByCode");
                    ht.Add("Code", (ConfigurationManager.AppSettings["CompCode"] + "").Trim());
                    TAMSR2Data objDAL = new TAMSR2Data();
                    objDAL.OpenConnection(Connection.GetConnectionStrinng());
                    DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_CompanyOps", ht);//TAMSR2_OrgTypeOps
                    if (objDataView != null)
                    {
                        DataRow rw = objDataView[0].Row;
                        HttpContext.Current.Session["PRIMARY_LICENSE"] = objDataView[0]["PrimaryLicenseKey"] + "";
                        HttpContext.Current.Session["SECONDARY_LICENSE"] = objDataView[0]["SecondaryLicenseKey"] + "";
                        HttpContext.Current.Session["PRODUCT_VERSION"] = objDataView[0]["ProductVersion"] + "";
                        HttpContext.Current.Session["LAST_BUILD_DATE"] = objDataView[0]["LastBuildDate"] + "";
                    }
                }



                string HardwareID = CPUID();
                HttpContext.Current.Session["HARDWARE_ID"] = HardwareID.ToString();
                IValidationFailure failure1 = null; 
                //string licensexml = File.ReadAllText(licpath, System.Text.Encoding.UTF8);
                string licensexml = Encryption.Decrypt_AES(HttpContext.Current.Session["PRIMARY_LICENSE"] + "");
                if (licensexml == "")
                    licensexml = Encryption.Decrypt_AES(HttpContext.Current.Session["SECONDARY_LICENSE"] + "");

                

                var license = Portable.Licensing.License.Load(licensexml);
                var PublicKey = license.AdditionalAttributes.Get("PublicKey"); ;
                 
                var validationFailures = license.Validate()
                                                           .ExpirationDate()
                    //  .When(lic => lic.Type == Portable.Licensing.LicenseType.Standard)
                                                           .And()
                                                           .AssertThat(lic => lic.AdditionalAttributes.Get("MachineID") == HardwareID, failure1)
                                                           //.When(lic => lic.Type == Portable.Licensing.LicenseType.Standard)
                    //.When(lic => lic.AdditionalAttributes.Contains("HardwareID"))
                                                           .And()
                                                           .Signature(PublicKey)
                                                           .AssertValidLicense().ToList();

                if (validationFailures.Any())
                {
                    IValidationFailure failure2 = null;

                    string licensexml1 = Encryption.Decrypt_AES(HttpContext.Current.Session["SECONDARY_LICENSE"] + "");
                    var license1 = Portable.Licensing.License.Load(licensexml1);
                    var PublicKey1 = license1.AdditionalAttributes.Get("PublicKey"); ;
                    var validationFailures1 = license1.Validate()
                                                          .ExpirationDate()
                        //  .When(lic => lic.Type == Portable.Licensing.LicenseType.Standard)
                                                           .And()
                                                           .AssertThat(lic => lic.AdditionalAttributes.Get("MachineID") == HardwareID, failure2)
                                                           .When(lic => lic.Type == Portable.Licensing.LicenseType.Standard)
                        //.When(lic => lic.AdditionalAttributes.Contains("HardwareID"))
                                                           .And()
                                                           .Signature(PublicKey1)
                                                           .AssertValidLicense().ToList();
   
                    if (validationFailures1.Any())
                    {
                        result = false;
                        if (HttpContext.Current.Session != null)
                        {

                        HttpContext.Current.Session["VALID_LICENSE"] = false;
                        HttpContext.Current.Session["LICENSE_TYPE"] = license.Type.ToString();
                        HttpContext.Current.Session["EXPIRY_DATE"] = license.Expiration + ""; 
                        HttpContext.Current.Session["LICENSED_TYPE"] = "Unknown";
                        HttpContext.Current.Session["LICENSED_TO"] = "Unknown"  + "";
                        HttpContext.Current.Session["START_DATE"] =  "9999-12-31" + "";
                        HttpContext.Current.Session["ACTIVATION_DATE"] = "9999-12-31"  + "";   

                            if (validationFailures[0].HowToResolve == null)
                                HttpContext.Current.Session["LICENSE_ERROR_MESSAGE"] = validationFailures[0].Message;
                            else
                                HttpContext.Current.Session["LICENSE_ERROR_MESSAGE"] = validationFailures[0].HowToResolve;
                        }
                    }
                    else
                    {
                        result = true;
                         
                        HttpContext.Current.Session["VALID_LICENSE"] = true;
                        HttpContext.Current.Session["LICENSE_TYPE"] = license.Type.ToString();
                        HttpContext.Current.Session["EXPIRY_DATE"] = license.Expiration + "";
                        HttpContext.Current.Session["LICENSED_TYPE"] = license.ProductFeatures.GetAll()["LICENSED_TYPE"] + "";
                        HttpContext.Current.Session["LICENSED_TO"] = license.ProductFeatures.GetAll()["LICENSED_TO"] + "";
                        HttpContext.Current.Session["START_DATE"] = license.ProductFeatures.GetAll()["START_DATE"] + "";
                        HttpContext.Current.Session["ACTIVATION_DATE"] = license.ProductFeatures.GetAll()["ACTIVATION_DATE"] + ""; 
                    }
                }
                else
                {
                    result = true;

                        HttpContext.Current.Session["VALID_LICENSE"] = true;
                        HttpContext.Current.Session["LICENSE_TYPE"] = license.Type.ToString();
                        HttpContext.Current.Session["EXPIRY_DATE"] = license.Expiration + ""; 
                        HttpContext.Current.Session["LICENSED_TYPE"] = license.ProductFeatures.GetAll()["LICENSED_TYPE"] + "";
                        HttpContext.Current.Session["LICENSED_TO"] = license.ProductFeatures.GetAll()["LICENSED_TO"] + "";
                        HttpContext.Current.Session["START_DATE"] = license.ProductFeatures.GetAll()["START_DATE"] + "";
                        HttpContext.Current.Session["ACTIVATION_DATE"] = license.ProductFeatures.GetAll()["ACTIVATION_DATE"] + "";
                        
                }
            }
            catch (Exception ex)
            {
                HttpContext.Current.Session["VALID_LICENSE"] = false;
                HttpContext.Current.Session["LICENSE_TYPE"] = "Unknown";
                HttpContext.Current.Session["EXPIRY_DATE"] = "9999-12-31" + "";
                HttpContext.Current.Session["LICENSED_TYPE"] = "Unknown";
                HttpContext.Current.Session["LICENSED_TO"] = "Unknown" + "";
                HttpContext.Current.Session["START_DATE"] = "9999-12-31" + "";
                HttpContext.Current.Session["ACTIVATION_DATE"] = "9999-12-31" + ""; 
                result = false;
            }
            
            
            return result;
        }

        public bool IsValidLicense(string LicenseKey)
        {
            bool result = false;
            try
            {
                string HardwareID = CPUID();
                HttpContext.Current.Session["HARDWARE_ID"] = HardwareID.ToString();
                IValidationFailure failure1 = null;
                string licensexml = Encryption.Decrypt_AES(LicenseKey);  
                var license = Portable.Licensing.License.Load(licensexml);
                var PublicKey = license.AdditionalAttributes.Get("PublicKey"); ;

                var validationFailures = license.Validate().ExpirationDate()
                                                           .And()
                                                           .AssertThat(lic => lic.AdditionalAttributes.Get("MachineID") == HardwareID, failure1)
                                                           .And()
                                                           .Signature(PublicKey)
                                                           .AssertValidLicense().ToList();

                if (validationFailures.Any())
                {
                    result = false;
                }
                else
                {
                    result = true;
                     
                }
            }
            catch (Exception ex)
            {

                result =  false;
            }

            return result;
        }

        public TAMSR2Licence(string LicenseKey)
        {
            
            try
            {
                string HardwareID = CPUID();
                HttpContext.Current.Session["HARDWARE_ID"] = HardwareID.ToString();
                IValidationFailure failure1 = null;
                string licensexml = Encryption.Decrypt_AES(LicenseKey);
                var license = Portable.Licensing.License.Load(licensexml);
                var PublicKey = license.AdditionalAttributes.Get("PublicKey"); ;

                var validationFailures = license.Validate().ExpirationDate()
                                                            //.AssertThat(lic => lic.AdditionalAttributes.Get("MachineID") == HardwareID, failure1)
                                                           .And()
                                                           .Signature(PublicKey)
                                                           .AssertValidLicense().ToList();

                if (validationFailures.Any())
                {
                    isValid = false;
                }
                else
                {
                    isValid = true;
                    Name = "SLA";
                    StartDate = license.ProductFeatures.GetAll()["START_DATE"] + "";
                    EndDate = license.ProductFeatures.GetAll()["END_DATE"] + "";

                    if (DateTime.Now >= Convert.ToDateTime(StartDate) && DateTime.Now <= Convert.ToDateTime(EndDate))
                    {
                        IsActive = true;
                    }
                    else
                    {
                        IsActive = false;
                    }

                }
            }
            catch (Exception ex)
            {

                 
            }
             
        }

        public string GetLicenseRemainigDays()
        {
            string Days = "0";
            try
            {
                
                    Hashtable ht = new Hashtable();
                    ht.Add("action", "getRemainingDays");
                    ht.Add("CompanyCode", (ConfigurationManager.AppSettings["CompCode"] + "").Trim());
                    TAMSR2Data objDAL = new TAMSR2Data();
                    objDAL.OpenConnection(Connection.GetConnectionStrinng());
                    DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_LicenseOps", ht);
                    if (objDataView != null)
                    {
                        Days =    objDataView[0][0] + "" ;
                    }
                    else
                    {
                        Days = "0";
                    }
                
            }
            catch (Exception ex)
            {
                Days = "0";
            }
            return Days;
        }

        #endregion

        #region GETSystemIDs

        private static string identifier(string wmiClass, string wmiProperty, string wmiMustBeTrue)
        {
            string result = "";
            ManagementClass mc = new System.Management.ManagementClass(wmiClass);
            ManagementObjectCollection moc = mc.GetInstances();
            foreach (ManagementObject mo in moc)
            {
                if (mo[wmiMustBeTrue].ToString() == "True")
                {
                    //Only get the first one
                    if (result == "")
                    {
                        try
                        {
                            result = mo[wmiProperty].ToString();
                            break;
                        }
                        catch
                        {
                        }
                    }
                }
            }
            return result;
        }
        //Return a hardware identifier
        private static string identifier(string wmiClass, string wmiProperty)
        {
            string result = "";
            ManagementClass mc = new System.Management.ManagementClass(wmiClass);
            ManagementObjectCollection moc = mc.GetInstances();
            foreach (ManagementObject mo in moc)
            {
                //Only get the first one
                if (result == "")
                {
                    try
                    {
                        result = mo[wmiProperty].ToString();
                        break;
                    }
                    catch
                    {
                    }
                }
            }
            return result;
        }
        public static string CPUID()
        {
            //Uses first CPU identifier available in order of preference
            //Don't get all identifiers, as it is very time consuming
            string retVal = identifier("Win32_Processor", "UniqueId");
            retVal += identifier("Win32_Processor", "ProcessorId");
            retVal += identifier("Win32_Processor", "DeviceID");
            retVal += identifier("Win32_Processor", "PNPDeviceID");
            retVal += identifier("Win32_Processor", "MaxClockSpeed");
            if (retVal == "") //If no UniqueID, use ProcessorID
            {
                retVal = identifier("Win32_Processor", "ProcessorId");
                if (retVal == "") //If no ProcessorId, use Name
                {
                    retVal = identifier("Win32_Processor", "Name");
                    if (retVal == "") //If no Name, use Manufacturer
                    {
                        retVal = identifier("Win32_Processor", "Manufacturer");
                    }
                    //Add clock speed for extra security
                    retVal += identifier("Win32_Processor", "MaxClockSpeed");
                }
            }
            //Add clock speed for extra security
            //retVal += identifier("Win32_Processor", "MaxClockSpeed");
            return retVal;
        }


        public string HardwareID()
        {
            //Uses first CPU identifier available in order of preference
            //Don't get all identifiers, as it is very time consuming
            string retVal = identifier("Win32_Processor", "UniqueId");
            retVal += identifier("Win32_Processor", "ProcessorId");
            retVal += identifier("Win32_Processor", "DeviceID");
            retVal += identifier("Win32_Processor", "PNPDeviceID");
            retVal += identifier("Win32_Processor", "MaxClockSpeed");
            if (retVal == "") //If no UniqueID, use ProcessorID
            {
                retVal = identifier("Win32_Processor", "ProcessorId");
                if (retVal == "") //If no ProcessorId, use Name
                {
                    retVal = identifier("Win32_Processor", "Name");
                    if (retVal == "") //If no Name, use Manufacturer
                    {
                        retVal = identifier("Win32_Processor", "Manufacturer");
                    }
                    //Add clock speed for extra security
                    retVal += identifier("Win32_Processor", "MaxClockSpeed");
                }
            }
            //Add clock speed for extra security
            //retVal += identifier("Win32_Processor", "MaxClockSpeed");
            return retVal;
        }
        #endregion

         

        public static void UpdateBuildDate()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                Assembly assembly = Assembly.LoadFile(HttpContext.Current.Server.MapPath("~/bin/TAMSR2.dll"));
                var filePath = assembly.Location;
                const int c_PeHeaderOffset = 60;
                const int c_LinkerTimestampOffset = 8;

                var buffer = new byte[2048];

                using (var stream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
                    stream.Read(buffer, 0, 2048);

                var offset = BitConverter.ToInt32(buffer, c_PeHeaderOffset);
                var secondsSince1970 = BitConverter.ToInt32(buffer, offset + c_LinkerTimestampOffset);
                var epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);

                var linkTimeUtc = epoch.AddSeconds(secondsSince1970);

                HttpContext.Current.Session["LAST_BUILD_DATE"] = linkTimeUtc + "";

                Configuration webConfigApp = WebConfigurationManager.OpenWebConfiguration("~");

                if (ConfigurationManager.AppSettings["buildDate"] + "" == "")
                {

                    webConfigApp.AppSettings.Settings["buildDate"].Value = linkTimeUtc + "";
                    webConfigApp.Save();


                    string chk = "0";
                    Hashtable ht = new Hashtable();
                    ht.Add("action", "UpdateBuildDate");
                    ht.Add("Code", ConfigurationManager.AppSettings["CompCode"] + "");
                    ht.Add("BuildDate", linkTimeUtc + "");

                    objDAL.OpenConnection();
                    string result = objDAL.Connection.GetValueProcedure("TAMSR2_CompanyOps", ht);
                    if (Numerics.GetDecimal(result) >= 0)
                    {
                        chk = result;
                    }
                    else
                    {
                        chk = "-1";
                    }
                }
                else
                {
                    if (ConfigurationManager.AppSettings["buildDate"] + "" != linkTimeUtc + "")
                    {
                        webConfigApp.AppSettings.Settings["buildDate"].Value = linkTimeUtc + "";
                        webConfigApp.Save();
                        Hashtable ht = new Hashtable();
                        ht.Add("action", "UpdateBuildDate");
                        ht.Add("Code", ConfigurationManager.AppSettings["CompCode"] + "");
                        ht.Add("BuildDate", linkTimeUtc + "");

                        objDAL.OpenConnection();
                        string result = objDAL.Connection.GetValueProcedure("TAMSR2_CompanyOps", ht);

                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/CompanyPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
        } 

         

    }
}