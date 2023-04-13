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
    public partial class ReaderOpsPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/ReaderOpsPage.aspx"));


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
            else if (Request["key"] + "" == "getAllByType")
            {
                data = GetAllByType();
            }
            else if (Request["key"] + "" == "getAllBuffer")
            {
                data = GetAllBuffer();
            } 
            else if (Request["key"] + "" == "getDownloadFileList")
            {
                data = GetDownloadFileList();
            }
            else if (Request["key"] + "" == "lock")
            {
                data = LockReaders();
            }
            else if (Request["key"] + "" == "readerEmployee")
            {
                data = ReaderEmployeeOperations();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByID();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if (Request["key"] + "" == "deleteBufferByID")
            {
                data = DeleteBufferByID();
            }
            else if (Request["key"] + "" == "retryBufferByID")
            {
                data = RetryBufferByID();
            }
            else if (Request["key"] + "" == "cancelBufferByID")
            {
                data = CancelBufferByID();
            }
            else if (Request["key"] + "" == "getIdNameListString")
            {
                data = GetIdNameListString();
            }
            else if (Request["key"] + "" == "bulkOperation")
            {
                data = BulkOperation();
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
            Reason obj = new Reason();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["reason_id"]);
                    obj.Code = dv[0]["code"] + "";
                    obj.DescriptionEn = dv[0]["description_Eng"] + "";
                    obj.DescriptionAr = dv[0]["description_Arb"] + "";
                    obj.ReasonMode = Numerics.GetInt(dv[0]["reason_mode"] + "");
                    obj.PromptMsg = dv[0]["prompt_message"] + "";
                    obj.Deleteable = Numerics.GetDecimal(dv[0]["deletable"] + "");
                    obj.NormalIn = Numerics.GetDecimal(dv[0]["normal_in"] + "");
                    obj.NormalOut = Numerics.GetDecimal(dv[0]["normal_out"] + "");
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

            string days = (String)GetGlobalResourceObject("Resource", "days");

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string reasonStr = (String)GetGlobalResourceObject("Resource", "reason");

                sb.Append("<option value=''>" + chooseStr + " " + reasonStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Reason obj = new Reason();
                    obj.ID = Numerics.GetDecimal(row["reader_id"] + "");
                    obj.Code = row["code"] + "";
                    obj.DescriptionEn = row["reader_name"] + "";
                    obj.DescriptionAr = row["reader_name"] + "";
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ReaderOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region DeleteBufferByID
        /// <summary>
        /// DeleteBufferByID function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteBufferByID()
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
                ht.Add("action", "deleteBufferByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ReaderBufferOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region RetryBufferByID
        /// <summary>
        /// RetryBufferByID function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string RetryBufferByID()
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
                ht.Add("action", "retryBufferByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ReaderBufferOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region CancelBufferByID
        /// <summary>
        /// CancelBufferByID function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string CancelBufferByID()
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
                ht.Add("action", "cancelBufferByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ReaderBufferOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.DeleteByID()", 0, ex);
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

                string[] cols = { "r.reason_id", "r.code", "r.description" + languagePostfix, "r.reason_mode", "r.prompt_message", "r.deletable", "r.normal_in", "r.normal_out", "org.description" + languagePostfix, "r.last_updated_date", "r.reason_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ReaderOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["reason_id"]) + "' />");
                    tempList.Add(obj["code"] + "");
                    tempList.Add((obj["description" + languagePostfix] + "").Length > 100 ? (obj["description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["description" + languagePostfix] + ""));
                    tempList.Add(obj["reason_mode"] + "");
                    tempList.Add(obj["prompt_message"] + "");
                    tempList.Add(obj["deletable"] + "");
                    tempList.Add(obj["normal_in"] + "");
                    tempList.Add(obj["normal_out"] + "");
                    tempList.Add((obj["orgDes" + languagePostfix] + "").Length > 100 ? (obj["orgDes" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["orgDes" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_READERS) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["reason_id"]) + ")' /> &nbsp; ";
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["reason_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region GetAllByType
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllByType()
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

                string[] cols = { "rdr.reader_id", "rdr.code", "rdr.reader_name", "dvcGroup.grpName" + languagePostfix, "lc.computer_name", "dvc.connection_name", "dvc.address", "rdr.status_flag", "rdr.polling_type", "rdr.enabled_flag", "rdr.deleted_flag", "rdr.web_punch", "rdr.reason_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecordsByType");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("readerTypeName", (Request["type"] + "").Trim());
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCountByType");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("readerTypeName", (Request["type"] + "").Trim());
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ReaderOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["reader_id"]) + "' />");
                    tempList.Add(obj["code"] + "");
                    tempList.Add((obj["reader_name"] + "").Length > 100 ? (obj["reader_name"] + "").Substring(0, 100) + "..." : (obj["reader_name"] + ""));
                    tempList.Add((obj["grpName" + languagePostfix] + "").Length > 100 ? (obj["grpName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["grpName" + languagePostfix] + ""));
                    tempList.Add((obj["computer_name"] + "").Length > 100 ? (obj["computer_name"] + "").Substring(0, 100) + "..." : (obj["computer_name"] + ""));
                    tempList.Add((obj["connection_name"] + "").Length > 100 ? (obj["connection_name"] + "").Substring(0, 100) + "..." : (obj["connection_name"] + ""));
                    tempList.Add(obj["address"] + "");

                    if (Numerics.GetDecimal(obj["status_flag"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    if (Numerics.GetDecimal(obj["polling_type"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    if (Numerics.GetDecimal(obj["enabled_flag"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    if (Numerics.GetDecimal(obj["deleted_flag"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    if (Numerics.GetDecimal(obj["web_punch"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    
                    //tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_READERS) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["reader_id"]) + ")' /> &nbsp; ";
                    }
                    //if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    //{
                    //    //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["reason_id"]) + ")' /> ";
                    //}
                    tempList.Add(tempAction);

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region BulkOperation
        /// <summary>
        /// LockReaders function 
        /// </summary>
        /// <returns>it will return 1 if successfully locked 0 incase of lock failed.</returns>
        public string BulkOperation()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {

                Hashtable ht = new Hashtable();
                ht.Add("action", "bulkOperation");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("priority", (Request["priority"] + "").Trim());
                ht.Add("operation", (Request["operation"] + "").Trim().ToUpper());

                ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("createdBy", Session["ID"] + "");
                ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("updatedBy", Session["ID"] + "");

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedureMaxLength("TAMSR2_ReaderBufferOps", ht, true);
                if (Numerics.GetDecimal(result) == -1)
                    return "-1";
                else if (Numerics.GetDecimal(result) > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of BulkOperation Function*********//
        #endregion



        #region LockReaders
        /// <summary>
        /// LockReaders function 
        /// </summary>
        /// <returns>it will return 1 if successfully locked 0 incase of lock failed.</returns>
        public string LockReaders()
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
                ht.Add("action", "lock");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("priority", (Request["priority"] + "").Trim());
                ht.Add("operation", (Request["operation"] + "").Trim().ToUpper());
                ht.Add("ID", ids);
                if ((Request["operation"] + "").Trim().ToUpper() == "DOWNLOAD_FILE")
                {
                    ht.Add("value", Server.MapPath("../Uploads/" + (Request["pwd"] + "").Trim()));
                }
                else
                {
                    ht.Add("value", (Request["pwd"] + "").Trim());
                }
                ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("createdBy", Session["ID"] + "");
                ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("updatedBy", Session["ID"] + "");

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedureMaxLength("TAMSR2_ReaderBufferOps", ht, true);
                if (Numerics.GetDecimal(result) == -1)
                    return "-1";
                else if (Numerics.GetDecimal(result) > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of LockReaders Function*********//
        #endregion



        #region ReaderEmployeeOperations
        /// <summary>
        /// ReaderEmployeeOperations function 
        /// </summary>
        /// <returns>it will return 1 if successfully locked 0 incase of lock failed.</returns>
        public string ReaderEmployeeOperations()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                int rdrCount = Numerics.GetInt(Request["rdrCount"] + "");
                int empCount = Numerics.GetInt(Request["empCount"] + "");

                string rdrIDs = "";
                for (int k = 1; k <= rdrCount; k++)
                {
                    rdrIDs += Request["rdr" + k] + ",";
                }
                rdrIDs = rdrIDs.TrimEnd(',');

                string empIDs = "";
                for (int k = 1; k <= empCount; k++)
                {
                    empIDs += Request["emp" + k] + ",";
                }
                empIDs = empIDs.TrimEnd(',');

                Hashtable ht = new Hashtable();
                ht.Add("action", "readerEmployee");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("priority", (Request["priority"] + "").Trim());
                ht.Add("operation", (Request["operation"] + "").Trim().ToUpper());
                ht.Add("rdrIDs", rdrIDs);
                ht.Add("empIDs", empIDs);

                ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("createdBy", Session["ID"] + "");
                ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("updatedBy", Session["ID"] + "");

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedureMaxLength("TAMSR2_ReaderBufferOps", ht, true);
                if (Numerics.GetDecimal(result) == -2)
                    return "-2";
                else if (Numerics.GetDecimal(result) == -1)
                    return "-1";
                else if (Numerics.GetDecimal(result) > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region GetAllBuffer
        /// <summary>
        /// GetAllBuffer function 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllBuffer()
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

                string[] cols = { "reader_buffer_id", "reader_name", "operation", "value", "priority", "status_flag", "remarks"};

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderBufferOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ReaderBufferOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if (Numerics.GetDecimal(obj["status_flag"] + "") != 1 || Numerics.GetDecimal(obj["status_flag"] + "") != 3)
                    {
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["reader_buffer_id"]) + "' />");
                    }
                    else
                    {
                        tempList.Add("&nbsp;");
                    }
                    tempList.Add((obj["reader_name"] + "").Length > 100 ? (obj["reader_name"] + "").Substring(0, 100) + "..." : (obj["reader_name"] + ""));
                    tempList.Add((obj["operation"] + "").Length > 100 ? (obj["operation"] + "").Substring(0, 100) + "..." : (obj["operation"] + ""));

                    if ((obj["operation"] + "").Trim() == "RESET_PWD" || (obj["operation"] + "").Trim() == "DOWNLOAD_FILE")
                        tempList.Add((obj["value"] + "").Length > 100 ? (obj["value"] + "").Substring(0, 100) + "..." : (obj["value"] + ""));
                    else
                        tempList.Add((obj["EmpName" + languagePostfix] + "").Length > 100 ? (obj["EmpName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["EmpName" + languagePostfix] + ""));

                    if (Numerics.GetDecimal(obj["priority"] + "") == 0)
                        tempList.Add((String)GetGlobalResourceObject("Resource", "normal"));
                    if (Numerics.GetDecimal(obj["priority"] + "") == 1)
                        tempList.Add((String)GetGlobalResourceObject("Resource", "medium"));
                    if (Numerics.GetDecimal(obj["priority"] + "") == 2)
                        tempList.Add((String)GetGlobalResourceObject("Resource", "high"));

                    if (Numerics.GetDecimal(obj["status_flag"] + "") == 0)
                        tempList.Add((String)GetGlobalResourceObject("Resource", "pending"));
                    if (Numerics.GetDecimal(obj["status_flag"] + "") == 1)
                        tempList.Add((String)GetGlobalResourceObject("Resource", "processing"));
                    if (Numerics.GetDecimal(obj["status_flag"] + "") == 2)
                        tempList.Add((String)GetGlobalResourceObject("Resource", "failed"));
                    if (Numerics.GetDecimal(obj["status_flag"] + "") == 3)
                        tempList.Add((String)GetGlobalResourceObject("Resource", "successful"));
                    if (Numerics.GetDecimal(obj["status_flag"] + "") == 4)
                        tempList.Add((String)GetGlobalResourceObject("Resource", "cancel"));


                    tempList.Add((obj["remarks"] + "").Length > 100 ? (obj["remarks"] + "").Substring(0, 100) + "..." : (obj["remarks"] + ""));
                    
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region GetDownloadFileList
        /// <summary>
        /// GetDownloadFileList function
        /// 
        /// </summary>
        /// <returns>it will list of downloaded reader files</returns>
        public string GetDownloadFileList()
        {
            StringBuilder sb = new StringBuilder();
            string noRecordFound = (String)GetGlobalResourceObject("Resource", "noRecordFound");
            string dirPath = Server.MapPath("../Uploads/");
            try
            {
                foreach (string str in Directory.GetFiles(dirPath)) //, ".DWN", SearchOption.TopDirectoryOnly))
                {
                    if (str.EndsWith(".DWN") || str.EndsWith(".dwn"))
                        sb.Append("<option value='" + str.Replace(dirPath, "") + "'>" + str.Replace(dirPath, "") + "</option>");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
            }
            if (sb.ToString() == "")
                return "<select id='ddDownloadedFile' size='15' style='width:100%'> <option value=''>noRecordFound</option> </select>";
            else
                return "<select id='ddDownloadedFile' size='15' style='width:100%'>" + sb.ToString() + "</select>";
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
            int deleteable = 0;
            int normalIn = 0;
            int normalOut = 0;

            if ((Request["type"] + "").ToLower() == "normalin")
                normalIn = 1;
            if ((Request["type"] + "").ToLower() == "normalout" && normalIn == 0)
                normalOut = 1;

            if ((Request["deleteable"] + "").ToLower() == "true")
                deleteable = 1;
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("descriptionEng", (Request["descriptionEn"] + "").Trim());
            ht.Add("descriptionArb", (Request["descriptionAr"] + "").Trim());
            ht.Add("reasonMode", (Request["reasonMode"] + "").Trim());
            ht.Add("promptMsg", (Request["promptMsg"] + "").Trim());
            ht.Add("deleteable", deleteable);
            ht.Add("normalIn", normalIn);
            ht.Add("normalOut", normalOut);
            ht.Add("orgID", (Request["orgID"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ReaderOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.Save()", 0, ex);
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