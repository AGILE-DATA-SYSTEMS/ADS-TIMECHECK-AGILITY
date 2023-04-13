/* **************************************************************
 * File Name        : TAMSR2ShowException.cs
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
    /// Summary description for TAMSR2ShowException.
    /// </summary>
    public class TAMSR2ShowException : TAMSR2Exception
    {
        #region constructors
        /// <summary>
        /// Constructor with string parameter
        /// </summary>
        /// <param name="message">Exception Message</param>
        public TAMSR2ShowException(string message)
            : base(message)
        { }

        /// <summary>
        /// Constructor with Message and Innner Exception
        /// </summary>
        /// <param name="message">Exception Message</param>
        /// <param name="inner">Inner Exception</param>
        public TAMSR2ShowException(string message, Exception inner)
            : base(message, inner)
        { }

        #endregion
    }
}
