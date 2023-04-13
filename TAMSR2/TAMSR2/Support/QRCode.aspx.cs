using QRCoder;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;

namespace TAMSR2.Support
{
    public partial class QRCode : BasePage
    {
        public string MachineID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.Url.AbsoluteUri;
            if (url.ToLower().Contains("qrcode.aspx"))
                path = url.Substring(0, url.ToLower().IndexOf("support/qrcode.aspx"));
            else
                path = url.Substring(0, url.ToLower().IndexOf("support/qr-code"));

            QRCodeGeneration();

        }



        public void QRCodeGeneration()
        {
            var link = new DBAppSetting().GetTimecheckMobileUrl(Session["ID"] + "", Connection.GetUserConnectionStrinng());//"http://api.agiledataint.com:90";
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(link, QRCodeGenerator.ECCLevel.Q);
            System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            imgBarCode.Height = 250;
            imgBarCode.Width = 250;
            using (Bitmap bitMap = qrCode.GetGraphic(20))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();
                    imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                }
                PlaceHolder1.Controls.Add(imgBarCode);
            }
        }
    }
}