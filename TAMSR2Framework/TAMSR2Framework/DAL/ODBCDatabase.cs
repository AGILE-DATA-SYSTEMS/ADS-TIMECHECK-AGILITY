/* **************************************************************
* File Name         : ODBCDatabase.cs
* Description       : DB Component class for accessing and manipulating any ODBC DB-compliant data source
 * 
 * Author		    : Muhammad Aqeel Abbas @linktoaqeel
 * Created		    : May 22, 2013
 * Dependency	    : ODBCDatabaseException class
 *				    : IConnectable interface
 *				    
 * Revision History :
 * 
 * 
 * *************************************************************/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TAMSR2Framework.DAL
{
    /// <summary>
    /// Class for accessing and manipulating any ODBC DB-compliant data source
    /// The class uses the ODBC .NET Data Provider
    /// The ODBC .NET Data Provider is an add-on component to the .NET Framework. 
    /// It provides access to native ODBC drivers the same way the OLE DB .NET Data Provider 
    /// provides access to native OLE DB providers. 
    /// </summary>
    public class ODBCDatabase : IConnectable
    {

        #region private members
        private string strConnection;
        private int transactionRefCount = 0;
        private int connectionRefCount = 0;
        private OdbcConnection objConnection;
        private OdbcTransaction objTransaction;
        #endregion

        #region Constructors and Destructors

        /// <summary>
        /// OdbcDatabase Constructor with no parameters
        /// Connection string is taken from Web.Config file
        /// </summary>
        public ODBCDatabase()
        {
            strConnection = ConfigurationSettings.AppSettings["ODBCConnectionString"];
        }

        /// <summary>
        /// 		/// ODBCDatabase Constructor - Connection String is passed as a string
        /// </summary>
        /// <param name="strConn">Connection String</param>
        public ODBCDatabase(string strConn)
        {
            strConnection = strConn;
        }

        /// <summary>
        /// Destructor closes connection to the database.
        /// </summary>
        ~ODBCDatabase()
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
                    objConnection = new OdbcConnection(strConnection);
                    objConnection.Open();
                }
                ++connectionRefCount;
            }
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.Open() failed, OdbcException  Occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.Open() Failed, Exception Occurred", "", e);
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
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.Close() failed, OdbcException Occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.Close() failed, Exception Occurred", "", e);
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
                OdbcDataAdapter objCommand = new OdbcDataAdapter(strQuery, objConnection);
                objCommand.SelectCommand.CommandTimeout = 180;
                objCommand.SelectCommand.Transaction = objTransaction;
                ds = new DataSet();
                objCommand.Fill(ds, "myTable");
                objCommand.Dispose();
            }
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteQuery() failed, OdbcException Occurred", e.Message, e);
            }

            catch (Exception e)
            {
                throw new ODBCDatabaseException("ExecuteQuery.ExecuteQuery() failed, Exception Occurred", "", e);
            }

            if (ds.Tables.Count > 0)
                return ds.Tables["myTable"].DefaultView;
            else
                return null;

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
                OdbcCommand objCommand = new OdbcCommand(strQuery, objConnection);
                objCommand.CommandTimeout = 120;
                objCommand.Transaction = objTransaction;
                nRecords = objCommand.ExecuteNonQuery();
                objCommand.Dispose();
            }
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteNonQuery() failed, OdbcException occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteNonQuery() failed, Exception occurred", "", e);
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
                OdbcCommand objCommand = new OdbcCommand(strQuery, objConnection);
                objCommand.CommandTimeout = 120;
                objCommand.Transaction = objTransaction;
                obj = objCommand.ExecuteScalar();

                if (obj != null)
                {
                    strValue = obj.ToString();
                }
                else
                    strValue = "";

                objCommand.Dispose();
            }
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.GetValue() failed, OdbcException Occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.GetValue() failed, Exception Occurred", "", e);
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

                //In ODBC.NET stored proedure syntax should be like this
                //strProcedure = "{CALL " + strProcedure + " (?,?)}";
                //'?' denotes the parameter ie if 2 parameters , it should be denoted by 2 question marks 

                if (htParameters.Count > 0)
                {
                    strProcedure = "{CALL " + strProcedure + " (?";
                    for (int i = 1; i < htParameters.Count; i++)
                    {
                        strProcedure = strProcedure + ",?";
                    }
                    strProcedure = strProcedure + ")}";
                }


                OdbcDataAdapter objCommand = new OdbcDataAdapter(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.SelectCommand.CommandType = CommandType.StoredProcedure;
                objCommand.SelectCommand.Transaction = objTransaction;
                objCommand.SelectCommand.CommandTimeout = 1800;
                OdbcType ParamType = OdbcType.VarChar;
                System.Type objType;
                while (objEnumerator.MoveNext())
                {
                    objType = objEnumerator.Value.GetType();
                    if (objType.FullName == "System.DBNull")
                    {
                        ParamType = OdbcType.NVarChar;
                    }
                    else if (objType.FullName == "System.Int32")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Int64")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Decimal")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Byte")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.String")
                    {
                        ParamType = OdbcType.VarChar;
                    }
                    else if (objType.FullName == "System.DateTime")
                    {
                        ParamType = OdbcType.DateTime;
                    }

                    objCommand.SelectCommand.Parameters.Add(new OdbcParameter(objEnumerator.Key.ToString(), ParamType, 1024));
                    objCommand.SelectCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                }
                ds = new DataSet();
                objCommand.Fill(ds, "myTable");
                objCommand.Dispose();
            }
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteProcedure() failed, OdbcException Occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteProcedure() failed, Exception Occurred", "", e);
            }
            if (ds.Tables.Count > 0)
                return ds.Tables["myTable"].DefaultView;
            else
                return null;

        }
        #endregion

        #region Excecute Procedure2
        /// <summary>
        /// ExecuteProcedure: Method for executing Procedures which returns records
        /// </summary>
        /// <param name="strProcedure">Procedure Name to be executed along with parameter </param>
        /// <returns>Dataview object which holds the results </returns>

        DataView IConnectable.ExecuteProcedure2(string strProcedure)
        {
            DataSet ds;

            try
            {
                //In ODBC.NET stored proedure syntax should be like this
                //strProcedure = "{CALL procedurename (value,value)}"; example for two parameters

                OdbcDataAdapter objCommand = new OdbcDataAdapter(strProcedure, objConnection);
                objCommand.SelectCommand.CommandType = CommandType.StoredProcedure;
                objCommand.SelectCommand.Transaction = objTransaction;
                objCommand.SelectCommand.CommandTimeout = 1800;
                ds = new DataSet();
                objCommand.Fill(ds, "myTable");
                objCommand.Dispose();
            }
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteProcedure() failed, OdbcException Occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteProcedure() failed, Exception Occurred", "", e);
            }
            if (ds.Tables.Count > 0)
                return ds.Tables["myTable"].DefaultView;
            else
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
                if (htParameters.Count > 0)
                {
                    strProcedure = "{CALL " + strProcedure + " (?";
                    for (int i = 1; i < htParameters.Count; i++)
                    {
                        strProcedure = strProcedure + ",?";
                    }
                    strProcedure = strProcedure + ")}";
                }

                OdbcCommand objCommand = new OdbcCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.CommandTimeout = 120;
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.Transaction = objTransaction;

                OdbcType ParamType = OdbcType.VarChar;
                System.Type objType;
                while (objEnumerator.MoveNext())
                {
                    objType = objEnumerator.Value.GetType();
                    if (objType.FullName == "System.DBNull")
                    {
                        ParamType = OdbcType.NVarChar;
                    }
                    else if (objType.FullName == "System.Int32")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Int64")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Decimal")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Byte")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.String")
                    {
                        ParamType = OdbcType.VarChar;
                    }
                    else if (objType.FullName == "System.DateTime")
                    {
                        ParamType = OdbcType.DateTime;
                    }

                    objCommand.Parameters.Add(new OdbcParameter(objEnumerator.Key.ToString(), ParamType, 1024));
                    objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                }

                nRecords = objCommand.ExecuteNonQuery();
                objCommand.Dispose();


            }

            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteNonQueryProcedure() failed, OdbcException Occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.ExecuteNonQueryProcedure() failed, Exception Occurred", "", e);
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

                if (htParameters.Count > 0)
                {
                    strProcedure = "{CALL " + strProcedure + " (?";
                    for (int i = 1; i < htParameters.Count; i++)
                    {
                        strProcedure = strProcedure + ",?";
                    }
                    strProcedure = strProcedure + ")}";
                }

                OdbcCommand objCommand = new OdbcCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandTimeout = 300;
                objCommand.Transaction = objTransaction;
                OdbcType ParamType = OdbcType.VarChar;
                System.Type objType;
                while (objEnumerator.MoveNext())
                {
                    objType = objEnumerator.Value.GetType();
                    if (objType.FullName == "System.DBNull")
                    {
                        ParamType = OdbcType.NVarChar;
                    }
                    else if (objType.FullName == "System.Int32")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Int64")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Decimal")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Byte")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.String")
                    {
                        ParamType = OdbcType.VarChar;
                    }
                    else if (objType.FullName == "System.DateTime")
                    {
                        ParamType = OdbcType.DateTime;
                    }

                    objCommand.Parameters.Add(new OdbcParameter(objEnumerator.Key.ToString(), ParamType, 1024));
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
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.GetValueNonQueryProcedure() failed, OdbcException occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.GetValueNonQueryProcedure() failed, Exception occurred", "", e);
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
                if (htParameters.Count > 0)
                {
                    strProcedure = "{CALL " + strProcedure + " (?";
                    for (int i = 1; i < htParameters.Count; i++)
                    {
                        strProcedure = strProcedure + ",?";
                    }
                    strProcedure = strProcedure + ")}";
                }

                OdbcCommand objCommand = new OdbcCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.CommandTimeout = 300;
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.Transaction = objTransaction;

                OdbcType ParamType = OdbcType.VarChar;
                System.Type objType;
                while (objEnumerator.MoveNext())
                {
                    objType = objEnumerator.Value.GetType();
                    if (objType.FullName == "System.DBNull")
                    {
                        ParamType = OdbcType.NVarChar;
                    }
                    else if (objType.FullName == "System.Int32")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Int64")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Decimal")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Byte")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.String")
                    {
                        ParamType = OdbcType.VarChar;
                    }
                    else if (objType.FullName == "System.DateTime")
                    {
                        ParamType = OdbcType.DateTime;
                    }

                    objCommand.Parameters.Add(new OdbcParameter(objEnumerator.Key.ToString(), ParamType, 1024));
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
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.GetValueProcedure() failed, OdbcException Occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.GetValueProcedure() failed, Exception Occurred", "", e);
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
                if (htParameters.Count > 0)
                {
                    strProcedure = "{CALL " + strProcedure + " (?";
                    for (int i = 1; i < htParameters.Count; i++)
                    {
                        strProcedure = strProcedure + ",?";
                    }
                    strProcedure = strProcedure + ")}";
                }

                OdbcCommand objCommand = new OdbcCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.CommandTimeout = 300;
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.Transaction = objTransaction;

                OdbcType ParamType = OdbcType.VarChar;
                System.Type objType;
                while (objEnumerator.MoveNext())
                {
                    objType = objEnumerator.Value.GetType();
                    if (objType.FullName == "System.DBNull")
                    {
                        ParamType = OdbcType.NVarChar;
                    }
                    else if (objType.FullName == "System.Int32")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Int64")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Decimal")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.Byte")
                    {
                        ParamType = OdbcType.Numeric;
                    }
                    else if (objType.FullName == "System.String")
                    {
                        ParamType = OdbcType.VarChar;
                    }
                    else if (objType.FullName == "System.DateTime")
                    {
                        ParamType = OdbcType.DateTime;
                    }

                    objCommand.Parameters.Add(new OdbcParameter(objEnumerator.Key.ToString(), ParamType, 1024));
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
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.GetValueProcedure() failed, OdbcException Occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.GetValueProcedure() failed, Exception Occurred", "", e);
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
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.BeginTransaction() failed, OdbcException occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.BeginTransaction() failed, Exception occurred", "", e);
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
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.CommitTransaction() failed, OdbcException occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.CommitTransaction() failed, Exception occurred", "", e);
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
            catch (OdbcException e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.RollbackTransaction() failed, OdbcException occurred", e.Message, e);
            }
            catch (Exception e)
            {
                throw new ODBCDatabaseException("OdbcDatabase.RollbackTransaction() failed, Exception occurred", "", e);
            }

        }

        #endregion
    }
}
