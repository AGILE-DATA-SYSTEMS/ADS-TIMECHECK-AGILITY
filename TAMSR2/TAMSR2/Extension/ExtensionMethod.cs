using System;
using System.Collections.Generic;
using System.Linq;

using System.Data;
using System.Data.OleDb;
using System.Text.RegularExpressions;
using System.Text;
using System.ComponentModel;
using System.Windows.Forms;
using System.Threading;
using System.IO;

namespace TAMSR2.Extension
{
    public static class ExtensionMethod
    {
        /// <summary>
        /// Get data type of column
        /// </summary>
        public static Type GetColumnDataType(this DataTable tbl, string ColumnName)
        {
            try
            {
                return tbl.Columns[ColumnName].DataType;
            }
            catch (Exception ex)
            {
                throw new Exception("OS_GetColumnDataType: \n" + ex.Message);
            }
        }

        /// <summary>
        /// Get data type of column
        /// </summary>
        public static Type GetColumnDataType(this DataTable tbl, int ColumnIndex)
        {
            try
            {
                return tbl.Columns[ColumnIndex].DataType;
            }
            catch (Exception ex)
            {
                throw new Exception("OS_GetColumnDataType: \n" + ex.Message);
            }
        }

        /// <summary>
        /// Get table element with given column and row indices
        /// </summary>
        public static object GetElementValue(this DataTable tbl, int ColInd, int RowInd)
        {
            try
            {
                return tbl.Rows[RowInd][ColInd];
            }
            catch (Exception ex)
            {
                throw new Exception("OS_GetElementValue: \n" + ex.Message);
            }
        }

        /// <summary>
        /// Get table element with given column names and row indices
        /// </summary>
        public static object GetElementValue(this DataTable tbl, string ColumnName, int RowInd)
        {
            try
            {
                return tbl.Rows[RowInd][ColumnName];
            }
            catch (Exception ex)
            {
                throw new Exception("OS_GetElementValue: \n" + ex.Message);
            }
        }

        /// <summary>Assign value to a table element with given column and row indices
        /// </summary>
        public static void SetElementValue(this DataTable tbl, string ColumnName, int RowInd,
            object ElementValue)
        {
            try
            {
                tbl.Rows[RowInd][ColumnName] = ElementValue;
            }
            catch (Exception ex)
            {
                throw new Exception("OS_SetElementValue: \n" + ex.Message);
            }
        }

        /// <summary>
        /// Convert DataTable into a printable string
        /// </summary>
        /// <returns>Formatted string</returns>
        public static string ConvertToString(this DataTable tbl)
        {
            try
            {
                // check if table is empty
                if (tbl == null || tbl.Columns.Count == 0)
                    return "OS_ConvertToString: EMPTY DataTable";

                StringBuilder builder = new StringBuilder();

                //  columns
                for (int i = 0; i < tbl.Columns.Count; i++)
                {
                    builder.Append(tbl.Columns[i].ColumnName + "\t");
                }

                // dashes
                builder.AppendLine();
                int StrLen = builder.ToString().Length + tbl.Columns.Count;
                for (int i = 0; i < StrLen; i++) builder.Append("-");
                builder.AppendLine();

                // rows
                for (int i = 0; i < tbl.Rows.Count; i++)
                {
                    for (int j = 0; j < tbl.Columns.Count; j++)
                    {
                        builder.Append(tbl.Rows[i][j].ToString() + "\t");
                    }
                    builder.AppendLine();
                }
                return builder.ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("OS_ConvertToString: " + ex.Message);
            }
        }

        /// <summary>
        /// Convert DataTable into  a MatrixTable object
        /// </summary>
        /// <param name="tbl">Input table of type DataTable</param>
        /// <param name="md">Master data</param>
        /// <param name="TextReplaceNull">Replacement text value for null in input table</param>
        /// <param name="NumReplaceNull">Replacement integer value for null in input table</param>
        /// <param name="KeyFigReplaceNull">Replacement floating value for null in input table</param>
        /// <returns>MatrixTable object</returns>
       
    

        /// <summary>
        /// Column partition: Return a DataTable with selected columns
        /// </summary>
        /// <param name="tbl">DataTable</param>
        /// <param name="ColumnNames">Column names</param>
        /// <returns>Subtable with selected columns</returns>
        /// <remarks>
        /// - error if input vector with column names is null or empty
        /// - error if any column name in vector is not contained in DataTable
        /// </remarks>

        /// <summary>
        /// Return subtable with selected column indices
        /// </summary>
        /// <param name="tbl">DataTable</param>
        /// <param name="ColumnIndices">Column indices</param>
        /// <returns>Subtable with selected columns</returns>
        /// <remarks>
        /// - error if input vector with column indices is null or empty
        /// - error if any column index in vector is not proper
        /// </remarks>

        /// <summary>Return subtable with selected row indices
        /// </summary>
        /// <param name="tbl">DataTable</param>
        /// <param name="RowIndices">Row indices</param>
        /// <returns>Subtable with selected rows</returns>
        /// <remarks>
        /// - error if input table is null or empty
        /// - error if index vector is null or empty
        /// - error if improper index value in vector
        /// </remarks>

        /// <summary>Return subtable with selected columns and rows
        /// </summary>
        

        /// <summary>
        /// View DataTable in grid view (read-only), multi-thread
        /// </summary>
        /// <param name="Tbl">DataTable input</param>
        /// <param name="Header">Header text for table viewer</param>
        /// <returns>TableViewer object</returns>

        /// <summary>
        /// View DataTable in grid view (read-only), single-thread
        /// </summary>
        /// <param name="Tbl">DataTable input</param>
        /// <param name="Header">Header text for table viewer</param>
        /// <returns>TableViewer object</returns>
      
        /// <summary>
        /// Save DataTable as an XML file.
        /// - Add a timestamp like "_14_09_2012_14_21_04" to file name if IfAddTimeStamp = true
        /// </summary>
        /// <param name="Tbl">Data table</param>
        /// <param name="Filename">A file name like "InventoryTable" without file extension</param>
        /// <param name="FileDir">A valid directory like @"C:\Users\John\Documents\</param>
        /// <param name="IfAddTimeStamp">If true, add timestamp to file name </param>
        public static void ExportTableToXMLfile(this DataTable Tbl, string Filename, string FileDir = "",
            bool IfAddTimeStamp = true)
        {
            if (Tbl == null || Tbl.Columns.Count == 0)
                throw new Exception("OS_StoreTableAsXMLfile: Null or empty input table!\n");

            Tbl.TableName = Filename;       // a table name is required for XML storage
            var filepath = FileDir + Filename;

            if (IfAddTimeStamp)
            {
                string timestr = DateTime.Now.ToLocalTime().ToString();     // a string like 14.09.2012 13:56:03
                timestr = Regex.Replace(timestr, @"[:\s\.]", "_");
                filepath = filepath + "_" + timestr;
            }

            try
            {
                Tbl.WriteXmlSchema(filepath + ".xsd");
                Tbl.WriteXml(filepath + ".xml");
            }
            catch (Exception ex)
            {
                throw new Exception("OS_StoreTableAsXMLfile: Data table could not be written into an XML file.\n"
                    + ex.Message);
            }
        }

        /// <summary>
        /// Read DataTable from an XML file
        /// </summary>
        /// <param name="Tbl">Data table</param>
        /// <param name="Filename">A file name like "InventoryTable" without file extension</param>
        /// <param name="FileDir">A valid directory like @"C:\Users\John\Documents\</param>
        /// <returns>DataTable object</returns>
        public static DataTable ImportTableFromXMLfile(this DataTable Tbl, string Filename, string FileDir = "")
        {
            // read data table from XML file
            var TblOut = new DataTable();
            var filepath = FileDir + Filename;

            try
            {
                TblOut.ReadXmlSchema(filepath + ".xsd");
                TblOut.ReadXml(filepath + ".xml");
            }
            catch (Exception ex)
            {
                throw new Exception("OS_ReadTableFromXMLfile: Data table could not be read from XML file.\n"
                    + ex.Message);
            }
            return TblOut;
        }

        /// <summary>
        /// Sort table rows after given fields
        /// </summary>
        /// <param name="Tbl">Input table</param>
        /// <param name="SortStr">Comma separated field names and sort option, like "field1 ASC, field2 DESC"</param>
        /// <returns>Sorted DataTable</returns>
        /// <remarks>
        /// - default sort option is ASC; need not be stated explicitly
        /// </remarks>
        public static DataTable Sort(this DataTable Tbl, string SortStr)
        {
            try
            {
                DataView dtview = new DataView(Tbl);
                dtview.Sort = SortStr;
                return dtview.ToTable();
            }
            catch (Exception ex)
            {
                throw new Exception("OS_Sort: \n" + ex.Message);
            }
        }

        /// <summary>
        /// Export DataTable to CSV file with semicolon as delimiter
        /// </summary>
        /// <param name="Tbl">DataTable object</param>
        /// <param name="filepath">Complete file path including file name</param>
        public static void ExportToCSVfile(this DataTable Tbl, string filepath)
        {
            try
            {
                // Create CSV file
                StreamWriter sw = new StreamWriter(filepath, false);

                // write headers
                int ColumnCount = Tbl.Columns.Count;

                for (int i = 0; i < ColumnCount; i++)
                {
                    sw.Write(Tbl.Columns[i]);
                    if (i < ColumnCount - 1)
                    {
                        sw.Write(";");
                    }
                }
                sw.Write(sw.NewLine);

                // write rows
                foreach (DataRow dr in Tbl.Rows)
                {
                    for (int i = 0; i < ColumnCount; i++)
                    {
                        if (!Convert.IsDBNull(dr[i]))
                        {
                            sw.Write(dr[i].ToString());
                        }
                        if (i < ColumnCount - 1)
                        {
                            sw.Write(";");
                        }
                    }
                    sw.Write(sw.NewLine);
                }
                sw.Close();
            }
            catch (Exception ex)
            {
                throw new Exception("FQ_DataTable_Extensions.FQ_ExportToCSVfile: \n" + ex.Message);
            }
        }

        /// Export DataTable to CSV file with semicolon as delimiter
        /// and open with an associated windows application.
        /// </summary>
        /// <param name="Tbl">DataTable object</param>
        /// <param name="filepath">Complete file path including file name</param>
        /// <remarks>
        /// Stores a file named "MyCSVfile.csv" in the temp folder
        /// </remarks>
        public static void ExportToCSVfile(this DataTable Tbl)
        {
            try
            {
                // construct filepath in TEMP folder of current user
                string tempPath = System.IO.Path.GetTempPath();
                string filepath = tempPath + "\\" + "FinaquantCSVfile_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".csv";

                // export to file
                Tbl.ExportToCSVfile(filepath);

                // open file with a windows application
                System.Diagnostics.Process.Start(filepath);
            }
            catch (Exception ex)
            {
                throw new Exception("FQ_DataTable_Extensions.FQ_ExportToCSVfile: \n" + ex.Message);
            }
        }

        /// <summary>
        /// Import DataTable from CSV file (semicolon as delimiter)
        /// </summary>
        /// <param name="Tbl">DataTable</param>
        /// <param name="md">MetaData</param>
        /// <param name="filepath">Full file path; directory and file name</param>
        /// <returns>DataTable object</returns>
        //public static DataTable ImportFromCSVfile(this DataTable Tbl, MetaData md, string filepath)
        //{
        //    StreamReader reader;
        //    try
        //    {
        //        reader = new StreamReader(File.OpenRead(filepath));
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception("FQ_DataTable_Extensions.FQ_ImportFromCSVfile: \n"
        //            + "Could not open file! Please check directory and file name.\n" + ex.Message);
        //    }

        //    try
        //    {
        //        // create DataTable
        //        var dtable = new DataTable();
        //        int LineCount = 0;

        //        // variables
        //        string fieldname;
        //        var FieldTypes = new List<FieldType>();
        //        string line;
        //        string[] values;
        //        DataRow drow;

        //        while (!reader.EndOfStream)
        //        {
        //            LineCount += 1;
        //            line = reader.ReadLine();
        //            values = line.Split(';');

        //            // read header line and add columns to table
        //            if (LineCount == 1)
        //            {
        //                for (int i = 0; i < values.Length; i++)
        //                {
        //                    // convert to lower letters
        //                    fieldname = values[i].ToLower();

        //                    // get field type from MetaData
        //                    FieldTypes.Add(MetaData.GetFieldType(md, fieldname));

        //                    // check if field is defined in MetaData
        //                    if (FieldTypes[i] == FieldType.Undefined)
        //                    {
        //                        throw new Exception("FQ_DataTable_Extensions.FQ_ImportFromCSVfile: "
        //                            + "Field " + fieldname + " is not defined in MetaData!\n");
        //                    }

        //                    // checks OK, add column
        //                    switch (FieldTypes[i])
        //                    {
        //                        case FieldType.TextAttribute:
        //                            dtable.Columns.Add(fieldname, typeof(string));
        //                            break;
        //                        case FieldType.IntegerAttribute:
        //                            dtable.Columns.Add(fieldname, typeof(int));
        //                            break;
        //                        case FieldType.DateAttribute:
        //                            dtable.Columns.Add(fieldname, typeof(DateTime));
        //                            break;
        //                        case FieldType.KeyFigure:
        //                            dtable.Columns.Add(fieldname, typeof(double));
        //                            break;
        //                    }
        //                }
        //            }

        //            // add rows to DataTable
        //            if (LineCount > 1)
        //            {
        //                // check number of values in the line
        //                if (values.Length != dtable.Columns.Count)
        //                {
        //                    throw new Exception("FQ_DataTable_Extensions.FQ_ImportFromCSVfile: "
        //                        + "Number of values in file line does not match column count!\n");
        //                }

        //                // get row data
        //                drow = dtable.NewRow();

        //                for (int j = 0; j < values.Length; j++)
        //                {

        //                    switch (FieldTypes[j])
        //                    {
        //                        case FieldType.TextAttribute:
        //                            drow[j] = values[j];
        //                            break;
        //                        case FieldType.IntegerAttribute:
        //                            drow[j] = Convert.ToInt32(values[j]);
        //                            break;
        //                        case FieldType.DateAttribute:
        //                            drow[j] = Convert.ToDateTime(values[j]);
        //                            break;
        //                        case FieldType.KeyFigure:
        //                            drow[j] = Convert.ToDouble(values[j]);
        //                            break;
        //                    }
        //                }
        //                dtable.Rows.Add(drow);
        //            }   // if
        //        }   // while

        //        // return DataTable
        //        return dtable;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception("FQ_DataTable_Extensions.FQ_ImportFromCSVfile: \n" + ex.Message);
        //    }

        //}

        // import/export DataTable from/to Excel
        // These excluded methods can work only if you have the required MS excel libraries on your computer
        // How to enable:
        // 1) Add following references to project OpenSource in Visual Studio: 
        // - Microsoft Office XX Object Library
        // - Microsoft Excel XX Object Library
        // 2) uncomment "using Excel = Microsoft.Office.Interop.Excel;" at the top
        public static void ExportToExcelFile(this DataTable Tbl, string ExcelFilePath = null)
        {
            try
            {
                if (Tbl == null || Tbl.Columns.Count == 0)
                    throw new Exception("OS_ExportToExcelFile: Null or empty input table!\n");

                using (Stream stream = File.Create(ExcelFilePath))
                {
                    try
                    {
                        StreamWriter wr = new StreamWriter(stream);
                        for (int i = 0; i < Tbl.Columns.Count; i++)
                        {
                            wr.Write(Tbl.Columns[i].ToString().ToUpper() + "\t");
                        }

                        wr.WriteLine();

                        //write rows to excel file
                        for (int i = 0; i < (Tbl.Rows.Count); i++)
                        {
                            for (int j = 0; j < Tbl.Columns.Count; j++)
                            {
                                if (Tbl.Rows[i][j] != null)
                                {
                                    wr.Write(Convert.ToString(Tbl.Rows[i][j]) + "\t");
                                }
                                else
                                {
                                    wr.Write("\t");
                                }
                            }
                            //go to next line
                            wr.WriteLine();
                        }
                        //close file
                        wr.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }

                    // check fielpath
                    if (ExcelFilePath != null && ExcelFilePath != "")
                    {
                        try
                        {

                        }
                        catch (Exception ex)
                        {
                            throw new Exception("OS_ExportToExcelFile: Excel file could not be saved.\n"
                                + ex.Message);
                        }
                    }
                    else    // no filepath is given
                    {

                    }

                }
                // load excel, and create a new workbook
            
                // format worksheet (AutoFormat?)
                // workSheet.UsedRange
                
            }
            catch (Exception ex)
            {
                throw new Exception("OS_ExportToExcelFile: " + ex.Message);
            }
        }
        //public static void ExportToExcelFile(this DataTable Tbl, string ExcelFilePath = null)
        //{
        //    try
        //    {
        //        if (Tbl == null || Tbl.Columns.Count == 0)
        //            throw new Exception("OS_ExportToExcelFile: Null or empty input table!\n");

        //        // load excel, and create a new workbook
        //        Microsoft.Office.Interop.Excel.Application excelApp = new  Microsoft.Office.Interop.Excel.Application();
        //        excelApp.Workbooks.Add();

        //        // single worksheet
        //        Microsoft.Office.Interop.Excel._Worksheet workSheet = excelApp.ActiveSheet;

        //        // column headings
        //        for (int i = 0; i < Tbl.Columns.Count; i++)
        //        {
        //            workSheet.Cells[1, (i + 1)] = Tbl.Columns[i].ColumnName;
        //        }

        //        // rows
        //        for (int i = 0; i < Tbl.Rows.Count; i++)
        //        {
        //            // to do: format datetime values before printing
        //            for (int j = 0; j < Tbl.Columns.Count; j++)
        //            {
        //                workSheet.Cells[(i + 2), (j + 1)] = Tbl.Rows[i][j];
        //            }
        //        }
        //        XLWorkbook
        //        // format worksheet (AutoFormat?)
        //        // workSheet.UsedRange


        //        // check fielpath
        //        if (ExcelFilePath != null && ExcelFilePath != "")
        //        {
        //            try
        //            {
        //                workSheet.SaveAs(ExcelFilePath);
        //                excelApp.Quit();
        //                //MessageBox.Show("Excel file saved!");
        //            }
        //            catch (Exception ex)
        //            {
        //                throw new Exception("OS_ExportToExcelFile: Excel file could not be saved.\n"
        //                    + ex.Message);
        //            }
        //        }
        //        else    // no filepath is given
        //        {
        //            excelApp.Visible = true;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception("OS_ExportToExcelFile: " + ex.Message);
        //    }
        //}

        /// <summary>
        /// Read DataTable from a sheet of excel file.
        /// Header line in excel sheet must contain field names.
        /// </summary>
        /// <param name="Tbl">DataTable input</param>
        /// <param name="Filepath">A valid file path like  @"C:\Users\John\Documents\Inventory.xlsx</param>
        /// <param name="SheetName">Name of excel sheet</param>
        public static DataTable ImportFromExcelFile(this DataTable Tbl, string Filepath, string SheetName)
        {
            try
            {
                var connectionString = string.Format("Provider=Microsoft.Jet.OLEDB.4.0; data source={0}; Extended Properties=Excel 8.0;", Filepath);
                var adapter = new OleDbDataAdapter("SELECT * FROM [" + SheetName + "$]", connectionString);

                var TblOut = new DataTable();
                adapter.FillSchema(TblOut, SchemaType.Source);
                // column types can be adjusted here before fill
                adapter.Fill(TblOut);
                return TblOut;
            }
            catch (Exception ex)
            {
                throw new Exception("OS_ImportFromExcelFile: Could not read table from excel file!\n" + ex.Message + "\n");
            }
        }

    }
}