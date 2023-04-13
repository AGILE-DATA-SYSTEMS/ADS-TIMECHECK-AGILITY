<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStandardRptPage.aspx.cs" Inherits="TAMSR2.Reports.ViewStandardRptPage" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <%-- <style type="text/css" media="print"> * { display: none; } </style>--%>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" ToolPanelView="None" />
        </div>
    </form>
</body>
</html>
