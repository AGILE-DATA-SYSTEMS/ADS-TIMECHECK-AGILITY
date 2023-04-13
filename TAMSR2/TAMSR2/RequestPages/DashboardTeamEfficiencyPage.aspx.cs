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
    public partial class DashboardTeamEfficiencyPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        string IsArabic = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/DashboardTeamEfficiencyPage.aspx"));


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
            {
                languagePostfix = "_arb";
                IsArabic = "1";
            }
            else
                languagePostfix = "_eng";

            string data = "";

            if (Session["ID"] + "" == "")
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "getIdNameTeamList")
            {

                data = GetIdNameTeamList();
            }
            else if (Request["key"] + "" == "getTeamYearlyStatisticByMemberId")
            {

                data = GetTeamYearlyStatisticByMemberId();
            }
            else if (Request["key"] + "" == "getMemberViolationsByMonth")
            {
                data = GetMemberViolationsByMonth();
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


        public string GetIdNameTeamList()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();
            List<Employee> TeamList = new List<Employee>();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string emp = (Request["emp"] + "").Trim();
                string mgr = (Request["mgr"] + "").Trim();
                string org = (Request["org"] + "").Trim();

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameTeamList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgID", org + "");
                ht.Add("managerID", mgr + "");
                ht.Add("ID", emp + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);
                foreach (DataRowView row in dv)
                {
                    Employee newTeamMember = new Employee();
                    newTeamMember.EncryptedID = Encryption.Encrypt((row["employee_id"] + "").Trim());
                    newTeamMember.Code = row["employee_code"] + "";
                    newTeamMember.NameEn = row["name_eng"] + "";
                    newTeamMember.NameAr = row["name_arb"] + "";
                    TeamList.Add(newTeamMember);
                }

            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(TeamList);
        }
        

        private string GetMemberViolationsByMonth()
        {
            string EmployeeId = Request["EmployeeId"] + "";
            EmployeeId = Encryption.Decrypt(EmployeeId);
            string dt = string.Empty;


            int year = Numerics.GetInt((Request["year"] + "").Trim());
            if (year <= 0)
                year = Numerics.GetInt(DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy"));

            string tempDate = year.ToString() + "-" + Request["month"] + "" + "-1";
            DateTime today = Convert.ToDateTime(tempDate);
            DateTime endOfMonth = new DateTime(year,
                                               Numerics.GetInt(Request["month"] + ""),
                                               DateTime.DaysInMonth(year,
                                                                    Numerics.GetInt(Request["month"] + "")));

            dt = endOfMonth.ToString("yyyy-MM-dd");

            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string type = "";
                string scope = Request["scope"] + "";

                if (Request["type"] + "" == "early")
                {
                    type = "Early";
                }
                if (Request["type"] + "" == "late")
                {
                    type = "Late";
                }
                if (Request["type"] + "" == "leave")
                {
                    type = "Leave";
                }
                if (Request["type"] + "" == "absent")
                {
                    type = "Absent";
                }

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "Ddate", "employee_code", "name" + languagePostfix, "sch", "punch", "remarks" + languagePostfix };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;

                ht = new Hashtable();
                ht.Add("action", "getMyLateDetails");
                ht.Add("sessionID", EmployeeId + "");
                ht.Add("date", dt);
                ht.Add("type", type);
                ht.Add("scope", scope);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamEfficiencyOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getMyLateDetailsCount");
                ht.Add("sessionID", EmployeeId + "");
                ht.Add("date", dt);
                ht.Add("type", type);
                ht.Add("scope", scope);
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_DashboardTeamEfficiencyOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add((obj["Ddate"] + "") == "" ? "" : Numerics.GetDateTime(obj["Ddate"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(obj["employee_code"] + "");
                    tempList.Add(obj["name" + languagePostfix] + "");
                    tempList.Add((obj["sch"] + "") == "" ? "" : Numerics.GetDateTime(obj["sch"] + "").ToString(AppSetting.shortTimeFormat));
                    if (type == "Absent")
                    {

                        tempList.Add("&nbsp;");
                        tempList.Add(obj["remarks" + languagePostfix] + "");
                    }
                    else
                    {


                        tempList.Add((obj["punch"] + "") == "" ? "" : Numerics.GetDateTime(obj["punch"] + "").ToString(AppSetting.dateTimeFormat24));
                        tempList.Add(obj["remarks" + languagePostfix] + "");
                    }
                    json.aaData.Add(tempList);
                }
                if (json.iTotalDisplayRecords == 0)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");
                    tempList.Add("&nbsp;");

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DashboardPage.aspx.GetMemberViolationsByMonth()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);

        }

        private string GetTeamYearlyStatisticByMemberId()
        {

            string year = (Request["year"] + "").Trim();
            if (string.IsNullOrEmpty(year))
                year = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy");

            string EmployeeId = Request["EmployeeId"] + "";
            EmployeeId = Encryption.Decrypt(EmployeeId);


            TAMSR2Data objDAL = new TAMSR2Data();
            List<object> ResponseObject = new List<object>();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "GetTeamYearlyStatisticByMemberId");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", year + "");
                ht.Add("MemberId", EmployeeId + "");

                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_DashboardTeamEfficiencyOps", ht);

                if (objDataView != null && objDataView.Count > 0)
                {
                    foreach (DataRowView dr in objDataView)
                    {
                        object obj = new
                        {
                            Month = Numerics.GetInt(dr["Month"] + ""),
                            MonthName = dr["MonthName"] + "",
                            Late = Numerics.GetInt(dr["Late"] + ""),
                            Early = Numerics.GetInt(dr["Early"] + ""),
                            Absent = Numerics.GetInt(dr["Absent"] + ""),
                            UnAuthorizedAbsent = Numerics.GetInt(dr["UnAuthorizedAbsent"] + ""),
                            Leaves = Numerics.GetInt(dr["Leaves"] + ""),
                            MissedIN = Numerics.GetInt(dr["MissedIN"] + ""),
                            MissedOut = Numerics.GetInt(dr["MissedOut"] + "")
                        };
                        ResponseObject.Add(obj);
                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/DashboardPage.aspx.GetTeamYearlyStatisticByMemberId()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(ResponseObject);

        }


    }
}