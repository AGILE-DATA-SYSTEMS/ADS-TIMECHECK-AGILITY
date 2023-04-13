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
    public partial class SinglePermissionPage : System.Web.UI.Page
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
                return (String)GetGlobalResourceObject("Resource", "cancelled") + "";
            else if (temp == 4)
                return (String)GetGlobalResourceObject("Resource", "pendingCancel") + "";
            else
                return "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/SinglePermissionPage.aspx"));


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
            else if (Request["key"] + "" == "cancelByID")
            {
                data = CancelByID();
            }
            else if (Request["key"] + "" == "approvePermissions")
            {
                data = Approve();
            }
            else if (Request["key"] + "" == "rejectPermissions")
            {
                data = Reject();
            }
            else if (Request["key"] + "" == "save")
            {
                data = Save();
            }
            else if (Request["key"] + "" == "UploadAttachment")
            {
                data = UploadAttachment();
            }
            else if (Request["key"] + "" == "permissionbalance")
            {
                data = GetPermissionBalance();
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
            SinglePermission obj = new SinglePermission();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["single_permissions_id"]);
                    obj.PermissionTypeID = Numerics.GetDecimal(dv[0]["permission_type_id"]);
                    obj.EmployeeID = Numerics.GetDecimal(dv[0]["employee_id"]);
                    obj.ApproveRejectFlag = Numerics.GetInt(dv[0]["approve_reject_flag"] + "");
                    obj.Remarks = dv[0]["remarks"] + "";
                    obj.FromTime = (dv[0]["from_time"] + "").Trim();
                    obj.ToTime = (dv[0]["to_time"] + "").Trim();
                    obj.Minutes = Convert.ToInt32((dv[0]["minutes"] + "").Trim());

                    obj.Saturday = (dv[0]["Saturday_minutes"] + "").Trim();
                    obj.Sunday = (dv[0]["Sunday_minutes"] + "").Trim();
                    obj.Monday = (dv[0]["Monday_minutes"] + "").Trim();
                    obj.Tuesday = (dv[0]["Tuesday_minutes"] + "").Trim();
                    obj.Wednesday = (dv[0]["Wednesday_minutes"] + "").Trim();
                    obj.Thursday = (dv[0]["Thursday_minutes"] + "").Trim();
                    obj.Friday = (dv[0]["Friday_minutes"] + "").Trim();

                    obj.CategoryID = (dv[0]["category_id"] + "").Trim();


                    if (dv[0]["from_date"] + "" != "")
                    {
                        obj.FromDate = Numerics.GetDateTime(dv[0]["from_date"]);
                        obj.FromDateTimeStr = obj.FromDate.ToString("dd-MM-yyyy");
                    }
                    if (dv[0]["to_date"] + "" != "")
                    {
                        obj.ToDate = Numerics.GetDateTime(dv[0]["to_date"]);
                        obj.ToDateTimeStr = obj.ToDate.ToString("dd-MM-yyyy");
                    }
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_date"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["last_updated_id"]);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(obj);
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
            DataView dv = new DataView();
            string result = "-1";
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

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);
                if (dv != null)
                {
                    if (Convert.ToInt32(dv[0][0]) > 0)
                        result = "1";
                    else
                        result = dv[0][0] + "";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return result;
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region DeleteByID
        /// <summary>
        /// DeleteByID function
        /// Delete user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string CancelByID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            string result = "-1";
            try
            {
                string ids = Request["Id"];
                Hashtable ht = new Hashtable();
                ht.Add("action", "cancelByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);
                if (dv != null)
                {
                    if (Convert.ToInt32(dv[0][0]) > 0)
                        result = "1";
                    else
                        result = dv[0][0] + "";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return result;
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
            DataView dv = new DataView();
            string result = "";
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
                ht.Add("action", "approve");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);
                if (dv != null)
                {
                    if (Convert.ToInt32(dv[0][0]) > 0)
                        result = "1";
                    else
                        result = dv[0][0] + "";

                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return result;
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
            DataView dv = new DataView();
            string result = "0";
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

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);
                if (dv != null)
                {
                    if (Convert.ToInt32(dv[0][0]) > 0)
                        result = "1";
                    else
                        result = dv[0][0] + "";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return result;
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

                //string[] cols = { "sngPerm.single_permissions_id", "emp.employee_code", "emp.name" + languagePostfix, "sngPerm.created_date", "permType.description" + languagePostfix, "sngPerm.from_date", "sngPerm.to_date", "sngPerm.from_time", "sngPerm.to_time", "sngPerm.minutes", "sngPerm.approve_reject_flag", "sngPerm.created_date", "sngPerm.single_permissions_id" };
                string[] cols = { "sngPerm.single_permissions_id", "emp.employee_code", "emp.name" + languagePostfix, "permType.description" + languagePostfix, "sngPerm.from_date", "sngPerm.to_date", "sngPerm.from_time", "sngPerm.to_time", "sngPerm.minutes", "sngPerm.approve_reject_flag", "emp_ul.name_eng", "sngPerm.last_updated_time" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string approveRejectFlag = (Request["status"] + "").Trim();
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("approveRejectFlag", approveRejectFlag);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("approveRejectFlag", approveRejectFlag);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_SinglePermissionOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();

                    if ((Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && obj["approval_status"] + "" != "Cancelled" && obj["approval_status"] + "" != "Rejected" && Session["ID"] + "" == obj["created_id"] + "") || Numerics.GetBool(Session["CanDelete"]) == true)
                    {
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["single_permissions_id"]) + "' />");
                    }
                    else if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_SINGLE_PERMISSION_ALL) == true)
                    {
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["single_permissions_id"]) + "' />");
                    }
                    else
                        tempList.Add("&nbsp;");

                    tempList.Add(obj["empCode"] + "");
                    tempList.Add((obj["empName" + languagePostfix] + "").Length > 100 ? (obj["empName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["empName" + languagePostfix] + ""));
                    //tempList.Add(Numerics.GetDateTime(obj["created_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add((obj["permDescription" + languagePostfix] + "").Length > 100 ? (obj["permDescription" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["permDescription" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["from_time"] + "");
                    tempList.Add(obj["to_time"] + "");
                    tempList.Add(Numerics.FormatMinsToHHmm((obj["minutes"] + "").Trim()));
                    tempList.Add(obj["approval_status"] + "");
                    //tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));


                    tempList.Add(obj["actionBy"] + "");
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_time"]).ToString(AppSetting.dateTimeFormat24));


                    string tempAction = "";
                    tempAction = "";
                    if (Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && obj["approval_status"] + "" != "Cancelled" && obj["approval_status"] + "" != "Rejected" && Session["ID"] + "" == obj["created_id"] + "" && (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_SINGLE_PERMISSION) == true || Numerics.GetBool(Session["CanUpdate"]) == true))
                    {
                        tempAction = "<a style='text-decoration: none;' href='" + path + "Leaves/Save-Short-Permission/" +
                                        Encryption.Encrypt(obj["single_permissions_id"] + "") + "'>" +
                                        "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    }
                    tempList.Add(tempAction);
                    /*tempAction = "";
                    if (Numerics.GetInt(obj["approve_reject_flag"] + "") == 1 && Session["ID"] + "" == obj["employee_id"] + "")
                    {
                        tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Cancel(" + Numerics.GetDecimal(obj["single_permissions_id"]) + ")' /> ";
                    }

                    tempList.Add(tempAction);
                    */
                    tempAction = "";
                    if (Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Numerics.GetBool(obj["ValidMedicalPass"]) == true)
                    {
                        tempAction += "<img src='" + path + "images/print-icon.png' alt='Print' title='Print' onclick='Download(" + Numerics.GetDecimal(obj["single_permissions_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
                    tempAction = "";

                    string virtualPath = "/Uploads/employeePermissions/attachement/";

                    string OriginalList = Encryption.Encrypt(obj["single_permissions_id"] + "") + ".pdf";
                    virtualPath = virtualPath + OriginalList;

                    if (Numerics.GetBool(obj["attachment_required"] + "") == true && Numerics.GetBool(obj["attachment_uploaded"] + "") == true)
                    {
                        tempList.Add("<a href=" + virtualPath + " target='_blank' ><img src='" + path + "images/attachment.png' title='Attachment' alt='attachment' /> &nbsp; </a>");
                    }
                    else if (Numerics.GetBool(obj["attachment_required"] + "") == true && obj["approval_status"] + "" != "Cancelled" && obj["approval_status"] + "" != "Rejected" && Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Numerics.GetBool(obj["ValidMedicalPass"]) == true)
                    {
                        tempAction += "<img src='" + path + "images/upload-icon.png' alt='Upload' title='Upload' onclick='Upload(" + Numerics.GetDecimal(obj["single_permissions_id"]) + ")' /> ";
                    }

                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region GetAllPending
        /// <summary>
        /// Get All Pending function
        /// Get all pending permissions
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
                var sessionId = Session["ID"] + "";
                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                //string[] cols = { "sngPerm.single_permissions_id", "emp.employee_code", "emp.name" + languagePostfix, "sngPerm.created_date", "permType.description" + languagePostfix, "sngPerm.from_date", "sngPerm.to_date", "sngPerm.from_time", "sngPerm.to_time", "sngPerm.minutes", "sngPerm.approve_reject_flag", "sngPerm.created_date", "sngPerm.single_permissions_id" };
                string[] cols = { "sngPerm.single_permissions_id", "emp.employee_code", "emp.name" + languagePostfix, "permType.description" + languagePostfix, "sngPerm.from_date", "sngPerm.to_date", "sngPerm.from_time", "sngPerm.to_time", "sngPerm.minutes", "sngPerm.approve_reject_flag", "sngPerm.created_date", "sngPerm.single_permissions_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();
                string approveRejectFlag = (Request["status"] + "").Trim();

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getPermissionRecords");
                ht.Add("sessionID", sessionId);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("approveRejectFlag", approveRejectFlag);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getPermissionRecordCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("approveRejectFlag", approveRejectFlag);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_SinglePermissionOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    var approve_RejectFlag = Numerics.GetInt(obj["approve_reject_flag"] + "");
                    var approverId = Numerics.GetInt(obj["last_updated_id"] + "");
                    var managerId = 0;
                    int.TryParse(sessionId, out managerId);
                    if (managerId == approverId && (approve_RejectFlag == 1 || approve_RejectFlag == 2))
                    {
                        continue;
                    }
                    List<string> tempList = new List<string>();

                    if ((obj["employee_id"] + "").Trim() != Session["ID"] + ""
                            && (
                                Numerics.GetInt(obj["approve_reject_flag"] + "") != 1
                                    || DateTime.UtcNow.AddHours(4).Date < Numerics.GetDateTime(obj["from_date"] + "")
                            )
                        )
                    {
                        if ((obj["last_updated_id"] + "").Trim() != Session["ID"] + "")
                            tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["single_permissions_id"]) + "' />");
                        else
                            tempList.Add("&nbsp;");
                    }
                    else
                        tempList.Add("&nbsp;");
                    tempList.Add(obj["empCode"] + "");
                    tempList.Add((obj["empName" + languagePostfix] + "").Length > 100 ? (obj["empName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["empName" + languagePostfix] + ""));
                    //tempList.Add(Numerics.GetDateTime(obj["created_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add((obj["permDescription" + languagePostfix] + "").Length > 100 ? (obj["permDescription" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["permDescription" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["from_time"] + "");
                    tempList.Add(obj["to_time"] + "");
                    tempList.Add(Numerics.FormatMinsToHHmm((obj["minutes"] + "").Trim()));
                    tempList.Add((obj["remarks"] + "").Trim());
                    tempList.Add(obj["approval_status"] + "");
                    //tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    if (obj["single_permissions_id"] + "" != "")
                    {

                        string virtualPath = "/Uploads/employeePermissions/attachement/";

                        string encryptedVirtualPath = virtualPath + Encryption.Encrypt(obj["single_permissions_id"] + "") + ".pdf";

                        if (System.IO.File.Exists(Server.MapPath(encryptedVirtualPath)))
                        {
                            tempList.Add("<a href=" + encryptedVirtualPath + " target='_blank' ><img src='" + path + "images/attachment.png' title='Edit' alt='Edit' /> &nbsp; </a>");
                        }
                        else
                        {
                            tempList.Add("");
                        }
                    }
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.GerAll()", 0, ex);
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

            string fromTime = Request["fromTime"] + "";
            string toTime = Request["toTime"] + "";

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
            DateTime dtFrom = Convert.ToDateTime(fromDate + " " + fromTime + ":00");
            DateTime dtTo = Convert.ToDateTime(toDate + " " + toTime + ":00");
            int minutes = 0;
            if (Request["CatId"] + "" == "0")
            {
                minutes = Numerics.GetInt((dtTo - dtFrom).TotalMinutes);
                if (minutes <= 0 && (fromTime != "00:00" && toTime != "00:00"))
                    return "-2";
            }
            else if (Request["Minutes"] + "" != "")
                minutes = Convert.ToInt32(Request["Minutes"] + "");

            string Sat = Request["Sat"] + "";
            string Sun = Request["Sun"] + "";
            string Mon = Request["Mon"] + "";
            string Tue = Request["Tue"] + "";
            string Wed = Request["Wed"] + "";
            string Thu = Request["Thu"] + "";
            string Fri = Request["Fri"] + "";




            string chk = "0";
            Hashtable ht = new Hashtable();
            if (Request["GroupID"] + "" != "")
                ht.Add("action", "saveGroup");
            else
                ht.Add("action", "save");

            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("ID", id);
            ht.Add("permissionTypeID", Request["permTypeID"] + "");
            ht.Add("employeeID", Request["empID"] + "");
            ht.Add("groupID", Request["GroupID"] + "");
            ht.Add("remarks", Request["remarks"] + "");
            ht.Add("AutoApprove", (Request["AutoApprove"] + "" == "true" ? 1 : 0));
            ht.Add("fromDate", fromDate);
            ht.Add("toDate", toDate);
            ht.Add("fromTime", Request["fromTime"] + "");
            ht.Add("toTime", Request["toTime"] + "");
            ht.Add("minutes", minutes + "");
            ht.Add("Saturday", Sat + "");
            ht.Add("Sunday", Sun + "");
            ht.Add("Monday", Mon + "");
            ht.Add("Tuesday", Tue + "");
            ht.Add("Wednesday", Wed + "");
            ht.Add("Thursday", Thu + "");
            ht.Add("Friday", Fri + "");
            ht.Add("CategoryId", Request["CatId"] + "");


            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = "0";
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);

                if (dv != null)
                {
                    result = dv[0][0] + "";
                    chk = dv[0][1] + "";

                }

                if (Numerics.GetDecimal(result) > 0)
                {
                    if (Request["AllowAttachement"] + "" == "1")
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

                        string dirPath = "";
                        string virtualPath = "/Uploads/employeePermissions/attachement/";
                        if (!System.IO.Directory.Exists(virtualPath))
                        {
                            System.IO.Directory.CreateDirectory(Server.MapPath(virtualPath));
                        }
                        string OriginalList = encryptedLeaveId + ".pdf";
                        dirPath = Server.MapPath(virtualPath + OriginalList);
                        file.SaveAs(dirPath);
                        IsAttachmentUploaded(result);
                    }

                    chk = "Success";


                    // chk = "Success";
                }
                //else
                //{
                //    chk = result;
                //}
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region UploadAttachment
        public string UploadAttachment()
        {
            string result = "";
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                if (!CheckAttachement(Request))
                {
                    return "Error: File failed to upload";
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

                string PermissionID = Request["PermissionID"] + "";

                string encryptedLeaveId = Encryption.Encrypt(PermissionID);

                string dirPath = "";
                string virtualPath = "/Uploads/employeePermissions/attachement/";
                if (!System.IO.Directory.Exists(virtualPath))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(virtualPath));
                }
                string OriginalList = encryptedLeaveId + ".pdf";
                dirPath = Server.MapPath(virtualPath + OriginalList);
                file.SaveAs(dirPath);

                if (IsAttachmentUploaded(PermissionID))
                    result = "Success";
                else
                    result = "Error: File failed to upload";
            }
            catch (Exception ex)
            {
                result = "Error: File failed to upload";
            }
            return result;
        }
        #endregion


        #region GetPermissionBalance

        public string GetPermissionBalance()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            string label = "";
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                var appsettings = new DBAppSetting().GetPermissionBalanceSettings(Session["ID"] + "", Connection.GetUserConnectionStrinng());
                if (appsettings == "YES")
                {

                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));


                    string fromDate = (Request["fromDate"] + "").Trim();
                    string toDate = (Request["toDate"] + "").Trim();
                    string sessionID = Session["ID"] + "";
                    string permissionTypeID = (Request["permTypeID"] + "").Trim();
                    string employeeID = (Request["employeeID"] + "").Trim();
                    Hashtable ht;
                    ht = new Hashtable();
                    ht.Add("sessionID", sessionID);
                    ht.Add("employeeID", employeeID);
                    ht.Add("permissionTypeID", permissionTypeID);
                    ht.Add("fromDate", fromDate);
                    ht.Add("toDate", toDate);

                    DataView objDataView = objDAL.Connection.ExecuteProcedure("SP_CheckPermissionBalance", ht);
                    if (objDataView != null)
                    {
                        foreach (DataRowView obj in objDataView)
                        {
                            var messageEnglish = obj["Message_Eng"] + "";
                            var messageArabic = obj["Message_Arb"] + "";
                            if (cookie.Values["language"] == "ar")
                                label = "<span id='spanCommentsMsg'>" + messageArabic + "</span>";
                            else
                                label = "<span id='spanCommentsMsg'>" + messageEnglish + "</span>";
                        }

                    }
                }

            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return label;
        }

        #endregion


        private bool IsAttachmentUploaded(string PermissionID)
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            bool Res = false;
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Action", "UpdateFileUpload");
                ht.Add("SessionID", Session["ID"] + "");
                ht.Add("ID", PermissionID);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);
                if (Convert.ToInt32(dv[0][0] + "") > 0)
                    Res = true;
            }
            catch (Exception ex)
            {
                Res = false;
            }
            return Res;
        }

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

                    string AllowedPatchedFile = ".pdf";

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