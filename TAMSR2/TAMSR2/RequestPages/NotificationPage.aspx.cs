using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
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
    public partial class NotificationPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/NotificationPage.aspx"));


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
            else if (Request["key"] + "" == "validateDevice")
            {
                data = ValidateDevice();
            }
            else if (Request["key"] + "" == "InValidateDevice")
            {
                data = InValidateDevice();
            }
            else if (Request["key"] + "" == "getAll")
            {
                data = GetAll();
            }
            else if (Request["key"] + "" == "getAllByType")
            {
                data = GetAllByType();
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
            else if (Request["key"] + "" == "createAction")
            {
                data = CreateDeviceActions();
            }
            else if (Request["key"] + "" == "SaveSettings")
            {
                data = SaveSettings();
            }
            else if (Request["key"] + "" == "GetDeviceSettingByCode")
            {
                data = GetDeviceSettingByCode();
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
            string id = "0";

            id = Request["id"] + "";


            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            NotificationDescription obj = new NotificationDescription();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_NotificationsDescriptionsOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["notification_description_id"]);
                    obj.Status = Numerics.GetInt(dv[0]["status"] + "");
                    obj.DescriptionEn = dv[0]["description_eng"] + "";
                    obj.DescriptionAr = dv[0]["description_arb"] + "";
                    obj.NotificationType = dv[0]["NotificationType"] + "";
                    obj.CreatedOn = Numerics.GetDateTime(dv[0]["created_date"]);
                    obj.CreatedBy = Numerics.GetDecimal(dv[0]["created_id"]);
                    obj.UpdatedOn = Numerics.GetDateTime(dv[0]["updated_date"]);
                    obj.UpdatedBy = Numerics.GetDecimal(dv[0]["updated_id"]);
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


        #region GetDeviceSettingByCode
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetDeviceSettingByCode()
        {
            string code = "0";

            code = Request["Code"] + "";


            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DeviceSetting obj = new DeviceSetting();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();

                ht.Add("DeviceID", code);
                dv = objDAL.Connection.ExecuteProcedure("CSI_GetDeviceSettings", ht);

                if (dv != null)
                {

                    obj.DeviceID = dv[0]["DeviceID"] + "";
                    obj.Logo = dv[0]["logo"] + "";
                    obj.Sound = dv[0]["sound"] + "";
                    obj.Display = dv[0]["display"] + "";
                    obj.Firmware = dv[0]["firmware"] + "";
                    obj.Screen1 = dv[0]["screen1"] + "";
                    obj.Screen2 = dv[0]["screen2"] + "";
                    obj.Screen3 = dv[0]["screen3"] + "";
                    obj.Screen4 = dv[0]["screen4"] + "";
                    obj.Screen5 = dv[0]["screen5"] + "";
                    obj.Button1 = dv[0]["button1"] + "";
                    obj.Button2 = dv[0]["button2"] + "";
                    obj.Button3 = dv[0]["button3"] + "";
                    obj.Button4 = dv[0]["button4"] + "";
                    obj.Button5 = dv[0]["button5"] + "";
                    obj.Add_User = dv[0]["add_user"] + "";
                    obj.Update_User = dv[0]["update_user"] + "";
                    obj.Delete_User = dv[0]["delete_user"] + "";
                    obj.Message_Timeout = dv[0]["message_timeout"] + "";
                    obj.Display_Timeout = dv[0]["display_timeout"] + "";
                    obj.Server_Address = dv[0]["server_address"] + "";
                    obj.Authentication_Type = dv[0]["authentication_type"] + "";
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string reasonStr = (String)GetGlobalResourceObject("Resource", "readers");

                sb.Append("<option value=''>" + chooseStr + " " + reasonStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Reason obj = new Reason();
                    obj.ID = Numerics.GetDecimal(row["reader_id"] + "");
                    obj.Code = row["code"] + "";
                    obj.DescriptionEn = row["reader_name"] + "";
                    obj.DescriptionAr = row["reader_name"] + "";
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

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_ReaderOps", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReasonPage.aspx.DeleteByID()", 0, ex);
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
            string isvalidateStyle = "";
            string isOnlineStyle = "";
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string DeviceType = Request["DeviceType"] + "";
                string Status = Request["Status"] + "";
                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "nd.notification_description_id", "nd.description_eng" };

                string orderByClause = " ";
                orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];


                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                //ht.Add("readerTypeName", DeviceType.Trim());
                ////ht.Add("Status", Status.Trim());
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_NotificationsDescriptionsOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_NotificationsDescriptionsOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {

                    List<string> tempList = new List<string>();
                    tempList.Add("<span " + isvalidateStyle + ">" + (obj["description_eng"] + "") + " </span>");
                    tempList.Add("<span " + isvalidateStyle + ">" + (obj["description_arb"] + "") + " </span>");
                    tempList.Add("<span " + isvalidateStyle + ">" + (obj["NotificationType"] + "") + " </span>");
                    tempList.Add("<span " + isvalidateStyle + ">" + (obj["name_eng"] + "") + " </span>");
                    if ((obj["updated_date"] + "").Trim() != "")
                        tempList.Add(Numerics.GetDateTime(obj["updated_date"] + "").ToString(AppSetting.dateFormat));

                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_APPLICATION_SETTINGS) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["notification_description_id"]) + ")' /> &nbsp; ";
                    }
                    tempList.Add(tempAction);
                    tempAction = "";
                    tempList.Add(tempAction);
                    tempAction = "";
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/NotificationPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion




        #region GetAllByType
        /// <summary>
        /// GetAllByType function
        ///  
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAllByType()
        {
            string readerType = (Request["readerType"] + "").Trim();

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

                string[] cols = { "rdr.reader_id", "rdr.code", "rdr.reader_name", "rdr.reader_type_name", "dvcGroup.grpName" + languagePostfix, "lc.computer_name", "dvc.connection_name", "dvc.address", "rdr.status_flag", "rdr.polling_type", "rdr.enabled_flag", "rdr.deleted_flag", "rdr.web_punch", "rdr.reason_id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecordsByType");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("readerTypeName", (Request["type"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCountByType");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("readerTypeName", (Request["type"] + "").Trim());
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ReaderOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["reader_id"]) + "' />");
                    tempList.Add(obj["code"] + "");
                    tempList.Add((obj["reader_name"] + "").Length > 100 ? (obj["reader_name"] + "").Substring(0, 100) + "..." : (obj["reader_name"] + ""));
                    tempList.Add((obj["reader_type_name"] + "").Length > 100 ? (obj["reader_type_name"] + "").Substring(0, 100) + "..." : (obj["reader_type_name"] + ""));
                    tempList.Add((obj["grpName" + languagePostfix] + "").Length > 100 ? (obj["grpName" + languagePostfix] + "").Substring(0, 100) + "..." : (obj["grpName" + languagePostfix] + ""));
                    tempList.Add((obj["computer_name"] + "").Length > 100 ? (obj["computer_name"] + "").Substring(0, 100) + "..." : (obj["computer_name"] + ""));
                    tempList.Add((obj["connection_name"] + "").Length > 100 ? (obj["connection_name"] + "").Substring(0, 100) + "..." : (obj["connection_name"] + ""));
                    tempList.Add(obj["address"] + "");

                    if (Numerics.GetDecimal(obj["status_flag"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    if (Numerics.GetDecimal(obj["polling_type"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    if (Numerics.GetDecimal(obj["enabled_flag"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    if (Numerics.GetDecimal(obj["deleted_flag"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");
                    if (Numerics.GetDecimal(obj["web_punch"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    //tempList.Add(Numerics.GetDateTime(obj["last_updated_date"] + "").ToString(AppSetting.dateFormat));
                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_READERS) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["reader_id"]) + ")' /> &nbsp; ";
                    }
                    //if (Numerics.GetBool(Session["CanDelete"]) == true || true)
                    //{
                    //    //tempAction += "<img src='" + path + "images/delete.png' alt='Delete' title='Delete' onclick='Delete(" + Numerics.GetDecimal(obj["reason_id"]) + ")' /> ";
                    //}
                    tempList.Add(tempAction);

                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderOpsPage.aspx.GerAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAllByType Function*********//
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

            if (string.IsNullOrEmpty(Request["descriptionEn"]) || string.IsNullOrEmpty(Request["descriptionAr"]))
            {
                chk = "-1";
                return chk;
            }

            string EnglishEmailScript = string.Empty;
            string ArabicEmailScript  = string.Empty;

            EnglishEmailScript =  (Request["descriptionEn"] + "").Trim();
            ArabicEmailScript =( Request["descriptionAr"] + "").Trim();

            string htmlDecodedEn = WebUtility.HtmlDecode(EnglishEmailScript); 
            string htmlDecodedAr = WebUtility.HtmlDecode(ArabicEmailScript);
            



            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("descriptionEng", htmlDecodedEn);
            ht.Add("descriptionArb", htmlDecodedAr);
            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_NotificationsDescriptionsOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/NotificationPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

        #region SaveSettings

        public string SaveSettings()
        {
            string chk = "0";

            Hashtable ht = new Hashtable();
            ht.Add("Action", "SaveSettings");
            ht.Add("UserId", Session["ID"] + "");

            ht.Add("DeviceID", (Request["code"] + "").Trim());

            ht.Add("Logo", (Request["Logo"] + "").Trim());

            ht.Add("Screen1", (Request["Screen1"] + "").Trim());
            ht.Add("Screen2", (Request["Screen2"] + "").Trim());
            ht.Add("Screen3", (Request["Screen3"] + "").Trim());
            ht.Add("Screen4", (Request["Screen4"] + "").Trim());
            ht.Add("Screen5", (Request["Screen5"] + "").Trim());


            ht.Add("Button1", (Request["Button1"] + "").Trim());
            ht.Add("Button2", (Request["Button2"] + "").Trim());
            ht.Add("Button3", (Request["Button3"] + "").Trim());
            ht.Add("Button4", (Request["Button4"] + "").Trim());
            //ht.Add("Button5", (Request["Button5"] + "").Trim());

            ht.Add("Sound", (Request["sound"] + "").Trim());
            ht.Add("Firmware", (Request["Firmware"] + "").Trim());
            ht.Add("ServerAddress", (Request["ServerAddress"] + "").Trim());

            ht.Add("Display", (Request["display"] + "").Trim());
            ht.Add("Messagetimeout", (Request["messagetimeout"] + "").Trim());
            ht.Add("DisplayTimeOut", (Request["devicetimeout"] + "").Trim());
            ht.Add("AuthenticationType", (Request["AuthenticationType"] + "").Trim());


            ht.Add("AddUser", (Request["enableAddUser"] + "").Trim());
            ht.Add("UpdateUser", (Request["enableUpdateUser"] + "").Trim());
            ht.Add("DeleteUser", (Request["enableDeleteUser"] + "").Trim());

            ht.Add("SavenApply", (Request["SavenApply"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("CSI_PushDeviceSettings", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ReasonPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }


        #endregion



        #region InValidateDevice
        /// <summary>
        /// ValidateDevice function
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string InValidateDevice()
        {
            string chk = "0";

            Hashtable ht = new Hashtable();
            ht.Add("action", "InValidateDevice");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ReaderOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ReasonPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region ValidateDevice
        /// <summary>
        /// ValidateDevice function
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string ValidateDevice()
        {
            string chk = "0";
            int authorizeFlag = 0;

            if ((Request["authorizeFlag"] + "").ToLower() == "true")
                authorizeFlag = 1;

            string regionID = (Request["RegionID"] + "");

            Hashtable ht = new Hashtable();
            ht.Add("action", "validateDevice");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());

            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("readerName", (Request["name"] + "").Trim());

            ht.Add("authorizeFlag", authorizeFlag);
            ht.Add("regionID", regionID);

            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMSR2_ReaderOps", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ReasonPage.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion


        #region CreateDeviceActions

        public string CreateDeviceActions()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            string chk = "0";
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("UserID", Session["ID"] + "");
                ht.Add("Action", (Request["Action"] + "").Trim());
                ht.Add("ActionType", (Request["ActionType"] + "").Trim());

                ht.Add("DeviceCode", (Request["DeviceCode"] + "").Trim());


                ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("createdBy", Session["ID"] + "");

                try
                {
                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    string result = objDAL.Connection.GetValueProcedure("CSI_PushDeviceAction", ht);
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
                    new ExceptionLog().WriteLog("RequestPages/ReaderPage.aspx.CreateDeviceActions()", 0, ex);
                }
                finally
                {
                    objDAL.CloseConnection();
                }
                return chk;
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReaderPage.aspx.CreateDeviceActions()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }


        #endregion

    }
}