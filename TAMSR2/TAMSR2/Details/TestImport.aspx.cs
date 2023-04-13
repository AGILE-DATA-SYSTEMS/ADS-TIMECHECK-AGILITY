using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TAMSR2.Details
{
    public partial class TestImport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            if (fileUploadControl.HasFile)
            {
                try
                {
                    Random rdm = new Random();
                    string fileName = "File_" + rdm.Next(10000) + "";
                    if (fileUploadControl.FileName.EndsWith(".xls"))
                    {
                        fileName += ".xls";
                    }
                    if (fileUploadControl.FileName.EndsWith(".xlsx"))
                    {
                        fileName += ".xlsx";
                    }
                    string filePath = Server.MapPath("../Uploads/" + fileName);
                    fileUploadControl.SaveAs(filePath);

                    DataSet ds = ImportFromExcel(filePath);
                    dgvImport.DataSource = ds.Tables[0];
                    dgvImport.AutoGenerateColumns = true;
                    dgvImport.DataBind();
                }
                catch (Exception ex)
                {
                }
            }
        }

        public DataSet ImportFromExcel(string file)
        {
            // Create new dataset
            DataSet ds = new DataSet();

            // -- Start of Constructing OLEDB connection string to Excel file
            Dictionary<string, string> props = new Dictionary<string, string>();

            // For Excel 2007/2010
            if (file.EndsWith(".xlsx"))
            {
                props["Provider"] = "Microsoft.ACE.OLEDB.12.0;";
                props["Extended Properties"] = "Excel 12.0 XML";
            }
            // For Excel 2003 and older
            else if (file.EndsWith(".xls"))
            {
                props["Provider"] = "Microsoft.Jet.OLEDB.4.0";
                props["Extended Properties"] = "Excel 8.0";
            }
            else
                return null;

            props["Data Source"] = file;

            StringBuilder sb = new StringBuilder();

            foreach (KeyValuePair<string, string> prop in props)
            {
                sb.Append(prop.Key);
                sb.Append('=');
                sb.Append(prop.Value);
                sb.Append(';');
            }

            string connectionString = sb.ToString();
            // -- End of Constructing OLEDB connection string to Excel file

            // Connecting to Excel File
            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                OleDbCommand cmd = new OleDbCommand();
                cmd.Connection = conn;

                // Get all Sheets in Excel File
                DataTable dtSheet = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                // Loop through all Sheets to get data
                foreach (DataRow dr in dtSheet.Rows)
                {
                    string sheetName = dr["TABLE_NAME"].ToString();

                    // Get all rows from the Sheet
                    cmd.CommandText = "SELECT * FROM [" + sheetName + "]";

                    DataTable dt = new DataTable();
                    dt.TableName = sheetName.Replace("$", string.Empty);

                    OleDbDataAdapter da = new OleDbDataAdapter(cmd);
                    da.Fill(dt);

                    // Add table into DataSet
                    ds.Tables.Add(dt);
                }

                cmd = null;
                conn.Close();
            }

            return ds;
        }
        
        protected void btnSaveData_Click(object sender, EventArgs e)
        {
            try
            {
                StringBuilder sb = new StringBuilder();

                foreach (GridViewRow rw in dgvImport.Rows)
                {
                    string code = (rw.Cells[0].Text + "").Trim();
                    DateTime transaction = Convert.ToDateTime(rw.Cells[1].Text + "");
                    string reason = (rw.Cells[2].Text + "").Trim();
                    sb.Append("INSERT INTO TEMPIMPORT VALUES('" + code + "', '" + transaction.ToString("yyyy-MM-dd HH:mm") + "', '" + reason + "'); ");
                }
                string query = sb.ToString();

            }
            catch (Exception ex)
            {
            }
        }

    }
}
