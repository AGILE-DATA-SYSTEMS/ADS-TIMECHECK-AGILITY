using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
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
    public partial class EmployeeLeavePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        public string GetApplyApporveRejectStatus(int temp)
        {
            if (temp == 0)
                return (String)GetGlobalResourceObject("Resource", "applied") + "";
            else if (temp == 1)
                return (String)GetGlobalResourceObject("Resource", "approved") + "";
            else if (temp == 2)
                return (String)GetGlobalResourceObject("Resource", "rejected") + "";
            else if (temp == 3)
                return (String)GetGlobalResourceObject("Resource", "pendingManager") + "";
            else if (temp == 4)
                return (String)GetGlobalResourceObject("Resource", "pendingHR") + "";
            else
                return "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/EmployeeLeavePage.aspx"));


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
            else if (Request["key"] + "" == "getAllPending")
            {
                data = GetAllPending();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByID();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if (Request["key"] + "" == "approveLeaves")
            {
                data = Approve();
            }
            else if (Request["key"] + "" == "rejectLeaves")
            {
                data = Reject();
            }
            else if (Request["key"] + "" == "getIdNameListString")
            {
                data = GetIdNameListString();
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
            string id = "0";
            try
            {
                id = Encryption.Decrypt(Request["id"] + "");
            }
            catch (Exception ex)
            {
                id = (Request["id"] + "").Trim();
                if (id == "undefined")
                    id = "0";
            }
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            EmployeeLeave obj = new EmployeeLeave();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeLeaveOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["employee_leave_id"]);
                    obj.LeaveID = Numerics.GetDecimal(dv[0]["leave_id"]);
                    obj.EmployeeID = Numerics.GetDecimal(dv[0]["employee_id"]);
                    obj.ApproveRejectFlag = Numerics.GetInt(dv[0]["approve_reject_flag"] + "");
                    obj.Remarks = dv[0]["remarks"] + "";
                    if (dv[0]["from_date"] + "" != "")
                    {
                        obj.FromDate = Numerics.GetDateTime(dv[0]["from_date"]);
                        obj.FromDateStr = obj.FromDate.ToString("yyyy-MM-dd");
                    }
                    if (dv[0]["to_date"] + "" != "")
                    {
                        obj.ToDate = Numerics.GetDateTime(dv[0]["to_date"]);
                        obj.ToDateStr = obj.ToDate.ToString("yyyy-MM-dd");
                    }
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeLeaveOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string HolidayStr = (String)GetGlobalResourceObject("Resource", "Holiday");

                sb.Append("<option value=''>" + chooseStr + " " + HolidayStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Holiday obj = new Holiday();
                    obj.ID = Numerics.GetDecimal(row["holiday_id"] + "");
                    obj.DescriptionEn = row["description_eng"] + "";
                    obj.DescriptionAr = row["description_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.DescriptionAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.DescriptionEn + "  </option>");
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmployeeLeaveOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeLeavePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region Approve
        /// <summary>
        /// Approve function
        /// Approve
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string Approve()
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
                ht.Add("action", "Approve");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmployeeLeaveOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeLeavePage.aspx.Approve()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region Reject
        /// <summary>
        /// Approve function
        /// Approve
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string Reject()
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
                ht.Add("action", "Reject");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmployeeLeaveOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeLeavePage.aspx.Reject()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion
        

        #region GetAllPending
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllPending()
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

                string[] cols = { "empLeaves.employee_leave_id", "emp.employee_code", "emp.name" + languagePostfix, "lv.description" + languagePostfix, "empLeaves.from_date", "empLeaves.to_date", "empLeaves.approve_reject_flag", "empLeaves.employee_leave_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getPendingRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeLeaveOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getPendingCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeLeaveOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if ((obj["employee_id"] + "").Trim() != Session["ID"] + "" && Numerics.GetInt(obj["approve_reject_flag"] + "") != 1)
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_leave_id"]) + "' />");
                    else
                        tempList.Add("&nbsp;");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                    tempList.Add((obj["description" + languagePostfix] + "").Length > 100 ? (obj["description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["description" + languagePostfix] + ""));

                    if (obj["from_date"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["from_date"]).ToString(AppSetting.dateFormat));
                    }
                    else
                    {
                        tempList.Add("");
                    }
                    if (obj["to_date"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["to_date"]).ToString(AppSetting.dateFormat));
                    }
                    else
                    {
                        tempList.Add("");
                    }
                    tempList.Add((obj["remarks"] + "").Trim());
                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeLeavePage.aspx.GetAll()", 0, ex);
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
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "empLeaves.employee_leave_id", "emp.employee_code", "emp.name" + languagePostfix, "lv.description" + languagePostfix, "empLeaves.from_date", "empLeaves.to_date", "empLeaves.approve_reject_flag", "empLeaves.employee_leave_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeLeaveOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeLeaveOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    //if (Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Session["ID"] + "" == obj["created_id"] + "")
                    //    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_leave_id"]) + "' />");
                    //else
                    //    tempList.Add("&nbsp;");
                    var empLeaveId = Numerics.GetDecimal(obj["employee_leave_id"]);
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + empLeaveId + "' />");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                    tempList.Add((obj["description" + languagePostfix] + "").Length > 100 ? (obj["description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["description" + languagePostfix] + ""));

                    if (obj["from_date"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["from_date"]).ToString(AppSetting.dateFormat));
                    }
                    else
                    {
                        tempList.Add("");
                    }
                    if (obj["to_date"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["to_date"]).ToString(AppSetting.dateFormat));
                    }
                    else
                    {
                        tempList.Add("");
                    }
                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    string tempAction = "";
                    tempAction = "";
                    //if (Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Session["ID"] + "" == obj["created_id"] + "" && (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_EMP_LEAVE) == true || Numerics.GetBool(Session["CanUpdate"]) == true))
                    //{
                    //    tempAction = "<a style='text-decoration: none;' href='" + path + "Leaves/Save-Employee-Leave/" +
                    //                    Encryption.Encrypt(obj["employee_leave_id"] + "") + "'>" +
                    //                    "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    //}
                    if ((Session["ID"] + "" == obj["created_id"] + "" || (Session["UserRoles"]+"").Contains("ADMIN")) && (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_EMP_LEAVE) == true || Numerics.GetBool(Session["CanUpdate"]) == true))
                    {
                        tempAction = "<a style='text-decoration: none;' href='" + path + "Leaves/Save-Employee-Leave/" +
                                        Encryption.Encrypt(obj["employee_leave_id"] + "") + "'>" +
                                        "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    }
                    //if (Numerics.GetBool(Session["CanUpdate"]) == true || true)
                    //{
                    //    tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["holiday_id"]) + ")' /> &nbsp; ";
                    //}
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["Holiday_id"]) + ")' /> ";
                    }

                    if (empLeaveId > 0)
                    {
                        string encryptedLeaveId = Encryption.Encrypt(empLeaveId.ToString());

                        string virtualPath = "/Uploads/employeeLeaves/attachement/";
                        string ext = "." + obj["ext"] + "";
                        if (!string.IsNullOrEmpty(ext) && ext!=".")
                        {
                            string encryptedVirtualPath = virtualPath + encryptedLeaveId + ext;

                            if (System.IO.File.Exists(Server.MapPath(encryptedVirtualPath)))
                            {
                                tempList.Add("<a href=" + encryptedVirtualPath + " target='_blank' ><img src='" + path + "images/attachment.png' title='Edit' alt='Edit' /> &nbsp; </a>");
                            }
                            else
                            {
                                tempList.Add("");
                            }
                        }
                        else
                        {
                            tempList.Add("");
                        }
                    }

                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeLeavePage.aspx.GetAll()", 0, ex);
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
            int approve = 0;
            if ((Request["approve"] + "").Trim().ToLower() == "true" && Session["ID"] + "" != Request["empID"] + "" && new DBAppSetting().GetAutoLeaveApproval(Session["ID"] + "", Connection.GetUserConnectionStrinng()) == false)
                approve = 1;
            string id = "0";
            try
            {
                if (Request["id"] + "" == "undefined" || Request["id"] + "" == "")
                    id = "0";
                else
                    id = Encryption.Decrypt(Request["id"] + "");
            }
            catch (Exception ex)
            {
                id = (Request["id"] + "").Trim();
                if (id == "undefined" || id == "")
                    id = "0";
            }
            string fromDate = ((Request["fromDate"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["fromDate"] + "";
            string toDate = ((Request["toDate"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["toDate"] + "";
            if (!fromDate.Contains('-') && fromDate.Length > 7)
            {
                fromDate = fromDate.Insert(4, "-");
                fromDate = fromDate.Insert(7, "-");
            }
            if (!toDate.Contains('-') && toDate.Length > 7)
            {
                toDate = toDate.Insert(4, "-");
                toDate = toDate.Insert(7, "-");
            }

            if (Numerics.GetDateTime(fromDate) > Numerics.GetDateTime(toDate))
            {
                return "-3";
            }

            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", id);
            ht.Add("employeeID", (Request["empID"] + "").Trim());
            ht.Add("leaveID", (Request["leaveID"] + "").Trim());
            ht.Add("fromDate", fromDate);
            ht.Add("toDate", toDate);
            ht.Add("approveRejectFlag", approve);
            ht.Add("remarks", (Request["remarks"] + "").Trim());
            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");
            ht.Add("extension", (Request["extension"] + "").Trim());

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeLeaveOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result;
                }
                else
                {
                    chk = result;
                }


                if (Numerics.GetDecimal(result) > 0)
                {
                    if (Request["AllowAttachement"] + "" == "true")
                    {
                        if (!CheckAttachement(Request))
                        {
                            return "-7";
                        }
                        var file = Request.Files[0];
                        string fileName;
                        if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                        {
                            string[] files = file.FileName.Split(new char[] { '\\' });
                            fileName = files[files.Length - 1];
                        }
                        else
                        {
                            fileName = file.FileName;
                        }

                        string encryptedLeaveId = Encryption.Encrypt(result);

                        string fileExt;
                        fileExt = System.IO.Path.GetExtension(fileName); //System.IO.Path.GetExtension(file.FileName)
                        string dirPath = "";
                        string virtualPath = "/Uploads/employeeLeaves/attachement/";
                        if (!System.IO.Directory.Exists(virtualPath))
                        {
                            System.IO.Directory.CreateDirectory(Server.MapPath(virtualPath));
                        }
                        string OriginalList = encryptedLeaveId + fileExt;// ".pdf";
                        dirPath = Server.MapPath(virtualPath + OriginalList);
                        file.SaveAs(dirPath);
                    }

                    chk = "Success";


                    // chk = "Success";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeLeavePage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        private bool CheckAttachement(HttpRequest Request)
        {
            decimal id = Numerics.GetDecimal(Request["id"] + "");
            decimal updateUserID = Numerics.GetDecimal(Request["userID"] + "");
            TAMSR2Company obj = new TAMSR2Company(id);

            bool ResultJSON = false;
            if (Request.Files.Count > 0)
            {
                var file = Request.Files[0];
                string fileName;
                if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                {
                    string[] files = file.FileName.Split(new char[] { '\\' });
                    fileName = files[files.Length - 1];
                }
                else
                {
                    fileName = file.FileName;
                }
                if (fileName.Trim() != "")
                {
                    string extension = System.IO.Path.GetExtension(file.FileName);

                    string AllowedPatchedFile = extension;

                    if (!string.IsNullOrEmpty(AllowedPatchedFile) && AllowedPatchedFile.IndexOf(extension) != -1)
                    {

                        float FileBytes = file.ContentLength;
                        float mbs = FileBytes / (1024 * 1024);
                        if (mbs > 2.0)
                        {
                            ResultJSON = false;
                            return ResultJSON;
                        }

                        ResultJSON = true;

                    }
                    else
                    {
                        ResultJSON = false;
                    }

                }
                else
                {
                    ResultJSON = false;
                }
            }
            return ResultJSON;
        }
    }
}