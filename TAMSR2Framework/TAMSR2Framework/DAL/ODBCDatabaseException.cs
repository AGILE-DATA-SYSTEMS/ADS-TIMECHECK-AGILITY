/* **************************************************************
 * File Name        : ODBCDatabaseException.cs
 * Description      : Exception Class for ODBCDatabase Class
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
    /// <summary>
    /// Summary description for ODBCDatabaseException.
    /// </summary>
    public class ODBCDatabaseException : ApplicationException
    {

        #region Private Members
        private string strODBCErrorMessage;
        #endregion

        #region Constructor
        /// <summary>
        /// Constructor with Error Message and Innner Exception
        /// </summary>
        /// <param name="strMessage">Exception Message</param>
        /// <param name="strActualError">SQL Server Error </param>
        /// <param name="inner">Inner Exception</param>
        public ODBCDatabaseException(string strMessage, string strActualError, Exception inner)
            : base(strMessage, inner)
        {
            this.strODBCErrorMessage = strActualError;

        }
        #endregion

        #region Public Properties

        /// <summary>
        /// ODBC Error Message
        /// </summary>
        public string ODBCErrorMessage
        {
            get
            {
                return this.strODBCErrorMessage;
            }
        }
        #endregion
    }
}
