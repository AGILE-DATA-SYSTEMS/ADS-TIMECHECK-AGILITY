/* **************************************************************
* File Name         : TAMSR2User.cs
* Description       : Properties of TAMSR2User according to TAMSR2_USERS Table for Root access
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
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class TAMSR2User : BaseClass
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public decimal CompanyID { get; set; }
        public string Email { get; set; }
        public bool CanView { get; set; }
        public bool CanAdd { get; set; }
        public bool CanUpdate { get; set; }
        public bool CanDelete { get; set; }
        public bool IsActive { get; set; }

    }
}