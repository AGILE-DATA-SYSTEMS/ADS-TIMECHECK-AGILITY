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
    public partial class DeptAdminPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/DeptAdminPage.aspx"));


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
            else if (Request["key"] + "" == "getEmployeeDeptAdmin")
            {
                data = GetEmployeeDeptAdminList();
            }
            else if (Request["key"] + "" == "getEmployeeNotDeptAdmin")
            {
                data = GetEmployeeNotInDeptAdminList();
            }
            else if (Request["key"] + "" == "GetSelectedDeptList")
            {
                data = GetSelectedDeptList();
            }
            else if (Request["key"] + "" == "GetSelectedEmployeeList")
            {
                data = GetSelectedEmployeeList();
            }
            else if (Request["key"] + "" == "save")
            {
                data = Save();
            }
            else if (Request["key"] + "" == "viewDeptAdminOrganizations")
            {
                data = ViewDeptAdminOrganizations();
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
                ObjDataview =   objDAL.Connection.ExecuteProcedure("TAMSR2_DeptAdminsOps", ht);
                int temp = Convert.ToInt32(ObjDataview[0].Row[0].ToString()); // objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_DeptAdminsOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DeptAdminPage.aspx.DeleteByID()", 0, ex);
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
        /// DeleteByID function
        /// Delete user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string GetByID()
        {

            string organizations = (String)GetGlobalResourceObject("Resource", "organizations");
            string delegatestr = (String)GetGlobalResourceObject("Resource", "delegateStr");
            string edit = (String)GetGlobalResourceObject("Resource", "edit");
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            StringBuilder sb = new StringBuilder();
            DeptAdmin objDpt    = new DeptAdmin();
            try
            {
                string deptAdminID = Encryption.Decrypt((Request["id"] + "").Trim());

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", deptAdminID);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DeptAdminsOps", ht);
                List<string> templist = new List<string>();
                foreach (DataRowView row in objDataView)
                {
                    objDpt.ID = Convert.ToInt32(row["ID"] + "");
                    objDpt.EmployeeID = Convert.ToInt32(row["employee_code"] + "");
                    objDpt.EmployeeCode = row["employee_code"] + "";
                    objDpt.EmployeeName_Eng = row["name_eng"] + "";
                    objDpt.EmployeeName_Arb = row["name_arb"] + "";


                    objDpt.FromDate = Numerics.GetDateTime(row["from_date"] + "");
                    objDpt.ToDate = Numerics.GetDateTime(row["to_date"] + "");

                    objDpt.FromDateStr = (row["from_date"] + "").Trim() != "" ? objDpt.FromDate.ToString("yyyy-MM-dd") : "";
                    objDpt.ToDateStr = (row["to_date"] + "" ).Trim() != "" ? objDpt.ToDate.ToString("yyyy-MM-dd") : "";
                    objDpt.Status = row["status"] + "";
                    objDpt.remarks = row["remarks"] + "";
                    objDpt.OrgID = Convert.ToInt32(row["organization_id"] + "");
                    objDpt.Description_Eng = row["description_eng"] + "";
                    objDpt.Description_Arb = row["description_arb"] + "";
                }
                 
                
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DeptAdminPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(objDpt);
        }
        //*********End Of GetAll Function*********//
        #endregion
        
        #region GetSelectedDeptList

        public string GetSelectedDeptList()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                string deptAdminID = Encryption.Decrypt((Request["id"] + "").Trim());

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", deptAdminID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DeptAdminsOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                
                foreach (DataRowView row in dv)
                {
                    DeptAdmin obj = new DeptAdmin();
                    obj.OrgID = Convert.ToInt32(row["organization_id"] + "");
                    obj.Description_Eng = row["description_eng"] + "";
                    obj.Description_Arb = row["description_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.OrgID + "'>" + obj.Description_Arb + " </option>");
                    else
                        sb.Append("<option value='" + obj.OrgID + "'>" + obj.Description_Eng + "  </option>");
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

        #region GetSelectedEmployeeList

        public string GetSelectedEmployeeList()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                string deptAdminID = Encryption.Decrypt((Request["id"] + "").Trim());

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", deptAdminID);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DeptAdminsOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");
                string EmpName = "";

                foreach (DataRowView row in dv)
                {
                    DeptAdmin obj = new DeptAdmin();
                    obj.EmployeeID = Convert.ToInt32(row["employee_id"] + "");
                    obj.EmployeeCode = row["employee_code"] + "";
                    obj.EmployeeName_Eng = row["name_eng"] + "";
                    obj.EmployeeName_Arb = row["name_arb"] + "";
                    if (EmpName != obj.EmployeeName_Eng)
                    {
                        if (cookie.Values["language"] == "ar")
                            sb.Append("<option value='" + obj.EmployeeID + "'>" + obj.EmployeeCode + " - " + obj.EmployeeName_Arb + " </option>");
                        else
                            sb.Append("<option value='" + obj.EmployeeID + "'>" + obj.EmployeeCode + " - " + obj.EmployeeName_Eng + "  </option>");
                    }
                        EmpName = obj.EmployeeName_Eng;
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


        #region GetEmployeeDeptAdminList
        /// <summary>
        /// GetIdNameListStringByOrgID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetEmployeeDeptAdminList()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getEmployeeDeptAdminList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DeptAdminsOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
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




        #region GetEmployeeNotInDeptAdminList
        /// <summary>
        /// GetIdNameListStringByOrgID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetEmployeeNotInDeptAdminList()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            string orgID = (Request["orgID"] + "").Trim();
            if (orgID == "" || orgID == "undefined")
                orgID = "-1";

            string SearchFilter = (Request["SearchFilter"] + "").Trim();
            if (SearchFilter == "" || SearchFilter == "undefined")
                SearchFilter = "";

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getEmployeeNotInDeptAdminList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", orgID);
                ht.Add("searchInput", SearchFilter + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DeptAdminsOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
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
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DeptAdminsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_DeptAdminsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();

                    if (Numerics.GetBool(obj["CanDelete"]) == true || obj["created_id"] + "" == Session["ID"] + "")
                    {
                        tempList.Add("<input type='checkbox' class='checkboxes'  value='" + Numerics.GetDecimal(obj["dept_admin_id"]) + "' />");
                    }
                    else
                    {
                        tempList.Add(" &nbsp;");
                    }
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));

                    tempList.Add("<img style='width: 32px; height: 32px; cursor: pointer; text-decoration: none;' src='" + path + "images/features.png' onclick='return ViewDeptAdminOrganizations(" + Numerics.GetDecimal(obj["dept_admin_id"]) + ");' title='" + organizations + "' alt='" + organizations + "' /> &nbsp; </a>");

                    tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));

                    if (Numerics.GetBool(obj["status"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    tempList.Add((obj["Created_Name" + languagePostfix] + "").Length > 100 ? (obj["Created_Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Created_Name" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if ((obj["created_id"] + "" == Session["ID"] + "" && new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_DEPT_ADMIN) == true) || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<a href='" + Page.ResolveClientUrl("~/Emp/Save-Department-Admins/" + Encryption.Encrypt((obj["dept_admin_id"] + "").Trim())) + "' >";
                        tempAction += "<img src='" + path + "images/edit.png' title='" + edit + "' alt='" + edit + "' /></a> ";
                    }
                  //  tempAction = "<a href='" + Page.ResolveClientUrl("~/Emp/Save-Department-Admins/" + Encryption.Encrypt((obj["dept_admin_id"] + "").Trim())) + "' >";
                    if (Numerics.GetBool(obj["status"] + "") == true)
                     tempAction += " &nbsp;&nbsp; <img src='" + path + "images/transfer-left-right.png' title='" + delegatestr + "' alt='" + delegatestr + "' onclick='return TransferDeptAdminOrganizations(" + Numerics.GetDecimal(obj["dept_admin_id"]) + ");' /> &nbsp; ";
                    else
                        tempAction += " &nbsp; ";

                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DeptAdminPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion




        #region ViewDeptAdminOrganizations
        /// <summary>
        /// ViewDeptAdminOrganizations function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string ViewDeptAdminOrganizations()
        {
            string id = "0";
            StringBuilder sb = new StringBuilder();
            try
            {
                id = Encryption.Decrypt(Request["dID"] + "");
            }
            catch (Exception ex)
            {
                id = (Request["dID"] + "").Trim();
                if (id == "undefined")
                    id = "0";
            }
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "ViewDeptAdminOrganizationsByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DeptAdminsOps", ht);

                foreach (DataRowView obj in dv)
                {
                    sb.Append("<li style=''>");
                    sb.Append(obj["description" + languagePostfix] + "");
                    sb.Append("</li>");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            if (sb.ToString() == "")
                return " &nbsp; ";
            else
                return "<ol>" + sb.ToString() + "</ol>";
        }
        //*********End Of ViewDeptAdminOrganizations Function*********//
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
            int status = 0;
            if ((Request["status"] + "").Trim().ToLower() == "true") // && Session["ID"] + "" != Request["empID"] + "" && new DBAppSetting().GetAutoLeaveApproval(Session["ID"] + "", Connection.GetUserConnectionStrinng()) == false)
                status = 1;
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
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", id);
            ht.Add("employeeID", (Request["empID"] + "").Trim());
            ht.Add("orgID", (Request["orgID"] + "").Trim());
            ht.Add("fromDate", fromDate);
            ht.Add("toDate", toDate);
            ht.Add("status", status);
            ht.Add("remarks", (Request["remarks"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_DeptAdminsOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/EmployeeLeavePage.aspx.Save()", 0, ex);
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