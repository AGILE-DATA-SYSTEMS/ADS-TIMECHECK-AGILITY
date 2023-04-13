/* **************************************************************
 * File Name        : SqlDatabaseException.cs
 * Description      : Exception Class for SqlDatabase Class
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
    /// SqlDatabaseException: Exception class for SqlDatabase
    /// </summary>
    public class SqlDatabaseException : ApplicationException
    {

        #region Private Members
        private int nError;
        #endregion

        #region Constructor
        /// <summary>
        /// Constructor with Error Message and Innner Exception
        /// </summary>
        /// <param name="strMessage">Exception Message</param>
        /// <param name="nErrorNum">SQL Server Error Number </param>
        /// <param name="inner">Inner Exception</param>
        public SqlDatabaseException(string strMessage, int nErrorNum, Exception inner)
            : base(strMessage, inner)
        {
            this.nError = nErrorNum;
            new ExceptionLog().WriteLog(strMessage, nErrorNum, inner);

        }
        #endregion

        #region Public Properties

        /// <summary>
        /// SQL Error Number
        /// </summary>
        public int SqlError
        {
            get
            {
                return this.nError;
            }
        }
        #endregion
    }
}