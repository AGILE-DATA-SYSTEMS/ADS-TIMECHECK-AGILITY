/* **************************************************************
 * File Name        : TAMSR2PrivilegeName.cs
 * Description      : Base class for Privileges
 * 
 * Author		    : Muhammad Aqeel Abbas @linktoaqeel
 * Created		    : May 22, 2013
 * Dependency	    : 
 * 
 * Revision History :
 * 
 * 
 * *************************************************************/

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TAMSR2Framework
{
    /// <summary>
    /// NeSTTechPrivilegeName - Base class for Privilege classes
    /// </summary>
    public class NeSTTechPrivilegeName : TAMSR2Data
    {
        #region private members and methods
        public NeSTTechPrivilegeName()
        {
        }
        #endregion

        #region protected methods
        // Get the id of the given privilege
        protected static int GetId(string privName)
        {
            int idPrivilege;
            TAMSR2Data objNeSTTechData = new TAMSR2Data();
            string strQuery;
            strQuery = "SELECT privilege_id FROM sec_privileges " +
                        "WHERE privilege_name  = '" + privName + "'";

            //Dataview to return the query
            DataView objDataview;

            try
            {
                objNeSTTechData.OpenConnection();
                objDataview = objNeSTTechData.Connection.ExecuteQuery(strQuery);
                if (objDataview.Count != 1)
                {
                    throw new TAMSR2Exception("Getting Privilege failed because query returned " + objDataview.Count.ToString() + " records");
                }
                idPrivilege = Convert.ToInt32(objDataview[0]["privilege_id"].ToString());
            }
            catch (Exception e)
            {
                throw new TAMSR2Exception("NeSTTechPrivilegeName.GetId() Failed", e);
            }
            finally
            {
                objNeSTTechData.CloseConnection();
            }
            return idPrivilege;
        }
        #endregion

    }
}
