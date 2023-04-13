using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
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
    public partial class AppSettingPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/AppSettingPage.aspx"));


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
            else if (Request["key"] + "" == "getRestDays")
            {
                data = GetRestDaysFromAppSetting();
            }
            else if (Request["key"] + "" == "getAll")
            {
                data = GetALL();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByName();
            }
            else if (Request["key"] + "" == "getByTab")
            {
                data = GetByTab();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if (Request["key"] + "" == "save")
            {
                data = Save();
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


        #region GetRestDaysFromAppSetting
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetRestDaysFromAppSetting()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Schedule obj = new Schedule();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByName");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("vname", "RestDays");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    string temp = (dv[0]["value"] + "").Trim();
                    if (temp != "")
                    {
                        string[] arr = temp.Trim().ToLower().Split(',');
                        if (arr.Contains("sunday"))
                            obj.Sunday = 1;
                        if (arr.Contains("monday"))
                            obj.Monday = 1;
                        if (arr.Contains("tuesday"))
                            obj.Tuesday = 1;
                        if (arr.Contains("wednesday"))
                            obj.Wednesday = 1;
                        if (arr.Contains("thursday"))
                            obj.Thursday = 1;
                        if (arr.Contains("friday"))
                            obj.Friday = 1;
                        if (arr.Contains("saturday"))
                            obj.Saturday = 1;
                    }
                    //obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    //obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    //obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_date"]);
                    //obj.UpdatedBy = Numerics.GetDecimal(dv[0]["last_updated_id"]);

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


        #region GetAllAppSettings
        public string GetALL()
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

                string[] cols = { "vname", "vname", "value", "Tab_no", "Descr" ,"updated_id", "updated_date" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_AppSettingOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" +(obj["Vname"]) + "' />");
                    tempList.Add(obj["Vname"] + "");
                    tempList.Add(obj["value"] + "");
                    tempList.Add((obj["Tab_no"] + ""));
                    tempList.Add((obj["Descr"] + ""));
                    tempList.Add((obj["name_eng"] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["Updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_APPLICATION_SETTINGS) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(&#39;" + obj["Vname"] + "" + "&#39;);' /> &nbsp; ";
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
                new ExceptionLog().WriteLog("RequestPages/AppSettingPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
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
                string vname = Request["vname"] + "";
                
                Hashtable ht = new Hashtable();
                ht.Add("action", "deleteByName");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("vname", vname);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_AppSettingOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/AppSettingPage.aspx.DeleteByID()", 0, ex);
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
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByName()
        {

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DBAppSetting obj = new DBAppSetting();
            
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByName");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("vname", Request["vname"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {
                    obj.Name = dv[0]["vname"] + "";
                    obj.Value = dv[0]["value"] + "";
                    obj.TabNo = Convert.ToInt32(dv[0]["tab_no"] + "");
                    obj.Descr = dv[0]["descr"] + "";
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["updated_date"]);
                    obj.Updated_By_name = dv[0]["name_eng"] + "";
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
        //*********End Of GetBy Name Function*********//
        #endregion

        #region GetByTab
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByTab()
        {

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DBAppSetting obj = new DBAppSetting();
            JQueryResponse json = new JQueryResponse();
            

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "vname", "vname", "value", "deleted", "Descr", "updated_id", "updated_date" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("tabNo", Request["tabno"] + "");
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", ht);

                if (dv != null)
                {

                    json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                    ht = new Hashtable();
                    ht.Add("action", "getCount");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                    ht.Add("tabNo", Request["tabno"] + "");
                    ht.Add("orderBy", orderByClause);
                    json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_AppSettingOps", ht));
                    json.iTotalDisplayRecords = json.iTotalRecords;

                    foreach (DataRowView objj in dv)
                    {
                        List<string> tempList = new List<string>();
                        if (Numerics.GetInt(objj["deleted"] + "") == 1)
                            tempList.Add("<input type='checkbox' class='checkboxes' value='" + (objj["Vname"]) + "' />");
                        else
                            tempList.Add("&nbsp;");
                        tempList.Add(objj["Vname"] + "");
                        tempList.Add(objj["value"] + "");
                        if (Numerics.GetInt(objj["deleted"] + "") == 1)
                            tempList.Add("<i class='icon-ok'></i>");
                        else
                            tempList.Add("<i class='icon-remove'></i>");
                        tempList.Add((objj["Descr"] + ""));
                        tempList.Add((objj["name_eng"] + ""));
                        tempList.Add(Numerics.GetDateTime(objj["Updated_date"] + "").ToString(AppSetting.dateFormat));
                        string tempAction = "";
                        tempAction = "";
                        if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_APPLICATION_SETTINGS) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                        {
                            tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(&#39;" + objj["Vname"] + "" + "&#39;);' /> &nbsp; ";
                        }
                        if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                        {
                            //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["country_id"]) + ")' /> ";
                        }
                        tempList.Add(tempAction);
                        json.aaData.Add(tempList);
                    }
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetBy Name Function*********//
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
            ht.Add("vname", (Request["vname"] + "").Trim().ToUpper());
            ht.Add("value", (Request["value"] + "").Trim());
            ht.Add("tabNo", (Request["tab_no"] + "").Trim());
            ht.Add("deleted", 1);
            ht.Add("descr", (Request["descr"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_AppSettingOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/AppSettingPage.aspx.Save()", 0, ex);
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