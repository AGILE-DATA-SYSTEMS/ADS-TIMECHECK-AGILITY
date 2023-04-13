using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;

namespace TAMSR2.Details
{
    public partial class UploadTransactions : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.ToLower().IndexOf("details/uploadtransactions.aspx"));
            if (Session["ID"] + "" == "")
                Response.Redirect(path + "Login.aspx");
            SetCultureValues();
            //if (Numerics.GetBool(Session["CanAdd"]) == false)
            //    spnAddButton.Visible = false;
        }
    }
}