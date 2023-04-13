<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewRptRosterView.aspx.cs" Inherits="TAMSR2.Reports.ViewRptRosterView" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=Resources.Resource.monthlyRoster %> - <%=Resources.Resource.applicationName %></title>
    <script src="../Scripts/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">

        //$("#IconImg_CrystalReportViewer1_toptoolbar_print").click(function () {
        //    alert("print button clicked");
        //});

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" ToolPanelView="None" />
    </div>
    </form>
</body>
</html>
