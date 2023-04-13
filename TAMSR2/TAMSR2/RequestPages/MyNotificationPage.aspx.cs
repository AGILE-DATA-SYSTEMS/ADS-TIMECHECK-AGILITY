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
    public partial class MyNotificationPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/MyNotificationPage.aspx"));


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
            else if (Request["key"] + "" == "getTabNotifications" && (Request["tab"] + "" != "late" && Request["tab"] + "" != "early" && Request["tab"] + "" != "absent"))
            {
                data = GetTabNotifications();
            }
            else if (Request["key"] + "" == "getTabNotificationsCount" && (Request["tab"] + "" != "late" && Request["tab"] + "" != "early" && Request["tab"] + "" != "absent"))
            {
                data = GetTabNotificationsCount();
            }
            else if (Request["key"] + "" == "getTabNotifications" && (Request["tab"] + "" == "late" || Request["tab"] + "" == "early" || Request["tab"] + "" == "absent"))
            {
                data = GetTabVerificationNotifications();
            }
            else if (Request["key"] + "" == "getTabNotificationsCount" && (Request["tab"] + "" == "late" || Request["tab"] + "" == "early" || Request["tab"] + "" == "absent"))
            {
                data = GetTabVerificationNotificationsCount();
            }
            else if (Request["key"] + "" == "markRead")
            {
                data = MarkRead();
            }
            else if (Request["key"] + "" == "getAllPendingVerifications")
            {
                data = GetAllPendingVerifications();
            }
            else if (Request["key"] + "" == "approveVerification")
            {
                data = VerificationApproveReject();
            }
            else if (Request["key"] + "" == "getGroupVoilations")
            {
                data = GetGroupVoilations();
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






        #region GetTabNotifications
        /// <summary>
        /// GetTabNotifications function
        /// Get Tab Notifications
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetTabNotifications()
        {
            StringBuilder sb = new StringBuilder();

            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", Request["tab"] + "");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                string redirectURL = "";
                
                if ((Request["tab"] + "").ToLower() == "leaves")
                    redirectURL = path + "Leaves/Approve-Employee-Leaves";
                if ((Request["tab"] + "").ToLower() == "permissions")
                    redirectURL = path + "Leaves/Approve-Permissions";
                if ((Request["tab"] + "").ToLower() == "movements")
                    redirectURL = path + "Events/Approve-Manual-Transaction";
                if ((Request["tab"] + "").ToLower() == "extraTime" || (Request["tab"] + "").ToLower() == "overtime")
                    redirectURL = path + "Emp/Employee-Approve-Overtime";

                if ((Request["tab"] + "").ToLower() == "late")
                    redirectURL = path + "Leaves/Approve-Verifications";
                if ((Request["tab"] + "").ToLower() == "early")
                    redirectURL = path + "Leaves/Approve-Verifications";
                if ((Request["tab"] + "").ToLower() == "absent")
                    redirectURL = path + "Leaves/Approve-Verifications";

                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYNotifications", ht);

                int count = 0;
                if (objDataView != null)
                    count = objDataView.Table.Rows.Count;
                sb.Append("<span id='spnNotifyCount" + Request["tab"] + "' style='display: none;'>" + count + "</span>");
                foreach (DataRowView obj in objDataView)
                {
                    if (obj["status"] + "" == "0")
                        sb.Append("<li style='cursor: pointer;' id='fli" + obj["notification_id"] + "' rdrurl='" + redirectURL + "' onclick='return MarkRead(" + obj["notification_id"] + ", \"" + Request["tab"] + "\")'>");
                    else
                        sb.Append("<li style='cursor: pointer;' id='fli" + obj["notification_id"] + "' rdrurl='#' onclick='return MarkRead(" + obj["notification_id"] + ", \"" + Request["tab"] + "\")'>");
                    sb.Append("<div class='col1'>");
                    sb.Append("<div class='cont'>");
                    sb.Append("<div class='cont-col1'>");
                    if (obj["status"] + "" == "2")
                    {
                        sb.Append("<div class='label label-important'>");
                    }
                    else if (obj["status"] + "" == "1")
                    {
                        sb.Append("<div class='label label-success'>");
                    }
                    else
                    {
                        sb.Append("<div class='label'>");
                    }
                    sb.Append("<i class='icon-bell'></i>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("<div class='cont-col2'>");
                    sb.Append("<div class='desc'>");
                    sb.Append(obj["description" + languagePostfix] + "");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("<div class='col2'>");
                    sb.Append("<div class='date'>");
                    sb.Append(GetNotificationTime(obj["created_date"] + ""));
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</li>");
                }
                if(objDataView.Count <= 0 )
                    sb.Append("<li>&nbsp;</li>");
            }
            catch (Exception ex)
            {
                sb.Append("<li>&nbsp;</li>");
                new ExceptionLog().WriteLog("RequestPages/MyNotificationPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAll Function*********//
        #endregion






        #region GetTabNotificationsCount
        /// <summary>
        /// GetTabNotifications function
        /// Get Tab Notifications
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetTabNotificationsCount()
        {
            TabNotification obj = new TabNotification();

            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "tabCounts");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYNotifications", ht);

                if (dv != null)
                {
                    obj.Leave = Numerics.GetDecimal(dv[0]["leaveCount"]);
                    obj.Permission = Numerics.GetDecimal(dv[0]["permissionCount"]);
                    obj.Movement = Numerics.GetDecimal(dv[0]["movementCount"]);
                    obj.MissTime = Numerics.GetDecimal(dv[0]["missTimeCount"]);
                    obj.ExtraTime = Numerics.GetDecimal(dv[0]["extraTimeCount"]);
                    obj.Late = Numerics.GetDecimal(dv[0]["lateCount"]);
                    obj.Early = Numerics.GetDecimal(dv[0]["earlyCount"]);
                    obj.Absent = Numerics.GetDecimal(dv[0]["absentCount"]);
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






        #region GetTabVerificationNotifications
        /// <summary>
        /// GetTabVerificationNotifications function
        /// Get Tab Verification Notifications
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetTabVerificationNotifications()
        {
            StringBuilder sb = new StringBuilder();

            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");

            string takeAction = (String)GetGlobalResourceObject("Resource", "takeAction");
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", Request["tab"] + "");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                string redirectURL = "";

                if ((Request["tab"] + "").ToLower() == "late")
                    redirectURL = path + "Leaves/Approve-Late";
                if ((Request["tab"] + "").ToLower() == "early")
                    redirectURL = path + "Leaves/Approve-Early";
                if ((Request["tab"] + "").ToLower() == "absent")
                    redirectURL = path + "Leaves/Approve-Absent";

                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYNotifications", ht);

                int count = 0;
                if (objDataView != null)
                    count = objDataView.Table.Rows.Count;
                sb.Append("<span id='spnNotifyCount" + Request["tab"] + "' style='display: none;'>" + count + "</span>");
                foreach (DataRowView obj in objDataView)
                {
                    //if (obj["status"] + "" == "0")
                    //    sb.Append("<li style='cursor: pointer;' id='fli" + obj["notification_id"] + "' rdrurl='" + redirectURL + "' >");
                    //else
                        sb.Append("<li style='cursor: pointer;' id='fli" + obj["notification_id"] + "' rdrurl='#' >");
                    sb.Append("<div class='col1'>");
                    sb.Append("<div class='cont'>");
                    sb.Append("<div class='cont-col1'>");
                    if (obj["status"] + "" == "2")
                    {
                        sb.Append("<div class='label label-important'>");
                    }
                    else if (obj["status"] + "" == "1")
                    {
                        sb.Append("<div class='label label-success'>");
                    }
                    else
                    {
                        sb.Append("<div class='label'>");
                    }
                    sb.Append("<i class='icon-bell'></i>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("<div class='cont-col2'>");
                    sb.Append("<div class='desc'>");
                    sb.Append(obj["description" + languagePostfix] + "");

                    sb.Append(@" &nbsp;&nbsp;&nbsp;<span class='label label-important label-mini' onclick='return VerificationTakeAction(" + obj["notification_id"] + ", \"" + Request["tab"] + "\", \"approve\", \"" + obj["description" + languagePostfix] + "" + "\")'>" 
                        + takeAction + " <i class='icon-share-alt'></i> </span>");

                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("<div class='col2'>");
                    sb.Append("<div class='date'>");
                    sb.Append(GetNotificationTime(obj["created_date"] + ""));
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</li>");
                }
                if (objDataView.Count <= 0)
                    sb.Append("<li>&nbsp;</li>");
            }
            catch (Exception ex)
            {
                sb.Append("<li>&nbsp;</li>");
                new ExceptionLog().WriteLog("RequestPages/MyNotificationPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetTabVerificationNotifications Function*********//
        #endregion






        #region GetTabVerificationNotificationsCount
        /// <summary>
        /// GetTabVerificationNotificationsCount function
        /// Get Tab Verfication Notifications
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetTabVerificationNotificationsCount()
        {
            TabNotification obj = new TabNotification();

            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "tabCounts");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYNotifications", ht);

                if (dv != null)
                {
                    obj.Leave = Numerics.GetDecimal(dv[0]["leaveCount"]);
                    obj.Permission = Numerics.GetDecimal(dv[0]["permissionCount"]);
                    obj.Movement = Numerics.GetDecimal(dv[0]["movementCount"]);
                    obj.MissTime = Numerics.GetDecimal(dv[0]["missTimeCount"]);
                    obj.ExtraTime = Numerics.GetDecimal(dv[0]["extraTimeCount"]);
                    obj.Late = Numerics.GetDecimal(dv[0]["lateCount"]);
                    obj.Early = Numerics.GetDecimal(dv[0]["earlyCount"]);
                    obj.Absent = Numerics.GetDecimal(dv[0]["absentCount"]);
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
        //*********End Of GetTabVerificationNotificationsCount Function*********//
        #endregion






        #region GetAllVerifications
        /// <summary>
        /// GetAlVerifications function
        /// Get All Verification 
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string GetAllVerifications()
        {
            StringBuilder sb = new StringBuilder();

            string dt = (Request["dt"] + "").Trim();
            string type = (Request["type"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");

            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", Request["tab"] + "");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYNotifications", ht);

                int count = 0;
                if (objDataView != null)
                    count = objDataView.Table.Rows.Count;
                sb.Append("<span id='spnNotifyCount" + Request["tab"] + "' style='display: none;'>" + count + "</span>");
                foreach (DataRowView obj in objDataView)
                {
                    //if (obj["status"] + "" == "0")
                    //    sb.Append("<li style='cursor: pointer;' id='fli" + obj["notification_id"] + "' rdrurl='" + redirectURL + "' >");
                    //else
                    sb.Append("<li style='cursor: pointer;' id='fli" + obj["notification_id"] + "' rdrurl='#' >");
                    sb.Append("<div class='col1'>");
                    sb.Append("<div class='cont'>");
                    sb.Append("<div class='cont-col1'>");
                    if (obj["status"] + "" == "2")
                    {
                        sb.Append("<div class='label label-important'>");
                    }
                    else if (obj["status"] + "" == "1")
                    {
                        sb.Append("<div class='label label-success'>");
                    }
                    else
                    {
                        sb.Append("<div class='label'>");
                    }
                    sb.Append("<i class='icon-bell'></i>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("<div class='cont-col2'>");
                    sb.Append("<div class='desc'>");
                    sb.Append(obj["description" + languagePostfix] + "");
                    sb.Append("<br /><span onclick='return VerificationAproveReject(" + obj["notification_id"] + ", \"" + Request["tab"] + "\", \"approve\")' class='label label-success'>Approve</span>");
                    sb.Append("&nbsp;&nbsp;<span onclick='return VerificationAproveReject(" + obj["notification_id"] + ", \"" + Request["tab"] + "\", \"reject\")' class='label label-important'>Reject</span>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("<div class='col2'>");
                    sb.Append("<div class='date'>");
                    sb.Append(GetNotificationTime(obj["created_date"] + ""));
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</li>");
                }
                if (objDataView.Count <= 0)
                    sb.Append("<li>&nbsp;</li>");
            }
            catch (Exception ex)
            {
                sb.Append("<li>&nbsp;</li>");
                new ExceptionLog().WriteLog("RequestPages/MyNotificationPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString();
        }
        //*********End Of GetAllVerifications Function*********//
        #endregion







        #region GetAllPendingVerifications
        /// <summary>
        /// Get All Pending Verifications function
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllPendingVerifications()
        {
            string verification = (Request["tab"] + "").Trim();
            string status = (Request["status"] + "").Trim();
            if (verification == "")
                verification = "late";
            if (status == "")
                status = "0";
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();

            try
            {
                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "Transaction_id", "employee_code", "name" + languagePostfix, "Transaction_id", "Ddate", verification, verification + "_approved_name" + languagePostfix, verification + "approved_date", verification + "approved_remarks" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getVerificationRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("verification", verification);
                ht.Add("approveReject", status);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYNotifications", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getVerificationRecordsCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("verification", verification);
                ht.Add("approveReject", status);
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_MYNotifications", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if ((Numerics.GetInt(obj["approve_reject_flag"] + "")) != 1 || 
                                ((Numerics.GetInt(obj["approve_reject_flag"] + "")) == 1 && new TAMSPrivilege().IsPrivileged(TAMSPrivilege.CANCEL_APPROVED_VERIFICATION) == true)
                        )
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["Transaction_id"]) + "' />");
                    else
                        tempList.Add(" &nbsp;");


                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));

                    tempList.Add(verification.ToUpper());

                    if (obj["TransactionDate"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["TransactionDate"]).ToString(AppSetting.dateFormat));
                    }
                    else
                    {
                        tempList.Add("");
                    }
                    if (obj["VerificationTime"] + "" != "")
                    {
                        tempList.Add((obj["VerificationTime"] + "").Trim());
                    }
                    else
                    {
                        tempList.Add("");
                    }

                    tempList.Add((obj["ApprovedByName" + languagePostfix] + "").Length > 100 ? (obj["ApprovedByName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["ApprovedByName" + languagePostfix] + ""));

                    if (obj["ApprovedDate"] + "" != "")
                    {
                        tempList.Add(Numerics.GetDateTime(obj["ApprovedDate"]).ToString(AppSetting.dateFormat));
                    }
                    else
                    {
                        tempList.Add("");
                    }

                    tempList.Add((obj["remarks"] + "").Length > 100 ? (obj["remarks"] + "").Substring(0, 100) + "..." : (obj["remarks"] + ""));

                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["approve_reject_flag"] + "")));
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/MyNotificationPage.aspx.GetAllPendingVerifications()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAllPendingVerifications Function*********//
        #endregion







        public string GetApplyApporveRejectStatus(int temp)
        {
            if (temp == 0)
                return (String)GetGlobalResourceObject("Resource", "pending") + "";
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
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            TabNotification obj = new TabNotification();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ReasonOps", ht);

                if (dv != null)
                {
                    obj.Leave = Numerics.GetDecimal(dv[0]["Leave"]);
                    obj.Permission = Numerics.GetDecimal(dv[0]["Permission"]);
                    obj.Movement = Numerics.GetDecimal(dv[0]["Movement"]);
                    obj.MissTime = Numerics.GetDecimal(dv[0]["MissTime"]);
                    obj.ExtraTime = Numerics.GetDecimal(dv[0]["ExtraTime"]);
                    obj.Late = Numerics.GetDecimal(dv[0]["Late"]);
                    obj.Early = Numerics.GetDecimal(dv[0]["Early"]);
                    obj.Absent = Numerics.GetDecimal(dv[0]["Absent"]);
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







        string GetNotificationTime(string dateStr)
        {
            DateTime date = Numerics.GetDateTime(dateStr);
            if (date.Date == DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).Date)
                return (String)GetGlobalResourceObject("Resource", "today") + " " + date.ToString("HH:mm") + "";
            else
                return date.ToString(AppSetting.dateFormat) + "";
        }






        string GetGroupVoilations()
        {
            GroupStats obj = new GroupStats();
            obj.MonthlyAchievedHours = 55;
            if (obj.MonthlyAchievedHours < 40)
                obj.MonthlyAchievedHoursColor = "red";
            else if (obj.MonthlyAchievedHours < 75)
                obj.MonthlyAchievedHoursColor = "yellow";
            else
                obj.MonthlyAchievedHoursColor = "green";
            
            obj.MonthlyLate = "8, 9, 10, 11, 10, 10, 12, 10, 10, 11, 9, 12, 11, 10, 9, 11, 13, 13, 12";
            obj.MonthlyEarly = "9, 11, 12, 13, 12, 13, 10, 14, 13, 11, 11, 12, 11, 11, 10, 12, 11, 10";
            obj.MonthlyAbsent = "9, 11, 12, 13, 12, 13, 10, 14, 13, 11, 11, 12, 11, 11, 10, 12, 11, 10";
            return new JavaScriptSerializer().Serialize(obj);
        }





        #region MarkRead
        /// <summary>
        /// MarkRead function
        /// Mark Read Notifications
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string MarkRead()
        {
            string temp = "";
            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");

            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "markRead");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Request["nID"] + "");
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYNotifications", ht);
                temp = objDataView[0][0] + "";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/MyNotificationPage.aspx.GerAll()", 0, ex);
                temp = "0";
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return temp;
        }
        //*********End Of GetAll Function*********//
        #endregion






        #region VerificationApproveReject
        /// <summary>
        /// VerificationApproveReject function
        /// Mark Read Notifications
        /// </summary>
        /// <returns>it will return html string for Dashboard Transaction Grid</returns>
        public string VerificationApproveReject()
        {
            string temp = "";
            string verification = (Request["tab"] + "").Trim();
            string approveReject = (Request["approveReject"] + "").Trim();
            string remarks = (Request["remarks"] + "").Trim();
            string dt = (Request["dt"] + "").Trim();

            int count = Numerics.GetInt(Request["count"] + "");
            string ids = "";
            for (int k = 1; k <= count; k++)
            {
                ids += Request["chk" + k] + ",";
            }
            ids = ids.TrimEnd(',');
            if(count <= 0 )
                ids = (Request["nID"] + "");

            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "verificationApproveReject");
                ht.Add("verification", verification);
                ht.Add("approveReject", approveReject);
                ht.Add("remarks", remarks);
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MYNotifications", ht);
                temp = objDataView[0][0] + "";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/MyNotificationPage.aspx.GerAll()", 0, ex);
                temp = "0";
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return temp;
        }
        //*********End Of VerificationApproveReject Function*********//
        #endregion




    }
}