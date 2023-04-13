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
    public partial class PermissionTypePage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/PermissionTypePage.aspx"));


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
            PermissionType obj = new PermissionType();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_PermissionTypeOps", ht);

                if (dv != null)
                {
                    obj.ID          = Numerics.GetDecimal(dv[0]["permission_type_id"]);
                    obj.ReasonID    = Numerics.GetDecimal(dv[0]["reason_id"]);

                    obj.MaxMinutesPerDay            = dv[0]["max_minutes_per_day"] + "";
                    obj.MaxPermissionsPerDay        = dv[0]["max_permissions_per_day"] + "";
                    obj.MaxMinutesMinutesPerMonth   = dv[0]["max_minutes_minutes_per_month"] + "";
                    obj.MaxPermissionsPerMonth      = dv[0]["max_permissions_per_month"] + "";
                    obj.MinPermissionTime           = dv[0]["min_permission_time"] + "";
                    obj.MaxPermissionTime           = dv[0]["max_permission_time"] + "";

                    obj.GroupApplyFlag  = Numerics.GetInt(dv[0]["group_apply_flag"] + "");
                    obj.OfficialFlag    = dv[0]["official_flag"] + "";
                    obj.Code            = dv[0]["code"] + "";
                    obj.DescriptionEn   = dv[0]["description_Eng"] + "";
                    obj.DescriptionAr   = dv[0]["description_Arb"] + "";
                    obj.CommentsEn     = dv[0]["comments_Eng"] + "";
                    obj.CommentsAr     = dv[0]["comments_Arb"] + "";


                    obj.HrOnlyFlag              = Numerics.GetInt(dv[0]["hr_only"] + "");
                    obj.AllowAttachment         = Numerics.GetInt(dv[0]["allow_attachement"] + "");
                    obj.CommentsRequired        = Numerics.GetInt(dv[0]["comments_required"] + "");
                    obj.PermissionTypeID        = Numerics.GetInt(dv[0]["permission_type"] + "");
                    obj.PriorityID              = Numerics.GetInt(dv[0]["permission_priority"] + "");
                    obj.ApplyRamadanRestriction = Numerics.GetInt(dv[0]["ramadan_restriction"] + "");
                    obj.MedicalPassAttachment   = Numerics.GetInt(dv[0]["medical_pass_attachment"] + "");

                    obj.WorkflowId      = dv[0]["Workflow_Id"] + ""; 
                    obj.OrganizationId  = dv[0]["OrganizationId"] + ""; 
                    obj.ManagerId       = dv[0]["ManagerId"] + "";
                    obj.EmployeeId      = dv[0]["EmployeeId"] + "";
                    obj.GroupId         = dv[0]["group_id"] + "";
                    obj.GenderId        = dv[0]["gender_id"] + "";
                    obj.NationalityID   = Numerics.GetInt(dv[0]["nationality_id"] + "");

                    if (dv[0]["valid_from"] + "" != "")
                        obj.ValidFrom = Numerics.GetDateTime(dv[0]["valid_from"]).ToString("dd-MM-yyyy");
                    else
                        obj.ValidFrom = "";

                    if (dv[0]["valid_to"] + "" != "")
                        obj.ValidTo = Numerics.GetDateTime(dv[0]["valid_to"]).ToString("dd-MM-yyyy");
                    else
                        obj.ValidTo = "";

                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["last_updated_time"]);
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

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_PermissionTypeOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string permissionTypeStr = (String)GetGlobalResourceObject("Resource", "permissionType");

                sb.Append("<option value=''>" + chooseStr + " " + permissionTypeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    PermissionType obj = new PermissionType();
                    obj.ID            = Numerics.GetDecimal(row["permission_type_id"] + "");
                    obj.DescriptionEn = row["description_eng"] + "";
                    obj.DescriptionAr = row["description_arb"] + "";
                    obj.CommentsEn    = row["comments_eng"] + "";
                    obj.CommentsAr    = row["comments_arb"] + "";
                    
                    obj.HrOnlyFlag = Convert.ToInt32(row["hr_only"] + "");

                    obj.GenderId = row["gender_id"] + "";


                    if (obj.HrOnlyFlag == 1 && new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_HR_ONLY_PERMISSION_TYPES) == true)
                    {
                        if (cookie.Values["language"] == "ar")
                            sb.Append("<option value='" + obj.ID + "' CommentsRequired='" + row["comments_required"] + "' Comments='" + obj.CommentsAr + "'" + "' hrOnly='" + obj.HrOnlyFlag + "' allowAttachement='" + row["allow_attachement"] + "' genderId='" + obj.GenderId + "' PermissionType='" + row["permission_type"] + "' NationalityId='" + row["nationality_id"] + "'GroupApply='" + row["group_apply_flag"] + "' >" + obj.DescriptionAr + " </option>");
                        else
                            sb.Append("<option value='" + obj.ID + "' CommentsRequired='" + row["comments_required"] + "' Comments='" + obj.CommentsEn + "' hrOnly='" + obj.HrOnlyFlag + "' allowAttachement='" + row["allow_attachement"] + "' genderId='" + obj.GenderId + "' PermissionType='" + row["permission_type"] + "' NationalityId='" + row["nationality_id"] + "'GroupApply='" + row["group_apply_flag"] + "'   >" + obj.DescriptionEn + "  </option>");
                    }
                    else
                    {
                        if (cookie.Values["language"] == "ar")
                            sb.Append("<option value='" + obj.ID + "' CommentsRequired='" + row["comments_required"] + "' Comments='" + obj.CommentsAr + "' hrOnly='" + row["hr_only"] + "' allowAttachement='" + row["allow_attachement"] + "' genderId='" + obj.GenderId + "' PermissionType='" + row["permission_type"] + "' NationalityId='" + row["nationality_id"] + "'GroupApply='" + row["group_apply_flag"] + "' >" + obj.DescriptionAr + " </option>");
                        else
                            sb.Append("<option value='" + obj.ID + "' CommentsRequired='" + row["comments_required"] + "' Comments='" + obj.CommentsEn + "' hrOnly='" + row["hr_only"] + "' allowAttachement='" + row["allow_attachement"] + "' genderId='" + obj.GenderId + "' PermissionType='" + row["permission_type"] + "' NationalityId='" + row["nationality_id"] + "'GroupApply='" + row["group_apply_flag"] + "' >" + obj.DescriptionEn + "  </option>");
                    
                    }
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_PermissionTypeOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/PermissionTypePage.aspx.DeleteByID()", 0, ex);
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

                string[] cols = { "per.permission_type_id", "per.code", "per.description" + languagePostfix, "rsn.description" + languagePostfix, "per.max_permissions", "per.max_minutes", "per.group_apply_flag", "per.Official_flag", "per.last_updated_time", "per.permission_type_id" };

                string orderByClause = "  " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_PermissionTypeOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_PermissionTypeOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["permission_type_id"]) + "' />");
                    tempList.Add(obj["code"] + "");
                    tempList.Add((obj["description" + languagePostfix] + "").Length > 100 ? (obj["description" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["description" + languagePostfix] + ""));
                    tempList.Add((obj["rsnDes" + languagePostfix] + "").Length > 100 ? (obj["rsnDes" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["rsnDes" + languagePostfix] + ""));

                    tempList.Add(obj["max_permissions_per_day"] + "");
                    tempList.Add(obj["max_minutes_per_day"] + "");
                    tempList.Add(obj["max_permissions_per_month"] + "");
                    tempList.Add(obj["max_minutes_minutes_per_month"] + "");

                    //tempList.Add(Numerics.GetBool(obj["official_flag"] + "") + "");
                    if (Numerics.GetBool(obj["official_flag"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    //tempList.Add(Numerics.GetBool(obj["group_apply_flag"] + "") + "");
                    if (Numerics.GetBool(obj["group_apply_flag"] + "") == true)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    tempList.Add(Numerics.GetDateTime(obj["last_updated_time"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_PERMISSIONTYPES) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                    //    tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["permission_type_id"]) + ");' /> &nbsp; ";
                        tempAction = "<a href='" + Page.ResolveClientUrl("~/Common/Save-Permission-Types/" + Encryption.Encrypt((obj["permission_type_id"] + "").Trim())) + "' style='text-decoration: none;'><img src='" + path + "images/edit.png' title='Edit' alt='Edit' /> &nbsp; </a> ";
                      
                    }
                    if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    {
                        //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["permission_type_id"]) + ")' /> ";
                    }
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/PermissionTypePage.aspx.GetAll()", 0, ex);
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
            int groupApply = 0;
            int hrOnly = 0;
            int allowAttachment = 0;
            int CommentsRequired = 0;
            int ApplyRamadanRestriction = 0;
            int MedicalPassAttachment = 0;  
            string officialFlag = "N";

            if ((Request["official"] + "").ToLower() == "true")
                officialFlag = "Y";
            if ((Request["groupApply"] + "").ToLower() == "true")
                groupApply = 1;

            if ((Request["hrOnly"] + "").ToLower() == "true")
                hrOnly = 1;
            if ((Request["allowAttachment"] + "").ToLower() == "true")
                allowAttachment = 1;
            if ((Request["CommentsRequired"] + "").ToLower() == "true")
                CommentsRequired = 1; 
            if ((Request["applyNationality"] + "").ToLower() == "true")
                ApplyRamadanRestriction = 1;
            if ((Request["MedicalPassAttachment"] + "").ToLower() == "true")
                MedicalPassAttachment = 1; 
             
 
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("descriptionEng", (Request["descriptionEn"] + "").Trim());
            ht.Add("descriptionArb", (Request["descriptionAr"] + "").Trim());
            ht.Add("commentsEng", (Request["commentsEn"] + "").Trim());
            ht.Add("commentsArb", (Request["commentsAr"] + "").Trim()); 
            ht.Add("groupApplyFlag", groupApply);
            ht.Add("reasonID", (Request["reasonID"] + "").Trim());
            ht.Add("officialFlag", officialFlag);
            ht.Add("hrOnlyFlag", hrOnly);
            ht.Add("allowAttachment", allowAttachment);
            ht.Add("CommentsRequired", CommentsRequired);
            ht.Add("NationalityId", (Request["NationalityID"] + "").Trim());
            ht.Add("PermissionTypeID", (Request["PermissionTypeID"] + "").Trim());
            ht.Add("PriorityID", (Request["PriorityID"] + "").Trim());
            ht.Add("ApplyRamadanRestriction", ApplyRamadanRestriction);
            ht.Add("MedicalPassAttachment", MedicalPassAttachment);
            

            ht.Add("MaxPermissionsPerDay", (Request["maxPermissionsPerDay"] + "").Trim());
            ht.Add("MaxMinutesPerDay", (Request["maxMinutesPerDay"] + "").Trim());
            ht.Add("MaxPermissionsPerMonth", (Request["maxPermissionsPerMonth"] + "").Trim());
            ht.Add("maxMinutesPerMonth", (Request["maxMinutesPerMonth"] + "").Trim());
            ht.Add("MinPermissionTime", (Request["MinPermissionTime"] + "").Trim());
            ht.Add("MaxPermissionTime", (Request["MaxPermissionTime"] + "").Trim());

            ht.Add("OrganizationId", (Request["OrgId"] + "").Trim());
            ht.Add("GroupId", (Request["GroupId"] + "").Trim());
            ht.Add("EmployeeId", (Request["EmpId"] + "").Trim());
            ht.Add("WorkflowId", (Request["WorkflowId"] + "").Trim());
            ht.Add("GenderId", (Request["Sex"] + "").Trim());

            string FromDate = Request["FromDate"] + "";

            if( FromDate =="null" || FromDate == "")
                    ht.Add("FromDate", DBNull.Value);
            else
                    ht.Add("FromDate", (Request["FromDate"] + "").Trim());

            string ToDate = Request["ToDate"] + ""; 

            if(ToDate == "" || ToDate =="null")
                ht.Add("ToDate", DBNull.Value);
            else
                ht.Add("ToDate", (Request["ToDate"] + "").Trim());


            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_PermissionTypeOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/PermissionTypePage.aspx.Save()", 0, ex);
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