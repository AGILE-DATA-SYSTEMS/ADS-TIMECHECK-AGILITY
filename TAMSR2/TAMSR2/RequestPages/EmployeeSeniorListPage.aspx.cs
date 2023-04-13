using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Text;
using System.Collections;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.RequestPages
{
    public partial class EmployeeSeniorListPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/EmployeeSeniorListPage.aspx"));


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
               // data = GetByID();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }

            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Write(data);
            Response.Flush();
        }




        #region GetAll
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAll()
        {
            string organizations = (String)GetGlobalResourceObject("Resource", "organizations");
            string delegatestr = (String)GetGlobalResourceObject("Resource", "delegateStr");
            string edit = (String)GetGlobalResourceObject("Resource", "edit");
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

                string[] cols = { "dpt.dept_admin_id", "emp.employee_code", "emp.name" + languagePostfix, "dpt.from_date", "dpt.to_date", "dpt.status", "empdlg.name" + languagePostfix, "dpt.updated_date", "dpt.dept_admin_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeSeniorListOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeSeniorListOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();


                    tempList.Add("<input type='checkbox' class='checkboxes'  value='" + Numerics.GetDecimal(obj["employee_senior_id"]) + "' />");
                    
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));

                    tempList.Add(Numerics.GetDateTime(obj["join_date"] + "").ToString(AppSetting.dateFormat));
                    
                    if (Numerics.GetBool(obj["manager_flag"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    if (Numerics.GetBool(obj["punch_flag"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    if (Numerics.GetBool(obj["status_flag"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    tempList.Add((obj["Designation" + languagePostfix] + "").Length > 100 ? (obj["Designation" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Designation" + languagePostfix] + ""));
                    tempList.Add((obj["Organization" + languagePostfix] + "").Length > 100 ? (obj["Organization" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Organization" + languagePostfix] + ""));
                    tempList.Add((obj["ManagerName" + languagePostfix] + "").Length > 100 ? (obj["ManagerName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["ManagerName" + languagePostfix] + ""));

                    //tempList.Add((obj["Created_Name" + languagePostfix] + "").Length > 100 ? (obj["Created_Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Created_Name" + languagePostfix] + ""));
                    //tempList.Add(Numerics.GetDateTime(obj["updated_date"] + "").ToString(AppSetting.dateFormat));
                    //string tempAction = "";
                    //tempAction = "";
                    //if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_GRADE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    //{
                    //    tempAction = "<a href='" + Page.ResolveClientUrl("~/Emp/Save-Department-Admins/" + Encryption.Encrypt((obj["dept_admin_id"] + "").Trim())) + "' >";
                    //    tempAction += "<img src='" + path + "images/edit.png' title='" + edit + "' alt='" + edit + "' /></a> ";
                    //}
                    //tempAction = "<a href='" + Page.ResolveClientUrl("~/Emp/Save-Department-Admins/" + Encryption.Encrypt((obj["employee_senior_id"] + "").Trim())) + "' >";
                    //if (Numerics.GetBool(obj["status"] + "") == true)
                    //    tempAction += " &nbsp;&nbsp; <img src='" + path + "images/transfer-left-right.png' title='" + delegatestr + "' alt='" + delegatestr + "' onclick='return TransferDeptAdminOrganizations(" + Numerics.GetDecimal(obj["dept_admin_id"]) + ");' /> &nbsp; ";
                    //else
                    //    tempAction += " &nbsp; ";

                    //tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeSeniorListPage.aspx.GetAll()", 0, ex);
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
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("employeeID", (Request["empID"] + "").Trim());
            
            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeSeniorListOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/TAMSR2_EmployeeSeniorListPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
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
            DataView ObjDataview = new DataView();
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
                ObjDataview = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeSeniorListOps", ht);
                int temp = Convert.ToInt32(ObjDataview[0].Row[0].ToString()); // objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_DeptAdminsOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/TAMSR2_EmployeeSeniorListPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion

    }
}