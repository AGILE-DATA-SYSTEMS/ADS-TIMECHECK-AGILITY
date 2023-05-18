using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
using System.IO;


namespace TAMSR2.Reports
{
    public partial class RosterReport1 : BasePage
    {
        ReportDocument rpt = new ReportDocument();

        string appLogoFileName = ConfigurationManager.AppSettings["ApplicationLogoFileName"];
        protected void Page_Init(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("rosterreport.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/rosterreport.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("reports/roster-report"));

            CrystalReportViewer1.PrintMode = CrystalDecisions.Web.PrintMode.ActiveX;

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

            ShowRosterReport();  
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
              
        protected void ShowRosterReport()
        {
            try
            {
                rpt.Load(Server.MapPath("../CrystalReports/RptRoster.rpt"));
                CrystalReportViewer1.ReportSource = rpt;
                ReportLogOn();
                
                DataTable dt = new DataTable();
                DataView dv = (DataView)Session["RosterReport"];
                dt = dv.Table;

                try
                {
                    DataColumn colByteArray = new DataColumn("Column50");
                    colByteArray.DataType = System.Type.GetType("System.Byte[]");
                    colByteArray.DefaultValue = File.ReadAllBytes(Server.MapPath("../Images/" + appLogoFileName));
                    if (dt.Rows.Count == 0)
                    {
                        dt.Rows.Add();
                    }
                  //  dt.Columns.Remove("Column50");
                    dt.Columns.Add(colByteArray);
                }
                catch (Exception e)
                {
                }
                
                TextObject FromDate = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["FromDate"];
                TextObject ToDate = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["ToDate"];
                //TextObject Orgn = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["Org"];
                //TextObject Emp = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["Employee"];
          //      PictureObject img = (PictureObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["ReportImage"];
               

                FromDate.Text = Session["FromDate"] + "";
                ToDate.Text = Session["ToDate"] + "";
                //Emp.Text = Session["EmpName"] + "";
                //Orgn.Text = Session["OrgName"] + "";
                

                List<ScheduleTime> schList = new ScheduleTime().GetAllSchListByOrgName(Session["ID"] + "", Session["OrgName"] + "");
                
                rpt.SetDataSource(dt);
               // rpt.Subreports[0].SetDataSource(schList);
                //RptSchCode rptsch = new RptSchCode();
                //rpt.Subreports[0].SetDataSource(schList);
                //rptsch.OpenSubreport("RptSchCode.rpt");
                rpt.SummaryInfo.ReportTitle = (string)GetGlobalResourceObject("Resource", "monthlyRoster");
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

                string SaveReportName = rpt.SummaryInfo.ReportTitle.ToString().Replace(" ", string.Empty) + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");

                string Key = Request["key"].ToString().ToLower();
                if (Key == "viewreport")
                {
                    //System.IO.MemoryStream oStream = (System.IO.MemoryStream)rpt.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                    //Response.Clear();
                    //Response.Buffer = true;
                    //Response.ContentType = "application/pdf";
                    //Response.BinaryWrite(oStream.ToArray());
                    //Response.End();
                    //Session["Report"] = rpt;
                    //byte[] byteArray = null;
                    //System.IO.Stream oStream = (System.IO.Stream)rpt.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                    //byteArray = new byte[oStream.Length];
                    //oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));
                    //Response.Clear();
                    //Response.Buffer = true;
                    //Response.ContentType = "application/pdf";
                    //Response.BinaryWrite(byteArray);
                    //Response.End();

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
                else if (Key == "excel")
                {

                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.Buffer = true;
                    rpt.ExportToHttpResponse(ExportFormatType.XLSXRecord, Response, true, SaveReportName);

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

               // Session["rpt"] = rpt;
            }
            catch (System.Exception ex)
            {
                CrystalReportViewer1.ReportSource = null;
                new ExceptionLog().WriteLog("Reports/RosterReport.aspx.ShowRosterReport()", 0, ex);
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