
var AdvanceFilters = function () {

    function LoadDepartments() {
        var d = "key=GetDepartmentIdNameList";

        $.ajax({
            type: 'POST',
            data: d,
            url: '../../../RequestPages/OrgPage.aspx',
            success: function (html) {
                $("#ddDept").html(html);
                $("#ddDept").trigger("liszt:updated");
                //  LoadEmployees();
                // LoadGrid();
            },
            error: function (html) {
                $("#divErrorMsg").css("display", "block");
                //$("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
            }
        });
    }

    function LoadSections() {
        var d = "key=GetSectionIdNameList";

        $.ajax({
            type: 'POST',
            data: d,
            url: '../../../RequestPages/OrgPage.aspx',
            success: function (html) {
                $("#ddSec").html(html);
                $("#ddSec").trigger("liszt:updated");
                //  LoadEmployees();
                // LoadGrid();
            },
            error: function (html) {
                $("#divErrorMsg").css("display", "block");
                //$("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
            }
        });
    }
    function LoadOrganizationsByParentID() {
        $("#divErrorMsg").css("display", "none");
        $("#spnSuccessMsg").css("display", "none");

        var ParentID = $("[name='Dept']").val();

        if (ParentID != "0")
            d = "key=getOrgByParentId&ID=" + ParentID;
        else
            d = "key=GetIdNameListStringSection"
        var URL
        //  alert(d);
        $.ajax({
            type: 'POST',
            data: d,
            url: '../../../RequestPages/OrgPage.aspx',
            success: function (html) {
                //alert(html);
                $("[name='Sec']").html(html)
                $("[name='Sec']").trigger("liszt:updated");
                LoadEmployees();
            },
            error: function (html) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").css("display", "block");
                //$("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                //     $("#form_sample_1").unmask();
            }
        });
    }
    function LoadEmployees () {
        $("#divErrorMsg").css("display", "none");
        $("#spnSuccessMsg").css("display", "none");

        //alert('LoadE');
        var orgVal = $("[name='Sec']").val();
        var ParentID = $("[name='Dept']").val();

        if (orgVal == "")
            orgVal = "0";

        if (ParentID == "")
            ParentID = "0";


        if (orgVal == "0" && ParentID != "0" && ParentID != undefined && orgVal != undefined)
            d = "key=getEmpNameListByBUID&ParentID=" + ParentID;
        else
            if (orgVal != "0" && ParentID == "0" && ParentID != undefined && orgVal != undefined)
                d = "key=getEmpNameListByBUID&orgID=" + orgVal;
            else
                if (orgVal != "0" && ParentID != "0" && ParentID != undefined && orgVal != undefined)
                    d = "key=getEmpNameListByBUID&ParentID=" + ParentID + "&OrgID=" + orgVal
                else
                    d = "key=getIdNameListString"

        $.ajax({
            type: 'POST',
            data: d,
            url: '../../../RequestPages/EmployeePage.aspx',
            success: function (html) {
                //alert(html);
                //      $("#form_sample_1").unmask();
                // document.getElementsByName("ddemp").html = html;
                // document.getElementByName("ddemp").innerHTML = html;
                $("[name='Emp']").html(html)
                $("[name='Emp']").trigger("liszt:updated");
            },
            error: function (html) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").css("display", "block");
                //$("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                //     $("#form_sample_1").unmask();
            }
        });
    }

    return {

        //main function to initiate template pages
        init: function () {
            LoadDepartments();
            LoadSections();
            LoadEmployees();
            
        }
            
    }
    return {
        vloadEmployee: function () {
            LoadEmployees()
        }
    }

    
}();