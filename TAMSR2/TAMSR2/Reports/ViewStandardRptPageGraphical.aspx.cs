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
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Reports
{
    public partial class ViewStandardRptPageGraphical : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        public string ReportJSON = string.Empty;
        public string ReportMetaData = string.Empty;
        string ReportTitle = "";
        string appLogoFileName = ConfigurationManager.AppSettings["ApplicationLogoFileName"];

        string ReportID = "";
        string ReportName = "";
        string ReportColumns = "";
        ReportDocument rpt = new ReportDocument();
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewstandardrptpagegraphical.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("reports/viewstandardrptpagegraphical.aspx"));
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


            ShowReportGraphical();
        }

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
                string ManagerID = (Request["Manager"] + "").Trim();

                string fromDate = (Request["FromDate"] + "").Trim();
                string toDate = (Request["ToDate"] + "").Trim();

                string includeInactive = (Request["includeInactive"] + "").Trim();
                string groupID = (Request["groupID"] + "").Trim();
                string EmpTypeID = (Request["EmpTypeID"] + "").Trim();
                int isArabic = 0;

                if (cookie.Values["language"] + "" == "ar")
                    isArabic = 1;
                else
                    isArabic = 0;

                Hashtable ht = new Hashtable();
                ht.Add("SessionID", Session["ID"].ToString());
                ht.Add("isArabic", isArabic);
                ht.Add("templateName", ReportName);
                ht.Add("RegionCode", RegionCode);
                ht.Add("OrganizationID", OrganizationID);
                ht.Add("ManagerId", ManagerID);
                ht.Add("EmployeeId", EmployeeID);
                ht.Add("FromDate", fromDate);
                ht.Add("ToDate", toDate);
                ht.Add("includeInactive", includeInactive);
                ht.Add("groupID", groupID);
                ht.Add("EmpTypeID", EmpTypeID);

                objDal.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                if (ReportTitle.Trim() == "Attendance Summary Report" || ReportTitle.Trim() == "ملخص الحضور و الانصراف"
                            || ReportTitle.Trim() == "مخلص الدوام")
                {
                    objDataView = objDal.Connection.ExecuteProcedure("usp_rpt_dmr_summary_graphical", ht);

                  

                 
                    string empID = Encryption.Decrypt((Request["id"] + "").Trim());
                    Hashtable ht2 = new Hashtable();
                    ht2.Add("action", "getByID");
                    ht2.Add("sessionID", Session["ID"] + "");
                    ht2.Add("ID", Numerics.GetDecimal(EmployeeID));
                    DataView dv1 = objDal.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht2);

                    ReportMetaData = new JavaScriptSerializer().Serialize(new { ReportName = ReportName, FromDate = fromDate, ToDate = toDate, includeInactive = includeInactive, EmployeeName = (dv1.Count > 0 && !string.IsNullOrEmpty(dv1[0]["name_eng"].ToString())) ? dv1[0]["name_eng"] + "" : "" });
                  
                    foreach (DataRowView dv in objDataView)
                    {
                        object obj = new
                        {
                            OrganizationName = dv["OrganizationName"],
                            NoOfAbsentDays = string.IsNullOrEmpty(dv["NoOfAbsentDays"].ToString()) ? 0 : Convert.ToInt32(dv["NoOfAbsentDays"]),
                            NoOfHoliday = string.IsNullOrEmpty(dv["NoofHoliday"].ToString()) ? 0 : Convert.ToInt32(dv["NoofHoliday"]),
                            NoOfLate = string.IsNullOrEmpty(dv["NoOfLate"].ToString()) ? 0 : Convert.ToInt32(dv["NoOfLate"]),
                            NoOfEarlyOut = string.IsNullOrEmpty(dv["NoOfEarlyOut"].ToString()) ? 0 : Convert.ToInt32(dv["NoOfEarlyOut"]),
                            TotalDaysOfLeave = string.IsNullOrEmpty(dv["TotalDaysOfLeave"].ToString()) ? 0 : Convert.ToInt32(dv["TotalDaysOfLeave"])
                           
                        };

                        lst.Add(obj);
                    }

                }
            }
            catch (Exception ex)
            {
 

            }
            finally
            {
                objDal.CloseConnection();
            }
            ReportJSON = new JavaScriptSerializer().Serialize(lst);
            return "";

        }

        #endregion
    }
}