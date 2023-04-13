/* **************************************************************
 * File Name        : TAMSR2Exception.cs
 * Description      : Exception Class for TAMSR2
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

namespace TAMSR2Framework
{
    /// <summary>
    /// TAMSR2Exception: Exception root class for MSOSS
    /// </summary>
    public class TAMSR2Exception : ApplicationException
    {

        #region constructors

        /// <summary>
        /// Constructor with string parameter
        /// </summary>
        /// <param name="message">Exception Message</param>

        public TAMSR2Exception(string message)
            : base(message)
        { }

        /// <summary>
        /// Constructor with Message and Innner Exception
        /// </summary>
        /// <param name="message">Exception Message</param>
        /// <param name="inner">Inner Exception</param>
        public TAMSR2Exception(string message, Exception inner)
            : base(message, inner)
        { }

        #endregion
    }
}

