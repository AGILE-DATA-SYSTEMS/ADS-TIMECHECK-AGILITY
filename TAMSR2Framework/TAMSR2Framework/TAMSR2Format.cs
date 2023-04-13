/* **************************************************************
 * File Name        : TAMSR2Format.cs
 * Description      : TAMSR2Format Format Manager Class
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
using TAMSR2Framework.DAL;

namespace TAMSR2Framework
{
    /// <summary>
    /// TAMSFormat controls the format of all items in TAMS
    /// </summary>
    public class TAMSR2Format
    {
        #region constructors
        /// <summary>
        /// empty constructor
        /// </summary>
        public TAMSR2Format()
        {
        }
        #endregion

        #region static methods
        /// <summary>
        /// date format for TAMS application
        /// </summary>
        public static string DateFormat
        {
            get
            {
                return AppSetting.dateFormat;
            }
        }
        /// <summary>
        /// Long time format for TAMS application
        /// </summary>
        public static string LongTimeFormat
        {
            get
            {
                return AppSetting.longTimeFormat;
            }
        }
        /// <summary>
        /// Short time format for TAMS application
        /// </summary>
        public static string ShortTimeFormat
        {
            get
            {
                return AppSetting.shortTimeFormat;
            }
        }

        /// <summary>
        /// Property for storing the Date and time format
        /// </summary>
        /// <remarks>
        ///		MM - month
        ///		dd - day
        ///		yyyy  - Year
        ///		hh	- hours in 12 hour format
        ///		mm - minutes
        ///		tt - meridiem
        /// </remarks>
        public static string DateTimeFormat
        {
            get
            {
                return AppSetting.dateTimeFormat;
            }
        }

        /// <summary>
        /// Date Time format in 24 hours.
        /// </summary>
        public static string DateTimeFormat24
        {
            get
            {
                return AppSetting.dateTimeFormat24;
            }
        }

        /// <summary>
        /// Number format for TAMS application
        /// </summary>
        public static string NumberFormat
        {
            get
            {
                return AppSetting.numberFormat;
            }
        }

        /// <summary>
        /// Money format for TAMS application
        /// </summary>
        public static string MoneyFormat
        {
            get
            {
                return AppSetting.currencyFormat;
            }
        }
        #endregion
    }
}
