using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.RequestPages
{
    public partial class EmployeePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/EmployeePage.aspx"));


            cookie = Request.Cookies["tamsCulture"];
            if (cookie == null)
            {
                cookie = new HttpCookie("tamsCulture");
                cookie.Values.Add("pullDirection", AppSetting.defaultPullDirection + "");
                cookie.Values.Add("language", AppSetting.defaultLanguage + "");
                cookie.Values.Add("culture", AppSetting.defaultCulture + "");
                cookie.Values.Add("timeZone", AppSetting.defaultTimeZone + "");
                cookie.Values.Add("dateFormat", AppSetting.dateFormat + "");
                cookie.Values.Add("dateTimeFormat", AppSetting.dateTimeFormat + "");
                DateTime dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(7);
                cookie.Expires = dt;
                Response.Cookies.Add(cookie);
            }

            Page.UICulture = cookie.Values["culture"] + "";
            Page.Culture = cookie.Values["culture"] + "";


            if (cookie.Values["language"] + "" == "ar")
                languagePostfix = "_arb";
            else
                languagePostfix = "_eng";

            string data = "";

            if (Session["ID"] + "" == "")
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "save")
            {
                data = Save();
            }
            else if (Request["key"] + "" == "getAll")
            {
                data = GetAll();
            }
            else if (Request["key"] + "" == "getAllByFilters")
            {
                data = GetAllByFilters();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByID();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if (Request["key"] + "" == "getIdNameListString")
            {
                data = GetIdNameListString();
            }
            else if (Request["key"] + "" == "getMgrIdNameListString")
            {
                data = GetMgrIdNameListString();
            }
            else if (Request["key"] + "" == "getIdNameListStringManager")
            {
                data = GetIdNameListStringManager();
            }
            else if (Request["key"] + "" == "getManagerNameListByOrgID")
            {
                data = GetCodeNameListStringManagerByOrgID();
            }
            else if (Request["key"] + "" == "getIdNameListStringByGroupID")
            {
                data = GetIdNameListStringByGroupID();
            }
            else if (Request["key"] + "" == "getIdNameListByOrgID")
            {
                data = GetIdNameListStringByOrgID();
            }
            else if (Request["key"] + "" == "getEmpIdNameListByOrgAndGroup")
            {
                data = GetIdNameListStringByOrgAndGroup();
            }
            else if (Request["key"] + "" == "getAllIdNameListByOrgID")
            {
                data = GetAllIdNameListStringByOrgID();
            }
            else if (Request["key"] + "" == "getEmpNameListByOrgID")
            {
                data = getEmpNameListByOrgID();
            }
            else if (Request["key"] + "" == "getIdNameListWithDept")
            {
                data = GetIdNameListWithDept();
            }
            else if (Request["key"] + "" == "getUsersInGroupByGroupID")
            {
                data = GetUsersInGroupByGroupID();
            }
            else if (Request["key"] + "" == "getUsersNotInGroupByGroupID")
            {
                data = GetUsersNotInGroupByGroupID();
            }
            else if (Request["key"] + "" == "getUsersInRoleByRoleID")
            {
                data = GetUsersInRoleByRoleID();
            }
            else if (Request["key"] + "" == "getUsersNotInRoleByRoleID")
            {
                data = GetUsersNotInRoleByRoleID();
            }
            else if (Request["key"] + "" == "getIdNameListStringRoaster")
            {
                data = GetIdNameListStringRoasterFlag();
            }
            else if (Request["key"] + "" == "getIdNameListByOrgEmpType")
            {
                data = GetIdNameListStringByOrgSchType();
            }
            else if (Request["key"] + "" == "getIdNameListByOrgIDRoasterFlag")
            {
                data = GetIdNameListStringByOrgIDRoasterFlag();
            }
            else if (Request["key"] + "" == "getZonesList")
            {
                data = GetZonesIdNameListString();
            }
            else if (Request["key"] + "" == "getBuildingsListByZone")
            {
                data = GetBuildingsIdNameListByZoneString();
            }
            else if (Request["key"] + "" == "getSchedulesList")
            {
                data = GetSchedulesIdNameList();
            }
            else
            {
                data = "";
            }

            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Write(data);
            Response.Flush();
            //Response.End();

        }


        #region GetByID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByID()
        {

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Employee obj = new Employee();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                string empID = Encryption.Decrypt((Request["id"] + "").Trim());
                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(empID));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["employee_id"]);
                    obj.OrgID = (dv[0]["organization_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["organization_id"]);
                    obj.GradeID = (dv[0]["grade_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["grade_id"]);
                    obj.DesignationID = (dv[0]["designation_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["designation_id"]);
                    obj.CountryID = (dv[0]["country_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["country_id"]);
                    obj.EmpTypeID = (dv[0]["employee_type_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["employee_type_id"]);
                    obj.RegionID = (dv[0]["region_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["region_id"]);
                    obj.BuildingID = (dv[0]["building_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["building_id"]);
                    obj.ScheduleTypeID = (dv[0]["schedule_type_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["schedule_type_id"]);
                    obj.ManagerID = (dv[0]["manager_id"] + "").Trim() == "" ? -1 : Numerics.GetDecimal(dv[0]["manager_id"]);
                    
                    obj.StatusFlag = Numerics.GetInt(dv[0]["status_flag"] + "");
                    obj.SexFlag = Numerics.GetInt(dv[0]["sex_flag"] + "");
                    obj.LocalFlag = Numerics.GetInt(dv[0]["local_flag"] + "");
                    obj.PunchFlag = Numerics.GetInt(dv[0]["punch_flag"] + "");
                    obj.ShiftFlag = Numerics.GetInt(dv[0]["shift_flag"] + "");
                    obj.OpenShiftFlag = Numerics.GetInt(dv[0]["open_shift_flag"] + "");
                    obj.OvertimeFlag = Numerics.GetInt(dv[0]["overtime_flag"] + "");
                    obj.OnReportFlag = Numerics.GetInt(dv[0]["on_reports_flag"] + "");
                    obj.ShareRoster = Numerics.GetInt(dv[0]["share_roaster"] + "");
                    obj.WebPunchFlag = Numerics.GetInt(dv[0]["web_punch_flag"] + "");

                    obj.ManagerFlag = Numerics.GetBool(dv[0]["manager_flag"] + "");
                    obj.Inpayroll = Numerics.GetBool(dv[0]["inpayroll"] + "");

                    obj.NotifyFlag = Numerics.GetBool(dv[0]["notify_flag"] + "");
                    obj.IncludeNotification = Numerics.GetBool(dv[0]["include_notifications"] + "");

                    obj.JoinDate = Numerics.GetDateTime(dv[0]["join_date"]);
                    obj.InactiveDate = Numerics.GetDateTime(dv[0]["inactive_date"]);
                    obj.JoinDateStr = (dv[0]["join_date"] + "").Trim() != "" ? obj.JoinDate.ToString("yyyy-MM-dd") : "";
                    obj.InactiveDateStr = (dv[0]["inactive_date"] + "").Trim() != "" ? obj.InactiveDate.ToString("yyyy-MM-dd") : "";

                    obj.Username = (dv[0]["login"] + "").Trim();
                    obj.Password = Encryption.Decrypt_AES((dv[0]["password"] + "").Trim());
                    obj.Code = dv[0]["employee_code"] + "";
                    obj.SalutationEn = dv[0]["salutation_eng"] + "";
                    obj.SalutationAr = dv[0]["salutation_arb"] + "";
                    obj.NameEn = dv[0]["name_eng"] + "";
                    obj.NameAr = dv[0]["name_arb"] + "";
                    obj.Email = dv[0]["email"] + "";
                    obj.Mobile = dv[0]["mobile"] + "";
                    obj.CardNo = dv[0]["card_number"] + "";
                    obj.ReaderPassword = dv[0]["reader_password"] + "";
                    obj.PhotoFileName = dv[0]["photo_file_name"] + "";
                    obj.Remarks = dv[0]["remarks"] + "";

                    obj.CalculateMonthlyMissedHours = Numerics.GetInt(dv[0]["monthly_missed_hours_flag"]); 

                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_date"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["last_updated_id"]);
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(obj);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetIdNameListString
        /// <summary>
        /// GetIdNameListString function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetIdNameListString Function*********//
        #endregion


        #region GetMgrIdNameListString
        /// <summary>
        /// GetMgrIdNameListString function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetMgrIdNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getMgrIdNameList");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("includeInactive", Request["includeInactive"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetIdNameListString Function*********//
        #endregion


        #region GetIdNameListStringManager
        /// <summary>
        /// GetIdNameListStringManager function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringManager()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListManager");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string managerStr = (String)GetGlobalResourceObject("Resource", "manager");

                sb.Append("<option value=''>" + chooseStr + " " + managerStr + "</option>");

                
                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetCodeNameListStringManagerByOrgID
        /// <summary>
        /// GetCodeNameListStringManagerByOrgID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetCodeNameListStringManagerByOrgID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListManager");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("regionCode", Request["orgID"] + "");
                ht.Add("orgCode", Request["RegionID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string managerStr = (String)GetGlobalResourceObject("Resource", "manager");

                sb.Append("<option value=''>" + chooseStr + " " + managerStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.Code + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.Code + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetCodeNameListStringManagerByOrgID Function*********//
        #endregion


        #region GetIdNameListStringByGroupID
        /// <summary>
        /// GetIdNameListStringByGroupID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringByGroupID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByGroupID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion
        

        #region GetUsersInGroupByGroupID
        /// <summary>
        /// GetUsersInGroupByGroupID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetUsersInGroupByGroupID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getUsersInGroupByGroupID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("groupID", (Request["gID"] + "").Trim());
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''></option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["user_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion
        

        #region GetUsersNotInGroupByGroupID
        /// <summary>
        /// GetUsersNotInGroupByGroupID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetUsersNotInGroupByGroupID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getUsersNotInGroupByGroupID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("groupID", (Request["gID"] + "").Trim());
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''></option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["user_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetUsersInRoleByRoleID
        /// <summary>
        /// GetUsersInRoleByRoleID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetUsersInRoleByRoleID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getUsersInRoleByRoleID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("roleID", (Request["rID"] + "").Trim());
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''></option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["user_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetUsersNotInRoleByRoleID
        /// <summary>
        /// GetUsersInRoleByRoleID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetUsersNotInRoleByRoleID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getUsersNotInRoleByRoleID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("roleID", (Request["rID"] + "").Trim());
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''></option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["user_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetIdNameListStringRoasterFlag
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringRoasterFlag()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListRoasterFlag");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetIdNameListStringByOrgID
        /// <summary>
        /// GetIdNameListStringByOrgID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringByOrgID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string EmpTypeID = (Request["EmpTypeID"] + "").Trim();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByOrgID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("managerID", Request["managerID"] + "");
                ht.Add("includeInactive", Request["includeInactive"] + "");
                ht.Add("EmpTypeID", EmpTypeID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetIdNameListStringByOrgAndGroup
        /// <summary>
        /// GetIdNameListStringByOrgAndGroup function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringByOrgAndGroup()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DataView dv2 = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string EmpTypeID = (Request["EmpTypeID"] + "").Trim();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByOrgID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("managerID", Request["managerID"] + "");
                ht.Add("includeInactive", Request["includeInactive"] + "");
                ht.Add("EmpTypeID", EmpTypeID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string EmpTypeIDGr = (Request["EmpTypeID"] + "").Trim();
                Hashtable htGr = new Hashtable();
                htGr.Add("action", "getIdNameListByEmpGroupReporting");
                htGr.Add("sessionID", Session["ID"] + "");
                htGr.Add("orgID", Request["orgID"] + "");
                htGr.Add("managerID", Request["managerID"] + "");
                htGr.Add("includeInactive", Request["includeInactive"] + "");
                htGr.Add("EmpTypeID", EmpTypeID);
                dv2 = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", htGr);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

                foreach (DataRowView row in dv2)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllIdNameListStringByOrgID
        /// <summary>
        /// GetAllIdNameListStringByOrgID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetAllIdNameListStringByOrgID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string EmpTypeID = (Request["EmpTypeID"] + "").Trim();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getAllIdNameListByOrgID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("managerID", Request["managerID"] + "");
                ht.Add("includeInactive", Request["includeInactive"] + "");
                ht.Add("EmpTypeID", EmpTypeID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region getEmpNameListByOrgID
        /// <summary>
        /// GetIdNameListStringByOrgID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string getEmpNameListByOrgID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string regionID = Request["RegionID"] + "";
                string EmpTypeID = Request["EmpTypeID"] + "";
                string OrgId = Request["orgID"] + "";
                string ParentID = Request["ParentID"] + "";
                string SchType = Request["SchType"] + "";
                Hashtable ht = new Hashtable();
                ht.Add("action", "getEmpNameListByOrgID");
                ht.Add("sessionID", Session["ID"] + "");
                if (ParentID != "")
                    ht.Add("ParentID", ParentID + "");
                if (OrgId != "")
                    ht.Add("orgID", OrgId + "");
                if (regionID != "")
                    ht.Add("regionID", regionID);
                if (EmpTypeID != "")
                    ht.Add("EmptypeID", EmpTypeID);
                if (SchType != "")
                    ht.Add("scheduleTypeID", SchType);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "all");
                //  string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.Code + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.Code + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetIdNameListWithDept
        /// <summary>
        /// GetIdNameListWithDept function
        ///  
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListWithDept()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByOrgByGroupWithDept");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option CountryId='" + row["country_id"] + "' value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option CountryId='" + row["country_id"] + "' value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
                Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(ex));
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetIdNameListWithDept Function*********//
        #endregion


        #region GetIdNameListStringByOrgSchType
        /// <summary>
        /// GetIdNameListStringByOrgID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringByOrgSchType()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
            string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByOrgEmpType");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("scheduleTypeID", Request["schType"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            if (sb.Length == 0)
            {
                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion
             

        #region GetIdNameListStringByOrgIDRoasterFlag
        /// <summary>
        /// GetIdNameListStringByOrgID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringByOrgIDRoasterFlag()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByOrgIDRoasterFlag");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region DeleteByID
        /// <summary>
        /// DeleteByID function
        /// Delete user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteByID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                int count = Numerics.GetInt(Request["count"] + "");
                string ids = "";
                for (int k = 1; k <= count; k++)
                {
                    ids += Request["chk" + k] + ",";
                }
                ids = ids.TrimEnd(',');
                Hashtable ht = new Hashtable();
                ht.Add("action", "deleteByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);
                
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmpMasterOps", ht));
                if (temp > 0)
                    return "1";
                else if (temp == -1)
                    return "-1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAll
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAll()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "emp.employee_id", "emp.employee_code", "emp.name" + languagePostfix, "emp.join_date", "emp.manager_flag", "emp.punch_flag", "emp.status_flag", "d.description" + languagePostfix, "org.description" + languagePostfix, "mgr.name" + languagePostfix, "emp.employee_id" };
                //string[] cols = { "emp.employee_id", "emp.employee_code", "emp.name" + languagePostfix, "g.description" + languagePostfix, "d.description" + languagePostfix, "org.description" + languagePostfix, "mgr.name" + languagePostfix, "emp.Ismanager" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("statusFlag", (Request["activeStatus"] + ""));
                ht.Add("onReportFlag", (Request["onReport"] + ""));
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);
                
                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("statusFlag", (Request["activeStatus"] + ""));
                ht.Add("onReportFlag", (Request["onReport"] + ""));
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmpMasterOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    if (obj["employee_id"] + "" != "1")
                    {
                        List<string> tempList = new List<string>();
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_id"]) + "' />");
                        tempList.Add(obj["employee_code"] + "");
                        tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                        //tempList.Add((obj["grade" + languagePostfix] + "").Length > 100 ? (obj["grade" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["grade" + languagePostfix] + ""));

                        if ((obj["join_date"] + "").Trim() != "")
                            tempList.Add(Numerics.GetDateTime(obj["join_date"] + "").ToString(AppSetting.dateFormat));
                        else
                            tempList.Add("&nbsp;");
                        if ((obj["manager_flag"] + "").Trim().ToUpper() == "Y")
                            tempList.Add("<i class='icon-ok'></i>");
                        else
                            tempList.Add("<i class='icon-remove'></i>");

                        if (Numerics.GetDecimal(obj["punch_flag"] + "") == 1)
                            tempList.Add("<i class='icon-ok'></i>");
                        else
                            tempList.Add("<i class='icon-remove'></i>");

                        if (Numerics.GetDecimal(obj["status_flag"] + "") == 1)
                            tempList.Add("<i class='icon-ok'></i>");
                        else
                            tempList.Add("<i class='icon-remove'></i>");

                        tempList.Add((obj["desigDesc" + languagePostfix] + "").Length > 100 ? (obj["desigDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["desigDesc" + languagePostfix] + ""));
                        tempList.Add((obj["orgDesc" + languagePostfix] + "").Length > 100 ? (obj["orgDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["orgDesc" + languagePostfix] + ""));
                        tempList.Add((obj["managerName" + languagePostfix] + "").Length > 100 ? (obj["managerName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["managerName" + languagePostfix] + ""));
                        
                        string tempAction = "";
                        tempAction = "";
                        if ( Request["v"] + "" != "reader" && new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_EMPLOYEE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                        {
                            tempAction = "<a href='" + Page.ResolveClientUrl("~/Emp/Save-Employee-Details/" + Encryption.Encrypt((obj["employee_id"] + "").Trim())) + "' style='text-decoration: none;'><img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a> ";
                        }
                        if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                        {
                            //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["employee_id"]) + ")' /> ";
                        }
                        tempList.Add(tempAction);
                        json.aaData.Add(tempList);
                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeePage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllByFilters
        /// <summary>
        /// Get All By Filters function
        /// Get all users from Employee_Master table with filters like organization/manager/designation
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllByFilters()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "emp.employee_id", "emp.employee_code", "emp.name" + languagePostfix, "emp.join_date", "emp.manager_flag", "emp.punch_flag", "emp.status_flag", "d.description" + languagePostfix, "org.description" + languagePostfix, "mgr.name" + languagePostfix, "emp.employee_id" };
                //string[] cols = { "emp.employee_id", "emp.employee_code", "emp.name" + languagePostfix, "g.description" + languagePostfix, "d.description" + languagePostfix, "org.description" + languagePostfix, "mgr.name" + languagePostfix, "emp.Ismanager" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string active = "";
                if ((Request["filter"] + "").ToLower() == "true" && (Request["active"] + "").ToLower() == "true")
                    active = "1";
                else if ((Request["active"] + "").ToLower() == "true")
                    active = "1";
                else
                    if ((Request["filter"] + "").ToLower() == "true")
                        active = "0";
                string joinDate = ((Request["join"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["join"] + "";
                if ((Request["filter"] + "").ToLower() == "true" && !joinDate.Contains('-') && joinDate.Length > 7)
                {
                    joinDate = joinDate.Insert(4, "-");
                    joinDate = joinDate.Insert(7, "-");
                }
                else
                    joinDate = "";

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecordsByFilters");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());

                ht.Add("empFilter", (Request["emp"] + "").Trim());
                ht.Add("joinDateFilter", joinDate);
                ht.Add("schTypeFilter", (Request["schType"] + "").Trim());
                ht.Add("orgFilter", (Request["org"] + "").Trim());
                ht.Add("desigFilter", (Request["desig"] + "").Trim());
                ht.Add("mgrFilter", (Request["mgr"] + "").Trim());
                ht.Add("statusFilter", active); 

                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCountByFilters");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());

                ht.Add("empFilter", (Request["emp"] + "").Trim());
                ht.Add("joinDateFilter", joinDate);
                ht.Add("schTypeFilter", (Request["schType"] + "").Trim());
                ht.Add("orgFilter", (Request["org"] + "").Trim());
                ht.Add("desigFilter", (Request["desig"] + "").Trim());
                ht.Add("mgrFilter", (Request["mgr"] + "").Trim());
                ht.Add("statusFilter", active); 
 
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmpMasterOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    if (obj["employee_id"] + "" != "1")
                    {
                        List<string> tempList = new List<string>();
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_id"]) + "' />");
                        tempList.Add(obj["employee_code"] + "");
                        tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                        //tempList.Add((obj["grade" + languagePostfix] + "").Length > 100 ? (obj["grade" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["grade" + languagePostfix] + ""));

                        if ((obj["join_date"] + "").Trim() != "")
                            tempList.Add(Numerics.GetDateTime(obj["join_date"] + "").ToString(AppSetting.dateFormat));
                        else
                            tempList.Add("&nbsp;");
                        if ((obj["manager_flag"] + "").Trim().ToUpper() == "Y")
                            tempList.Add("<i class='icon-ok'></i>");
                        else
                            tempList.Add("<i class='icon-remove'></i>");

                        if (Numerics.GetDecimal(obj["punch_flag"] + "") == 1)
                            tempList.Add("<i class='icon-ok'></i>");
                        else
                            tempList.Add("<i class='icon-remove'></i>");

                        if (Numerics.GetDecimal(obj["status_flag"] + "") == 1)
                            tempList.Add("<i class='icon-ok'></i>");
                        else
                            tempList.Add("<i class='icon-remove'></i>");

                        tempList.Add((obj["desigDesc" + languagePostfix] + "").Length > 100 ? (obj["desigDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["desigDesc" + languagePostfix] + ""));
                        tempList.Add((obj["orgDesc" + languagePostfix] + "").Length > 100 ? (obj["orgDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["orgDesc" + languagePostfix] + ""));
                        tempList.Add((obj["managerName" + languagePostfix] + "").Length > 100 ? (obj["managerName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["managerName" + languagePostfix] + ""));

                        string tempAction = "";
                        tempAction = "";
                        if (Request["v"] + "" != "reader" && new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_EMPLOYEE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                        {
                            tempAction = "<a href='" + Page.ResolveClientUrl("~/Emp/Save-Employee-Details/" + Encryption.Encrypt((obj["employee_id"] + "").Trim())) + "' style='text-decoration: none;'><img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a> ";
                        }
                        if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                        {
                            //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["employee_id"]) + ")' /> ";
                        }
                        tempList.Add(tempAction);
                        json.aaData.Add(tempList);
                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeePage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAllByFilters Function*********//
        #endregion


        #region Save
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string Save()
        {
            string chk = "0";
            string username = (Request["username"] + "").ToLower();
            string password = Encryption.Encrypt_AES((Request["pswd"] + "").Trim());
            int active = 0;
            int local = 0;
            int punch = 0;
            int shift = 0;
            int openShift = 0;
            int overtime = 0;
            int onreport = 0;
            int ShareRoster = 0;
            int notifyFlag = 0;
            int includeNotifications = 0;
            int webpunchFlag = 0;

            string id = ((Request["id"] + "").Trim() == "undefined") ? "0" : (Request["id"] + "").Trim();
            string joinDate = ((Request["join"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["join"] + "";
            string inactiveDate = ((Request["inactive"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["inactive"] + "";
            if (!joinDate.Contains('-') && joinDate.Length > 7)
            {
                joinDate = joinDate.Insert(4, "-");
                joinDate = joinDate.Insert(7, "-");
            }
            if (!inactiveDate.Contains('-') && inactiveDate.Length > 7)
            {
                inactiveDate = inactiveDate.Insert(4, "-");
                inactiveDate = inactiveDate.Insert(7, "-");
            }
            string ismgr = "N";
            string inpayroll = "N";
            if ((Request["ismgr"] + "").ToLower() == "true")
                ismgr = "Y";
            if ((Request["inpayroll"] + "").ToLower() == "true")
                inpayroll = "Y";
            if ((Request["active"] + "").ToLower() == "true")
                active = 1;
            if ((Request["local"] + "").ToLower() == "true")
                local = 1;
            if ((Request["punch"] + "").ToLower() == "true")
                punch = 1;
            if ((Request["shift"] + "").ToLower() == "true")
                shift = 1;
            if ((Request["openShift"] + "").ToLower() == "true")
                openShift = 1;
            if ((Request["overtime"] + "").ToLower() == "true")
                overtime = 1;
            if ((Request["onreport"] + "").ToLower() == "true")
                onreport = 1;
            if ((Request["shareRoster"] + "").ToLower() == "true")
                ShareRoster = 1;
            if ((Request["notifyFlag"] + "").ToLower() == "true")
                notifyFlag = 1;
            if ((Request["includeNotifications"] + "").ToLower() == "true")
                includeNotifications = 1;
            if ((Request["webpunch"] + "").ToLower() == "true")
                webpunchFlag = 1;

            int monthlyMissedHours = 0;
            if ((Request["monthlyMissedHours"] + "").ToLower() == "true" || (Request["monthlyMissedHours"] + "") == "1")
                monthlyMissedHours = 1;
            else
                monthlyMissedHours = 0;
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", id);
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("salutationEng", (Request["salEn"] + "").Trim());
            ht.Add("salutationArb", (Request["salAr"] + "").Trim());
            ht.Add("nameEng", (Request["nameEn"] + "").Trim());
            ht.Add("nameArb", (Request["nameAr"] + "").Trim());
            ht.Add("username", username);
            ht.Add("password", password);
            ht.Add("cardNo", (Request["card"] + "").Trim());
            ht.Add("remarks", (Request["remarks"] + "").Trim());
            ht.Add("photoFileName", (Request["photo"] + "").Trim());
            ht.Add("email", (Request["email"] + "").Trim());
            ht.Add("mobile", (Request["mobile"] + "").Trim());
            ht.Add("joinDate", joinDate);
            ht.Add("inactiveDate", inactiveDate);
            ht.Add("readerPassword", (Request["pin"] + "").Trim());

            ht.Add("orgID", (Request["orgID"] + "").Trim());
            ht.Add("sexFlag", (Request["sex"] + "").Trim());
            ht.Add("gradeID", (Request["grd"] + "").Trim());
            ht.Add("designationID", (Request["desig"] + "").Trim());
            ht.Add("countryID", (Request["cnt"] + "").Trim());
            ht.Add("empTypeID", (Request["empType"] + "").Trim());
            ht.Add("regionID", (Request["rgn"] + "").Trim());
            ht.Add("building_id", (Request["building_id"] + "").Trim());
            ht.Add("scheduleTypeID", (Request["sch"] + "").Trim());
            ht.Add("managerID", (Request["mgr"] + "").Trim());

            ht.Add("statusFlag", active);
            ht.Add("onReportFlag", onreport);
            ht.Add("inpayroll", inpayroll);
            ht.Add("localFlag", local);
            ht.Add("punchFlag", punch);
            ht.Add("shiftFlag", shift);
            ht.Add("openShiftFlag", openShift);
            ht.Add("overtimeFlag", overtime);
            ht.Add("managerFlag", ismgr);
            ht.Add("shareRoster", ShareRoster);
            ht.Add("notifyFlag", notifyFlag);
            ht.Add("includeNotifications", includeNotifications);
            ht.Add("webPunchFlag", webpunchFlag);
            ht.Add("MonthlyMissedHoursFlag", monthlyMissedHours);

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_EmpMasterOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result;
                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeePage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region GetZonesIdNameListString
        /// <summary>
        /// GetZonesIdNameListString function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetZonesIdNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "zone");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_GetDropdownNameValueOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string zoneStr = (String)GetGlobalResourceObject("Resource", "zones");

                sb.Append("<option value=''>" + chooseStr + " " + zoneStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Zones obj = new Zones();
                    obj.ID = Numerics.GetDecimal(row["ZoneId"] + "");
                    obj.NameEn = row["ZoneTitle"] + "";

                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + "  </option>");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetIdNameListString Function*********//
        #endregion


        #region GetSchedulesIdNameList
        /// <summary>
        /// GetSchedulesIdNameList function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetSchedulesIdNameList()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "schedules");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_GetDropdownNameValueOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string scheduleStr = (String)GetGlobalResourceObject("Resource", "schedules");

                sb.Append("<option value=''>" + chooseStr + " " + scheduleStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Schedule obj = new Schedule();
                    obj.ID = Numerics.GetDecimal(row["ScheduleId"] + "");
                    obj.NameEn = row["ScheduleTitle"] + "";

                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + "  </option>");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetIdNameListString Function*********//
        #endregion


        #region GetBuildingsIdNameListString
        /// <summary>
        /// GetBuildingsIdNameListString function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetBuildingsIdNameListByZoneString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "building");
                ht.Add("zoneId", Request["zoneID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_GetDropdownNameValueOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string buildingStr = (String)GetGlobalResourceObject("Resource", "building");

                sb.Append("<option value=''>" + chooseStr + " " + buildingStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Buildings obj = new Buildings();
                    obj.ID = Numerics.GetDecimal(row["BuildingId"] + "");
                    obj.NameEn = row["BuildingTitle"] + "";

                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + "  </option>");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetIdNameListString Function*********//
        #endregion

    }
}