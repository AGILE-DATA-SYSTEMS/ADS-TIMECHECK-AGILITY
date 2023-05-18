<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RosterReport.aspx.cs" Inherits="TAMSR2.Reports.RosterReport1" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=Resources.Resource.monthlyRoster %> - <%=Resources.Resource.applicationName %></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false"  />
    </div>
    </form>
</body>
</html>
