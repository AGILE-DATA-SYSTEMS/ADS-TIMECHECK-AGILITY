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
    public partial class SchedulePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/SchedulePage.aspx"));


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
                if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "0" && (Request["empID"] + "").Trim() != "undefined")
                    data = GetAllEmployeeSchedules();
                else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "0" && (Request["groupID"] + "").Trim() != "undefined")
                    data = GetAllGroupSchedules();
                else if ((Request["orgID"] + "").Trim() != "" && (Request["orgID"] + "").Trim() != "undefined")
                    data = GetAllOrganizationSchedules();
                else
                {
                    JQueryResponse json = new JQueryResponse();
                    List<string> tempList = new List<string>();
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    tempList.Add(" &nbsp;");
                    json.aaData.Add(tempList);
                    data = new JavaScriptSerializer().Serialize(json);
                }
            }
            else if (Request["key"] + "" == "getByID")
            {
                if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "-1" && (Request["empID"] + "").Trim() != "0" && (Request["empID"] + "").Trim() != "undefined")
                    data = GetByEmployeeID();
                else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "-1" && (Request["groupID"] + "").Trim() != "0" && (Request["groupID"] + "").Trim() != "undefined")
                    data = GetByGroupID();
                else
                    if ((Request["orgID"] + "").Trim() != "" && (Request["orgID"] + "").Trim() != "undefined")
                        data = GetByOrganizationID();
            }
            else if (Request["key"] + "" == "getLabel")
            {
                if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "-1" && (Request["empID"] + "").Trim() != "0" && (Request["empID"] + "").Trim() != "undefined")
                    data = GetLabelByEmployeeID();
                else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "-1" && (Request["groupID"] + "").Trim() != "0" && (Request["groupID"] + "").Trim() != "undefined")
                    data = GetLabelByGroupID();
                else
                    if ((Request["orgID"] + "").Trim() != "" && (Request["orgID"] + "").Trim() != "undefined")
                        data = GetLabelByOrganizationID();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "-1" && (Request["empID"] + "").Trim() != "undefined")
                    data = DeleteByIDEmployeeSchedule();
                else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "-1" && (Request["groupID"] + "").Trim() != "undefined")
                    data = DeleteByIDGroupSchedule();
                else
                    if ((Request["orgID"] + "").Trim() != "" && (Request["orgID"] + "").Trim() != "undefined")
                        data = DeleteByIDOrganizationSchedule();
                
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


        #region GetByEmployeeID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByEmployeeID()
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
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeScheduleOps", ht);

                if (dv != null)
                {
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
                        obj.FromDateStr = obj.FromDate.ToString(AppSetting.dateFormat);
                    }
                    if ((dv[0]["to_date"] + "").Trim() != "")
                    {
                        obj.ToDate = Numerics.GetDateTime((dv[0]["to_date"] + "").Trim());
                        obj.ToDateStr = obj.ToDate.ToString(AppSetting.dateFormat);
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


        #region GetByGroupID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByGroupID()
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
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_GroupScheduleOps", ht);

                if (dv != null)
                {
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
                        obj.FromDateStr = obj.FromDate.ToString(AppSetting.dateFormat);
                    }
                    if ((dv[0]["to_date"] + "").Trim() != "")
                    {
                        obj.ToDate = Numerics.GetDateTime((dv[0]["to_date"] + "").Trim());
                        obj.ToDateStr = obj.ToDate.ToString(AppSetting.dateFormat);
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


        #region GetByOrganizationID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByOrganizationID()
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
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrganizationScheduleOps", ht);

                if (dv != null)
                {
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
                        obj.FromDateStr = obj.FromDate.ToString(AppSetting.dateFormat);
                    }
                    if ((dv[0]["to_date"] + "").Trim() != "")
                    {
                        obj.ToDate = Numerics.GetDateTime((dv[0]["to_date"] + "").Trim());
                        obj.ToDateStr = obj.ToDate.ToString(AppSetting.dateFormat);
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleOps", ht);

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


        #region DeleteByIDEmployeeSchedule
        /// <summary>
        /// DeleteByIDEmployeeSchedule function
        /// Delete schedule by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteByIDEmployeeSchedule()
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_EmployeeScheduleOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region DeleteByIDGroupSchedule
        /// <summary>
        /// DeleteByIDEmployeeSchedule function
        /// Delete schedule by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteByIDGroupSchedule()
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_GroupScheduleOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region DeleteByIDOrganizationSchedule
        /// <summary>
        /// DeleteByIDOrganizationSchedule function
        /// Delete schedule by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteByIDOrganizationSchedule()
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_OrganizationScheduleOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ScheduleOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllOrganizationSchedules
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllOrganizationSchedules()
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

                string[] cols = { "organization_schedule_id", "from_date", "to_date", "s7.schedule_code", "s2.schedule_code", "s2.schedule_code", "s3.schedule_code", "s4.schedule_code", "s5.schedule_code", "s6.schedule_code", "organization_schedule_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_OrganizationScheduleOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_OrganizationScheduleOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["organization_schedule_id"]) + "' />");
                    if ((obj["from_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("");
                    if ((obj["to_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("");
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
                    //tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_ORG_SCHEDULE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["organization_schedule_id"]) + ")' /> &nbsp; ";
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
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllGroupSchedules
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllGroupSchedules()
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

                string[] cols = { "group_schedule_id", "from_date", "to_date", "s7.schedule_code", "s2.schedule_code", "s2.schedule_code", "s3.schedule_code", "s4.schedule_code", "s5.schedule_code", "s6.schedule_code", "group_schedule_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_GroupScheduleOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_GroupScheduleOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["group_schedule_id"]) + "' />");
                    if ((obj["from_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("");
                    if ((obj["to_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("");
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
                    //tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_GRP_SCHEDULE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["group_schedule_id"]) + ")' /> &nbsp; ";
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
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAllEmployeeSchedules
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllEmployeeSchedules()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "employee_schedule_id", "from_date", "to_date", "s7.schedule_code", "s2.schedule_code", "s2.schedule_code", "s3.schedule_code", "s4.schedule_code", "s5.schedule_code", "s6.schedule_code", "employee_schedule_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("empID", Request["empID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmployeeScheduleOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("empID", Request["empID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeScheduleOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                List<string> tempList = new List<string>();
                foreach (DataRowView obj in objDataView)
                {
                    tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["employee_schedule_id"]) + "' />");
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
                    //tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_EMP_SCHEDULE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["employee_schedule_id"]) + ")' /> &nbsp; ";
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
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region GetLabelByEmployeeID
        /// <summary>
        /// GetLabelByEmployeeID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetLabelByEmployeeID()
        {
            string str = "&nbsp;";
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            EmployeeGroup obj = new EmployeeGroup();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["empID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);
                
                string scheduleForEmployee = (String)GetGlobalResourceObject("Resource", "scheduleForEmployee");
                if (dv != null)
                {
                    obj.Code = dv[0]["employee_code"] + "";
                    obj.NameEn = dv[0]["name_eng"] + "";
                    obj.NameAr = dv[0]["name_arb"] + "";

                    if (cookie.Values["language"] == "ar")
                        str = scheduleForEmployee + " \"" + obj.NameAr + "\"";
                    else
                        str = scheduleForEmployee + " \"" + obj.NameEn + "\"";
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return str;
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region GetLabelByGroupID
        /// <summary>
        /// GetLabelByGroupID function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetLabelByGroupID()
        {
            string str = "&nbsp;";
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            EmployeeGroup obj = new EmployeeGroup();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["groupID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpGroupOps", ht);
                
                string scheduleForGroup = (String)GetGlobalResourceObject("Resource", "scheduleForGroup");
                if (dv != null)
                {
                    obj.Code = dv[0]["group_code"] + "";
                    obj.NameEn = dv[0]["group_name_eng"] + "";
                    obj.NameAr = dv[0]["group_name_arb"] + "";

                    if (cookie.Values["language"] == "ar")
                        str = scheduleForGroup + " \"" + obj.NameAr + "\"";
                    else
                        str = scheduleForGroup + " \"" + obj.NameEn + "\"";
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return str;
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region GetLabelByOrganizationID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetLabelByOrganizationID()
        {
            string str = "&nbsp;";
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            ObjectClasses.Org obj = new ObjectClasses.Org();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["orgID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string scheduleForOrg = (String)GetGlobalResourceObject("Resource", "scheduleForOrg");
                if (dv != null)
                {
                    obj.Code = dv[0]["code"] + "";
                    obj.DescriptionEn = dv[0]["description_Eng"] + "";
                    obj.DescriptionAr = dv[0]["description_Arb"] + "";

                    if (cookie.Values["language"] == "ar")
                        str = scheduleForOrg + " \"" + obj.DescriptionAr + "\"";
                    else
                        str = scheduleForOrg + " \"" + obj.DescriptionEn + "\"";
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return str;
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

                string[] cols = { "country_id", "code", "description" + languagePostfix, "last_updated_date", "country_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("empID", Request["empID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", Request["orgID"] + "");
                ht.Add("groupID", Request["groupID"] + "");
                ht.Add("empID", Request["empID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["country_id"]) + "' />");
                    tempList.Add(obj["code"] + "");
                    tempList.Add((obj["description" + languagePostfix] + "").Length > 100 ? (obj["description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["description" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_SCHEDULE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["country_id"]) + ");' /> &nbsp; ";
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
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.GerAll()", 0, ex);
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
            ht.Add("ID", Request["id"] + "");
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
                if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "0" && (Request["empID"] + "").Trim() != "-1")
                {
                    ht.Add("empID", (Request["empID"] + "").Trim());
                    result = objDAL.Connection.GetValueProcedure("TAMSR2_EmployeeScheduleOps", ht);
                }
                else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "0" && (Request["groupID"] + "").Trim() != "-1")
                {
                    ht.Add("groupID", (Request["groupID"] + "").Trim());
                    result = objDAL.Connection.GetValueProcedure("TAMSR2_GroupScheduleOps", ht);
                }
                else
                    if ((Request["orgID"] + "").Trim() != "")
                    {
                        ht.Add("orgID", (Request["orgID"] + "").Trim());
                        result = objDAL.Connection.GetValueProcedure("TAMSR2_OrganizationScheduleOps", ht);
                    }
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result;
                }
                else
                {
                    chk = Numerics.GetDecimal(result) + "";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SchedulePage.aspx.Save()", 0, ex);
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