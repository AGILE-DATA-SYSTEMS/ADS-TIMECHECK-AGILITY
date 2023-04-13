<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestImport.aspx.cs" Inherits="TAMSR2.Details.TestImport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="main">
                <div class="post">
                    <h3 id='headingData'>&nbsp</h3>


                    <div style='width: 100%;'>
                        <table style='width: 500px; padding-bottom: 20px;'>
                            <tr>
                                <th class='lblClass'>Import</th>
                                <td style='width: 200px;'>
                                    <asp:FileUpload ID="fileUploadControl" runat="server" />
                                </td>
                                <td>
                                    <asp:Button ID="btnImport" runat="server" CssClass='btn-more'
                                        Text="Show Data" style="padding: 0px 10px;"  OnClick="btnImport_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnSaveData" runat="server" CssClass='btn-more'
                                        Text="Save Data" style="padding: 0px 10px;" OnClick="btnSaveData_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id='divGrid'>
                        <div id='divData'>
                            <asp:GridView ID="dgvImport" Width="100%" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView>
                            
                        </div>

                    </div>
                </div>
                <div class="cl">&nbsp;</div>
                <div id='inline' style='display: none;'>
                    <div id='divForm' style='height: 400px; overflow: scroll;'>
                        &nbsp;
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
