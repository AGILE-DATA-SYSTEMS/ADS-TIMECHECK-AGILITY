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
    public partial class WorkflowPage : System.Web.UI.Page
    {
        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.IndexOf(@"RequestPages/WorkflowPage.aspx"));


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
            else if (Request["key"] + "" == "save")
            {
                data = Save();
            }
            else if (Request["key"] + "" == "getAll")
            {
                data = GetAll();
            }
            else if (Request["key"] + "" == "getByID")
            {
                data = GetByID();
            }
            else if (Request["key"] + "" == "deleteByID")
            {
                data = DeleteByID();
            }
            else if (Request["key"] + "" == "getIdNameListString")
            {
                data = GetIdNameListString();
            }
            else if (Request["key"] + "" == "getActionIdNameListString")
            {
                data = GetActionIdNameListString();
            }
            else if (Request["key"] + "" == "getCategoryIdNameListString")
            {
                data = GetCategoryIdNameListString();
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


        #region GetByID
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetByID()
        {

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            Workflow obj = new Workflow();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht);

                if (dv != null)
                { 
                    obj.ID = Numerics.GetDecimal(dv[0]["Workflow_Id"]); 
                    obj.Code = dv[0]["code"] + "";
                    obj.Category = dv[0]["category_id"] + "";
                }
                ht.Clear();
                dv = null;
                ht.Add("action", "getStepsByID");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", Numerics.GetDecimal(Request["id"] + ""));
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht);
                int rows =  1;
                if(dv != null)
                 obj.Level = dv.Count;
                else
                obj.Level  = 0;

                foreach (DataRowView row in dv)
                {
                   
                   if(rows <= dv.Count)
                   {
                       if(rows == 1)
                       {
                           obj.Type1 =   row["Action_Type"] + "" ;
                           obj.Value1 =   row["Action_Data"] + "" ;
                           obj.OnSuccess1 =   row["Approved"] + "" ;
                           obj.OnFailure1 = Resources.Resource.rejected; // row["Rejected"] + "" ;
                           obj.StatusText1 =   row["Step_Eng"] + "" ;
                       }
                       else if(rows ==2)
                       {
                           obj.Type2=   row["Action_Type"] + "" ;
                           obj.Value2 =   row["Action_Data"] + "" ;
                           obj.OnSuccess2 =   row["Approved"] + "" ;
                           obj.OnFailure2 = Resources.Resource.rejected; // row["Rejected"] + "" ;
                           obj.StatusText2 =   row["Step_Eng"] + "" ;
                       }
                       else if (rows == 3)
                       {
                           obj.Type3 =   row["Action_Type"] + "" ;
                           obj.Value3 =   row["Action_Data"] + "" ;
                           obj.OnSuccess3 =   row["Approved"] + "" ; 
                           obj.OnFailure3 = Resources.Resource.rejected; //  row["Rejected"] + "" ;
                           obj.StatusText3 =   row["Step_Eng"] + "" ;
                       }
                       else if(rows  == 4) 
                       {
                           obj.Type4 =   row["Action_Type"] + "" ;
                           obj.Value4 =   row["Action_Data"] + "" ;
                           obj.OnSuccess4 =   row["Approved"] + "" ;
                           obj.OnFailure4 = Resources.Resource.rejected; // row["Rejected"] + "" ;
                           obj.StatusText4 =   row["Step_Eng"] + "" ;
                       }
                   }
                   rows++;
		 
                }
                
                
                 
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(obj);
        }
        //*********End Of GetAll Function*********//
        #endregion



        #region GetIdNameListString
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetIdNameListString()
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
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string workflowStr = (String)GetGlobalResourceObject("Resource", "workflow");

                sb.Append("<option value=''>" + chooseStr + " " + workflowStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Workflow obj = new Workflow();
                    obj.ID = Numerics.GetDecimal(row["Workflow_Id"]);
                    obj.Code = row["code"] + ""; 

                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option   value='" + obj.ID + "'>" + obj.Code + " </option>");
                    else
                        sb.Append("<option   value='" + obj.ID + "'>" + obj.Code + "  </option>");
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
        //*********End Of GetAll Function*********//
        #endregion



        #region GetCategoryIdNameListString
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetCategoryIdNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getCategoryIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string workflowStr = (String)GetGlobalResourceObject("Resource", "workflow");

                sb.Append("<option value=''>" + chooseStr + " " + workflowStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Workflow obj = new Workflow();
                    obj.ID = Numerics.GetDecimal(row["workflow_category_id"]);
                    obj.Code = row["code"] + "";

                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option   value='" + obj.ID + "'>" + obj.Code + " </option>");
                    else
                        sb.Append("<option   value='" + obj.ID + "'>" + obj.Code + "  </option>");
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
        //*********End Of GetAll Function*********//
        #endregion



        #region GetActionIdNameListString
        /// <summary>
        /// GetByID function
        /// Get user by ID from TAMSR2_LICENCE table 
        /// </summary>
        /// <returns>it will return parsed json object</returns>
        public string GetActionIdNameListString()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            StringBuilder sb = new StringBuilder();

            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                Hashtable ht = new Hashtable();
                ht.Add("action", "getActionIdNameList");
                ht.Add("sessionID", Session["ID"] + "");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht);

                string chooseStr = (String)GetGlobalResourceObject("Resource", "choose");
                string workflowStr = (String)GetGlobalResourceObject("Resource", "workflow");

                sb.Append("<option value=''>" + chooseStr + " " + workflowStr + "</option>");

                foreach (DataRowView row in dv)
                {
                    Workflow obj = new Workflow();
                    obj.ID = Numerics.GetDecimal(row["Workflow_action_Id"]);
                    obj.Code = row["desc_eng"] + "";

                    if (cookie.Values["language"] == "ar")
                        sb.Append("<option   value='" + obj.ID + "'>" + obj.Code + " </option>");
                    else
                        sb.Append("<option   value='" + obj.ID + "'>" + obj.Code + "  </option>");
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
        //*********End Of GetAll Function*********//
        #endregion


        #region DeleteByID
        /// <summary>
        /// DeleteByID function
        /// Delete user by ID from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return 1 if successfully deleted 0 incase of deletion failed.</returns>
        public string DeleteByID()
        {
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                int count = Numerics.GetInt(Request["count"] + "");
                string ids = "";
                for (int k = 1; k <= count; k++)
                {
                    ids += Request["chk" + k] + ",";
                }
                ids = ids.TrimEnd(',');
                Hashtable ht = new Hashtable();
                ht.Add("action", "deleteByIDList");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("ID", ids);
                
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                DataView dv = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht);
                if(dv != null && dv.Count > 0)
                    return "1";
                else
                    return "0";
            } 
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/WorkflowPage.aspx.DeleteByID()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return "0";
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region GetAll
        /// <summary>
        /// Get All function
        /// Get all users from TAMSR2_USERS table 
        /// </summary>
        /// <returns>it will return html string for USERS Grid</returns>
        public string GetAll()
        {
            JQueryResponse json = new JQueryResponse();
            TAMSR2Data objDAL = new TAMSR2Data();
            //if (Numerics.GetBool(Session["CanView"]) == false)
            //{
            //    return new JavaScriptSerializer().Serialize(json);
            //}
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                int start = Numerics.GetInt(Request["iDisplayStart"]);
                int end = Numerics.GetInt(Request["iDisplayLength"]);

                string[] cols = { "wt.Workflow_Id", "wt.Code", "wtc.Code", "steps", "wt.Workflow_Id" };

                string orderByClause = " " + cols[Numerics.GetInt(Request["iSortCol_0"])] + " " + Request["sSortDir_0"];

                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getRecords");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                ht.Add("startRow", start);
                ht.Add("endRow", end);
                DataView objDataView = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht);

                json.sEcho = Numerics.GetInt(Request["sEcho"] + "");
                ht = new Hashtable();
                ht.Add("action", "getCount");
                ht.Add("sessionID", Session["ID"] + "");
                ht.Add("searchInput", (Request["sSearch"] + "").Trim());
                ht.Add("orderBy", orderByClause);
                json.iTotalRecords = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_WorkflowOps", ht));
                json.iTotalDisplayRecords = json.iTotalRecords;

                foreach (DataRowView obj in objDataView)
                {
                    List<string> tempList = new List<string>();
                    tempList.Add("<input type='checkbox' class='checkboxes' value='" + Numerics.GetDecimal(obj["Workflow_Id"]) + "' />");
                    tempList.Add(obj["code"] + "");
                    tempList.Add(obj["category"] + "");
                    tempList.Add(obj["steps"] + "");
                    string tempAction = ""; 
                    if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.EDIT_WORKFLOWS) == true || Numerics.GetBool(Session["CanUpdate"]) == true)
                    {
                        tempAction = "<img src='" + path + "images/edit.png' title='Edit' alt='Edit' onclick='return Edit(" + Numerics.GetDecimal(obj["Workflow_Id"]) + ");' /> &nbsp; ";
                    } 
                    tempList.Add(tempAction);
                    json.aaData.Add(tempList);
                }
            }
            catch (Exception ex)
            {
                new ExceptionLog().WriteLog("RequestPages/WorkflowPage.aspx.GetAll()", 0, ex);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return new JavaScriptSerializer().Serialize(json);
        }
        //*********End Of GetAll Function*********//
        #endregion


        #region Save
        /// <summary>
        /// Save function
        /// TAMSR2_USERS attributes to save in database
        /// </summary>
        /// <returns>it will return 1 in success, 0 in case of already exists and -1 in case of failed </returns>

        public string Save()
        {
            DataView dv = new DataView();
            string chk = "";

            int Level = Convert.ToInt32( (Request["Level"] + "").Trim());

            Hashtable ht = new Hashtable();
            ht.Add("action", "save");
            ht.Add("sessionID", Session["ID"] + "");
            ht.Add("id", (Request["id"] + "").Trim());
            ht.Add("code", (Request["code"] + "").Trim());
            ht.Add("Category", (Request["cat"] + "").Trim()); 
            ht.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("createdBy", Session["ID"] + "");
            ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
            ht.Add("updatedBy", Session["ID"] + "");

            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht);
                if (dv != null)
                {
                    if (dv[0][0] != "0")
                    {
                        for (int i = 1; i <= Level; i++)
                        {
                            Hashtable ht1 = new Hashtable();
                            ht1.Add("action", "saveSteps");
                            ht1.Add("sessionID", Session["ID"] + "");
                            ht1.Add("ID", dv[0][0] + "");
                            ht1.Add("Type", Request["Type" + i] + "");
                            ht1.Add("Value", Request["Value" + i] + "");
                            ht1.Add("Step", i + "");
                            ht1.Add("OnSuccess", Request["Step" + i] + "");
                            ht1.Add("OnFailure", Request["Rejected" + i] + "");
                            ht1.Add("StatusText", Request["Status" + i] + "");

                            ht1.Add("createdOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                            ht1.Add("createdBy", Session["ID"] + "");
                            ht1.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                            ht1.Add("updatedBy", Session["ID"] + "");

                            objDAL.OpenConnection(Connection.GetConnectionStrinng(Session["dbType"] + "", Session["dbName"] + "", Session["dbUser"] + "", Session["dbPassword"] + ""));

                            DataView dv2 = new DataView();
                            dv2 = objDAL.Connection.ExecuteProcedure("TAMSR2_WorkflowOps", ht1);

                            if (dv2 != null)
                            {
                                if (Convert.ToInt32(dv[0][0]) > 0)
                                    chk = "1";
                                else
                                    chk = "0";
                            }
                            else
                            {
                                chk = "-1";
                            }
                        }

                    }
                    else
                    {
                        chk = "0";
                    }

                }
                else
                {
                    chk = "-1";
                }
            }
            catch (Exception ex)
            {
                chk = "-1";
                ht = new Hashtable();
                ht.Add("action", "deleteByID");
                ht.Add("id", dv[0][0] + "");
                objDAL.Connection.ExecuteNonQueryProcedure("TAMSR2_WorkflowOps", ht); 
                new ExceptionLog().WriteLog("RequestPages/WorkflowPage.aspx.Save()", 0, ex);

            }
            finally
            {
                objDAL.CloseConnection();
            }
            return chk;
        }
        //*********End Of Save Function*********//
        #endregion

    }
}