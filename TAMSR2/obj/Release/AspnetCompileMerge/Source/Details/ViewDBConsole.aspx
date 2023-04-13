<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewDBConsole.aspx.cs" Inherits="TAMSR2.Details.ViewDBConsole" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SQL Server Query Editor</title>
    <style type="text/css">
        #divQuery {
            clear: both;
            padding: 10px;
            width: 98%;
            height: 170px;
        }
        #divResult {
            clear: both;
            padding: 10px;
            width: 98%;
        }
        .Editor {
            width: 100%;
            height: 150px;
        }
        .Grid {
            margin-top: 10px;
            width: 100%;
            font-family: Calibri;
            font-size: 14px;
        }
        th {
            background-color: #CCC;
        }
        th a {
            text-decoration: none;
            color: black;
        }
        #divButtons {
            padding: 10px;
            float: right;
        }
        #divFooter {
            clear: both;
            margin-top: 10px;
            text-align:center;
            width: 100%;
            height: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divMain">
        <div id="divQuery">
            <asp:TextBox ID="txtQuery" runat="server" TextMode="MultiLine" CssClass="Editor" ></asp:TextBox>
        </div>
        <div id="divButtons" >
            <asp:Button ID="btnExecute" runat="server" Text="Execute" OnClick="btnExecute_Click" />
            <span style="width: 50px">&nbsp;</span>
            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
            <span style="width: 50px">&nbsp;</span>
            <asp:Button ID="btnBack" runat="server" Text="Go to Home" OnClick="btnBack_Click" />
        </div>
        <div id="divResult">
            <asp:GridView ID="dgvResult" runat="server" CssClass="Grid" AllowPaging="true" AllowSorting="true" EmptyDataText="No results found" PageSize="20" OnPageIndexChanging="dgvResult_PageIndexChanging">

            </asp:GridView>
        </div>
    </div>
        <div id="divFooter">
            © 2013 Future Trends Establishment. 
        </div>
    </form>
</body>
</html>
