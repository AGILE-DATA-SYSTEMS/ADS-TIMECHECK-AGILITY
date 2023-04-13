<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConsoleLogin.aspx.cs" Inherits="TAMSR2.Admin.ConsoleLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding: 50px; margin-left: 100px;">
        <table>
            <tr>
                <th>
                    <asp:Label ID="lblUser" runat="server" Text="Username"></asp:Label>
                </th>
                <td>
                    <asp:TextBox ID="txtUser" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                </th>
                <td>
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnLogin" runat="server" Text="Proceed" OnClick="btnLogin_Click" />
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
