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
    public partial class RolePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/RolePage.aspx"));


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
            else if (Request["key"] + "" == "saveAssignUsers")
            {
                data = SaveAssignUsers();
            }
            else if (Request["key"] + "" == "saveRemoveUsers")
            {
                data = SaveRemoveUsers();
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
            Role obj = new Role();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_RoleOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["role_id"]);
                    obj.NameEn = dv[0]["role_name"] + "";
                    obj.NameAr = dv[0]["role_name"] + "";
                    obj.EditableFlag = Numerics.GetInt(dv[0]["editable_flag"]);
                    obj.PrivilegeFlag = Numerics.GetInt(dv[0]["privilege_flag"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_time"]);
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_RoleOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgTypeStr = (String)GetGlobalResourceObject("Resource", "organizationType");

                sb.Append("<option value=''>" + chooseStr + " " + orgTypeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Role obj = new Role();
                    obj.ID = Numerics.GetDecimal(row["role_id"] + "");
                    obj.NameEn = row["role_name"] + "";
                    obj.NameAr = row["role_name"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameAr + "  </option>");
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_RoleOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/RolePage.aspx.DeleteByID()", 0, ex);
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

                string[] cols = { "sr.role_id", "role_name", "role_name", "role_name", "role_name", "role_name", "role_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string users = (String)GetGlobalResourceObject("Resource", "users");
                string privileges = (String)GetGlobalResourceObject("Resource", "privileges");

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_RoleOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_RoleOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if (Numerics.GetInt(obj["privilege_flag"] + "") == 1 && Numerics.GetInt(obj["editable_flag"] + "") == 1)
                    {
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["role_id"]) + "' />");
                    }
                    else
                    {
                        tempList.Add("");
                    }
                    tempList.Add((obj["role_name"] + "").Length > 100 ? (obj["role_name"] + "").Substring(0, 100) + "..." : (obj["role_name"] + ""));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.CONFIGURE_ROLE) == true && Numerics.GetInt(obj["privilege_flag"] + "") == 1)
                    {
                        tempAction = "<span style='cursor: pointer; text-decoration: underline; color: blue;' title='" + privileges + "' alt='" + privileges + "' onclick='return AssignPrivileges(" + Numerics.GetDecimal(obj["role_id"]) + ", \"" + (obj["role_name"] + "").Trim() + "\" );' >" + privileges + "</span> &nbsp; ";
                    }
                    tempList.Add(tempAction);

                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.ASSIGN_ROLE) == true && Numerics.GetInt(obj["privilege_flag"] + "") == 1 || 1 == 1)
                    {
                        tempAction = "<span style='cursor: pointer; text-decoration: underline; color: blue;' title='" + users + "' alt='" + users + "' onclick='return AssignUsers(" + Numerics.GetDecimal(obj["role_id"]) + ", \"" + (obj["role_name"] + "").Trim() + "\" );' >" + users + "</span> &nbsp; ";
                    }
                    tempList.Add(tempAction);

                    tempList.Add(obj["totalUsers"] + "");

                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_GRADE) == true && Numerics.GetInt(obj["editable_flag"] + "") == 1)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["role_id"]) + ");' /> &nbsp; ";
                    }
                    tempList.Add(tempAction);
                    
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/RolePage.aspx.GerAll()", 0, ex);
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
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("nameEn", (Request["nameEn"] + "").Trim());
            ht.Add("nameAr", (Request["nameAr"] + "").Trim());
            ht.Add("editableFlag", 1);
            ht.Add("privilegeFlag", 1);

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_RoleOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/RolePage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region SaveAssignUsers
        /// <summary>
        /// saveAssignUsers function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveAssignUsers()
        {
            string toUsersList = (Request["toUser"] + "").Trim();
            toUsersList = toUsersList.Substring(0, toUsersList.LastIndexOf(',') + 1);
            int toUserListLength = toUsersList.Length;
            string temptoUsersList = toUsersList;

            string chk = "0";
            int tempIndex = 0;
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                Hashtable ht = new Hashtable();
                while (temptoUsersList.Contains(',')) // temptoUsersList.IndexOf(',', 3000) > 0)
                {
                    if (toUsersList.Length > 3000)
                    {
                        tempIndex = toUsersList.IndexOf(',', 3000);
                        temptoUsersList = toUsersList.Substring(0, tempIndex);
                        toUsersList = toUsersList.Replace(temptoUsersList, "");
                    }
                    else
                    {
                        temptoUsersList = toUsersList;
                        toUsersList = toUsersList.Replace(temptoUsersList, "");
                    }

                    objDAL = new TAMSR2Data();
                    ht = new Hashtable();
                    ht.Add("action", "saveAssignUsers");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("roleID", (Request["roleID"] + "").Trim());
                    ht.Add("toUserList", temptoUsersList);
                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    try
                    {
                        string result = objDAL.Connection.GetValueProcedureMaxLength("TAMSR2_RoleOps", ht, true);
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
                        new ExceptionLog().WriteLog("RequestPages/RolePage.aspx.Save()", 0, ex);
                    }
                    finally
                    {
                        objDAL.CloseConnection();
                    }
                }

            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/RolePage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region SaveRemoveUsers
        /// <summary>
        /// saveAssignUsers function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveRemoveUsers()
        {
            string fromUsersList = (Request["fromUser"] + "").Trim();
            fromUsersList = fromUsersList.Substring(0, fromUsersList.LastIndexOf(',') + 1);
            int fromUserListLength = fromUsersList.Length;
            string tempfromUsersList = fromUsersList;

            string chk = "0";
            int tempIndex = 0;
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                Hashtable ht = new Hashtable();
                while (tempfromUsersList.Contains(',')) // temptoUsersList.IndexOf(',', 3000) > 0)
                {
                    if (fromUsersList.Length > 3000)
                    {
                        tempIndex = fromUsersList.IndexOf(',', 3000);
                        tempfromUsersList = fromUsersList.Substring(0, tempIndex);
                        fromUsersList = fromUsersList.Replace(tempfromUsersList, "");
                    }
                    else
                    {
                        tempfromUsersList = fromUsersList;
                        fromUsersList = fromUsersList.Replace(tempfromUsersList, "");
                    }
                    objDAL = new TAMSR2Data();
                    ht = new Hashtable();
                    ht.Add("action", "saveRemoveUsers");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("roleID", (Request["roleID"] + "").Trim());
                    ht.Add("fromUserList", tempfromUsersList);
                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    try
                    {
                        string result = objDAL.Connection.GetValueProcedureMaxLength("TAMSR2_RoleOps", ht, true);
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
                        new ExceptionLog().WriteLog("RequestPages/RolePage.aspx.Save()", 0, ex);
                    }
                    finally
                    {
                        objDAL.CloseConnection();
                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/RolePage.aspx.Save()", 0, ex);
            }
            finally
            {
                //objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

    }
}