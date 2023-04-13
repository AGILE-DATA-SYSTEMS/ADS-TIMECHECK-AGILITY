using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public static string url = "";
        public static string languageStr = "en";
        public static string pullDirectionStr = "right";

        /// <summary>
        /// Set page culture values according to user selection
        /// </summary>
        #region
        public void SetCultureValues()
        {
            HttpCookie cookie = Request.Cookies["tamsCulture"];
            try
            {
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
                pullDirectionStr = cookie.Values["pullDirection"] + "";
                languageStr = cookie.Values["language"] + "";
                Page.UICulture = cookie.Values["culture"] + "";
                Page.Culture = cookie.Values["culture"] + "";
            }
            catch (Exception ex)
            {
                pullDirectionStr = AppSetting.defaultPullDirection + "";
                languageStr = AppSetting.defaultLanguage + "";
                Page.UICulture = AppSetting.defaultCulture + "";
                Page.Culture = AppSetting.defaultCulture + "";
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ID"] + "" == "" && Session["VALID_LICENSE"] + "" != "" && Convert.ToBoolean(Session["VALID_LICENSE"] + "") == true)
                Response.Redirect("~/Login.aspx");
            else if (Session["VALID_LICENSE"] + "" != "" && Convert.ToBoolean(Session["VALID_LICENSE"] + "") == false)
                Response.Redirect("~/ApplyLicense.aspx");
            SetCultureValues();
            if (Numerics.GetBool(Session["chkPrivileges"] + "") == false)
            {
                TAMSR2Data objDAL = new TAMSR2Data();
                List<IdName> list = new List<IdName>();
                try
                {
                    objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                    Hashtable ht;
                    ht = new Hashtable();
                    ht.Add("action", "getUserPrivileges");
                    ht.Add("sessionID", Session["ID"] + "");
                    ht.Add("ID", Session["ID"] + "");

                    DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_SecUserOps", ht);

                    foreach (DataRowView obj in objDataView)
                    {
                        list.Add(new IdName() { Name = obj["privilege_name"] + "", value = obj["scope"] + "" });
                    }
                }
                catch (Exception ex)
                {
                }
                finally
                {
                    objDAL.Connection.Close();
                }
                Session["chkPrivileges"] = true;
                Session["userPrivilegeList"] = list;
            }
        }
    }
}