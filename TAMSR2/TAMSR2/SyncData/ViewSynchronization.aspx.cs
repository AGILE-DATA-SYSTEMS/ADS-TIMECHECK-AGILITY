using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;

namespace TAMSR2.SyncData
{
    public partial class ViewSynchronization : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("viewsynchronization.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("syncdata/viewsynchronization.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("synchronization/data-synchronization"));

        }
    }
}