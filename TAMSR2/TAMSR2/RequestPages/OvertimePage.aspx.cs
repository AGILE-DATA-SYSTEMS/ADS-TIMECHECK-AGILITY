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
    public partial class OvertimePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        public string GetApplyApporveRejectStatus(int temp)
        {
            //if (temp == -1)
            //    return (String)GetGlobalResourceObject("Resource", "pending") + "";
            if (temp == 0)
                return (String)GetGlobalResourceObject("Resource", "pending") + "";
            else if (temp == 1)
                return (String)GetGlobalResourceObject("Resource", "approved") + "";
            else if (temp == 2)
                return (String)GetGlobalResourceObject("Resource", "rejected") + "";
            else
                return "";
        }

        public string GetProcessedStatus(int temp)
        {
            //if (temp == -1)
            //    return (String)GetGlobalResourceObject("Resource", "pending") + "";
            if (temp == 0)
                return (String)GetGlobalResourceObject("Resource", "ready") + "";
            else if (temp == 1)
                return (String)GetGlobalResourceObject("Resource", "transferred") + "";
            else if (temp == 2)
                return (String)GetGlobalResourceObject("Resource", "failed") + "";
            else
                return "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/OvertimePage.aspx"));


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
            else if (Request["key"] + "" == "getAllPendingProcess")
            {
                data = GetAllPendingProcess();
            }
            else if (Request["key"] + "" == "applyPending")
            {
                data = ApplyPending();
            }
            else if (Request["key"] + "" == "approvePendingOvertime")
            {
                data = ApprovePendingOvertime();
            }
            else if (Request["key"] + "" == "rejectPendingOvertime")
            {
                data = RejectPendingOvertime();
            }
            else if (Request["key"] + "" == "processAllOvertime")
            {
                data = ProcessAllManagerApprovedOvertime();
            }
            else if (Request["key"] + "" == "processApprovePendingOvertime")
            {
                data = ProcessApprovePendingOvertime();
            }
            else if (Request["key"] + "" == "processRejectPendingOvertime")
            {
                data = ProcessRejectPendingOvertime();
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
            Country obj = new Country();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CountryOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["country_id"]);
                    obj.Code = dv[0]["code"] + "";
                    obj.DescriptionEn = dv[0]["description_Eng"] + "";
                    obj.DescriptionAr = dv[0]["description_Arb"] + "";
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CountryOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string countryStr = (String)GetGlobalResourceObject("Resource", "country");

                sb.Append("<option value=''>" + chooseStr + " " + countryStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Country obj = new Country();
                    obj.ID = Numerics.GetDecimal(row["country_id"] + "");
                    obj.Code = row["code"] + "";
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_CountryOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion




        #region ApplyPending
        /// <summary>
        /// ApplyPending function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string ApplyPending()
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
                ht.Add("action", "applyPendingByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_OverTimeOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return temp + "";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of ApplyPending Function*********//
        #endregion




        #region ApprovePendingOvertime
        /// <summary>
        /// ApprovePendingOvertime function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string ApprovePendingOvertime()
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
                ht.Add("action", "ApprovePendingOvertime");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_OverTimeOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return temp + "";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of ApprovePendingOvertime Function*********//
        #endregion





        #region RejectPendingOvertime
        /// <summary>
        /// RejectPendingOvertime function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string RejectPendingOvertime()
        {
            string result = "0";
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
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
                ht.Add("action", "RejectPendingOvertime");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OverTimeOps", ht);
                if (dv != null)
                {
                    result = (dv[0][0] + "").Trim();
                }
                //int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_OverTimeOps", ht);
                if (Numerics.GetInt(result) > 0)
                    result = "1";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return result;
        }
        //*********End Of RejectPendingOvertime Function*********//
        #endregion









        #region ProcessAllManagerApprovedOvertime
        /// <summary>
        /// ProcessAllManagerApprovedOvertime function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string ProcessAllManagerApprovedOvertime()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DbActionMsg obj = new DbActionMsg();
            try
            {
                string year = Request["year"] + "";
                string month = Request["month"] + "";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";
                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + noOfDays;

                Hashtable ht = new Hashtable();
                ht.Add("action", "ProcessAllManagerApprovedOvertime");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OverTimeOps", ht);

                if (dv != null)
                {
                    obj.ActionType = (dv[0]["ActionType"] + "").Trim();
                    obj.ActionResult = (dv[0]["ActionResult"] + "").Trim();
                    obj.ActionMessage = (dv[0]["ActionMessage"] + "").Trim();
                    obj.ActionWarning = (dv[0]["ActionWarning"] + "").Trim();
                    obj.ActionResult = Numerics.GetDecimal(obj.ActionResult) > 0 ? "1" : obj.ActionResult;
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.ProcessAllManagerApprovedOvertime()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(obj);
        }
        //*********End Of ProcessAllManagerApprovedOvertime Function*********//
        #endregion

        #region ProcessApprovePendingOvertime
        /// <summary>
        /// ProcessApprovePendingOvertime function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string ProcessApprovePendingOvertime()
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
                ht.Add("action", "ProcessApprovePendingOvertime");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_OverTimeOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of ProcessApprovePendingOvertime Function*********//
        #endregion




        #region ProcessRejectPendingOvertime
        /// <summary>
        /// RejectPendingOvertime function
        /// 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string ProcessRejectPendingOvertime()
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
                ht.Add("action", "ProcessRejectPendingOvertime");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_OverTimeOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of RejectPendingOvertime Function*********//
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

                //string[] cols = { "transactionID", "employee_code", "Name" + languagePostfix, "Org" + languagePostfix, "Ddate", "OT1", "OT2", "OT1_PROCESSED", "OT2_PROCESSED", "OT_Request_Status", "OT_Action_Status", "OT_Processed_Status" };
                string[] cols = { "transactionID", "employee_code", "Name" + languagePostfix, "Org" + languagePostfix, "FromDate", "ToDate", "Time_IN", "Time_OUT", "OT1", "OT2",  "OT_Type", "OT_Request_Status", "OT_Action_Status" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string year = Request["year"] + "";
                string month = Request["month"] + "";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";
                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + noOfDays;

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", (Request["orgID"] + "").Trim());
                ht.Add("empID", (Request["empID"] + "").Trim());
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_OverTimeOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", (Request["orgID"] + "").Trim());
                ht.Add("empID", (Request["empID"] + "").Trim());
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_OverTimeOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if (Numerics.GetInt(obj["OT_Request_Status"] + "") != 0 && Numerics.GetInt(obj["OT_Request_Status"] + "") != 1)
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["transactionID"]) + "' />");
                    else
                        tempList.Add("&nbsp;");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["Name" + languagePostfix] + "").Length > 100 ? (obj["Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Name" + languagePostfix] + ""));
                    tempList.Add((obj["Org" + languagePostfix] + "").Length > 100 ? (obj["Org" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Org" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["FromDate"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["ToDate"] + "").ToString(AppSetting.dateFormat)); 
                    tempList.Add(obj["Punch_IN"] + "");
                    tempList.Add(obj["Punch_Out"] + "");
                    tempList.Add(obj["OT1_HHmm"] + "");
                    tempList.Add(obj["OT2_HHmm"] + "");
                    tempList.Add(obj["OT_Type"] + "");
                    //tempList.Add(obj["OT2_HHmm_Processed"] + "");
                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["OT_Request_Status"] + "")));
                    if(Numerics.GetInt(obj["OT_Request_Status"] + "") != 1)
                        tempList.Add("&nbsp;");
                    else
                        tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["OT_Action_Status"] + "")));
                    //tempList.Add(GetProcessedStatus(Numerics.GetInt(obj["OT_Processed_Status"] + "")));
                    //tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "&nbsp;";

                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.GerAll()", 0, ex);
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

                //string[] cols = { "transactionID", "employee_code", "Name" + languagePostfix, "Org" + languagePostfix, "Ddate", "OT1", "OT2", "OT1_PROCESSED", "OT2_PROCESSED", "OT_Request_Status", "OT_Action_Status", "OT_Processed_Status" };
                string[] cols = { "transactionID", "employee_code", "Name" + languagePostfix, "Org" + languagePostfix, "FromDate", "ToDate", "Time_IN", "Time_OUT", "OT1", "OT2", "OT_Type", "OT_Request_Status", "OT_Action_Status" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string year = Request["year"] + "";
                string month = Request["month"] + "";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";
                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + noOfDays;

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getPendingRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", (Request["orgID"] + "").Trim());
                ht.Add("empID", (Request["empID"] + "").Trim());
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_OverTimeOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getPendingCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", (Request["orgID"] + "").Trim());
                ht.Add("empID", (Request["empID"] + "").Trim());
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_OverTimeOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if (Numerics.GetInt(obj["OT_Request_Status"] + "") != 2)
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["transactionID"]) + "' />");
                    else
                        tempList.Add("&nbsp;");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["Name" + languagePostfix] + "").Length > 100 ? (obj["Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Name" + languagePostfix] + ""));
                    tempList.Add((obj["Org" + languagePostfix] + "").Length > 100 ? (obj["Org" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Org" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["FromDate"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["ToDate"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["Punch_IN"] + "");
                    tempList.Add(obj["Punch_Out"] + "");
                    tempList.Add(obj["OT1_HHmm"] + "");
                    tempList.Add(obj["OT2_HHmm"] + "");
                    tempList.Add(obj["OT_Type"] + ""); 
                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["OT_Request_Status"] + "")));
                    if (Numerics.GetInt(obj["OT_Request_Status"] + "") != 1)
                        tempList.Add("&nbsp;");
                    else
                        tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["OT_Action_Status"] + "")));
                    string tempAction = "";
                    tempAction = "&nbsp;";
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAllPending Function*********//
        #endregion




        #region GetAllPendingProcess
        /// <summary>
        /// Get All Pending Process function
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllPendingProcess()
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

                string[] cols = { "transactionID", "employee_code", "Name" + languagePostfix, "Org" + languagePostfix, "Ddate", "OT1", "OT2", "OT1_PROCESSED", "OT2_PROCESSED", "OT_Request_Status", "OT_Action_Status", "OT_Processed_Status" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string year = Request["year"] + "";
                string month = Request["month"] + "";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";
                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + noOfDays;

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getPendingProcessRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", (Request["orgID"] + "").Trim());
                ht.Add("empID", (Request["empID"] + "").Trim());
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("OTActionStatus", (Request["status"] + "").Trim());
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_OverTimeOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getPendingProcessCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", (Request["orgID"] + "").Trim());
                ht.Add("empID", (Request["empID"] + "").Trim());
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("OTActionStatus", (Request["status"] + "").Trim());
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_OverTimeOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if (Numerics.GetInt(obj["OT_action_Status"] + "") != 1)
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["transactionID"]) + "' />");
                    else
                        tempList.Add("&nbsp;");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["Name" + languagePostfix] + "").Length > 100 ? (obj["Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Name" + languagePostfix] + ""));
                    tempList.Add((obj["Org" + languagePostfix] + "").Length > 100 ? (obj["Org" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Org" + languagePostfix] + ""));
                    tempList.Add(obj["MonthYear"] + "");
                    tempList.Add(obj["OT1_HHmm"] + "");
                    tempList.Add(obj["OT2_HHmm"] + "");
                    tempList.Add(obj["OT1_HHmm_Processed"] + "");
                    tempList.Add(obj["OT2_HHmm_Processed"] + "");
                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["OT_Action_Status"] + "")));
                    tempList.Add(GetProcessedStatus(Numerics.GetInt(obj["OT_Processed_Status"] + "")));
                    //tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";

                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAllPendingProcess Function*********//
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
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("descriptionEng", (Request["descriptionEn"] + "").Trim());
            ht.Add("descriptionArb", (Request["descriptionAr"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_CountryOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/OvertimePage.aspx.Save()", 0, ex);
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