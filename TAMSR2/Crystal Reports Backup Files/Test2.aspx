<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test2.aspx.cs" Inherits="TAMSR2.Test2" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title></title>
    <link href="Styles/ajaxfileupload.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Scripts/jquery.js"></script>
    <script type="text/javascript" src="Scripts/ajaxfileupload.js"></script>
    <script type="text/javascript">
        function ajaxFileUpload() {
            var desc = $("#txtDesc").val();
            $("#loading")
           .ajaxStart(function () {
               //$(this).show();
           })
           .ajaxComplete(function () {
               //$(this).hide();
           });

            $.ajaxFileUpload({
                url: 'Handlers/AjaxFileUpload.ashx?desc=' + desc,
                secureuri: false,
                fileElementId: 'fileToUpload',
                dataType: 'json',
                data: { name: 'logan', id: 'id' },
                success: function (data, status) {
                    if (typeof (data.error) != 'undefined') {
                        if (data.error != '') {
                            alert(data.error);
                        } else {
                            alert(data.msg);
                        }
                    }
                },
                error: function (data, status, e) {
                    alert(e);
                }
            })
            return false;
        }
</script>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div>
        <table>
            <tr>
                <td>
                    Description
                </td>
                <td>
                    <input type="text" id="txtDesc" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input id="fileToUpload" type="file" size="45" name="fileToUpload" class="input" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    <button id="buttonUpload" onclick="return ajaxFileUpload();">
                        Upload</button>
                    <img id="loading" src="../loading.gif" style="display: none;">
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
