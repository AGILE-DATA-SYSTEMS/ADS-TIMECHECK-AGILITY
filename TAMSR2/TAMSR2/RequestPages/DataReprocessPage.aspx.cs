using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using System.Collections;

namespace TAMSR2.RequestPages
{
    public partial class DataReprocessPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/DataReprocessPage.aspx"));


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
            else if (Request["key"] + "" == "ReprocessData")
            {
                data = ReprocessData();
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write(data);
                Response.End();
            }
        }

        protected string ReprocessData()
        {
            try
            {
                Hashtable ht = new Hashtable();
                TAMSR2Data objDAL = new TAMSR2Data();

                ht.Add("CompanyID", DBNull.Value);

                if (Request["OrganizationID"] + "" == "")
                    ht.Add("OrganizationID", DBNull.Value);
                else
                    ht.Add("OrganizationID", (Request["OrganizationID"] + "").Trim());

                if (Request["EmployeeID"] + "" == "")
                    ht.Add("EmployeeID", DBNull.Value);
                else
                    ht.Add("EmployeeID", Convert.ToInt32((Request["EmployeeID"] + "").Trim()));

                ht.Add("FromDate", Convert.ToDateTime((Request["FromDate"] + "").Trim()).ToString("yyyy-MM-dd"));
                ht.Add("ToDate", Convert.ToDateTime((Request["ToDate"] + "").Trim()).ToString("yyyy-MM-dd"));
                ht.Add("UserID", Convert.ToInt32(Session["userID"].ToString()));
                ht.Add("UpdateAll", Convert.ToInt32((Request["DeleteVerifications"] + "").Trim()));

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                string result = objDAL.Connection.GetValueProcedure("reprocess_attendance_data", ht);
                if (Convert.ToInt32(result) > 0)
                    return "1";
                else
                    return "0";
            }
            catch (Exception ex)
            {
                return "0";
            }
        }
    }
}