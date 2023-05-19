using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using ClosedXML.Excel;
using System.Text;

namespace TAMSR2.Reports
{
    public partial class ViewStandardRptPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        MemoryStream logostream = null;
        string ReportTitle = "";
        string appLogoFileName = ConfigurationManager.AppSettings["ApplicationLogoFileName"];

        string fromDate = "";
        string toDate = ""; 
        string ReportID = "";
        string ReportName = "";
        string ReportColumns = "";
        ReportDocument rpt = new ReportDocument();
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewstandardrptpage.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/viewstandardrptpage.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("reports/view-standard-repots"));

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


            ShowStandardReports();



        }



        #region ShowStandardReports

        protected string ShowStandardReports()
        {
            DataView objDataView = new DataView();
            TAMSR2Data objDal = new TAMSR2Data();

            try
            {
                ReportID = (Request["ReportCode"] + "").Trim();
                ReportName = (Request["ReportName"] + "").Trim();
                ReportTitle = (Request["ReportName"] + "").Trim();

                string RegionCode = (Request["Region"] + "").Trim();
                string OrganizationID = (Request["Organization"] + "").Trim();
                string EmployeeID = (Request["Employee"] + "").Trim();
                string ManagerID = (Request["Manager"] + "").Trim();


                  fromDate = (Request["FromDate"] + "").Trim();
                  toDate = (Request["ToDate"] + "").Trim();

                string includeInactive = (Request["includeInactive"] + "").Trim();
                string groupID = (Request["groupID"] + "").Trim();

                string EmpTypeID = (Request["EmpTypeID"] + "").Trim();
                string PermCatID = (Request["PermCatID"] + "").Trim();
                
                int isArabic = 0;

                if (cookie.Values["language"] + "" == "ar")
                    isArabic = 1;
                else
                    isArabic = 0;



                TAMSR2Data objDALApp = new TAMSR2Data();
                DataView dvApp = new DataView();
                TAMSR2.ObjectClasses.DBAppSetting objApp = new TAMSR2.ObjectClasses.DBAppSetting();
                bool isUngrouped = false;
                try
                {
                    objDALApp.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    Hashtable htApp = new Hashtable();
                    htApp.Add("action", "getByName");
                    htApp.Add("sessionID", Session["ID"] + "");
                    htApp.Add("vname", "SHOW_UNGROUPED_REPORT" + "");
                    dvApp = objDALApp.Connection.ExecuteProcedure("TAMSR2_AppSettingOps", htApp);

                    if (dvApp != null)
                    {
                        objApp.Value = dvApp[0]["value"] + "" == "" ? "No" : dvApp[0]["value"] + "";
                    }
                }
                catch (Exception ex)
                {
                    Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(ex));
                }
                finally
                {
                    objDALApp.CloseConnection();
                }



                Hashtable ht = new Hashtable();

                if (ReportName != "MedicalPassReport")
                {
                    LoadReportColumns();

                    ht.Add("SessionID", Session["ID"].ToString());
                    ht.Add("isArabic", isArabic);
                    ht.Add("templateName", ReportName);
                    ht.Add("RegionCode", RegionCode);
                    ht.Add("OrganizationID", OrganizationID);
                    ht.Add("EmployeeId", EmployeeID);
                    ht.Add("ManagerId", ManagerID);
                    ht.Add("FromDate", fromDate);
                    ht.Add("ToDate", toDate);
                    ht.Add("includeInactive", includeInactive);
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_PI_REPORTS) == false)
                    {
                        ht.Add("groupID", groupID);
                        ht.Add("EmpTypeID", EmpTypeID);
                    }
                    if (ReportTitle.Trim().IndexOf("Permissions Report") != -1)
                    {
                        ht.Add("PermCategory", PermCatID);

                    }
                }
                else
                {
                    string PermissionID = (Request["PermissionId"] + "").Trim();
                    ht.Add("SessionID", Session["ID"].ToString());
                    ht.Add("PermissionID", PermissionID); 
                }
                objDal.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));


                if (ReportTitle.Trim().IndexOf("MedicalPassReport") != -1 || ReportTitle.Trim().IndexOf("MedicalPassReport") != -1)
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_PrintMedicalReport", ht);

                }
                else if (ReportTitle.Trim().IndexOf("Attendance Summary Report") != -1 || ReportTitle.Trim().IndexOf("ملخص الحضور و الانصراف" ) != -1)
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_DMR_Summary", ht);

                }
                else if (ReportTitle.Trim().IndexOf("Daily Movement Report") != -1 || ReportTitle.Trim().IndexOf("التقرير التحركات اليومي") != -1)
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_DailyMovementReport", ht);

                }
                else if (ReportTitle.Trim().IndexOf("Total Movement Report") != -1 || ReportTitle.Trim().IndexOf("تقرير الحركة الإجمالي") != -1)
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_TotalMovementReport", ht);
                }
                else if (ReportTitle.Trim().IndexOf("Employee Year Summary Report") != -1 || ReportTitle.Trim().IndexOf("التقرير الملخص السنوية الموظف ") != -1)
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_EmployeeYearSummaryReport", ht);

                }
                else if (ReportTitle.Trim().IndexOf("Permissions Report") != -1 || ReportTitle.Trim().IndexOf("التقرير الإذن") != -1)
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_PermissionReport", ht);

                }
                else if (ReportTitle.Trim().IndexOf("Employee Deduction Report") != -1 || ReportTitle.Trim().IndexOf("التقرير المخالفات الموظف") != -1)
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_EmployeeDeductionReport", ht);

                }
                else if (ReportTitle.Trim().IndexOf("Employee Overtime Report") != -1 || ReportTitle.Trim().IndexOf("Employee Extra Hours Report") != -1 ||
                         ReportTitle.Trim().IndexOf("HR Overtime Report") != -1   || ReportTitle.Trim().IndexOf(" ساعة إضافية") != -1 )
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_EmployeeOvertimeReport", ht);

                }
                else if (ReportTitle.Trim().IndexOf("No Time IN Report") != -1 || ReportTitle.Trim().IndexOf("التقرير بدون حركة دخول") != -1
                   || ReportTitle.Trim().IndexOf("No Time Out Report") != -1 || ReportTitle.Trim().IndexOf("التقرير بدون حركة خروج") != -1
                   || ReportTitle.Trim().IndexOf("No Time In/Out Report") != -1 || ReportTitle.Trim().IndexOf("التقرير بدون حركة دخول/خروج") != -1)
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_Missed_Punch_Report", ht);

                }
                else
                {
                    objDataView = objDal.Connection.ExecuteProcedure("Rpt_Standard_Template_Execution", ht);
                }
                Boolean.TryParse(objApp.Value, out isUngrouped);
                if (ReportTitle.Trim().IndexOf("MedicalPassReport") != -1 || ReportTitle.Trim().IndexOf("MedicalPassReport") != -1)
                {
                    this.rpt.Load(this.Server.MapPath("../CrystalReports/Medical_Pass_Report_Eng.rpt"));
                }
                else if (this.ReportTitle.Trim() == "Employee Movements Report" || this.ReportTitle.Trim() == "التقرير دخول و خروج الموظف" || this.ReportTitle.Trim() == "حركات الحضور" || this.ReportTitle.Trim() == "حركات الحضور")
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_Movement_Report_En.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_Movement_Report.rpt"));
                }
                else if ((this.ReportTitle.Trim() == "Attendance Summary Report" || this.ReportTitle.Trim() == "التقرير ملخص الحضور و الانصراف") || this.ReportTitle.Trim() == "مخلص الدوام")
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_DMR_Report_En.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_DMR_Report.rpt"));
                }
                else if (this.ReportTitle.Trim() == "Daily Movement Report" || ReportTitle.Trim().IndexOf("التقرير التحركات اليومي") != -1)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/DailyMovementReport_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/DailyMovementReport_Arb.rpt"));
                }
                else if (this.ReportTitle.Trim() == "Total Movement Report" || ReportTitle.Trim().IndexOf("تقرير الحركة الإجمالي") != -1)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/TotalMovementReport_Eng1.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/TotalMovementReport_Arb.rpt"));
                }
                else if (this.ReportTitle.Trim() == "Employee Year Summary Report" || ReportTitle.Trim().IndexOf("التقرير الملخص السنوية الموظف") != -1)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/EmployeeYearSummaryReport_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/EmployeeYearSummaryReport_Arb.rpt"));
                }
                else if (ReportTitle.Trim().IndexOf("Permissions Report") != -1 || ReportTitle.Trim().IndexOf("التقرير الإذن") != -1)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/PermissionReport_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/PermissionReport_Arb.rpt"));

                }
                else if (ReportTitle.Trim().IndexOf("Employee Deduction Report") != -1 || ReportTitle.Trim().IndexOf("Employee Deduction Report") != -1)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Employee_Deduction_Report_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Employee_Deduction_Report_Arb.rpt"));


                }
                else if (ReportTitle.Trim().IndexOf("No Time In/Out Report") != -1 || ReportTitle.Trim().IndexOf("التقرير بدون حركة دخول/خروج") != -1)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Eight_Column_Report_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Eight_Column_Report_Arb.rpt"));
                }
                else if (ReportTitle.Trim().IndexOf("Employee Details Report") != -1 || ReportTitle.Trim().IndexOf("'التقرير بيانات الموظف") != -1)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/EmployeeDetail_Report_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/EmployeeDetail_Report_Arb.rpt"));
                }
                else if ((this.ReportColumns ?? "").Split(',').Length > 15 && (this.ReportColumns ?? "").Split(',').Length <= 20)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Fifteen_Column_Report_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Fifteen_Column_Report_Arb.rpt"));
                    //ReportColumnLength = 7;
                }
                else if ((this.ReportColumns ?? "").Split(',').Length > 8 && (this.ReportColumns ?? "").Split(',').Length > 11)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_DMR_Report_En.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_DMR_Report.rpt"));

                    //ReportColumnLength = 7;
                }
                else if ((this.ReportColumns ?? "").Split(',').Length > 8 && (this.ReportColumns ?? "").Split(',').Length <= 11)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Nine_Column_Report_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Nine_Column_Report_Arb.rpt"));

                    //ReportColumnLength = 7;
                }
                else if ((this.ReportColumns ?? "").Split(',').Length <= 8)
                {
                    if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Five_Column_Report_Eng.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Five_Column_Report_Arb.rpt"));
                }
                else
                {
                    int num2;
                    if ((this.ReportColumns ?? "").Split(',').Length > 8)
                        num2 = (this.ReportColumns ?? "").Split(',').Length > 8 ? 1 : 0;
                    else
                        num2 = 1;
                    if (num2 == 0)
                    {
                        if (this.languagePostfix == "_eng")
                            this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_Movement_Report_En.rpt"));
                        else
                            this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_Movement_Report.rpt"));
                    }
                    else if (this.languagePostfix == "_eng")
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_DMR_Report_En.rpt"));
                    else
                        this.rpt.Load(this.Server.MapPath("../CrystalReports/Arabic_DMR_Report.rpt"));
                }
                CrystalReportViewer1.ReportSource = rpt;

                DataTable dt = new DataTable();
                dt = objDataView.Table;
                //   dt = objDataView.Table;
                try
                {
                    DataColumn colByteArray = new DataColumn("Column50");
                    colByteArray.DataType = System.Type.GetType("System.Byte[]");
                    System.Drawing.Image img = System.Drawing.Image.FromFile(Server.MapPath("../Images/" + appLogoFileName));
                    byte[] arr;
                    using (MemoryStream ms = new MemoryStream())
                    {
                        img.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                        arr = ms.ToArray();
                    }

                    colByteArray.DefaultValue = arr;// File.ReadAllBytes(Server.MapPath("../Images/" + appLogoFileName));
                    if (dt.Rows.Count == 0)
                    {
                        dt.Rows.Add();
                    }
                    dt.Columns.Remove("Column50");
                    dt.Columns.Add(colByteArray);
                }
                catch (Exception e)
                {
                    Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(e));
                }
                ////dt.Rows[0].ItemArray[dt.Columns.Count - 1] = File.ReadAllBytes(Server.MapPath("../Images/app-logo.jpg"));

                rpt.SetDataSource(dt);
                SetParameterFields(rpt, ReportColumns);
                rpt.SummaryInfo.ReportAuthor = Session["Username"].ToString().Trim();

                CrystalReportViewer1.BestFitPage = true;
                CrystalReportViewer1.DocumentView = DocumentViewType.WebLayout;
                rpt.SummaryInfo.ReportTitle = ReportTitle.Trim();

                //CrystalReportViewer1.DisplayToolbar = false;
                //CrystalReportViewer1.HasExportButton = false;
                //CrystalReportViewer1.HasPrintButton = false;
                //CrystalReportViewer1.HasRefreshButton = false;




                string SaveReportName = rpt.SummaryInfo.ReportTitle.ToString().Replace(" ", string.Empty) + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");

                string action = Request["action"].ToString().ToLower();

                if (action.ToLower() == "viewreport")
                {
                    try
                    {
                        byte[] byteArray = null;
                        System.IO.Stream oStream = (System.IO.Stream)rpt.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                        byteArray = new byte[oStream.Length];
                        oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));
                        Response.Clear();
                        Response.Buffer = true;
                        Response.ContentType = "application/pdf";
                        Response.BinaryWrite(byteArray);
                        Response.End();
                    }
                    catch (Exception ex)
                    {
                        Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(ex));
                    }
                }
                else if (action.ToLower() == "exceldownload")
                { 
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.Buffer = true;
                    if (!string.IsNullOrEmpty(Request["format"] + "".Trim()) && Request["format"] == "dataonly")
                    {
                        DownloadExcelClosedXML(dt);
                        //string data = ExportExcel(dt);
                        //Response.Write(data);
                    }
                    else
                    { 
                        rpt.ExportOptions.ExportFormatType = ExportFormatType.XLSXRecord; 
                        ExcelFormatOptions objExcelOptions = new ExcelFormatOptions();
                        objExcelOptions.ExportPageHeadersAndFooters = ExportPageAreaKind.OnEachPage;
                        objExcelOptions.ExportPageBreaksForEachPage = true;
                        objExcelOptions.ConvertDateValuesToString = true;
                        objExcelOptions.ExcelTabHasColumnHeadings = true;
                        objExcelOptions.ExcelUseConstantColumnWidth = false;
                        rpt.ExportOptions.FormatOptions = objExcelOptions;  
                        rpt.ExportToHttpResponse(rpt.ExportOptions, Response, true, SaveReportName);
                    }
                    Response.Flush();
                    Response.End();
                    Response.Flush();
                    Response.End();
                }
                else if (action.ToLower() == "worddownload")
                {
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.Buffer = true;
                    rpt.ExportToHttpResponse(ExportFormatType.WordForWindows, Response, true, SaveReportName);
                    Response.Flush();
                    Response.End();
                }
                else if (action.ToLower() == "pdfdownload")
                {
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.Buffer = true;
                    rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, SaveReportName);
                    Response.Flush();
                    Response.End();
                }
                return "";
            }
            catch (System.Exception ex)
            {
                rpt.Dispose();
                return "ErrorOccured" + ex.Message.ToString();
                Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(ex));

            }
            finally
            {
                rpt.Dispose();
            }
        }

        #endregion

        #region ShowReportGraphical

        public string ShowReportGraphical()
        {


            DataView objDataView = new DataView();
            TAMSR2Data objDal = new TAMSR2Data();
            List<object> lst = new List<object>();
            try
            {
                ReportID = (Request["ReportCode"] + "").Trim();
                ReportName = (Request["ReportName"] + "").Trim();
                ReportTitle = (Request["ReportName"] + "").Trim();

                string RegionCode = (Request["Region"] + "").Trim();
                string OrganizationID = (Request["Organization"] + "").Trim();
                string EmployeeID = (Request["Employee"] + "").Trim();

                string fromDate = (Request["FromDate"] + "").Trim();
                string toDate = (Request["ToDate"] + "").Trim();

                string includeInactive = (Request["includeInactive"] + "").Trim();

                int isArabic = 0;

                if (cookie.Values["language"] + "" == "ar")
                    isArabic = 1;
                else
                    isArabic = 0;

                LoadReportColumns();


                Hashtable ht = new Hashtable();
                ht.Add("SessionID", Session["ID"].ToString());
                ht.Add("isArabic", isArabic);
                ht.Add("templateName", ReportName);
                ht.Add("RegionCode", RegionCode);
                ht.Add("OrganizationID", OrganizationID);
                ht.Add("EmployeeId", EmployeeID);
                ht.Add("FromDate", fromDate);
                ht.Add("ToDate", toDate);
                ht.Add("includeInactive", includeInactive);


                objDal.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                if (ReportTitle.Trim() == "Attendance Summary" || ReportTitle.Trim() == "ملخص الحضور و الانصراف"
                            || ReportTitle.Trim() == "مخلص الدوام")
                {
                    objDataView = objDal.Connection.ExecuteProcedure("usp_rpt_dmr_summary_graphical", ht);
                    foreach (DataRowView dv in objDataView)
                    {
                        object obj = new
                        {
                            OrganizationName = dv["OrganizationName"],
                            NoOfAbsentDays = dv["NoOfAbsentDays"],
                            NoofHoliday = dv["NoofHoliday"],
                            NoOfLate = dv["NoOfLate"],
                            TotalDaysOfLeave = dv["TotalDaysOfLeave"]
                        };

                        lst.Add(obj);
                    }

                }
            }
            catch (Exception)
            {


            }

            return new JavaScriptSerializer().Serialize(lst);



        }
        #endregion

        private void DownloadExcelClosedXML(DataTable dt)
        {
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Sheet1");
                // Add "Daily Movement Report" in the first row
                var titleRow = worksheet.Row(1);
                titleRow.Height = 25;
                var titleCell = titleRow.Cell(1);
                titleCell.Value = ReportTitle;
                titleCell.Style.Font.Bold = true;
                titleCell.Style.Font.FontSize = 18;
                titleCell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                worksheet.Range("A1:E1").Merge();
                worksheet.Range("A1:E1").Style.Border.TopBorder = XLBorderStyleValues.Thick;
                worksheet.Range("A1:E1").Style.Border.BottomBorder = XLBorderStyleValues.Thick;
                worksheet.Range("A1:E1").Style.Border.LeftBorder = XLBorderStyleValues.Thick;
                worksheet.Range("A1:E1").Style.Border.RightBorder = XLBorderStyleValues.Thick;
                var cellD1 = worksheet.Range("E1:P3");
                cellD1.Style.Border.TopBorder = XLBorderStyleValues.None;
                cellD1.Style.Border.LeftBorder = XLBorderStyleValues.None;
                cellD1.Style.Border.RightBorder = XLBorderStyleValues.None;
                cellD1.Style.Border.BottomBorder = XLBorderStyleValues.None;
                // Add "From" in the second row
                var fromRow = worksheet.Row(2);
                var fromCell = fromRow.Cell(1);
                fromCell.Value = "From";
                fromCell.Style.Font.Bold = false;
                // Add "FromDate" in the second row
                var FromDateCell = fromRow.Cell(2);
                FromDateCell.Value = fromDate;
                FromDateCell.Style.Font.Bold = false;
                // Add text in cell B3
                var toCell = worksheet.Cell(2, 3);
                toCell.Value = "To";
                // Add text in cell B4
                var textCell = worksheet.Cell(2, 4);
                textCell.Value = toDate;
                if (ReportTitle.Trim().IndexOf("Daily Movement Report") != -1 || ReportTitle.Trim().IndexOf("التقرير اليومى") != -1)
                {
                    //var blankhead = worksheet.Cell(4, 1);
                    //blankhead.Value = "";
                    var firstHead = worksheet.Cell(4, 1);
                    firstHead.Value = "BU";
                    firstHead.Style.Font.Bold = true;
                    var secondHead = worksheet.Cell(4, 2);
                    secondHead.Value = "Department";
                    secondHead.Style.Font.Bold = true;
                    var thirdHead = worksheet.Cell(4, 3);
                    thirdHead.Value = "Section";
                    thirdHead.Style.Font.Bold = true;
                    var forthHead = worksheet.Cell(4, 4);
                    forthHead.Value = "Number";
                    forthHead.Style.Font.Bold = true;
                    var fifthHead = worksheet.Cell(4, 5); 
                    fifthHead.Value = "Name";
                    fifthHead.Style.Font.Bold = true;
                    var sixthHead = worksheet.Cell(4, 6); 
                    sixthHead.Value = "Date";
                    sixthHead.Style.Font.Bold = true;
                    var seventhHead = worksheet.Cell(4, 7);
                    seventhHead.Value = "Time In";
                    seventhHead.Style.Font.Bold = true;
                    var eighthHead = worksheet.Cell(4, 8); 
                    eighthHead.Value = "Time Out";
                    eighthHead.Style.Font.Bold = true;
                    var ninethHead = worksheet.Cell(4, 9); 
                    ninethHead.Value = "Late";
                    ninethHead.Style.Font.Bold = true;
                    var tenthHead = worksheet.Cell(4, 10); 
                    tenthHead.Value = "Early";
                    tenthHead.Style.Font.Bold = true;
                    var eleventhHead = worksheet.Cell(4, 11); 
                    eleventhHead.Value = "Worked Hours";
                    eleventhHead.Style.Font.Bold = true;
                    var twelvethHead = worksheet.Cell(4, 12); 
                    twelvethHead.Value = "Req. Hours";
                    twelvethHead.Style.Font.Bold = true;
                    var thirteenthHead = worksheet.Cell(4, 13);
                    thirteenthHead.Value = "Missed Hours";
                    thirteenthHead.Style.Font.Bold = true;
                    var forteenthHead = worksheet.Cell(4, 14); 
                    forteenthHead.Value = "Extra Hours";
                    forteenthHead.Style.Font.Bold = true;
                    var fifteenthHead = worksheet.Cell(4, 15);
                    fifteenthHead.Value = "Schedule";
                    fifteenthHead.Style.Font.Bold = true;
                    var sixteenthHead = worksheet.Cell(4, 16); 
                    sixteenthHead.Value = "Comments";
                    sixteenthHead.Style.Font.Bold = true;

                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 16; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r";
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ";
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }

                else if (ReportTitle.Trim() == "Employee Movements Report" || ReportTitle.Trim() == "دخول و خروج الموظف")
                {
                    var firstHead = worksheet.Cell(4, 1); 
                    firstHead.Value = "BU";
                    firstHead.Style.Font.Bold = true;
                    var secondHead = worksheet.Cell(4, 2); 
                    secondHead.Value = "Department";
                    secondHead.Style.Font.Bold = true;
                    var thirdHead = worksheet.Cell(4, 3);
                    thirdHead.Value = "Section";
                    var forthHead = worksheet.Cell(4, 4); 
                    forthHead.Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5);
                    fifthHead.Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6);
                    sixthHead.Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7);
                    seventhHead.Value = "Time";
                    var eighthHead = worksheet.Cell(4, 8);
                    eighthHead.Value = "Trans Mode";
                    var ninethHead = worksheet.Cell(4, 9);
                    ninethHead.Value = "Device";
                    var tenthHead = worksheet.Cell(4, 10);
                    tenthHead.Value = "Comments";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 10; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "Absentees Report" || ReportTitle.Trim() == "الغياب")
                {
                    var firstHead = worksheet.Cell(4, 1);
                        firstHead.Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Day";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Remarks";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Time In";
                    var tenthHead = worksheet.Cell(4, 10).Value = "Time Out";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "Late";
                    var twelvethHead = worksheet.Cell(4, 12).Value = "Early";
                    var thirteenthHead = worksheet.Cell(4, 13).Value = "Worked Hours";
                    var forteenthHead = worksheet.Cell(4, 14).Value = "Req Hours";
                    var fifteenthHead = worksheet.Cell(4, 15).Value = "Missed Hours";
                    var sixteenthHead = worksheet.Cell(4, 16).Value = "Extra Hours";
                    var seventeenthHead = worksheet.Cell(4, 17).Value = "Schedule";
                    var eightteenthHead = worksheet.Cell(4, 18).Value = "Comments";
                    var ninteenthHead = worksheet.Cell(4, 19).Value = "Site";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 19; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }

                }
                else if (ReportTitle.Trim() == "Late In Report" || ReportTitle.Trim() == "التأخير")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Late In";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Time In";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Time Out";
                    var tenthHead = worksheet.Cell(4, 10).Value = "Late";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "Early";
                    var twelvethHead = worksheet.Cell(4, 12).Value = "Worked Hour";
                    var thirteenthHead = worksheet.Cell(4, 13).Value = "Req Hours";
                    var forteenthHead = worksheet.Cell(4, 14).Value = "Missed Hours";
                    var fifteenthHead = worksheet.Cell(4, 15).Value = "Extra Hours";
                    var sixteenthHead = worksheet.Cell(4, 16).Value = "Schedule";
                    var seventeenthHead = worksheet.Cell(4, 17).Value = "Comments";
                    var eightteenthHead = worksheet.Cell(4, 18).Value = "Site";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 18; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }

                }
                else if (ReportTitle.Trim() == "Early Out Report" || ReportTitle.Trim() == "الخروج المبكر")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Time Out";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Early Out";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Schedule";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 9; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "Attendance Summary Report" || ReportTitle.Trim() == "ملخص الحضور و الانصراف")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "no. of absent day";
                    var seventhHead = worksheet.Cell(4, 7).Value = "no. of unauthorized absent";
                    var eighthHead = worksheet.Cell(4, 8).Value = "no. of holidays";
                    var ninethHead = worksheet.Cell(4, 9).Value = "no. of late in";
                    var tenthHead = worksheet.Cell(4, 10).Value = "late in hours";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "no. of early out";
                    var twelvethHead = worksheet.Cell(4, 12).Value = "early out hours";
                    var thirteenthHead = worksheet.Cell(4, 13).Value = "approved leaves";
                    var forteenthHead = worksheet.Cell(4, 14).Value = "required hours";
                    var fifteenthHead = worksheet.Cell(4, 15).Value = "working hours";
                    var sixteenthHead = worksheet.Cell(4, 16).Value = "missing hours";
                    var seventeenthHead = worksheet.Cell(4, 17).Value = "extra hours";
                    var eightteenthHead = worksheet.Cell(4, 18).Value = "total hours";
                    var nineteenthHead = worksheet.Cell(4, 19).Value = "no. of missed in";
                    var twentythHead = worksheet.Cell(4, 20).Value = "no. of missed out";
                    var twentyfirstHead = worksheet.Cell(4, 21).Value = "no. of personal Permissions";
                    var twentysecondHead = worksheet.Cell(4, 22).Value = "Personal Permissions Hours";
                    var twentythirdHead = worksheet.Cell(4, 23).Value = "No. of Official Permissions";
                    var twentyforthHead = worksheet.Cell(4, 24).Value = "Official Permissions Hours";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 24; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "Employee Details Report" || ReportTitle.Trim() == "بيانات الموظف")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Join Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Status";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Designation";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 8; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "No Time IN Report")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Schedule In";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Missing In";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Time In";
                    var tenthHead = worksheet.Cell(4, 10).Value = "Time Out";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "Late";
                    var twelvethHead = worksheet.Cell(4, 12).Value = "Early";
                    var thirteenthHead = worksheet.Cell(4, 13).Value = "Worked Hour";
                    var forteenthHead = worksheet.Cell(4, 14).Value = "Req hours";
                    var fifteenthHead = worksheet.Cell(4, 15).Value = "Missed Hour";
                    var sixteenthHead = worksheet.Cell(4, 16).Value = "Extra Hour";
                    var seventeenthHead = worksheet.Cell(4, 17).Value = "Schedule";
                    var eightteenthHead = worksheet.Cell(4, 18).Value = "Comments";
                    var nineteenthHead = worksheet.Cell(4, 19).Value = "Site";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 19; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "No Time Out Report")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Schedule Out";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Missing In";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Time In";
                    var tenthHead = worksheet.Cell(4, 10).Value = "Time Out";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "Late";
                    var twelvethHead = worksheet.Cell(4, 12).Value = "Early";
                    var thirteenthHead = worksheet.Cell(4, 13).Value = "Worked Hour";
                    var forteenthHead = worksheet.Cell(4, 14).Value = "Req hours";
                    var fifteenthHead = worksheet.Cell(4, 15).Value = "Missed Hour";
                    var sixteenthHead = worksheet.Cell(4, 16).Value = "Extra Hour";
                    var seventeenthHead = worksheet.Cell(4, 17).Value = "Schedule";
                    var eightteenthHead = worksheet.Cell(4, 18).Value = "Comments";
                    var nineteenthHead = worksheet.Cell(4, 19).Value = "Site";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 19; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim().IndexOf("Permissions Report") != -1 || ReportTitle.Trim().IndexOf("تقرير الإذن") != -1)
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "From Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "To Date";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Permission Type";
                    var ninethHead = worksheet.Cell(4, 9).Value = "From Time";
                    var tenthHead = worksheet.Cell(4, 10).Value = "To Time";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "Permission Time";
                    var twelvethHead = worksheet.Cell(4, 12).Value = "Status";
                    var thirteenthHead = worksheet.Cell(4, 13).Value = "Applied By";
                    var forteenthHead = worksheet.Cell(4, 14).Value = "Approved By";
                    var fifteenthHead = worksheet.Cell(4, 15).Value = "Total Official Permission Hours";
                    var sixteenthHead = worksheet.Cell(4, 16).Value = "Total Personal Permission Hours";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 16; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim().IndexOf("No Time In/Out Report") != -1 || ReportTitle.Trim().IndexOf("تقرير بدون حركة دخول/خروج") != -1)
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Schedule In";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Time In";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Schedule Out";
                    var tenthHead = worksheet.Cell(4, 10).Value = "Missing Out";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 10; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim().IndexOf("Employee Year Summary Report") != -1 || ReportTitle.Trim().IndexOf("تقرير الملخص السنوية الموظف ") != -1)
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Type";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Jan";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Feb";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Mar";
                    var tenthHead = worksheet.Cell(4, 10).Value = "Apr";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "May";
                    var twelvethHead = worksheet.Cell(4, 12).Value = "Jun";
                    var thirteenthHead = worksheet.Cell(4, 13).Value = "Jul";
                    var forteenthHead = worksheet.Cell(4, 14).Value = "Aug";
                    var fifteenthHead = worksheet.Cell(4, 15).Value = "Sep";
                    var sixteenthHead = worksheet.Cell(4, 16).Value = "Oct";
                    var seventeenthHead = worksheet.Cell(4, 17).Value = "Nov";
                    var eightteenthHead = worksheet.Cell(4, 18).Value = "Dec";
                    var nineteenthHead = worksheet.Cell(4, 19).Value = "Total";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 19; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "Employee Overtime Report" || ReportTitle.Trim() == "التقرير العمل الإضافي للموظف" || ReportTitle.Trim().IndexOf("Employee Extra Hours Report") != -1 ||
                         ReportTitle.Trim().IndexOf("HR Overtime Report") != -1 || ReportTitle.Trim().IndexOf(" ساعة إضافية") != -1)
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Time In";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Time Out";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Extra Hours";
                    var tenthHead = worksheet.Cell(4, 10).Value = "Overtime";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "Total Extra Hours";
                    var twelvethHead = worksheet.Cell(4, 12).Value = "Total Overtime";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 12; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "Employee Deduction Report" || ReportTitle.Trim() == "التقرير المخالفات الموظف")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "BU";
                    var secondHead = worksheet.Cell(4, 2).Value = "Department";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Section";
                    var forthHead = worksheet.Cell(4, 4).Value = "Number";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Name";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Date";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Shortage";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Voilation In Hours";
                    var ninethHead = worksheet.Cell(4, 9).Value = "Deduction Formula";
                    var tenthHead = worksheet.Cell(4, 10).Value = "Deduction Amount";
                    var eleventhHead = worksheet.Cell(4, 11).Value = "Total Deduction";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 11; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "Total Movement Report")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "Employee Code";
                    var secondHead = worksheet.Cell(4, 2).Value = "Name";
                    var thirdHead = worksheet.Cell(4, 3).Value = "Department";
                    var forthHead = worksheet.Cell(4, 4).Value = "Job";
                    var fifthHead = worksheet.Cell(4, 5).Value = "Site";
                    var sixthHead = worksheet.Cell(4, 6).Value = "Total Lateness";
                    var seventhHead = worksheet.Cell(4, 7).Value = "Total Absences";
                    var eighthHead = worksheet.Cell(4, 8).Value = "Period";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 8; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else if (ReportTitle.Trim() == "تقرير الحركة الإجمالي")
                {
                    var firstHead = worksheet.Cell(4, 1).Value = "فترة";
                    var secondHead = worksheet.Cell(4, 2).Value = "مجموع الغياب";
                    var thirdHead = worksheet.Cell(4, 3).Value = "إجمالي التأخير";
                    var forthHead = worksheet.Cell(4, 4).Value = "موقع";
                    var fifthHead = worksheet.Cell(4, 5).Value = "مهنة";
                    var sixthHead = worksheet.Cell(4, 6).Value = "قسم";
                    var seventhHead = worksheet.Cell(4, 7).Value = "اسم الموظف";
                    var eighthHead = worksheet.Cell(4, 8).Value = "رمز الموظف";
                    try
                    {
                        int rowIndex = 5;
                        foreach (DataRow row in dt.Rows)
                        {
                            //Here work
                            for (int i = 0; i < 8; i++)
                            {
                                if (dt.Columns[i].ColumnName != "Column1")
                                {
                                    if (row[i].ToString().StartsWith("-") == true)
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = "'" + row[i] + "\r".ToString();
                                    }
                                    else
                                    {
                                        worksheet.Cell(rowIndex, i + 1).Value = row[i] + " ".ToString();
                                    }
                                }
                            }
                            rowIndex++;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                using (var stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    var content = stream.ToArray();
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheet.sheet";
                    Response.AddHeader("content-disposition", "attachment; filename=" + ReportTitle + ".xlsx");
                    Response.BinaryWrite(content);
                    Response.End();
                }
            }
        }
        //private string ExportExcel(DataTable table)
        //{
        //    StringBuilder sb = new StringBuilder();
        //    try
        //    {
        //        sb.Append("<BR><BR><BR>");
        //        sb.Append("<TR><TD colspan='5' style='font-size:16.0pt; font-family:Calibri; text-align: center; font-weight:bold;'>" + ReportTitle.Replace(" ", "").Trim() + "</td></TR>");
        //        sb.Append("<TR><td>From Date</td><TD>" + fromDate + "</td>");
        //        sb.Append("<td>To Date</td><TD>" + toDate + "</td></TR>");
        //        sb.Append("<TR><td>&nbsp</td></TR>");
        //        string[] ColmHeaders = null;
        //        if (ReportTitle.Trim().IndexOf("Daily Movement Report") != -1 || ReportTitle.Trim().IndexOf("التقرير اليومى") != -1)
        //        {
        //            ColmHeaders = new string[]{"BU","Department","Section","Number","Name" ,"Date","Time In","Time Out","Late","Early","Worked Hours","Req. Hours", "Missed Hours"
        //                                     ,"Extra Hours","Schedule ","Comments" };
        //        }
        //        else if (ReportTitle.Trim() == "Employee Movements Report" || ReportTitle.Trim() == "دخول و خروج الموظف")
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Time", "Trans Mode", "Device", "Comments" };
        //        }
        //        else if (ReportTitle.Trim() == "Absentees Report" || ReportTitle.Trim() == "الغياب")
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Day", "Remarks", "Time In", "Time Out", "Late", "Early", "Worked Hour", "Req Hour", "Missed Hour", "Extra Hour", "Schedule", "Comments", "Site" };
        //        }
        //        else if (ReportTitle.Trim() == "Late In Report" || ReportTitle.Trim() == "التأخير")
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Late In", "Time In", "Time Out", "Late", "Early", "Worked Hour", "Req Hour", "Missed Hour", "Extra Hour", "Schedule", "Comments", "Site" };
        //        }
        //        else if (ReportTitle.Trim() == "Early Out Report" || ReportTitle.Trim() == "الخروج المبكر")
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Time Out", "Early Out", "Schedule" };
        //        }
        //        else if (ReportTitle.Trim() == "Attendance Summary Report" || ReportTitle.Trim() == "ملخص الحضور و الانصراف")
        //        {
        //            ColmHeaders = new string[] { "BU","Department","Section","Number", "Name", "No. of Absent Day","No. of Unauthorized Absent", "No. of Holidays",
        //                                               "No. of Late In", "Late In Hours","No. of Early Out" ,"Early Out Hours",   "Approved Leaves" ,
        //                                               "Required Hours","Working Hours", "Missing Hours", "Extra Hours","Total Hours", "No. of Missed IN", "No. of Missed Out",
        //                                               "No. of Personal Permissions","Personal Permissions Hours","No. of Official Permissions","Official Permissions Hours"};
        //        }
        //        else if (ReportTitle.Trim() == "Employee Details Report" || ReportTitle.Trim() == "بيانات الموظف")
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Join Date", "Status", "Designation" };
        //        }
        //        else if (ReportTitle.Trim() == "No Time IN Report")
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Schedule In", "Missing In", "Time In", "Time Out", "Late", "Early", "Worked Hour", "Req Hour", "Missed Hour", "Extra Hour", "Schedule", "Comments", "Site" };
        //        }
        //        else if (ReportTitle.Trim() == "No Time Out Report")
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Schedule Out", "Missing Out", "Time In", "Time Out", "Late", "Early", "Worked Hour", "Req Hour", "Missed Hour", "Extra Hour", "Schedule", "Comments", "Site" };
        //        }
        //        else if (ReportTitle.Trim().IndexOf("Permissions Report") != -1 || ReportTitle.Trim().IndexOf("تقرير الإذن") != -1)
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section",  "Number", "Name", "From Date", "To Date", "Permission Type", "From Time", "To Time","Permission Time", "Status", "Applied By",
        //                        "Approved By",  "Total Official Permission Hours", "Total Personal Permission Hours"};
        //        }
        //        else if (ReportTitle.Trim().IndexOf("No Time In/Out Report") != -1 || ReportTitle.Trim().IndexOf("تقرير بدون حركة دخول/خروج") != -1)
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Schedule In", "Time In", "Schedule Out", "Missing Out" };
        //        }
        //        else if (ReportTitle.Trim().IndexOf("Employee Year Summary Report") != -1 || ReportTitle.Trim().IndexOf("تقرير الملخص السنوية الموظف ") != -1)
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Type", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Total" };
        //        }
        //        else if (ReportTitle.Trim() == "Employee Overtime Report" || ReportTitle.Trim() == "التقرير العمل الإضافي للموظف" || ReportTitle.Trim().IndexOf("Employee Extra Hours Report") != -1 ||
        //                   ReportTitle.Trim().IndexOf("HR Overtime Report") != -1 || ReportTitle.Trim().IndexOf(" ساعة إضافية") != -1)
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Time In", "Time Out", "Extra Hours", "Overtime", "Total Extra Hours", "Total Overtime" };
        //        }
        //        else if (ReportTitle.Trim() == "Employee Deduction Report" || ReportTitle.Trim() == "التقرير المخالفات الموظف")
        //        {
        //            ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Shortage", "Violation In Hours", "Deduction Formula", "Deduction Amount", "Total Deduction" };
        //        }
        //        else if (ReportTitle.Trim() == "Total Movement Report")
        //        {
        //            ColmHeaders = new string[] { "Employee Code", "Name", "Department", "Job", "Site", "Total Lateness", "Total Absences", "Period" };
        //        }
        //        else if (ReportTitle.Trim() == "تقرير الحركة الإجمالي")
        //        {
        //            ColmHeaders = new string[] { "رمز الموظف", "اسم الموظف", "قسم", "مهنة", "موقع", "إجمالي التأخير", "مجموع الغياب", "فترة" };
        //        }

        //        for (int j = 0; j < ColmHeaders.Length; j++)
        //        {      //write in new column
        //            sb.Append("<tr><Td>");
        //            //Get column headers  and make it as bold in excel columns
        //            sb.Append("<B>");
        //            sb.Append("<tr>"+ColmHeaders[j]+"</tr>");
        //            sb.Append("</B>");
        //            sb.Append("</Td></tr>");
        //        }
        //        HttpContext.Current.Response.Write("</TR>");
        //        foreach (DataRow row in table.Rows)
        //        {//write in new row

        //            HttpContext.Current.Response.Write("<TR>");
        //            for (int i = 0; i < ColmHeaders.Length; i++)
        //            {
        //                if (table.Columns[i].ColumnName != "Column1")
        //                {
        //                    sb.Append("<Td style ='.text { mso-number-format; }'>");

        //                    if (row[i].ToString().StartsWith("-") == true)
        //                        sb.Append("'" + row[i] + "\r");
        //                    else
        //                        sb.Append((row[i] + " "));//.Replace("am", "").Replace("pm", ""));
        //                                                  //HttpContext.Current.Response.Write((row[i] + " ").Replace("am", "").Replace("pm", ""));

        //                    sb.Append("</Td>");
        //                }
        //            }
        //            sb.Append("</TR>");
        //        }

        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //    return sb.ToString();
        //}
        private void ExporttoExcel(DataTable table)
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.ClearHeaders();
            HttpContext.Current.Response.Buffer = true;
            //HttpContext.Current.Response.ContentType = "application/ms-excel";
            HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            HttpContext.Current.Response.Write(@"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">");
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + ReportTitle.Replace(" ", "").Trim() + ".xls");
            HttpContext.Current.Response.Charset = "utf-8";
            if (languagePostfix == "_arb")
                HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
            else
                HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("windows-1250");
            //sets font
            HttpContext.Current.Response.Write("<font style='font-size:10.0pt; font-family:Calibri;'>");
            HttpContext.Current.Response.Write("<BR><BR><BR>");
            //sets the table border, cell spacing, border color, font of the text, background, foreground, font height
            HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' " +
              "borderColor='#000000' cellSpacing='0' cellPadding='0' " +
              "style='font-size:10.0pt; font-family:Calibri; background:white;'> <TR>");

            HttpContext.Current.Response.Write("<TR><TD colspan='5' style='font-size:16.0pt; font-family:Calibri; text-align: center; font-weight:bold;'>" + ReportTitle.Replace(" ", "").Trim() + "</td></TR>");
            HttpContext.Current.Response.Write("<TR><td>From Date</td><TD>" + fromDate + "</td>");
            HttpContext.Current.Response.Write("<td>To Date</td><TD>" + toDate + "</td></TR>");
            HttpContext.Current.Response.Write("<TR></TR>");
            //am getting my grid's column headers
            string[] ColmHeaders = null;

            if (ReportTitle.Trim().IndexOf("Daily Movement Report") != -1 || ReportTitle.Trim().IndexOf("التقرير اليومى") != -1)
            {
                ColmHeaders = new string[]{"BU","Department","Section","Number","Name" ,"Date","Time In","Time Out","Late","Early","Worked Hours","Req. Hours", "Missed Hours"
                                             ,"Extra Hours","Schedule ","Comments" };//, "Total Late Hours","Total Early Hours","Total Missed Hours","Total Worked Hours","Total Required Hours",
                                                                                     //s"Total Extra Hours","Personal Out Hours","Business Out Hours","Total Leaves","Unauthorized Absent","Total Absent","Total Missed In/Out"};
            }
            else if (ReportTitle.Trim() == "Employee Movements Report" || ReportTitle.Trim() == "دخول و خروج الموظف")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Time", "Trans Mode", "Device", "Comments" };
            }
            else if (ReportTitle.Trim() == "Absentees Report" || ReportTitle.Trim() == "الغياب")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Day", "Remarks", "Time In", "Time Out", "Late", "Early", "Worked Hour", "Req Hour", "Missed Hour", "Extra Hour", "Schedule", "Comments", "Site" };
            }
            else if (ReportTitle.Trim() == "Late In Report" || ReportTitle.Trim() == "التأخير")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Late In", "Time In", "Time Out", "Late", "Early", "Worked Hour", "Req Hour", "Missed Hour", "Extra Hour", "Schedule", "Comments", "Site" };
            }
            else if (ReportTitle.Trim() == "Early Out Report" || ReportTitle.Trim() == "الخروج المبكر")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Time Out", "Early Out", "Schedule" };
            }
            else if (ReportTitle.Trim() == "Attendance Summary Report" || ReportTitle.Trim() == "ملخص الحضور و الانصراف")
            {
                ColmHeaders = new string[] { "BU","Department","Section","Number", "Name", "No. of Absent Day","No. of Unauthorized Absent", "No. of Holidays",
                                                       "No. of Late In", "Late In Hours","No. of Early Out" ,"Early Out Hours",   "Approved Leaves" ,
                                                       "Required Hours","Working Hours", "Missing Hours", "Extra Hours","Total Hours", "No. of Missed IN", "No. of Missed Out",
                                                       "No. of Personal Permissions","Personal Permissions Hours","No. of Official Permissions","Official Permissions Hours"};
            }
            else if (ReportTitle.Trim() == "Employee Details Report" || ReportTitle.Trim() == "بيانات الموظف")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Join Date", "Status", "Designation" };
            }
            else if (ReportTitle.Trim() == "No Time IN Report")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Schedule In", "Missing In", "Time In", "Time Out", "Late", "Early", "Worked Hour", "Req Hour", "Missed Hour", "Extra Hour", "Schedule", "Comments", "Site" };
            }
            else if (ReportTitle.Trim() == "No Time Out Report")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Schedule Out", "Missing Out", "Time In", "Time Out", "Late", "Early", "Worked Hour", "Req Hour", "Missed Hour", "Extra Hour", "Schedule", "Comments", "Site" };
            }
            else if (ReportTitle.Trim().IndexOf("Permissions Report") != -1 || ReportTitle.Trim().IndexOf("تقرير الإذن") != -1)
            {
                ColmHeaders = new string[] { "BU", "Department", "Section",  "Number", "Name", "From Date", "To Date", "Permission Type", "From Time", "To Time","Permission Time", "Status", "Applied By",
                                "Approved By",  "Total Official Permission Hours", "Total Personal Permission Hours"};
            }
            else if (ReportTitle.Trim().IndexOf("No Time In/Out Report") != -1 || ReportTitle.Trim().IndexOf("تقرير بدون حركة دخول/خروج") != -1)
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Schedule In", "Time In", "Schedule Out", "Missing Out" };
            }
            else if (ReportTitle.Trim().IndexOf("Employee Year Summary Report") != -1 || ReportTitle.Trim().IndexOf("تقرير الملخص السنوية الموظف ") != -1)
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Type", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Total" };
            }
            else if (ReportTitle.Trim() == "Employee Overtime Report" || ReportTitle.Trim() == "التقرير العمل الإضافي للموظف" || ReportTitle.Trim().IndexOf("Employee Extra Hours Report") != -1 ||
                       ReportTitle.Trim().IndexOf("HR Overtime Report") != -1 || ReportTitle.Trim().IndexOf(" ساعة إضافية") != -1)
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Time In", "Time Out", "Extra Hours", "Overtime", "Total Extra Hours", "Total Overtime" };
            }
            else if (ReportTitle.Trim() == "Employee Deduction Report" || ReportTitle.Trim() == "التقرير المخالفات الموظف")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Shortage", "Violation In Hours", "Deduction Formula", "Deduction Amount", "Total Deduction" };
            }
            else if (ReportTitle.Trim() == "Total Movement Report")
            {
                ColmHeaders = new string[] { "Employee Code", "Name", "Department", "Job", "Site", "Total Lateness", "Total Absences", "Period" };
            }
            else if (ReportTitle.Trim() == "تقرير الحركة الإجمالي")
            {
                ColmHeaders = new string[] { "رمز الموظف", "اسم الموظف", "قسم", "مهنة", "موقع", "إجمالي التأخير", "مجموع الغياب", "فترة" };
            }
            int w = 0;
            try
            {

                for (int j = 0; j < ColmHeaders.Length; j++)
                {      //write in new column
                    HttpContext.Current.Response.Write("<Td>");
                    //Get column headers  and make it as bold in excel columns
                    HttpContext.Current.Response.Write("<B>");
                    HttpContext.Current.Response.Write(ColmHeaders[j]);
                    HttpContext.Current.Response.Write("</B>");
                    HttpContext.Current.Response.Write("</Td>");
                }
                HttpContext.Current.Response.Write("</TR>");
                foreach (DataRow row in table.Rows)
                {//write in new row

                    HttpContext.Current.Response.Write("<TR>");
                    for (int i = 0; i < ColmHeaders.Length; i++)
                    {
                        if (table.Columns[i].ColumnName != "Column1")
                        {
                            HttpContext.Current.Response.Write("<Td style ='.text { mso-number-format; }'>");

                            if (row[i].ToString().StartsWith("-") == true)
                                HttpContext.Current.Response.Write("'" + row[i] + "\r");
                            else
                                HttpContext.Current.Response.Write((row[i] + " "));//.Replace("am", "").Replace("pm", ""));
                                                                                   //HttpContext.Current.Response.Write((row[i] + " ").Replace("am", "").Replace("pm", ""));

                            HttpContext.Current.Response.Write("</Td>");
                        }
                    }

                    HttpContext.Current.Response.Write("</TR>");
                }
            }
            catch (Exception ex)
            {

            }
            HttpContext.Current.Response.Write("</Table>");
            HttpContext.Current.Response.Write("</font>");
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }
        private void ReportLogOn()
        {

            try
            {
                TableLogOnInfos tableLogOnInfos = new TableLogOnInfos();//CrystalReportViewer1.LogOnInfo;
                string strConnInfo = System.Configuration.ConfigurationManager.AppSettings["DbConnectionString"].ToString();
                string[] connValues = strConnInfo.Split(';');
                string serverName = connValues[0];
                string dbName = connValues[1];
                string userID = connValues[2];
                string password = connValues[3];

                ConnectionInfo connectionInfo = new ConnectionInfo();
                //connectionInfo.ServerName = serverName;
                //connectionInfo.DatabaseName = dbName;
                //connectionInfo.UserID = userID;
                //connectionInfo.Password = password;

                string server = ConfigurationSettings.AppSettings["dbServer"];
                connectionInfo.ServerName = server;
                connectionInfo.DatabaseName = Session["dbName"] + "";
                connectionInfo.UserID = Session["dbUser"] + "";
                connectionInfo.Password = Session["dbPassword"] + "";
                TableLogOnInfo tbl = new TableLogOnInfo();

                tbl.ConnectionInfo = connectionInfo;
                tableLogOnInfos.Add(tbl);
                CrystalReportViewer1.LogOnInfo = tableLogOnInfos;
            }
            catch (Exception ex)
            {
               Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(ex));
            }

        }


        protected void LoadReportColumns()
        {
            TAMSR2Data objData = new TAMSR2Data();
            try
            {
                Hashtable ht = new Hashtable();

                ht.Add("action", "GetAllColumns");
                ht.Add("SortCols", "Sort By");
                ht.Add("GroupCols", "Group By");
                ht.Add("ReportCols", "Report Column");
                ht.Add("tempID", (Request["ReportCode"] + "").Trim());
                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                DataView objDataView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                ReportColumns = "";
                if (cookie.Values["language"] + "" == "ar")
                    ReportColumns = objDataView[0].Row.ItemArray[5] + "";
                else
                    ReportColumns = objDataView[0].Row.ItemArray[4] + "";
                if (objDataView[0].Row["ReportImage"] != null)
                {
                    logostream = new MemoryStream((byte[])(objDataView[0].Row["ReportImage"]));

                }




            }
            catch (Exception ex)
            {
                Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(ex));
            }
            finally
            {
            }
        }

        protected void SetParameterFields(ReportDocument rpt, string ParamValues)
        {
            try
            {
                string[] ColumnValues = ParamValues.Split(',');
                string FilterValues = Session["FilVal"] + "";

                string[] FilterVal = FilterValues.Split('#');
                string Val = "";
                string FilterForReport = "";
                //rpt.ReportDefinition.Sections["Section1"].ReportObjects[""]. = ResolveUrl("~/assets/en/img/logo-bid.png");

                for (int i = 0; i < rpt.ParameterFields.Count; i++)
                {
                    string abc = rpt.ParameterFields[i].Name;
                    Val = "";
                    if (i < ColumnValues.Length)
                    {
                        rpt.SetParameterValue(i, ColumnValues[i] + "");
                    }
                    else if (!abc.Contains("FilterParam"))
                    {
                        rpt.SetParameterValue(i, "");
                    }
                }

                try
                {
                    string fromDate = (Request["FromDate"] + "").Trim();
                    string toDate = (Request["ToDate"] + "").Trim();
                    if (cookie.Values["language"] + "" == "en")
                    {
                        fromDate = "From Date: " + Numerics.GetDateTime(fromDate).ToString("dd-MM-yyyy");
                        toDate = "To Date: " + Numerics.GetDateTime(toDate).ToString("dd-MM-yyyy");

                        if (ReportID != "7")
                        {
                            TextObject objTxt = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtParam" + 5];
                            objTxt.Text = fromDate.Trim();

                            TextObject objTxt2 = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtParam" + 4];
                            objTxt2.Text = toDate.Trim();
                        }
                    }
                    else
                    {
                        fromDate = "" + Numerics.GetDateTime(fromDate).ToString("yyyy-MM-dd") + "  :من";
                        toDate = "" + Numerics.GetDateTime(toDate).ToString("yyyy-MM-dd") + "  :الى";

                        if (ReportID != "7")
                        {
                            TextObject objTxt = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtParam" + 4];
                            objTxt.Text = fromDate.Trim();

                            TextObject objTxt2 = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtParam" + 5];
                            objTxt2.Text = toDate.Trim();
                        }

                    }
                }
                catch (System.Exception ex)
                {

                    Elmah.ErrorLog.GetDefault(HttpContext.Current).Log(new Elmah.Error(ex));
                }

            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("ViewRptPage.aspx.ReportGen()", 0, ex);
            }

        }



        protected override void OnUnload(EventArgs e)
        {
            base.OnUnload(e);
            try
            {
                rpt.Close();
                rpt.Dispose();
            }
            catch (Exception ex)
            {
            }
        }


    }
}