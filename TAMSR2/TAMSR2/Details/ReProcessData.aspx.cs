using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework;

namespace TAMSR2.Details
{
    public partial class ReProcessData : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("reprocessdata.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("details/reprocessdata.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("security/reprocess-data"));

        }
    }
}