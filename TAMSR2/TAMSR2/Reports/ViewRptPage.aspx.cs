using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing.Printing;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using System.Windows.Forms;
using System.Collections;
using System.Text;
using System.Threading;
using System.Timers;
using TAMSR2.ObjectClasses;

namespace TAMSR2.Reports
{
    public partial class ViewRptPage : BasePage
    {
        public PrinterSettings.StringCollection InstalledPrinters
        {
            get
            {
                return PrinterSettings.InstalledPrinters;
            }
        }


        ReportDocument rpt = new ReportDocument();
        string ReportTitle = "";
        string appLogoFileName = ConfigurationManager.AppSettings["ApplicationLogoFileName"];

        protected void Page_Init(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewrptpage.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/viewrptpage.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("reports/report-view"));

            CrystalReportViewer1.PrintMode = CrystalDecisions.Web.PrintMode.Pdf;

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



            ReportGen();

        }

        protected void Page_Load(object sender, EventArgs e)
        {


        }


        #region GenrateReport

        public void ReportGen()
        {
            string ParamVal = "";
            string TableName = "";
            string Columns = "";
            string sortBy = "";
            string groupBy = "";
            string Filt = "";
            string ReportOrentation = "";
            string sortOrder = "";
            string[] GroupBy;



            TAMSR2Data objData = new TAMSR2Data();
            PrinterSettings setting = new PrinterSettings();
            try
            {

                DataView objDataView = (DataView)Session["DataView"];


                sortBy = objDataView[0].Row.ItemArray[0].ToString();
                groupBy = objDataView[0].Row.ItemArray[1].ToString();
                Columns = objDataView[0].Row.ItemArray[2].ToString();
                TableName = objDataView[0].Row.ItemArray[3].ToString();
                ReportOrentation = objDataView[0].Row.ItemArray[8].ToString();
                sortOrder = objDataView[0].Row.ItemArray[9].ToString();
                GroupBy = groupBy.Split(',');
                if (languageStr == "en")
                {
                    ParamVal = objDataView[0].Row.ItemArray[4].ToString();
                    ReportTitle = objDataView[0].Row.ItemArray[6].ToString();
                }
                else
                {
                    ParamVal = objDataView[0].Row.ItemArray[5].ToString();
                    ReportTitle = objDataView[0].Row.ItemArray[7].ToString();
                }
                if (ReportOrentation == "Portrait")
                   rpt.Load(Server.MapPath("../CrystalReports/Std_5_ReportEngine.rpt"));
                else
                    rpt.Load(Server.MapPath("../CrystalReports/Std_6_ReportEngine.rpt"));

                CrystalReportViewer1.ReportSource = rpt;

                ReportLogOn();
                DataSet DSS = new DataSet();
                string objType = Session["objType"] + "";
                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                DataView DView = null;
                if (objType != "P")
                {
                    string query = CreateSelectQuery(Columns, TableName, sortBy, sortOrder);
                    if (query == "")
                        return;
                    DView = objData.Connection.ExecuteQuery(query);
                }
                else
                {
                    string filters = Session["Filters"].ToString();
                    filters = filters.Replace('"', ' ').Replace('\'', ' ');
                    string[] Seprator = { "AND", "=" };
                    string[] Fil = filters.Split(Seprator, StringSplitOptions.RemoveEmptyEntries);
                    string filVal = Session["FilVal"].ToString();

                    Hashtable ht = new Hashtable();

                    try
                    {
                        //if (filters.Contains("1 =  > 2)
                        //{
                        for (int m = 0; m < Fil.Length && filVal != "1#  =     #1#"; m = m + 2)
                        {
                            if ((Fil[m] + "").Trim() != "" && (Fil[m] + "").Trim() != "1" && (Fil[m + 1] + "").Trim() != "")
                                ht.Add((Fil[m] + "").Trim(), (Fil[m + 1] + "").Trim());
                            else if ((Fil[m] + "").Trim() != "" && (Fil[m + 1] + "").Trim() == "")
                                ht.Add((Fil[m] + "").Trim(), DBNull.Value);
                        }
                        //}
                        ht.Add("sessionID", Session["ID"] + "");
                        int isArabic = 0;

                        if (languageStr == "ar")
                            isArabic = 1;
                        else
                            isArabic = 0;

                        ht.Add("isArabic", isArabic);
                        DView = objData.Connection.ExecuteProcedure(TableName, ht);
                    }
                    catch (Exception ee)
                    {

                    }

                }
                DataTable dt = new DataTable();
                dt = DView.Table;
                try
                {
                    DataColumn colByteArray = new DataColumn("Column50");
                    colByteArray.DataType = System.Type.GetType("System.Byte[]");
                    colByteArray.DefaultValue = File.ReadAllBytes(Server.MapPath("../Images/" + appLogoFileName));
                    dt.Columns.Add(colByteArray);

                    ////dt.Rows[0].ItemArray[dt.Columns.Count - 1] = File.ReadAllBytes(Server.MapPath("../Images/app-logo.jpg"));
                }
                catch (Exception ex)
                { }
                //dt.Rows[0].ItemArray[49] = File.ReadAllBytes(Server.MapPath("../Images/app-logo.jpg"));
                int j = 11;
                //for (int i = 0; i < 5; i++)
                //{
                //    if (i < GroupBy.Length && GroupBy.Length >= 1)
                //    {
                //        DataColumn NewColumn = dt.Columns.Add("Column" + j);
                //        // NewColumn.DefaultValue = GroupBy[i].ToString();
                //        for (int ii = 0; ii < dt.Rows.Count; ii++)
                //        {
                //            dt.Rows[ii]["Column" + j] = GroupBy[i].ToString();
                //        }
                //        j++;
                //    }
                //    else
                //    {
                //        DataColumn NewColumn = dt.Columns.Add("Column" + j);
                //        // NewColumn.DefaultValue = GroupBy[i].ToString();
                //        for (int ii = 0; ii < dt.Rows.Count; ii++)
                //        {
                //            dt.Rows[ii]["Column" + j] = null;
                //        }
                //        j++;
                //    }
                //}

                rpt.SetDataSource(dt);

                SetParameterFields(rpt, ParamVal);


                //CrystalReportViewer1.SeparatePages = false;
                CrystalReportViewer1.BestFitPage = true;
                CrystalReportViewer1.DocumentView = DocumentViewType.WebLayout;
                rpt.SummaryInfo.ReportTitle = ReportTitle.Trim();

                rpt.SummaryInfo.ReportAuthor = Session["Username"].ToString().Trim();
                if (ReportOrentation == "Portrait")
                {

                    rpt.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
                }
                else
                {
                    rpt.PrintOptions.PaperOrientation = PaperOrientation.Landscape;
                }
                CrystalReportViewer1.DisplayToolbar = true;
                CrystalReportViewer1.HasExportButton = true;
                CrystalReportViewer1.HasPrintButton = true;
                CrystalReportViewer1.HasRefreshButton = false;


                //   CrystalReportViewer1.ReportSource = rpt;

                string SaveReportName = rpt.SummaryInfo.ReportTitle.ToString().Replace(" ", string.Empty) + "-" + DateTime.Now.Date.ToString("yyyy-MM-dd");

                string Key = Request["key"].ToString().ToLower();
                if (Key == "showreport")
                {
                    System.IO.Stream oStream = null;
                    byte[] byteArray = null;
                    oStream = rpt.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                    byteArray = new byte[oStream.Length];
                    oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(byteArray);
                    Response.End();
                    Session["Report"] = rpt;

                }
                else if (Key == "excel")
                {
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.Buffer = true;
                    rpt.ExportToHttpResponse(ExportFormatType.Excel, Response, true, SaveReportName);

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
                // Session["Report"] = rpt;

            }
            catch (Exception ex)
            {
                CrystalReportViewer1.ReportSource = null;
                new ExceptionLog().WriteLog("ViewRptPage.aspx.ReportGen()", 0, ex.InnerException);
                return;
            }

        }


        private string CreateSelectQuery(string col, string TableName, string SortBy, string SortOrder)
        {
            string GroupID = Session["GroupID"] + "";
            string query = "SELECT ";//ID As Column1 ,NameEn As Column2, NameAr As Column3,Email As Column4,NameEn As Column5,NameEn As Column6,NameEn As Column7,NameEn As Column8,NameEn As Column9";
            string WhereCaluse = Session["Filters"].ToString();
            string[] Columns = col.Split(',');

            //commented by syed wajahat //for (int i = 0; i < Columns.Length - 1; i++)
            for (int i = 0; i < Columns.Length ; i++)
            {

                if (languageStr == "en")
                {
                    if (Columns[i].ToLower().Contains("date"))
                        query += "Convert(nvarchar(10)," + Columns[i].ToString() + " ,121) As Column" + (i + 1) + " ,";
                    else
                    {
                        if (Columns[i].ToLower().Trim().Contains("_arabic"))
                        {
                            Columns[i] = Columns[i].Trim().ToLower().Replace("_arabic", "_english");
                        }

                        query += Columns[i].ToString() + " As Column" + (i + 1) + " ,";
                    }
                }
                else if (languageStr == "ar")
                {
                    if (Columns[i].ToLower().Contains("date"))
                        query += "Convert(nvarchar(10)," + Columns[i].ToString() + " ,121) As Column" + (i + 1) + " ,";
                    else
                    {
                        if (Columns[i].ToLower().Trim().Contains("_english"))
                        {
                            Columns[i] = Columns[i].Trim().ToLower().Replace("_english", "_arabic");
                        }
                        query += Columns[i].ToString() + " As Column" + (i + 1) + " ,";
                    }
                }
            }
            //query = query.Remove(query.LastIndexOf(','), 1);
            string groupBy = "";
            string[] GroupBy;
            DataView objDataView = (DataView)Session["DataView"];
            groupBy = objDataView[0].Row.ItemArray[1].ToString();
            GroupBy = groupBy.Split(',');

            int groupColumnStartIndex = 11;

            if (ReportTitle.Trim() == "Daily Movement Report" || ReportTitle.Trim() == "التقرير اليومى"
                    || ReportTitle.Trim() == "Attendance Summary" || ReportTitle.Trim() == "مخلص الدوام")
            {
                groupColumnStartIndex = 14;
            }

            for (int i = 0; i < GroupBy.Length || i < 5; i++)
            {
                

                if (i >= GroupBy.Length)
                {
                    query += ", null As Column" + (i + 11);
                }
                else
                {
                    if (GroupBy[i].ToString().Trim() == "")
                    {

                        query += " null As Column" + (i + groupColumnStartIndex);
                    }
                    else
                    {
                        if (languageStr == "en")
                        {
                            if (GroupBy[i].ToLower().Trim().Contains("_arabic"))
                            {
                                GroupBy[i] = GroupBy[i].Trim().ToLower().Replace("_arabic", "_english");
                            }
                        }
                        else if (languageStr == "ar")
                        {

                            if (GroupBy[i].ToLower().Trim().Contains("_english"))
                            {
                                GroupBy[i] = GroupBy[i].Trim().ToLower().Replace("_english", "_arabic");
                            }
                        }
                        query += GroupBy[i].ToString().Trim() + " As Column" + (i + groupColumnStartIndex);
                    }


                }

            }

            query += "  FROM " + TableName.Trim();
            if (GroupID != "" && (query.Contains("Employee_") || query.Contains("EmployeeTrans") || query.Contains("EmployeeOverTime") || query.Contains("_Employee")))
            {
                query += "  WHERE    Employee_ID in (select Employee_ID from employee_group_members where employee_group_id = " + GroupID + ")  AND " + WhereCaluse;

            }
            else
                if (query.Contains("Employee_") || query.Contains("EmployeeTrans") || query.Contains("EmployeeOverTime") || query.Contains("_Employee"))
                {
                    query += "  WHERE " + WhereCaluse + " and Employee_Id in (" + GetPrivilegeEmployeeIds() + ")";
                }
                else
                {
                    query += "  WHERE " + WhereCaluse;
                }

            string order = "";
            if (SortOrder == "Ascending")
            {
                order = "Asc";
            }
            else
            {
                order = "Desc";
            }
            if (SortBy.Trim() != "")
                query += "  ORDER BY " + SortBy + "  " + order;
            return query;

        }

        public string GetPrivilegeEmployeeIds()
        {
            int includeInactive = 0;
            if ((Request["includeInactive"] + "").Trim().ToLower() == "true"
                && new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INCLUDE_INACTIVE_STAFF_IN_REPORTS) == true)
                includeInactive = 1;
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdString");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("includeInactive", includeInactive);
                //int isArabic = 0;

                ////if (languageStr == "ar")
                ////    isArabic = 1;
                ////else
                ////    isArabic = 0;

                ////ht.Add("isArabic", isArabic);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                sb.Append((dv[0][0] + "").Trim().Trim(','));

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

        protected void SetParameterFields(ReportDocument rpt, string ParamValues)
        {
            try
            {
                string[] ColumnValues = ParamValues.Split(',');
                string FilterValues = Session["FilVal"].ToString();

                string[] FilterVal = FilterValues.Split('#');
                string Val = "";
                string FilterForReport = "";

                int k = 1;
                for (int i = 0; i < FilterVal.Length; i = i + 3)
                {
                    try
                    {
                        if (FilterVal[i] + "" != "")
                        {
                            FilterForReport = FilterVal[i].ToString() + ":";
                            //  FilterForReport += FilterVal[i + 1].ToString();
                            if (FilterVal[i + 2].ToString() == "")
                            {
                                FilterForReport += "   All";
                            }
                            else
                            {
                                if ((FilterVal[i + 2] + "").Trim().Length == 10 && (FilterVal[i + 2] + "").IndexOf('-') == 4 && (FilterVal[i + 2] + "").IndexOf('-', 5) == 7)
                                {
                                    if (languageStr == "en")
                                        FilterForReport += "  " + Numerics.GetDateTime(FilterVal[i + 2] + "").ToString("dd-MM-yyyy");
                                    else
                                    {
                                        if (FilterForReport.Contains("From Date:"))
                                            FilterForReport = " " + Numerics.GetDateTime(FilterVal[i + 2] + "").ToString("yyyy-MM-dd") + "  :من";
                                        else if (FilterForReport.Contains("To Date:"))
                                            FilterForReport = " " + Numerics.GetDateTime(FilterVal[i + 2] + "").ToString("yyyy-MM-dd") + "  :الى";
                                        else
                                            FilterForReport += " " + Numerics.GetDateTime(FilterVal[i + 2] + "").ToString("yyyy-MM-dd");
                                    }
                                }
                                else
                                    FilterForReport += "  " + FilterVal[i + 2].ToString();

                            }
                            if (!FilterForReport.Contains("null"))
                            {

                                TextObject objTxt = (TextObject)rpt.ReportDefinition.Sections["Section2"].ReportObjects["txtParam" + k];
                                objTxt.Text = FilterForReport.Trim();
                                k++;
                            }
                            FilterForReport = "";

                        }
                    }
                    catch (System.Exception ex)
                    {

                    }

                }

                for (int i = 0; i < rpt.ParameterFields.Count; i++)
                {
                    string abc = rpt.ParameterFields[i].Name;
                    Val = "";
                   
                    if (i < ColumnValues.Length)
                    {
                        rpt.SetParameterValue(i, ColumnValues[i].ToString());
                    }
                    else if (!abc.Contains("FilterParam"))
                    {
                        rpt.SetParameterValue(i, "");
                    }
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("ViewRptPage.aspx.ReportGen()", 0, ex);
            }

        }

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

        protected void btnRptPrint_Click(object sender, EventArgs e)
        {

            //rpt.ExportToDisk(ExportFormatType.PortableDocFormat, Server.MapPath("../Files/Rpt-"+DateTime.Now.Date.ToString("yyyy-MM-dd") +".pdf"));

            //return;

            ////String pkInstalledPrinters;
            ////for (int i = 0; i < PrinterSettings.InstalledPrinters.Count; i++)
            ////{
            ////    pkInstalledPrinters = PrinterSettings.InstalledPrinters[i];
            ////  //  comboInstalledPrinters.Items.Add(pkInstalledPrinters);
            ////}
            //PrintDialog printDilog = new PrintDialog();
            //printDilog.AllowCurrentPage = true;
            //printDilog.AllowPrintToFile = true;

            //printDilog.AllowSelection = true;
            //printDilog.AllowSomePages = true;


            //if (printDilog.ShowDialog() == DialogResult.OK)
            //{
            //    //printDilog;

            //    int copies = printDilog.PrinterSettings.Copies;
            //    int fromPage = printDilog.PrinterSettings.FromPage;
            //    int toPage = printDilog.PrinterSettings.ToPage;
            //    bool collate = printDilog.PrinterSettings.Collate;


            //    rpt.PrintOptions.PrinterName = printDilog.PrinterSettings.PrinterName;
            //    rpt.PrintToPrinter(copies, collate, fromPage, toPage);
            // }
        }

        private static void OnTimedEvent(Object source, ElapsedEventArgs e)
        {
            BringtoFront();
        }

        private static void BringtoFront()
        {
            // Thread.Sleep(2000);
            SendKeys.SendWait(Keys.Alt.ToString());
            SendKeys.SendWait(Keys.Tab.ToString());
        }

    }
}