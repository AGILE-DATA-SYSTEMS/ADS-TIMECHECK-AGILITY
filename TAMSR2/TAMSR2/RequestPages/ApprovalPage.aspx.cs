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
    public partial class ApprovalPage : System.Web.UI.Page
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
            else
                return "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/ApprovalPage.aspx"));


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
            else if (Request["key"] + "" == "getAllPending")
            {
                data = GetAllPending();
            }
            else if (Request["key"] + "" == "approvePermissions")
            {
                data = Approve();
            }
            else if (Request["key"] + "" == "rejectPermissions")
            {
                data = Reject();
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_SinglePermissionOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SinglePermissionPage.aspx.DeleteByID()", 0, ex);
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
            DataView dv = new DataView();
            string result = "";
            string lang = "en";
            try
            {
                if (languagePostfix != "_eng")
                    lang = "ar";
                int count = Numerics.GetInt(Request["count"] + "");
                string ids = "";
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                for (int k = 1; k <= count; k++)
                {
                    ids = ids.TrimEnd(',');
                    Hashtable ht = new Hashtable();
                    ht.Add("action", "Approve");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("ID", Request["chk" + k] + "");
                    ht.Add("Type", Request["Type" + k] + "");
                    ht.Add("lang", lang + "");
                    dv = objDAL.Connection.ExecuteProcedure("TAMSR2_PendingApprovalOps", ht);

                    if (dv != null)
                    {
                        if (Convert.ToInt32(dv[0][0]) > 0)
                            result = "1";
                        else
                            result = dv[0][0] + "";

                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/PendingApprovalPage.aspx.DeleteByID()", 0, ex);
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
            string lang = "en";
            try
            {
                if (languagePostfix != "_eng")
                    lang = "ar";
                int count = Numerics.GetInt(Request["count"] + "");
                string ids = "";
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                for (int k = 1; k <= count; k++)
                {
                    ids += Request["chk" + k] + ",";

                    ids = ids.TrimEnd(',');
                    Hashtable ht = new Hashtable();
                    ht.Add("action", "Reject");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("ID", Request["chk" + k] + "");
                    ht.Add("Type", Request["Type" + k] + "");
                    ht.Add("lang", lang + "");

                    dv = objDAL.Connection.ExecuteProcedure("TAMSR2_PendingApprovalOps", ht);
                    if (dv != null)
                    {
                        if (Convert.ToInt32(dv[0][0]) > 0)
                            result = "1";
                        else
                            result = dv[0][0] + "";
                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/PendingApprovalPage.aspx.DeleteByID()", 0, ex);
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_SinglePermissionOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_SinglePermissionOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();

                    if ((Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Session["ID"] + "" == obj["created_id"] + "") || Numerics.GetBool(Session["CanDelete"]) == true)
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
                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));


                    tempList.Add(obj["actionBy"] + "");
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_time"]).ToString(AppSetting.dateTimeFormat24));


                    string tempAction = "";
                    tempAction = "";
                    if (Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Session["ID"] + "" == obj["created_id"] + "" && (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_SINGLE_PERMISSION) == true || Numerics.GetBool(Session["CanUpdate"]) == true))
                    {
                        tempAction = "<a style='text-decoration: none;' href='" + path + "Leaves/Save-Short-Permission/" +
                                        Encryption.Encrypt(obj["single_permissions_id"] + "") + "'>" +
                                        "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        // tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["country_id"]) + ")' /> ";
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
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                //string[] cols = { "sngPerm.single_permissions_id", "emp.employee_code", "emp.name" + languagePostfix, "sngPerm.created_date", "permType.description" + languagePostfix, "sngPerm.from_date", "sngPerm.to_date", "sngPerm.from_time", "sngPerm.to_time", "sngPerm.minutes", "sngPerm.approve_reject_flag", "sngPerm.created_date", "sngPerm.single_permissions_id" };
                string[] cols = { "transaction_id", "employee_code", "name" + languagePostfix, "type", "description" + languagePostfix, "from_date", "to_date", "from_time", "to_time", "minutes", "approve_reject_flag", "created_date", "single_permissions_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();
                string type = (Request["type"] + "").Trim();
                string employeeID = (Request["empID"] + "").Trim(); ;
                string managerID = (Request["mgrID"] + "").Trim(); ;
                string OrganizationID = (Request["orgID"] + "").Trim(); ;



                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);

                if (OrganizationID != "" && OrganizationID != "undefined")
                    ht.Add("OrganizationId", OrganizationID);
                if (managerID != "" && managerID != "undefined")
                    ht.Add("ManagerId", managerID);
                if (employeeID != "" && employeeID != "undefined")
                    ht.Add("EmployeeId", employeeID);

                ht.Add("typeId", type);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_PendingApprovalOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);

                if (OrganizationID != "" && OrganizationID != "undefined")
                    ht.Add("OrganizationId", OrganizationID);
                if (managerID != "" && managerID != "undefined")
                    ht.Add("ManagerId", managerID);
                if (employeeID != "" && employeeID != "undefined")
                    ht.Add("EmployeeId", employeeID);

                ht.Add("typeId", type);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_PendingApprovalOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();

                    //if (obj["attachment_required"] + "" == "1" &&  obj["attachment_uploaded"] + ""== "0" && obj["Approval_Status"] + "" == "Pending HR")
                    //{
                    //}
                    //else
                    //{
                    if ((obj["employee_id"] + "").Trim() != Session["ID"] + ""
                            && (
                                Numerics.GetInt(obj["approve_reject_flag"] + "") != 1
                                    || DateTime.UtcNow.AddHours(4).Date < Numerics.GetDateTime(obj["from_date"] + "")
                            )
                        )
                    {
                        if (obj["IsMonthLocked"] + "" != "1")
                            tempList.Add("<input type='checkbox' RequestType='" + obj["type"] + "" + "' class='checkboxes' value='" + Numerics.GetDecimal(obj["transaction_id"]) + "' />");
                        else

                            tempList.Add("<input type='checkbox' disabled='disabled' RequestType='" + obj["type"] + "" + "' class='checkboxes' value='" + Numerics.GetDecimal(obj["transaction_id"]) + "' />");
                    }
                    else
                        tempList.Add("&nbsp;");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["Name" + languagePostfix] + "").Length > 100 ? (obj["Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Name" + languagePostfix] + ""));
                    //tempList.Add(Numerics.GetDateTime(obj["created_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["type"] + "");
                    tempList.Add((obj["Description" + languagePostfix] + "").Length > 100 ? (obj["Description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Description" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["from_time"] + "");
                    tempList.Add(obj["to_time"] + "");
                    tempList.Add(Numerics.FormatMinsToHHmm((obj["minutes"] + "").Trim()));
                    tempList.Add((obj["remarks"] + "").Trim());
                    tempList.Add((obj["Approval_Status"] + "").Trim());
                    // tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    string tempAction = "";
                    tempAction = "";
                    if (obj["transaction_id"] + "" != "")
                    {

                        if (obj["type"] + "" == "Missing Movements")
                        {
                            string virtualPath = "/Uploads/MissingMovements/attachement/";

                            string encryptedVirtualPath = virtualPath + Encryption.Encrypt(obj["transaction_id"] + "") + ".jpg";

                            if (System.IO.File.Exists(Server.MapPath(encryptedVirtualPath)))
                            {
                                tempList.Add("<a href=" + encryptedVirtualPath + " target='_blank' ><img src='" + path + "images/attachment.png' title='attachment' alt='attachment' /> &nbsp; </a>");
                            }
                            else
                            {
                                tempList.Add("");
                            }
                        }
                        else if (obj["type"] + "" == "Short Permission")
                        {
                            string virtualPath = "/Uploads/employeePermissions/attachement/";

                            string encryptedVirtualPath = virtualPath + Encryption.Encrypt(obj["transaction_id"] + "") + ".pdf";

                            if (System.IO.File.Exists(Server.MapPath(encryptedVirtualPath)))
                            {
                                tempList.Add("<a href=" + encryptedVirtualPath + " target='_blank' ><img src='" + path + "images/attachment.png' title='attachment' alt='attachment' /> &nbsp; </a>");
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
                    //}
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

            int minutes = Numerics.GetInt((dtTo - dtFrom).TotalMinutes);
            if (minutes <= 0 && (fromTime != "00:00" && toTime != "00:00"))
                return "-2";

            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("ID", id);
            ht.Add("permissionTypeID", Request["permTypeID"] + "");
            ht.Add("employeeID", Request["empID"] + "");
            ht.Add("remarks", Request["remarks"] + "");
            ht.Add("fromDate", fromDate);
            ht.Add("toDate", toDate);
            ht.Add("fromTime", Request["fromTime"] + "");
            ht.Add("toTime", Request["toTime"] + "");
            ht.Add("minutes", minutes + "");

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = "0";
                result = objDAL.Connection.GetValueProcedure("TAMSR2_SinglePermissionOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result;
                }
                else
                {
                    chk = result;
                }
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


    }
}