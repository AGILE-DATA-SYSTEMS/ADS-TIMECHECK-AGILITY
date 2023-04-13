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
    public partial class EmailLogsPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/EmailLogsPage.aspx"));


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
            else if (Request["key"] + "" == "exportToExcel")
            {
                data = ExportToExcel();
            }
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Write(data);
            Response.Flush();
            //Response.End();

        }
        #region ExportToExcel
        private string ExportToExcel()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "to_text", "subject_text", "body_text", "email_status", "cc_email", "bcc_email","is_complete_violation_email","created_date_time" ,"last_updated_datetime"};

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("fromDate", fromDate.Trim());
                ht.Add("toDate", toDate.Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmailLogOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("fromDate", fromDate.Trim());
                ht.Add("toDate", toDate.Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmailLogOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;
                DataTable dt = new DataTable();
                dt = objDataView.ToTable();
                string attachment = "attachment; filename=city.xls";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/vnd.ms-excel";
                string tab = "";
                foreach (DataColumn dc in dt.Columns)
                {
                    Response.Write(tab + dc.ColumnName);
                    tab = "\t";
                }
                Response.Write("\n");
                int i;
                foreach (DataRow dr in dt.Rows)
                {
                    tab = "";
                    for (i = 0; i < dt.Columns.Count; i++)
                    {
                        Response.Write(tab + dt.Columns[i].ToString());
                        tab = "\t";
                    }
                    Response.Write("\n");
                }
                Response.End();

            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmailLogs.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
         #endregion
        #region GetAll
        public string GetAll()
         {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "to_text", "subject_text", "body_text", "email_status", "cc_email", "bcc_email","is_complete_violation_email","created_date_time" ,"last_updated_datetime"};

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("fromDate", fromDate.Trim());
                ht.Add("toDate", toDate.Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_EmailLogOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearchFilter"] + "").Trim());
                ht.Add("fromDate", fromDate.Trim());
                ht.Add("toDate", toDate.Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_EmailLogOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add(obj["to_text"] + "");
                    tempList.Add(obj["subject_text"] + "");
                    tempList.Add((obj["body_text"] + ""));
                    tempList.Add((obj["email_status"] + ""));
                    tempList.Add((obj["cc_email"] + ""));
                    tempList.Add((obj["bcc_email"] + ""));
                    if (Numerics.GetDecimal(obj["is_complete_violation_email"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    tempList.Add(Numerics.GetDateTime(obj["created_date_time"] + "").ToString(AppSetting.dateTimeFormat24));
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_datetime"] + "").ToString(AppSetting.dateTimeFormat24));

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/EmailLogs.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//

        #endregion



    }
}