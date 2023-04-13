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
    public partial class MonthLockPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/MonthLockPage.aspx"));

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
            else if (Request["key"] + "" == "getEmployeeByMonthID")
            {
                data = GetEmployeeByMonthId(); 
            }
            else if (Request["key"] + "" == "unlockByID")
            {
                data = UnlockByID();
            }
            else if (Request["key"] + "" == "lockByID")
            {
                data = LockByID();
            }
            else if (Request["key"] + "" == "DeleteByIDs")
            {
                 data = DeleteByID();
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

                string[] cols = { "m.month_lock_id","o.description" + languagePostfix, "m.year", "m.month", "m.status","u.name_eng","m.updated_date"};

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("Year", (Request["Year"] + "").Trim());
                ht.Add("Month", (Request["Month"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MonthLockOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("Year", (Request["Year"] + "").Trim());
                ht.Add("Month", (Request["Month"] + "").Trim());
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_MonthLockOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["month_lock_id"]) + "' />");
                    tempList.Add((obj["organization" + languagePostfix] + "").Length > 100 ? (obj["organization" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["organization" + languagePostfix] + ""));
                    tempList.Add(obj["year"] + "");
                    tempList.Add(MonthNameByID(obj["month"] + ""));

                    string tempAction = "";
                    if(Convert.ToBoolean(obj["status"] + "") == true)
                        tempAction = "<i class='icon-lock'></i>";
                    else
                        tempAction = "<i class='icon-unlock'></i>";

                    tempList.Add(tempAction);

                    tempAction = "";
                    tempAction = "<a href='" + Page.ResolveClientUrl("~/Freeze/Month-Lock-Details") + "/" + obj["month_lock_id"] + "" + "' > <img src='" + path + "images/add_users.png' title='Edit' alt='Edit'   /> </a>";

                    tempList.Add(tempAction);

                    tempList.Add(obj["UpdatedBy"] + "");
                    tempList.Add(Numerics.GetDateTime(obj["UpdatedOn"] + "").ToString(AppSetting.dateFormat));
                    

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/MonthLockPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetEmployeeByMonthId
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetEmployeeByMonthId()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { " m.month_lock_detail_id", "e.employee_code", "e.name_" + languagePostfix, "o.description" + languagePostfix, "rivisons", "status",   "u.name_eng", "m.updated_date" };
                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getMonthRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("OrganizationID", (Request["org"] + "").Trim());
                ht.Add("ManagerID", (Request["mgr"] + "").Trim());
                ht.Add("ID", (Request["ID"] + "").Trim()); 
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_MonthLockOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getMonthCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("OrganizationID", (Request["org"] + "").Trim());
                ht.Add("ManagerID", (Request["mgr"] + "").Trim());
                ht.Add("ID", (Request["ID"] + "").Trim());  
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_MonthLockOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' empId='" + obj["employee_id"] + "' value='" + Numerics.GetDecimal(obj["month_lock_detail_id"]) + "' />");
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                    tempList.Add((obj["organization" + languagePostfix] + "").Length > 100 ? (obj["organization" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["organization" + languagePostfix] + ""));
                    tempList.Add(obj["rivisons"] + "");

                    string tempAction = "";
                    string tempAction1 = "";
                    if (Convert.ToBoolean(obj["status"] + "") == true)
                    {
                        tempAction = "<i class='icon-lock'></i>";
                        tempAction1 = "<a onclick='return PreSave(" + obj["month_lock_detail_id"] + ",\"unlock\");' href='javascript:void(0);' data-toggle='modal' class='btn blue'><i class='icon-unlock'></i></a>";
                    }
                    else
                    {
                        tempAction = "<i class='icon-unlock'></i>";
                        tempAction1 = "<a onclick='return PreSave(" + obj["month_lock_detail_id"] + ",\"lock\");' href='javascript:void(0);' data-toggle='modal' class='btn green'> <i class='icon-lock'></i></a>";

                    }
                    tempList.Add(tempAction);

                    //tempAction = "";
                    //tempAction = "<a href='" + Page.ResolveClientUrl("~/Freeze/Month-Lock-Details") + "/" + obj["month_lock_id"] + "" + "' > <img src='" + path + "images/add_users.png' title='Edit' alt='Edit'   /> </a>";

                    //tempList.Add(tempAction);

                    tempList.Add(obj["UpdatedBy"] + "");
                    tempList.Add(Numerics.GetDateTime(obj["UpdatedOn"] + "").ToString(AppSetting.dateFormat));
                    
                    tempList.Add(tempAction1);                     
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/MonthLockPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region LockByID
        /// <summary>
        /// FinalizeRoster function
        /// Finalize Roster by Manager ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string LockByID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            string result = "0";
            try
            {
                int temp = 0;

                Hashtable ht = new Hashtable();
                ht.Add("action", "lockByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", (Request["ID"] + "").Trim());

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MonthLockOps", ht);

                if (dv != null || dv.Count > 0)
                {
                    result = dv[0][0] + "";
                }
                else
                {
                    result = "-1";

                }

            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/MonthLockPage.aspx.UnFinalizeRoster()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return result;
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region UnlockByID
        /// <summary>
        /// FinalizeRoster function
        /// Finalize Roster by Manager ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string UnlockByID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            string result = "0";
            try
            { 
                int temp = 0;
                 
                    Hashtable ht = new Hashtable();
                    ht.Add("action", "unlockByID");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("ID", (Request["ID"] + "").Trim()); 

                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MonthLockOps", ht);

                    if (dv != null || dv.Count > 0)
                    {
                        result = dv[0][0] + "";
                    }
                    else
                    {
                        result = "-1";

                    }
                
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/MonthLockPage.aspx.UnFinalizeRoster()", 0, ex);
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
        public string DeleteByID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            { 
                string ids = Request["ID"] + ""; 
                ids = ids.TrimEnd(',');
                Hashtable ht = new Hashtable();
                ht.Add("action", "DeleteByIDs");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MonthLockOps", ht);
                if(dv != null)
                {
                    if (Convert.ToInt32(dv[0][0]) > 0)
                        return "1";
                    else
                        return "0";
                }
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/MonthLockPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
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

            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("Year", (Request["Year"] + "").Trim());
            ht.Add("Month", (Request["Month"] + "").Trim()); 

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_MonthLockOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/MonthLockPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

        #region LoadMonthNameByID

        protected string MonthNameByID(string monthID)
        {
            string MonthName = "";
            try
            {

                if (monthID == "1")
                    MonthName = "January";
                else if (monthID == "2")
                    MonthName = "Feburary";
                else if (monthID == "3")
                    MonthName = "March";
                else if (monthID == "4")
                    MonthName = "April";
                else if (monthID == "5")
                    MonthName = "May";
                else if (monthID == "6")
                    MonthName = "June";
                else if (monthID == "7")
                    MonthName = "July";
                else if (monthID == "8")
                    MonthName = "August";
                else if (monthID == "9")
                    MonthName = "September";
                else if (monthID == "October")
                    MonthName = "April";
                else if (monthID == "11")
                    MonthName = "November";
                else if (monthID == "12")
                    MonthName = "December";
            }
            catch (Exception ex)
            {
                
            }
            return MonthName;
        }

        #endregion
    }
}