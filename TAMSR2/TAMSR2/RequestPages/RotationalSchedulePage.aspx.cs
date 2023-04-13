using Newtonsoft.Json;
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
    public partial class RotationalSchedulePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/RotationalSchedulePage.aspx"));


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
                data = GetAllRotationalSchedule();
            }
            else if (Request["key"] + "" == "getRotationalScheduleDetailById")
            {
                data = GetRotationalScheduleDetailById();
            }
            else if (Request["key"] + "" == "deleteRotationalScheduleById")
            {
                data = DeleteRotationalScheduleById();
            }
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Write(data);
            Response.Flush();
            //Response.End();

        }

        private string DeleteRotationalScheduleById()
        {
            JQueryResponse json = new JQueryResponse();
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

                int temp = Numerics.GetInt(objDAL.Connection.GetValueProcedure("[TAMSR2_ScheduleRotationalOps]", ht));
                if (temp > 0)
                    return "1";
                else if (temp == -1)
                    return "-1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/RotationalSchedulePage.aspx.GetAllRotationalSchedule()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        #region GetAllRotationalSchedule
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllRotationalSchedule()
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

                string[] cols = { "schedule_rotational_id", "from_date", "to_date", "Scope", "NoOfSchedules", "CreatedBy" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string type = "0";
                string scopeId = "0";
                if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "0")
                {
                    type = "2";
                    scopeId = Request["empID"];
                }
                else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "0")
                {
                    type = "3";
                    scopeId = Request["groupID"];
                }
                else if ((Request["orgID"] + "").Trim() != "")
                {
                    type = "1";
                    scopeId = Request["orgID"];
                }
             
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["userID"] + "");
                ht.Add("ScopeType", type + "");
                ht.Add("ScopeId", scopeId);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRotationalOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["userID"] + "");
                ht.Add("ScopeType", type + "");
                ht.Add("ScopeId", scopeId);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRotationalOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["schedule_rotational_id"]) + "' />");

                    if ((obj["from_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["from_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("");
                    if ((obj["to_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["to_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("");

                    if ((obj["Scope"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["Scope"] + "").Trim());

                    if ((obj["NoOfSchedules"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["NoOfSchedules"] + "").Trim());

                    if ((obj["CreatedBy"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["CreatedBy"] + "").Trim());

                   

                    tempList.Add("<a style='cursor:pointer;' onclick='GetRotationalScheduleDetail(" + Numerics.GetDecimal(obj["schedule_rotational_id"]) + ")'> View Detail </a>");

                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_ORG_SCHEDULE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        string editString =Numerics.GetDecimal(obj["schedule_rotational_id"])+"|"+ Numerics.GetDateTime(obj["from_date"]).ToString("yyyy-MM-dd");
                        tempAction = String.Format("<img style='cursor:pointer;' src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit({0},\"{1}\")' /> &nbsp; ", Numerics.GetDecimal(obj["schedule_rotational_id"]), Numerics.GetDateTime(obj["from_date"]).ToString("yyyy-MM-dd"));

                       
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
                new ExceptionLog().WriteLog("RequestPages/RotationalSchedulePage.aspx.GetAllRotationalSchedule()", 0, ex);
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

            Dictionary<string, string> listOfRotation = new Dictionary<string, string>();
            listOfRotation = new JavaScriptSerializer().Deserialize<Dictionary<string, string>>(Request["rotationalList"]);
            List<string> temp = new List<string>();
            foreach (KeyValuePair<string, string> item in listOfRotation)
            {
                temp.Add(item.Value);
            }
            string temp2 = string.Join(",", temp);
            string chk = "0";
            Hashtable ht = new Hashtable();
            string type = "0";
            string scopeId = "0";
            if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "0")
            {
                type = "2";
                scopeId = Request["empID"];
            }
            else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "0")
            {
                type = "3";
                scopeId = Request["groupID"];
            }
            else if ((Request["orgID"] + "").Trim() != "")
            {
                type = "1";
                scopeId = Request["orgID"];
            }
            ht.Add("action", "save");
            ht.Add("sessionID", Session["userID"] + "");
            ht.Add("ID", Request["id"] + "");
            ht.Add("ScopeType", type + "");
            ht.Add("ScopeId", scopeId);
            ht.Add("rotationlist", temp2);
            ht.Add("count", listOfRotation.Count);


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
            ht.Add("toDate", "2050-01-01");

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["userID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["userID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            string result = "0";
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRotationalOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/RotationalSchedulePage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

        #region GetRotationalScheduleDetailById
        public string GetRotationalScheduleDetailById()
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

                string[] cols = { "Day", "srd.schedule_id", "schedule_code", "sch_color", "in_time1", "out_time1", "srd.last_updated_date" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string type = "0";
                string scopeId = "0";
                if ((Request["empID"] + "").Trim() != "" && (Request["empID"] + "").Trim() != "0")
                {
                    type = "2";
                    scopeId = Request["empID"];
                }
                else if ((Request["groupID"] + "").Trim() != "" && (Request["groupID"] + "").Trim() != "0")
                {
                    type = "3";
                    scopeId = Request["groupID"];
                }
                else if ((Request["orgID"] + "").Trim() != "")
                {
                    type = "1";
                    scopeId = Request["orgID"];
                }

                Hashtable ht;
                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getRotationalScheduleDetailByIdCount");
                ht.Add("ID", Request["ScheduleRotationalId"] + "");
                ht.Add("sessionID", Session["userID"] + "");
                ht.Add("ScopeType", type + "");
                ht.Add("ScopeId", scopeId);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRotationalOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                ht = new Hashtable();
                ht.Add("action", "getRotationalScheduleDetailById");
                ht.Add("sessionID", Session["userID"] + "");
                ht.Add("ID", Request["ScheduleRotationalId"] + "");
                ht.Add("ScopeType", type + "");
                ht.Add("ScopeId", scopeId);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", json.iTotalRecords);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ScheduleRotationalOps", ht);


                json.rawData = new List<object>();
                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    
                    var temp = new
                    {
                        Day = obj["Day"],
                        ScheduleId = obj["schedule_id"],
                        ScheduleRotationalId = Request["ScheduleRotationalId"]
                    };
                    if ((obj["Day"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["Day"] + "").Trim());

                    if ((obj["schedule_id"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["schedule_id"] + "").Trim());

                    if ((obj["schedule_code"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["schedule_code"] + "").Trim());

                    if ((obj["sch_color"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["sch_color"] + "").Trim());


                    if ((obj["Time_In"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["Time_In"] + "").Trim());



                    if ((obj["Time_Out"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["Time_Out"] + "").Trim());


                    if ((obj["last_updated_date"] + "").Trim() == "")
                        tempList.Add("<i class='icon-remove'></i>");
                    else
                        tempList.Add((obj["last_updated_date"] + "").Trim());
                    
                    json.aaData.Add(tempList);
                    json.rawData.Add(temp);

                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/RotationalSchedulePage.aspx.GetAllRotationalSchedule()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);


        }
        //*********End Of GetRotationalScheduleDetailById Function*********//
        #endregion
    }
}