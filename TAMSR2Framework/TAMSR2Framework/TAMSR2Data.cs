/* **************************************************************
 * File Name        : TAMSR2Data.cs
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
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CryptoSys;
using System.Runtime.InteropServices;
using Microsoft.Win32;
using TAMSR2Framework.DAL; 

namespace TAMSR2Framework
{
    /// <summary>
    /// Summary description for TAMSR2Data.
    /// </summary>
    public class TAMSR2Data
    {
        #region Constructor and private variables
        // private variables
        private IConnectable objConnection;
        private bool ownConnection = true;

        public TAMSR2Data()
        {
        }

        #endregion

        #region Connection handling

        /// <summary>
        /// Open a connection. 
        /// </summary>
        public void OpenConnection()
        {
            // ignore connection request, if already connected
            if (this.objConnection == null)
            {
                string strDbConnType = ConfigurationSettings.AppSettings["DbConnectionType"];
                string strDatabase = ConfigurationSettings.AppSettings["Database"];
                string strConnEncrypted = ConfigurationSettings.AppSettings["DbConnectionString"];

                string strConn = "";
                if (ConfigurationSettings.AppSettings["dbEncryptString"] + "" == "1")
                    strConn = getDecryptedConnStr(strConnEncrypted);
                else
                    strConn = strConnEncrypted;

                strDbConnType = strDbConnType.ToUpper();
                strDatabase = strDatabase.ToUpper();
                if (strDbConnType == "NATIVE")
                {
                    if (strDatabase == "SQL")
                        this.objConnection = (IConnectable)(new SqlDatabase(strConn));
                    else if (strDatabase == "ORACLE")
                        this.objConnection = (IConnectable)(new OledbDatabase(strConn));
                    else // Use SQL by default
                        this.objConnection = (IConnectable)(new SqlDatabase(strConn));
                }
                else if (strDbConnType == "OLEDB")
                {
                    this.objConnection = (IConnectable)(new OledbDatabase(strConn));
                }
                else // Use ODBC
                {
                    this.objConnection = (IConnectable)(new ODBCDatabase(strConn));
                }
            }
            this.objConnection.Open();
        }

        public void OpenConnection(string strConnEncrypted)
        {
            // ignore connection request, if already connected
            if (this.objConnection == null)
            {
                string strDbConnType = ConfigurationSettings.AppSettings["DbConnectionType"];
                string strDatabase = ConfigurationSettings.AppSettings["Database"];
                //string strConnEncrypted = ConfigurationSettings.AppSettings["DbConnectionString"];


                string strConn = "";
                if (ConfigurationSettings.AppSettings["dbEncryptString"] + "" == "1")
                    strConn = getDecryptedConnStr(strConnEncrypted);
                strConn = strConnEncrypted;

                strDbConnType = strDbConnType.ToUpper();
                strDatabase = strDatabase.ToUpper();
                if (strDbConnType == "NATIVE")
                {
                    if (strDatabase == "SQL")
                        this.objConnection = (IConnectable)(new SqlDatabase(strConn));
                    else if (strDatabase == "ORACLE")
                        this.objConnection = (IConnectable)(new OledbDatabase(strConn));
                    else // Use SQL by default
                        this.objConnection = (IConnectable)(new SqlDatabase(strConn));
                }
                else if (strDbConnType == "OLEDB")
                {
                    this.objConnection = (IConnectable)(new OledbDatabase(strConn));
                }
                else // Use ODBC
                {
                    this.objConnection = (IConnectable)(new ODBCDatabase(strConn));
                }
            }
            this.objConnection.Open();
        }


        /// <summary>
        /// Open a connection by reading Database connection setting from registry. 
        /// </summary>
        public void OpenConnectionFromRegistry()
        {
            //This method is used from window application, which sends the email notifications
            // ignore connection request, if already connected
            if (this.objConnection == null)
            {
                RegistryKey MyReg = Registry.LocalMachine.OpenSubKey("SOFTWARE\\FutureTrends\\TAMS");
                string strConn = (string)MyReg.GetValue("Database", "novalue");
                string decryptedStrConn = getDecryptedConnStr(strConn);
                MyReg.Close();
                this.objConnection = (IConnectable)(new SqlDatabase(decryptedStrConn));
            }
            this.objConnection.Open();
        }



        //example: strConn= "DSN=TAMS-ENT-ADIB;UID=sa;PWD=772C0CC7B6D1F29E25FF921FEC8BFFC16B3C8F341761F86936B4505104BADA2E";
        //returns  "DSN=TAMS-ENT-ADIB;UID=sa;PWD=sa";
        string getDecryptedConnStr(string strConn)
        {
            try
            {
                int index = strConn.LastIndexOf("pwd");
                string encryptedPwd = strConn.Substring(index + 1);
             //   Ency
               // string sss = fteCrypt.Decrypt(encryptedPwd);
               // //CryptoSys.CFTECryptClass fteCrypt = null;
               // //fteCrypt = new CFTECryptClass();
               //// string decryptedPwd = fteCrypt.Decrypt(encryptedPwd);
               // Marshal.ReleaseComObject(fteCrypt);
               // string decryptedStrConn = strConn.Substring(0, index + 1) + sss;// decryptedPwd;
               // return decryptedStrConn;
                return strConn;
            }
            catch (Exception ex)
            {
                return strConn;
            }
            //return "";

        }


        /// <summary>
        /// Close connection
        /// </summary>
        public void CloseConnection()
        {
            // ignore close request, if the connection is created
            // by somebody else.
            if (ownConnection && objConnection != null)
            {
                objConnection.Close();
            }
        }


        /// <summary>
        /// Property holding Connection
        /// </summary>
        public IConnectable Connection
        {
            get
            {
                return objConnection;
            }
            set
            {
                objConnection = value;
                ownConnection = false;
            }
        }
        #endregion
        
    }
}