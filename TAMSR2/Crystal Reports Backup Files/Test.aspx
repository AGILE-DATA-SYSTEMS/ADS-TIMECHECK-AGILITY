<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="TAMSR2.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
                url: 'Handler/AjaxFileUpload.ashx?desc=' + desc,
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
</head>
<body>
    <form id="form1" runat="server">
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
                    <img id="loading" src="images/loading.gif" style="display: none;">
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
