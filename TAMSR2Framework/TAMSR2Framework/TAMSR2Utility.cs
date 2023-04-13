/* **************************************************************
 * File Name        : TAMSR2Utility.cs
 * Description      : Base class for all items
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
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace TAMSR2Framework
{
    /// <summary>
    /// TAMSR2 Utility Class
    /// </summary>
    public class TAMSR2Utility
    {
        #region UtilConsts
        /// <summary>
        /// Constants holding null values for specific data types. These values will be equivalent to NULL 
        /// for that data Type through out the project. 
        /// </summary>
        public const int INTNULL = -99999;
        public const long LONGNULL = -9999999;
        public const float FLOATNULL = -99999.9999f;
        public const double DOUBLENULL = -9999999.999999;
        public static DateTime DATENULL = System.DateTime.MinValue;
        #endregion

        #region Constructor
        public TAMSR2Utility()
        {
        }
        #endregion

        #region static string MonthName
        /// <summary>
        /// Get Name of the given month
        /// </summary>
        /// <param name="idMonth">Month Number ( 1- Jan)</param>
        /// <returns>Month Name</returns>
        public static string MonthName(int idMonth)
        {

            if (idMonth < 1 || idMonth > 12)
                return "Invalid";

            string temp;
            DateTime dt = new DateTime();
            temp = idMonth.ToString() + "/" + idMonth.ToString() + "/2000";
            dt = Convert.ToDateTime(temp);
            temp = dt.ToString("MMM");
            return temp;
        }
        #endregion

        #region static string Encrypt

        /// <summary>
        /// Encrypt a given string
        /// </summary>
        /// <param name="plainText">string to encrypt</param>
        /// <returns>encrypted string</returns>
        public static string Encrypt(string plainText)
        {
            string encrypted, key;
            TripleDESCryptoServiceProvider des;
            MD5CryptoServiceProvider hashmd5;
            byte[] pwdhash, buff;

            //create a secret key. the key is used to encrypt string
            key = "DhimTharikitaThom!";


            //generate an MD5 hash from the key. 
            hashmd5 = new MD5CryptoServiceProvider();
            pwdhash = hashmd5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(key));
            hashmd5 = null;

            //implement DES3 encryption
            des = new TripleDESCryptoServiceProvider();
            des.Key = pwdhash;

            // The mode is the block cipher mode which is basically the
            // details of how the encryption will work.  Here the Electronic 
            //Code Book (ECB) cipher is used which means that a given bit of text is 
            // always encrypted exactly the same when the same password is used.
            des.Mode = CipherMode.ECB;

            // the original string, which needs encrypted, must be in byte
            // array form to work with the des3 class. Encryption works at the 
            // byte level so the class takes in byte arrays and returns byte arrays 
            // and be converting those arrays to strings.
            buff = ASCIIEncoding.ASCII.GetBytes(plainText);

            //encrypt the byte buffer representation of the original string
            //Base64 encoding provides a platform independent view of the encrypted 
            //string and can be sent as a plain text string to wherever.
            encrypted = Convert.ToBase64String(
                des.CreateEncryptor().TransformFinalBlock(buff, 0, buff.Length)
                );

            return encrypted;

        }

        #endregion

        #region static Check Null Functions

        /// <summary>
        /// Checks whether the specified data is null.
        /// </summary>
        /// <param name="dataToCheck"></param>
        /// <returns></returns>
        public static string CheckNull(int dataToCheck)
        {
            if (TAMSR2Utility.INTNULL == dataToCheck)
            {
                return "null";
            }
            else
            {
                return dataToCheck.ToString();
            }
        }

        /// <summary>
        /// Checks whether the specified data is null.
        /// </summary>
        /// <param name="dataToCheck"></param>
        /// <returns></returns>
        public static string CheckNull(long dataToCheck)
        {
            if (TAMSR2Utility.LONGNULL == dataToCheck)
            {
                return "null";
            }
            else
            {
                return dataToCheck.ToString();
            }
        }

        /// <summary>
        /// Checks whether the specified data is null.
        /// </summary>
        /// <param name="dataToCheck"></param>
        /// <returns></returns>
        public static string CheckNull(double dataToCheck)
        {
            if (TAMSR2Utility.DOUBLENULL == dataToCheck)
            {
                return "null";
            }
            else
            {
                return dataToCheck.ToString();
            }
        }

        /// <summary>
        /// Checks whether the specified data is null.
        /// </summary>
        /// <param name="dataToCheck"></param>
        /// <returns></returns>
        public static string CheckNull(string dataToCheck)
        {
            if (0 == dataToCheck.Trim().Length)
            {
                return "null";
            }
            else
            {
                dataToCheck = dataToCheck.Replace("'", "''");
                return "'" + dataToCheck + "'";
            }
        }

        /// <summary>
        /// Checks whether the specified data is null.
        /// </summary>
        /// <param name="dataToCheck"></param>
        /// <returns></returns>
        public static string CheckNull(DateTime dataToCheck)
        {
            if (TAMSR2Utility.DATENULL == dataToCheck)
            {
                return "null";
            }
            else
            {
                string database = ConfigurationSettings.AppSettings["Database"];
                string dateString = "'" + dataToCheck.ToString(DateTimeFormatInfo.InvariantInfo) + "'";

                if (database.Equals("Oracle"))
                    dateString = "to_date(" + dateString + ",'mm/dd/yyyy hh24:mi:ss')";

                return dateString;
            }
        }

        #endregion

        #region static string MonthFullName
        /// <summary>
        /// Return string full month name for the month number.
        /// </summary>
        /// <param name="MonthNumber"></param>
        /// <returns></returns>
        public static string MonthFullName(int MonthNumber)
        {
            if (MonthNumber < 1 || MonthNumber > 12)
                return "Invalid";

            string tmpName;
            DateTime dt = new DateTime();
            tmpName = MonthNumber.ToString() + "/" + MonthNumber.ToString() + "/2000";
            dt = Convert.ToDateTime(tmpName);
            tmpName = dt.ToString("MMMM");
            return tmpName;
        }
        #endregion

    }
}
