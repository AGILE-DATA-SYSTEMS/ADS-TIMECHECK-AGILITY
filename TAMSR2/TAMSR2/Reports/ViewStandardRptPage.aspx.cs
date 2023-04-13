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
                        ExporttoExcel(dt); 

                    }
                    else
                    { 
                        rpt.ExportOptions.ExportFormatType = ExportFormatType.Excel; 
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



        private void ExporttoExcel(DataTable table)
        {

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.ClearHeaders();
            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            HttpContext.Current.Response.Write(@"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">");
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=" + ReportTitle.Replace(" ", "").Trim() + ".xls");

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
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Day" ,  "Remarks" , "Time In" , "Time Out" , "Late" , "Early" , "Worked Hour" , "Req Hour" , "Missed Hour" , "Extra Hour" , "Schedule" , "Comments" , "Site" };
            }
            else if (ReportTitle.Trim() == "Late In Report" || ReportTitle.Trim() == "التأخير")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Late In", "Time In" , "Time Out" , "Late" , "Early" , "Worked Hour" , "Req Hour" , "Missed Hour" , "Extra Hour" , "Schedule" , "Comments" , "Site" };
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
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Schedule In", "Missing In", "Time In" , "Time Out" , "Late" , "Early" , "Worked Hour" , "Req Hour" , "Missed Hour" , "Extra Hour" , "Schedule" , "Comments" , "Site" };
            }
            else if (ReportTitle.Trim() == "No Time Out Report")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Schedule Out", "Missing Out" , "Time In" , "Time Out" , "Late" , "Early" , "Worked Hour" , "Req Hour" , "Missed Hour" , "Extra Hour" , "Schedule" , "Comments" , "Site" };
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
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Time In", "Time Out", "Extra Hours","Overtime","Total Extra Hours","Total Overtime" };
            }
            else if (ReportTitle.Trim() == "Employee Deduction Report" || ReportTitle.Trim() == "التقرير المخالفات الموظف")
            {
                ColmHeaders = new string[] { "BU", "Department", "Section", "Number", "Name", "Date", "Shortage", "Violation In Hours", "Deduction Formula", "Deduction Amount", "Total Deduction" };
            }
            else if (ReportTitle.Trim() == "Total Movement Report")
            {
                ColmHeaders = new string[] { "Employee Code", "Name", "Department", "Job", "Site", "Total Lateness", "Total Absences", "Period"};
            }
            else if(ReportTitle.Trim() == "تقرير الحركة الإجمالي")
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
                    for (int i = 0; i <= ColmHeaders.Length; i++)
                    {
                        if (table.Columns[i].ColumnName != "Column1" 
                            //&& ((ReportTitle.Trim().IndexOf("Daily Movement Report") != -1 || ReportTitle.Trim().IndexOf("التقرير اليومى") != -1)
                            //|| (ReportTitle.Trim().IndexOf("Employee Year Summary Report") != -1 || ReportTitle.Trim().IndexOf("تقرير الملخص السنوية الموظف ") != -1)
                            //|| (ReportTitle.Trim() == "Attendance Summary Report" || ReportTitle.Trim() == "ملخص الحضور و الانصراف")
                            //|| (ReportTitle.Trim().IndexOf("No Time In/Out Report") != -1 || ReportTitle.Trim().IndexOf("تقرير بدون حركة دخول/خروج") != -1)
                            //|| (ReportTitle.Trim() == "Absentees Report" || ReportTitle.Trim() == "الغياب")
                            //   )
                            )
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