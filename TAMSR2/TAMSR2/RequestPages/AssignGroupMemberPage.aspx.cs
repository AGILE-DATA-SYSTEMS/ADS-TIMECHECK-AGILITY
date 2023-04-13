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
    public partial class AssignGroupMemberPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/AssignGroupMemberPage.aspx"));


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
            else if (Request["key"] + "" == "assignGroupMembers")
            {
                data = AssignGroupMembers();
            }
            else if (Request["key"] + "" == "removeGroupMembers")
            {
                data = RemoveGroupMembers();
            }
            else if (Request["key"] + "" == "getAllMembersByOrgIDGroupID")
            {
                data = GetAllMembersByOrgIDGroupID();
            }
            else if (Request["key"] + "" == "getAllEmployeesByOrgIDGroupID")
            {
                data = GetAllEmployeesByOrgIDGroupID();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByID();
            }
            else if (Request["key"] + "" == "getIdNameListString")
            {
                data = GetIdNameListString();
            }
            else if (Request["key"] + "" == "getUsersInGroupByGroupID")
            {
                data = GetUsersInGroupByGroupID();
            }
            else if (Request["key"] + "" == "getUsersNotInGroupByGroupID")
            {
                data = GetUsersNotInGroupByGroupID();
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

                    obj.ManagerFlag = Numerics.GetBool(dv[0]["manager_flag"] + "");
                    obj.Inpayroll = Numerics.GetBool(dv[0]["inpayroll"] + "");

                    obj.JoinDate = Numerics.GetDateTime(dv[0]["join_date"]);
                    obj.InactiveDate = Numerics.GetDateTime(dv[0]["inactive_date"]);
                    obj.JoinDateStr = (dv[0]["join_date"] + "").Trim() != "" ? obj.JoinDate.ToString("yyyy-MM-dd") : "";
                    obj.InactiveDateStr = (dv[0]["inactive_date"] + "").Trim() != "" ? obj.InactiveDate.ToString("yyyy-MM-dd") : "";

                    obj.Username = (dv[0]["login"] + "").Trim();
                    obj.Password = Encryption.Decrypt((dv[0]["password"] + "").Trim());
                    obj.Code = dv[0]["employee_code"] + "";
                    obj.SalutationEn = dv[0]["salutation_eng"] + "";
                    obj.SalutationAr = dv[0]["salutation_arb"] + "";
                    obj.NameEn = dv[0]["name_eng"] + "";
                    obj.NameAr = dv[0]["name_arb"] + "";
                    obj.Email = dv[0]["email"] + "";
                    obj.CardNo = dv[0]["card_number"] + "";
                    obj.ReaderPassword = dv[0]["reader_password"] + "";
                    obj.PhotoFileName = dv[0]["photo_file_name"] + "";
                    obj.Remarks = dv[0]["remarks"] + "";

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
        /// GetByID function
        /// Get user by ID from TAMSR2_LICENCE table 
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
        //*********End Of GetAll Function*********//
        #endregion
        //GetUsersInGroupByGroupID


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
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameAr + " </option>");
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

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByOrgID");
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
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameAr + " </option>");
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
        //*********End Of GetAll Function*********//
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
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameAr + " </option>");
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
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameAr + " </option>");
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
        //*********End Of GetAll Function*********//
        #endregion


        #region RemoveGroupMembers
        /// <summary>
        /// RemoveGroupMembers function
        /// </summary>
        /// <returns>it will return 1 if successfull.</returns>
        public string RemoveGroupMembers()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            int temp = 0;
            try
            {
                int count = Numerics.GetInt(Request["count"] + "");
                string groupID = "";
                try
                {
                    groupID = Encryption.Decrypt((Request["groupID"] + "").Trim());
                }
                catch (Exception ex)
                {
                    groupID = (Request["groupID"] + "").Trim();
                }
                string ids = "";
                for (int k = 1; k <= count; k++)
                {
                    ids += Request["chk" + k] + ",";
                }
                ids = ids.TrimEnd(',');
                Hashtable ht = new Hashtable();
                ht.Add("action", "removeGroupMembers");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("groupID", groupID);
                ht.Add("empList", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_GroupMemberOps", ht);
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/AssignGroupMemberPage.aspx.RemoveGroupMembers()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            if (temp > 0)
                return "1";
            else
                return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region AssignGroupMembers
        /// <summary>
        /// AssignGroupMembers function
        /// </summary>
        /// <returns>it will return 1 if successfull.</returns>
        public string AssignGroupMembers()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            int temp = 0;
            try
            {
                int count = Numerics.GetInt(Request["count"] + "");
                string groupID = "";
                try
                {
                    groupID = Encryption.Decrypt((Request["groupID"] + "").Trim());
                }
                catch (Exception ex)
                {
                    groupID = (Request["groupID"] + "").Trim();
                }
                string ids = "";
                for (int k = 1; k <= count; k++)
                {
                    ids += Request["chk" + k] + ",";
                }
                ids = ids.TrimEnd(',');
                Hashtable ht = new Hashtable();
                ht.Add("action", "assignGroupMembers");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("groupID", groupID);
                ht.Add("empList", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_GroupMemberOps", ht);
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/AssignGroupMemberPage.aspx.AssignGroupMembers()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            if (temp > 0)
                return "1";
            else
                return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllMembersByOrgIDGroupID
        /// <summary>
        /// GetAllMembersByOrgIDGroupID function
        /// GetAllMembersByOrgIDGroupID it will fetch all employees based on organization id and group id passed.
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllMembersByOrgIDGroupID()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string orgID = "";
                string groupID = "";
                try
                {
                    orgID = Encryption.Decrypt((Request["orgID"] + "").Trim());
                }
                catch (Exception ex)
                {
                    orgID = (Request["orgID"] + "").Trim();
                }
                try
                {
                    groupID = Encryption.Decrypt((Request["groupID"] + "").Trim());
                }
                catch (Exception ex)
                {
                    groupID = (Request["groupID"] + "").Trim();
                }

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "emp.employee_id", "emp.employee_code", "emp.name" + languagePostfix, "d.description" + languagePostfix, "org.description" + languagePostfix };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                if (groupID == "")
                {
                    json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                    json.iTotalRecords = 0;
                    json.iTotalDisplayRecords = json.iTotalRecords;
                    List<string> list = new List<string>();
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    json.aaData.Add(list);
                    return new JavaScriptSerializer().Serialize(json);
                }
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getMemberRecordsByOrgIDAndGroupID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("groupID", groupID);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_GroupMemberOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getMemberCountByOrgIDAndGroupID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("groupID", groupID);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_GroupMemberOps", ht));
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
                        tempList.Add((obj["desigDesc" + languagePostfix] + "").Length > 100 ? (obj["desigDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["desigDesc" + languagePostfix] + ""));
                        tempList.Add((obj["orgDesc" + languagePostfix] + "").Length > 100 ? (obj["orgDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["orgDesc" + languagePostfix] + ""));
                        json.aaData.Add(tempList);
                    }
                }
                if (json.aaData.Count == 0)
                {
                    List<string> list = new List<string>();
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    json.aaData.Add(list);
                    return new JavaScriptSerializer().Serialize(json);
                }
                
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/AssignGroupMemberPage.aspx.GetAllMembersByOrgIDGroupID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllEmployeesByOrgIDGroupID
        /// <summary>
        /// GetAllEmployeesByOrgIDGroupID function
        /// GetAllEmployeesByOrgIDGroupID it will fetch all employees based on organization id and group id passed.
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllEmployeesByOrgIDGroupID()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string orgID = "";
                string groupID = "";
                try
                {
                    orgID = Encryption.Decrypt((Request["orgID"] + "").Trim());
                }
                catch (Exception ex)
                {
                    orgID = (Request["orgID"] + "").Trim();
                }
                try
                {
                    groupID = Encryption.Decrypt((Request["groupID"] + "").Trim());
                }
                catch (Exception ex)
                {
                    groupID = (Request["groupID"] + "").Trim();
                }

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "emp.employee_id", "emp.employee_code", "emp.name" + languagePostfix, "d.description" + languagePostfix, "org.description" + languagePostfix};

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                //if (groupID == "" || orgID == "")
                //{
                //    json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                //    json.iTotalRecords = 0;
                //    json.iTotalDisplayRecords = json.iTotalRecords;
                //    List<string> list = new List<string>();
                //    list.Add("");
                //    list.Add("");
                //    list.Add("");
                //    list.Add("");
                //    list.Add("");
                //    json.aaData.Add(list);
                //    return new JavaScriptSerializer().Serialize(json);
                //}
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getEmployeeRecordsByOrgIDAndGroupID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("groupID", groupID);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_GroupMemberOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getEmployeeCountByOrgIDAndGroupID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("groupID", groupID);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_GroupMemberOps", ht));
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
                        tempList.Add((obj["desigDesc" + languagePostfix] + "").Length > 100 ? (obj["desigDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["desigDesc" + languagePostfix] + ""));
                        tempList.Add((obj["orgDesc" + languagePostfix] + "").Length > 100 ? (obj["orgDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["orgDesc" + languagePostfix] + ""));
                        json.aaData.Add(tempList);
                    }
                }
                if (json.aaData.Count == 0)
                {
                    List<string> list = new List<string>();
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    list.Add("");
                    json.aaData.Add(list);
                    return new JavaScriptSerializer().Serialize(json);
                }
                
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/AssignGroupMemberPage.aspx.GetAllEmployeesByOrgIDGroupID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
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
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "emp.employee_id", "emp.employee_code", "emp.name" + languagePostfix, "d.description" + languagePostfix, "org.description" + languagePostfix, "mgr.name" + languagePostfix, "emp.Ismanager" };
                
                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
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
                        tempList.Add((obj["desigDesc" + languagePostfix] + "").Length > 100 ? (obj["desigDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["desigDesc" + languagePostfix] + ""));
                        tempList.Add((obj["orgDesc" + languagePostfix] + "").Length > 100 ? (obj["orgDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["orgDesc" + languagePostfix] + ""));
                        tempList.Add((obj["managerName" + languagePostfix] + "").Length > 100 ? (obj["managerName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["managerName" + languagePostfix] + ""));

                        string tempAction = "";
                        tempAction = "";
                        if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_EMPLOYEE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
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
                new ExceptionLog().WriteLog("RequestPages/AssignGroupMemberPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
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
            string password = Encryption.Encrypt((Request["pswd"] + "").Trim());
            int active = 0;
            int local = 0;
            int punch = 0;
            int shift = 0;
            int overtime = 0;
            int onreport = 0;
            int shareRoster = 0;

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
            if ((Request["overtime"] + "").ToLower() == "true")
                overtime = 1;
            if ((Request["onreport"] + "").ToLower() == "true")
                onreport = 1;
            if ((Request["shareRoster"] + "").ToLower() == "true")
                shareRoster = 1;

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
            ht.Add("scheduleTypeID", (Request["sch"] + "").Trim());
            ht.Add("managerID", (Request["mgr"] + "").Trim());

            ht.Add("statusFlag", active);
            ht.Add("onReportFlag", onreport);
            ht.Add("inpayroll", inpayroll);
            ht.Add("localFlag", local);
            ht.Add("punchFlag", punch);
            ht.Add("shiftFlag", shift);
            ht.Add("overtimeFlag", overtime);
            ht.Add("managerFlag", ismgr);
            ht.Add("shareRoster", shareRoster);

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
                new ExceptionLog().WriteLog("RequestPages/AssignGroupMemberPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

    }
}