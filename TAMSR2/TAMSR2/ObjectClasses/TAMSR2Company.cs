using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class TAMSR2Company : BaseClass
    {
        public string Prefix { get; set; }
        
        public string DbType { get; set; }
        public string DbName { get; set; }
        public string DbUser { get; set; }
        public string DbPassword { get; set; }

        public string PrimaryLicenseKey { get; set; }
        public string SecondaryLicenseKey { get; set; }
        public decimal LicenceID { get; set; }
        public DateTime StartDate { get; set; }
        public bool IsActive { get; set; }
        
        public string Logo { get; set; }

        public TAMSR2Company()
        {
        }

        public TAMSR2Company(decimal id)
        {
            Logo = null;

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getByID");
                ht.Add("ID", id);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CompanyOps", ht);

                if (dv != null)
                {
                    ID = id;
                    NameEn = dv[0]["NameEn"] + "";
                    NameAr = dv[0]["NameAr"] + "";
                    DescriptionEn = dv[0]["DescriptionEn"] + "";
                    DescriptionAr = dv[0]["DescriptionAr"] + "";
                    PrimaryLicenseKey = dv[0]["PrimaryLicenseKey"] + "";
                    SecondaryLicenseKey = dv[0]["SecondaryLicenseKey"] + "";
                    StartDate = Numerics.GetDateTime(dv[0]["StartDate"] + "");

                    DbType = dv[0]["DbType"] + "";
                    DbName = dv[0]["DbName"] + "";
                    DbUser = dv[0]["DbUser"] + "";
                    DbPassword = dv[0]["DbPassword"] + "";

                    Logo = dv[0]["Logo"] + "";
                    
                    IsActive = Numerics.GetBool(dv[0]["IsActive"] + "");
                    CreatedOn = Numerics.GetDateTime(dv[0]["CreatedOn"] + "");
                    CreatedBy = Numerics.GetDecimal(dv[0]["CreatedBy"] + "");
                    UpdatedOn = Numerics.GetDateTime(dv[0]["UpdatedOn"] + "");
                    UpdatedBy = Numerics.GetDecimal(dv[0]["UpdatedBy"] + "");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
        }

        public TAMSR2Company(string code)
        {
            Logo = null;

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection();
                Hashtable ht = new Hashtable();
                ht.Add("action", "getByCode");
                ht.Add("code", code);
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_CompanyOps", ht);

                if (dv != null)
                {
                    ID = Numerics.GetDecimal(dv[0]["ID"] + ""); ;
                    Code = dv[0]["Code"] + "";
                    NameEn = dv[0]["NameEn"] + "";
                    NameAr = dv[0]["NameAr"] + "";
                    DescriptionEn = dv[0]["DescriptionEn"] + "";
                    DescriptionAr = dv[0]["DescriptionAr"] + "";

                    PrimaryLicenseKey = dv[0]["PrimaryLicenseKey"] + "";
                    SecondaryLicenseKey = dv[0]["SecondaryLicenseKey"] + "";

                    StartDate = Numerics.GetDateTime(dv[0]["StartDate"] + "");

                    DbType = dv[0]["DbType"] + "";
                    DbName = dv[0]["DbName"] + "";
                    DbUser = dv[0]["DbUser"] + "";
                    DbPassword = dv[0]["DbPassword"] + "";

                    Logo = dv[0]["Logo"] + "";

                    IsActive = Numerics.GetBool(dv[0]["IsActive"] + "");
                    CreatedOn = Numerics.GetDateTime(dv[0]["CreatedOn"] + "");
                    CreatedBy = Numerics.GetDecimal(dv[0]["CreatedBy"] + "");
                    UpdatedOn = Numerics.GetDateTime(dv[0]["UpdatedOn"] + "");
                    UpdatedBy = Numerics.GetDecimal(dv[0]["UpdatedBy"] + "");
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
        }

        public string UpdateLogo(TAMSR2Company obj, decimal updatedBy)
        {            
            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            string result = "0";
            try
            {
                objDAL.OpenConnection();
                Hashtable ht = new Hashtable();
                ht.Add("action", "save");
                ht.Add("ID", obj.ID);
                ht.Add("nameEn", obj.NameEn);
                ht.Add("nameAr", obj.NameAr);
                ht.Add("PrimaryLicenseKey", obj.PrimaryLicenseKey);
                ht.Add("SecondaryLicenseKey", obj.SecondaryLicenseKey);
                ht.Add("startDate", obj.StartDate.ToString("yyyy-MM-dd HH:mm:ss"));

                ht.Add("dbType", obj.DbType);
                ht.Add("dbName", obj.DbName);
                ht.Add("dbUser", obj.DbUser);
                ht.Add("dbPassword", obj.DbPassword);

                ht.Add("descriptionEn", obj.DescriptionEn);
                ht.Add("descriptionAr", obj.DescriptionAr);
                           
                ht.Add("logo", obj.Logo);

                ht.Add("IsActive", obj.IsActive);
                ht.Add("updatedOn", DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).ToString("yyyy-MM-dd HH:mm:ss"));
                ht.Add("updatedBy", updatedBy + "");

                objDAL.OpenConnection();
                result = objDAL.Connection.GetValueProcedure("TAMSR2_CompanyOps", ht);
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }
            return result;
        }
    }
}