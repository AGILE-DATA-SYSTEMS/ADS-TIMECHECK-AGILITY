using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
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
    public partial class TAEventPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        public string allowAttachment = "0";
        public string EMPath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/TAEventPage.aspx"));
            allowAttachment = ConfigurationManager.AppSettings["AllowEmployeeMovementAttachments"];
            EMPath= ConfigurationManager.AppSettings["EmployeeMovementAttachmentPath"];

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
            else if (Request["key"] + "" == "saveEmployeeManualTrans")
            {
                data = SaveManualTransaction();
            }
            else if (Request["key"] + "" == "save")
            {
                data = Save();
            }
            else if (Request["key"] + "" == "saveWebPunch")
            {
                data = SaveWebPunch();
            }
            else if (Request["key"] + "" == "saveManualPunch")
            {
                data = SaveManualPunch();
            }
            else if (Request["key"] + "" == "ApproveRejectMissingPunch")
            {
                data = ApproveRejectMissingPunch();
            }
            else if (Request["key"] + "" == "ApproveRejectManualPunch")
            {
                data = ApproveRejectManualPunch();
            }
            else if (Request["key"] + "" == "getAll")
            {
                data = GetAll();
            }
            else if (Request["key"] + "" == "getManualMovementByID")
            {
                data = GetManualMovementByID();
            }
            else if (Request["key"] + "" == "getEmployeeManualTrans")
            {
                data = GetAllManualMovements();
            }
            else if (Request["key"] + "" == "GetAllPendingManualMovements")
            {
                data = GetAllPendingManualMovements();
            }
            else if (Request["key"] + "" == "deleteManualMovementByID")
            {
                data = DeleteManualTransactionByID();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByID();
            }
            else if (Request["key"] + "" == "getManualPunchByID")
            {
                data = GetManualPunchByID();
            }
            else if (Request["key"] + "" == "GetAllManualPunch")
            {
                data = GetAllManualPunch();
            }
            else if (Request["key"] + "" == "GetAllMissingPunch")
            {
                data = GetAllMissingPunch();
            }
            else if (Request["key"] + "" == "getEmployeeTempRecord")
            {
                data = GetEmployeeTempTransactionRecord();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if (Request["key"] + "" == "deleteManualMissingPunchByID")
            {
                data = DeleteManualMissingPunchByID();
            }
            else if (Request["key"] + "" == "getLabel")
            {
                if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "undefined")
                    data = GetLabelByEmployeeID();
                else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "undefined")
                    data = GetLabelByGroupID();
                else
                    if ((Request["orgID"] + "").Trim() != "" && (Request["orgID"] + "").Trim() != "undefined")
                    data = GetLabelByOrganizationID();
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
            TAEvent obj = new TAEvent();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpEventTransactionsOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["transaction_id"]);
                    obj.EmployeeID = Numerics.GetDecimal(dv[0]["employee_id"]);
                    obj.ReasonID = Numerics.GetDecimal(dv[0]["reason_id"]);
                    obj.ReaderID = Numerics.GetDecimal(dv[0]["reader_id"]);
                    obj.UserEntryFlag = Numerics.GetInt(dv[0]["user_entry_flag"] + "");
                    obj.Remarks = dv[0]["remarks"] + "";
                    if (dv[0]["transaction_time"] + "" != "")
                    {
                        obj.TransactionDateTime = Numerics.GetDateTime(dv[0]["transaction_time"]);
                        obj.TransactionDateTimeStr = obj.TransactionDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                        obj.TransactionDateStr = obj.TransactionDateTime.ToString("yyyy-MM-dd");
                        obj.TransactionTimeStr = obj.TransactionDateTime.ToString("HH:mm:ss");
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


        #region GetManualPunchByID
        /// <summary>
        /// GetManualPunchByID function
        ///  
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetManualPunchByID()
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
            TAEvent obj = new TAEvent();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getManualPunchByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpEventTransactionsOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["transaction_id"]);
                    obj.EmployeeID = Numerics.GetDecimal(dv[0]["employee_id"]);
                    obj.ReasonID = Numerics.GetDecimal(dv[0]["reason_id"]);
                    obj.ReaderID = Numerics.GetDecimal(dv[0]["reader_id"]);
                    obj.Status = (dv[0]["status"] + "").Trim();
                    obj.Remarks = dv[0]["remarks"] + "";
                    if (dv[0]["transaction_time"] + "" != "")
                    {
                        obj.TransactionDateTime = Numerics.GetDateTime(dv[0]["transaction_time"]);
                        obj.TransactionDateTimeStr = obj.TransactionDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                        obj.TransactionDateStr = obj.TransactionDateTime.ToString("yyyy-MM-dd");
                        obj.TransactionTimeStr = obj.TransactionDateTime.ToString("HH:mm");
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
        //*********End Of GetManualPunchByID Function*********//
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmpEventTransactionsOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetByID
        /// <summary>
        /// GetManualMovementByID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetManualMovementByID()
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ManualTransactionsOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["transaction_id"]);
                    obj.EmployeeID = Numerics.GetDecimal(dv[0]["employee_id"]);
                    obj.ApproveRejectFlag = Numerics.GetInt(dv[0]["approve_reject_flag"] + "");
                    obj.Remarks = dv[0]["remarks"] + "";
                    obj.FromTime = (dv[0]["from_time"] + "").Trim();
                    obj.ToTime = (dv[0]["to_time"] + "").Trim();

                    if (dv[0]["from_date"] + "" != "")
                    {
                        obj.FromDate = Numerics.GetDateTime(dv[0]["from_date"]);
                        obj.FromDateTimeStr = obj.FromDate.ToString("yyyy-MM-dd");
                    }
                    if (dv[0]["to_date"] + "" != "")
                    {
                        obj.ToDate = Numerics.GetDateTime(dv[0]["to_date"]);
                        obj.ToDateTimeStr = obj.ToDate.ToString("yyyy-MM-dd");
                    }
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["updated_date"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["updated_id"]);
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
        //*********End Of GetManualMovementByID Function*********//
        #endregion


        #region DeleteManualTransactionByID
        /// <summary>
        /// DeleteByID function
        /// Delete user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteManualTransactionByID()
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ManualTransactionsOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region DeleteManualMissingPunchByID
        /// <summary>
        /// DeleteManualMissingPunchByID function
        ///  
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteManualMissingPunchByID()
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
                ht.Add("action", "deleteManualMissingPunchByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmpEventTransactionsOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of DeleteManualMissingPunchByID Function*********//
        #endregion


        #region GetAllByOrganization
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllByOrganization()
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

                string[] cols = { "h.transaction_id", "h.description" + languagePostfix, "org.description" + languagePostfix, "h.from_date", "h.to_date", "h.last_updated_date", "h.transaction_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecordsByOrganization");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpEventTransactionsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCountByOrganization");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmpEventTransactionsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["transaction_id"]) + "' />");
                    tempList.Add(obj["code"] + "");
                    tempList.Add((obj["description" + languagePostfix] + "").Length > 100 ? (obj["description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["description" + languagePostfix] + ""));
                    tempList.Add((obj["orgDes" + languagePostfix] + "").Length > 100 ? (obj["orgDes" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["orgDes" + languagePostfix] + ""));

                    if (obj["from_date"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["from_date"]).ToString("yyyy-MM-dd"));
                    }
                    else
                    {
                        tempList.Add("");
                    }
                    if (obj["to_date"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["to_date"]).ToString("yyyy-MM-dd"));
                    }
                    else
                    {
                        tempList.Add("");
                    }
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (Numerics.GetBool(Session["CanUpdate"]) == true || true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["transaction_id"]) + ");' /> &nbsp; ";
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["transaction_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.GetAll()", 0, ex);
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
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "empTrans.transaction_id", "emp.employee_code", "emp.Name" + languagePostfix, "rsn.description" + languagePostfix, "rdr.reader_name", "empTrans.transaction_time", "empTrans.user_entry_flag" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];
                if (Request["iSortCol_1"] + "" != "")
                    orderByClause += " , " + cols[Numerics.GetInt(Request["iSortCol_1"])] + " " + Request["sSortDir_1"];
                if (Request["iSortCol_2"] + "" != "")
                    orderByClause += " , " + cols[Numerics.GetInt(Request["iSortCol_2"])] + " " + Request["sSortDir_2"];
                if (Request["iSortCol_3"] + "" != "")
                    orderByClause += " , " + cols[Numerics.GetInt(Request["iSortCol_3"])] + " " + Request["sSortDir_3"];
                if (Request["iSortCol_4"] + "" != "")
                    orderByClause += " , " + cols[Numerics.GetInt(Request["iSortCol_4"])] + " " + Request["sSortDir_4"];
                if (Request["iSortCol_5"] + "" != "")
                    orderByClause += " , " + cols[Numerics.GetInt(Request["iSortCol_5"])] + " " + Request["sSortDir_5"];

                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();

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
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("empID", Request["empID"] + "");
                ht.Add("mgrID", Request["mgrID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                ht.Add("buildingId", Request["buildingID"] + "");
                ht.Add("zoneId", Request["zoneID"] + "");
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpEventTransactionsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("empID", Request["empID"] + "");
                ht.Add("mgrID", Request["mgrID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("buildingId", Request["buildingID"] + "");
                ht.Add("zoneId", Request["zoneID"] + "");
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmpEventTransactionsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["transaction_id"]) + "' />");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["empName" + languagePostfix] + "").Length > 100 ? (obj["empName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["empName" + languagePostfix] + ""));
                    tempList.Add((obj["reasonDesc" + languagePostfix] + "").Length > 100 ? (obj["reasonDesc" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["reasonDesc" + languagePostfix] + ""));
                    tempList.Add((obj["readerName" + languagePostfix] + "").Length > 100 ? (obj["readerName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["readerName" + languagePostfix] + ""));

                    if (obj["transaction_time"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["transaction_time"]).ToString(AppSetting.dateTimeFormat24));
                    }
                    else
                    {
                        tempList.Add("");
                    }

                    if (Numerics.GetBool(obj["user_entry_flag"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    string tempAction = "";
                    tempAction = "";
                    //if (Numerics.GetBool(Session["CanUpdate"]) == true || true)
                    //{
                    //    tempAction = "<a style='text-decoration: none;' href='" + path + "Details/SaveTAEvent.aspx?hdy=" +
                    //                    Encryption.Encrypt(obj["transaction_id"] + "") + "'>" +
                    //                    "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    //}
                    //if (Numerics.GetBool(Session["CanUpdate"]) == true || true)
                    //{
                    //    tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["transaction_id"]) + ")' /> &nbsp; ";
                    //}
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["transaction_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllManualMovements
        /// <summary>
        /// Get All Manual Movements function
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllManualMovements()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            string fromDate = (Request["fromDate"] + "").Trim();
            string toDate = (Request["toDate"] + "").Trim();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "mv.transaction_id", "emp.employee_code", "emp.name" + languagePostfix, "mv.created_date", "mv.from_date", "mv.to_date", "mv.from_time", "mv.to_time", "mv.minutes", "mv.approve_reject_flag", "emp_u.name_eng", "mv.updated_date" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ManualTransactionsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ManualTransactionsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;


                List<string> tempList = new List<string>();
                if (objDataView.Table.Rows.Count == 0)
                {
                    tempList = new List<string>();
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    json.aaData.Add(tempList);
                }


                foreach (DataRowView obj in objDataView)
                {
                    tempList = new List<string>();
                    //if (Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Session["ID"] + "" == obj["created_id"] + "")
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["transaction_id"]) + "' />");
                    //else
                    //    tempList.Add("&nbsp;");
                    tempList.Add(obj["empCode"] + "");
                    tempList.Add((obj["empName" + languagePostfix] + "").Length > 100 ? (obj["empName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["empName" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["created_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["from_time"] + "");
                    tempList.Add(obj["to_time"] + "");
                    tempList.Add(Numerics.FormatMinsToHHmm((obj["minutes"] + "").Trim()));
                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    tempList.Add(obj["actionBy"] + "");
                    tempList.Add(Numerics.GetDateTime(obj["updated_date"]).ToString(AppSetting.dateTimeFormat24));


                    string tempAction = "";
                    tempAction = "";
                    if ( //Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Session["ID"] + "" == obj["created_id"] + "" && 
                        (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_EMP_MANUAL_MOVEMENT) == true || Numerics.GetBool(Session["CanUpdate"]) == true))
                    {
                        tempAction = "<a style='text-decoration: none;' href='" + path + "Events/Save-Manual-Movement/" +
                                        Encryption.Encrypt(obj["transaction_id"] + "") + "'>" +
                                        "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["country_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
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
        //*********End Of GetAllManualMovements Function*********//
        #endregion


        #region GetAllPendingManualMovements
        /// <summary>
        /// Get All Pending Manual Movements function
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllPendingManualMovements()
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

                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();

                string[] cols = { "mv.transaction_id", "emp.employee_code", "emp.name" + languagePostfix, "mv.created_date", "mv.from_date", "mv.to_date", "mv.from_time", "mv.to_time", "mv.minutes", "mv.approve_reject_flag", "mv.created_date", "mv.transaction_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getPendingRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ManualTransactionsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getPendingCount");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ManualTransactionsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;


                List<string> tempList = new List<string>();
                if (objDataView.Table.Rows.Count == 0)
                {
                    tempList = new List<string>();
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    json.aaData.Add(tempList);
                }


                foreach (DataRowView obj in objDataView)
                {
                    tempList = new List<string>();
                    //if (Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Session["ID"] + "" == obj["created_id"] + "")
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["transaction_id"]) + "' />");
                    //else
                    //    tempList.Add("&nbsp;");
                    tempList.Add(obj["empCode"] + "");
                    tempList.Add((obj["empName" + languagePostfix] + "").Length > 100 ? (obj["empName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["empName" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["created_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["from_time"] + "");
                    tempList.Add(obj["to_time"] + "");
                    tempList.Add(Numerics.FormatMinsToHHmm((obj["minutes"] + "").Trim()));
                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    string tempAction = "";
                    tempAction = "";
                    if ( //Numerics.GetInt(obj["approve_reject_flag"] + "") != 1 && Session["ID"] + "" == obj["created_id"] + "" && 
                        (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_EMP_MANUAL_MOVEMENT) == true || Numerics.GetBool(Session["CanUpdate"]) == true))
                    {
                        tempAction = "<a style='text-decoration: none;' href='" + path + "Events/Save-Manual-Movement/" +
                                        Encryption.Encrypt(obj["transaction_id"] + "") + "'>" +
                                        "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["country_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
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
        //*********End Of GetAllManualMovements Function*********//
        #endregion


        #region GetAllManualPunch
        /// <summary>
        /// Get All Manual Movements function
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllManualPunch()
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

                string[] cols = { "empTrans.transaction_id", "emp.employee_code", "emp.name" + languagePostfix, "empTrans.transaction_date", "empTrans.transaction_time", "rsn.description" + languagePostfix, "empTrans.remarks", "empTrans.status", "emp_up.name_eng", "empTrans.updated_date" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getManualRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("empID", Request["empID"] + "");
                ht.Add("status", Request["status"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpEventTransactionsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getManualCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("empID", Request["empID"] + "");
                ht.Add("status", Request["status"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmpEventTransactionsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                string preUrl = Request.UrlReferrer.AbsoluteUri;

                List<string> tempList = new List<string>();
                if (objDataView.Table.Rows.Count == 0)
                {
                    tempList = new List<string>();
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    json.aaData.Add(tempList);
                }

                foreach (DataRowView obj in objDataView)
                {
                    tempList = new List<string>();
                    if ((obj["status"] + "").ToUpper() == "APPROVED" && new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.DELETE_MANUAL_TRANSACTION) == false)
                    {
                        tempList.Add(" &nbsp;");

                    }
                    else
                    {
                        if (preUrl.Contains("/Events/Approve-Missing-Transaction")
                            || (preUrl.Contains("/Events/View-Manual-Transaction")))
                        {
                            tempList.Add("<input type='checkbox' style='' class='checkboxes' value='" + Numerics.GetDecimal(obj["transaction_id"]) + "' />");
                        }
                        else
                        {
                            tempList.Add(" &nbsp;");
                        }
                    }
                    tempList.Add(obj["employee_Code"] + "");
                    tempList.Add((obj["empName" + languagePostfix] + "").Length > 100 ? (obj["empName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["empName" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["transaction_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["transaction_time"] + "");
                    tempList.Add(obj["reasonDesc" + languagePostfix] + "");
                    tempList.Add(obj["remarks"] + "");
                    tempList.Add(obj["status"] + "");
                    tempList.Add(obj["actionBy"] + "");
                    tempList.Add(Numerics.GetDateTime(obj["updated_date"]).ToString(AppSetting.dateTimeFormat24));
                    string tempAction = "";
                    tempAction = "";
                    if (obj["transaction_id"] + "" != "")
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
                    tempList.Add(tempAction);
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
        //*********End Of GetAllManualMovements Function*********//
        #endregion


        #region GetAllMissingPunch
        /// <summary>
        /// Get All Missing Movements function
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllMissingPunch()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {

                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "employee_code", "Employee_Name_English", "transaction_date", "Punch_IN", "Punch_OUT", "Trans_IN", "Trans_OUT", "Status_IN", "Status_OUT" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getMissingRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("empID", Request["empID"] + "");
                //ht.Add("status", Request["status"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpEventTransactionsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getMissingCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("empID", Request["empID"] + "");
                //ht.Add("status", Request["status"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmpEventTransactionsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                string tempAction = "";
                List<string> tempList = new List<string>();
                if (objDataView.Table.Rows.Count == 0)
                {
                    tempList = new List<string>();
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    json.aaData.Add(tempList);
                }

                foreach (DataRowView obj in objDataView)
                {
                    tempList = new List<string>();

                    tempList.Add(obj["employee_Code"] + "");
                    tempList.Add((obj["Name" + languagePostfix] + "").Length > 100 ? (obj["Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Name" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["transaction_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["Punch_IN"] + "");
                    tempList.Add(obj["Punch_OUT"] + "");
                    //tempList.Add(Numerics.GetDateTime(obj["Punch_IN"] + "").ToString(AppSetting.shortTimeFormat));
                    //tempList.Add(Numerics.GetDateTime(obj["Punch_OUT"] + "").ToString(AppSetting.shortTimeFormat));
                    if (obj["Trans_IN"] + "" != "" && obj["Punch_IN"] + "" == "")
                    {
                        tempAction = "<a onclick='return Apply(\"" + obj["trans_IN_id"] + "\"," + obj["employee_id"] + ",\"IN\"," + "\"" + Numerics.GetDateTime(obj["transaction_date"] + "").ToString("yyyy-MM-dd") + "\" )'>" + Numerics.GetDateTime(obj["Trans_IN"] + "").ToString(AppSetting.shortTimeFormat) + "</a>";
                        //tempList.Add(Numerics.GetDateTime(obj["Trans_IN"] + "").ToString(AppSetting.shortTimeFormat));
                    }
                    else
                        if (obj["Punch_IN"] + "" == "")
                    {
                        tempAction = "<a onclick='return Apply(\"" + obj["trans_IN_id"] + "\"," + obj["employee_id"] + ",\"IN\"," + "\"" + Numerics.GetDateTime(obj["transaction_date"] + "").ToString("yyyy-MM-dd") + "\" )'>Apply</a>";
                    }
                    tempList.Add(tempAction);
                    tempAction = " &nbsp;";

                    tempList.Add(obj["Status_IN"] + "");

                    if (obj["Trans_OUT"] + "" != "" && obj["Punch_OUT"] + "" == "")
                    {
                        tempAction = "<a onclick='return Apply(\"" + obj["trans_OUT_id"] + "\"," + obj["employee_id"] + ",\"OUT\"," + "\"" + Numerics.GetDateTime(obj["transaction_date"] + "").ToString("yyyy-MM-dd") + "\" )'>" + Numerics.GetDateTime(obj["Trans_OUT"] + "").ToString(AppSetting.shortTimeFormat) + "</a>";
                        //tempList.Add(Numerics.GetDateTime(obj["Trans_OUT"] + "").ToString(AppSetting.shortTimeFormat));
                    }
                    else
                        if (obj["Punch_OUT"] + "" == "")
                    {
                        tempAction = "<a onclick='return Apply(\"" + obj["trans_OUT_id"] + "\"," + obj["employee_id"] + ",\"OUT\"," + "\"" + Numerics.GetDateTime(obj["transaction_date"] + "").ToString("yyyy-MM-dd") + "\" )'>Apply</a>";
                    }

                    tempList.Add(tempAction);
                    tempAction = " &nbsp;";

                    tempList.Add(obj["Status_OUT"] + "");

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAllMissingPunch Function*********//
        #endregion


        #region SaveWebPunch
        /// <summary>
        /// Save function
        /// Web Punch attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveWebPunch()
        {
            string computerName = "";
            try
            {
                System.Net.IPAddress[] strClientIPAddress = System.Net.Dns.GetHostAddresses(Environment.MachineName);
                string strClientMachineName = Environment.MachineName.ToString().Trim();
                string strClientUserName = Environment.UserName.ToString().Trim();
                string strClientDomainName = Environment.UserDomainName.ToString().Trim();
                string strClientOSVersion = Environment.OSVersion.ToString().Trim();
                computerName = System.Web.HttpContext.Current.Request.UserHostName;

            }
            catch (Exception ex)
            {
                computerName = ex.ToString();


            }
            string chk = "0";
            DateTime dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone);

            if (Numerics.GetDateTime(Session["LastPunchTime"] + "").AddMinutes(Numerics.GetInt(Session["WebPunchDelay"] + "")) > dt)
            {
                return "-2";
            }

            if (Session["WebPunch"] + "" != "1")
                return "-1";

            Hashtable ht = new Hashtable();
            ht.Add("action", "employeeWebPunch");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("empID", Session["ID"] + "");
            ht.Add("reasonID", (Request["rID"] + "").Trim());
            ht.Add("location", (Request["rlocation"] + "").Trim());
            ht.Add("transactionTime", dt.ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("userEntryFlag", 0);
            ht.Add("remarks", computerName);
            ht.Add("createdOn", dt.ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", dt.ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");


            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_EmpEventTransactionsOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result;
                    if (Numerics.GetDecimal(result) > 0)
                    {
                        Session["LastPunchMode"] = Numerics.GetDecimal((Request["rMode"] + "").Trim());
                        Session["LastPunchTime"] = dt.ToString("yyyy-MM-dd HH:mm:ss");
                    }
                    if (result == "")
                        chk = "-1";
                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region SaveWebPunch
        /// <summary>
        /// SaveManualPunch
        /// Web Punch attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveManualPunch()
        {
            string chk = "0";
            DateTime dt = Convert.ToDateTime((Request["transDate"] + "").Trim());
            //string time = Convert.ToDateTime((Request["transTime"] + "").Trim()).ToLongTimeString();
            // string time = Convert.ToDateTime((Request["transTime"] + "").Trim()).ToString("hh:mm");
            string time = Request["transTime"] + "";

            string id = "0";
            try
            {
                id = Encryption.Decrypt(Request["id"] + "");
            }
            catch (Exception ex)
            {
                id = (Request["id"] + "").Trim();
                if (id == "undefined" || id == "-1")
                    id = "0";
            }


            Hashtable ht = new Hashtable();
            ht.Add("action", "employeeManualPunch");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("ID", id);
            ht.Add("empID", (Request["empID"] + "").Trim());
            ht.Add("reasonID", (Request["reasonTypeID"] + "").Trim());
            ht.Add("readerID", (Request["readerID"] + "").Trim());
            ht.Add("transactionDate", dt.ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("transactionTime", time);
            ht.Add("remarks", (Request["remarks"] + "").Trim());
            ht.Add("status", "Applied");

            ht.Add("createdOn", dt.ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_EmpEventTransactionsOps", ht);
                if (Numerics.GetDecimal(result) > 0)
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
                    string virtualPath = "/Uploads/MissingMovements/attachement/";
                    if (!System.IO.Directory.Exists(virtualPath))
                    {
                        System.IO.Directory.CreateDirectory(Server.MapPath(virtualPath));
                    }
                    string OriginalList = encryptedLeaveId + ".jpg";
                    dirPath = Server.MapPath(virtualPath + OriginalList);
                    file.SaveAs(dirPath);
                    chk = "1";

                }
                else
                {
                    chk = Numerics.GetDecimal(result) + "";
                }
            }
            catch (Exception ex)
            {
                chk = "-2";
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.SaveManualPunch()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of SaveManualPunch Function*********//
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


                    if (extension == ".jpg" || extension == ".jpeg")
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


        #region Save
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string Save()
        {
            string attachment = Request["attchment"] + "";
            string chk = "0";
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
            string transactionDateTime = "";
            string transactionDate = ((Request["transactionDate"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["transactionDate"] + "";
            string transactionTime = (Request["transactionTime"] + "").Trim();
            if (transactionTime.Length == 5)
                transactionTime += ":00";

            if (!transactionDate.Contains('-') && transactionDate.Length > 7)
            {
                transactionDate = transactionDate.Insert(4, "-");
                transactionDate = transactionDate.Insert(7, "-");
                transactionDateTime = transactionDate + " " + transactionTime;
            }

            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", id);
            ht.Add("empID", (Request["empID"] + "").Trim());
            ht.Add("reasonID", (Request["reasonID"] + "").Trim());
            ht.Add("readerID", (Request["readerID"] + "").Trim());
            ht.Add("transactionTime", transactionDateTime);
            ht.Add("userEntryFlag", 1);
            ht.Add("remarks", (Request["remarks"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_EmpEventTransactionsOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result;
                }
                else
                {
                    chk = "-1";
                }


                if (chk != "0" && chk != "-1")
                {
                    if (attachment.Length > 0)
                    {
                        string folderPath = Server.MapPath("~/Images/EmployeeMovement/");
                        string fileName = chk + ".jpg";
                        string imagePath = folderPath + fileName;

                        string base64StringData = attachment; // Your base 64 string data
                        string cleandata = base64StringData.Replace("data:image/png;base64,", "");
                        byte[] data = Convert.FromBase64String(cleandata);
                        MemoryStream ms = new MemoryStream(data);
                        System.Drawing.Image img = System.Drawing.Image.FromStream(ms);
                        img.Save(imagePath, System.Drawing.Imaging.ImageFormat.Jpeg);
                    }

                }

            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region GetLabelByEmployeeID
        /// <summary>
        /// GetLabelByEmployeeID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetLabelByEmployeeID()
        {
            string str = "&nbsp;";
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            EmployeeGroup obj = new EmployeeGroup();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["empID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string employee = (String)GetGlobalResourceObject("Resource", "employee");
                if (dv != null)
                {
                    obj.Code = dv[0]["employee_code"] + "";
                    obj.NameEn = dv[0]["name_eng"] + "";
                    obj.NameAr = dv[0]["name_arb"] + "";

                    if (cookie.Values["language"] == "ar")
                        str = employee + " \"" + obj.NameAr + "\"";
                    else
                        str = employee + " \"" + obj.NameEn + "\"";
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return str;
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetLabelByGroupID
        /// <summary>
        /// GetLabelByGroupID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetLabelByGroupID()
        {
            string str = "&nbsp;";
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            EmployeeGroup obj = new EmployeeGroup();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["groupID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpGroupOps", ht);

                string group = (String)GetGlobalResourceObject("Resource", "group");
                if (dv != null)
                {
                    obj.Code = dv[0]["group_code"] + "";
                    obj.NameEn = dv[0]["group_name_eng"] + "";
                    obj.NameAr = dv[0]["group_name_arb"] + "";

                    if (cookie.Values["language"] == "ar")
                        str = group + " \"" + obj.NameAr + "\"";
                    else
                        str = group + " \"" + obj.NameEn + "\"";
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return str;
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetLabelByOrganizationID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetLabelByOrganizationID()
        {
            string str = "&nbsp;";
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            ObjectClasses.Org obj = new ObjectClasses.Org();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["orgID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string organization = (String)GetGlobalResourceObject("Resource", "organization");
                if (dv != null)
                {
                    obj.Code = dv[0]["code"] + "";
                    obj.DescriptionEn = dv[0]["description_Eng"] + "";
                    obj.DescriptionAr = dv[0]["description_Arb"] + "";

                    if (cookie.Values["language"] == "ar")
                        str = organization + " \"" + obj.DescriptionAr + "\"";
                    else
                        str = organization + " \"" + obj.DescriptionEn + "\"";
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return str;
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetEmployeeTempTransactionRecord
        /// <summary>
        /// GetEmployeeTempTransactionRecord function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetEmployeeTempTransactionRecord()
        {
            StringBuilder sb = new StringBuilder();

            int count = Numerics.GetInt(Request["count"] + "");
            string ids = "";
            for (int k = 1; k <= count; k++)
            {
                ids += Request["chk" + k] + ",";
            }
            ids = ids.TrimEnd(',');
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
            string fromTime = (Request["fromTime"] + "").Trim();
            string toTime = (Request["toTime"] + "").Trim();

            if (fromTime.Trim() == "undefined")
                fromTime = "";
            if (toTime.Trim() == "undefined")
                toTime = "";
            //fromDate = fromDate + " " + fromTime;
            //toDate = toDate + " " + toTime;

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            ObjectClasses.Org obj = new ObjectClasses.Org();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));


                Hashtable ht = new Hashtable();
                ht.Add("action", "getByName");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("vname", "MANUAL_TRANSACTION_MAX_WORK_HOURS");
                string workHours = objDAL.Connection.GetValueProcedure("TAMSR2_AppSettingOps", ht);
                if (fromTime == "" && toTime == "")
                {
                    fromTime = "08:00";
                    toTime = (Numerics.GetInt(workHours) + 8) + ":00";
                }
                ht = new Hashtable();
                ht.Add("action", "getEmployeeIdNameListByIDs");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                foreach (DataRowView row in dv)
                {
                    sb.Append("<tr>");
                    sb.Append("<td class='sel' eid='" + Numerics.GetDecimal(row["employee_id"]) + "'><input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(row["employee_id"]) + "' /></td>");
                    sb.Append("<td>" + row["employee_code"] + "</td>");
                    sb.Append("<td>");
                    sb.Append((row["name" + languagePostfix] + "").Length > 100 ? (row["name" + languagePostfix] + "").Substring(0, 100) + "..." : (row["name" + languagePostfix] + ""));
                    sb.Append("</td>");
                    sb.Append("<td class='sel' fd='" + fromDate + "'>" + fromDate + "</td>");
                    sb.Append("<td class='sel' td='" + toDate + "'>" + toDate + "</td>");
                    sb.Append("<td class='sel' ft='" + fromTime + "'>" + fromTime + "</td>");
                    sb.Append("<td class='sel' tt='" + toTime + "'>" + toTime + "</td>");
                    sb.Append("</tr>");
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
        //*********End Of GetEmployeeTempTransactionRecord Function*********//
        #endregion


        #region Save
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveManualTransaction()
        {
            string chk = "0";
            string id = "0";
            DataView dv = new DataView();
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
            string transactionDateTime = "";
            string fromDate = ((Request["fromDate"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["fromDate"] + "";
            string toDate = ((Request["toDate"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["toDate"] + "";
            string fromTime = (Request["fromTime"] + "").Trim();
            string toTime = (Request["toTime"] + "").Trim();
            string showDiffDate = Request["individualValueProcess"] + "";
            if (showDiffDate == "")
                showDiffDate = "0";
            if (fromTime.Length == 5)
                fromTime += ":00";
            if (toTime.Length == 5)
                toTime += ":00";

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
            if (fromTime.Trim() == "undefined")
                fromTime = "";
            if (toTime.Trim() == "undefined")
                toTime = "";
            DateTime dtFrom = Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd") + " " + fromTime);
            DateTime dtTo = Convert.ToDateTime(DateTime.UtcNow.ToString("yyyy-MM-dd") + " " + toTime);

            int minutes = Numerics.GetInt((dtTo - dtFrom).TotalMinutes);
            //if (minutes <= 0)
            //    return "-2";

            int count = Numerics.GetInt(Request["count"] + "");
            string eids = "", fd = "", td = "", ft = "", tt = "";
            for (int k = 1; k <= count; k++)
            {
                eids += Request["eid" + k] + ",";
                fd += Request["fd" + k] + ",";
                td += Request["td" + k] + ",";
                ft += Request["ft" + k] + ",";
                tt += Request["tt" + k] + ",";
            }
            eids = eids.TrimEnd(',');
            fd = fd.TrimEnd(',');
            td = td.TrimEnd(',');
            ft = ft.TrimEnd(',');
            tt = tt.TrimEnd(',');

            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", id);
            ht.Add("employeeID", eids);
            ht.Add("fromDate", fromDate);
            ht.Add("toDate", toDate);
            ht.Add("fromTime", fromTime);
            ht.Add("toTime", toTime);
            ht.Add("minutes", minutes + "");
            ht.Add("remarks", (Request["remarks"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");
            ht.Add("fromDates", fd);
            ht.Add("toDates", td);
            ht.Add("fromTimes", ft);
            ht.Add("toTimes", tt);
            ht.Add("saveDiffDates", showDiffDate);

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ManualTransactionsOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region ApproveRejectMissingPunch

        public string ApproveRejectMissingPunch()
        {
            string chk = "0";

            int count = Numerics.GetInt(Request["count"] + "");
            string status = Request["status"] + "";
            string ids = "";
            for (int k = 1; k <= count; k++)
            {
                ids += Request["chk" + k] + ",";
            }
            ids = ids.TrimEnd(',');

            Hashtable ht = new Hashtable();
            ht.Add("action", "ApproveRejectManualPunch");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", ids);
            ht.Add("status", status);
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");
            ht.Add("lineComments", Request["lineComments"] + "");
            ht.Add("lang", cookie.Values["language"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_EmpEventTransactionsOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = "1";

                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }


        #endregion


        #region ApproveRejectManualPunch

        public string ApproveRejectManualPunch()
        {
            string chk = "0";

            int count = Numerics.GetInt(Request["count"] + "");
            string status = Request["status"] + "";
            string ids = "";
            for (int k = 1; k <= count; k++)
            {
                ids += Request["chk" + k] + ",";
            }
            ids = ids.TrimEnd(',');

            Hashtable ht = new Hashtable();
            ht.Add("action", "ApproveRejectManualPunch");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("approverID", Session["ID"] + "");
            ht.Add("id", ids);
            ht.Add("status", status);
            ht.Add("updatedBy", Session["ID"] + "");
            ht.Add("lineComments", Request["lineComments"] + "");
            ht.Add("lang", cookie.Values["language"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("approveDate", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ManualTransactionsOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = "1";

                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAEventPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }


        #endregion

    }
}