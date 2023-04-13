/* **************************************************************
 * File Name        : Numerics.cs
 * Description      : Convert objects into specific type and return it value to calling class
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
    public static class Numerics
    {
        public static bool GetBool(object obj)
        {
            try
            {
                if ((obj + "").ToLower() == "y")
                    return true;
                else if ((obj + "").ToLower() == "1")
                    return true;
                else if ((obj + "").ToLower() == "n")
                    return false;
                else if ((obj + "").ToLower() == "0")
                    return false;
                else 
                    return Convert.ToBoolean(obj);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public static int GetInt(object obj)
        {
            try
            {
                return Convert.ToInt32(obj);
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public static long GetLong(object obj)
        {
            try
            {
                return Convert.ToInt64(obj);
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public static double GetDouble(object obj)
        {
            try
            {
                return Convert.ToDouble(obj);
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public static decimal GetDecimal(object obj)
        {
            try
            {
                return Convert.ToDecimal(obj);
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public static DateTime GetDateTime(object obj)
        {
            try
            {
                return Convert.ToDateTime(obj);
            }
            catch (Exception ex)
            {
                return Convert.ToDateTime(AppSetting.defaultApplicationDate);
            }
        }

        public static byte[] GetByteArray(object obj)
        {
            try
            {
                return (byte[])obj;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static string ReverseString(string s)
        {
            char[] charArray = s.ToCharArray();
            Array.Reverse(charArray);
            return new string(charArray);
        }


        #region FormatMinsToHHmm
        /// <summary>
        /// This function is used to format given time in MINs to HH:MM 
        /// </summary>
        /// <param name="Mins"></param>
        public static string FormatMinsToHHmm(object obj)
        {
            long Mins = GetLong(obj);
            string sHHMM = "";
            if(Mins < 0)
                return "00:00";
            if (Mins < 60)
                sHHMM = "00:" + (Mins % 60 < 10 ? "0" + Mins % 60 : Mins % 60 + "");
            else
                sHHMM = (Mins / 60 < 10 ? "0" + Mins / 60 : Mins / 60 + "") + ":" + (Mins % 60 < 10 ? "0" + Mins % 60 : Mins % 60 + "");
            return sHHMM;
        }
        #endregion


    }
}
