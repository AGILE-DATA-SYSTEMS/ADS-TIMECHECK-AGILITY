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
    public partial class OrgPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        List<IdName> privilegeList = new List<IdName>();

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/OrgPage.aspx"));

            try
            {
                if (Numerics.GetBool(Session["chkPrivileges"]) == true)
                {
                    privilegeList = (List<IdName>)Session["userPrivilegeList"];
                }
            }
            catch (Exception ex)
            {
            }
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
            else if (Request["key"] + "" == "getCodeNameListString")
            {
                data = GetCodeNameListString();
            }
            else if (Request["key"] + "" == "getIdNameListString")
            {
                data = GetIdNameListString();
            }
            else if (Request["key"] + "" == "getIdNameListStringByRegion")
            {
                data = GetIdNameListStringByRegionCode();
            }
            else if (Request["key"] + "" == "getIdNameListStringForRoster")
            {
                data = GetIdNameListStringForRoster();
            }
            else if (Request["key"] + "" == "getIdNameListSectionStringForRoster")
            {
                data = GetIdNameListSectionStringForRoster();
            }
            else if (Request["key"] + "" == "getIdNameListStringByType")
            {
                data = GetIdNameListStringByType();
            }
            else if (Request["key"] + "" == "getAllIdNameListString")
            {
                data = GetAllIdNameListString();
            }
            else if (Request["key"] + "" == "getRootOrg")
            {
                data = GetRootOrganizations();
            }
            else if (Request["key"] + "" == "getOrgByParent")
            {
                data = GetOrganizationsByRootID();
            }
            else if (Request["key"] + "" == "getSection")
            {
                data = GetSection();
            }
            else if (Request["key"] + "" == "GetDepartment")
            {
                data = GetDepartment();
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
            ObjectClasses.Org obj = new  ObjectClasses.Org();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);
                
                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["organization_id"]);
                    obj.OrgTypeID = Numerics.GetDecimal(dv[0]["organization_type_id"]);
                    obj.ParentID = Numerics.GetDecimal(dv[0]["parent_id"]);
                    obj.ParentTypeID = Numerics.GetDecimal(dv[0]["parent_Organization_Type_ID"]);
                    obj.BranchFlag = dv[0]["branch_flag"] + "";
                    obj.OpenShiftFlag = Numerics.GetInt(dv[0]["open_shift_flag"]);


                    obj.InactiveDate = Numerics.GetDateTime(dv[0]["inactive_date"]);
                    obj.InactiveDateStr = (dv[0]["inactive_date"] + "").Trim() != "" ? obj.InactiveDate.ToString("dd-MM-yyyy") : "";

                    obj.CalculateMonthlyMissedHours = Numerics.GetInt(dv[0]["calculate_monthly_missed_hours"]); 
                    obj.Code = dv[0]["code"] + "";
                    obj.DescriptionEn = dv[0]["description_Eng"] + "";
                    obj.DescriptionAr = dv[0]["description_Arb"] + "";
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



        #region Get Root Organizations
        /// <summary>
        /// GetRootOrganizations function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetRootOrganizations()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" ");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getRootOrg");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);
                foreach (DataRowView row in dv)
                {
                    ObjectClasses.Org obj = new ObjectClasses.Org();
                    obj.ID = Numerics.GetDecimal(row["organization_id"]);
                    obj.OrgTypeID = Numerics.GetDecimal(row["organization_type_id"]);
                    obj.ParentID = Numerics.GetDecimal(row["parent_id"]);
                    obj.Code = row["code"] + "";
                    obj.DescriptionEn = row["description_Eng"] + "";
                    obj.DescriptionAr = row["description_Arb"] + "";
                    sb.Append("<li id='li" + obj.ID + "' > ");
                    sb.Append("<a href='#' data-role='branch' class='tree-toggle' data-toggle='branch' data-value='" + obj.ID + "'> ");
                    if (languagePostfix == "ar")
                        sb.Append(obj.Code + " - " + obj.DescriptionAr + " ");
                    else
                        sb.Append(obj.Code + " - " + obj.DescriptionEn + " ");
                    sb.Append("</a> ");
                    sb.Append("<ul class='branch'> ");
                    sb.Append("</ul> ");
                    sb.Append("</li> ");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString() + " ";
        }
        //*********End Of GetRootOrganizations Function*********//
        #endregion




        #region Get Organizations By Root ID
        /// <summary>
        /// GetOrganizationsByRootID function
        /// Get organizations by parent ID from organizations table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetOrganizationsByRootID()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" ");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getAllByParentID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Request["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                foreach (DataRowView row in dv)
                {
                    ObjectClasses.Org obj = new ObjectClasses.Org();
                    obj.ID = Numerics.GetDecimal(row["organization_id"]);
                    obj.OrgTypeID = Numerics.GetDecimal(row["organization_type_id"]);
                    obj.ParentID = Numerics.GetDecimal(row["parent_id"]);
                    obj.Code = row["code"] + "";
                    obj.DescriptionEn = row["description_Eng"] + "";
                    obj.DescriptionAr = row["description_Arb"] + "";
                    sb.Append("<li id='li" + obj.ID + "' > ");
                    sb.Append("<a href='#' data-role='branch' class='tree-toggle' data-toggle='branch' data-value='" + obj.ID + "'> ");
                    if (languagePostfix == "ar")
                        sb.Append(obj.Code + " - " + obj.DescriptionAr + " ");
                    else
                        sb.Append(obj.Code + " - " + obj.DescriptionEn + " ");
                    sb.Append("</a> ");
                    sb.Append("<ul class='branch'> ");
                    sb.Append("</ul> ");
                    sb.Append("</li> ");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString() + " ";
        }
        //*********End Of GetOrganizationsByRootID Function*********//
        #endregion



        #region GetCodeNameListString
        /// <summary>
        /// GetCodeNameListString function
        /// Get organization drop down list from ORGANIZATION table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetCodeNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "organization");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
                    obj.Code = row["code"] + "";
                    obj.DescriptionEn = row["description_eng"] + "";
                    obj.DescriptionAr = row["description_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.Code + "'>" + obj.Code + " --- " + obj.DescriptionAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.Code + "'>" + obj.Code + " --- " + obj.DescriptionEn + "  </option>");
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
        /// GetIdNameListString function
        /// Get organization drop down list from ORGANIZATION table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("searchInput", Request["SearchFilter"] + "");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "organization");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
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
        //*********End Of GetIdNameListString Function*********//
        #endregion



        #region GetIdNameListStringByRegionCode
        /// <summary>
        /// GetIdNameListStringByRegionCode function
        /// Get organization drop down list from ORGANIZATION table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringByRegionCode()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int includeInactive = 0;
                if ((Request["includeInactive"] + "").ToLower() == "true" || (Request["includeInactive"] + "") == "1")
                    includeInactive = 1;
                else
                    includeInactive = 0;

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByRegionID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("regionCode", (Request["Region"] + "").Trim());
                ht.Add("includeInactive", includeInactive);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "organization");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
                    obj.Code = row["code"] + "";
                    obj.DescriptionEn = row["description_eng"] + "";
                    obj.DescriptionAr = row["description_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " --- " + obj.DescriptionAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " --- " + obj.DescriptionEn + "  </option>");
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
        //*********End Of GetIdNameListStringByRegionCode Function*********//
        #endregion

        #region getIdNameListSectionStringForRoster
        public string GetIdNameListSectionStringForRoster()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListSectionStringForRoster");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Request["orgID"] + "");
                ht.Add("InactiveDate", Request["dt"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "section");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
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

        #endregion

        #region GetIdNameListStringForRoster
        /// <summary>
        /// GetIdNameListStringForRoster function
        /// Get organization drop down list for Roster page from ORGANIZATION table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringForRoster()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListForRoster");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("InactiveDate", Request["dt"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "organization");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
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
        //*********End Of GetIdNameListStringForRoster Function*********//
        #endregion




        #region GetIdNameListStringByType
        /// <summary>
        /// GetIdNameListStringByType function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringByType()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameListByType");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("orgTypeID", (Request["type"] + "").Trim());
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "organization");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
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
        


        #region GetAllIdNameListString
        /// <summary>
        /// GetAllIdNameListString function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetAllIdNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getAllIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "organization");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
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




        #region Get Section
        /// <summary>
        /// GetSection function
        /// Get organizations by parent ID from organizations table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetSection()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" ");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "GetSection");
                ht.Add("sessionID", Session["ID"] + "");
                if (Request["RegionID"] + "" != "")
                    ht.Add("RegionCode", Request["RegionID"] + "");
                if (Request["ParentID"] + "" != "")
                    ht.Add("orgParentID", Request["ParentID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);
                sb.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["Code"] + "");
                    obj.DescriptionEn = row["description_eng"] + "";
                    obj.DescriptionAr = row["description_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.ID + "---" + obj.DescriptionAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.ID + "---" + obj.DescriptionEn + "  </option>");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString() + " ";
        }
        //*********End Of GetSection Function*********//
        #endregion

        #region Get Department
        /// <summary>
        /// GetDepartment function
        /// Get organizations by parent ID from organizations table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetDepartment()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" ");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "GetDepartment");
                ht.Add("sessionID", Session["ID"] + "");
                if (Request["RegionID"] + "" != "")
                    ht.Add("RegionCode", Request["RegionID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);
                sb.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["Code"] + "");
                    obj.DescriptionEn = row["description_eng"] + "";
                    obj.DescriptionAr = row["description_arb"] + "";
                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.ID + "---" + obj.DescriptionAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.ID + "---" + obj.DescriptionEn + "  </option>");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return sb.ToString() + " ";
        }
        //*********End Of GetDepartment Function*********//
        #endregion


        #region DeleteByID
        /// <summary>
        /// DeleteByID function
        /// Delete user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteByID()
        {
            if (privilegeList.FirstOrDefault(p => p.Name == "DELETE_ORGANIZATION") == null)
                return "0";
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

                int temp = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_OrgOps", ht));
                if (temp > 0)
                    return "1";
                else if (temp == -1)
                    return "-1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OrgPage.aspx.DeleteByID()", 0, ex);
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
            //if (privilegeList.FirstOrDefault(p => p.Name == "VIEW_ORGANIZATION") == null)
            //    return "0";
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

                string[] cols = { "org.organization_id", "org.code", "org.description" + languagePostfix, "org.type" + languagePostfix, "prtOrg.parent" + languagePostfix, "open_shift_flag","org.inactive_date", "org.last_updated_date", "org.organization_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_OrgOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    if (Numerics.GetDecimal(obj["organization_id"]) > 1)
                        tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["organization_id"]) + "' />");
                    else 
                        tempList.Add(" &nbsp;");
                    tempList.Add(obj["code"] + "");
                    tempList.Add((obj["description" + languagePostfix] + "").Length > 100 ? (obj["description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["description" + languagePostfix] + ""));
                    tempList.Add((obj["type" + languagePostfix] + "").Length > 100 ? (obj["type" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["type" + languagePostfix] + ""));
                    tempList.Add((obj["parent" + languagePostfix] + "").Length > 100 ? (obj["parent" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["parent" + languagePostfix] + ""));

                    if (Numerics.GetDecimal(obj["open_shift_flag"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>"); 

                    if (obj["inactive_date"] + "" != "")
                        tempList.Add(Numerics.GetDateTime(obj["inactive_date"] + "").ToString(AppSetting.dateFormat));
                    else
                        tempList.Add("");


                    tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if ((obj["code"] + "").ToLower() != "root")
                    {
                        if (Numerics.GetDecimal(obj["organization_id"]) > 1 && (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_ORGANIZATION) == true || Numerics.GetBool(Session["CanUpdate"]) == true))
                        {
                            tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["organization_id"]) + ");' /> &nbsp; ";
                        }
                        if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                        {
                            //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["organization_id"]) + ")' /> ";
                        }
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OrgPage.aspx.GerAll()", 0, ex);
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
            if (privilegeList.FirstOrDefault(p => p.Name == "INSERT_ORGANIZATION") == null && (Request["id"] + "" == "0" || Request["id"] + "" == "-1"))
                return "-1";
            else
            {
                if (privilegeList.FirstOrDefault(p => p.Name == "EDIT_ORGANIZATION") == null && (Request["id"] + "" != "0" && Request["id"] + "" != "-1"))
                    return "-1";
            }
            int openShift = 0;
            if ((Request["openShift"] + "").ToLower() == "true")
                openShift = 1;
             
            string InactiveDate = ((Request["InactiveDate"] + "").Trim() == "[object HTMLInputElement]") ? "" : Request["InactiveDate"] + "";
            string InactiveDateStr = "";
            if (InactiveDate + "" != "")
            {
                int Day = Convert.ToInt32(InactiveDate.Substring(0, 2));
                int Month = Convert.ToInt32(InactiveDate.Substring(3, 2));
                int Year = Convert.ToInt32(InactiveDate.Substring(6, 4));

                DateTime inactiveDDate = new DateTime(Year, Month, Day);
                InactiveDateStr =  inactiveDDate.ToString("yyyy-MM-dd");
            }

            

            int monthlyMissedHours = 0;
            if ((Request["monthlyMissedHours"] + "").ToLower() == "true" || (Request["monthlyMissedHours"] + "") == "1")
                monthlyMissedHours = 1;
            else
                monthlyMissedHours = 0;

            string chk = "0";
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("descriptionEng", (Request["descriptionEn"] + "").Trim());
            ht.Add("descriptionArb", (Request["descriptionAr"] + "").Trim());
            ht.Add("orgTypeID", (Request["orgTypeID"] + "").Trim());
            ht.Add("orgParentID", (Request["parentID"] + "").Trim());
            ht.Add("branchFlag", (Request["branchFlag"] + "").Trim());
            ht.Add("openShiftFlag", openShift);
            ht.Add("InactiveDate", InactiveDateStr);
            ht.Add("calculateMonthlyMissedHours", monthlyMissedHours);

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_OrgOps", ht);
                if (Numerics.GetDecimal(result) >= 0)
                {
                    chk = result;
                }
                else if (result == "-2")
                {
                    chk = "-2";
                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/OrgPage.aspx.Save()", 0, ex);
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