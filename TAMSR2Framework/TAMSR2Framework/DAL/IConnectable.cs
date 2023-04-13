/*************************************************************************************
* File Name          : IConnectable.cs
* Description        : All databases should implement this interface
* Author             : Mallika Jacob
* Created On         : May 20, 2003
 * Dependency	     : 
* Revision History   :
* **********************************************************************************/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TAMSR2Framework.DAL
{
    /// <summary>
    /// IConnectable interface : All Database objects should
    ///		implement this interface. All database operations should
    ///		be done through the interface.
    /// </summary>

    public interface IConnectable
    {
        /// <summary>
        /// Open connection
        /// </summary>
        void Open();

        /// <summary>
        /// ExecuteQuery: Method for executing SELECT statements
        /// </summary>
        /// <param name="strQuery">Select Statement to be executed </param>
        /// <returns>Dataview object which holds the results of the query </returns>
        DataView ExecuteQuery(string strQuery);

        /// <summary>
        /// ExecuteQueryProcedure: Method for executing Procedures which returns records
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns>Dataview object which holds the results </returns>
        DataView ExecuteProcedure(string strProcedure, Hashtable htParameters);

        /// <summary>
        /// ExecuteQueryProcedure: Method for executing Procedures which returns records
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed along with parameters</param>
        /// <returns>Dataview object which holds the results </returns>
        DataView ExecuteProcedure2(string strProcedure);

        /// <summary>
        /// Execute a Non Query
        /// </summary>
        /// <param name="strQuery">SQL statement</param>
        /// <returns>Number of records affected</returns>
        int ExecuteNonQuery(string strQuery);

        /// <summary>
        /// Execute a Procedure which runs a non query
        /// </summary>
        /// <param name="strProcedure">Stored Procedure name</param>
        /// <param name="htParameters">hash table holding parameter name and value</param>
        /// <returns>Number of records affected</returns>
        int ExecuteNonQueryProcedure(string strProcedure, Hashtable htParameters);

        /// <summary>
        /// GetValueNonQueryProcedure: Method for executing Proecedure which inserts into the 
        /// database and it returns the primary ley inserted. i.e @@IDENTITY.
        /// </summary>
        /// <param name="strProcedure">Stored Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns> Last inserted id. The object is type casted to int before returning.</returns>
        long GetValueNonQueryProcedure(string strProcedure, Hashtable htParameters);

        /// <summary>
        /// GetValue: Method for returning a single value (first column of first row, others ignored) from a Query 
        /// </summary>
        /// <param name="strQuery">Query to be executed </param>
        /// <returns>string holds the results </returns>
        string GetValue(string strQuery);

        /// <summary>
        /// GetValueProcedure: Method for returning a single value (first column of first row, others ignored) from a Procedures 
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns>string holds the results </returns>
        string GetValueProcedure(string strProcedure, Hashtable htParameters);

        /// <summary>
        /// maxLength parameter will tell that there is sql parameter with max length
        /// GetValueProcedureMaxLength: Method for returning a single value (first column of first row, others ignored) from a Procedures 
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns>string holds the results </returns>
        string GetValueProcedureMaxLength(string strProcedure, Hashtable htParameters, bool maxLength);

        /// <summary>
        /// BeginTransaction: Method for starting a transaction
        /// </summary>
        void BeginTransaction();

        /// <summary>
        /// CommitTransaction: Method for committing a transaction
        /// </summary>
        void CommitTransaction();

        /// <summary>
        /// RollbackTransaction: Method for Rollbacking a transaction
        /// </summary>
        void RollbackTransaction();

        /// <summary>
        /// Close: Close connection
        /// </summary>
        void Close();
    }
}
