using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
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
    public partial class SynchronizationPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/SynchronizationPage.aspx"));


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
            else if (Request["key"] + "" == "syncData")
            {
                data = SyncData();
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


        #region SyncData
        /// <summary>
        /// SyncData function
        /// 
        /// </summary>
        /// <returns> </returns>
        public string SyncData()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            DbActionMsg obj = new DbActionMsg();
            try
            {
                string syncProcessName = Request["syncProcessName"] + "";
                
                Hashtable ht = new Hashtable();
                ht.Add("action", "SyncProcess");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("syncProcessName", syncProcessName);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("Syn_Data_From_TAMS_Application", ht);

                if (dv != null)
                {
                    obj.ActionType = (dv[0]["ActionType"] + "").Trim();
                    obj.ActionResult = (dv[0]["ActionResult"] + "").Trim();
                    obj.ActionMessage = (dv[0]["ActionMessage"] + "").Trim();
                    obj.ActionWarning = (dv[0]["ActionWarning"] + "").Trim();
                    obj.ActionResult = Numerics.GetDecimal(obj.ActionResult) > 0 ? "1" : obj.ActionResult;
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/SynchronizationPage.aspx.SyncData()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(obj);
        }
        //*********End Of GetAll Function*********//
        #endregion


    }
}