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
    public partial class IntegrationSetting : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/IntegrationSetting.aspx"));


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
            else if (Request["key"] + "" == "getTaTableList")
            {
                data = GetTATables();
            }
            else if (Request["key"] + "" == "getByIDColumnList")
            {

                data = GetTaTableColumns();

            }
            else if (Request["key"] + "" == "save")
            {

                data = Save();

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

        private string GetTaTableColumns()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByIDColumnList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("value", Request["tableId"] + "");
                dv = objDAL.Connection.ExecuteProcedure("[Tamsr2_IntegrationSettingOps]", ht);
                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = "columns";
                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");
                foreach (DataRowView row in dv)
                {
                    sb.Append("<option value='" + Numerics.GetDecimal(row["column_id"] + "") + "'>" + row["name"] + "" + "</option>");
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


        #region GetTATables
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetTATables()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getTaTables");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("[Tamsr2_IntegrationSettingOps]", ht);
                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = "table";
                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");
                foreach (DataRowView row in dv)
                {
                    sb.Append("<option value='" + Numerics.GetDecimal(row["object_id"] + "") + "'>" + row["name"] + "" + "</option>");
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


        #region Save
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string Save()
        {
            string chk = "0";
            List<IntegrationMapping> lstMapping = new List<IntegrationMapping>();
            lstMapping = new JavaScriptSerializer().Deserialize<List<IntegrationMapping>>(Request["dataArray"]);
            TAMSR2Data objDAL = new TAMSR2Data();
            if (lstMapping != null && lstMapping.Count > 0)
            {
                string query = Request["query"];
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                try
                {
                    foreach (var item in lstMapping)
                    {
                        Hashtable ht = new Hashtable();
                        ht.Add("action", "save");
                        ht.Add("sessionID", Session["ID"]);
                        ht.Add("value", (Request["value"] + "").Trim());
                        ht.Add("DestinationCompany", (Session["CompanyName"] + "").Trim().ToUpper());
                        ht.Add("DestinationTableID", (item.DTID));
                        ht.Add("DestinationColumnID", (item.DTCID));
                        ht.Add("SourceColumnName", (item.SourceColumnName + "").Trim().ToUpper());
                        ht.Add("DestinationColumnName", (item.DTCName + "").Trim().ToUpper());
                       
                        string result = objDAL.Connection.GetValueProcedure("Tamsr2_IntegrationSettingOps", ht);
                        if (Numerics.GetDecimal(result) >= 0)
                        {
                            chk = result;
                        }
                        else
                        {
                            chk = "-1";
                        }

                    }
                }
                catch (Exception ex)
                {
                    new ExceptionLog().WriteLog("RequestPages/IntegrationSetting.aspx.Save()", 0, ex);
                }
                finally
                {

                    objDAL.CloseConnection();

                }
            }

            return chk;
        }
        //*********End Of Save Function*********//
        #endregion
        class IntegrationMapping
        {
            public int DTID { get; set; }
            public int DTCID { get; set; }
            public string DTCName { get; set; }
            public string SourceColumnName { get; set; }
        }

    }
}