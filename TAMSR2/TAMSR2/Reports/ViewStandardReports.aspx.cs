using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Collections;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

using CrystalDecisions.CrystalReports;
using CrystalDecisions.Reporting;
using CrystalDecisions.Shared;
using CrystalDecisions.ReportSource;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.ReportAppServer;

using TAMSR2.ObjectClasses;
using TAMSR2.CustomClasses;
using TAMSR2.CrystalReports;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Reports
{
    public partial class ViewStandardReports : BasePage
    {
        ReportDocument rpt = new ReportDocument();
        HttpCookie cookie;
        protected void Page_Init(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewstandardreports.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/viewstandardreports.aspx"));
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
           
            #region User Authentication and Preferences
            /// <summary>
            /// Checks Session variable for login, if windows login is not activate 
            /// otherwise Authenticate user by windows login if Windows Login is activated in Web.config
            /// And also Set Page Culture Variables for user preffered language.
            /// </summary>
            if (UserAuthentication() == false)
            {
                Response.Redirect(path + "Login");
            }
            SetCultureValues();
            #endregion

            ShowStandardReports();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            


          

        }

        protected void ShowStandardReports()
        {
            
            try
            {

               
                string SaveReportName = "";  
                int ReportID = Convert.ToInt32(Session["ReportID"] + "".Trim());
                if (cookie.Values["language"] + "" == "ar")
                {
                    if (ReportID == 1)
                    {

                        rpt.Load(Server.MapPath("../CrystalReports/DailyMovementReport_Arb.rpt"));
                            SaveReportName = "EmployeeSpecialReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 2)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/AbsenteesReport_Arb.rpt"));
                            SaveReportName = "Absentees" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 3)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/PermissionReport_Arb.rpt"));
                        SaveReportName = "PermissionReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 4)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/SummaryViolationReport_Arb.rpt"));
                        SaveReportName = "SummaryViolationReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 5)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/LeaveReport_Arb.rpt"));
                        SaveReportName = "LeaveReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 6)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/NotApprovedPermissionReport_Arb.rpt"));
                        SaveReportName = "NotApprovedPermissionReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                }
                else
                {
                    if (ReportID == 1)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/DailyMovementReport_Eng.rpt"));
                        SaveReportName = "EmployeeSpecialReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 2)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/AbsenteesReport_Eng.rpt"));
                        SaveReportName = "AbsenteesReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 3)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/PermissionReport_Eng.rpt"));
                        SaveReportName = "PermissionReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 4)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/SummaryViolationReport_Eng.rpt"));
                        SaveReportName = "SummaryViolationReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 5)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/LeaveReport_Eng.rpt"));
                        SaveReportName = "LeaveReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                    else if (ReportID == 6)
                    {
                        rpt.Load(Server.MapPath("../CrystalReports/NotApprovedPermissionReport_Eng.rpt"));
                        SaveReportName = "NotApprovedPermissionReport" + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");
                    }
                     
                }
                CrystalReportViewer1.ReportSource = rpt;
                ReportLogOn();

               
                 
                DataTable dt = new DataTable();
                DataView dv = (DataView)Session["StandardReport"];
                dt = dv.Table;


                TextObject FromDate = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtFromDate"];
                TextObject ToDate = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtToDate"];

                CrystalDecisions.CrystalReports.Engine.PictureObject obj = (CrystalDecisions.CrystalReports.Engine.PictureObject)rpt.ReportDefinition.Sections["Section1"].ReportObjects["Picture1"];
                //obj.pic

                FromDate.Text = Session["FromDate"] + "";
                ToDate.Text = Session["ToDate"] + "";

               // ReportColumnsHeaders(ReportID);

                rpt.SetDataSource(dt);

               // rpt.SummaryInfo.ReportTitle = Session["StandardReportName"] + "";
                rpt.SummaryInfo.ReportAuthor = Session["Username"].ToString().Trim();
                CrystalReportViewer1.BestFitPage = true;
                CrystalReportViewer1.DocumentView = DocumentViewType.WebLayout;
                CrystalReportViewer1.DisplayToolbar = true;
                CrystalReportViewer1.HasExportButton = true;
                CrystalReportViewer1.HasPrintButton = true;
                CrystalReportViewer1.HasRefreshButton = false;
                rpt.ReportOptions.EnableUseDummyData = false;



                CrystalReportViewer1.ReportSource = rpt;
                //CrystalReportViewer1.DataBind();
                CrystalReportViewer1.RefreshReport();
               // string SaveReportName = rpt.SummaryInfo.ReportTitle.ToString().Replace(" ", string.Empty) + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");

                string Key = Request["key"].ToString().ToLower();
                if (Key == "viewreport")
                {
                    System.IO.MemoryStream oStream = (System.IO.MemoryStream)rpt.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(oStream.ToArray());
                    Response.End();
                    Session["Report"] = rpt;

                }
                else if (Key == "excel")
                {

                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.Buffer = true;
                    rpt.ExportToHttpResponse(ExportFormatType.Excel, Response,true, SaveReportName);

                    Session["Report"] = rpt;
                    return;
                    // Response.Redirect("../Reports/ReportWizard.aspx");
                }
                else if (Key == "word")
                {
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.Buffer = true;
                    rpt.ExportToHttpResponse(ExportFormatType.WordForWindows, Response, true, SaveReportName);
                    Session["Report"] = rpt;
                    return;
                }
                else if (Key == "pdf")
                {
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.Buffer = true;
                    rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, SaveReportName);
                    Session["Report"] = rpt;
                    return;
                }

                Session["StandardReport"] = "";
                if (rpt != null)
                {
                    rpt.Close();
                    rpt.Dispose();
                }
            }
            catch (System.Exception ex)
            {
                Session["StandardReport"] = "";
                CrystalReportViewer1.ReportSource = null;
                new ExceptionLog().WriteLog("Reports/RosterReport.aspx.ShowStandardReports()", 0, ex);
            }

        }

        #region ReportLogOn

        private void ReportLogOn()
        {

            TableLogOnInfos tableLogOnInfos = new TableLogOnInfos();//CrystalReportViewer1.LogOnInfo;
            string strConnInfo = System.Configuration.ConfigurationManager.AppSettings["DbConnectionString"].ToString();
            string[] connValues = strConnInfo.Split(';');
            string serverName = connValues[0];
            string dbName = connValues[1];
            string userID = connValues[2];
            string password = connValues[3];

            ConnectionInfo connectionInfo = new ConnectionInfo();

            string server = ConfigurationManager.AppSettings["dbServer"];
            connectionInfo.ServerName = server;
            connectionInfo.DatabaseName = Session["dbName"] + "";
            connectionInfo.UserID = Session["dbUser"] + "";
            connectionInfo.Password = Session["dbPassword"] + "";
            TableLogOnInfo tbl = new TableLogOnInfo();

            tbl.ConnectionInfo = connectionInfo;
            tableLogOnInfos.Add(tbl);
            CrystalReportViewer1.LogOnInfo = tableLogOnInfos;

        }

        #endregion

        #region ReportColumns

        protected void ReportColumnsHeaders( int ReportID)
        {
            try
            {

                switch (ReportID)
                {
                    case 1:
                        {
                            TextObject lblDepartment = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblDepartment"];
                            TextObject lblSection = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblSection"];
                            TextObject lblName = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblName"];
                            TextObject lblEmpNumber = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblEmpNumber"];

                            TextObject lbldate = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtH1"];
                            TextObject lbltimein = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtH2"];
                            TextObject lbltimeout = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtH3"];
                            TextObject lblworkhours = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtH4"];
                            TextObject lbllate = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtH5"];
                            TextObject lblearly = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtH6"];
                            TextObject lblcomments = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtH7"];
                            TextObject lblremarks = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtH8"];

                            TextObject lblLatecount = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblLatecount"];
                            TextObject lblEarlyCount = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblEarlyCount"];
                            TextObject lblAbsentCount = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblAbsentCount"];
                            TextObject lblLeaveCount = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblLeaveCount"];
                            TextObject lblEarlyMinutes = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblEarlyMinutes"];
                            TextObject lblLateMinutes = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["lblLateMinutes"];

                            lblDepartment.Text = Resources.Resource.lblLocation;
                            lblSection.Text = Resources.Resource.lblSection;
                            lblName.Text = Resources.Resource.name;
                            lblEmpNumber.Text = Resources.Resource.employeeNumber;

                            lbldate.Text = Resources.Resource.date;
                            lbltimein.Text = Resources.Resource.timeIn;
                            lbltimeout.Text = Resources.Resource.timeOut;
                            lblworkhours.Text = Resources.Resource.workHours;
                            lbllate.Text = Resources.Resource.late;
                            lblearly.Text = Resources.Resource.early;
                            lblcomments.Text = Resources.Resource.lblComments;
                            lblremarks.Text = Resources.Resource.remarks;


                            lblLatecount.Text = Resources.Resource.totalLate;
                            lblEarlyCount.Text = Resources.Resource.totalEarly;
                            lblAbsentCount.Text = Resources.Resource.totalAbsents;
                            lblLeaveCount.Text = Resources.Resource.totalLeaves;
                            lblEarlyMinutes.Text = Resources.Resource.earlyMinutes;
                            lblLateMinutes.Text = Resources.Resource.lateMinutes;
                                 
                        }
                        break;
                    default:
                        break;
                }

            }
            catch (Exception e) 
            {
                
                 ;
            }
        }

        #endregion

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