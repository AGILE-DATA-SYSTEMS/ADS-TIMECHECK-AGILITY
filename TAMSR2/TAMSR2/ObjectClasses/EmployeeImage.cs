using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class EmployeeImage : BaseClass
    {
        public decimal EmployeeID { get; set; }
        public byte[] ProfileImage { get; set; }
        public string Ext { get; set; }

        public EmployeeImage()
        {
            ProfileImage = null;
        }

        public decimal Save(EmployeeImage obj, string constr)
        {
            decimal id = -1;
            SqlConnection conString = new SqlConnection(constr);
            try
            {
                string query = "";
                SqlCommand command;
                query = @"if(not exists(select 1 from employee_images where employee_id=@employeeID)) 
                            begin
	                            insert into employee_images values(@employeeID, @ProfileImage, @Ext, @UpdatedBy, @UpdatedOn, @CreatedBy, @CreatedOn)
                                ; SELECT @@IDENTITY
                            end
                            else
                            begin
	                            update employee_images set Image=@ProfileImage, Ext=@Ext, updated_id=@UpdatedBy, updated_date=@UpdatedOn where employee_id=@employeeID
                                ; SELECT @@IDENTITY
                            end";

                command = new SqlCommand(query, conString);
                command.Parameters.Add("@employeeID", SqlDbType.Decimal).Value = obj.EmployeeID;
                command.Parameters.Add("@ProfileImage", SqlDbType.Binary).Value = obj.ProfileImage;
                command.Parameters.Add("@Ext", SqlDbType.NVarChar).Value = obj.Ext;
                command.Parameters.Add("@CreatedBy", SqlDbType.Decimal).Value = obj.CreatedBy;
                command.Parameters.Add("@CreatedOn", SqlDbType.DateTime2).Value = obj.CreatedOn;
                command.Parameters.Add("@UpdatedBy", SqlDbType.Decimal).Value = obj.UpdatedBy;
                command.Parameters.Add("@UpdatedOn", SqlDbType.DateTime2).Value = obj.UpdatedOn;

                if (conString.State == System.Data.ConnectionState.Closed)
                    conString.Open();
                id = Numerics.GetDecimal(command.ExecuteScalar());
            }
            catch (Exception ex)
            {
                id = -1;
            }
            finally
            {
                if (conString.State == System.Data.ConnectionState.Open)
                    conString.Close();
            }
            return id;
        }


        public EmployeeImage GetImageByEmployeeID(decimal employeeID, string connectionString)
        {
            EmployeeImage tempObj = new EmployeeImage();
            decimal id = -1;
            SqlConnection conString = new SqlConnection(connectionString);
            try
            {
                string query = "";
                SqlCommand command;
                query = @"select * from employee_images where employee_id=@employeeID";

                command = new SqlCommand(query, conString);
                command.Parameters.Add("@employeeID", SqlDbType.Decimal).Value = employeeID;

                if (conString.State == System.Data.ConnectionState.Closed)
                    conString.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    tempObj.EmployeeID = employeeID;
                    tempObj.ProfileImage = Numerics.GetByteArray(reader["Image"]);
                    tempObj.Ext = reader["Ext"] + "";

                }
            }
            catch (Exception ex)
            {
                id = -1;
            }
            finally
            {
                if (conString.State == System.Data.ConnectionState.Open)
                    conString.Close();
            }
            return tempObj;
        }
        
    }
}