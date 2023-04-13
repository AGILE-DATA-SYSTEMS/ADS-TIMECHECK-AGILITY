﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2Framework.DAL;

namespace TAMSR2.RequestPages
{
    public partial class DownloadPage : System.Web.UI.Page
    {

        string url = "";
        string path = "";
        string languagePostfix = "";
        HttpCookie cookie;
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
          

            cookie = Request.Cookies["tamsCulture"];
            if (cookie == null)
            {
                cookie = new HttpCookie("tamsCulture");
                cookie.Values.Add("pullDirection", AppSetting.defaultPullDirection + "");
                cookie.Values.Add("language", AppSetting.defaultLanguage + "");
                cookie.Values.Add("culture", AppSetting.defaultCulture + "");
                cookie.Values.Add("timeZone", AppSetting.defaultTimeZone + "");
                cookie.Values.Add("dateFormat", AppSetting.dateFormat + "");
                cookie.Values.Add("dateTimeFormat", AppSetting.dateTimeFormat + "");
                DateTime dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(7);
                cookie.Expires = dt;
                Response.Cookies.Add(cookie);
            }

            Page.UICulture = cookie.Values["culture"] + "";
            Page.Culture = cookie.Values["culture"] + "";


            if (cookie.Values["language"] + "" == "ar")
                languagePostfix = "_arb";
            else
                languagePostfix = "_eng";
            if (Session["ID"] + "" == "")
            {
                Response.Redirect(path + "Login.aspx");
            }
            else if (Request["key"] + "" == "export")
            {
                string Path = Request["Path"] + "";

                if (!string.IsNullOrEmpty(Path))
                {
                    try
                    {
                        Path = Encryption.Decrypt(Path);
                        DownloadClass downloadClass = new DownloadClass();
                        downloadClass.DownloadFile(Context, Path);
                    }
                    catch (Exception ex)
                    {

                    }

                }
            }
        }
    }
}