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
    public partial class ReaderPanelPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/ReaderPanelPage.aspx"));

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

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            ReaderPanel obj = new ReaderPanel();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_PanelOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["panel_id"]);
                    obj.OrgID = Numerics.GetDecimal(dv[0]["organization_id"]);
                    obj.Code = dv[0]["code"] + "";
                    obj.DescriptionEn = dv[0]["name_Eng"] + "";
                    obj.DescriptionAr = dv[0]["name_Arb"] + "";
                    obj.InuseFlag = Numerics.GetInt(dv[0]["inuse_flag"]);
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_date"]);
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
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_PanelOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeTypeStr = (String)GetGlobalResourceObject("Resource", "employeeType");

                sb.Append("<option value=''>" + chooseStr + " " + employeeTypeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    EmployeeType obj = new EmployeeType();
                    obj.ID = Numerics.GetDecimal(row["panel_id"] + "");
                    obj.Code = row["code"] + "";
                    obj.DescriptionEn = row["name_Eng"] + "";
                    obj.DescriptionAr = row["name_Arb"] + "";
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_PanelOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderPanelPage.aspx.DeleteByID()", 0, ex);
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

                string[] cols = { "pnl.panel_id", "pnl.code", "pnl.name" + languagePostfix, "org.description" + languagePostfix, "pnl.last_updated_date", "pnl.panel_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_PanelOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_PanelOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["panel_id"]) + "' />");
                    tempList.Add(obj["code"] + "");
                    tempList.Add((obj["name" + languagePostfix] + "").Length > 100 ? (obj["name" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["name" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetBool(obj["inuse_flag"] + "") + "");
                    tempList.Add((obj["orgDes" + languagePostfix] + "").Length > 100 ? (obj["orgDes" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["orgDes" + languagePostfix] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_PANEL) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["panel_id"]) + ");' /> &nbsp; ";
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["panel_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderPanelPage.aspx.GerAll()", 0, ex);
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
            int inuseFlag = 0;
            if ((Request["inuseFlag"] + "").ToLower() == "true")
                inuseFlag = 1;
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("inuseFlag", inuseFlag);
            ht.Add("descriptionEng", (Request["descriptionEn"] + "").Trim());
            ht.Add("descriptionArb", (Request["descriptionAr"] + "").Trim());
            ht.Add("orgID", (Request["orgID"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_PanelOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ReaderPanelPage.aspx.Save()", 0, ex);
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