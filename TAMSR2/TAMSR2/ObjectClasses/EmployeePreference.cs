using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class EmployeePreference : BaseClass
    {
        public decimal EmployeeID { get; set; }
        public string Language { get; set; }
        public string Sidebar { get; set; }
        public string Theme { get; set; }
        public int PageSize { get; set; }

        public EmployeePreference()
        {
            Language = "en";
            Sidebar = "";
            Theme = "default.css";
            PageSize = 10;
        }

        public EmployeePreference GetEmployeePreference(string sessionID, string dbType, string dbName, string dbUser, string dbPassword)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            EmployeePreference obj = new EmployeePreference();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(dbType, dbName, dbUser, dbPassword));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByEmployeeID");
                ht.Add("sessionID", sessionID);
                ht.Add("empID", sessionID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_PreferenceOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["preference_id"]);
                    obj.EmployeeID = Numerics.GetDecimal(dv[0]["employee_id"]);
                    obj.PageSize = Numerics.GetInt(dv[0]["page_size"] + "");
                    obj.PageSize = (dv[0]["page_size"] + "").Trim() == "" ? 10 : Numerics.GetInt(dv[0]["page_size"] + "");
                    obj.Language = (dv[0]["language"] + "").Trim() == "" ? "en" : dv[0]["language"] + "";
                    obj.Sidebar = dv[0]["sidebar"] + "";
                    obj.Theme = (dv[0]["theme"] + "").Trim() == "" ? "default.css" : dv[0]["theme"] + "";
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["updated_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["updated_date"]);
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return obj;
        }

        public bool Save(string sessionID, string dbType, string dbName, string dbUser, string dbPassword, string language, string pageSize, string sidebar, string theme)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            bool chk = false;
            EmployeePreference obj = GetEmployeePreference(sessionID, dbType, dbName, dbUser, dbPassword);
            try
            {
                if (obj == null)
                {
                    obj = new EmployeePreference();
                    obj.ID = 0;
                }
                obj.EmployeeID = Numerics.GetDecimal(sessionID);
                obj.Language = language.Trim().ToLower() == "" ? obj.Language : language;
                obj.Sidebar = sidebar.Trim().ToLower() == "" ? "" : sidebar;
                obj.Theme = theme.Trim().ToLower() == "" ? obj.Theme : theme;
                obj.PageSize = Numerics.GetInt(pageSize) <= 10 ? 10 : Numerics.GetInt(pageSize);
                obj.CreatedBy = obj.EmployeeID;
                obj.CreatedOn = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone);
                obj.UpdatedBy = obj.EmployeeID;
                obj.UpdatedOn = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(dbType, dbName, dbUser, dbPassword));

                Hashtable ht = new Hashtable();
                ht.Add("action", "save");
                ht.Add("sessionID", sessionID);
                ht.Add("id", obj.ID + "");
                ht.Add("empID", sessionID);
                ht.Add("language", obj.Language);
                ht.Add("sidebar", obj.Sidebar);
                ht.Add("theme", obj.Theme);
                ht.Add("pageSize", obj.PageSize);

                ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("createdBy", sessionID);
                ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("updatedBy", sessionID);

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_PreferenceOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = true;
                }
                else
                {
                    chk = false;
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }

    }
}