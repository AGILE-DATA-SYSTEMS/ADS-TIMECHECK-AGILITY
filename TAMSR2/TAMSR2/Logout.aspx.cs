using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;

namespace TAMSR2
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string companyCode = Session["companyCode"] + "";
            try
            {
                Session["ID"] = "";
                Session["userID"] = "";
                Session["UserPassword"] = "";
                Session["Username"] = "";
                Session["companyID"] = "";
                Session["orgID"] = "";
                Session["dbType"] = "";
                Session["dbName"] = "";
                Session["dbUser"] = "";
                Session["dbPassword"] = "";
                Session["chkPrivileges"] = "";
                Session.Clear();
                Session.Abandon();

                HttpCookie cookie = Request.Cookies["TAMSR2"];
                if (cookie != null && companyCode == "")
                {
                    companyCode = Encryption.Decrypt_AES(cookie.Values["companyCode"] + "");
                }

                Response.Redirect("Login/" + companyCode);
            }
            catch (Exception ex)
            {
                Response.Redirect("Login/" + companyCode);
            }
        }
    }
}