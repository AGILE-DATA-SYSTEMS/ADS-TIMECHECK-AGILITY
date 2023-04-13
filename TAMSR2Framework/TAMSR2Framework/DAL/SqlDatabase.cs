/* **************************************************************
* File Name         : SqlDatabase.cs
* Description       : DB Component class for accessing and manipulating any SQL DB-compliant data source
 * 
 * Author		    : Muhammad Aqeel Abbas @linktoaqeel
 * Created		    : May 22, 2013
 * Dependency	    : SqlDatabaseException class
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
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TAMSR2Framework.DAL
{
	/// <summary>
	/// SqlDatabase: SQL Server Database component implementing IConnectable interface.
	/// This component provides all methods for accessing SQL server database.
	/// All exceptions are rethrown to the calling page using SqlDatabaseException.
	/// (Original exception can be taken from the InnderException.)
	/// </summary>
	 

	public class SqlDatabase: IConnectable
	{
		#region private members
		private string strConnection; 
		private int transactionRefCount = 0;
		private int connectionRefCount = 0;
		private SqlConnection objConnection;
		private SqlTransaction objTransaction;
		
		#endregion

		#region Constructors and Destructors

		/// <summary>
		/// SqlDatabase Constructor with no parameters
		/// Connection string is taken from Web.Config file
		/// </summary>
		public SqlDatabase()
		{
			strConnection = ConfigurationSettings.AppSettings["SQLConnectionString"];
		}

		/// <summary>
		/// SqlDatbase Constructor - Connection String is passed as a string
		/// </summary>
		/// <param name="strConn">Connection String</param>
		public SqlDatabase(string strConn)
		{
			strConnection = strConn;
		}

		/// <summary>
		/// Destructor closes connection to the database.
		/// </summary>
		~SqlDatabase()
		{
            try
            {
                if (objConnection.State == ConnectionState.Open)
                    objConnection.Close();
            }
            catch (Exception ex)
            {
            }
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
				if(connectionRefCount<=0)
				{
					objConnection = new SqlConnection(strConnection);
					objConnection.Open ();
				}
				++connectionRefCount;
			}
			catch(SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.Open() failed, SqlException Occurred",e.Number, e);
			}
			catch(Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.Open() Failed, Exception Occurred",0, e);
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
				if(connectionRefCount <= 0 && objConnection != null)
				{
                    if (objConnection.State == ConnectionState.Open)
                        objConnection.Close();
				}
			}
			catch(SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.Close() failed, SqlException Occurred",e.Number, e);
			}
			catch(Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.Close() failed, Exception Occurred",0, e);
			}
		}

		#endregion

		#region Query and SP execution Methods

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
					SqlDataAdapter objCommand = new SqlDataAdapter(strQuery, objConnection);
					objCommand.SelectCommand.CommandTimeout = 180;
					objCommand.SelectCommand.Transaction = objTransaction;
					ds = new DataSet();
					objCommand.Fill(ds, "myTable");
					objCommand.Dispose();
			}
			catch (SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.ExecuteQuery() failed, SqlException Occurred",e.Number,e);
			}

			catch (Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.ExecuteQuery() failed, Exception Occurred",0,e);
			}

			if(ds.Tables.Count > 0)
				return ds.Tables["myTable"].DefaultView;
			else
				return null;
			
		}
		/// <summary>
		/// ExecuteQueryProcedure: Method for executing Procedures which returns records
		/// </summary>
		/// <param name="strProcedure">Procedure Name to be executed </param>
		/// <param name="htParameters">Hash table which holds 0 or more parameters for the procedure </param>
		/// <returns>Dataview object which holds the results </returns>

		DataView IConnectable.ExecuteProcedure(string strProcedure, Hashtable htParameters)
		{
			DataSet ds;

			try
			{
					SqlDataAdapter objCommand = new SqlDataAdapter(strProcedure, objConnection);
					IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
					objCommand.SelectCommand.CommandTimeout = 600;
					objCommand.SelectCommand.CommandType = CommandType.StoredProcedure;
					objCommand.SelectCommand.Transaction = objTransaction;

					while ( objEnumerator.MoveNext() )
					{
						objCommand.SelectCommand.Parameters.Add(new SqlParameter(objEnumerator.Key.ToString() , SqlDbType.NVarChar, 4096));
						objCommand.SelectCommand.Parameters[objEnumerator.Key.ToString() ].Value = objEnumerator.Value;
					}
					ds = new DataSet();
					objCommand.Fill(ds, "myTable");
					objCommand.Dispose();
				
			}
			catch (SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.ExecuteProcedure() failed, SqlException Occurred",e.Number,e);
			}
			catch (Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.ExecuteProcedure() failed, Exception Occurred",0,e);
			}

			if(ds.Tables.Count > 0)
				return ds.Tables["myTable"].DefaultView;
			else
				return null;

		}


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
					SqlCommand objCommand = new SqlCommand(strQuery, objConnection);
					objCommand.CommandTimeout = 120;
					objCommand.Transaction = objTransaction;
					nRecords = objCommand.ExecuteNonQuery();
					objCommand.Dispose();
			}
			catch(SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.ExecuteNonQuery() failed, SqlException occurred",e.Number,e);
			}
			catch(Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.ExecuteNonQuery() failed, Exception occurred",0,e);
			}
			return nRecords;
		}

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

				SqlCommand objCommand = new SqlCommand(strProcedure, objConnection);
				objCommand.CommandTimeout = 120;
				IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
				objCommand.CommandType = CommandType.StoredProcedure;
				objCommand.Transaction = objTransaction;

				while ( objEnumerator.MoveNext() )
				{
					objCommand.Parameters.Add(new SqlParameter(objEnumerator.Key.ToString() , SqlDbType.NVarChar, 4096));
					objCommand.Parameters[objEnumerator.Key.ToString() ].Value = objEnumerator.Value;
				}

				nRecords = objCommand.ExecuteNonQuery();
				objCommand.Dispose();
			}
			catch(SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.ExecuteNonQueryProcedure() failed, SqlException Occurred",e.Number,e);
			}
			catch(Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.ExecuteNonQueryProcedure() failed, Exception Occurred",0,e);
			}

			return nRecords;
		}


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
	
					SqlCommand objCommand = new SqlCommand(strProcedure, objConnection);
					IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
					objCommand.CommandTimeout = 120;
					objCommand.CommandType = CommandType.StoredProcedure;
					objCommand.Transaction = objTransaction;
		
					while ( objEnumerator.MoveNext() )
					{
						objCommand.Parameters.Add(new SqlParameter(objEnumerator.Key.ToString() , SqlDbType.NVarChar, 4096));
						objCommand.Parameters[objEnumerator.Key.ToString() ].Value = objEnumerator.Value;
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
			catch (SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.GetValueNonQueryProcedure() failed, SqlException occurred",e.Number,e);
			}		
			catch (Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.GetValueNonQueryProcedure() failed, Exception occurred",0,e);
			}		
			
			//returning the object obtained after type casting it to integer.
			return nValue;
		}

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
					SqlCommand objCommand = new SqlCommand(strProcedure, objConnection);
					IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
					objCommand.CommandTimeout = 120;
					objCommand.CommandType = CommandType.StoredProcedure;
				    objCommand.Transaction = objTransaction;

                    SqlDbType ParamType = SqlDbType.VarChar;
                    string tempType = "NVarChar";
                    System.Type objType;
                    while (objEnumerator.MoveNext())
                    {
                        try
                        {
                            objType = objEnumerator.Value.GetType();
                            tempType = objType.FullName;
                        }
                        catch (Exception ex)
                        {
                            tempType = "NVarChar";
                        }
                        if (tempType == "System.Byte[]")
                        {
                            ParamType = SqlDbType.VarBinary;
                            objCommand.Parameters.Add(new SqlParameter(objEnumerator.Key.ToString(), SqlDbType.Binary));
                            objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                        }
                        else
                        {
                            ParamType = SqlDbType.NVarChar;
                            objCommand.Parameters.Add(new SqlParameter(objEnumerator.Key.ToString(), SqlDbType.NVarChar, 4096));
                            objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                        }
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
			catch (SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.GetValueProcedure() failed, SqlException Occurred",e.Number, e);
			}
			catch (Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.GetValueProcedure() failed, Exception Occurred",0, e);
			}
			return strValue;

		}

        /// <summary>
        /// maxLength parameter will tell that there is sql parameter with max length
        /// GetValueProcedureMaxLength: Method for returning a single value (first column of first row, others ignored) from a Procedures 
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
                SqlCommand objCommand = new SqlCommand(strProcedure, objConnection);
                IDictionaryEnumerator objEnumerator = htParameters.GetEnumerator();
                objCommand.CommandTimeout = 120;
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.Transaction = objTransaction;

                SqlDbType ParamType = SqlDbType.VarChar;
                string tempType = "NVarChar";
                System.Type objType;
                while (objEnumerator.MoveNext())
                {
                    try
                    {
                        objType = objEnumerator.Value.GetType();
                        tempType = objType.FullName;
                    }
                    catch (Exception ex)
                    {
                        tempType = "NVarChar";
                    }
                    if (tempType == "System.Byte[]")
                    {
                        ParamType = SqlDbType.VarBinary;
                        objCommand.Parameters.Add(new SqlParameter(objEnumerator.Key.ToString(), SqlDbType.Binary));
                        objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                    }
                    else
                    {
                        ParamType = SqlDbType.NVarChar;
                        objCommand.Parameters.Add(new SqlParameter(objEnumerator.Key.ToString(), SqlDbType.VarChar, objEnumerator.Value.ToString().Length));
                        objCommand.Parameters[objEnumerator.Key.ToString()].Value = objEnumerator.Value;
                    }
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
            catch (SqlException e)
            {
                throw new SqlDatabaseException("SqlDatabase.GetValueProcedure() failed, SqlException Occurred", e.Number, e);
            }
            catch (Exception e)
            {
                throw new SqlDatabaseException("SqlDatabase.GetValueProcedure() failed, Exception Occurred", 0, e);
            }
            return strValue;

        }


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
					SqlCommand objCommand = new SqlCommand(strQuery, objConnection);
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
			catch (SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.GetValue() failed, SqlException Occurred",e.Number, e);
			}
			catch (Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.GetValue() failed, Exception Occurred",0, e);
			}
			return strValue;

		}

		#endregion

		#region Transaction Support Methods

		/// <summary>
		/// BeginTransaction: Method for starting a transaction
		/// </summary>

		void IConnectable.BeginTransaction()
		{
			try
			{
				if(0 == transactionRefCount)
				{
					objTransaction = objConnection.BeginTransaction ();
				}
				++transactionRefCount;
			}
			catch(SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.BeginTransaction() failed, SqlException occurred",e.Number,e);
			}
			catch(Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.BeginTransaction() failed, Exception occurred",0,e);
			}
		}

		/// <summary>
		/// CommitTransaction: Method for committing a transaction
		/// </summary>

		void IConnectable.CommitTransaction()
		{
			try
			{
				if(null != objTransaction)
				{
					--transactionRefCount;
					if(0 == transactionRefCount )
					{
						objTransaction.Commit();
						objTransaction = null;
					}
				}
			}
			catch(SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.CommitTransaction() failed, SqlException occurred",e.Number, e);
			}
			catch(Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.CommitTransaction() failed, Exception occurred",0, e);
			}
		}

		/// <summary>
		/// RollbackTransaction: Method for Rollbacking a transaction
		/// </summary>

		void IConnectable.RollbackTransaction()
		{
			try
			{
				if(null != objTransaction)
				{
					--transactionRefCount;
					if(0 == transactionRefCount)
					{
						objTransaction.Rollback();
						objTransaction = null;
					}
				}
			}
			catch(SqlException e)
			{
				throw new SqlDatabaseException("SqlDatabase.RollbackTransaction() failed, SqlException occurred",e.Number, e);
			}
			catch(Exception e)
			{
				throw new SqlDatabaseException("SqlDatabase.RollbackTransaction() failed, Exception occurred",0, e);
			}
							 
		}

		#endregion
	
	}
}
