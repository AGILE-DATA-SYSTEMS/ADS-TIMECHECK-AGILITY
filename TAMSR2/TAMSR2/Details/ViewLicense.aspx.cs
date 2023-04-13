using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;

namespace TAMSR2.Details
{
    public partial class ViewLicense : BasePage
    {
        public string MachineID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewlicense.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/viewlicense.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("license/view-license"));

            MachineID = TAMSR2.ObjectClasses.TAMSR2Licence.CPUID();

        }
    }
}