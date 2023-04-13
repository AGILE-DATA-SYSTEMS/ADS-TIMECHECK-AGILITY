using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.Details
{
    public partial class SaveTAEvent : BasePage
    {
        public string allowAttachment { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
             allowAttachment = ConfigurationManager.AppSettings["AllowEmployeeMovementAttachments"];

            url = Request.Url.AbsoluteUri;
            path = url.Substring(0, url.ToLower().IndexOf("details/savetaevent.aspx"));
            if (Session["ID"] + "" == "")
                Response.Redirect(path + "Login.aspx");
            SetCultureValues();
            //if (Numerics.GetBool(Session["CanAdd"]) == false)
            //    spnAddButton.Visible = false;
        }
    }
}