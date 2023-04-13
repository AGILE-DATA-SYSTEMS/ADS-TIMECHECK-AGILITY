using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class DBAppSetting : BaseClass
    {
        public string Name { get; set; }
        public string Value { get; set; }
        public string Descr { get; set; }
        public int TabNo { get; set; }
        public int deleted { get; set; }
        public string Updated_By_name { get; set; }

        public Schedule GetRestDays(string sessionID, string constr)
        {
            Schedule obj = new Schedule();
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByName");
                ht.Add("vname", "RestDays");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    string temp = (dv[0]["value"] + "").Trim();
                    if (temp != "")
                    {
                        string[] arr = temp.Trim().ToLower().Split(',');
                        if (arr.Contains("sunday"))
                            obj.Sunday = 1;
                        if (arr.Contains("monday"))
                            obj.Monday = 1;
                        if (arr.Contains("tuesday"))
                            obj.Tuesday = 1;
                        if (arr.Contains("wednesday"))
                            obj.Wednesday = 1;
                        if (arr.Contains("thursday"))
                            obj.Thursday = 1;
                        if (arr.Contains("friday"))
                            obj.Friday = 1;
                        if (arr.Contains("saturday"))
                            obj.Saturday = 1;
                    }
                    else
                    {
                    }
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

        public bool GetAutoLeaveApproval(string sessionID, string constr)
        {
            bool chk = false;

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByName");
                ht.Add("vname", "EMPLOYEE_LEAVE_AUTO_APPROVE");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    chk = Numerics.GetBool((dv[0]["value"] + "").Trim());
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

        public string GetTimecheckMobileUrl(string sessionID, string constr)
        {
            string chk = "";

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByName");
                ht.Add("vname", "TIME_CHECK_MOBILE");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    chk = (dv[0]["value"] + "").Trim();
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



        public int GetUserActiveSessionLastMinutes(string sessionID, string constr)
        {
            int chk = 0;

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByName");
                ht.Add("vname", "USER_ACTIVE_SESSIONS_LAST_MINUTES");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    chk = Numerics.GetInt((dv[0]["value"] + "").Trim());
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

        public string GetDefaultLocation(string sessionID, string constr)
        {
            string chk = "";

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByName");
                ht.Add("vname", "SYSTEM_DEFAULT_LOCATION");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    chk =  (dv[0]["value"] + "").Trim() ;
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

        public string IsGeoLocationEnabled(string sessionID, string constr)
        {
            string chk = "";

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByName");
                ht.Add("vname", "ENABLE_GEO_LOCATION");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    chk = (dv[0]["value"] + "").Trim();
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

        public bool GetEmployeeImageFromFolder(decimal sessionID, string constr)
        {
            bool chk = false;

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByName");
                ht.Add("vname", "LOAD_EMPLOYEE_IMAGE_FROM_FOLADER");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    if ((dv[0]["value"] + "").Trim() == "YES")
                        chk = true;
                    else
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

        public string GetPermissionBalanceSettings(string sessionID, string constr)
        {
            string chk = "";

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(constr);
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getByName");
                ht.Add("vname", "SHOW_PERMISSION_BALANCE");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    chk = (dv[0]["value"] + "").Trim();
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