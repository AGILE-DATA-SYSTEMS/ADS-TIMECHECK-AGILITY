using ADS_IRIS;
using ADS_IRIS.DTOs;
using ADS_IRIS.Utilities;
using CMITech.Client.Entities;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using WMD.Constants;
using static WMD.Constants.InfoConstants;

namespace TAMSR2.RequestPages
{
    public partial class ReaderPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        ResponseDTO glbResponse = new ResponseDTO();

        protected void Page_Load(object sender, EventArgs e)
        {

            var httpRequest = HttpContext.Current.Request;
            //httpRequest.Form["RequestMessage"];
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/ReaderPage.aspx"));


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
            else if (Request["key"] + "" == "GetDeviceData")
            {
                data = GetDeviceData();
            }
            else if (Request["key"] + "" == "GetCMIBaseUrl")
            {
                data = Connection.GetCMIBaseUrl();
            }
            else if (Request["key"] + "" == "saveDevice")
            {
                data = SaveDevice();
            }
            else if (Request["key"] + "" == "editDevice")
            {
                data = EditDevice();
            }
            else if (Request["key"] + "" == "getDeviceByID")
            {
                data = GetDeviceByID();
            }
            else if (Request["key"] + "" == "getUsers")
            {
                data = GetUser();
            }
            else if (Request["key"] + "" == "deleteDeviceByID")
            {
                data = DeleteDeviceByID();
            }
            else if (Request["key"] + "" == "saveDeviceFunctions")
            {
                data = SaveDeviceFunctions();
            }
            else if (Request["key"] + "" == "saveDeviceMessage")
            {
                data = SaveDeviceMessage();
            }
            else if ((Request["key"] + "" != null && Request["key"] + "" == "saveDeviceWallpaper") || (httpRequest.Form["Key"] == "saveDeviceWallpaper" && httpRequest.Files.Count > 0))
            {
                data = SaveDeviceWallpaper(httpRequest.Files[0]);
            }
            else if (Request["key"] + "" == "getFunctionKeysByDeviceID")
            {
                data = GetFunctionKeysByDeviceID();
            }
            else if (Request["key"] + "" == "getScreenMessageByDeviceID")
            {
                data = GetScreenMessageByDeviceID();
            }
            else if (Request["key"] + "" == "RebootDevice")
            {
                RebootDevice();
            }
            else if (Request["key"] + "" == "PowerOff")
            {
                PowerOff();
            }
            else if (Request["key"] + "" == "UpdateUserMessage")
            {
                UpdateUserMessage();
            }
            else if (Request["key"] + "" == "SetSpecificTime")
            {
                SetSpecificTime();
            }
            else if (Request["key"] + "" == "StartEnrollment")
            {
                StartEnrollment();
            }
            else if (Request["key"] + "" == "UpdateWallpaper")
            {
                UpdateWallpaper();
            }
            else if (Request["key"] + "" == "SyncEnrollment")
            {
                SyncEnrollment();
            }
            else if (Request["key"] + "" == "SyncUsers")
            {
                StartUserSync();
            }

            else if (Request["key"] + "" == "UpdateKeyLabels")
            {
                UpdateKeyLabels();
                data = JsonConvert.SerializeObject(glbResponse);
            }

            else if (Request["key"] + "" == "AddToSyncTableWithDeleteFlag")
            {
                AddToSyncTableWithDeleteFlag();
                data = JsonConvert.SerializeObject(glbResponse);
            }
            else if (Request["key"] + "" == "getSync")
            {

                glbResponse.Data = GetSync();
                data = JsonConvert.SerializeObject(glbResponse);
            }
            else if (Request["key"] + "" == "deleteSyncData")
            {

                glbResponse.Data = DeleteSyncData();
                data = JsonConvert.SerializeObject(glbResponse);
            }
            else if (Request["key"] + "" == "AddSelectedToSyncTableWithDeleteFlag")
            {

                glbResponse.Data = AddSelectedToSyncTableWithDeleteFlag();
                data = JsonConvert.SerializeObject(glbResponse);
            }

            else
            {
                data = "";
            }

            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            if (glbResponse.Success == true)
            {
                Response.StatusCode = (int)HttpStatusCode.OK;
            }
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
            DBAppSetting AppStng = new DBAppSetting();
            string DefaultLocation = "";

            id = Request["id"] + "";


            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Reader obj = new Reader();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DefaultLocation = AppStng.GetDefaultLocation(Session["ID"] + "", Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderOps", ht);

                if (dv != null)
                {
                    obj.ID = Numerics.GetDecimal(dv[0]["reader_id"]);
                    obj.Code = dv[0]["code"] + "";
                    obj.NameEn = dv[0]["reader_name"] + "";
                    obj.IPAddress = dv[0]["address"] + "";
                    obj.Port = dv[0]["port"] + "";
                    obj.BaudRate = dv[0]["baudrate"] + "";
                    obj.Timeout = dv[0]["connection_timeout"] + "";

                    obj.ReaderTypeName = dv[0]["reader_type_name"] + "";
                    obj.ConnectionID = Numerics.GetDecimal(dv[0]["connection_id"]);
                    obj.ReaderTypeID = Numerics.GetDecimal(dv[0]["reader_type_id"]);
                    obj.ConnectionTypeID = Numerics.GetDecimal(dv[0]["connection_type_id"]);
                    obj.GroupID = Numerics.GetDecimal(dv[0]["group_id"]);
                    obj.LocationID = Numerics.GetDecimal(dv[0]["location_id"]);
                    obj.RegionID = Numerics.GetDecimal(dv[0]["region_id"]);
                    obj.building_id = Numerics.GetInt(dv[0]["building_id"] + "");
                    obj.DirectionID = Numerics.GetDecimal(dv[0]["reader_direction"]);

                    if (dv[0]["reader_location"] + "" != "")
                    {
                        obj.ReaderLocation = dv[0]["reader_location"] + "";
                    }
                    else
                    {
                        obj.ReaderLocation = DefaultLocation;
                    }

                    obj.EnableFlag = Numerics.GetInt(dv[0]["enabled_flag"] + "");
                    obj.WebPunchFlag = Numerics.GetInt(dv[0]["web_punch"] + "");

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


        private UMXClientUtility uMXClientUtility = null;
        string _selectedSerialNum = "";
        public async Task<string> RebootDevice()
        {
            int id = int.Parse(Request["id"]);
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    var updateDeviceTimeResponse = uMXClientUtility.RebootDevice();
                    //AddLog(device.name, updateDeviceTimeResponse.Message);
                    return updateDeviceTimeResponse.Message;
                }
                return resp.Message;
            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response.Message;
        }

        public async Task<ResponseDTO> ConnectAndUpdateStatus(int id)
        {
            var response = new ResponseDTO();

            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                //AddLog(device.name, resp.Message);
                if (resp.Success)
                {
                    await UpdateDeviceStatus(device.id, DeviceStatuses.Online);
                }
                else
                {
                    await UpdateDeviceStatus(device.id, DeviceStatuses.Offline);
                }

                return resp;
            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }

        public async Task<ResponseDTO> PowerOff()
        {
            int id = int.Parse(Request["id"]);
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    var updateDeviceTimeResponse = uMXClientUtility.PowerOffDevice();
                    //update device status
                    await UpdateDeviceStatus(device.id, DeviceStatuses.Offline);
                    return updateDeviceTimeResponse;
                }
                return resp;
            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }

        public async Task<ResponseDTO> SetServerTime()
        {
            int id = int.Parse(Request["id"]);
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    DateTime dt = DateTime.Now;
                    string month, day, hour, minute, year, second = "";
                    if (dt.Month < 10) month = "0" + dt.Month.ToString();
                    else month = dt.Month.ToString();

                    if (dt.Day < 10) day = "0" + dt.Day.ToString();
                    else day = dt.Day.ToString();

                    if (dt.Hour < 10) hour = "0" + dt.Hour.ToString();
                    else hour = dt.Hour.ToString();

                    if (dt.Minute < 10) minute = "0" + dt.Minute.ToString();
                    else minute = dt.Minute.ToString();

                    year = dt.Year.ToString();

                    if (dt.Second < 10) second = "0" + dt.Second.ToString();
                    else second = dt.Second.ToString();

                    string date = month + "" + day + "" + hour + "" + minute + "" + year + "." + second;

                    var updateDeviceTimeResponse = uMXClientUtility.UpdateDeviceTime(date);
                    return updateDeviceTimeResponse;
                }
                return resp;
            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }

        public async Task<ResponseDTO> SetSpecificTime()
        {
            int id = int.Parse(Request["id"]);
            string dateTime = Request["dateTime"];
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    var updateDeviceTimeResponse = uMXClientUtility.UpdateDeviceTime(dateTime);
                    return updateDeviceTimeResponse;
                }
                return resp;

            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }

        #region set wallpaper
        // Updated Wallpaper api/Device/1/Wallpaper
        public async Task<ResponseDTO> UpdateWallpaper()//int id, byte[] image)
        {
            int id = int.Parse(Request["id"]);
            var image = Request["image"].Contains("data:image/jpeg;base64,") ? Request["image"].Replace("data:image/jpeg;base64,", "") : Request["image"];
            image = Request["image"].Contains("data:image/png;base64,") ? Request["image"].Replace("data:image/png;base64,", "") : Request["image"];


            image = image.Replace(" ", "+");
            byte[] bytes = System.Convert.FromBase64String(image);
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    var updateDeviceTimeResponse = uMXClientUtility.SetWallpaper(bytes);
                    return updateDeviceTimeResponse;
                }
                return resp;

            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }
        #endregion

        #region User Message
        // Update User Message api/Device/1/UserMessage/001
        public async Task<ResponseDTO> UpdateUserMessage()
        {
            int id = int.Parse(Request["id"]);
            string message = Request["message"];
            string uid = Request["uid"];
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    var updateDeviceTimeResponse = uMXClientUtility.SetScreenMessage(uid, message);

                    return updateDeviceTimeResponse;
                }
                return resp;

            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }
        #endregion

        #region Enrollment
        // Enrollment api/Device/1/StartEnrollment


        public async Task<ResponseDTO> StartEnrollment()
        {
            int id = int.Parse(Request["id"]);
            string uid = Request["uid"];
            string name = Request["name"];

            UMXClientUtility.AddLog("TIMECHECK", "Enrollment Started");


            UserDTO payload = new UserDTO
            {
                UID = uid,
                FullName = name,
                BothEyeMode = false,
                EitherEyeMode = true,
                FaceFullResolution = false,
                RecogMode = false
            };
            var response = new ResponseDTO();

            UMXClientUtility.AddLog("TIMECHECK", "Device ID:" + id.ToString());
            var device = await GetDevice(id);
            //UMXClientUtility.AddLog("TIMECHECK",  "Device:"+ JsonConvert.SerializeObject(device));

            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);

                //UMXClientUtility.AddLog("TIMECHECK", "GetOrCreateClientUtility:" + JsonConvert.SerializeObject(resp));
                if (resp.Success)
                {
                    payload.deviceID = id.ToString();

                    //UMXClientUtility.AddLog("TIMECHECK", "Enrollment: Starting Enrollment");
                    //uMXClientUtility.AddUsersManually();
                    //if (uMXClientUtility._umxClient.PreviewData)
                    //{
                    var updateDeviceTimeResponse = uMXClientUtility.StartEnrollment(payload);

                    //uMXClientUtility.Disconnect();
                    //UMXClientManager.Remove(device.ipAddress);

                    return updateDeviceTimeResponse;
                    //}

                    //UMXClientUtility.AddLog("TIMECHECK", "StartEnrollment Response :" + JsonConvert.SerializeObject(updateDeviceTimeResponse));
                    //return updateDeviceTimeResponse;
                    // return resp;
                }
                return resp;

            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }


        public async Task<ResponseDTO> StartUserSync()
        {
            int id = int.Parse(Request["id"]);
            //string uid = Request["uid"];
            //string name = Request["name"];

            //UMXClientUtility.AddLog("TIMECHECK", "Enrollment Started");


            //UserDTO payload = new UserDTO
            //{
            //    UID = uid,
            //    FullName = name,
            //    BothEyeMode = true,
            //    EitherEyeMode = false,
            //    FaceFullResolution = false,
            //    RecogMode = false
            //};
            var response = new ResponseDTO();

            UMXClientUtility.AddLog("TIMECHECK", "Device ID:" + id.ToString());
            var device = await GetDevice(id);
            //UMXClientUtility.AddLog("TIMECHECK",  "Device:"+ JsonConvert.SerializeObject(device));

            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);

                //UMXClientUtility.AddLog("TIMECHECK", "GetOrCreateClientUtility:" + JsonConvert.SerializeObject(resp));
                if (resp.Success)
                {
                    //payload.deviceID = id.ToString();

                    UMXClientUtility.AddLog("TIMECHECK", "Enrollment: Starting User Sync");
                    var res = uMXClientUtility.AddUsersManually();
                    //var updateDeviceTimeResponse = uMXClientUtility.StartEnrollment(payload);
                    uMXClientUtility.Disconnect();
                    UMXClientManager.Remove(device.ipAddress);

                    //UMXClientUtility.AddLog("TIMECHECK", "StartEnrollment Response :" + JsonConvert.SerializeObject( updateDeviceTimeResponse));
                    //return updateDeviceTimeResponse;
                    return resp;
                }
                return resp;

            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }
        // Enrollment api/Device/1/EndEnrollment
        public async Task<ResponseDTO> EndEnrollment(int id)
        {
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    var updateDeviceTimeResponse = uMXClientUtility.EndEnrollment();
                    return updateDeviceTimeResponse;
                }
                return resp;

            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }

        // Enrollment api/Device/1/Card
        public async Task<ResponseDTO> UpdateUserCard(int id, Card card)
        {
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    var updateDeviceTimeResponse = uMXClientUtility.UpdateCard(card);
                    return updateDeviceTimeResponse;
                }
                return resp;
            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }

        // Enrollment api/Device/1/SyncEnrollment
        public async Task<ResponseDTO> SyncEnrollment()
        {
            int id = int.Parse(Request["id"]);
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    await GetAndSyncEnrolments(uMXClientUtility, device);
                }
                return resp;

            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }



        // HttpDelete Enrollment api/Device/Enrollment/userID/OperatorCode
        public async Task<ResponseDTO> DeleteEnrollment(string uid, string operatorCode)
        {
            var response = new ResponseDTO();
            var devices = await GetDevices();
            if (devices != null)
            {
                foreach (var device in devices)
                {
                    var resp = GetOrCreateClientUtility(device);
                    if (resp.Success)
                    {
                        var updateDeviceTimeResponse = uMXClientUtility.DeleteEnrollment(uid);
                        return updateDeviceTimeResponse;
                    }
                }
            }
            var d = await deleteEnrollment(uid, operatorCode);
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }
        #endregion

        #region Function Keys
        //Update Key Labels api/Device/1/KeyLabels
        public async Task<ResponseDTO> UpdateKeyLabels()
        {
            int id = int.Parse(Request["id"]);
            string keyNumber = Request["keyNumber"];
            string label = Request["label"];
            string chk = "";
            string[] keyNumberArr = keyNumber.ToString().Split(',');
            string[] labelArr = label.ToString().Split(',');
            var response = new ResponseDTO();
            var device = await GetDevice(id);
            if (device != null)
            {
                var resp = GetOrCreateClientUtility(device);
                if (resp.Success)
                {
                    response = new ResponseDTO();
                    //int i = 0;
                    for (int i = 0; i < keyNumberArr.Length; i++)
                    {
                        var setFunctionKeyLabelsResponse = uMXClientUtility.SetFunctionKeyLabels(GetKeyTitle(int.Parse(keyNumberArr[i])), labelArr[i]);

                        //Save Function keys in db
                        Hashtable ht = new Hashtable();
                        ht.Add("TAMSR2_DeviceId", (id + "").Trim());
                        ht.Add("TAMSR2_FunctionKeyLabel", (keyNumberArr[i] + "").Trim());

                        ht.Add("TAMSR2_FunctionKeyValue", (labelArr[i] + "").Trim());
                        ht.Add("TAMSR2_CreatedDate", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                        ht.Add("TAMSR2_CreatedBy", Session["ID"] + "");
                        ht.Add("TAMSR2_DevicefunctionIdNotIn", Request["DevicefunctionIdNotIn"] == "" ? "0" : Request["DevicefunctionIdNotIn"] + "");

                        TAMSR2Data objDAL = new TAMSR2Data();
                        try
                        {
                            objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                            string result = objDAL.Connection.GetValueProcedure("SP_TAMSR2_DeviceFunctions", ht);
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

                        glbResponse = setFunctionKeyLabelsResponse;
                    }


                    return resp;
                }
                return resp;
            }
            response.Message = InfoConstants.MessageKeys.DEVICE_NOT_FOUND;
            return response;
        }
        #endregion
        #region Add To Sync Table With Delete Flag
        public async Task<ResponseDTO> AddToSyncTableWithDeleteFlag()
        {
            int id = Request["id"] == "" ? 0 : int.Parse(Request["id"]);
            string Type = Request["type"];
            glbResponse = new ResponseDTO();
            if (id != 0)
            {

                Hashtable ht = new Hashtable();
                ht.Add("TAMSR2_DeviceId", (id + "").Trim());
                ht.Add("TAMSR2_CreatedBy", Session["ID"] + "");
                ht.Add("TAMSR2_Type", (Type + "").Trim());

                TAMSR2Data objDAL = new TAMSR2Data();
                try
                {
                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    string result = objDAL.Connection.GetValueProcedure("SP_TAMSR2_AddToSyncTableWithDeleteFlag", ht);
                    glbResponse.Message = "Employees offline sync registered successfully";
                    glbResponse.Success = true;
                }
                catch (Exception ex)
                {
                    new ExceptionLog().WriteLog("RequestPages/ReasonPage.aspx.Save()", 0, ex);
                    glbResponse.Message = ex.Message;
                    glbResponse.Success = false;

                }
                finally
                {
                    objDAL.CloseConnection();
                }
            }
            return glbResponse;
        }
        #endregion
        #region Add Selected To Sync Table With Delete Flag
        public async Task<ResponseDTO> AddSelectedToSyncTableWithDeleteFlag()
        {
            int id = Request["id"] == "" ? 0 : int.Parse(Request["id"]);
            string Type = Request["type"];
            string EmployeeCode = Request["EmployeeCode"];
            string chk = "";
            glbResponse = new ResponseDTO();
            if (id != 0 && EmployeeCode != "" && EmployeeCode != null)
            {

                Hashtable ht = new Hashtable();
                ht.Add("TAMSR2_DeviceId", (id + "").Trim());
                ht.Add("TAMSR2_CreatedBy", Session["ID"] + "");
                ht.Add("TAMSR2_Type", (Type + "").Trim());
                ht.Add("TAMSR2_EmployeeCode", (EmployeeCode + "").Trim());

                TAMSR2Data objDAL = new TAMSR2Data();
                try
                {
                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    string result = objDAL.Connection.GetValueProcedure("SP_TAMSR2_AddSelectedToSyncTableWithDeleteFlag", ht);
                    glbResponse.Message = "Employees offline sync registered successfully";
                    glbResponse.Success = true;
                }
                catch (Exception ex)
                {
                    new ExceptionLog().WriteLog("RequestPages/ReasonPage.aspx.Save()", 0, ex);
                    glbResponse.Message = ex.Message;
                    glbResponse.Success = false;
                }
                finally
                {
                    objDAL.CloseConnection();
                }

            }
            return glbResponse;
        }
        #endregion

        private async Task<DeviceDTO> GetDevice(int deviceId)
        {
            try
            {
                var response = HttpClientUtility.SendRequest("api/Device/GetDeviceById/" + deviceId, "Get", null);

                UMXClientUtility.AddLog("TIMECHECK", "SendRequest:api/Device/GetDeviceById/->" + JsonConvert.SerializeObject(response));

                if (response.IsSuccessStatusCode)
                {
                    var ObjResponse = response.Content.ReadAsStringAsync().Result;
                    var devices = JsonConvert.DeserializeObject<List<DeviceDTO>>(ObjResponse);
                    return devices.FirstOrDefault();
                }
                return null;
            }
            catch (Exception e)
            {
                return null;
            }
        }

        private async Task<List<DeviceDTO>> GetDevices(bool onlyOffline = false)
        {
            try
            {
                var response = HttpClientUtility.SendRequest(onlyOffline == true ? "api/Device/GetOfflineIRISDevices" : "api/Device/GetIRISDevices", "Get", null);
                if (response.IsSuccessStatusCode)
                {
                    var ObjResponse = response.Content.ReadAsStringAsync().Result;
                    var devices = JsonConvert.DeserializeObject<List<DeviceDTO>>(ObjResponse);
                    return devices;
                }
                return null;
            }
            catch (Exception e)
            {
                return null;
            }
        }
        private string GetKeyTitle(int keyNumber)
        {
            if (keyNumber == InfoConstants.FunctionKeys.F1.GetHashCode())
            {
                return InfoConstants.FunctionKeyTitles.F1;
            }
            else if (keyNumber == InfoConstants.FunctionKeys.F2.GetHashCode())
            {
                return InfoConstants.FunctionKeyTitles.F2;
            }
            else if (keyNumber == InfoConstants.FunctionKeys.F3.GetHashCode())
            {
                return InfoConstants.FunctionKeyTitles.F3;
            }
            else if (keyNumber == InfoConstants.FunctionKeys.F4.GetHashCode())
            {
                return InfoConstants.FunctionKeyTitles.F4;
            }
            else if (keyNumber == InfoConstants.FunctionKeys.F5.GetHashCode())
            {
                return InfoConstants.FunctionKeyTitles.F5;
            }
            return null;
        }

        private static async Task GetAndSyncEnrolments(UMXClientUtility uMXClientUtility, DeviceDTO device)
        {
            // get existing 
            var enrolResponse = uMXClientUtility.GetUserList();
            if (enrolResponse.Success == true)
            {
                List<UserSimple> existingUsers = enrolResponse.Data;
                // get all the enrollments since last sync and add
                var response = HttpClientUtility.SendRequest("api/Person/GetEnrolledPerson", "Get", null);
                if (response.IsSuccessStatusCode)
                {
                    var ObjResponse = response.Content.ReadAsStringAsync().Result;
                    var parsed = JsonConvert.DeserializeObject<dynamic>(ObjResponse);
                    List<EnrolPersonDTO> allEnrollments = new List<EnrolPersonDTO>();
                    try
                    {
                        allEnrollments = JsonConvert.DeserializeObject<List<EnrolPersonDTO>>(parsed.ToString());
                    }
                    catch (Exception e)
                    {

                    }
                    //active in db but not in device
                    var syncableEnrollments = allEnrollments.Where(n => n.isDeleted == false && !existingUsers.Any(x => x.UserUUID == n.person_code)).ToList();
                    uMXClientUtility.SyncEnrollments(syncableEnrollments);

                    //offline added enrolments
                    var offlineAddedEnrollments = existingUsers.Where(n => !allEnrollments.Any(x => x.person_code == n.UserUUID));
                    uMXClientUtility.AddUserFromDeviceToDB(offlineAddedEnrollments, device.id);

                    // remove this enrolment from device if deleted in db
                    var deletedEnrollments = existingUsers.Where(n => allEnrollments.Any(x => x.isDeleted == true && x.person_code == n.UserUUID));
                    foreach (var enrol in deletedEnrollments)
                    {
                        uMXClientUtility.DeleteEnrollment(enrol.UserUUID);
                    }
                }
            }
        }

        private static async Task UpdateDeviceStatus(string deviceID, string status)
        {

            var response = HttpClientUtility.SendRequest("api/Device/UpdateDeviceStatus/" + deviceID + "/" + status, "Post", null);
            if (response.IsSuccessStatusCode)
            {
                var ObjResponse = response.Content.ReadAsStringAsync().Result;
            }
        }

        private static async Task<HttpResponseMessage> deleteEnrollment(string user_id, string operatorCode)
        {
            var data = new
            {
                operator_code = operatorCode,
                user_id = user_id
            };
            var stringContent = new StringContent(JsonConvert.SerializeObject(data), UnicodeEncoding.UTF8, "application/json");

            var response = HttpClientUtility.SendRequest("api/Person/deleteenrollment", "Post", stringContent);
            if (response.IsSuccessStatusCode)
            {
                var ObjResponse = response.Content.ReadAsStringAsync().Result;
            }

            return response;
        }
        private ResponseDTO GetOrCreateClientUtility(DeviceDTO device)
        {
            var response = new ResponseDTO();
            var instance = UMXClientManager.Get(device.ipAddress);
            if (instance != null)
            {
                if (!instance.uMXClientUtility.IsConnected())
                {
                    UMXClientManager.Remove(device.ipAddress);
                    uMXClientUtility = new UMXClientUtility();
                    var resp1 = uMXClientUtility.connectUmx(device.ipAddress, "", true);
                    if (resp1.Success)
                    {
                        UMXClientManager.Add(device.ipAddress, device.bioClientID, device.name, uMXClientUtility);
                    }
                }
                else
                {
                    uMXClientUtility = instance.uMXClientUtility;
                }
                response.Success = true;
                return response;
            }
            else
            {
                uMXClientUtility = new UMXClientUtility();
                var resp1 = uMXClientUtility.connectUmx(device.ipAddress, "", true);
                if (resp1.Success)
                {
                    UMXClientManager.Add(device.ipAddress, device.bioClientID, device.name, uMXClientUtility);
                }
                return resp1;
            }
        }
        #region GetSync
        /// <summary>
        /// GetSync function
        /// Get sync from ADS_WDM_SYNC table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetSync()
        {
            DBAppSetting AppStng = new DBAppSetting();
            string DefaultLocation = "";



            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Employee obj = new Employee();
            StringBuilder sb = new StringBuilder();
            string json = "";
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DefaultLocation = AppStng.GetDefaultLocation(Session["ID"] + "", Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("DeviceID", (Request["id"] + "").Trim());
                dv = objDAL.Connection.ExecuteProcedure("SP_GetSync", ht);
                if (dv != null)
                {
                    //string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                    //string deviceGroupStr = (String)GetGlobalResourceObject("Resource", "employee");

                    //sb.Append("<option value=''>" + chooseStr + " " + deviceGroupStr + "</option>");

                    //foreach (DataRow dr in dv.Table.Rows)
                    //{
                    //    sb.Append("<option value='" + dr["employee_code"].ToString() + "'>" + dr["name_eng"].ToString() + " </option>");
                    //}
                    json = JsonConvert.SerializeObject(dv.Table);
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return json;
        }
        //*********End Of GetSync Function*********//
        #endregion

        #region DeleteSyncData
        /// <summary>
        /// DeleteSyncData function
        /// Delete Sync Data from ADS_WDM_SYNC table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string DeleteSyncData()
        {
            DBAppSetting AppStng = new DBAppSetting();
            string DefaultLocation = "";



            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Employee obj = new Employee();
            StringBuilder sb = new StringBuilder();
            string json = "";
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DefaultLocation = AppStng.GetDefaultLocation(Session["ID"] + "", Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("DeviceID", (Request["id"] + "").Trim());
                ht.Add("SyncIds", (Request["syncIds"] + "").Trim());
                dv = objDAL.Connection.ExecuteProcedure("SP_DeleteSyncData", ht);
                if (dv != null)
                {
                    json = JsonConvert.SerializeObject(dv.Table);
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return json;
        }
        //*********End Of GetSync Function*********//
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
        //*********End Of GetDeviceData Function*********//
        #endregion

        #region GetDeviceData
        /// <summary>
        /// GetDeviceData function
        /// Get Devices from ADS_WDM_DEVICES table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetDeviceData()
        {
            string code = "0";
            JQueryResponse json = new JQueryResponse();

            code = Request["Code"] + "";


            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            //Device obj = new Device();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                List<string> tempList = new List<string>();
                string isvalidateStyle = "";
                dv = objDAL.Connection.ExecuteProcedure("GetCMIIRISDevices", ht);

                string DeviceType = Request["DeviceType"] + "";
                string Status = Request["Status"] + "";
                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                //string[] cols = { "rdr.reader_id", "rdr.Status_flag", "rdr.code", "rdr.reader_name", "rdr.reader_type_name", "rdr.last_communication_time", "rdr.firmwarebuilddate", "rdr.address", "rdr.status_flag", "rdr.building_name" + languagePostfix };

                //string orderByClause = " ";
                //orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                //ht = new Hashtable();
                //ht.Add("action", "getCount");
                //ht.Add("sessionID", Session["ID"] + "");
                //ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                //ht.Add("readerTypeName", DeviceType.Trim());
                json.iTotalRecords = dv.Table.Rows.Count;//Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ReaderOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                if (dv != null)
                {

                    foreach (DataRowView obj in dv)
                    {
                        //if (Numerics.GetBool(obj["require_validated_flag"] + "") == true && Numerics.GetBool(obj["validated_flag"] + "") == false)
                        //    isvalidateStyle = " style='color: red !important;'";
                        //else
                        //    isvalidateStyle = "";
                        tempList = new List<string>();
                        tempList.Add("<input type='checkbox' " + isvalidateStyle + " class='checkboxes' value='" + Numerics.GetDecimal(obj["ADS_DeviceID"]) + "' />");
                        tempList.Add("<span " + isvalidateStyle + ">" + (obj["ADS_DeviceCode"] + "").Trim() + "</span>");
                        tempList.Add("<span " + isvalidateStyle + ">" + (obj["ADS_DeviceName"] + "").Trim() + "</span>");
                        tempList.Add("<span " + isvalidateStyle + ">" + ((obj["ADS_DeviceMAC"] + "").Length > 100 ? (obj["ADS_DeviceMAC"] + "").Substring(0, 100) + "..." : (obj["ADS_DeviceMAC"] + "")) + " </span>");
                        tempList.Add("<span " + isvalidateStyle + ">" + (obj["ADS_DeviceIP"] + "").Trim() + "</span>");
                        tempList.Add("<span " + isvalidateStyle + ">" + (obj["ADS_DeviceStatusName"] + "").Trim() + "</span>");
                        //if (Numerics.GetDecimal(obj["ADS_DeviceStatusName"] + "") == 1)
                        //    tempList.Add("<i class='icon-ok'></i>");
                        //else
                        //    tempList.Add("<i class='icon-remove'></i>");
                        string tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick=EditDevice('" + obj["ADS_DeviceID"] + "')></img>";
                        //tempList.Add("<i class='icon-edit' onclick=EditDevice('" + obj["ADS_DeviceID"] + "')></i>");
                        tempList.Add(tempAction);


                        json.aaData.Add(tempList);
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
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetDeviceData Function*********//
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
        #region DeleteDeviceByID
        /// <summary>
        /// DeleteDeviceByID function
        /// Delete Device by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteDeviceByID()
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
                //ht.Add("action", "deleteByIDList");
                //ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int temp = objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_DeleteDevice", ht);
                if (temp > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReasonPage.aspx.DeleteDeviceByID()", 0, ex);
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

                string[] cols = { "rdr.reader_id", "rdr.Status_flag", "rdr.code", "rdr.reader_name", "rdr.reader_type_name", "rdr.last_communication_time", "rdr.firmwarebuilddate", "rdr.address", "rdr.status_flag", "rdr.building_name" + languagePostfix };

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
                ht.Add("readerTypeName", DeviceType.Trim());
                //ht.Add("Status", Status.Trim());
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_ReaderOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                //ht.Add("readerTypeName", (Request["type"] + "").Trim());
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("readerTypeName", DeviceType.Trim());
                //ht.Add("Status", Status.Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_ReaderOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    if (Numerics.GetBool(obj["require_validated_flag"] + "") == true && Numerics.GetBool(obj["validated_flag"] + "") == false)
                        isvalidateStyle = " style='color: red !important;'";
                    else
                        isvalidateStyle = "";


                    //if ((obj["DeviceStatus"] + "") == "Online")
                    //    isOnlineStyle = " style='color: Green !important; font-weight: bold !important; '";
                    //else
                    //    isOnlineStyle = "style='color: red !important; font-weight: bold !important; '";

                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' " + isvalidateStyle + " class='checkboxes' value='" + Numerics.GetDecimal(obj["reader_id"]) + "' />");
                    tempList.Add("<span " + isvalidateStyle + ">" + (obj["code"] + "").Trim() + "</span>");
                    tempList.Add("<span " + isvalidateStyle + ">" + ((obj["reader_name"] + "").Length > 100 ? (obj["reader_name"] + "").Substring(0, 100) + "..." : (obj["reader_name"] + "")) + " </span>");
                    tempList.Add("<span " + isvalidateStyle + ">" + (obj["building_name" + languagePostfix] + "").Trim() + "</span>");
                    if (Numerics.GetDecimal(obj["enabled_flag"] + "") == 1)
                        tempList.Add("<i class='icon-ok'></i>");
                    else
                        tempList.Add("<i class='icon-remove'></i>");

                    //tempList.Add("<span " + isvalidateStyle + ">" + ((obj["reader_type_name"] + "").Length > 100 ? (obj["reader_type_name"] + "").Substring(0, 100) + "..." : (obj["reader_type_name"] + "")) + " </span>");


                    string tempAction = "";
                    tempAction = "";
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_READERS) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='Edit(" + Numerics.GetDecimal(obj["reader_id"]) + ")' /> &nbsp; ";
                    }
                    tempList.Add(tempAction);
                    tempAction = "";
                    if (Numerics.GetBool(obj["require_validated_flag"] + "") == true && Numerics.GetBool(obj["validated_flag"] + "") == false)
                        tempAction += "<img src='" + path + "images/upload.png' title='Validate' alt='Validate' onclick='Validate(" + Numerics.GetDecimal(obj["reader_id"]) + ")' /> &nbsp; ";

                    if (Numerics.GetBool(obj["validated_flag"] + "") == true && (obj["reader_type_name"] + "") == "CS Infotel")
                        tempAction += "<img src='" + path + "images/unvalidate.png' title='InValidate' alt='InValidate' onclick='InValidateDevice(" + Numerics.GetDecimal(obj["reader_id"]) + ")' /> &nbsp; ";

                    tempList.Add(tempAction);
                    tempAction = "";
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



        #region GetDeviceByID
        /// <summary>
        /// GetDeviceByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetDeviceByID()
        {
            string id = "0";
            DBAppSetting AppStng = new DBAppSetting();
            string DefaultLocation = "";

            id = Request["id"] + "";


            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Device obj = new Device();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DefaultLocation = AppStng.GetDefaultLocation(Session["ID"] + "", Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                //ht.Add("action", "GetDeviceByID");
                //ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ADS_DeviceID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_GetDevicebyId", ht);

                if (dv != null)
                {
                    obj.DeviceID = dv[0]["ADS_DeviceID"].ToString();
                    obj.DeviceCode = dv[0]["ADS_DeviceCode"].ToString() + "";
                    obj.DeviceName = dv[0]["ADS_DeviceName"].ToString() + "";
                    obj.MACAddress = dv[0]["ADS_DeviceMAC"].ToString() + "";
                    obj.IPAddress = dv[0]["ADS_DeviceIP"].ToString() + "";
                    obj.IsActive = !Convert.ToBoolean(dv[0]["ADS_Deleted"]);
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
        #region GetUser
        /// <summary>
        /// GetUser function
        /// Get user from employee_master table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetUser()
        {
            DBAppSetting AppStng = new DBAppSetting();
            string DefaultLocation = "";



            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Employee obj = new Employee();
            StringBuilder sb = new StringBuilder();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DefaultLocation = AppStng.GetDefaultLocation(Session["ID"] + "", Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_GetActiveEmployees", ht);
                if (dv != null)
                {
                    string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                    string deviceGroupStr = (String)GetGlobalResourceObject("Resource", "employee");

                    sb.Append("<option value=''>" + chooseStr + " " + deviceGroupStr + "</option>");

                    foreach (DataRow dr in dv.Table.Rows)
                    {
                        sb.Append("<option value='" + dr["employee_code"].ToString() + "'>" + dr["name_eng"].ToString() + " </option>");
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

        #region Get Function Keys
        /// <summary>
        /// Get Function Keys
        /// TAMSR2_DeviceFunctions attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string GetFunctionKeysByDeviceID()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string DeviceId = Request["id"] + "";

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("DeviceId", DeviceId);

                DataView objDataView = objDAL.Connection.ExecuteProcedure("SP_TAMSR2_GetFunctionKeysByDeviceId", ht);
                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add(obj["TAMSR2_FunctionKeyLabel"].ToString() + "_" + obj["TAMSR2_FunctionKeyValue"].ToString());
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

        //*********End Of SaveDevice Function*********//
        #endregion
        #region Get Screen Message
        /// <summary>
        /// Get Function Keys
        /// TAMSR2_SP_TAMSR2_GetScreenMessageByDeviceId attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string GetScreenMessageByDeviceID()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string DeviceId = Request["id"] + "";

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("DeviceId", DeviceId);

                DataView objDataView = objDAL.Connection.ExecuteProcedure("SP_TAMSR2_GetScreenMessageByDeviceId", ht);
                List<string> tempList = new List<string>();
                tempList.Add(objDataView[0]["TAMSR2_Message"].ToString());
                json.aaData.Add(tempList);
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

        //*********End Of SaveDevice Function*********//
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
            int enableFlag = 0;
            int webPunchFlag = 0;

            if ((Request["enableFlag"] + "").ToLower() == "true")
                enableFlag = 1;
            if ((Request["webPunchFlag"] + "").ToLower() == "true")
                webPunchFlag = 1;

            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());

            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("readerName", (Request["name"] + "").Trim());

            ht.Add("readerTypeID", (Request["readerType"] + "").Trim());
            ht.Add("connectionTypeID", (Request["connectionType"] + "").Trim());
            ht.Add("readerDirection", (Request["direction"] + "").Trim());
            ht.Add("groupID", (Request["groupID"] + "").Trim());
            ht.Add("locationID", (Request["locationID"] + "").Trim());
            ht.Add("regionID", (Request["region"] + "").Trim());
            ht.Add("building_id", (Request["building_id"] + "").Trim());
            ht.Add("address", (Request["ipAddress"] + "").Trim());
            ht.Add("port", (Request["port"] + "").Trim());
            ht.Add("baudRate", (Request["baudRage"] + "").Trim());
            ht.Add("timeout", (Request["connTimeout"] + "").Trim());
            ht.Add("ReaderLocation", (Request["ReaderLocation"] + "").Trim());

            ht.Add("enabled", enableFlag);
            ht.Add("webPunch", webPunchFlag);

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

        #region Save Device
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveDevice()
        {
            string chk = "0";
            int enableFlag = 0;
            int webPunchFlag = 0;

            Hashtable ht = new Hashtable();
            //ht.Add("action", "save");

            ht.Add("ADS_DeviceCode", (Request["code"] + "").Trim());
            ht.Add("ADS_DeviceName", (Request["name"] + "").Trim());

            //ht.Add("ADS_LocationID", (Request["readerType"] + "").Trim());
            //ht.Add("ADS_DeviceTypeID", (Request["connectionType"] + "").Trim());
            ht.Add("ADS_DeviceIP", (Request["ipAddress"] + "").Trim());
            ht.Add("ADS_DeviceMAC", (Request["macAddress"] + "").Trim());
            //ht.Add("ADS_LastCommunicationTime", (Request["locationID"] + "").Trim());
            //ht.Add("ADS_PunchTypeID", (Request["region"] + "").Trim());
            //ht.Add("ADS_StatusID", (Request["building_id"] + "").Trim());
            //ht.Add("ADS_isAuthorized", (Request["ipAddress"] + "").Trim());
            //ht.Add("ADS_License", (Request["port"] + "").Trim());
            ht.Add("ADS_Deleted", (Request["isDelete"] == "false" ? 1 : 0));
            ht.Add("ADS_CreatedDate", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("ADS_CreatedBy", Session["ID"] + "");
            ht.Add("ADS_UpdatedDate", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("ADS_UpdatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMS2_AddDevice", ht);
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
        //*********End Of SaveDevice Function*********//
        #endregion

        #region Edit Device
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string EditDevice()
        {
            string chk = "0";
            int enableFlag = 0;
            int webPunchFlag = 0;

            Hashtable ht = new Hashtable();
            //ht.Add("action", "save");

            ht.Add("ADS_DeviceId", (Request["id"] + "").Trim());
            //ht.Add("ADS_DeviceCode", (Request["code"] + "").Trim());
            ht.Add("ADS_DeviceName", (Request["name"] + "").Trim());
            ht.Add("ADS_DeviceIP", (Request["ipAddress"] + "").Trim());
            ht.Add("ADS_DeviceMAC", (Request["macAddress"] + "").Trim());
            ht.Add("ADS_UpdatedDate", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("ADS_UpdatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("TAMS2_UpdateDevice", ht);
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
                new ExceptionLog().WriteLog("RequestPages/ReasonPage.aspx.Update()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of SaveDevice Function*********//
        #endregion

        #region Save Device Functions
        /// <summary>
        /// Save Device Functions
        /// TAMSR2_DeviceFunctions attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveDeviceFunctions()
        {
            string chk = "0";
            int enableFlag = 0;
            int webPunchFlag = 0;
            string Key = Request["FunctionKeyLabel"];
            string KeyValue = Request["FunctionKeyValue"];

            for (int i = 0; i < Key.Split(',').Length; i++)
            {
                Hashtable ht = new Hashtable();
                //ht.Add("action", "save");

                ht.Add("TAMSR2_DeviceId", (Request["DeviceId"] + "").Trim());
                ht.Add("TAMSR2_FunctionKeyLabel", (Key.Split(',')[i] + "").Trim());

                ht.Add("TAMSR2_FunctionKeyValue", (KeyValue.Split(',')[i] + "").Trim());
                ht.Add("TAMSR2_CreatedDate", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("TAMSR2_CreatedBy", Session["ID"] + "");
                ht.Add("TAMSR2_DevicefunctionIdNotIn", Request["DevicefunctionIdNotIn"] == "" ? "0" : Request["DevicefunctionIdNotIn"] + "");

                TAMSR2Data objDAL = new TAMSR2Data();
                try
                {
                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    string result = objDAL.Connection.GetValueProcedure("SP_TAMSR2_DeviceFunctions", ht);
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
            }
            return chk;
        }
        //*********End Of SaveDevice Function*********//
        #endregion

        #region Save Device Message
        /// <summary>
        /// Save Device Functions
        /// TAMSR2_DeviceFunctions attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveDeviceMessage()
        {
            string chk = "0";
            int enableFlag = 0;
            int webPunchFlag = 0;

            Hashtable ht = new Hashtable();
            //ht.Add("action", "save");

            ht.Add("TAMSR2_DeviceId", (Request["DeviceId"] + "").Trim());
            ht.Add("TAMSR2_Message", (Request["Message"] + "").Trim());
            ht.Add("TAMSR2_CreatedDate", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("TAMSR2_CreatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("SP_TAMSR2_DeviceScreenMessage", ht);
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
        //*********End Of SaveDevice Function*********//
        #endregion

        #region Set Device Wallpaper
        /// <summary>
        /// Save Device Wallpaper 
        /// TAMSR2_DeviceFunctions attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string SaveDeviceWallpaper(HttpPostedFile image)
        {
            string FileName = image.FileName;
            string FileExt = image.FileName.Split('.')[image.FileName.Split('.').Length - 1];
            var path = Server.MapPath("~/Uploads/Wallpaper/" + FileName);
            if (!Directory.Exists(Server.MapPath("~/Uploads/Wallpaper/")))
            {
                Directory.CreateDirectory(path);
            }
            image.SaveAs(path);
            string chk = "0";
            int enableFlag = 0;
            int webPunchFlag = 0;
            var Image = Request["Image"];

            //httpRequest.Files[0]
            Hashtable ht = new Hashtable();
            //ht.Add("action", "save");

            ht.Add("TAMSR2_DeviceId", (Request.Form["DeviceId"] + "").Trim());
            ht.Add("TAMSR2_WallpaperPath", (path + "").Trim());
            ht.Add("TAMSR2_CreatedDate", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("TAMSR2_CreatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("SP_AddDeviceWallpaper", ht);
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
        //*********End Of SaveDevice Function*********//
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