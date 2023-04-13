using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.RequestPages
{
    public partial class DashboardGeoTrackingPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        string IsArabic = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/DashboardGeoTrackingPage.aspx"));


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
            {
                languagePostfix = "_arb";
                IsArabic = "1";
            }
            else
                languagePostfix = "_eng";

            string data = "";

            if (Session["ID"] + "" == "")
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "GetReaderTransactionsCount")
            { 
                data = GetReaderTransactionsCount();
            }
            else
            {
                data = "";
            }
            
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Write(data);
            Response.Flush();
            //Response.End();

        }


        #region LoadReaderTransactions
        /// <summary>
        /// LoadReaderTransactions function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetReaderTransactionsCount()
        {
            IList<Reader> ReaderList = new List<Reader>();
            DBAppSetting AppStng = new DBAppSetting();
            string DefaultLocation = "";
            string location = "";
            string dt = (Request["dt"] + "").Trim();
            if (dt == "")
                dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd");
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DefaultLocation = AppStng.GetDefaultLocation(Session["ID"] + "", Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "GetReaderTransactionsCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("date", dt);
                ht.Add("ID", Numerics.GetDecimal(Session["ID"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_MYDailytimeAttendence", ht);

                if (dv != null)
                {
                    foreach (DataRowView row in dv)
                    {
                        Reader obj = new Reader();
                        obj.NameEn = (row["reader_Name"] + "").Trim();
                        if ((row["reader_location"] + "").Trim() != "")
                        {
                            location = (row["reader_location"] + "").Trim();
                        }
                        else
                        {
                            location = DefaultLocation;
                        }
                        string[] str = location.Split(',');
                        obj.Latitude = decimal.Round(Numerics.GetDecimal(str[0].Trim()), 5);
                        obj.Longitude = decimal.Round(Numerics.GetDecimal(str[1].Trim()), 5);
                        ReaderList.Add(obj);
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
            return new JavaScriptSerializer().Serialize(ReaderList);
        }
        //*********End Of GetAll Function*********//
        #endregion

         
    }
}