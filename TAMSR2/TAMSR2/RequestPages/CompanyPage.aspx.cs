using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
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
    public partial class CompanyPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/CompanyPage.aspx"));


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



            string data = "";

            if (Session["ID"] + "" == "" && Request["key"] + "" != "login" && Request["key"] + "" != "getIdNameListString" && Request["key"] + "" != "getCodeNameListString")
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
            else if (Request["key"] + "" == "defaultCreation")
            {
                data = CreateDefaultTables();
            }
            else if (Request["key"] + "" == "defaultInsertion")
            {
                data = InsertDefaultValues();
            }
            else if (Request["key"] + "" == "getIdNameListString")
            {
                data = GetIdNameListString();
            }
            else if (Request["key"] + "" == "getCodeNameListString")
            {
                data = GetCodeNameListString();
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
            TAMSR2User obj = new TAMSR2User();
            try
            {
                objDAL.OpenConnection();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CompanyOps", ht);

                if (dv != null)
                {
                    obj.NameEn = dv[0]["NameEn"] + "";
                    obj.NameAr = dv[0]["NameAr"] + "";
                    obj.Username = dv[0]["Username"] + "";
                    obj.Password = dv[0]["Password"] + "";
                    
                    obj.Email = dv[0]["Email"] + "";
                    obj.CompanyID = Numerics.GetDecimal(dv[0]["CompanyID"]);
                    obj.CanView = Numerics.GetBool(dv[0]["CanView"]);
                    obj.CanAdd = Numerics.GetBool(dv[0]["CanAdd"]);
                    obj.CanUpdate = Numerics.GetBool(dv[0]["CanUpdate"]);
                    obj.CanDelete = Numerics.GetBool(dv[0]["CanDelete"]);
                    obj.IsActive = Numerics.GetBool(dv[0]["IsActive"]);
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["CreatedOn"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["CreatedBy"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["UpdatedOn"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["UpdatedBy"]);
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



        #region GetCodeNameListString
        /// <summary>
        /// GetCodeNameListString function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetCodeNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            string choose = (String)GetGlobalResourceObject("Resource", "choose");
            string companyStr = (String)GetGlobalResourceObject("Resource", "company");

            try
            {
                objDAL.OpenConnection();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CompanyOps", ht);

                sb.Append("<option value=''>" + choose + " " + companyStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["ID"] + "");
                    obj.Code = (row["Code"] + "").Trim().ToLower();
                    obj.NameEn = row["NameEn"] + "";
                    obj.NameAr = row["NameAr"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.Code + "'>" + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.Code + "'>" + obj.NameEn + " </option>");
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
        //*********End Of GetCodeNameListString Function*********//
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

            string choose = (String)GetGlobalResourceObject("Resource", "choose");
            string companyStr = (String)GetGlobalResourceObject("Resource", "company");

            try
            {
                objDAL.OpenConnection();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CompanyOps", ht);

                //sb.Append("<option value=''>" + choose + " " + companyStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["ID"] + "");
                    obj.NameEn = row["NameEn"] + "";
                    obj.NameAr = row["NameAr"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameAr +  " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + " </option>");
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
                Hashtable ht = new Hashtable();
                ht.Add("action", "deleteByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                objDAL.OpenConnection();
                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_CompanyOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
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
            try
            {
                objDAL.OpenConnection();

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "ID", "Name" + cookie.Values["language"], "DbName", "StartDate", "Description" + cookie.Values["language"], "UpdatedBy", "UpdatedOn", "IsActive", "ID" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_CompanyOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_CompanyOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["ID"]) + "' />");
                    tempList.Add((obj["Name" + cookie.Values["language"]] + "").Length > 100 ? (obj["Name" + cookie.Values["language"]] + "").Substring(0, 100) + "..." : (obj["Name" + cookie.Values["language"]] + ""));
                    tempList.Add(obj["DbName"] + "");
                    tempList.Add(Numerics.GetDateTime(obj["StartDate"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add((obj["Description" + cookie.Values["language"]] + "").Length > 100 ? (obj["Description" + cookie.Values["language"]] + "").Substring(0, 100) + "..." : (obj["Description" + cookie.Values["language"]] + ""));
                    tempList.Add(obj["UpdatedBy"] + "");
                    tempList.Add(Numerics.GetDateTime(obj["UpdatedOn"] + "").ToString(AppSetting.dateFormat));
                    tempList.Add(Numerics.GetBool(obj["IsActive"] + "").ToString());
                    string tempAction = "";
                    tempAction = "";
                    if (Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        //tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["ID"]) + ")' /> &nbsp; ";
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true)
                    {
                        tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='return Delete(" + Numerics.GetDecimal(obj["ID"]) + ");' /> ";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/CompanyPage.aspx.GerAll()", 0, ex);
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
            if ((Request["nameEn"] + "").Trim() == "" || (Request["nameAr"] + "").Trim() == "" || (Request["dbName"] + "").Trim() == "" || (Request["serialKey"] + "").Trim() == "")
            {
                return "-1";
            }
            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("nameEn", (Request["nameEn"] + "").Trim());
            ht.Add("nameAr", (Request["nameAr"] + "").Trim());
            ht.Add("dbType", (Request["dbType"] + "").Trim());
            ht.Add("dbName", (Request["dbName"] + "").Trim());
            ht.Add("dbUser", (Request["dbUser"] + "").Trim());
            ht.Add("dbPassword", (Request["dbPassword"] + "").Trim());
            ht.Add("serialKey", (Request["serialKey"] + "").Trim());
            ht.Add("startDate", (Request["startDate"] + "").Trim());
            ht.Add("descriptionEn", (Request["descriptionEn"] + "").Trim());
            ht.Add("descriptionAr", (Request["descriptionAr"] + "").Trim());

            ht.Add("IsActive", (Request["isActive"] + "").Trim());


            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                if (Session["ID"] + "" != "")
                {
                    ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                    ht.Add("createdBy", Session["ID"] + "");
                    ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                    ht.Add("updatedBy", Session["ID"] + "");
                }
                objDAL.OpenConnection();
                string result = objDAL.Connection.GetValueProcedure("TAMSR2_CompanyOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/CompanyPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region CreateDefaultTables
        /// <summary>
        /// CreateDefaultTables function
        /// To create Default tables in database for company by given prefix of that company.
        /// </summary>
        /// <parameter>Prefix of the company</parameter>
        /// <returns>it will return integer value </returns>

        public string CreateDefaultTables()
        {
            string chk = "0";
            string dbType = Request["dbType"] + "";
            string dbName = Request["dbName"] + "";
            string dbUser = Request["dbUser"] + "";
            string dbPassword = Request["dbPassword"] + "";
            string connStr = Connection.GetConnectionStrinng(dbType, dbName, dbUser, dbPassword);
            Hashtable ht = new Hashtable();
            ht.Add("dbName", (Request["dbName"]).Trim());
            string tempStr = "";
            //if (dbType.ToLower() == "sql")
            //    tempStr = File.ReadAllText(Server.MapPath("~/Uploads/tamsr2_create_tables.sql"));
            //else
            //    tempStr = File.ReadAllText(Server.MapPath("~/Uploads/tamsr2_create_tables.txt"));

            //ht.Add("TablePrefix", (Request["prefix"] + "").Trim());
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                //objDAL.OpenConnection(connStr);
                objDAL.OpenConnection();
                //int result = objDAL.Connection.ExecuteNonQuery(tempStr);
                int result = objDAL.Connection.ExecuteNonQueryProcedure("CREATE_TAMS_TABLES", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result + "";
                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/CompanyPage.aspx.CreateDefaultTables()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of CreateDefaultTables Function*********//
        #endregion


        #region InsertDefaultValues
        /// <summary>
        /// InsertDefaultValues function
        /// To insert Default values in database for company by given prefix of that company.
        /// </summary>
        /// <parameter>Prefix of the company</parameter>
        /// <returns>it will return integer value </returns>

        public string InsertDefaultValues()
        {
            string chk = "0";
            string dbType = Request["dbType"] + "";
            string dbName = Request["dbName"] + "";
            string dbUser = Request["dbUser"] + "";
            string dbPassword = Request["dbPassword"] + "";
            string connStr = Connection.GetConnectionStrinng(dbType, dbName, dbUser, dbPassword);
            Hashtable ht = new Hashtable();
            //ht.Add("TablePrefix", (Request["prefix"] + "").Trim());
            ht.Add("dbName", (Request["dbName"] + "").Trim());
            ht.Add("defaultvalues", (Request["defaultvalues"] + "").ToLower().Trim());
            ht.Add("smtpOrWebMail", (Request["smtpOrWebMail"] + "").Trim());
            ht.Add("server", (Request["server"] + "").Trim());
            ht.Add("smtpPort", (Request["smtpPort"] + "").Trim());
            ht.Add("smtpEmail", (Request["smtpEmail"] + "").Trim());
            ht.Add("smtpPassword", (Request["smtpPassword"] + "").Trim());
            ht.Add("fromEmail", (Request["fromEmail"] + "").Trim());
            ht.Add("bccEmail", (Request["bccEmail"] + "").Trim());
            ht.Add("ccEmail", (Request["ccEmail"] + "").Trim());
            ht.Add("timeZone", (Request["timeZone"] + "").Trim());

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection();
                int result = objDAL.Connection.ExecuteNonQueryProcedure("INSERT_TAMS_TABLES", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result + "";
                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/CompanyPage.aspx.InsertDefaultValues()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of InsertDefaultValues Function*********//
        #endregion

    }
}