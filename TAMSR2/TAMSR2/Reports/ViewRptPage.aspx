<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewRptPage.aspx.cs" Inherits="TAMSR2.Reports.ViewRptPage" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=Resources.Resource.report %> - <%=Resources.Resource.applicationName %></title>
    
   <script src="../assets/<%= languageStr %>/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
    <script src="../assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="../assets/<%= languageStr %>/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.css" rel="stylesheet" ></script> 
    <script type="text/javascript">

        $(document).ready(function () {
            //alert(typeof String.prototype.trim);
            if (typeof String.prototype.trim != 'function') {
                String.prototype.trim = function () {
                    return this.replace(/^\s+|\s+$/g, '');
                }
            }
        });

        $(document).ready(function () {
           ;
            var btn = document.getElementById("IconImg_CrystalReportViewer1_toptoolbar_print");
            var div = $('#IconImg_CrystalReportViewer1_toptoolbar_print').parent();
            $("#CrystalReportViewer1_toptoolbar_print").parent().html("<span onclick='return PrintReport();'><b>Print</b></span>");
         //   alert(btn);
            
            
        });
        
        function PrintReport() {
            $("#btnRptPrint").click();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnRptPrint" runat="server" Text="Button" style="display: none;" OnClick="btnRptPrint_Click" />
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" ToolPanelView="None" />
    </div>
    </form>
</body>
</html>
