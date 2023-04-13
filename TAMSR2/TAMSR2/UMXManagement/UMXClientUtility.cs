using ADS_IRIS.DTOs;
using ADS_IRIS.Utilities;
using CMITech.Client;
using CMITech.Client.Entities;
using CMITech.Client.Enums;
using CMITech.Client.Events;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using static WMD.Constants.InfoConstants;

namespace ADS_IRIS
{
    public class UMXClientUtility
    {
        #region properties
        public IUMXClient _umxClient = null;
        public string deviceName;
        private static bool _enableLogs = Convert.ToBoolean(ConfigurationManager.AppSettings["EnableLogs"]);

        enum ListColumn : int
        {
            ConnMode = 0,
            Address,
            SerialNo,
            Mode
        }

        #region Capture data
        private string uid;
        private string fullName;
        private string deviceID;
        private string cardSerialNo;
        private string cardRemark;
        private bool overwriteUIDInfo;

        private EnrolTemplate _currentEnrolTemplate = null;
        /// <summary>
        /// Face image when capturing face and colored
        /// </summary>
        private EnrolFaceFeature _currentEnrolFarOffFaceFeature = null;
        private FaceFeatureInfo _currentEnrolFarOffFaceFeatureInfo = null;
        /// <summary>
        /// Face image when capturing face and Black/White
        /// </summary>
        private EnrolFaceFeature _currentEnrolFarOnFaceFeature = null;
        private FaceFeatureInfo _currentEnrolFarOnFaceFeatureInfo = null;
        /// <summary>
        /// Face image with glasses when captuing face and Colored
        /// </summary>
        private EnrolFaceFeature _currentEnrolNearOffFaceFeature = null;
        private FaceFeatureInfo _currentEnrolNearOffFaceFeatureInfo = null;
        /// <summary>
        /// Face image with glasses when capturing face and Black/White
        /// </summary>
        private EnrolFaceFeature _currentEnrolNearOnFaceFeature = null;
        private FaceFeatureInfo _currentEnrolNearOnFaceFeatureInfo = null;

        private bool _enrollCompleted = false;
        private bool _bigOffFaceCanEnroll = true;
        private bool _startEnrollCaptureCompleted = false;
        private bool _onMatchingImgae = true;

        private Image _currentEnrolLeftIrisImage = null;
        private byte[] _currentEnrolLeftIris8bppBmpByteArray = null;
        private Image _currentEnrolRightIrisImage = null;
        private byte[] _currentEnrolRightIris8bppBmpByteArray = null;
        private Image _currentEnrolIrisOffFaceImage = null;
        private byte[] _currentEnrolIrisOffFace24bppBmpByteArray = null;
        private Image _currentEnrolFarOffFaceImage = null;
        private byte[] _currentEnrolFarOffFace24bppBmpByteArray = null;
        private Image _currentEnrolFarOnFaceImage = null;
        private byte[] _currentEnrolFarOnFace8bppBmpByteArray = null;
        private Image _currentEnrolNearOffFaceImage = null;
        private byte[] _currentEnrolNearOffFace24bppBmpByteArray = null;
        private Image _currentEnrolNearOnFaceImage = null;
        private byte[] _currentEnrolNearOnFace8bppBmpByteArray = null;
        #endregion

        #endregion
        #region Init Client & device connection
        public ResponseDTO connectUmx(string strIPAddress, string strSrialNumber, bool forceConnect = true)
        {
            var response = new ResponseDTO();
            // Check connect
            if (_umxClient != null && _umxClient.IsConnected())
            {
                response.Message = "Device is already connected.";
                return response;
            }

            _umxClient = CreateClient();
            try
            {
                bool isCheckSerialNumber = false;
                bool isConnect = false;
                if (forceConnect)
                    isConnect = _umxClient.StealConnect(strIPAddress, strSrialNumber, isCheckSerialNumber, true, true, false, 1000, false, false, "", "");
                else
                    isConnect = _umxClient.Connect(strIPAddress, strSrialNumber, isCheckSerialNumber, true, true, false, -1, false, false, "", "");

                if (isConnect)
                {
                    if (strSrialNumber == "") strSrialNumber = _umxClient.GetConfigString("launcher.device.deviceinfo.deviceid");
                    response.Success = true;
                    response.Message = "Successfully connected to UMX " + strSrialNumber;
                }
                else if (forceConnect)
                {
                    response.Message = " Error forcing connection to device.";
                }
                else
                {
                    response.Message = "Device is already connected to another client.  Press Force Connect to steal the connection.";
                }

            }
            catch (DeviceNotFoundException ex)
            {
                response.Message = ex.Message;
            }
            catch (InvalidSerialNumberException ex)
            {
                response.Message = ex.Message;
            }
            catch (UMXException ex)
            {
                response.Message = ex.Message;
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
            }

            return response;
        }
        public bool IsConnected()
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                return _umxClient.IsConnected();
            }
            return false;
        }
        public ResponseDTO Disconnect()
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    if (_umxClient.IsCaptureStarted())
                        _umxClient.StopCapture();
                    if (_umxClient.IsConnected())
                        _umxClient.Disconnect();
                    _umxClient.Close();
                    _umxClient = null;

                    response.Success = true;
                    response.Message = "Disconnected from client.";
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }

            return response;
        }
        public ResponseDTO UpdateDeviceTime(string date)
        {
            var response = new ResponseDTO();
            try
            {
                _umxClient.SetDeviceTime(date);
                response.Success = true;
                response.Message = "Successfully set device's time : " + date;
            }
            catch (DeviceNotFoundException ex)
            {
                response.Message = ex.Message;
            }
            catch (Exception exception)
            {
                response.Message = "Unable to set device's time : " + date + " (" + exception.Message + ")";
            }
            return response;
        }
        public ResponseDTO SetFunctionKeyLabels(string key, string label)
        {
            var response = new ResponseDTO();
            if (_umxClient != null && _umxClient.IsConnected())
            {
                try
                {
                    // Custom key message
                    string key_f1 = _umxClient.GetConfigString(key);

                    //_umxClient.SetConfigString("launcher.auth.customkey.f1.message", "custom message for f1");
                    _umxClient.SetConfigString(key, label);
                    //int key_f1_val = _umxClient.GetConfigInt("launcher.auth.takey.f1");

                    //if ( key == FunctionKeyTitles.F1)
                    //{
                    //    _umxClient.SetConfigInt( "launcher.auth.takey.f1", 0);
                    //}
                    //else if (key == FunctionKeyTitles.F2)
                    //{
                    //    _umxClient.SetConfigInt("launcher.auth.takey.f2", 1); // Code limit : 0 ~ 5
                    //}
                    //else if (key == FunctionKeyTitles.F3)
                    //{
                    //    _umxClient.SetConfigInt("launcher.auth.takey.f3", 2); // Code limit : 0 ~ 5
                    //}
                    //else if (key == FunctionKeyTitles.F4)
                    //{
                    //    _umxClient.SetConfigInt("launcher.auth.takey.f4", 3); // Code limit : 0 ~ 5
                    //}
                    //if (key == FunctionKeyTitles.F5)
                    //{
                    //    _umxClient.SetConfigInt("launcher.auth.takey.f5", 4); // Code limit : 0 ~ 5
                    //}

                    response.Success = true;
                    response.Message = "Labels set successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }
            return response;
        }
        public ResponseDTO SetFunctionKeyMapping()
        {
            var response = new ResponseDTO();
            if (_umxClient != null && _umxClient.IsConnected())
            {
                try
                {
                    int key_f1 = _umxClient.GetConfigInt("launcher.auth.takey.f1");
                    //m_logMessages.AddMessage(LogMessages.Icon.Information, DateTime.Now, "f1 key value : " + key_f1);
                    int key_f2 = _umxClient.GetConfigInt("launcher.auth.takey.f2");

                    _umxClient.SetConfigInt("launcher.auth.takey.f1", 0); // Code limit : 0 ~ 5
                    _umxClient.SetConfigInt("launcher.auth.takey.f2", 1); // Code limit : 0 ~ 5

                    response.Success = true;
                    response.Message = "Labels set successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }
            return response;
        }
        public ResponseDTO SetScreenMessage(string uid, string message)
        {
            var response = new ResponseDTO();
            if (_umxClient != null && _umxClient.IsConnected())
            {
                try
                {
                    if (string.IsNullOrEmpty(uid))
                    {
                        var users = _umxClient.GetUserList();
                        foreach (var user in users)
                        {
                            UserInfo userInfo = _umxClient.GetUserInfoByUUID(user.UserUUID);
                            userInfo.Message = message;
                            _umxClient.UpdateUserInfoByUUID(userInfo);
                        }
                    }
                    else
                    {
                        UserInfo userInfo = _umxClient.GetUserInfoByUUID(uid);
                        userInfo.Message = message;
                        _umxClient.UpdateUserInfoByUUID(userInfo);
                    }

                    response.Success = true;
                    response.Message = "User Message set successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }
            return response;
        }
        public ResponseDTO SetWallpaper(byte[] file)
        {
            var response = new ResponseDTO();
            if (_umxClient != null && _umxClient.IsConnected())
            {
                try
                {
                    _umxClient.SaveFileToDevice(GetUMXFileIndex("Screen saver logo"), file);
                    RebootDevice();
                    response.Success = true;
                    response.Message = "Screen saver logo set successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }
            return response;
        }
        public ResponseDTO PowerOffDevice()
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    _umxClient.PowerOff();
                    response.Success = true;
                    response.Message = "Device powered off successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }
            return response;
        }
        public ResponseDTO RebootDevice()
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    _umxClient.Reboot();
                    response.Success = true;
                    response.Message = "Device rebooted successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }
            return response;
        }
        public ResponseDTO GetLogs(string macAddress, bool deleteLogs = false)
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    List<Log> logs = _umxClient.GetAllLogs();
                    response.Data = MapLogs(macAddress, logs);
                    if (deleteLogs == true)
                    {
                        _umxClient.DeleteAllLogs();
                    }
                    response.Success = true;
                    response.Message = "Logs received successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }

            return response;
        }
        public ResponseDTO IsUserExisting(string uid)
        {
            var response = new ResponseDTO();
            if (_umxClient != null && _umxClient.IsConnected())
            {
                try
                {
                    Subject checkSubject = _umxClient.GetSubject(uid);
                    if (checkSubject.SubjectUID == uid)
                    {
                        response.Success = true;
                        response.Message = "Already exist uuid " + uid;
                        return response;
                    }
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }

            return response;
        }

        public bool AddUsersManually()
        {
            var users = getUsers();
            foreach (var key in users.Keys)
            {
                try
                {
                    try
                    {
                        Subject checkSubject = _umxClient.GetSubject(key);
                        if (checkSubject.SubjectUID == key)
                        {
                            AddLog("TimeCheck", "User " + users[key] + " already exist");
                           // _umxClient.DeleteSubject(key);
                        }
                    }
                    catch(Exception e)
                    {
                        try
                        {
                            Subject subject = new Subject();
                            subject.AccessAllowed = true;
                            subject.LastName = users[key]; // Required                    
                            subject.FirstName = users[key]; // Required                    
                                                            //subject.SubjectUID = Guid.NewGuid().ToString();
                            subject.SubjectUID = key;
                            subject.WiegandSite = 0;
                            subject.WiegandFacility = 0;
                            subject.WiegandCode = 0;
                            subject.WiegandCustom = "";
                            subject.EnrolTemplate = new EnrolTemplate("", "");
                            subject.RecordVersion = 1;
                            _umxClient.AddSubject(subject); 
                            //here it goes to exception 
                                    UserInfo userInfo = new UserInfo();
                                    userInfo.UUID = key;

                                    userInfo.Pin = "";
                                    userInfo.Admin = 0;
                                    userInfo.GroupIndex = 0;
                                    userInfo.ByPassCard = 0;
                                    userInfo.Indivisual = 0;
                                    userInfo.ThreeOutStatus = 0;
                                    userInfo.ThreeOutAccessAllowed = 1;

                                    try
                                    {
                                        _umxClient.AddUserInfo(userInfo);
                                        //System.Threading.Thread.Sleep(100);
                                    }
                                    catch (Exception ex)
                                    {
                                    }
                        }
                        catch(Exception exception)
                            {
                                   
                        }
                    }


                   
                    //System.Threading.Thread.Sleep(100);

                }
                catch (Exception exception)
                {
                    
                }
            }

            return true;
        }

        private Dictionary<string, string> getUsers()
        {
            Dictionary<string, string> EmployeeList = new Dictionary<string, string>();

            //select employee_code, name_eng from employee_master where
            //status_flag = 1 and isnumeric(employee_code)= 1
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Reader obj = new Reader();
            DBAppSetting AppStng = new DBAppSetting();
            string DefaultLocation = "";
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(HttpContext.Current.Session["dbType"] + "", HttpContext.Current.Session["dbName"] + "", HttpContext.Current.Session["dbUser"] + "", HttpContext.Current.Session["dbPassword"] + ""));

                DefaultLocation = AppStng.GetDefaultLocation(HttpContext.Current.Session["ID"] + "", Connection.GetConnectionStrinng(HttpContext.Current.Session["dbType"] + "", HttpContext.Current.Session["dbName"] + "", HttpContext.Current.Session["dbUser"] + "", HttpContext.Current.Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                //ht.Add("action", "getByID");
                //ht.Add("sessionID", HttpContext.Current.Session["ID"] + "");
                //ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_GetActiveEmployees", ht);

                if (dv != null)
                {
                    foreach (DataRow dr in dv.Table.Rows)
                    {
                        EmployeeList.Add(dr["employee_code"].ToString(), dr["name_eng"].ToString());
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

            //EmployeeList.Add("100885", "Raveendran Ramankutty");
            //EmployeeList.Add("1012113", "Mansur Alam");
            //EmployeeList.Add("1012117", "Anwar Hossain");
            //EmployeeList.Add("1026962", "Ibrahim Howlader");
            //EmployeeList.Add("103080", "Ruhoul Amin");
            //EmployeeList.Add("1121015", "Rajesh Kumar");
            //EmployeeList.Add("1124246", "Najmul Hassan");
            //EmployeeList.Add("1130977", "Arifur Rahman");
            //EmployeeList.Add("1154270", "Ibrahim Hamid");
            //EmployeeList.Add("1154274", "Amir Howlader");
            //EmployeeList.Add("1154303", "Rasal Abdur Razzak");
            //EmployeeList.Add("115684", "Babul Miah");
            //EmployeeList.Add("1156871", "Mahatab Uddin");
            //EmployeeList.Add("1171679", "Annaliza Laylo");
            //EmployeeList.Add("1174819", "Rowena Castro");
            //EmployeeList.Add("1183954", "Masum Yousuf");
            //EmployeeList.Add("1183956", "Sohag Shahabuddin");
            //EmployeeList.Add("1198988", "Fadi Jaroua");
            //EmployeeList.Add("1204896", "Sudheesh K K");
            //EmployeeList.Add("1216968", "Balasubramanian Thekkepura");
            //EmployeeList.Add("1217803", "Samah Hamad");
            //EmployeeList.Add("1221260", "Bish Mohan");
            //EmployeeList.Add("1221263", "Sanjay Banjade");
            //EmployeeList.Add("1223656", "Syam Kumar");
            //EmployeeList.Add("1280814", "Wael Fouad");
            //EmployeeList.Add("1285572", "Harischandra Loniya");
            //EmployeeList.Add("1304259", "Jeetha Thankam Titus");
            //EmployeeList.Add("1304469", "Manoj Kumar Pillai");
            //EmployeeList.Add("1304517", "Abdollah Mirshekari Dehkahan");
            //EmployeeList.Add("1305681", "Charbel Youssef Assaad");
            //EmployeeList.Add("1316452", "Resham Neupane");
            //EmployeeList.Add("1318320", "Vishnu Raghu");
            //EmployeeList.Add("1321099", "Bhakta Bahadur");
            //EmployeeList.Add("1321100", "Subhash Chhetri");
            //EmployeeList.Add("1338504", "Remya Vikraman");
            //EmployeeList.Add("1342594", "Bibek Bhujel");
            //EmployeeList.Add("1344445", "Maria Clarissa Diaz");
            //EmployeeList.Add("1345120", "Tak Bahadur Kunwor");
            //EmployeeList.Add("1349341", "Patricia Dellosa");
            //EmployeeList.Add("1349342", "William Batuto");
            //EmployeeList.Add("1351156", "Sangam Chhetri");
            //EmployeeList.Add("1351157", "Khyam Raj Neupane");
            //EmployeeList.Add("1354306", "Indra Bahadur");
            //EmployeeList.Add("1354474", "Saroj Bhat");
            //EmployeeList.Add("136873", "Jonahlee Cruz");
            //EmployeeList.Add("159684", "Zakir Hossain");
            //EmployeeList.Add("170785", "Kamal Hossain");
            //EmployeeList.Add("184486", "Lathesh Kumar");
            //EmployeeList.Add("186066", "Aminul Islam");
            //EmployeeList.Add("191432", "Maria Margarita");
            //EmployeeList.Add("200751", "Pillai Raveendran Velayudhan");
            //EmployeeList.Add("21835", "Mahbub Adam Ali");
            //EmployeeList.Add("233107", "Majd Diek Joseph");
            //EmployeeList.Add("251087", "Nishant Ravi Pillai");
            //EmployeeList.Add("50382", "Lenny Monteiro");
            //EmployeeList.Add("64696", "Hamid Ullah");
            //EmployeeList.Add("98203", "Lydia DSouza");

            return EmployeeList;
        }

        public  ResponseDTO StartEnrollment(UserDTO payload)
        {
            uid = payload.UID;
            fullName = payload.FullName;
            deviceID = payload.deviceID;
            cardSerialNo = payload.CardSerialNo;
            cardRemark = payload.CardRemark;    
            overwriteUIDInfo = payload.OverwriteUIDInfo;
            var response = new ResponseDTO();

           



            if (_umxClient != null && _umxClient.IsConnected ())
            {
              

                try
                {
                    CameraMode mode = _umxClient.GetCameraMode();
                                     
                    switch (mode)
                    {
                        case CameraMode.Slave: // PC Control UI
                            
                                try
                                {
                                 
                                    _umxClient.StartCapture(payload.FaceMode, payload.GlassesMode, payload.BothEyeMode, payload.EitherEyeMode, payload.FaceFullResolution, payload.RecogMode, 5000);

                                   
                                }
                                catch (CMITech.Client.InvalidOperationException iex)
                                {
                                    try
                                    {
                                       _umxClient.StopCapture();
                                     
                                        _umxClient.StartCapture(payload.FaceMode, payload.GlassesMode, payload.BothEyeMode, payload.EitherEyeMode, payload.FaceFullResolution, payload.RecogMode, 5000);
                                       // System.Threading.Thread.Sleep(10000);
                                       }
                                    catch (Exception ex)
                                    {
                                        
                                        response.Message = ex.Message;
                                    }
                                }
                                catch (Exception ex)
                                {
                                    
                                    response.Message = ex.Message;
                                }
                                response.Success = true;
                                response.Message = "Device enrollment is started successfully.";
                            
                            break;
                        case CameraMode.Recog: // Launcher or Recognition UI
                            try
                            {
                                
                                _umxClient.SetCameraMode(CameraMode.Slave);
                                
                                try
                                {
                                  
                                    _umxClient.StartCapture(payload.FaceMode, payload.GlassesMode, payload.BothEyeMode, payload.EitherEyeMode, payload.FaceFullResolution, payload.RecogMode, 5000);
                                    
                                    
                                    System.Threading.Thread.Sleep(10000);
                                       // _umxClient.SetCameraMode(CameraMode.Recog);
                                    

                                    
                                }
                                catch (CMITech.Client.InvalidOperationException iex)
                                {
                                    try
                                    {
                                       
                                        _umxClient.StopCapture();
                                        
                                     
                                        _umxClient.StartCapture(payload.FaceMode, payload.GlassesMode, payload.BothEyeMode, payload.EitherEyeMode, payload.FaceFullResolution, payload.RecogMode, 5000);
                                        System.Threading.Thread.Sleep(10000);
                                        
                                    }
                                    catch (Exception ex)
                                    {
                                        
                                        response.Message = ex.Message;
                                    }
                                }
                                catch (Exception ex)
                                {
                                    
                                    response.Message = ex.Message;
                                }
                                response.Success = true;
                                response.Message = "Device enrollment is started successfully.";
                            }
                            catch (Exception exception)
                            {
                                
                                response.Message = exception.Message;
                            }
                            break;
                        case CameraMode.Enrol: // User or Settings UI
                            response.Message = "Device is used by someone.";
                            break;
                    }
                

                    //UMXClientUtility.AddLog("TIMECHECK", "Main SetCameraMode : CameraMode.Recog");
                    //_umxClient.StopCapture();
                    //System.Threading.Thread.Sleep(20);
                    //_umxClient.SetCameraMode(CameraMode.Recog);
                }
                catch (CMITech.Client.InvalidOperationException iex)
                {

                    _umxClient.StopCapture();
                    _umxClient.SetCameraMode(CameraMode.Recog);

                    
                    response.Message = iex.Message;
                }
                catch (Exception ex)
                {
                    
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Not connected to a device.";
            }

            return response;
        }
        public ResponseDTO EndEnrollment()
        {
            var response = new ResponseDTO();
            if (_umxClient != null && _umxClient.IsConnected())
            {

                try
                {
                    CameraMode mode = _umxClient.GetCameraMode();
                    switch (mode)
                    {
                        case CameraMode.Slave: // PC Control UI
                            try
                            {
                                _umxClient.SetCameraMode(CameraMode.Recog);
                                response.Success = true;
                                response.Message = "Device enrollment is stopped successfully.";
                            }
                            catch (CMITech.Client.InvalidOperationException exception)
                            {
                                response.Message = exception.Message;
                            }
                            catch (Exception exception)
                            {
                                response.Message = exception.Message;
                            }
                            break;
                        case CameraMode.Recog: // Launcher or Recognition UI
                            response.Message = "Device is used by someone.";
                            break;
                    }

                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Not connected to a device.";
            }
            return response;
        }
        public ResponseDTO UpdateCard(Card card)
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    var isExistResp = IsUserExisting(card.UserUID);
                    if (isExistResp.Success == true)
                    {
                        _umxClient.DeleteUserCards(card.UserUID);
                        _umxClient.AddUserCards(card.UserUID, new List<UserCard> { new UserCard { Card = card.SerialNo, Remark = card.Remark } });
                    }
                    response.Success = true;
                    response.Message = "Labels set successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }
            return response;
        }
        public ResponseDTO DeleteEnrollment(string uuid)
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    if (!string.IsNullOrEmpty(uuid) && _umxClient.GetUserInfoByUUID(uuid) != null)
                    {
                        try
                        {
                            _umxClient.DeleteUser(uuid);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete user " + uuid + " (" + exception.Message + ")";
                        }

                        try
                        {
                            _umxClient.DeleteSubject(uuid);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete subject " + uuid + " (" + exception.Message + ")";
                        }

                        try
                        {
                            _umxClient.DeleteFace(uuid, (int)UMXFace.FarOffFace);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete face " + uuid + ", " + (int)UMXFace.FarOffFace + " (" + exception.Message + ")";
                        }

                        try
                        {
                            _umxClient.DeleteFace(uuid, (int)UMXFace.FarOnFace);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete face " + uuid + ", " + (int)UMXFace.FarOnFace + " (" + exception.Message + ")";
                        }

                        try
                        {
                            _umxClient.DeleteFace(uuid, (int)UMXFace.NearOffFace);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete face " + uuid + ", " + (int)UMXFace.NearOffFace + " (" + exception.Message + ")";
                        }

                        try
                        {
                            _umxClient.DeleteFace(uuid, (int)UMXFace.NearOnFace);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete face " + uuid + ", " + (int)UMXFace.NearOnFace + " (" + exception.Message + ")";
                        }

                        try
                        {
                            _umxClient.DeleteFace(uuid, (int)UMXFace.UpOffFace);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete face " + uuid + ", " + (int)UMXFace.UpOffFace + " (" + exception.Message + ")";
                        }

                        try
                        {
                            _umxClient.DeleteFace(uuid, (int)UMXFace.UpOnFace);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete face " + uuid + ", " + (int)UMXFace.UpOnFace + " (" + exception.Message + ")";
                        }

                        try
                        {
                            _umxClient.DeleteUserInfo(uuid);
                        }
                        catch (Exception exception)
                        {
                            response.Message = "Failed to delete userinfo " + uuid + " (" + exception.Message + ")";
                        }

                        if (string.IsNullOrEmpty(response.Message))
                        {
                            response.Success = true;
                            response.Message = " user " + uuid + " delete done";
                        }
                    }
                    else
                    {
                        response.Message = "No user found against uuid " + uuid;
                    }
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }
            else
            {
                response.Message = "Client not connected.";
            }
            return response;
        }
        public ResponseDTO GetEnrollments()
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    List<UserSimple> users = _umxClient.GetUserList();
                    response.Data = users;
                    response.Success = true;
                    response.Message = "Logs received successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }

            return response;
        }
        public ResponseDTO GetUserList()
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    List<UserSimple> users = _umxClient.GetUserList();
                    response.Data = users;
                    response.Success = true;
                    response.Message = "Logs received successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }

            return response;
        }
        public ResponseDTO SyncEnrollments(List<EnrolPersonDTO> enrollments)
        {
            var response = new ResponseDTO();
            if (_umxClient != null)
            {
                try
                {
                    foreach (var enrolment in enrollments)
                    {
                        AddUserFromEnrollment(enrolment);
                    }

                    response.Success = true;
                    response.Message = "Logs received successfully.";
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                }
                catch (Exception ex)
                {
                    response.Message = ex.Message;
                }
            }

            return response;
        }


        #endregion

        #region Private Methods 
        private List<LogDTO> MapLogs(string macAddress, List<Log> logs)
        {
            var logDTOs = new List<LogDTO>();
            foreach (var log in logs)
            {
                logDTOs.Add(new LogDTO { AdditionalData = log.AdditionalData, DeviceIP = _umxClient.IPAddress, DeviceMAC = macAddress, EventType = log.EventType, PersonID = log.SubjectUID, TransactionDateTime = log.Timestamp, Remarks = log.Info });
            }
            return logDTOs;
        }
        private bool AddUser()
        {
            var response = new ResponseDTO();
            if (uid == "")
            {
                response.Message = "Please pass uuid.";
                AddLog(deviceName, "UID is empty. User " + fullName + " not saved.");
                return false;
            }
            if (fullName == "")
            {
                response.Message = "Please pass name.";
                AddLog(deviceName, "Name is empty. UID " + uid + " not saved.");
                return false;
            }

            try
            {
                Subject checkSubject = _umxClient.GetSubject(uid);
                if (checkSubject.SubjectUID == uid)
                {
                    response.Message = "Already exist uuid.";
                    AddLog(deviceName, "UID " + uid + " already exist. Record not saved.");

                    return false;
                }
            }
            catch (Exception exception)
            {
                response.Message = exception.Message;
            }

            var irisDTO = new EnrolPersonDTO();
            irisDTO.WiegandSite = -1;
            irisDTO.person_code = uid;
            irisDTO.person_id = uid;
            irisDTO.person_first_name = fullName;
            irisDTO.person_last_name = fullName;
            irisDTO.WiegandFacility = -1;
            irisDTO.WiegandCode = -1;
            irisDTO.WiegandCustom = "Iamtestingnow";
            irisDTO.deviceId = deviceID;
            irisDTO.expiry_date = "2021-03-20T11:04:15";// DateTime.Now.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss");
            irisDTO.email = "";
            irisDTO.password = "";
            irisDTO.finger_print1 = "";
            irisDTO.finger_print2 = "";
            irisDTO.card = "";
            irisDTO.CardSerialNo = "";
            irisDTO.Remark = "";
            irisDTO.MatchUntil = "";

            User user = new User();
            user.UserUID = uid;

            Subject subject = new Subject();
            subject.AccessAllowed = true;
            subject.FirstName = fullName; // Required 
            subject.LastName = fullName; // Required 
            //subject.SubjectUID = Guid.NewGuid().ToString();
            subject.SubjectUID = uid;
            subject.WiegandSite = -1;
            subject.WiegandFacility = -1;
            subject.WiegandCode = -1;
            subject.WiegandCustom = "Iamtestingnow";

            if (_currentEnrolTemplate != null)
            {
                subject.EnrolTemplate = _currentEnrolTemplate;
                irisDTO.LeftEyeTemplate = _currentEnrolTemplate.LeftEyeTemplate;
                irisDTO.RightEyeTemplate = _currentEnrolTemplate.RightEyeTemplate;
                //irisDTO.LeftEyeTemplate = _currentEnrolLeftIris8bppBmpByteArray;
                //irisDTO.RightEyeTemplate = _currentEnrolRightIris8bppBmpByteArray;

                //irisDTO.LeftEyeTemplateAsBase64 = _currentEnrolTemplate.LeftEyeTemplateAsBase64;
                //irisDTO.RightEyeTemplateAsBase64 = _currentEnrolTemplate.RightEyeTemplateAsBase64;
            }

            //user.Subject = subject;
            _umxClient.AddSubject(subject);

            UserInfo userInfo = new UserInfo();
            userInfo.UUID = uid;
            //userInfo.Card = txtCard.Text; /* Card CSN : 9A 99 1F 3E ...*/
            userInfo.Pin = "";
            userInfo.Admin = 0;
            userInfo.GroupIndex = 0;
            userInfo.ByPassCard = 0;
            userInfo.Indivisual = 0;
            userInfo.ThreeOutStatus = 0;
            userInfo.ThreeOutAccessAllowed = 1;
            //user.UserInfo = userInfo;
            _umxClient.AddUserInfo(userInfo);

            //user.Faces = new List<Face>();

            if (_currentEnrolFarOffFaceFeature != null)
            {
                Face farOffFace = new Face();
                farOffFace.UserID = uid;
                farOffFace.SubId = UMXClient.FarOff;
                farOffFace.FaceEyeWidth = _currentEnrolFarOffFaceFeatureInfo.EyeWidth;
                farOffFace.FaceFeatureSize = (int)_currentEnrolFarOffFaceFeatureInfo.FeatureSize;
                farOffFace.FaceFrontalScore = _currentEnrolFarOffFaceFeatureInfo.FrontalFaceScore;
                farOffFace.FaceLeftEyeX = _currentEnrolFarOffFaceFeatureInfo.LeftEyeX;
                farOffFace.FaceRightEyeX = _currentEnrolFarOffFaceFeatureInfo.RightEyeX;
                farOffFace.FaceRoll = _currentEnrolFarOffFaceFeatureInfo.Roll;
                farOffFace.FaceScore = _currentEnrolFarOffFaceFeatureInfo.Score;
                farOffFace.FaceLEDState = _currentEnrolFarOffFaceFeatureInfo.LEDState;
                farOffFace.EnrolFaceFeature = _currentEnrolFarOffFaceFeature;

                //user.Faces.Add(farOffFace);
                _umxClient.AddFace(farOffFace);

                MapFaceInfo(irisDTO, _currentEnrolFarOffFaceFeature, _currentEnrolFarOffFaceFeatureInfo, UMXClient.FarOff);
            }
            if (_currentEnrolFarOnFaceFeature != null)
            {
                Face farOnFace = new Face();
                farOnFace.UserID = uid;
                farOnFace.SubId = UMXClient.FarOn;
                farOnFace.FaceEyeWidth = _currentEnrolFarOnFaceFeatureInfo.EyeWidth;
                farOnFace.FaceFeatureSize = (int)_currentEnrolFarOnFaceFeatureInfo.FeatureSize;
                farOnFace.FaceFrontalScore = _currentEnrolFarOnFaceFeatureInfo.FrontalFaceScore;
                farOnFace.FaceLeftEyeX = _currentEnrolFarOnFaceFeatureInfo.LeftEyeX;
                farOnFace.FaceRightEyeX = _currentEnrolFarOnFaceFeatureInfo.RightEyeX;
                farOnFace.FaceRoll = _currentEnrolFarOnFaceFeatureInfo.Roll;
                farOnFace.FaceScore = _currentEnrolFarOnFaceFeatureInfo.Score;
                farOnFace.FaceLEDState = _currentEnrolFarOnFaceFeatureInfo.LEDState;
                farOnFace.EnrolFaceFeature = _currentEnrolFarOnFaceFeature;

                //user.Faces.Add(farOnFace);
                _umxClient.AddFace(farOnFace);

                MapFaceInfo(irisDTO, _currentEnrolFarOnFaceFeature, _currentEnrolFarOnFaceFeatureInfo, UMXClient.FarOn);

            }

            if (_currentEnrolNearOffFaceFeature != null)
            {
                Face nearOff = new Face();
                nearOff.UserID = uid;
                nearOff.SubId = UMXClient.NearOff;
                nearOff.FaceEyeWidth = _currentEnrolNearOffFaceFeatureInfo.EyeWidth;
                nearOff.FaceFeatureSize = (int)_currentEnrolNearOffFaceFeatureInfo.FeatureSize;
                nearOff.FaceFrontalScore = _currentEnrolNearOffFaceFeatureInfo.FrontalFaceScore;
                nearOff.FaceLeftEyeX = _currentEnrolNearOffFaceFeatureInfo.LeftEyeX;
                nearOff.FaceRightEyeX = _currentEnrolNearOffFaceFeatureInfo.RightEyeX;
                nearOff.FaceRoll = _currentEnrolNearOffFaceFeatureInfo.Roll;
                nearOff.FaceScore = _currentEnrolNearOffFaceFeatureInfo.Score;
                nearOff.FaceLEDState = _currentEnrolNearOffFaceFeatureInfo.LEDState;
                nearOff.EnrolFaceFeature = _currentEnrolNearOffFaceFeature;

                //user.Faces.Add(nearOff);
                _umxClient.AddFace(nearOff);

                MapFaceInfo(irisDTO, _currentEnrolNearOffFaceFeature, _currentEnrolNearOffFaceFeatureInfo, UMXClient.NearOff);
            }

            if (_currentEnrolNearOnFaceFeature != null)
            {
                Face nearOn = new Face();
                nearOn.UserID = uid;
                nearOn.SubId = UMXClient.NearOn;
                nearOn.FaceEyeWidth = _currentEnrolNearOnFaceFeatureInfo.EyeWidth;
                nearOn.FaceFeatureSize = (int)_currentEnrolNearOnFaceFeatureInfo.FeatureSize;
                nearOn.FaceFrontalScore = _currentEnrolNearOnFaceFeatureInfo.FrontalFaceScore;
                nearOn.FaceLeftEyeX = _currentEnrolNearOnFaceFeatureInfo.LeftEyeX;
                nearOn.FaceRightEyeX = _currentEnrolNearOnFaceFeatureInfo.RightEyeX;
                nearOn.FaceRoll = _currentEnrolNearOnFaceFeatureInfo.Roll;
                nearOn.FaceScore = _currentEnrolNearOnFaceFeatureInfo.Score;
                nearOn.FaceLEDState = _currentEnrolNearOnFaceFeatureInfo.LEDState;
                nearOn.EnrolFaceFeature = _currentEnrolNearOnFaceFeature;

                //user.Faces.Add(nearOn);
                _umxClient.AddFace(nearOn);

                MapFaceInfo(irisDTO, _currentEnrolNearOnFaceFeature, _currentEnrolNearOnFaceFeatureInfo, UMXClient.NearOn);
            }

            user.Cards = new List<Card>();
            if (!string.IsNullOrEmpty(cardSerialNo))
            {
                UserCard card = new UserCard();
                card.SubID = 0;
                card.Card = cardSerialNo;
                irisDTO.CardSerialNo = cardSerialNo;
                card.Remark = cardRemark;
                irisDTO.Remark = cardRemark;

                //user.Cards.Add(card);
                _umxClient.AddUserCards(uid, new List<UserCard> { card });
            }
            //user info added explicitly
            // ading to all the online devices
            //bool saveToDB = false;
            //try
            //{
            //    if (_umxClient.IsExistTemplate(user.Subject) == "")
            //    {
            //        saveToDB = true;
            //        _umxClient.AddUser(user);
            //    }
            //}
            //catch (DeviceNotFoundException ex)
            //{
            //    response.Message = ex.Message;
            //    //return false;
            //    AddLog(deviceName, ex.Message);
            //}
            //catch (Exception exception)
            //{
            //    response.Message = "Unable to add subject " + fullName + " (" + exception.Message + ")";
            //    AddLog(deviceName, response.Message);

            //    //return false;
            //}
            //var clientInfos = UMXClientManager.GetAll();
            //foreach (var info in clientInfos)
            //{
            //    if (info.uMXClientUtility != null)
            //    {
            //        try
            //        {
            //            if (info.uMXClientUtility._umxClient.IsExistTemplate(user.Subject) == "")
            //            {
            //                saveToDB = true;
            //                info.uMXClientUtility._umxClient.AddUser(user);
            //            }
            //        }
            //        catch (DeviceNotFoundException ex)
            //        {
            //            response.Message = ex.Message;
            //            //return false;
            //            AddLog(info.DeviceName, ex.Message);
            //        }
            //        catch (Exception exception)
            //        {
            //            response.Message = "Unable to add subject " + fullName + " (" + exception.Message + ")";
            //            AddLog(info.DeviceName, response.Message);

            //            //return false;
            //        }
            //    }
            //}

            //if (saveToDB == true)
            {
                SaveEnrolmentsToDB(irisDTO);
                uid = "";
                fullName = "";
                deviceID = null;
                if(_umxClient.GetCameraMode() == CameraMode.Slave)
                {
                    _umxClient.SetCameraMode(CameraMode.Recog);
                }

            }
            //update sync time of all online devices

            return true;
        }

        public bool AddUserFromDeviceToDB(IEnumerable<UserSimple> users, string deviceId)
        {
            foreach (var simpleUser in users)
            {
                var irisDTO = new EnrolPersonDTO();
                try
                {
                    Subject userSubject = _umxClient.GetSubject(simpleUser.UserUUID);
                    irisDTO.WiegandSite = userSubject.WiegandSite;
                    irisDTO.person_id = simpleUser.UserUUID;
                    irisDTO.person_code = uid;
                    irisDTO.person_first_name = simpleUser.UserName;
                    irisDTO.person_last_name = simpleUser.UserName;
                    irisDTO.WiegandFacility = userSubject.WiegandFacility;
                    irisDTO.WiegandCode = userSubject.WiegandCode;
                    irisDTO.WiegandCustom = userSubject.WiegandCustom;
                    irisDTO.LeftEyeTemplate = userSubject.EnrolTemplate?.LeftEyeTemplate;
                    irisDTO.RightEyeTemplate = userSubject.EnrolTemplate?.RightEyeTemplate;
                    irisDTO.LeftEyeTemplateAsBase64 = userSubject.EnrolTemplate?.LeftEyeTemplateAsBase64;
                    irisDTO.RightEyeTemplateAsBase64 = userSubject.EnrolTemplate?.RightEyeTemplateAsBase64;

                    irisDTO.deviceId = deviceId;
                    irisDTO.expiry_date = "2021-03-20T11:04:15";// DateTime.Now.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss");
                    irisDTO.email = "";
                    irisDTO.password = "";
                    irisDTO.finger_print1 = "";
                    irisDTO.finger_print2 = "";
                    irisDTO.card = "";
                    irisDTO.CardSerialNo = "";
                    irisDTO.Remark = "";
                    irisDTO.MatchUntil = "";

                    try
                    {
                        var faces = _umxClient.GetFaces(simpleUser.UserUUID);
                        foreach (var face in faces)
                        {
                            irisDTO.FaceEyeWidth = face.FaceEyeWidth;
                            irisDTO.FaceFeatureSize = face.FaceFeatureSize;
                            irisDTO.FaceFrontalScore = face.FaceFrontalScore;
                            irisDTO.FaceLeftEyeX = face.FaceLeftEyeX;
                            irisDTO.FaceRightEyeX = face.FaceRightEyeX;
                            irisDTO.FaceRoll = face.FaceRoll;
                            irisDTO.FaceLEDState = face.FaceLEDState;
                            if (face.SubId == UMXClient.FarOff)
                            {
                                irisDTO.FaceFeature1 = face.EnrolFaceFeature.FaceFeature;
                            }
                            else if (face.SubId == UMXClient.FarOn)
                            {
                                irisDTO.FaceFeature2 = face.EnrolFaceFeature.FaceFeature;
                            }
                            else if (face.SubId == UMXClient.NearOff)
                            {
                                irisDTO.FaceFeature3 = face.EnrolFaceFeature.FaceFeature;
                            }
                            else if (face.SubId == UMXClient.NearOn)
                            {
                                irisDTO.FaceFeature4 = face.EnrolFaceFeature.FaceFeature;
                            }
                        }
                    }
                    catch (Exception e)
                    {

                    }

                    //get card info
                    try
                    {
                        var cards = _umxClient.GetUserCards(simpleUser.UserUUID);
                        foreach (var card in cards)
                        {
                            irisDTO.CardSerialNo = card.Card;
                            irisDTO.Remark = card.Remark;
                            irisDTO.CardSubID = card.SubID;
                        }
                    }
                    catch (Exception ex)
                    {

                    }

                    SaveEnrolmentsToDB(irisDTO);

                }
                catch (Exception exception)
                {
                    var m = exception.Message;
                }
            }
            return true;
        }

        private static void SaveEnrolmentsToDB(EnrolPersonDTO irisDTO)
        {
            var stringContent = new StringContent(JsonConvert.SerializeObject(irisDTO), UnicodeEncoding.UTF8, "application/json");

            var response = HttpClientUtility.SendRequest("api/Person/enroll", "Post", stringContent);
            //if (response.IsSuccessStatusCode)
            //{
            //    var ObjResponse = response.Content.ReadAsStringAsync().Result;
            //    var parsed = JsonConvert.DeserializeObject<dynamic>(ObjResponse);
            //}
        }

        private void MapFaceInfo(EnrolPersonDTO enrollment, EnrolFaceFeature enrolFaceFeature, FaceFeatureInfo faceFeatureInfo, int faceSubId)
        {
            enrollment.FaceEyeWidth = faceFeatureInfo.EyeWidth;
            enrollment.FaceFeatureSize = faceFeatureInfo.FeatureSize;
            enrollment.FaceFrontalScore = faceFeatureInfo.FrontalFaceScore;
            enrollment.FaceLeftEyeX = faceFeatureInfo.LeftEyeX;
            enrollment.FaceRightEyeX = faceFeatureInfo.RightEyeX;
            enrollment.FaceRoll = faceFeatureInfo.Roll;
            enrollment.FaceLEDState = faceFeatureInfo.LEDState;
            if (faceSubId == UMXClient.FarOff)
            {
                enrollment.FaceFeature1 = enrolFaceFeature.FaceFeature;
            }
            else if (faceSubId == UMXClient.FarOn)
            {
                enrollment.FaceFeature2 = enrolFaceFeature.FaceFeature;
            }
            else if (faceSubId == UMXClient.NearOff)
            {
                enrollment.FaceFeature3 = enrolFaceFeature.FaceFeature;
            }
            else if (faceSubId == UMXClient.NearOn)
            {
                enrollment.FaceFeature4 = enrolFaceFeature.FaceFeature;
            }
        }
        private bool AddUserFromEnrollment(EnrolPersonDTO enrollment)
        {
            var response = new ResponseDTO();
            if (enrollment.person_code == "")
            {
                response.Message = "Please pass uuid.";
                return false;
            }
            var userFullName = enrollment.person_first_name;//;enrollment.FirstName + " " + enrollment.LastName;
            if (string.IsNullOrWhiteSpace(userFullName))
            {
                response.Message = "Please pass name.";
                return false;
            }

            try
            {
                Subject checkSubject = _umxClient.GetSubject(enrollment.person_code);
                if (checkSubject.SubjectUID == enrollment.person_code)
                {
                    response.Message = "Already exist uuid.";
                    return false;
                }
            }
            catch (Exception exception)
            {
                response.Message = exception.Message;
            }

            User user = new User();
            user.UserUID = enrollment.person_code;

            Subject subject = new Subject();
            subject.AccessAllowed = true;
            subject.LastName = userFullName; // Required                    
            //subject.SubjectUID = Guid.NewGuid().ToString();
            subject.SubjectUID = enrollment.person_code;
            subject.WiegandSite = enrollment.WiegandSite;
            subject.WiegandFacility = enrollment.WiegandFacility;
            subject.WiegandCode = enrollment.WiegandCode;
            subject.WiegandCustom = enrollment.WiegandCustom;

            subject.EnrolTemplate = new EnrolTemplate(enrollment.LeftEyeTemplate, enrollment.RightEyeTemplate);
            //subject.EnrolTemplate.LeftEyeTemplateAsBase64 = enrollment.LeftEyeTemplateAsBase64;
            //subject.EnrolTemplate.RightEyeTemplateAsBase64 = enrollment.RightEyeTemplateAsBase64;

            _umxClient.AddSubject(subject);
            //user.Subject = subject;

            UserInfo userInfo = new UserInfo();
            userInfo.UUID = enrollment.person_code;
            userInfo.Card = enrollment.CardSerialNo; /* Card CSN : 9A 99 1F 3E ...*/
            userInfo.Pin = "";
            userInfo.Admin = 0;
            userInfo.GroupIndex = 0;
            userInfo.ByPassCard = 0;
            userInfo.Indivisual = 0;
            userInfo.ThreeOutStatus = 0;
            userInfo.ThreeOutAccessAllowed = 1;
            user.UserInfo = userInfo;

            user.Faces = new List<Face>();


            //user.Faces.Add(MapToFace(enrollment, UMXClient.FarOff, enrollment.FaceFeature1));
            //user.Faces.Add(MapToFace(enrollment, UMXClient.FarOn, enrollment.FaceFeature2));
            //user.Faces.Add(MapToFace(enrollment, UMXClient.NearOff, enrollment.FaceFeature3));
            //user.Faces.Add(MapToFace(enrollment, UMXClient.NearOn, enrollment.FaceFeature4));
            _umxClient.AddFace(MapToFace(enrollment, UMXClient.FarOff, enrollment.FaceFeature1));
            _umxClient.AddFace(MapToFace(enrollment, UMXClient.FarOn, enrollment.FaceFeature2));
            _umxClient.AddFace(MapToFace(enrollment, UMXClient.NearOff, enrollment.FaceFeature3));
            _umxClient.AddFace(MapToFace(enrollment, UMXClient.NearOn, enrollment.FaceFeature4));

            user.Cards = new List<Card>();
            if (!string.IsNullOrEmpty(enrollment.CardSerialNo))
            {
                UserCard card = new UserCard();
                card.SubID = 0;
                card.Card = enrollment.CardSerialNo;
                card.Remark = enrollment.Remark;
                //user.Cards.Add(card);
                _umxClient.AddUserCards(uid, new List<UserCard> { card });
            }

            //try
            //{
            //    if (_umxClient.IsExistTemplate(user.Subject) == "")
            //    {
            //        _umxClient.AddUser(user);
            //    }
            //}
            //catch (DeviceNotFoundException ex)
            //{
            //    response.Message = ex.Message;
            //    //return false;
            //    AddLog(deviceName, ex.Message);
            //}
            //catch (Exception exception)
            //{
            //    response.Message = "Unable to add subject " + fullName + " (" + exception.Message + ")";
            //    AddLog(deviceName, response.Message);

            //    //return false;
            //}
            return true;
        }

        private Face MapToFace(EnrolPersonDTO enrollment, int faceSubId, byte[] byteArray)
        {
            Face face = new Face();
            face.UserID = enrollment.person_code;
            face.SubId = faceSubId;
            face.FaceEyeWidth = enrollment.FaceEyeWidth;
            face.FaceFeatureSize = (int)enrollment.FaceFeatureSize;
            face.FaceFrontalScore = enrollment.FaceFrontalScore;
            face.FaceLeftEyeX = enrollment.FaceLeftEyeX;
            face.FaceRightEyeX = enrollment.FaceRightEyeX;
            face.FaceRoll = enrollment.FaceRoll;
            face.FaceScore = enrollment.FaceScore;
            face.FaceLEDState = enrollment.FaceLEDState;
            face.EnrolFaceFeature = new EnrolFaceFeature(byteArray);

            return face;
        }
        private UploadFile GetUMXFileIndex(string fileType)
        {
            switch (fileType)
            {
                case "Enroll logo":
                    return UploadFile.EnrollLogo;
                case "Screen saver logo":
                    return UploadFile.ScreenSaverLogo;
                case "Job code list":
                    return UploadFile.JobCodeList;
                case "Holiday":
                    return UploadFile.Holiday;
                case "Time schedule":
                    return UploadFile.TimeSchedule;
                case "Shift schedule":
                    return UploadFile.ShiftSchedule;
                case "TNASchedule":
                    return UploadFile.TNASchedule;
                case "Custom image":
                    return UploadFile.CustomImage;
                case "Custom sound":
                    return UploadFile.CustomSound;
                case "RFID":
                    return UploadFile.RFID_Firmware;
                case "EFIO":
                    return UploadFile.EFIO_Firmware;
                default:
                    return UploadFile.Unknown;

            }
        }
        private IUMXClient CreateClient()
        {
            IUMXClient client = new UMXClient();
            client.onCaptureCompleted += new CaptureCompletedEventHandler(_client_CaptureCompleted);
            //client.onCaptureTimedOut += new CaptureTimedOutEventHandler(_client_CaptureTimedOut);
            client.onCaptureError += new CaptureErrorEventHandler(_client_CaptureError);
            //client.onCardReadCompleted += new CardReadCompletedEventHandler(_client_CardReadCompleted);
            //client.onCardReadTimedOut += new CardReadTimedOutEventHandler(_client_CardReadTimedOut);
            //client.onCardReadError += new CardReadErrorEventHandler(_client_CardReadError);
            //client.onFwUploadCompleted += new FwUploadCompletedEventHandler(_client_UploadCompleted);
            //client.onFwUploadError += new FwUploadErrorEventHandler(_client_UploadError);
            //client.onFwUploadStatus += new FwUploadStatusEventHandler(_client_ProgressStatus);
            //client.onAccessEventLog += new AccessEventLogEventHandler(_client_AccessEventLog);
            //client.onDeviceEventLog += new DeviceEventLogEventHandler(_client_DeviceEventLog);
            client.onMatchData += new MatchDataEventHandler(_client_MatchData);
            //client.onDoorStatus += new DoorStatusEventHandler(_client_DoorStatus);
            //client.onDeviceStatus += new DeviceStatusEventHandler(client_onDeviceStatus);
            //client.onPreviewImage += new PreviewImageEventHandler(_client_PreviewImage);
            //client.onDiscoveryResult += new DiscoveryEventHandler(_client_DiscoveryResult);
            //client.onDbUploadCompleted += new DbUploadCompletedEventHandler(_client_dbUploadCompleted);
            //client.onDbUploadError += new DbUploadErrorEventHandler(_client_dbUploadError);
            //client.onDbUploadStatus += new DbUploadStatusEventHandler(_client_dbProgressStatus);

            client.onDisconnected += new DisconnectedEventHandler(_client_Disconnected);
            client.onCMIException += new CMIExceptionEventHandler(_client_UMXException);


            return client;
        }
        private bool AddSubject(string uid, string firstName, string lastName)
        {
            var response = new ResponseDTO();
            if (uid == "")
            {
                response.Message = "Please input uuid.";
                return false;
            }
            if (lastName == "")
            {
                response.Message = "Please input name.";
                return false;
            }

            try
            {
                Subject checkSubject = _umxClient.GetSubject(uid);
                if (checkSubject.SubjectUID == uid)
                {
                    response.Message = "Already exist uuid.";
                    return false;
                }
            }
            catch (Exception exception)
            {
                response.Message = exception.Message;
            }

            Subject subject = new Subject();
            subject.AccessAllowed = true;
            //subject.FirstName = enrolForm.FirstName;
            subject.LastName = lastName; // Required                    
            //subject.SubjectUID = Guid.NewGuid().ToString();
            subject.SubjectUID = uid;
            subject.WiegandSite = -1;
            subject.WiegandFacility = -1;
            subject.WiegandCode = -1;
            subject.WiegandCustom = "Iamtestingnow";

            //test 26bit (3byte data + 2bit parity bits)
            //subject.WiegandFacility = Convert.ToInt16(70); // 0x46, 01000110 (1byte date)
            //subject.WiegandCode = Convert.ToInt16(1330); // 0x0532, 00000101 00110010 (2byte data)

            //test 34bit (4byte data + 2bit parity bits)
            //subject.WiegandCode = Convert.ToInt32(1174745772); // 0x460532AC, 01000110 00000101 00110010 10101100 (4byte date)

            //test 50bit (6byte data + 2bit parity bits)
            //subject.WiegandSite = Convert.ToInt16(16); // 00010000 (1byte date)
            //subject.WiegandFacility = Convert.ToInt16(50); // 00110010 (1byte date)
            //subject.WiegandCode = Convert.ToInt32(240); // 00000000 00000000 00000000 11110000 (4byte date)

            //subject.WiegandCode = Convert.ToInt16(enrolForm.WiegandCode);
            if (_currentEnrolTemplate != null)
            {
                subject.EnrolTemplate = _currentEnrolTemplate;

                try
                {
                    string duplicateUUID = _umxClient.IsExistTemplate(subject);
                    if (duplicateUUID != "")
                    {
                        int dedup = _umxClient.GetConfigInt("launcher.device.bio.iris.deduplication");
                        if (dedup == 1) // deduplication on
                        {
                            response.Message = "Already enrolled iris template.";
                            _currentEnrolTemplate = null;
                            return false;
                        }
                        else
                        {
                            response.Message = "Duplicate user was found.";
                            //}
                        }
                    }
                }
                catch (DeviceNotFoundException ex)
                {
                    response.Message = ex.Message;
                    return false;
                }
                catch (Exception exception)
                {
                    if (firstName == "")
                        response.Message = "Unable to enroll user " + lastName + " (" + exception.Message + ")";
                    else
                        response.Message = "Unable to enroll user " + firstName + " " + lastName + " (" + exception.Message + ")";
                    return false;
                }

                /*
#if true // Save image
                if (_currentEnrolLeftIrisImage != null && _currentEnrolLeftIris8bppBmpByteArray != null)
                    _umxClient.SaveBMP8ImageToDevice(UMXImage.LeftIris, _currentEnrolLeftIris8bppBmpByteArray,
                        _currentEnrolLeftIrisImage.Width, _currentEnrolLeftIrisImage.Height);

                if (_currentEnrolRightIrisImage != null && _currentEnrolRightIris8bppBmpByteArray != null)
                    _umxClient.SaveBMP8ImageToDevice(UMXImage.RightIris, _currentEnrolRightIris8bppBmpByteArray,
                        _currentEnrolRightIrisImage.Width, _currentEnrolRightIrisImage.Height);

                if (_currentEnrolIrisOffFaceImage != null && _currentEnrolIrisOffFace24bppBmpByteArray != null)
                    _umxClient.SaveBMP24ImageToDevice(UMXImage.IrisFace, _currentEnrolIrisOffFace24bppBmpByteArray,
                        _currentEnrolIrisOffFaceImage.Width, _currentEnrolIrisOffFaceImage.Height);

                if (_currentEnrolFarOffFaceImage != null && _currentEnrolFarOffFace24bppBmpByteArray != null)
                    _umxClient.SaveBMP24ImageToDevice(UMXImage.FarOffFace, _currentEnrolFarOffFace24bppBmpByteArray,
                        _currentEnrolFarOffFaceImage.Width, _currentEnrolFarOffFaceImage.Height);

                if (_currentEnrolFarOnFaceImage != null && _currentEnrolFarOnFace8bppBmpByteArray != null)
                    _umxClient.SaveBMP8ImageToDevice(UMXImage.FarOnFace, _currentEnrolFarOnFace8bppBmpByteArray,
                        _currentEnrolFarOnFaceImage.Width, _currentEnrolFarOnFaceImage.Height);

                if (_currentEnrolNearOffFaceImage != null && _currentEnrolNearOffFace24bppBmpByteArray != null)
                    _umxClient.SaveBMP24ImageToDevice(UMXImage.NearOffFace, _currentEnrolNearOffFace24bppBmpByteArray,
                        _currentEnrolNearOffFaceImage.Width, _currentEnrolNearOffFaceImage.Height);

                if (_currentEnrolNearOnFaceImage != null && _currentEnrolNearOnFace8bppBmpByteArray != null)
                    _umxClient.SaveBMP8ImageToDevice(UMXImage.NearOnFace, _currentEnrolNearOnFace8bppBmpByteArray,
                        _currentEnrolNearOnFaceImage.Width, _currentEnrolNearOnFaceImage.Height);
#else // New save image
	                if (_currentEnrolLeftIrisImage != null && _currentEnrolLeftIris8bppBmpByteArray != null)
	                    _umxClient.SaveFileToDevice(UMXFile.LeftIris, _currentEnrolLeftIris8bppBmpByteArray, uid);
	
	                if (_currentEnrolRightIrisImage != null && _currentEnrolRightIris8bppBmpByteArray != null)
	                    _umxClient.SaveFileToDevice(UMXFile.RightIris, _currentEnrolRightIris8bppBmpByteArray, uid);
	
	                if (_currentEnrolIrisOffFaceImage != null && _currentEnrolIrisOffFace24bppBmpByteArray != null)
	                    _umxClient.SaveFileToDevice(UMXFile.IrisFace, _currentEnrolIrisOffFace24bppBmpByteArray, uid);
	
	                if (_currentEnrolFarOffFaceImage != null && _currentEnrolFarOffFace24bppBmpByteArray != null)
	                    _umxClient.SaveFileToDevice(UMXFile.FarOffFace, _currentEnrolFarOffFace24bppBmpByteArray, uid);
	
	                if (_currentEnrolFarOnFaceImage != null && _currentEnrolFarOnFace8bppBmpByteArray != null)
	                    _umxClient.SaveFileToDevice(UMXFile.FarOnFace, _currentEnrolFarOnFace8bppBmpByteArray, uid);
	
	                if (_currentEnrolNearOffFaceImage != null && _currentEnrolNearOffFace24bppBmpByteArray != null)
	                    _umxClient.SaveFileToDevice(UMXFile, _currentEnrolNearOffFace24bppBmpByteArray, uid);
	
	                if (_currentEnrolNearOnFaceImage != null && _currentEnrolNearOnFace8bppBmpByteArray != null)
	                    _umxClient.SaveFileToDevice(Client.UMXFile.NearOnFace, _currentEnrolNearOnFace8bppBmpByteArray, uid);
#endif // End of Save image
                */
            }

            try
            {
                System.Diagnostics.Stopwatch sw = new System.Diagnostics.Stopwatch();
                sw.Start();
                _umxClient.AddSubject(subject);
                sw.Stop();
                long duration = sw.ElapsedMilliseconds;
                if (firstName == "")
                    response.Message = "Successfully added subject " + lastName;
                else
                    response.Message = "Successfully added subject " + firstName + " " + lastName;

                //if (true) // save image
                //{
                //    string saveFolder = Path.GetDirectoryName(Application.ExecutablePath) + "\\EnrolledImages";
                //    if (!System.IO.Directory.Exists(saveFolder))
                //    {
                //        System.IO.Directory.CreateDirectory(saveFolder);
                //    }

                //    if (_currentEnrolLeftIrisImage != null)
                //    {
                //        if (_currentEnrolLeftIris8bppBmpByteArray != null)
                //        {
                //            File.WriteAllBytes(saveFolder + "\\" + uid + "_" + Client.Left + ".bmp", _currentEnrolLeftIris8bppBmpByteArray.ToArray());
                //        }
                //    }

                //    if (_currentEnrolRightIrisImage != null)
                //    {
                //        if (_currentEnrolRightIris8bppBmpByteArray != null)
                //        {
                //            File.WriteAllBytes(saveFolder + "\\" + uid + "_" + Client.Right + ".bmp", _currentEnrolRightIris8bppBmpByteArray.ToArray());
                //        }
                //    }

                //    if (_currentEnrolIrisOffFaceImage != null)
                //    {
                //        if (_currentEnrolIrisOffFace24bppBmpByteArray != null)
                //        {
                //            File.WriteAllBytes(saveFolder + "\\" + uid + "_" + Client.IrisFace + ".bmp", _currentEnrolIrisOffFace24bppBmpByteArray.ToArray());
                //        }
                //    }
                //}

            }
            catch (DeviceNotFoundException ex)
            {
                response.Message = ex.Message;
                return false;
            }
            catch (Exception exception)
            {
                if (firstName == "")
                    response.Message = "Unable to add subject " + lastName + " (" + exception.Message + ")";
                else
                    response.Message = "Unable to add subject " + firstName + " " + lastName + " (" + exception.Message + ")";
                return false;
            }

            return true;
        }
        private bool AddUserInfo(string uid, string firstName, string lastName)
        {
            var response = new ResponseDTO();
            UserInfo userInfo = new UserInfo();
            userInfo.UUID = uid;
            //userInfo.Card = txtCard.Text; /* Card CSN : 9A 99 1F 3E ...*/
            userInfo.Pin = "";
            userInfo.Admin = 0;
            userInfo.GroupIndex = 0;
            userInfo.ByPassCard = 0;
            userInfo.Indivisual = 0;
            userInfo.ThreeOutStatus = 0;
            userInfo.ThreeOutAccessAllowed = 1;

            try
            {
                _umxClient.AddUserInfo(userInfo);

                if (firstName == "")
                    response.Message = "Successfully added userinfo " + lastName;
                else
                    response.Message = "Successfully added userinfo " + firstName + " " + lastName;
            }
            catch (DeviceNotFoundException ex)
            {
                response.Message = ex.Message;
                return false;
            }
            catch (Exception exception)
            {
                if (firstName == "")
                    response.Message = "Unable to add userinfo " + lastName + " (" + exception.Message + ")";
                else
                    response.Message = "Unable to add userinfo " + firstName + " " + lastName + " (" + exception.Message + ")";
                return false;
            }

            return true;
        }
        #endregion

        #region Events
        private void _client_CaptureCompleted(CaptureCompletedEventArgs captureCompletedEventArgs)
        {
            if (captureCompletedEventArgs == null) return;

            //if (this.InvokeRequired)
            //{
            //    BeginInvoke(new MethodInvoker(delegate () { _client_CaptureCompleted(captureCompletedEventArgs); }));
            //}
            //else
            {
                if (captureCompletedEventArgs.CaptureData.ErrorMessage == "color lens detected")
                {
                    //m_enrollLogMessages.AddMessage(LogMessages.Icon.Warning, DateTime.Now, "Color lens detected");
                    //return;
                }
                if (captureCompletedEventArgs.CaptureData.Completed)
                {
                    //ending camera slave mode
                    _umxClient.SetCameraMode(CameraMode.Recog);

                    //setting data to save later
                    _currentEnrolLeftIrisImage = captureCompletedEventArgs.CaptureData.LeftEye;
                    _currentEnrolLeftIris8bppBmpByteArray = captureCompletedEventArgs.CaptureData.LeftEye8bitBmpByteArray;
                    //pictureBoxLeftEye.Image = captureCompletedEventArgs.CaptureData.LeftEye;
                    //if (pictureBoxLeftEye.Image == null) pictureBoxLeftEye.Image = convertingByteArrayToImage(_currentEnrolLeftIris8bppBmpByteArray);

                    _currentEnrolRightIrisImage = captureCompletedEventArgs.CaptureData.RightEye;
                    _currentEnrolRightIris8bppBmpByteArray = captureCompletedEventArgs.CaptureData.RightEye8bitBmpByteArray;
                    //pictureBoxRightEye.Image = captureCompletedEventArgs.CaptureData.RightEye;
                    //if (pictureBoxRightEye.Image == null) pictureBoxRightEye.Image = convertingByteArrayToImage(_currentEnrolRightIris8bppBmpByteArray);

                    _currentEnrolIrisOffFaceImage = captureCompletedEventArgs.CaptureData.IrisOffFace;
                    _currentEnrolIrisOffFace24bppBmpByteArray = captureCompletedEventArgs.CaptureData.IrisOffFace24bitBmpByteArray;
                    //pictureBoxIrisFace.Image = captureCompletedEventArgs.CaptureData.IrisOffFace;
                    //if (pictureBoxIrisFace.Image == null) pictureBoxIrisFace.Image = convertingByteArrayToImage(_currentEnrolIrisOffFace24bppBmpByteArray);

                    _currentEnrolFarOffFaceImage = captureCompletedEventArgs.CaptureData.FarOffFace;
                    _currentEnrolFarOffFace24bppBmpByteArray = captureCompletedEventArgs.CaptureData.FarOffFace24bitBmpByteArray;
                    //pictureBoxFaceOff.Image = captureCompletedEventArgs.CaptureData.FarOffFace;
                    //if (pictureBoxFaceOff.Image == null) pictureBoxFaceOff.Image = convertingByteArrayToImage(_currentEnrolFarOffFace24bppBmpByteArray);

                    _currentEnrolFarOnFaceImage = captureCompletedEventArgs.CaptureData.FarOnFace;
                    _currentEnrolFarOnFace8bppBmpByteArray = captureCompletedEventArgs.CaptureData.FarOnFace8bitBmpByteArray;
                    //pictureBoxFaceOn.Image = captureCompletedEventArgs.CaptureData.FarOnFace;
                    //if (pictureBoxFaceOn.Image == null) pictureBoxFaceOn.Image = convertingByteArrayToImage(_currentEnrolFarOnFace8bppBmpByteArray);

                    _currentEnrolNearOffFaceImage = captureCompletedEventArgs.CaptureData.NearOffFace;
                    _currentEnrolNearOffFace24bppBmpByteArray = captureCompletedEventArgs.CaptureData.NearOffFace24bitBmpByteArray;
                    //pictureBoxFaceOff1.Image = captureCompletedEventArgs.CaptureData.NearOffFace;
                    //if (pictureBoxFaceOff1.Image == null) pictureBoxFaceOff1.Image = convertingByteArrayToImage(_currentEnrolNearOffFace24bppBmpByteArray);

                    _currentEnrolNearOnFaceImage = captureCompletedEventArgs.CaptureData.NearOnFace;
                    _currentEnrolNearOnFace8bppBmpByteArray = captureCompletedEventArgs.CaptureData.NearOnFace8bitBmpByteArray;
                    //pictureBoxFaceOn1.Image = captureCompletedEventArgs.CaptureData.NearOnFace;
                    //if (pictureBoxFaceOn1.Image == null) pictureBoxFaceOn1.Image = convertingByteArrayToImage(_currentEnrolNearOnFace8bppBmpByteArray);

                    // Save completed capture images
                    string saveFolder = Path.GetDirectoryName(AppDomain.CurrentDomain.BaseDirectory) + "\\CapturedImages";
                    if (!System.IO.Directory.Exists(saveFolder))
                    {
                        System.IO.Directory.CreateDirectory(saveFolder);
                    }

                    DateTime captureTime = captureCompletedEventArgs.CaptureData.Timestamp.ToLocalTime();

                    if (_currentEnrolLeftIris8bppBmpByteArray != null) saveFile(saveFolder, captureTime, UMXClient.Left, _currentEnrolLeftIris8bppBmpByteArray);
                    if (_currentEnrolRightIris8bppBmpByteArray != null) saveFile(saveFolder, captureTime, UMXClient.Right, _currentEnrolRightIris8bppBmpByteArray);
                    if (_currentEnrolIrisOffFace24bppBmpByteArray != null) saveFile(saveFolder, captureTime, UMXClient.IrisFace, _currentEnrolIrisOffFace24bppBmpByteArray);
                    if (_currentEnrolFarOffFace24bppBmpByteArray != null) saveFile(saveFolder, captureTime, UMXClient.FarOff.ToString(), _currentEnrolFarOffFace24bppBmpByteArray);
                    if (_currentEnrolFarOnFace8bppBmpByteArray != null) saveFile(saveFolder, captureTime, UMXClient.FarOn.ToString(), _currentEnrolFarOnFace8bppBmpByteArray);
                    if (_currentEnrolNearOffFace24bppBmpByteArray != null) saveFile(saveFolder, captureTime, UMXClient.NearOff.ToString(), _currentEnrolNearOffFace24bppBmpByteArray);
                    if (_currentEnrolNearOnFace8bppBmpByteArray != null) saveFile(saveFolder, captureTime, UMXClient.NearOn.ToString(), _currentEnrolNearOnFace8bppBmpByteArray);

                    if (captureCompletedEventArgs.CaptureData.EnrolTemplate.LeftEyeTemplate.Length > 0)
                        System.IO.File.WriteAllBytes(string.Format(@"{0}\{1}_leftEye.fet", saveFolder, captureTime.ToString("yyyy-MM-dd HH.mm.ss")), captureCompletedEventArgs.CaptureData.EnrolTemplate.LeftEyeTemplate);
                    if (captureCompletedEventArgs.CaptureData.EnrolTemplate.RightEyeTemplate.Length > 0)
                        System.IO.File.WriteAllBytes(string.Format(@"{0}\{1}_rightEye.fet", saveFolder, captureTime.ToString("yyyy-MM-dd HH.mm.ss")), captureCompletedEventArgs.CaptureData.EnrolTemplate.RightEyeTemplate);

                    // Deduplicate
                    if ((captureCompletedEventArgs.CaptureData.LeftEyeDuplicateUUID != "" && captureCompletedEventArgs.CaptureData.LeftEyeDuplicateUUID != null)
                        || (captureCompletedEventArgs.CaptureData.RightEyeDuplicateUUID != "" && captureCompletedEventArgs.CaptureData.RightEyeDuplicateUUID != null))
                    /*
                    || (captureCompletedEventArgs.FarOffFaceDuplicateUUID != "" && captureCompletedEventArgs.FarOffFaceDuplicateUUID != null)
                    || (captureCompletedEventArgs.FarOnFaceDuplicateUUID != "" && captureCompletedEventArgs.FarOnFaceDuplicateUUID != null)
                    || (captureCompletedEventArgs.NearOffFaceDuplicateUUID != "" && captureCompletedEventArgs.NearOffFaceDuplicateUUID != null)
                    || (captureCompletedEventArgs.NearOnFaceDuplicateUUID != "" && captureCompletedEventArgs.NearOnFaceDuplicateUUID != null))
                    */
                    {
                        int dedup = _umxClient.GetConfigInt("launcher.device.bio.iris.deduplication");
                        if (dedup == 1) // deduplication on
                        {
                            //MessageBox.Show("Already enrolled iris template.", "Error message", MessageBoxButtons.OK);
                            AddLog(deviceName, "Already enrolled iris template. User " + fullName + " not saved.");
                            _currentEnrolTemplate = null;
                            _enrollCompleted = true;
                            return;
                        }
                        else
                        {
                            //if (MessageBox.Show("Duplicate user was found.\n Do you like to continue?", "Message", MessageBoxButtons.YesNo) == DialogResult.Yes)
                            //{
                            //    // YES
                            //}
                            //else
                            //{
                            //    // NO
                            //    return;
                            //}
                        }
                    }

                    _currentEnrolTemplate = captureCompletedEventArgs.CaptureData.EnrolTemplate;
                    _currentEnrolFarOffFaceFeature = captureCompletedEventArgs.CaptureData.EnrolFarOffFaceFeature;
                    _currentEnrolFarOffFaceFeatureInfo = captureCompletedEventArgs.CaptureData.FarOffFaceFeatureInfo;
                    _currentEnrolFarOnFaceFeature = captureCompletedEventArgs.CaptureData.EnrolFarOnFaceFeature;
                    _currentEnrolFarOnFaceFeatureInfo = captureCompletedEventArgs.CaptureData.FarOnFaceFeatureInfo;
                    _currentEnrolNearOffFaceFeature = captureCompletedEventArgs.CaptureData.EnrolNearOffFaceFeature;
                    _currentEnrolNearOffFaceFeatureInfo = captureCompletedEventArgs.CaptureData.NearOffFaceFeatureInfo;
                    _currentEnrolNearOnFaceFeature = captureCompletedEventArgs.CaptureData.EnrolNearOnFaceFeature;
                    _currentEnrolNearOnFaceFeatureInfo = captureCompletedEventArgs.CaptureData.NearOnFaceFeatureInfo;

                    StringBuilder sb = new StringBuilder();
                    if (captureCompletedEventArgs.CaptureData.LeftEyeImageQualityMetrics != null)
                    {
                        sb.Append("Left image metrics: ");
                        sb.Append("Usable Iris Area - ");
                        sb.Append(captureCompletedEventArgs.CaptureData.LeftEyeImageQualityMetrics.UsableIrisArea);
                        sb.Append(" Quality Score - ");
                        sb.Append(captureCompletedEventArgs.CaptureData.LeftEyeImageQualityMetrics.QualityScore);
                        sb.Append(" Quality Ok - ");
                        sb.Append(captureCompletedEventArgs.CaptureData.LeftEyeImageQualityMetrics.QualityOk);
                    }
                    if (captureCompletedEventArgs.CaptureData.RightEyeImageQualityMetrics != null)
                    {
                        sb.Append(" Right image metrics:");
                        sb.Append(" Usable Iris Area - ");
                        sb.Append(captureCompletedEventArgs.CaptureData.RightEyeImageQualityMetrics.UsableIrisArea);
                        sb.Append(" Quality Score - ");
                        sb.Append(captureCompletedEventArgs.CaptureData.RightEyeImageQualityMetrics.QualityScore);
                        sb.Append(" Quality Ok - ");
                        sb.Append(captureCompletedEventArgs.CaptureData.RightEyeImageQualityMetrics.QualityOk);
                    }

                    //if (captureCompletedEventArgs.CaptureData.LeftEyeImageQualityMetrics != null || captureCompletedEventArgs.CaptureData.RightEyeImageQualityMetrics != null)
                    //    m_enrollLogMessages.AddMessage(LogMessages.Icon.Information, DateTime.Now, sb.ToString());

                    _startEnrollCaptureCompleted = true;
                    AddUser();
                }
                else
                {
                    // m_enrollLogMessages.AddMessage(LogMessages.Icon.Error, DateTime.Now, "Capture failed");
                }
            }
        }
        private void _client_CaptureError(Exception error)
        {
            var errorMessage = error.Message;
            //if (this.InvokeRequired)
            //{
            //    BeginInvoke(new MethodInvoker(delegate () { _client_CaptureError(error); }));
            //}
            //else
            //{
            //    m_enrollLogMessages.AddMessage(LogMessages.Icon.Error, DateTime.Now, "Capture Error: " + error.Message);
            //}
        }
        private void _client_MatchData(MatchDataEventArgs matchDataEventArgs)
        {
            var uid = matchDataEventArgs.UUID;
            var IrisFace = UMXClient.IrisFace;
            var pictureBoxLeftEyeImage = matchDataEventArgs.LeftEye;
            var pictureBoxRightEyeImage = matchDataEventArgs.RightEye;
            var LogId = matchDataEventArgs.LogId;
            //if (this.InvokeRequired)
            //{
            //    BeginInvoke(new MethodInvoker(delegate () { _client_MatchData(matchDataEventArgs); }));
            //    //m_logMessages.AddMessage(LogMessages.Icon.Information, DateTime.Now, "BeginInvoke _client_MatchData test");
            //}
            //else
            //{
            //    //m_logMessages.AddMessage(LogMessages.Icon.Information, DateTime.Now, "_client_MatchData test");

            //    var BackgroundImage = null;
            //    //this.alphaBTextBox_topIrisInfoBack.Hide();
            //    //this.pictureBox_irisGuide.Hide();
            //    //this.alphaBTextBox_openEyesInfoTxt.Hide();

            //    pictureBoxLeftEye.Image = null;
            //    pictureBoxRightEye.Image = null;
            //    pictureBoxFaceOff.Image = null;
            //    pictureBoxFaceOn.Image = null;
            //    pictureBoxFaceOff1.Image = null;
            //    pictureBoxFaceOn1.Image = null;
            //    pictureBoxIrisFace.Image = null;

            //    if (!_onMatchingImgae) return;

            //    string loadFolder = Path.GetDirectoryName(Application.ExecutablePath) + "\\EnrolledImages";
            //    if (_onMatchingImgae && System.IO.Directory.Exists(loadFolder))
            //    {
            //        string loadFile = loadFolder + "\\" + matchDataEventArgs.UUID + "_" + UMXClient.IrisFace + ".bmp";
            //        if (System.IO.File.Exists(loadFile))
            //        {
            //            pictureBox_preview.Load(loadFile);
            //            panelPrevivew.BackgroundImage = scaleDown(pictureBox_preview.Image, panelPrevivew.Width, panelPrevivew.Height);
            //            pictureBox_preview.Image = null;
            //        }
            //        else
            //        {
            //            loadFile = loadFolder + "\\" + matchDataEventArgs.UUID + "_" + UMXClient.FarOff.ToString() + ".bmp";
            //            if (System.IO.File.Exists(loadFile))
            //            {
            //                pictureBox_preview.Load(loadFile);
            //                panelPrevivew.BackgroundImage = scaleDown(pictureBox_preview.Image, panelPrevivew.Width, panelPrevivew.Height);
            //                pictureBox_preview.Image = null;
            //            }
            //            else
            //            {
            //                loadFile = loadFolder + "\\" + matchDataEventArgs.UUID + "_" + UMXClient.NearOff.ToString() + ".bmp";
            //                if (System.IO.File.Exists(loadFile))
            //                {
            //                    pictureBox_preview.Load(loadFile);
            //                    panelPrevivew.BackgroundImage = scaleDown(pictureBox_preview.Image, panelPrevivew.Width, panelPrevivew.Height);
            //                    pictureBox_preview.Image = null;
            //                }
            //            }
            //        }
            //    }

            //    // Display
            //    if (matchDataEventArgs.LeftEye != null) pictureBoxLeftEye.Image = matchDataEventArgs.LeftEye;
            //    if (matchDataEventArgs.RightEye != null) pictureBoxRightEye.Image = matchDataEventArgs.RightEye;
            //    if (matchDataEventArgs.IrisOffFace != null) pictureBoxIrisFace.Image = matchDataEventArgs.IrisOffFace;
            //    if (matchDataEventArgs.FarOffFace != null) pictureBoxFaceOff.Image = matchDataEventArgs.FarOffFace;
            //    if (matchDataEventArgs.FarOnFace != null) pictureBoxFaceOn.Image = matchDataEventArgs.FarOnFace;
            //    if (matchDataEventArgs.NearOffFace != null) pictureBoxFaceOff1.Image = matchDataEventArgs.NearOffFace;
            //    if (matchDataEventArgs.NearOnFace != null) pictureBoxFaceOn1.Image = matchDataEventArgs.NearOnFace;

            //    // Save
            //    bool isSave = true;
            //    if (isSave)
            //    {
            //        string saveFolder = Path.GetDirectoryName(Application.ExecutablePath) + "\\MatchedImages";
            //        if (!System.IO.Directory.Exists(saveFolder))
            //        {
            //            System.IO.Directory.CreateDirectory(saveFolder);
            //        }

            //        if (matchDataEventArgs.LeftEye8bitBmpByteArray != null)
            //        {
            //            File.WriteAllBytes(saveFolder + "\\" + matchDataEventArgs.LogId + "_" + matchDataEventArgs.UUID + "_" + UMXClient.Left + ".bmp",
            //                matchDataEventArgs.LeftEye8bitBmpByteArray.ToArray());
            //        }

            //        if (matchDataEventArgs.RightEye8bitBmpByteArray != null)
            //        {
            //            File.WriteAllBytes(saveFolder + "\\" + matchDataEventArgs.LogId + "_" + matchDataEventArgs.UUID + "_" + UMXClient.Right + ".bmp",
            //                matchDataEventArgs.RightEye8bitBmpByteArray.ToArray());
            //        }

            //        // Iris off face image is 360 * 480 JPG not byte[].
            //        if (matchDataEventArgs.IrisOffFace != null)
            //        {
            //            var i = new Bitmap(matchDataEventArgs.IrisOffFace);
            //            i.Save(saveFolder + "\\" + matchDataEventArgs.LogId + "_" + matchDataEventArgs.UUID + "_" + UMXClient.IrisFace + ".jpg",
            //                System.Drawing.Imaging.ImageFormat.Jpeg);
            //        }

            //        if (matchDataEventArgs.FarOffFace24bitBmpByteArray != null)
            //        {
            //            File.WriteAllBytes(saveFolder + "\\" + matchDataEventArgs.LogId + "_" + matchDataEventArgs.UUID + "_" + UMXClient.FarOff + ".bmp",
            //                matchDataEventArgs.FarOffFace24bitBmpByteArray.ToArray());
            //        }

            //        if (matchDataEventArgs.FarOnFace8bitBmpByteArray != null)
            //        {
            //            File.WriteAllBytes(saveFolder + "\\" + matchDataEventArgs.LogId + "_" + matchDataEventArgs.UUID + "_" + UMXClient.FarOn + ".bmp",
            //                matchDataEventArgs.FarOnFace8bitBmpByteArray.ToArray());
            //        }

            //        if (matchDataEventArgs.NearOffFace24bitBmpByteArray != null)
            //        {
            //            File.WriteAllBytes(saveFolder + "\\" + matchDataEventArgs.LogId + "_" + matchDataEventArgs.UUID + "_" + UMXClient.NearOff + ".bmp",
            //                matchDataEventArgs.NearOffFace24bitBmpByteArray.ToArray());
            //        }

            //        if (matchDataEventArgs.NearOnFace8bitBmpByteArray != null)
            //        {
            //            File.WriteAllBytes(saveFolder + "\\" + matchDataEventArgs.LogId + "_" + matchDataEventArgs.UUID + "_" + UMXClient.NearOn + ".bmp",
            //                matchDataEventArgs.NearOnFace8bitBmpByteArray.ToArray());
            //        }
            //}
            //}
        }
        private void _client_Disconnected(DisconnectedEventArgs eventData)
        {
            var msg = eventData.Message;
            //if (this.InvokeRequired)
            //{
            //    BeginInvoke(new MethodInvoker(delegate () { _client_Disconnected(eventData); }));
            //}
            //else
            //{
            //    m_logMessages.AddMessage(LogMessages.Icon.Warning, DateTime.Now, eventData.Message);
            //    //btnDisconnect.PerformClick();
            //}
        }
        private void _client_UMXException(CMIExceptionEventArgs exceptionEventArgs)
        {
            var msg = exceptionEventArgs.Message;
            //if (this.InvokeRequired)
            //{
            //    BeginInvoke(new MethodInvoker(delegate () { _client_UMXException(exceptionEventArgs); }));
            //}
            //else
            //{
            //    m_logMessages.AddMessage(LogMessages.Icon.Warning, DateTime.Now, exceptionEventArgs.Message);
            //}
        }
        #endregion

        #region Image Util

        private Image convertingByteArrayToImage(byte[] byteArr)
        {
            if (byteArr == null) return null;
            using (MemoryStream ms = new MemoryStream(byteArr))
            {
                return Image.FromStream(ms);
            }
        }
        private static ImageCodecInfo GetEncoderInfo(String mimeType)
        {
            int j;
            ImageCodecInfo[] encoders;
            encoders = ImageCodecInfo.GetImageEncoders();
            for (j = 0; j < encoders.Length; ++j)
            {
                if (encoders[j].MimeType == mimeType)
                    return encoders[j];
            }
            return null;
        }
        private static Image scaleDown(Image imgPhoto, int Width, int Height)
        {
            if (imgPhoto == null)
            {
                return null;
            }

            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int sourceX = 0;
            int sourceY = 0;
            int destX = 0;
            int destY = 0;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = ((float)Width / (float)sourceWidth);
            nPercentH = ((float)Height / (float)sourceHeight);
            if (nPercentH < nPercentW)
            {
                nPercent = nPercentH;
                destX = System.Convert.ToInt16((Width -
                              (sourceWidth * nPercent)) / 2);
            }
            else
            {
                nPercent = nPercentW;
                destY = System.Convert.ToInt16((Height -
                              (sourceHeight * nPercent)) / 2);
            }

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap bmPhoto = new Bitmap(Width, Height, PixelFormat.Format24bppRgb);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution,
                      imgPhoto.VerticalResolution);

            Graphics grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.Clear(Color.Transparent);

            grPhoto.DrawImage(imgPhoto,
                new Rectangle(destX, destY, destWidth, destHeight),
                new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
                GraphicsUnit.Pixel);

            grPhoto.Dispose();
            return bmPhoto;
        }
        private void saveFile(string saveFolder, DateTime captureTime, string whichFile, byte[] arr)
        {
            File.WriteAllBytes(saveFolder + "\\" + captureTime.Year + "-" + captureTime.Month + "-" + captureTime.Day + "_" +
                                    captureTime.Hour + "." + captureTime.Minute + "." + captureTime.Second + "_" + whichFile + ".bmp",
                                    arr.ToArray());
        }
        public static void AddLog(string deviceName, string message)
        {
            //if (_enableLogs)
            //{
                string path = AppDomain.CurrentDomain.BaseDirectory + "\\Logs";
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                var date = DateTime.Now.Date.ToShortDateString().Replace('/', '_');
                var time = DateTime.Now.ToShortTimeString();
                string filepath = AppDomain.CurrentDomain.BaseDirectory + "\\Logs\\" + deviceName + "_" + date + ".txt";
                if (!File.Exists(filepath))
                {
                    // Create a file to write to.   
                    using (StreamWriter sw = File.CreateText(filepath))
                    {
                        sw.WriteLine(date + " " + time + " :" + message);
                    }
                }
                else
                {
                    using (StreamWriter sw = File.AppendText(filepath))
                    {
                        sw.WriteLine(date + " " + time + " :" + message);
                    }
                }
            //}
        }
        #endregion

    }
}