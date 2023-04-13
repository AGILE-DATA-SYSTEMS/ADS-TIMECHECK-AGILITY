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
    public partial class EmployeeGroupPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/EmployeeGroupPage.aspx"));

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
            string id = "0";
            try
            {
                id = Encryption.Decrypt((Request["id"] + "").Trim());
            }
            catch (Exception ex)
            {
                id = (Request["id"] + "").Trim();
            }
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            EmployeeGroup obj = new EmployeeGroup();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpGroupOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["employee_group_id"]);
                    obj.Code = dv[0]["group_code"] + "";
                    obj.DescriptionEn = dv[0]["group_name_eng"] + "";
                    obj.DescriptionAr = dv[0]["group_name_arb"] + "";
                    obj.ScheduleFlag = Numerics.GetBool(dv[0]["schedule_flag"] + "");
                    if (obj.ScheduleFlag)
                    {
                        obj.FromDate = Numerics.GetDateTime(dv[0]["from_date"]);
                        obj.FromDateStr = obj.FromDate.ToString("yyyy-MM-dd");
                        obj.ToDate = Numerics.GetDateTime(dv[0]["to_date"]);
                        obj.ToDateStr = obj.ToDate.ToString("yyyy-MM-dd");
                    }
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_date"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["last_updated_id"]);
                    obj.ReportFlag = Numerics.GetBool(dv[0]["reporting_group_flag"]);
                    if(obj.ReportFlag)
                        obj.EmployeeID = Numerics.GetInt(dv[0]["employee_id"]);
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpGroupOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeGroup = (String)GetGlobalResourceObject("Resource", "employeeGroup");

                sb.Append("<option value=''>" + chooseStr + " " + employeeGroup + "</option>");

                foreach (DataRowView row in dv)
                {
                    EmployeeType obj = new EmployeeType();
                    obj.ID = Numerics.GetDecimal(row["employee_group_id"] + "");
                    obj.Code = row["group_code"] + "";
                    obj.DescriptionEn = row["group_name_eng"] + "";
                    obj.DescriptionAr = row["group_name_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "' EmployeesCount='" + row["EmployeesCount"] + "" + "'>" + obj.Code + " - " + obj.DescriptionAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "' EmployeesCount='" + row["EmployeesCount"] + "" + "'>" + obj.Code + " - " + obj.DescriptionEn + "  </option>");
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmpGroupOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeGroupPage.aspx.DeleteByID()", 0, ex);
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
                string employees = (String)GetGlobalResourceObject("Resource", "employees");
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "employee_group_id", "group_code", "group_name" + languagePostfix, "grpType.last_updated_date", "employee_group_id", "employee_group_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpGroupOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmpGroupOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if ((obj["group_code"] + "").ToUpper() == "SENIORS" || Numerics.GetDecimal(obj["employee_group_id"] + "") <= 2)
                        tempList.Add(" &nbsp;");
                    else
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_group_id"]) + "' />");

                    tempList.Add(obj["group_code"] + "");
                    tempList.Add((obj["group_name" + languagePostfix] + "").Length > 100 ? (obj["group_name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["group_name" + languagePostfix] + ""));

                    if (Numerics.GetBool(obj["schedule_flag"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    tempList.Add(Numerics.GetBool(obj["schedule_flag"] + "") == true ? Numerics.GetDateTime(obj["From_Date"] + "").ToString(AppSetting.dateFormat) : "");
                    tempList.Add(Numerics.GetBool(obj["schedule_flag"] + "") == true ? Numerics.GetDateTime(obj["To_Date"] + "").ToString(AppSetting.dateFormat) : "");


                    if (Numerics.GetBool(obj["reporting_group_flag"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    tempList.Add(obj["name_eng"] + "");
                    tempList.Add("&nbsp; &nbsp; <a style='text-decoration: none;' href='" + path + "Emp/Assign-Employees-To-Groups/" +
                                        Encryption.Encrypt(obj["employee_group_id"] + "") + "/" + Encryption.Encrypt(obj["group_name" + languagePostfix] + "") + "'>" +
                                        "<img src='" + path + "images/add_users.png' title='" + employees + "' alt='" + employees + "' /> &nbsp; </a>"
                    );
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));


                    string tempAction = "";
                    tempAction = "";
                    if ((obj["group_code"] + "").ToUpper() == "SENIORS" || Numerics.GetDecimal(obj["employee_group_id"] + "") <= 2)
                        tempList.Add(" &nbsp;");
                    else
                        if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_GROUP) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempList.Add("&nbsp; <a style='text-decoration: none;' href='" + path + "Emp/Save-Employee-Group/" +
                                            Encryption.Encrypt(obj["employee_group_id"] + "") + "'>" +
                                            "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a>"
                        );

                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["employee_group_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmployeeGroupPage.aspx.GerAll()", 0, ex);
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
            string scheduleFlag = "0";
            string reportFlag = "0";
            string employeeId = "";
            string fromDate = "";
            string toDate = "";

            try
            {
                id = Encryption.Decrypt((Request["id"] + "").Trim());
            }
            catch (Exception ex)
            {
                id = (Request["id"] + "").Trim();
            }
            if ((Request["schFlag"] + "").Trim() == "" || (Request["schFlag"] + "").Trim().ToLower() == "false")
            {
                scheduleFlag = "0";
            }
            else
            {
                scheduleFlag = "1";

                fromDate = ((Request["fromDate"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["fromDate"] + "";
                toDate = ((Request["toDate"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["toDate"] + "";

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
            }
            if ((Request["rptFlag"] + "").Trim() == "" || (Request["rptFlag"] + "").Trim().ToLower() == "false")
            {
                reportFlag = "0";
            }
            else
            {
                reportFlag = "1";
                employeeId = Request["empID"] + "";
            }
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", id);
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("descriptionEng", (Request["descriptionEn"] + "").Trim());
            ht.Add("descriptionArb", (Request["descriptionAr"] + "").Trim());
            ht.Add("schFlag", scheduleFlag);
            ht.Add("fromDate", fromDate);
            ht.Add("toDate", toDate);

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");
            ht.Add("reportFlag", reportFlag);
            ht.Add("employeeId", employeeId);

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_EmpGroupOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/EmployeeGroupPage.aspx.Save()", 0, ex);
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