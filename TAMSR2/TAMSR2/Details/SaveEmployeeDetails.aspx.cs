using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Details
{
    public partial class SaveEmployeeDetails : BasePage
    {
        public static string addRecord = "false";
        public static string enableForm = "false";
        public string empID = "0";

        public string orgList = "";
        public string regionList = "";
        public string designationList = "";
        public string empList = "";
        public string countryList = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("saveemployeedetails.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/saveemployeedetails.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("emp/save-employee-details"));

            if (Page.RouteData.Values["emp"] != null)
            {
                empID = (Page.RouteData.Values["emp"] + "").Trim();
            }
            else
            {
                empID = (Request["emp"] + "").Trim();
            }
            if (empID.Trim() == "")
                empID = "0";

            divHiddenValues.InnerHtml = "<span id='spnEmp' style='display: none;'>" + empID + "</span> &nbsp;";


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

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_EMPLOYEE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
            {
                addRecord = "true";
            }
            else
            {
                addRecord = "false";
            }
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_EMPLOYEE) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
            {
                spnSaveButton.Visible = true;
                enableForm = "true";
            }
            else
            {
                spnSaveButton.Visible = false;
                enableForm = "false";
            }

            orgList = GetIdNameListStringOrg();
            regionList = GetIdNameListStringRegions();
            designationList = GetIdNameListStringDesignations();
            empList = GetIdNameListStringEmp();
            countryList = GetIdNameListStringCountry();

            orgList = orgList.Replace('"', '\'');
            regionList = regionList.Replace('"', '\'');
            designationList = designationList.Replace('"', '\'');
            empList = empList.Replace('"', '\'');
            countryList = countryList.Replace('"', '\'');
        }



        #region GetIdNameListStringDesignations
        /// <summary>
        /// GetIdNameListStringDesignations function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringDesignations()
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_DesignationOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string designationStr = (String)GetGlobalResourceObject("Resource", "designation");

                sb.Append("<option value=''>" + chooseStr + " " + designationStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    EmployeeType obj = new EmployeeType();
                    obj.ID = Numerics.GetDecimal(row["designation_id"] + "");
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
        //*********End Of GetIdNameListStringDesignations Function*********//
        #endregion



        #region GetIdNameListStringRegions
        /// <summary>
        /// GetIdNameListStringRegions function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringRegions()
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_RegionOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string regionStr = (String)GetGlobalResourceObject("Resource", "region");

                sb.Append("<option value=''>" + chooseStr + " " + regionStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Country obj = new Country();
                    obj.ID = Numerics.GetDecimal(row["region_id"] + "");
                    obj.Code = row["region_code"] + "";
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



        #region GetIdNameListStringOrg
        /// <summary>
        /// GetIdNameListStringOrg function
        /// Get organization drop down list from ORGANIZATION table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringOrg()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string orgStr = (String)GetGlobalResourceObject("Resource", "organization");

                sb.Append("<option value=''>" + chooseStr + " " + orgStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    TAMSR2Licence obj = new TAMSR2Licence();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
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
        //*********End Of GetIdNameListStringOrg Function*********//
        #endregion



        #region GetIdNameListStringEmp
        /// <summary>
        /// GetIdNameListStringEmp function
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringEmp()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_EmpMasterOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string employeeStr = (String)GetGlobalResourceObject("Resource", "employee");

                sb.Append("<option value=''>" + chooseStr + " " + employeeStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Employee obj = new Employee();
                    obj.ID = Numerics.GetDecimal(row["employee_id"] + "");
                    obj.Code = row["employee_code"] + "";
                    obj.NameEn = row["name_eng"] + "";
                    obj.NameAr = row["name_arb"] + "";
                    if (languageStr == "ar")
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameAr + " </option>");
                    else
                        sb.Append("<option value='" + obj.ID + "'>" + obj.Code + " - " + obj.NameEn + "  </option>");
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
        //*********End Of GetIdNameListStringEmp Function*********//
        #endregion



        #region GetIdNameListStringCountry
        /// <summary>
        /// GetIdNameListStringCountry function
        /// 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListStringCountry()
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CountryOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string countryStr = (String)GetGlobalResourceObject("Resource", "country");

                sb.Append("<option value=''>" + chooseStr + " " + countryStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Country obj = new Country();
                    obj.ID = Numerics.GetDecimal(row["country_id"] + "");
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
        //*********End Of GetIdNameListStringCountry Function*********//
        #endregion






    }
}