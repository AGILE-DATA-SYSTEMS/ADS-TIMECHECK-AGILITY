using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using System.Text;

namespace TAMSR2.RequestPages
{
    public partial class ReportTemplatePage : System.Web.UI.Page
    {

        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/ReportTemplatePage.aspx"));


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
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if(Request["key"] + "" == "getTableNameListString")
            {
                data = getTableNameListString();
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
            try
            {
                int count = Numerics.GetInt(Request["count"] + "");
                string ids = Request["ID"] + "";
                //for (int k = 1; k <= count; k++)
                //{
                //    ids += Request["chk" + k] + ",";
                //}
                ids = ids.TrimEnd(',');
                Hashtable ht = new Hashtable();
                ht.Add("action", "deleteByID");
               // ht.Add("action", "deleteByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_TemplatePageOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReportTemplatePage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion

        #region getTableNameListString
        /// <summary>
        /// GetIdNameListString function
        /// Get organization drop down list from ORGANIZATION table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string getTableNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getTableNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "reportCategory");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + row["TblName"] + "" + "'>" + row["Name_Arb"] + "" + " </option>");
                    else
                        sb.Append("<option value='" + row["TblName"] + "" + "'>" + row["Name_Eng"] + "" + "  </option>");
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
        //*********End Of GetIdNameListString Function*********//
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
            string tempLanguagePostfix = "";
            if (languagePostfix == "_eng")
                tempLanguagePostfix = "En";
            else
                tempLanguagePostfix = "Ar";

            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "ID", "Name" + tempLanguagePostfix, "Description" + tempLanguagePostfix, "Category", "UpdatedBy" + tempLanguagePostfix, "UpdatedOn" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getall");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("sessionID", Session["userID"] + "");
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_TemplatePageOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_TemplatePageOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["ID"]) + "' />");
                    tempList.Add((obj["Name" + languagePostfix] + "").Length > 100 ? (obj["Name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["Name" + languagePostfix] + ""));
                    tempList.Add((obj["description" + languagePostfix] + "").Length > 100 ? (obj["description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["description" + languagePostfix] + ""));
                    tempList.Add((obj["Category"] + ""));
                    tempList.Add((obj["CreatedBy" + languagePostfix] + "").Length > 100 ? (obj["CreatedBy" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["CreatedBy" + languagePostfix] + ""));
                   // tempList.Add(Numerics.GetDateTime(obj["CreatedOn"] + "").ToString(AppSetting.dateFormat));
                   
                   // tempList.Add((obj["UpdatedBy" + languagePostfix] + "").Length > 100 ? (obj["UpdatedBy" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["UpdatedBy" + languagePostfix] + ""));
  
                    tempList.Add(Numerics.GetDateTime(obj["UpdatedOn"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_REPORT_TEMPLATE) == true)
                    {
                        if (obj["CreatedBy" + languagePostfix].ToString().ToLower() != "administrator"  )
                             tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["ID"]) + ")' /> ";
                        else if (obj["CreatedBy" + languagePostfix].ToString().ToLower() == "administrator" && Convert.ToInt32(Session["ID"].ToString()) == 1)
                        {
                            tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["ID"]) + ")' /> ";
                        }
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReportTemplatePage.aspx.GetAll()", 0, ex);
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