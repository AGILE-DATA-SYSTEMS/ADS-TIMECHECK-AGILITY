/*************************************************************************************
* File Name         : OleDatabase.cs
* Description       : DB Component class for accessing and manipulating any OLE DB-compliant data source
 * 
 * Author		    : Muhammad Aqeel Abbas @linktoaqeel
 * Created		    : May 22, 2013
 * Dependency	    : OledbDatabaseException class
 *				    : IConnectable interface
 *				    
* Revision History  :
 * 
 * 
* **********************************************************************************/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TAMSR2Framework.DAL
{
    /// <summary>
    /// OleDatabase: Database component implementing IConnectable interface.
    /// This component provides all methods for accessing and manipulating any OLE DB-compliant data source.
    /// All exceptions are rethrown to the calling page using OleDatabaseException.	
    /// </summary>
    public class OledbDatabase : IConnectable
    {

        #region private members
        private string strConnection;
        private int transactionRefCount = 0;
        private int connectionRefCount = 0;
        private OleDbConnection objConnection;
        private OleDbTransaction objTransaction;
        #endregion

        #region Constructors and Destructors

        /// <summary>
        /// OleDatabase Constructor with no parameters
        /// Connection string is taken from Web.Config file
        /// </summary>
        public OledbDatabase()
        {
            strConnection = ConfigurationSettings.AppSettings["OLEDBConnectionString"];
        }

        /// <summary>
        /// OleDbConnection Constructor - Connection String is passed as a string
        /// </summary>
        /// <param name="strConn">Connection String</param>
        public OledbDatabase(string strConn)
        {
            strConnection = strConn;
        }

        /// <summary>
        /// Destructor closes connection to the database.
        /// </summary>
        ~OledbDatabase()
        {
            objConnection.Close();
        }

        #endregion

        #region Open and Close Methods

        /// <summary>
        /// Opens connection to the database for the first call to this method.
        /// Increments the reference count of connections for subsequent calls. 
        /// </summary>
        /// 

        void IConnectable.Open()
        {
            try
            {
                if (connectionRefCount <= 0)
                {
                    objConnection = new OleDbConnection(strConnection);
                    objConnection.Open();
                }
                ++connectionRefCount;
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.Open() failed, OleDbException  Occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.Open() Failed, Exception Occurred", 0, e);
            }

        }

        /// <summary>
        /// Decrements the connection reference count and if it has reached zero,
        /// actually closes the connection
        /// </summary>

        void IConnectable.Close()
        {
            try
            {
                --connectionRefCount;
                if (connectionRefCount <= 0)
                {
                    objConnection.Close();
                }
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.Close() failed, OleDbException Occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.Close() failed, Exception Occurred", 0, e);
            }
        }

        #endregion

        #region Query and SP execution Methods

        #region Execute Query
        /// <summary>
        /// ExecuteQuery: Method for executing SELECT statements
        /// </summary>
        /// <param name="strQuery">Select Statement to be executed </param>
        /// <returns>Dataview object which holds the results of the query </returns>

        DataView IConnectable.ExecuteQuery(string strQuery)
        {
            DataSet ds;
            try
            {
                OleDbDataAdapter objCommand = new OleDbDataAdapter(strQuery, objConnection);
                objCommand.SelectCommand.CommandTimeout = 180;
                objCommand.SelectCommand.Transaction = objTransaction;
                ds = new DataSet();
                objCommand.Fill(ds, "myTable");
                objCommand.Dispose();
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.ExecuteQuery() failed, OleDbException Occurred", e.ErrorCode, e);
            }

            catch (Exception e)
            {
                throw new OledbDatabaseException("ExecuteQuery.ExecuteQuery() failed, Exception Occurred", 0, e);
            }

            return ds.Tables["myTable"].DefaultView;

        }

        #endregion

        #region Excecute NonQuery
        /// <summary>
        /// ExecuteNonQuery: Method for executing Non Select SQLs such as UPDATE, INSERT and DELETE
        /// </summary>
        /// <param name="strQuery">SQL Statement to be executed </param>
        /// <returns> Number of records affected by the query </returns>

        int IConnectable.ExecuteNonQuery(string strQuery)
        {
            int nRecords;
            try
            {
                OleDbCommand objCommand = new OleDbCommand(strQuery, objConnection);
                objCommand.CommandTimeout = 120;
                objCommand.Transaction = objTransaction;
                nRecords = objCommand.ExecuteNonQuery();
                objCommand.Dispose();
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.ExecuteNonQuery() failed, OleDbException occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.ExecuteNonQuery() failed, Exception occurred", 0, e);
            }
            return nRecords;
        }
        #endregion

        #region GetValue Query
        /// <summary>
        /// GetValue: Method for returning a single value (first column of first row, others ignored) from a Query 
        /// </summary>
        /// <param name="strQuery">Query to be executed </param>
        /// <returns>string holds the results </returns>

        string IConnectable.GetValue(string strQuery)
        {
            string strValue;
            object obj;
            try
            {
                OleDbCommand objCommand = new OleDbCommand(strQuery, objConnection);
                objCommand.Transaction = objTransaction;
                objCommand.CommandTimeout = 120;
                obj = objCommand.ExecuteScalar();

                if (obj != null)
                {
                    strValue = obj.ToString();
                }
                else
                    strValue = "";

                objCommand.Dispose();
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.GetValue() failed, OleDbException Occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.GetValue() failed, Exception Occurred", 0, e);
            }
            return strValue;

        }

        #endregion

        #region Excecute Procedure
        /// <summary>
        /// ExecuteProcedure: Method for executing Procedures which returns records
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns>Dataview object which holds the results </returns>

        DataView IConnectable.ExecuteProcedure(string strProcedure, Hashtable htParameters)
        {
            DataSet ds;

            try
            {
                OleDbDataAdapter objCommand = new OleDbDataAdapter(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.SelectCommand.CommandType = CommandType.StoredProcedure;
                objCommand.SelectCommand.Transaction = objTransaction;
                objCommand.SelectCommand.CommandTimeout = 600;
                while (objEnumerator.MoveNext())
                {
                    objCommand.SelectCommand.Parameters.Add(new OleDbParameter(objEnumerator.Key.ToString(), OleDbType.VarWChar, 1024));
                    objCommand.SelectCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                }
                ds = new DataSet();
                objCommand.Fill(ds, "myTable");
                objCommand.Dispose();

            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.ExecuteProcedure() failed, OleDbException Occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.ExecuteProcedure() failed, Exception Occurred", 0, e);
            }
            return ds.Tables["myTable"].DefaultView;

        }
        #endregion

        #region Excecute Procedure2
        /// <summary>
        /// ExecuteProcedure: Method for executing Procedures which returns records
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed along with parameters </param>
        /// <returns>Dataview object which holds the results </returns>

        DataView IConnectable.ExecuteProcedure2(string strProcedure)
        {
            //not implemented
            return null;


        }

        #endregion
        #region ExecuteNonQuery Procedure
        /// <summary>
        /// ExecuteNonQueryProcedure: Method for executing Proecedure which alter the 
        /// database in some way, such as insert , update or delete records.
        /// </summary>
        /// <param name="strProcedure">Stored Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns> Number of records affected by the query </returns>

        int IConnectable.ExecuteNonQueryProcedure(string strProcedure, Hashtable htParameters)
        {
            int nRecords;
            try
            {
                OleDbCommand objCommand = new OleDbCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.CommandTimeout = 120;
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.Transaction = objTransaction;

                while (objEnumerator.MoveNext())
                {
                    objCommand.Parameters.Add(new OleDbParameter(objEnumerator.Key.ToString(), OleDbType.VarWChar, 1024));
                    objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                }

                nRecords = objCommand.ExecuteNonQuery();
                objCommand.Dispose();


            }

            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.ExecuteNonQueryProcedure() failed, OleDbException Occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.ExecuteNonQueryProcedure() failed, Exception Occurred", 0, e);
            }

            return nRecords;
        }

        #endregion

        #region GetValueNonQuery Procedure
        /// <summary>
        /// GetValueNonQueryProcedure: Method for executing Proecedure which inserts into the 
        /// database and it returns the primary ley inserted. i.e @@IDENTITY.
        /// </summary>
        /// <param name="strProcedure">Stored Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns> @@IDENTITY (the last inserted id). The object is type casted to int before returning.</returns>

        long IConnectable.GetValueNonQueryProcedure(string strProcedure, Hashtable htParameters)
        {
            Object obj;
            int nValue;
            try
            {

                OleDbCommand objCommand = new OleDbCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandTimeout = 120;
                objCommand.Transaction = objTransaction;
                while (objEnumerator.MoveNext())
                {
                    objCommand.Parameters.Add(new OleDbParameter(objEnumerator.Key.ToString(), OleDbType.VarWChar, 1024));
                    objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                }

                //returns an object. now to return the value of the object
                obj = objCommand.ExecuteScalar();
                if (obj != null)
                {
                    nValue = Convert.ToInt32(obj.ToString());
                }
                else
                    nValue = -1;

                objCommand.Dispose();
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.GetValueNonQueryProcedure() failed, OleDbException occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.GetValueNonQueryProcedure() failed, Exception occurred", 0, e);
            }

            //returning the object obtained after type casting it to integer.
            return nValue;
        }
        #endregion

        #region GetValue Procedure
        /// <summary>
        /// GetValueProcedure: Method for returning a single value (first column of first row, others ignored) from a Procedures 
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns>string holds the results </returns>

        string IConnectable.GetValueProcedure(string strProcedure, Hashtable htParameters)
        {
            string strValue;
            object obj;
            try
            {
                OleDbCommand objCommand = new OleDbCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.Transaction = objTransaction;
                objCommand.CommandTimeout = 120;
                objCommand.CommandType = CommandType.StoredProcedure;

                while (objEnumerator.MoveNext())
                {
                    objCommand.Parameters.Add(new OleDbParameter(objEnumerator.Key.ToString(), OleDbType.VarWChar, 1024));
                    objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                }

                obj = objCommand.ExecuteScalar();

                if (obj != null)
                {
                    strValue = obj.ToString();
                }
                else
                    strValue = "";

                objCommand.Dispose();
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.GetValueProcedure() failed, OleDbException Occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.GetValueProcedure() failed, Exception Occurred", 0, e);
            }
            return strValue;

        }
        #endregion

        #region GetValueProcedureMaxLength
        /// <summary>
        /// maxLength parameter will tell that there is sql parameter with max length
        /// GetValueProcedure: Method for returning a single value (first column of first row, others ignored) from a Procedures 
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed </param>
        /// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
        /// <returns>string holds the results </returns>

        string IConnectable.GetValueProcedureMaxLength(string strProcedure, Hashtable htParameters, bool maxLength)
        {
            string strValue;
            object obj;
            try
            {
                OleDbCommand objCommand = new OleDbCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.Transaction = objTransaction;
                objCommand.CommandTimeout = 120;
                objCommand.CommandType = CommandType.StoredProcedure;

                while (objEnumerator.MoveNext())
                {
                    objCommand.Parameters.Add(new OleDbParameter(objEnumerator.Key.ToString(), OleDbType.VarWChar, 1024));
                    objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                }

                obj = objCommand.ExecuteScalar();

                if (obj != null)
                {
                    strValue = obj.ToString();
                }
                else
                    strValue = "";

                objCommand.Dispose();
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.GetValueProcedure() failed, OleDbException Occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.GetValueProcedure() failed, Exception Occurred", 0, e);
            }
            return strValue;

        }
        #endregion
        
        #endregion

        #region Transaction Support Methods

        /// <summary>
        /// BeginTransaction: Method for starting a transaction
        /// </summary>

        void IConnectable.BeginTransaction()
        {
            try
            {
                if (0 == transactionRefCount)
                {
                    objTransaction = objConnection.BeginTransaction();
                }
                ++transactionRefCount;
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.BeginTransaction() failed, OleDbException occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.BeginTransaction() failed, Exception occurred", 0, e);
            }
        }

        /// <summary>
        /// CommitTransaction: Method for committing a transaction
        /// </summary>

        void IConnectable.CommitTransaction()
        {
            try
            {
                if (null != objTransaction)
                {
                    --transactionRefCount;
                    if (0 == transactionRefCount)
                    {
                        objTransaction.Commit();
                        objTransaction = null;
                    }
                }
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.CommitTransaction() failed, OleDbException occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.CommitTransaction() failed, Exception occurred", 0, e);
            }
        }

        /// <summary>
        /// RollbackTransaction: Method for Rollbacking a transaction
        /// </summary>

        void IConnectable.RollbackTransaction()
        {
            try
            {
                if (null != objTransaction)
                {
                    --transactionRefCount;
                    if (0 == transactionRefCount)
                    {
                        objTransaction.Rollback();
                        objTransaction = null;
                    }
                }
            }
            catch (OleDbException e)
            {
                throw new OledbDatabaseException("OleDatabase.RollbackTransaction() failed, OleDbException occurred", e.ErrorCode, e);
            }
            catch (Exception e)
            {
                throw new OledbDatabaseException("OleDatabase.RollbackTransaction() failed, Exception occurred", 0, e);
            }

        }

        #endregion
    }
}