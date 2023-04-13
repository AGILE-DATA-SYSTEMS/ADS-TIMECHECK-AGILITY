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
using System.Configuration;

namespace TAMSR2.RequestPages
{
    public partial class LicensePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/LicensePage.aspx"));


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

            if (Session["ID"] + "" == "" && Request["key"] + "" != "login" && Session["VALID_LICENSE"] + "" != "" && Convert.ToBoolean(Session["VALID_LICENSE"] + "") == true)
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "save")
            {
                data = Save();
            }
            else if (Request["key"] + "" == "ApplyLicense")
            {
                data = ApplyLicense();
            }
            else if (Request["key"] + "" == "getApplicationLicense")
            {
                data = GetApplicationLicense();
            }
            else if (Request["key"] + "" == "getSupportLicense")
            {
                data = GetSupportLicense();
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
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByID()
        {

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            TAMSR2Licence obj = new TAMSR2Licence();
            try
            {
                string ConStr = Connection.GetConnectionStrinng();
                objDAL.OpenConnection(ConStr);
                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ConfigurationManager.AppSettings["ADComp"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CompanyOps", ht);

                if (dv != null)
                {
                    obj.Primary_License = dv[0]["PrimaryLicenseKey"] + "";
                    obj.Secondary_License = dv[0]["SecondaryLicenseKey"] + "";
                    
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

        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetApplicationLicense()
        {

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            TAMSR2Licence obj = new TAMSR2Licence();
            try
            {
                //Update the Build Date 
                TAMSR2Licence.UpdateBuildDate();
                obj.CompName = Session["LICENSED_TO"] + "";
                obj.Type = Session["LICENSED_TYPE"] + "";
                obj.ProductVersion = Resources.Resource.applicationName + " " + Session["PRODUCT_VERSION"] + "";

                obj.StartDate = Convert.ToDateTime(Session["START_DATE"]).ToString(AppSetting.dateFormat) + "";
                obj.ActiveDate = Convert.ToDateTime(Session["ACTIVATION_DATE"]).ToString(AppSetting.dateFormat) + "";
                obj.LastBuildDate = Convert.ToDateTime(Session["LAST_BUILD_DATE"]).ToString(AppSetting.dateFormat + " hh:mm") + ""; 
                obj.EndDate = Convert.ToDateTime(Session["EXPIRY_DATE"]).ToString(AppSetting.dateFormat) + "";
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

        #region ApplyLicense

        public string ApplyLicense()
        {

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            string ret = "";
            try
            {
                string licenseKey = Request["License"] + "";
                licenseKey = licenseKey.Replace(" ", "+");
                string LicenseType = Request["LicenseType"] + "";
                string ConString = Connection.GetConnectionStrinng();
                objDAL.OpenConnection(ConString);
                Hashtable ht = new Hashtable();
                ht.Add("action", "UpdateLicenseKey");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("Code", System.Configuration.ConfigurationManager.AppSettings["CompCode"] + "");
                if (LicenseType == "Primary")
                    ht.Add("PrimaryLicenseKey", licenseKey);
                else
                    ht.Add("SecondaryLicenseKey", licenseKey);

                ht.Add("LicenseType", LicenseType);
                int res = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_CompanyOps", ht);

                if (res != null && res > 0)
                {
                    ret = "1";
                    if (LicenseType == "Primary")
                        Session["PRIMARY_LICENSE"] = "";
                    else
                        Session["SECONDARY_LICENSE"] = "";

                }
                else
                {
                    ret = "1";

                }
            }
            catch (Exception ex)
            {
                ret = "-1";

            }
            finally
            {
                objDAL.CloseConnection();
            }

            TAMSR2Licence.ValidateLicense();
            return ret;
        }

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
            string choose = (String)GetGlobalResourceObject("Resource", "choose");
            string licenseStr = (String)GetGlobalResourceObject("Resource", "license");

            try
            {
                objDAL.OpenConnection();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_LicenseOps", ht);

                sb.Append("<option value=''>" + choose + " " + licenseStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["ID"] + "");
                    obj.NameEn = row["NameEn"] + "";
                    obj.NameAr = row["NameAr"] + "";
                    obj.Days = Numerics.GetInt(row["LicenseDays"] + "");
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameAr + " - " + days + ":" + obj.Days + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.NameEn + " - " + days + ":" + obj.Days + " </option>");
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
        /// Delete user by ID from TAMSR2_LICENCE table 
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
                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_LicenseOps", ht);
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


        #region GetSupportLicense
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetSupportLicense()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            string isActive = "Expired";
            try
            {
                objDAL.OpenConnection();

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "ID", "Name", "FromDate", "ToDate", "Status"};

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("CompanyCode", ConfigurationManager.AppSettings["CompCode"] + ""); 
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_LicenseOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("CompanyCode", ConfigurationManager.AppSettings["CompCode"] + ""); 
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_LicenseOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add(Numerics.GetDecimal(obj["ID"]) + "");
                    tempList.Add((obj["Name"] + "").Length > 30 ? (obj["Name"] + "").Substring(0, 30) + "..." : (obj["Name"] + ""));
                    tempList.Add(Numerics.GetDateTime(obj["FromDate"] + "").ToString(AppSetting.dateFormat) + "");
                    tempList.Add(Numerics.GetDateTime(obj["ToDate"] + "").ToString(AppSetting.dateFormat) + "");
                    if((obj["isActive"] + "") == "0")
                        tempList.Add("<span class='label label-important'>" + Resources.Resource.expired + "</span>");
                    else
                        tempList.Add("<span class='label label-success'>" + Resources.Resource.active + "</span>");
                     
                     
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/UserPage.aspx.GerAll()", 0, ex);
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
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("nameEn", (Request["nameEn"] + "").Trim());
            ht.Add("nameAr", (Request["nameAr"] + "").Trim());
            ht.Add("prefix", (Request["prefix"] + "").Trim());
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

    }
}