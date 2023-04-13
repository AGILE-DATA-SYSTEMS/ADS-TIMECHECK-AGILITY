using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using System.Text;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;
using TAMSR2.ObjectClasses;
using System.Web.Script.Serialization;

namespace TAMSR2.RequestPages
{
    public partial class ReportRequest : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        protected void Page_Load(object sender, EventArgs e)
        {
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

            if (Request["key"] + "" == "LoadColumns")
            {
                string action = Request["action"] + "";
                string str = LoadColumns(action);
                
                Response.Write(str);
                Response.Flush();
            }
            if (Request["key"] + "" == "save")
            {
                string str = Save();
                Response.Write(str);
                Response.Flush();
            }

            if (Request["action"] + "" == "getAllTemplate")
            {
                string str  = LoadTemplates();
                Response.Write(str);
                Response.Flush();
            }
            if (Request["action"] + "" == "FilterValues")
            {
                string str = LoadFilters();
                Response.Write(str);
                Response.Flush();
            }
            if (Request["key"] + "" == "LoadGroups")
            {
                string str = LoadGroups();
                Response.Write(str);
                Response.Flush();

            }
            if(Request["key"] + "" == "GenrateReport")
            {
                GenrateReport();
                Response.Write("1");
                Response.Flush();

            }
            if (Request["key"] + "" == "ShowRosterReport")
            {
                string str = ShowRosterReport();
                Response.Write(str);
                Response.Flush();
            }
            if (Request["key"] + "" == "ShowRosterView")
            {
                string str = ShowRosterView();
                Response.Write(str);
                Response.Flush();
            }
            if (Request["key"] + "" == "StandardReport")
            {
                string str = LoadStandardReport();
                Response.Write(str);
                Response.Flush();
            }
            if (Request["key"] + "" == "ShowStandardReport")
            {
                string str = ShowStandardReports();
                Response.Write(str);
                Response.Flush();
            }
            if (Request["key"] + "" == "ShowBIDefault")
            {
                string data = GetBISummaryReport();

                Response.Clear();
                Response.ClearHeaders();
                Response.ClearContent();
                Response.Write(data);
                Response.Flush();
            }
            if (Request["key"] + "" == "ShowBIDetails")
            {
                string data = GetBIDetailReport();

                Response.Clear();
                Response.ClearHeaders();
                Response.ClearContent();
                Response.Write(data);
                Response.Flush();
            }
            if (Request["key"] + "" == "TransactionRpt")
            {
                string data = TransactionReport();

                Response.Clear();
                Response.ClearHeaders();
                Response.ClearContent();
                Response.Write(data);
                Response.Flush();
            }
            

        }

        #region LoadColumns
		 
        protected string LoadColumns( string action)
        {
            try
            {
                string TableName = Request["TableName"].ToString();
                string query = @"SELECT COLUMN_NAME 
                                FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + TableName + "'";
                StringBuilder temp = new StringBuilder();
              //  temp.Append("<div class='control-group'>");
                TAMSR2Data objData = new TAMSR2Data();
                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DataView DView = objData.Connection.ExecuteQuery(query);

                DataTable dt = new DataTable();
                dt = DView.Table;

                   int i = 0;
                   int j = 1;
                   temp.Append("<div class='control-group'>");
                   
                   if (action == "Columns")
                   {
                       temp.Append("<label class='control-label'>Select The Columns</label>");
                       temp.Append("<div class='controls'>");
                       temp.Append("<select data-placeholder='Select Columns'  class='chosen span6'   tabindex='-1' id='select2_sample3'>");

                   }
                   else if (action == "GroupBy")
                   {
                       temp.Append("<label class='control-label'>Select The Columns To Group By</label>");
                       temp.Append("<div class='controls'>");
                       temp.Append("<select data-placeholder='Select Columns'  class='chosen span6' tabindex='-1' id='selGroupBy'>");
                   }
                   else if (action == "Filters")
                   {
                       temp.Append("<label class='control-label'>Select The Columns To Apply Filters</label>");
                       temp.Append("<div class='controls'>");
                       temp.Append("<select data-placeholder='Select Columns'   class='chosen span6' tabindex='-1' id='selFilters'>");
                   }
                   else if (action == "SortBy")
                   {
                       temp.Append("<label class='control-label'>Select The Columns To Sort</label>");
                       temp.Append("<div class='controls'>");
                       temp.Append("<select data-placeholder='Select Columns'  class='chosen span6' tabindex='-1'  id='selSortBy'>");
                   }
                   
                                    
                       while (i< dt.Rows.Count)
                       {
                           
                             temp.Append("<option value = ' " + dt.Rows[i].ItemArray[0] + "'> " + dt.Rows[i].ItemArray[0] + " </option>");
                           
                           i++;
                       }
                 
                      // temp.Append("</optgroup>");

                       temp.Append("</select>");
                       
                       temp.Append("</div>");
                       temp.Append("</div>");
               
                return temp.ToString();
            }
            catch (Exception ex)
            {
                return "";
               
            }
        }

        #endregion

        #region loadFilters

        protected string LoadFilters()
        {
            TAMSR2Data objData = new TAMSR2Data();
            int includeInactive = 0; 
            if ((Request["includeInactive"] + "").Trim().ToLower() == "true"
                && new TAMSPrivilege().IsPrivileged(TAMSPrivilege.INCLUDE_INACTIVE_STAFF_IN_REPORTS) == true)
                includeInactive = 1;

            try
            {
                Session["RTID"] = Request["ID"].ToString();
                StringBuilder temp = new StringBuilder();
                Hashtable ht = new Hashtable();
                ht.Add("action", "GetByID");
                ht.Add("filters", "Filter");
                ht.Add("tempID", Request["ID"].ToString());
                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                DataView objDataView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                string fData = objDataView[0].Row.ItemArray[0].ToString();
                string oData = objDataView[0].Row.ItemArray[1].ToString();
                string arabicName = objDataView[0].Row.ItemArray[2].ToString();
                string OrignalName = objDataView[0].Row.ItemArray[3].ToString();
                string[] sData = fData.Split(',');
                string[] Operator = oData.Split(',');
                string[] OrgnlName = OrignalName.Split(',');
                string[] NameAr = arabicName.Split(',');
                List<string> FilterColumns = new List<string>();

                DataTable dt = new DataTable();
                dt = objDataView.Table;
                //if (sData[0] != "")
                  temp.Append("<div class='control-group'>");
                    temp.Append("<div class='controls' style='margin-left:0px !important;style='margin-right:0px !important;'>");
                    temp.Append("<table>");
                    temp.Append("<thead>");
                    temp.Append("<th style='width:150px;'><label style='text-align:left;font-weight:bold;'>Filter Name</label></th>");
                    temp.Append("<th style='width:150px; display:none;'><label style='text-align:center;font-weight:bold;; display:none;'>Filter Operator</label></th>");
                    temp.Append("<th style='width:150px;'><label style='font-weight:bold;'>Filter Value</label></th>");
                    if (dt.Rows.Count > 1)
                    {
                        temp.Append("<th style='width:150px;'><label style='font-weight:bold;display:none;'>Logical Operator</label></th>");
                    }
                    //if (sData.Length > 1)
                    //{
                    //    temp.Append("<th style='width:150px;'><label style='text-align:left; font-weight:bold;'>Logical Operator</label></th>");
                    //    temp.Append("<th style='width:150px;'><label style='text-align:left; font-weight:bold;'>Filter Name</label></th>");
                    //    temp.Append("<th style='width:150px;'><label style='text-align:left;font-weight:bold;'>Filter Operator</label></th>");
                    //    temp.Append("<th style='width:150px;'><label style='font-weight:bold;'>Filter Value</label></th>");
                    //}
                    temp.Append("</thead>");
                    temp.Append("<tbody>");
                    int i = 1; int k = 1;
                if(dt.Rows.Count > 0)
                {
                foreach (DataRow row in dt.Rows)
                {
                        temp.Append("<tr>");

                        if (row["Isvisible"].ToString() == "False")
                        {

                            temp.Append("<td style='text-align:left; width:150px;display:none;'><label id='lbl" + i + "' style='display:none;' >" + row["ColumnNameEn"] + "" + "</label></td>");
                            temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                            temp.Append("<td  style='display:none;width:150px;'><label style='text-align:center; display:none;' id='lblOp" + i + "'>" + row["ColumnOperator"] + "   </label></td>");
                            temp.Append("<td style='text-align:center; width:150px;display:none;'> <input type='Text' style='margin-left:0px; width:170px;display:none;'   disabled=' disabled' value='" + row["DefaultValues"].ToString() + "' class='span6 m-wrap' id='txt" + i + "' /></td>");
                             
                        }
                        else
                        {
                            if (languagePostfix == "_arb")
                                temp.Append("<td style='text-align:left; width:150px;'><label id='lbl" + i + "' >" + row["ColumnNameAr"] + "" + "</label></td>");
                            else
                                temp.Append("<td style='text-align:left; width:150px;'><label id='lbl" + i + "' >" + row["ColumnNameEn"] + "" + "</label></td>");
                           // temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                            temp.Append("<td  style='display:none;width:150px;'><label style='text-align:center; display:none;' id='lblOp" + i + "'>" + row["ColumnOperator"] + "   </label></td>");
                            temp.Append("<td style='text-align:center; width:200px;'>");
                            if (row["ColumnOriginalName"].ToString().ToLower().Contains("employee_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadEmployeeBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                ht.Add("includeInactive", includeInactive);
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<select data-placeholder='Logical Operator' name='ddemp'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                
                                temp.Append("</select>");
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("organization_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadOrganizationBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator' name='ddorg'   class='chosen span6' style='width:430px;'  id='txt" + i + "' onchange='LoadEmployees();'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("manager_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadManagerBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator' name='ddMgr'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("group_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadGroupBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("desig_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadDesigBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("emp_type_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadEmployeeTypeBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("country_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadCountryBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("region_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadRegionBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator' name='ddrgn'  class='chosen span6' style='width:430px;'  id='txt" + i + "' onchange='LoadDepartment();'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("grade_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadGradeBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("schtype_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadSchTypeBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("reader_name") || row["ColumnOriginalName"].ToString().ToLower().Contains("reader_id"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadReadersBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["reader_id"] + "'> " + r["reader_name"] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("employee_group_code"))
                            {
                                ht.Clear();
                                ht.Add("action", "LoadGroupBox");
                                ht.Add("SessionID", Session["ID"] + "");
                                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                                DataView objDView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<select data-placeholder='Logical Operator'  class='chosen span6' style='width:430px;'  id='txt" + i + "'>");
                                temp.Append("<option value = '0' selected='selected'> " + Resources.Resource.all + " </option>");
                                foreach (DataRow r in objDView.Table.Rows)
                                {
                                    temp.Append("<option value = '" + r["Code"] + "'> " + r["CodeName" + languagePostfix] + " </option>");
                                }
                                temp.Append("</select>");
                            }
                            else if (row["ColumnOriginalName"].ToString().ToLower().Contains("date"))
                            {
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<input id='txtDate" + k + "' name='txtJoinDate' style='width:418px;' class='m-wrap m-ctrl-medium date-picker' size='16' type='text' value='" + row["DefaultValues"].ToString() + "' />");
                                k++;
                            }
                            else
                            {
                                temp.Append("<input type='hidden' value='" + row["ColumnOriginalName"] + "'  id='hid" + i + "' />");
                                temp.Append("<input type='Text' style='margin-left:0px; width:418px;' value='" + row["DefaultValues"].ToString() + "' class='m-wrap m-ctrl-medium' id='txt" + i + "' />");
                            }
                            temp.Append("</td>");
                           
                          //  temp.Append("<td style='text-align:center; width:150px;'> <input type='Text' style='margin-left:0px; width:170px;' class='span6 m-wrap' id='txt" + i + "' /></td>");
                        }
                        if (dt.Rows.Count >= 1 && i != dt.Rows.Count)
                        {

                            if (row["Isvisible"].ToString() != "False")
                            {
                                temp.Append("");

                                temp.Append("<td ><select data-placeholder='Logical Operator'  class='chosen span6' style='width:150px;display:none;'  id='sel" + i + "'>");
                                temp.Append("<option value = 'AND' selected='selected'> AND </option>");
                                temp.Append("<option value = 'OR'> OR</option>");
                                temp.Append("<option value = 'NOT'> NOT </option>");
                                temp.Append("<option value = 'AND NOT'>AND NOT </option>");
                                temp.Append("<option value = 'OR NOT'>OR NOT </option>");
                                temp.Append("</select>");
                                temp.Append("</td>");

                            }
                            else
                            {
                                temp.Append("");

                                temp.Append("<td ><select data-placeholder='Logical Operator'  class='chosen span6' style='width:150px;display:none;'  id='sel" + i + "'>");
                                temp.Append("<option value = 'AND'> AND </option>");
                                temp.Append("<option value = 'OR'> OR</option>");
                                temp.Append("<option value = 'NOT'> NOT </option>");
                                temp.Append("<option value = 'AND NOT'>AND NOT </option>");
                                temp.Append("<option value = 'OR NOT'>OR NOT </option>");
                                temp.Append("</select>");
                            }
                                                        

                        }

                        temp.Append("</tr>");
                        i++;
                    }
                    //temp.Append("</tr>");
                   
                }
                else
                {
                    temp.Append("<label>No Filter Is Found</label>");
                }
                    temp.Append("</tbody");
                    temp.Append("</table>");
                    temp.Append("</div>");
                    temp.Append("</div>");
                return temp.ToString();
            }
            catch (Exception ex)
            {
                return "";

            }
            finally
            {
                objData.CloseConnection();
            }
        }

        #endregion

        #region LoadGroups

        protected string LoadGroups()
        {
            TAMSR2Data objData = new TAMSR2Data();
            try
            {
                string TemplateID = Request["ID"].ToString();
                Hashtable ht = new Hashtable();
                ht.Add("action", "LoadGroups");
                ht.Add("ID", TemplateID);
                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                DataView objDataView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);

                StringBuilder temp = new StringBuilder();
                if (objDataView != null)
                {
                    temp.Append("<label class='control-label'>" + (String)GetGlobalResourceObject("Resource", "chooseempgroup") + "</label>");
                    temp.Append("<div class='controls'>");
                    temp.Append("<select data-placeholder='" + (String)GetGlobalResourceObject("Resource", "chooseempgroup") + "'  class='chosen span6' tabindex='-1' id='selEmployeeGroup'>");

                    foreach (DataRowView obj in objDataView)
                    {
                        temp.Append("<option value = ' " + (obj["GroupID"] + "" + "'> " + (obj["Name" + languagePostfix] + "" + " </option>")));
                    }
                    temp.Append("</select>");
                    temp.Append("</div>");
                    temp.Append("</div>");
                }
                return temp + "";
                
            }
            catch (Exception ex)
            {

                return "";
            
            }
        }

        #endregion

        #region Save

        public string Save()
        {
            string chk = "0";
            string Cols = "";
            string Filters = "";
            string SortBy = "";
            string GroupBy = "";
            string SortOrder = "";
            string Category = "";
            string Layout = "";
            string result = "";
            string ApplyGroup = "";

            Cols = (Request["SlectedCols"] + "").Trim();
            SortBy =(Request["SortCols"] + "").Trim();
            SortOrder = (Request["SortBy"] + "").Trim();
            Filters = (Request["Filters"] + "").Trim();
            GroupBy = (Request["GroupBy"] + "").Trim();
            Category = (Request["Category"] + "").Trim();
            Layout = (Request["Layout"] + "").Trim();
            ApplyGroup = (Request["ApplyGroup"] + "").Trim();

            string AllColumns =  SortBy + "," + GroupBy;

           string [] SelectedColumns = Cols.Split(',');
          //  string[] SelectedSortBy = SortBy.Split(',');
            string[] SelectedFilters = Filters.Split(',');
          //  string[] SelectedGroupBy = GroupBy.Split(',');
            TAMSR2Data objDAL = new TAMSR2Data();
            string[] AllCols = AllColumns.Split(',');
            try
            {
            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("@ID", "0");
            ht.Add("nameEn", (Request["nameEn"] + "").Trim());
            ht.Add("nameAr", (Request["nameAr"] + "").Trim());

            ht.Add("DescriptionEn", (Request["DescriptionEn"] + "").Trim());
            ht.Add("DescriptionAr", (Request["DescriptionAr"] + "").Trim());
            ht.Add("Category", (Request["Category"] + "").Trim());
            ht.Add("Layout", (Request["Layout"] + "").Trim());
            ht.Add("SortOrder", (Request["SortOrder"] + "").Trim());
            ht.Add("ApplyGroup", Convert.ToInt32(ApplyGroup));
            int ID = Convert.ToInt32(Session["ID"].ToString());
            
           
                if (Session["ID"] + "" != "")
                {
                    ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
                    ht.Add("createdBy", Session["ID"] + "");
                    ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:m:ss"));
                    ht.Add("updatedBy", Session["ID"] + "");
                }
                ht.Add("tableName", Request["TableName"].ToString().Trim());

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                result = objDAL.Connection.GetValueProcedure("TAMSR2_TemplatesOps", ht);
                
                if (Numerics.GetDecimal(result) > 0)
                {
                    if (AllCols != null || SelectedColumns != null || SelectedFilters != null)
                    {
                        
                        for (int i = 0; i < AllCols.Length; i =i+2)
                    {
                        if (AllCols[i] != "")
                        {
                            ht.Clear();
                            ht.Add("action", "saveDetail");
                            ht.Add("sessionID", Session["ID"] + "");
                            ht.Add("TempID", result);
                            ht.Add("columnNameEn", AllCols[i]);
                            ht.Add("columnNameAr", AllCols[i]);
                            ht.Add("columnOrignalName", AllCols[i]);
                            ht.Add("columnType", AllCols[i + 1]);
                            string res = objDAL.Connection.GetValueProcedure("TAMSR2_TemplatesOps", ht);
                        }
                    }
                        int IsVisible = 0;
                        for (int j = 0; j < SelectedFilters.Length; j = j + 7)
                        {
                            if (SelectedFilters[j].Trim() != "" && SelectedFilters.Length > 1)
                            {
                                ht.Clear();
                                ht.Add("action", "saveDetail");
                                ht.Add("TempID", result);
                                ht.Add("columnNameEn", SelectedFilters[j]);
                                ht.Add("columnNameAr", SelectedFilters[j+1]);
                                ht.Add("columnOrignalName", SelectedFilters[j+2]);
                                ht.Add("columnOp", SelectedFilters[j + 3]);
                                if (SelectedFilters[j + 4] == "Yes")
                                {
                                    IsVisible = 1;
                                }
                                else
                                {
                                    IsVisible = 0;
                                }
                                ht.Add("IsVisible", IsVisible);
                                ht.Add("DefaultValues", SelectedFilters[j + 5]);
                                ht.Add("columnType", SelectedFilters[j + 6]);

                                string res = objDAL.Connection.GetValueProcedure("TAMSR2_TemplatesOps", ht);
                            }
                        }

                        for (int j = 0; j < SelectedColumns.Length; j = j + 5)
                        {
                            if (SelectedColumns[j].Trim() != "" && SelectedColumns.Length > 1)
                            {
                                ht.Clear();
                                ht.Add("action", "saveDetail");
                                ht.Add("TempID", result);
                                ht.Add("columnNameEn", SelectedColumns[j]);
                                ht.Add("columnNameAr", SelectedColumns[j + 1]);
                                ht.Add("columnOrignalName", SelectedColumns[j + 2]);
                                ht.Add("columnType", SelectedColumns[j + 4]);
                                if (SelectedColumns[j + 3] == "Yes")
                                {
                                    IsVisible = 1;
                                }
                                else
                                {
                                    IsVisible = 0;
                                }
                                ht.Add("IsVisible", IsVisible);
                                string res = objDAL.Connection.GetValueProcedure("TAMSR2_TemplatesOps", ht);
                            }
                        }
                    }
                    chk = "1";
                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                if (result != "")
                {
                    DeleteByID(result);
                }
                new ExceptionLog().WriteLog("RequestPages/ReportRequest.aspx.Save()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

        #region GetTemplatesList

        public string LoadTemplates()
        {
                TAMSR2Data objTAMSDATA = new TAMSR2Data();
            try
            {
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getAllTemplate");
                ht.Add("SessionID", Session["ID"]);
                objTAMSDATA.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                DataView objDataView = objTAMSDATA.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                StringBuilder temp = new StringBuilder();
                //temp.Append("<label class='control-label'>" + (String)GetGlobalResourceObject("Resource", "selectReportTemplate") + "</label>");
                //temp.Append("<div class='controls'>");
                //temp.Append("<select data-placeholder='" + (String)GetGlobalResourceObject("Resource", "selectReportTemplate") + "'  class='chosen span6' tabindex='-1' id='selTemplate'>");
               
                if (objDataView != null && objDataView.Count > 0)
                {
                    foreach (DataRowView obj in objDataView)
                    {
                        if (languagePostfix == "_eng")
                            temp.Append("<option objType='" + obj["TableType"] + "' value = ' " + (obj["ID"] + "" + "'> " + (obj["NameEn"] + "" + " </option>")));
                        else
                            temp.Append("<option objType='" + obj["TableType"] + "' value = ' " + (obj["ID"] + "" + "'> " + (obj["NameAr"] + "" + " </option>")));
                    }
                }
                else 
                {
                    temp.Append("<option value = '0'> No Report Found </option>");

                }
                //temp.Append("</select>");
                //temp.Append("</div>");
                //temp.Append("</div>");
               
                return temp.ToString();
            }
            catch (Exception ex)
            {
                return  "";
            }
        }

        #endregion


        #region GenrateReport

        public void GenrateReport()
        {

            TAMSR2Data objData = new TAMSR2Data();
            try
            {
               
                    Hashtable ht = new Hashtable();

                    ht.Add("action", "GetAllColumns");
                    ht.Add("SortCols", "Sort By");
                    ht.Add("GroupCols", "Group By");
                    ht.Add("ReportCols", "Report Column");
                    ht.Add("tempID", Session["RTID"].ToString());
                    objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                    DataView objDataView  = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
               
                string Filt = Request["Filters"].ToString().TrimEnd(',');
                if (Filt == "1  =    '1'   ")
                    Filt = "";
                Filt = Filt.Replace("#", "%");
                Filt = Filt.Replace(" undefined  ", "");
                string FilVal = Request["FilVal"].ToString();
                if (FilVal == "1#  =     #1#")
                    FilVal = "";
                string GroupID = Request["GroupID"].ToString();
                //string[] Filter = Filt.Split(',');
                //string FilterBy = "1 = 1";
                //for (int i = 0; i < Filter.Length - 1; i++)
                //{
                //    FilterBy = FilterBy + " AND " + Filter[i];

                //}

                if (GroupID == "undefined")
                    GroupID = "";

                Session["DataView"] = objDataView;
                Session["Filters"] = Filt;
                Session["FilVal"] = FilVal;
                Session["GroupID"] = GroupID;
                Session["objType"] =  Request["objType"].ToString();
            
               // string query = @"SELECT NameEn,NameAr,Email From " + TableName + "  WHERE  " + FilterBy +

               //                " Order By " + sortBy;

               // DataView DView = objData.Connection.ExecuteQuery(query);
               // DataTable dt = new DataTable();
               // dt = DView.Table;

               //// DataSet ds = new DataSet();
               // Reports.ReportDataSet ds = new Reports.ReportDataSet();
               // ds.Tables.Add(dt.Copy());

               // Session["DataSet"] = ds;
                
            }
            catch (Exception ex)
            {   //return "-1";

            }
        }


        

        #endregion

        #region DeleteByID
         protected void DeleteByID(string TempID)
        {
             TAMSR2Data objData = new TAMSR2Data();
            try
            {
                Hashtable ht = new Hashtable();

                ht.Add("action", "DeleteByID");
                ht.Add("TempID", TempID);
                objData.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                DataView objDataView = objData.Connection.ExecuteProcedure("TAMSR2_TemplatesOps", ht);
                

            }
            catch (Exception ex)
            {
                
                
            }
        }
        #endregion

        #region ShowRosterReport
         
         protected string ShowRosterReport()
        {
            DataView objDataView = new DataView();
            TAMSR2Data objDal = new TAMSR2Data();

            try
            {
                string Orgnization = Request["Org"] + "";
                int year = Convert.ToInt32(Request["Year"] + "");
                int Month = Convert.ToInt32(Request["Month"] + "");
                string Emp = Request["EmpID"] + "";
                string Mgr = Request["MgrId"] + "";
                if (Orgnization == "")
                {

                    Orgnization = System.DBNull.Value + "";
                }
                if (Emp == "")
                {
                    Emp = System.DBNull.Value + "";

                }
                if (Mgr == "")
                {
                    Mgr = System.DBNull.Value + "";

                }

                //DateTime nod = new DateTime();
                int nod = DateTime.DaysInMonth(year, Month);
                DateTime FromDate = new DateTime(year, Month, 01);
                DateTime ToDate = new DateTime(year, Month, nod);

                Session["FromDate"] = FromDate.ToString("dd-MM-yyyy");
                Session["ToDate"] = ToDate.ToString("dd-MM-yyyy");
                Session["OrgName"] = Request["OrgName"].ToString();
                string empname = Request["EmpName"].ToString();
                if (empname == "Choose Employee")
                    empname = "---";
                Session["EmpName"] = empname;

                Hashtable ht = new Hashtable();


                ht.Add("CompanyID", System.DBNull.Value);
                ht.Add("OrganizationID", Orgnization);
                if (Emp == "")
                {
                    ht.Add("EmployeeId", System.DBNull.Value);
                }
                else
                {
                    ht.Add("EmployeeId", Emp);
                }
                ht.Add("ManagerId", Mgr);
                ht.Add("FromDate", FromDate.ToString("yyyy-MM-dd"));
                ht.Add("ToDate", ToDate.ToString("yyyy-MM-dd"));
                ht.Add("UserID", Session["ID"].ToString());

                objDal.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                objDataView = objDal.Connection.ExecuteProcedure("Rpt_Get_MonthlyRosterReport", ht);

                Session["RosterReport"] = objDataView;

                    return "";
            }
            catch (System.Exception ex)
            {
                return "error";
            }
        }
               
         protected string ShowRosterView()
        {
            DataView objDataView = new DataView();
            TAMSR2Data objDal = new TAMSR2Data();

            try
            {
                string Orgnization = Request["Org"] + "";
                int year = Convert.ToInt32(Request["Year"] + "");
                int Month = Convert.ToInt32(Request["Month"] + "");
                string Emp = Request["EmpID"] + "";
                string Mgr = Request["MgrId"] + "";
                string GroupId = Request["GroupId"] + "";
                if (Orgnization == "")
                {

                    Orgnization = System.DBNull.Value + "";
                }
                if (Emp == "")
                {
                    Emp = System.DBNull.Value + "";

                }

                if (Mgr == "")
                {
                    Mgr = System.DBNull.Value + "";

                }
                if (GroupId == "")
                {
                    GroupId = System.DBNull.Value + "";

                }
                //DateTime nod = new DateTime();
                int nod = DateTime.DaysInMonth(year, Month);
                DateTime FromDate = new DateTime(year, Month, 01);
                DateTime ToDate = new DateTime(year, Month, nod);

                Session["FromDate"] = FromDate.ToString("dd-MM-yyyy");
                Session["ToDate"] = ToDate.ToString("dd-MM-yyyy");
                Session["FromDateStr"] = FromDate.ToString("yyyy-MM-dd");
                Session["ToDateStr"] = ToDate.ToString("yyyy-MM-dd");
                Session["OrgName"] = Request["OrgName"].ToString();
                Session["RosterMgrID"] = Mgr + "";
                Session["RosterOrgID"] = Orgnization + "";
                Session["RosterGroupID"] = GroupId + "";
                Session["RosterEmpID"] = Emp + ""; 

                string empname = Request["EmpName"].ToString();
                if (empname == "Choose Employee")
                    empname = "---";
                Session["EmpName"] = empname;

                Hashtable ht = new Hashtable();


                ht.Add("CompanyID", System.DBNull.Value);
                ht.Add("OrganizationID", Orgnization);
                if (Emp == "")
                {
                    ht.Add("EmployeeId", System.DBNull.Value);
                }
                else
                {
                    ht.Add("EmployeeId", Emp);
                }
                ht.Add("ManagerId", Mgr);
                ht.Add("FromDate", FromDate.ToString("yyyy-MM-dd"));
                ht.Add("ToDate", ToDate.ToString("yyyy-MM-dd"));
                ht.Add("UserID", Session["ID"].ToString());

                objDal.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                objDataView = objDal.Connection.ExecuteProcedure("Rpt_Get_MonthlyRosterView", ht);

                Session["MonthlyRosterView"] = objDataView;

                return "";
            }
            catch (System.Exception ex)
            {
                return "error";
            }
        }
       
         #endregion

        
        #region LoadStandardReports

         protected string LoadStandardReport()
         {
             TAMSR2Data objTAMSDATA = new TAMSR2Data();
             try
             {
                 Hashtable ht;
                 ht = new Hashtable();
                 ht.Add("action", "LoadStandardReports");
                 ht.Add("SessionID", Session["ID"]);
                 objTAMSDATA.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                 DataView objDataView = objTAMSDATA.Connection.ExecuteProcedure("TAMSR2_StandardReportOps", ht);
                 StringBuilder temp = new StringBuilder();

                 if (objDataView != null && objDataView.Count > 0)
                 {
                     //  temp.Append("<option value = '0' selected='selected'>"+Resources.Resource.choose + "  " + Resources.Resource.report +" </option>");
                     foreach (DataRowView obj in objDataView)
                     {
                         if (cookie.Values["language"] + "" == "ar")
                             temp.Append("<option  value = ' " + (obj["ID"] + "" + "'> " + (obj["ReportName_Arb"] + "" + " </option>")));
                         else
                             temp.Append("<option  value = ' " + (obj["ID"] + "" + "'> " + (obj["ReportName_Eng"] + "" + " </option>")));
                     }
                 }
                 else
                 {
                     temp.Append("<option value = '0'> No Report Found </option>");

                 }
                 //temp.Append("</select>");
                 //temp.Append("</div>");
                 //temp.Append("</div>");

                 return temp.ToString();
             }
             catch (Exception ex)
             {
                 return "";
             }
         }

         #endregion


        #region ShowStandardReports

         protected string ShowStandardReports()
         {
             DataView objDataView = new DataView();
             TAMSR2Data objDal = new TAMSR2Data();

             try
             {
                 int ReportID = Convert.ToInt32(Request["ReportCode"] + "");
                 string RegionID = (Request["Comp"] + "").Trim();
                 string OrganizationID = (Request["Comp"] + "").Trim();
                 string fromDate = (Request["FromDate"] + "").Trim();
                 string toDate = (Request["ToDate"] + "").Trim();
                 string Emp = (Request["EmpID"] + "").Trim();

                 int isArabic = 0;

                 if (cookie.Values["language"] + "" == "ar")
                     isArabic = 1;
                 else
                     isArabic = 0;


                 //DateTime nod = new DateTime(); 
                 Session["StandardReportName"] = Request["ReportName"] + "";
                 Session["FromDate"] = fromDate;
                 Session["ToDate"] = toDate;
                 //string empname = Request["EmpName"].ToString();
                 //if (empname == "Choose Employee")
                 //    empname = "---";
                 //Session["EmpName"] = empname;


                 Hashtable ht = new Hashtable();


                 //ht.Add("CompanyID", CompanyID);
                 //if (DepartmentID == 0)
                 //    ht.Add("DepartmentID", DBNull.Value);
                 //else
                 //    ht.Add("DepartmentID", DepartmentID);

                 //if (SectionID == 0)
                 //    ht.Add("SectionID", DBNull.Value);
                 //else
                 //    ht.Add("SectionID", SectionID);

                 if (Emp == "0" || Emp == "")
                     ht.Add("EmployeeId", DBNull.Value);
                 else
                     ht.Add("EmployeeId", Emp);



                 if (fromDate != "")
                     ht.Add("FromDate", fromDate);
                 if (toDate != "")
                     ht.Add("ToDate", toDate);

                 ht.Add("isArabic", isArabic);
                 ht.Add("SessionID", Session["ID"].ToString());

                 objDal.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                 if (ReportID == 1)
                     objDataView = objDal.Connection.ExecuteProcedure("Rpt_DMR_Summary", ht);
                 else if (ReportID == 2)
                     objDataView = objDal.Connection.ExecuteProcedure("Rpt_Get_AbsenteesReport", ht);
                 else if (ReportID == 3)
                     objDataView = objDal.Connection.ExecuteProcedure("RPT_Get_PermissionReport", ht);
                 else if (ReportID == 4)
                     objDataView = objDal.Connection.ExecuteProcedure("Rpt_GET_ViolationSummaryReport", ht);
                 else if (ReportID == 5)
                     objDataView = objDal.Connection.ExecuteProcedure("RPT_Get_LeavesReport", ht);
                 else if (ReportID == 6)
                     objDataView = objDal.Connection.ExecuteProcedure("RPT_Get_NotApprovedPermissionReport", ht);
                 else
                     return "ReportNotFound";

                 Session["ReportID"] = ReportID;
                 Session["StandardReport"] = objDataView;

                 return "";
             }
             catch (System.Exception ex)
             {
                 return "ErrorOccured" + ex.Message.ToString();

             }
         }

        #endregion


        #region GetBIReport
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetBISummaryReport()
        {
            List<BussinessIntelligence> tempList = new List<BussinessIntelligence>();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();
                string employeeID = (Request["employeeID"] + "").Trim();

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "default");
                ht.Add("employeeID", employeeID);
                ht.Add("toDate", toDate);
                ht.Add("fromDate", fromDate);
                ht.Add("trimTimeInSchIn", (Request["trimTimeInSchIn"] + "" == "true" ? 1 : 0));
                ht.Add("trimTimeOutSchOut", (Request["trimTimeOutSchOut"] + "" == "true" ? 1 : 0));
                ht.Add("missingInOutDaysAsAbsent", (Request["missingInOutDaysAsAbsent"] + "" == "true" ? 1 : 0));
                ht.Add("excludeHolidaysHours", (Request["excludeHolidaysHours"] + "" == "true" ? 1 : 0));
                ht.Add("excludeRestDaysHours", (Request["excludeRestDaysHours"] + "" == "true" ? 1 : 0));
                ht.Add("excludeLeaveHours", (Request["excludeLeaveHours"] + "" == "true" ? 1 : 0));
                ht.Add("absentDaysOfSickLeave", (Request["absentDaysOfSickLeave"] + "" == "true" ? 1 : 0));
                ht.Add("fullDayWorkingMissedInOut", (Request["fullDayWorkingMissedInOut"] + "" == "true" ? 1 : 0));
                ht.Add("fullDayWorkingWithoutInOrOut", (Request["fullDayWorkingWithoutInOrOut"] + "" == "true" ? 1 : 0));

                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_BusinessIntelligenceOps", ht);

                foreach (DataRowView obj in objDataView)
                {
                    BussinessIntelligence tempObj = new BussinessIntelligence();

                    tempObj.employee_id = Numerics.GetInt(obj["Column1"] + ""); //EmpName
                    tempObj.employee_code = obj["Column2"] + ""; //EmpName
                    tempObj.employee_name = obj["Column3"] + ""; //EmpName

                    if (obj["Column4"] + "" != "")
                    {
                        tempObj.join_date = Numerics.GetDateTime(obj["Column4"]).ToString(AppSetting.dateFormat);
                    }
                    else
                    {
                        tempObj.join_date = "";
                    }

                    if (obj["Column5"] + "" != "")
                    {
                        tempObj.inactive_date = Numerics.GetDateTime(obj["Column5"]).ToString(AppSetting.dateFormat);
                    }
                    else
                    {
                        tempObj.inactive_date= "";
                    }

                    tempObj.expected_work_days = Numerics.GetInt(obj["Column6"] + "");
                    tempObj.expected_hours = Numerics.GetInt(obj["Column7"] + "");
                    tempObj.actual_work_days = Numerics.GetInt(obj["Column8"] + "");
                    tempObj.actual_work_hours = Numerics.GetInt(obj["Column9"] + "");
                    tempObj.absentcount = Numerics.GetInt(obj["Column10"] + "");
                    tempObj.missingIN = Numerics.GetInt(obj["Column11"] + "");
                    tempObj.missingOUT = Numerics.GetInt(obj["Column12"] + "");
                    tempObj.delaycount = Numerics.GetInt(obj["Column13"] + "");
                    tempObj.delaysum = Numerics.GetInt(obj["Column14"] + "");
                    tempObj.earlycount = Numerics.GetInt(obj["Column15"] + "");
                    tempObj.earlysum = Numerics.GetInt(obj["Column16"] + "");
                    tempList.Add(tempObj);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReportRequest.aspx.GetBISummaryReport()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
           return new JavaScriptSerializer().Serialize(tempList);
        }

        #endregion        

        #region GetBIDetailReport
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetBIDetailReport()
        {
            List<BussinessIntelligenceDetails> tempList = new List<BussinessIntelligenceDetails>();
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                string fromDate = (Request["fromDate"] + "").Trim();
                string toDate = (Request["toDate"] + "").Trim();
                string employeeID = (Request["employeeID"] + "").Trim();

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "details");
                ht.Add("employeeID", employeeID);
                ht.Add("fromDate", fromDate);
                ht.Add("toDate", toDate);
                ht.Add("trimTimeInSchIn", (Request["trimTimeInSchIn"] + "" == "true" ? 1 : 0));
                ht.Add("trimTimeOutSchOut", (Request["trimTimeOutSchOut"] + "" == "true" ? 1 : 0));
                ht.Add("missingInOutDaysAsAbsent", (Request["missingInOutDaysAsAbsent"] + "" == "true" ? 1 : 0));
                ht.Add("excludeHolidaysHours", (Request["excludeHolidaysHours"] + "" == "true" ? 1 : 0));
                ht.Add("excludeRestDaysHours", (Request["excludeRestDaysHours"] + "" == "true" ? 1 : 0));
                ht.Add("excludeLeaveHours", (Request["excludeLeaveHours"] + "" == "true" ? 1 : 0));
                ht.Add("absentDaysOfSickLeave", (Request["absentDaysOfSickLeave"] + "" == "true" ? 1 : 0));
                ht.Add("fullDayWorkingMissedInOut", (Request["fullDayWorkingMissedInOut"] + "" == "true" ? 1 : 0));
                ht.Add("fullDayWorkingWithoutInOrOut", (Request["fullDayWorkingWithoutInOrOut"] + "" == "true" ? 1 : 0));

                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_BusinessIntelligenceOps", ht);

                foreach (DataRowView obj in objDataView)
                {
                    BussinessIntelligenceDetails tempObj = new BussinessIntelligenceDetails();

                    if (obj["Column1"] + "" != "")
                    {
                        tempObj.Transaction_date = Numerics.GetDateTime(obj["Column1"]).ToString(AppSetting.dateFormat);
                    }
                    else
                    {
                        tempObj.Transaction_date = "";
                    }
                    tempObj.day_name = obj["Column2"] + ""; 
                    tempObj.Punch_In = obj["Column3"] + "";
                    tempObj.Punch_Out = obj["Column4"] + ""; 
                    tempObj.Late_HH_MM = obj["Column5"] + ""; 
                    tempObj.Early_HH_MM = obj["Column6"] + ""; 
                    tempObj.Required_Work_HH_MM = obj["Column7"] + ""; 
                    tempObj.Work_Time_HH_MM = obj["Column8"] + ""; 
                    tempObj.Missing_Time_HH_MM = obj["Column9"] + ""; 
                    tempObj.ExtraWorkedTime_HH_MM = obj["Column10"] + ""; 
                    tempObj.Comment_English = obj["Column11"] + ""; 
                    tempObj.Remarks_English = obj["Column12"] + "";
                    tempObj.employee_code = obj["Column14"] + ""; 
                    tempObj.Employee_Name_English = obj["Column15"] + "";

                    tempList.Add(tempObj);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReportRequest.aspx.GetBIDetailReport()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
           return new JavaScriptSerializer().Serialize(tempList);
        }

        #endregion


        #region TransactionReport

        protected string TransactionReport()
        {
            DataView objDataView = new DataView();
            TAMSR2Data objDAL = new TAMSR2Data();
            List<TransactionRpt> tempList = new List<TransactionRpt>();
            try
            {
                string reportType = Request["ReportType"] + "";

                string Orgnization = Request["Org"] + "";
                int year = Convert.ToInt32(Request["Year"] + "");
                int Month = Convert.ToInt32(Request["Month"] + "");
                string Emp = Request["EmpID"] + "";
                string Mgr = Request["MgrId"] + "";
                string GroupId = Request["GroupId"] + "";
                if (Orgnization == "")
                {
                    Orgnization = System.DBNull.Value + "";
                }
                if (Emp == "")
                {
                    Emp = System.DBNull.Value + "";
                }

                if (Mgr == "")
                {
                    Mgr = System.DBNull.Value + "";
                }
                if (GroupId == "")
                {
                    GroupId = System.DBNull.Value + "";
                }

                Hashtable ht = new Hashtable();
                ht.Add("sessionID", "");
                ht.Add("OrganizationID", Orgnization);
                ht.Add("EmployeeId", Emp);
                ht.Add("ManagerId", Mgr);
                ht.Add("Year", year);
                ht.Add("Month", Month);
                ht.Add("action", reportType);

                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));
                objDataView = objDAL.Connection.ExecuteProcedure("Rpt_TransactionReport", ht);
                DateTime serverTime = DateTime.Now; // gives you current Time in server timeZone
                DateTime utcTime = serverTime.ToUniversalTime(); // convert it to Utc using timezone setting of server computer

                foreach (DataRowView obj in objDataView)
                {
                    TransactionRpt tempObj = new TransactionRpt();

                    tempObj.EmployeeNumber = obj["EmployeeNumber"] + "";
                    tempObj.EmployeeName = obj["EmployeeName"] + "";
                    tempObj.DepartmentName = obj["DepartmentName"] + "";
                    tempObj.CurrentTimeStamp = utcTime.ToString("dd-MMM-yyyy");
                    tempObj.Col1 = obj["Col1"] + "";
                    tempObj.Col2 = obj["Col2"] + "";
                    tempObj.Col3 = obj["Col3"] + "";
                    tempObj.Col4 = obj["Col4"] + "";
                    tempObj.Col5 = obj["Col5"] + "";
                    tempObj.Col6 = obj["Col6"] + "";
                    tempObj.Col7 = obj["Col7"] + "";
                    tempObj.Col8 = obj["Col8"] + "";
                    tempObj.Col9 = obj["Col9"] + "";
                    tempObj.Col10 = obj["Col10"] + "";
                    tempObj.Col11 = obj["Col11"] + "";
                    tempObj.Col12 = obj["Col12"] + "";
                    tempObj.Col13 = obj["Col13"] + "";
                    tempObj.Col14 = obj["Col14"] + "";
                    tempObj.Col15 = obj["Col15"] + "";
                    tempObj.Col16 = obj["Col16"] + "";
                    tempObj.Col17 = obj["Col17"] + "";
                    tempObj.Col18 = obj["Col18"] + "";
                    tempObj.Col19 = obj["Col19"] + "";
                    tempObj.Col20 = obj["Col20"] + "";
                    tempObj.Col21 = obj["Col21"] + "";
                    tempObj.Col22 = obj["Col22"] + "";
                    tempObj.Col23 = obj["Col23"] + "";
                    tempObj.Col24 = obj["Col24"] + "";
                    tempObj.Col25 = obj["Col25"] + "";
                    tempObj.Col26 = obj["Col26"] + "";
                    tempObj.Col27 = obj["Col27"] + "";
                    tempObj.Col28 = obj["Col28"] + "";
                    tempObj.Col29 = obj["Col29"] + "";
                    tempObj.Col30 = obj["Col30"] + "";
                    tempObj.Col31 = obj["Col31"] + "";

                    tempList.Add(tempObj);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/ReportRequest.aspx.TransactionReport()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(tempList);
        }

        #endregion
    }
}