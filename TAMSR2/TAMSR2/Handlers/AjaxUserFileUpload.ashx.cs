using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using TAMSR2.Extension;
namespace TAMSR2.Handlers
{
    /// <summary>
    /// Summary description for AjaxUserFileUpload
    /// </summary>
    public class AjaxUserFileUpload : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request["key"] != null && context.Request["key"].Trim() == "saveScheduleRoster")
            {
                try
                {

                    string temp = SaveScheduleRosterFile(context);
                    context.Response.Write(temp);
                }
                catch (Exception ex)
                {

                    context.Response.Write(ex.ToString());
                }



                return;
            }
            decimal id = Numerics.GetDecimal(context.Request["id"] + "");
            decimal createdByID = Numerics.GetDecimal(context.Request["user"] + "");

            EmployeeImage obj = new EmployeeImage();//.GetByID(id);
            if (obj == null)
                obj = new EmployeeImage();

            obj.EmployeeID = id;

            obj.UpdatedBy = createdByID;
            obj.UpdatedOn = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone);
            obj.CreatedBy = createdByID;
            obj.CreatedOn = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone);


            if (context.Request.Files.Count > 0)
            {
                var file = context.Request.Files[0];
                string fileName;
                if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                {
                    string[] files = file.FileName.Split(new char[] { '\\' });
                    fileName = files[files.Length - 1];
                }
                else
                {
                    fileName = file.FileName;
                }
                if (fileName.Trim() != "")
                {
                    //obj.Ext = Path.GetExtension(file.FileName);
                    obj.Ext = Path.GetExtension(file.FileName) + "||" + file.ContentType;
                    int imageLength = file.ContentLength;
                    byte[] picbyte = new byte[imageLength];
                    file.InputStream.Read(picbyte, 0, imageLength);
                    Bitmap bmp = new Bitmap(file.InputStream);
                    //obj.ProfileImage = SaveCroppedImage(bmp, 150, 150, "");
                    obj.ProfileImage = picbyte;
                }
            }
            string error = "";
            decimal result = -1;
            string server = ConfigurationManager.AppSettings["dbServer"];
            string connectionString = "Data Source=" + server + ";Initial Catalog=" + context.Session["dbName"] + ";uid=" + context.Session["dbUser"] + ";pwd=" + context.Session["dbPassword"] + "";
            result = new EmployeeImage().Save(obj, connectionString);

            string msg = "{";

            msg += string.Format("error:'{0}',\n", error);

            msg += string.Format("msg:'{0}'\n", result);

            msg += "}";

            context.Response.Write(msg);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        private string SaveScheduleRosterFile(HttpContext context)
        {
            decimal id = Numerics.GetDecimal(context.Request["id"] + "");
            decimal updateUserID = Numerics.GetDecimal(context.Request["userID"] + "");
            TAMSR2Company obj = new TAMSR2Company(id);

            string ResultJSON = string.Empty;
            if (context.Request.Files.Count > 0)
            {
                var file = context.Request.Files[0];
                string year = context.Request["year"] + "";
                string month = context.Request["month"] + "";
                if (year == "")
                    year = DateTime.Now.Year + "";
                if (month == "")
                    month = DateTime.Now.Month + "";

                int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));

                string fromDate = year + "-" + month + "-" + "01";
                string toDate = year + "-" + month + "-" + noOfDays;


                string fileName;
                if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                {
                    string[] files = file.FileName.Split(new char[] { '\\' });
                    fileName = files[files.Length - 1];
                }
                else
                {
                    fileName = file.FileName;
                }
                if (fileName.Trim() != "")
                {
                    string extension = Path.GetExtension(file.FileName);
                    string dirPath = "";
                    string virtualPath = "../Uploads/Roster/OrignalUpload/";
                    if (!Directory.Exists(virtualPath))
                    {
                        Directory.CreateDirectory(context.Server.MapPath(virtualPath));
                    }
                    string OriginalList = year + "_" + month + "_RosterExcel_Original_" + DateTime.Now.ToString("dd_MM_yyyy hh_mm_ss") + extension;
                    dirPath = context.Server.MapPath(virtualPath + OriginalList);
                    file.SaveAs(dirPath);
                    ResultJSON = SaveDataFromExcel(dirPath, context);

                }
                else
                {
                    obj.Logo = "";
                }
            }
            return ResultJSON;
        }

        //the connection string is : @"Provider=Microsoft.Jet.OLEDB.4.0; Data Source={0};Extended Properties=""Excel 8.0;HDR=YES;"""
        //And the DataSource is the path of the excel file
        public string SaveDataFromExcel(string ActualFilePath, HttpContext Context)
        {

            DataTable SaveRosterList = new DataTable();
            DataTable FailedRosterList = new DataTable();

            object ResultObj=new {};
            string FailedFilepath = string.Empty;
            string SuccessFilepath = string.Empty;

            int count = Numerics.GetInt(Context.Request["count"] + "");
            string year = Context.Request["year"] + "";
            string month = Context.Request["month"] + "";
            if (year == "")
                year = DateTime.Now.Year + "";
            if (month == "")
                month = DateTime.Now.Month + "";
            int noOfDays = DateTime.DaysInMonth(Numerics.GetInt(year), Numerics.GetInt(month));
            string fromDate = year + "-" + month + "-" + "01";
            string toDate = year + "-" + month + "-" + noOfDays;
            OleDbConnection con = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + ActualFilePath + ";Extended Properties=Excel 12.0");
            con.Open();
            try
            {
                //Create Dataset and fill with imformation from the Excel Spreadsheet for easier reference
                DataSet myDataSet = new DataSet();
                OleDbDataAdapter myCommand = new OleDbDataAdapter("select * from [Sch_Roster$]", con);
                myCommand.Fill(myDataSet);
                con.Close();
                string createdDateStr = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                string updatedDateStr = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                SaveRosterList = myDataSet.Tables[0].Copy();
                SaveRosterList.Clear();
                FailedRosterList = myDataSet.Tables[0].Copy();
                FailedRosterList.Clear();
                ScheduleRoster Roster;
                for (int i = 0; i < myDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = myDataSet.Tables[0].Rows[i];
                    Object[] cells = dr.ItemArray;
                    Roster = new ScheduleRoster();

                    Hashtable ht = new Hashtable();
                    ht.Add("action", "saveExcel");
                    ht.Add("sessionID", Context.Session["ID"] + "");
                    ht.Add("mgrID", Context.Session["ID"] + "");
                    ht.Add("fromDate", fromDate);
                    ht.Add("toDate", toDate);
                    ht.Add("createdBy", Context.Session["ID"] + "");
                    ht.Add("createdOn", createdDateStr);
                    ht.Add("updatedBy", Context.Session["ID"] + "");
                    ht.Add("updatedOn", updatedDateStr);
                    for (int k = 0; k < cells.Length; k++)
                    {
                        object cellContent = cells[k].ToString();
                        string cellText = cellContent.ToString().Trim();
                        if (k == 0)
                        {
                            Roster.EmpCode = cellText;

                            ht.Add("EmpCode", Roster.EmpCode);
                        }
                        else
                        {
                            Roster.Day = k;
                            Roster.SchCode = cellText;
                            ht.Add("d" + Roster.Day, Roster.SchCode);
                        }
                    }

                    if (string.IsNullOrEmpty(Roster.EmpCode))
                    {

                        FailedRosterList.ImportRow(dr);
                        continue;

                    }
                    string chk = "0";
                    TAMSR2Data objDAL = new TAMSR2Data();
                    try
                    {
                        objDAL.OpenConnection(Connection.GetConnectionStrinng(Context.Session["dbType"] + "", Context.Session["dbName"] + "", Context.Session["dbUser"] + "", Context.Session["dbPassword"] + ""));

                        string result = objDAL.Connection.GetValueProcedure("TAMSR2_ScheduleRosterOps", ht);
                        if (Numerics.GetDecimal(result) >= 0)
                        {
                            chk = result;
                            SaveRosterList.ImportRow(dr);
                        }
                        else
                        {
                            FailedRosterList.ImportRow(dr);
                        }
                    }
                    catch (Exception ex)
                    {
                        new ExceptionLog().WriteLog("Handler/ScheduleRosterImport.Save()", 0, ex);
                        FailedRosterList.ImportRow(dr);
                    }
                    finally
                    {
                        objDAL.CloseConnection();
                    }
                }

                if (SaveRosterList != null && SaveRosterList.Rows.Count > 0)
                {
                    try
                    {
                        string virtualPath = "../Uploads/Roster/SuccessFullUpload/";

                        if (!Directory.Exists(virtualPath))
                        {
                            Directory.CreateDirectory(Context.Server.MapPath(virtualPath));
                        }
                        string failListName = year + "_" + month + "_RosterExcel_Success_" + DateTime.Now.ToString("dd_MM_yyyy hh_mm_ss") + ".xls";
                        SuccessFilepath = Context.Server.MapPath(virtualPath + failListName);
                        SaveRosterList.ExportToExcelFile(SuccessFilepath);
                        ResultObj = new { SuccessFullUploadFilePath = Encryption.Encrypt(SuccessFilepath.Trim()), FailedUploadFilePath = Encryption.Encrypt(FailedFilepath.Trim()) };
                    }
                    catch (Exception ex)
                    {
                        ResultObj = ex.ToString();
                    }

                }

                if (FailedRosterList != null && FailedRosterList.Rows.Count > 0)
                {

                    try
                    {
                        string virtualPath = "../Uploads/Roster/Faileduploads/";

                        if (!Directory.Exists(virtualPath))
                        {
                            Directory.CreateDirectory(Context.Server.MapPath(virtualPath));
                        }
                        string failListName = year + "_" + month + "_RosterExcel_" + DateTime.Now.ToString("dd_MM_yyyy hh_mm_ss") + ".xls";
                        FailedFilepath = Context.Server.MapPath(virtualPath + failListName);
                        FailedRosterList.ExportToExcelFile(FailedFilepath);
                        ResultObj = new { SuccessFullUploadFilePath = Encryption.Encrypt(SuccessFilepath.Trim()), FailedUploadFilePath = Encryption.Encrypt(FailedFilepath.Trim()) };
                    }
                    catch (Exception ex)
                    {
                        ResultObj = ex.ToString();
                    }

                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                con.Close();
            }

            return new JavaScriptSerializer().Serialize(ResultObj);
        }

        public byte[] SaveCroppedImage(Image image, int maxWidth, int maxHeight, string filePath)
        {
            ImageCodecInfo jpgInfo = ImageCodecInfo.GetImageEncoders()
                                     .Where(codecInfo =>
                                     codecInfo.MimeType == "image/jpeg").First();
            Image finalImage = image;
            System.Drawing.Bitmap bitmap = null;
            try
            {
                int left = 0;
                int top = 0;
                int srcWidth = maxWidth;
                int srcHeight = maxHeight;
                bitmap = new System.Drawing.Bitmap(maxWidth, maxHeight);
                double croppedHeightToWidth = (double)maxHeight / maxWidth;
                double croppedWidthToHeight = (double)maxWidth / maxHeight;

                if (image.Width > image.Height)
                {
                    srcWidth = (int)(Math.Round(image.Height * croppedWidthToHeight));
                    if (srcWidth < image.Width)
                    {
                        srcHeight = image.Height;
                        left = (image.Width - srcWidth) / 2;
                    }
                    else
                    {
                        srcHeight = (int)Math.Round(image.Height * ((double)image.Width / srcWidth));
                        srcWidth = image.Width;
                        top = (image.Height - srcHeight) / 2;
                    }
                }
                else
                {
                    srcHeight = (int)(Math.Round(image.Width * croppedHeightToWidth));
                    if (srcHeight < image.Height)
                    {
                        srcWidth = image.Width;
                        top = (image.Height - srcHeight) / 2;
                    }
                    else
                    {
                        srcWidth = (int)Math.Round(image.Width * ((double)image.Height / srcHeight));
                        srcHeight = image.Height;
                        left = (image.Width - srcWidth) / 2;
                    }
                }
                using (Graphics g = Graphics.FromImage(bitmap))
                {
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                    g.CompositingQuality = CompositingQuality.HighQuality;
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.DrawImage(image, new Rectangle(0, 0, bitmap.Width, bitmap.Height),
                    new Rectangle(left, top, srcWidth, srcHeight), GraphicsUnit.Pixel);
                }
                finalImage = bitmap;
            }
            catch { }
            try
            {
                using (EncoderParameters encParams = new EncoderParameters(1))
                {
                    encParams.Param[0] = new EncoderParameter(Encoder.Quality, (long)100);
                    //quality should be in the range 
                    //[0..100] .. 100 for max, 0 for min (0 best compression)
                    //finalImage.Save(filePath, jpgInfo, encParams);
                    //return true;
                    byte[] byteArray = new byte[0];
                    using (MemoryStream stream = new MemoryStream())
                    {
                        finalImage.Save(stream, jpgInfo, encParams);
                        //finalImage.Save(stream, System.Drawing.Imaging.ImageFormat.Png);
                        stream.Close();

                        byteArray = stream.ToArray();
                    }
                }
            }
            catch { }
            if (bitmap != null)
            {
                bitmap.Dispose();
            }
            return null;

        }
    }
}