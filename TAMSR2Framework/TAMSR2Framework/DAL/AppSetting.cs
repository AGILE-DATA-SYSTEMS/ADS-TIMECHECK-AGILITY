/* **************************************************************
 * File Name        : AppSetting.cs
 * Description      : Basic Application Settings read from configuration file.
 * 
 * Author		    : Muhammad Aqeel Abbas @linktoaqeel
 * Created		    : May 22, 2013
 * Dependency	    : 
 * 
 * Revision History :
 * 
 * 
 * *************************************************************/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TAMSR2Framework.DAL
{
    public static class AppSetting
    {
        public static string numberFormat = (System.Configuration.ConfigurationSettings.AppSettings["numberFormat"] + "").Trim();
        public static string currencyFormat = (System.Configuration.ConfigurationSettings.AppSettings["currencyFormat"] + "").Trim();

        public static string domainName = (System.Configuration.ConfigurationSettings.AppSettings["domainName"] + "").Trim();
        public static string errorLogPath = (System.Configuration.ConfigurationSettings.AppSettings["errorLogPath"] + "").Trim();

        public static string defaultLanguage = (System.Configuration.ConfigurationSettings.AppSettings["defaultLanguage"] + "").Trim(); 
        public static string defaultCulture = (System.Configuration.ConfigurationSettings.AppSettings["defaultCulture"] + "").Trim();
        public static string defaultPullDirection = (System.Configuration.ConfigurationSettings.AppSettings["defaultPullDirection"] + "").Trim();

        public static string defaultApplicationDate = (System.Configuration.ConfigurationSettings.AppSettings["defaultApplicationDate"] + "").Trim();
        public static int defaultTimeZone = Numerics.GetInt((System.Configuration.ConfigurationSettings.AppSettings["defaultTimeZone"] + "").Trim());

        public static string longTimeFormat = (System.Configuration.ConfigurationSettings.AppSettings["longTimeFormat"] + "").Trim();
        public static string shortTimeFormat = (System.Configuration.ConfigurationSettings.AppSettings["shortTimeFormat"] + "").Trim();
        
        public static string dateFormat = (System.Configuration.ConfigurationSettings.AppSettings["dateFormat"] + "").Trim();
        public static string dateTimeFormat = (System.Configuration.ConfigurationSettings.AppSettings["dateTimeFormat"] + "").Trim();
        public static string dateTimeFormat24 = (System.Configuration.ConfigurationSettings.AppSettings["dateTimeFormat24"] + "").Trim();

        public static string webPunchDelay = (System.Configuration.ConfigurationSettings.AppSettings["webPunchDelay"] + "").Trim();

    }
}
