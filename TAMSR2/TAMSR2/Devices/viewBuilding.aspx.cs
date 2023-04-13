using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;


namespace TAMSR2.Devices
{
    public partial class ViewBuilding : BasePage
    {

        public string zonesList = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewBuildings.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("devices/viewBuilding.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("devices/view-building"));

            #region User Authentication and Preferences
            /// <summary>
            /// Checks Session variable for login, if windows login is not activate 
            /// otherwise Authenticate user by windows login if Windows Login is activated in Web.config
            /// And also Set Page Culture Variables for user preffered language.
            /// </summary>
            if (UserAuthentication() == false || new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_READERS) == false)
            {
                Response.Redirect(path + "Login");
            }
            SetCultureValues();
            #endregion

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DELETE_READERS) == false)
            {
                spnDeleteButton.Visible = false;
            }
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INSERT_READERS) == false)
            {
                spnAddButton.Visible = false;
            }

            zonesList = GetIdNameListStringZones();
            zonesList = zonesList.Replace('"', '\'');

        }
        #region GetIdNameListStringRegions
        /// <summary>
        /// GetIdNameListStringRegions function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringZones()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            string days = (String)GetGlobalResourceObject("Resource", "days");

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_ZonesOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string zoneStr = (String)GetGlobalResourceObject("Resource", "zones");

                sb.Append("<option value=''>" + chooseStr + " " + zoneStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Country obj = new Country();
                    obj.ID = Numerics.GetDecimal(row["zone_id"] + "");
                    obj.Code = row["code"] + "";
                    obj.DescriptionEn = row["description_eng"] + "";
                    obj.DescriptionAr = row["description_arb"] + "";
                    if (languageStr == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.DescriptionAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.DescriptionEn + "  </option>");
                }

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
        //*********End Of GetIdNameListStringRegions Function*********//
        #endregion

    }
}