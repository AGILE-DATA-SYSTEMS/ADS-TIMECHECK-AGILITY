using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework.DAL;

namespace TAMSR2.Details
{
    public partial class ViewDBConsole : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewdbconsole.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/viewdbconsole.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("security/console"));

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

            //if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.DB_CONSOLE) == false)
            //{
            //    Response.Redirect(path + "Common/Home");
            //}

            if (Numerics.GetBool(Session["RootUser"]) == false)
            {
                Response.Redirect(path + "ErrorPages/error-404.aspx");
            }
        }

        public string GetConnectionStrinng()
        {
            string connectionString = "";

            string strDbConnType = ConfigurationManager.AppSettings["DbConnectionType"];
            string strDatabase = ConfigurationManager.AppSettings["Database"];
            string strConnEncrypted = ConfigurationManager.AppSettings["DbConnectionString"];
            if ((HttpContext.Current.Session["dbType"] + "").ToLower() == "sql")
            {
                string server = ConfigurationManager.AppSettings["dbServer"];

                connectionString = "Data Source=" + server + ";Initial Catalog=" + HttpContext.Current.Session["dbName"] + ";uid=" + HttpContext.Current.Session["dbUser"] + ";pwd=" + HttpContext.Current.Session["dbPassword"] + "";
            }

            return connectionString;
        }

        protected void btnExecute_Click(object sender, EventArgs e)
        {
            LoadGrid();
        }

        public void LoadGrid()
        {
            string query = txtQuery.Text.Trim();
            SqlConnection con = new SqlConnection(GetConnectionStrinng());
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter adopter = new SqlDataAdapter(cmd);
                DataTable table = new DataTable();
                adopter.Fill(table);
                dgvResult.DataSource = table;
                dgvResult.DataBind();
                cmd.Dispose();
                adopter.Dispose();
            }
            catch (Exception ex)
            {
                dgvResult.DataSource = null;
                dgvResult.DataBind();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtQuery.Text = "";
        }

        protected void dgvResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            LoadGrid();
            dgvResult.PageIndex = e.NewPageIndex;
            dgvResult.DataBind();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Common/Home");
        }
    }
}