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
    public partial class EmployeeScheduleManualPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        List<string> userRolesList = new List<string>();
        bool isAdminRoleUser = false;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/EmployeeScheduleManualPage.aspx"));


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

            userRolesList.AddRange((Session["UserRoles"] + "").Split(','));
            if (userRolesList.FindIndex(p => p == "ADMIN") >= 0)
                isAdminRoleUser = true;

            if (Request["key"] + "" == "save")
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
            else if (Request["key"] + "" == "approve")
            {
                data = Approve();
            }
            else if (Request["key"] + "" == "reject")
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




        #region DeleteByID
        /// <summary>
        /// DeleteByID function
        ///  
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmployeeScheduleManualOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeScheduleManualPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of DeleteByID Function*********//
        #endregion




        #region Approve
        /// <summary>
        /// Approve function
        ///  
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string Approve()
        {
            int temp = 0;
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
                ht.Add("action", "approve");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmployeeScheduleManualOps", ht);
                if (temp > 0)
                    temp = 1;
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeScheduleManualPage.aspx.Approve()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return temp + "";
        }
        //*********End Of Approve Function*********//
        #endregion




        #region Reject
        /// <summary>
        /// Reject function
        ///  
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string Reject()
        {
            int temp = 0;
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
                ht.Add("action", "reject");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmployeeScheduleManualOps", ht);
                if (temp > 0)
                    temp = 1;
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeScheduleManualPage.aspx.Reject()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return temp + "";
        }
        //*********End Of Reject Function*********//
        #endregion





        #region GetAll
        /// <summary>
        /// GetAll function
        ///  
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

                string[] cols = { "employee_schedule_id", "employee_code", "name" + languagePostfix, "from_date", "to_date", "s7.schedule_code", "s2.schedule_code", "s2.schedule_code", "s3.schedule_code", "s4.schedule_code", "s5.schedule_code", "s6.schedule_code", "os.status_flag", "employee_schedule_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeScheduleManualOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeScheduleManualOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;
                
                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if ((obj["created_id"] + "" == Session["ID"] + "" || isAdminRoleUser) && obj["status_flag"] + "" != "1")
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_schedule_id"]) + "' />");
                    else
                        tempList.Add(" &nbsp;");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                    if ((obj["from_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("&nbsp;");
                    if ((obj["to_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("&nbsp;");
                    if ((obj["sundayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["sundayschedule"] + "").Trim());
                    if ((obj["mondayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["mondayschedule"] + "").Trim());
                    if ((obj["tuesdayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["tuesdayschedule"] + "").Trim());
                    if ((obj["wednesdayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["wednesdayschedule"] + "").Trim());
                    if ((obj["thursdayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["thursdayschedule"] + "").Trim());
                    if ((obj["fridayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["fridayschedule"] + "").Trim());
                    if ((obj["saturdayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["saturdayschedule"] + "").Trim());

                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["status_flag"] + "")));
                    //tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if ((obj["created_id"] + "" == Session["ID"] + "" || isAdminRoleUser || Numerics.GetBool(Session["CanUpdate"]) == true) && obj["status_flag"] + "" != "0")
                    {
                        tempAction = "<a style='text-decoration: none;' href='" + path + "Sch/Apply-Employee-Schedules/" +
                                        Encryption.Encrypt(obj["employee_schedule_id"] + "") + "'>" +
                                        "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
                if (objDataView.Table.Rows.Count <= 0)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeScheduleManualPage.aspx.GerAll()", 0, ex);
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
        /// GetAllPending function
        ///  
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

                string[] cols = { "employee_schedule_id", "employee_code", "name" + languagePostfix, "from_date", "to_date", "s7.schedule_code", "s2.schedule_code", "s2.schedule_code", "s3.schedule_code", "s4.schedule_code", "s5.schedule_code", "s6.schedule_code", "os.status_flag" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getPendingRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeScheduleManualOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getPendingCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeScheduleManualOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if ((obj["created_id"] + "" != Session["ID"] + "" || isAdminRoleUser) && obj["status_flag"] + "" == "0")
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_schedule_id"]) + "' />");
                    else
                        tempList.Add(" &nbsp;");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                    if ((obj["from_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("&nbsp;");
                    if ((obj["to_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("&nbsp;");
                    if ((obj["sundayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["sundayschedule"] + "").Trim());
                    if ((obj["mondayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["mondayschedule"] + "").Trim());
                    if ((obj["tuesdayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["tuesdayschedule"] + "").Trim());
                    if ((obj["wednesdayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["wednesdayschedule"] + "").Trim());
                    if ((obj["thursdayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["thursdayschedule"] + "").Trim());
                    if ((obj["fridayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["fridayschedule"] + "").Trim());
                    if ((obj["saturdayschedule"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["saturdayschedule"] + "").Trim());

                    tempList.Add(GetApplyApporveRejectStatus(Numerics.GetInt(obj["status_flag"] + "")));
                    
                    json.aaData.Add(tempList);
                }
                if (objDataView.Table.Rows.Count <= 0)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    tempList.Add(" &nbsp; ");
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeScheduleManualPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion




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
            Schedule obj = new Schedule();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                try
                {
                    ht.Add("ID", Encryption.Decrypt((Request["id"] + "").Trim()));
                }
                catch (Exception ex)
                {
                    ht.Add("ID", Request["id"] + "");
                }
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeScheduleManualOps", ht);

                if (dv != null)
                {
                    obj.EmpID = Numerics.GetDecimal((dv[0]["employee_id"] + "").Trim());
                    obj.Sunday = Numerics.GetInt((dv[0]["sunday_schedule_id"] + "").Trim());
                    obj.Monday = Numerics.GetInt((dv[0]["monday_schedule_id"] + "").Trim());
                    obj.Tuesday = Numerics.GetInt((dv[0]["tuesday_schedule_id"] + "").Trim());
                    obj.Wednesday = Numerics.GetInt((dv[0]["wednesday_schedule_id"] + "").Trim());
                    obj.Thursday = Numerics.GetInt((dv[0]["thursday_schedule_id"] + "").Trim());
                    obj.Friday = Numerics.GetInt((dv[0]["friday_schedule_id"] + "").Trim());
                    obj.Saturday = Numerics.GetInt((dv[0]["saturday_schedule_id"] + "").Trim());
                    if ((dv[0]["from_date"] + "").Trim() != "")
                    {
                        obj.FromDate = Numerics.GetDateTime((dv[0]["from_date"] + "").Trim());
                        obj.FromDateStr = obj.FromDate.ToString("yyyy-MM-dd");
                    }
                    if ((dv[0]["to_date"] + "").Trim() != "")
                    {
                        obj.ToDate = Numerics.GetDateTime((dv[0]["to_date"] + "").Trim());
                        obj.ToDateStr = obj.ToDate.ToString("yyyy-MM-dd");
                    }
                    obj.CreatedBy = Numerics.GetDecimal((dv[0]["created_id"] + "").Trim());
                    obj.CreatedOn = Numerics.GetDateTime((dv[0]["created_date"] + "").Trim());
                    obj.UpdatedBy = Numerics.GetDecimal((dv[0]["updated_id"] + "").Trim());
                    obj.UpdatedOn = Numerics.GetDateTime((dv[0]["updated_date"] + "").Trim());
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




        #region Save
        /// <summary>
        /// Save function
        ///  
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string Save()
        {
            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            try
            {
                ht.Add("ID", Encryption.Decrypt((Request["id"] + "").Trim()));
            }
            catch (Exception ex)
            {
                ht.Add("ID", Request["id"] + "");
            }
            ht.Add("empID", (Request["empID"] + "").Trim());
            ht.Add("sunday", (Request["sunday"] + "").Trim());
            ht.Add("monday", (Request["monday"] + "").Trim());
            ht.Add("tuesday", (Request["tuesday"] + "").Trim());
            ht.Add("wednesday", (Request["wednesday"] + "").Trim());
            ht.Add("thursday", (Request["thursday"] + "").Trim());
            ht.Add("friday", (Request["friday"] + "").Trim());
            ht.Add("saturday", (Request["saturday"] + "").Trim());

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
            ht.Add("fromDate", fromDate);
            ht.Add("toDate", toDate);

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = "0";

                result = objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeScheduleManualOps", ht);

                if (Numerics.GetDecimal(result) > 0)
                {
                    chk = "1";
                }
                else
                {
                    chk = Numerics.GetDecimal(result) + "";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeScheduleManualPage.aspx.Save()", 0, ex);
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