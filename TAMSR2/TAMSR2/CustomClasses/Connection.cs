using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.CustomClasses
{
    public static class Connection
    {
        public static string GetConnectionStrinng()
        {
            string connectionString = "";

            string strDbConnType = ConfigurationManager.AppSettings["DbConnectionType"];
            string strDatabase = ConfigurationManager.AppSettings["Database"];
            string strConnEncrypted = ConfigurationManager.AppSettings["DbConnectionString"];
            if (strDatabase.ToLower() == "sql")
            {
                string server = ConfigurationManager.AppSettings["dbServer"];
                string dbName = ConfigurationManager.AppSettings["dbName"];
                string dbUser = ConfigurationManager.AppSettings["dbUser"];
                string dbPassword = ConfigurationManager.AppSettings["dbPassword"];                
                connectionString = "Data Source=" + server + ";Initial Catalog=" + dbName + ";uid=" + dbUser + ";pwd=" + dbPassword;
            }

            return connectionString;
        }

        public static string GetConnectionStrinng(string dbType, string dbName, string dbUser, string dbPassword)
        {
            string connectionString = "";

            string strDbConnType = ConfigurationManager.AppSettings["DbConnectionType"];
            string strDatabase = ConfigurationManager.AppSettings["Database"];
            string strConnEncrypted = ConfigurationManager.AppSettings["DbConnectionString"];
            if (dbType.ToLower() == "sql")
            {
                string server = ConfigurationManager.AppSettings["dbServer"];
                
                connectionString = "Data Source=" + server + ";Initial Catalog=" + dbName + ";uid=" + dbUser + ";pwd=" + dbPassword;
            }

            return connectionString;
        }

        public static string GetUserConnectionStrinng()
        {
            string connectionString = "";

            string strDbConnType = ConfigurationManager.AppSettings["DbConnectionType"];
            string strDatabase = ConfigurationManager.AppSettings["Database"];
            string strConnEncrypted = ConfigurationManager.AppSettings["DbConnectionString"];
            if (HttpContext.Current.Session != null && (HttpContext.Current.Session["dbType"] + "").ToLower() == "sql")
            {
                string server = ConfigurationManager.AppSettings["dbServer"];

                connectionString = "Data Source=" + server + ";Initial Catalog=" + HttpContext.Current.Session["dbName"] + ";uid=" + HttpContext.Current.Session["dbUser"] + ";pwd=" + HttpContext.Current.Session["dbPassword"] + "";
            }

            return connectionString;
        }
        public static string GetCMIBaseUrl()
        {
            string Url = ConfigurationManager.AppSettings["cmibaseurl"];
            return Url;
        }


        //public static string dbType { get; set; }
        //public static string dbName { get; set; }
        //public static string dbUser { get; set; }
        //public static string dbPassword { get; set; }

        #region protected methods
        // Get the id of the given privilege
        public static int GetId(string privName)
        {
            int idPrivilege = 0;
            TAMSR2Data objDAL = new TAMSR2Data();
            //Dataview to return the query
            //DataView objDataview;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("action", "getPrivilegeIDByName");
                ht.Add("sessionID", HttpContext.Current.Session["ID"] + "");
                ht.Add("privilegeName", privName);
                objDAL.OpenConnection(Connection.GetConnectionStrinng(HttpContext.Current.Session["dbType"] + "", HttpContext.Current.Session["dbName"] + "", HttpContext.Current.Session["dbUser"] + "", HttpContext.Current.Session["dbPassword"] + ""));

                idPrivilege = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_SecPrivilegeOps", ht));
            }
            catch (Exception e)
            {
                //throw new NeSTTechLogException("NeSTTechPrivilegeName.GetId() Failed", e);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return idPrivilege;
        }
        #endregion



        public static object nPrivilegeID { get; set; }
    }
}