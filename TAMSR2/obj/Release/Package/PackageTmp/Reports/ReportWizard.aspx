<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportWizard.aspx.cs" Inherits="TAMSR2.Reports.ReportWizard1" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.reportWizard %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <%--<link href="../Assets/<%= languageStr %>/Styles/jquery.loadmask.css" rel="stylesheet" />--%>
    <link href='../Assets/<%= languageStr %>/css/pages/login.css' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../Assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.css" />

    <%--<script type="text/javascript" src="../Assets/<%= languageStr %>plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>--%>

    <script type="text/javascript" src="../Assets/<%= languageStr %>/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
    <!-- END PAGE LEVEL STYLES -->

    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-fileupload/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/select2/select2_metro.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.css" />

    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-toggle-buttons/static/stylesheets/bootstrap-toggle-buttons.css" />

    
    <script src="../assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(".*").css("font-size", "16");
        $(document).ready(function () {
            //alert(typeof String.prototype.trim);
            if (typeof String.prototype.trim != 'function') {
                String.prototype.trim = function () {
                    return this.replace(/^\s+|\s+$/g, '');
                }
            }
        });

        function GenerateReport(btnID) {
            
            $("#form_wizard_1").attr("disabled", "disabled");
            $("#btnViewReport").attr("disabled", "disabled");
            $("#btnExcelDownload").attr("disabled", "disabled");
            $("#btnWordDownload").attr("disabled", "disabled");
            //$("#btnBack").attr("disabled", "disabled");
            $("#form_wizard_1").css("cursor", "wait");
            var FilVAl = '';
            var Filters = '';
            var Itrate = true;
            var i = 1;
            //alert($("#selTemplate option:selected", this).attr("ObjType"));
            var objType = $("#selTemplate").find(':selected').attr('objType');
           
            var GroupId = $('#selEmployeeGroup option:selected').val();
            if (GroupId == undefined)
                GroupId = ''

            var OriginalValue;
            var k = 1;
            while (Itrate == true) {
                //    alert('In');
                var Txtvalue;
                var LblValue = $('#lbl' + i).html();
                var OpValue = $('#lblOp' + i).html();
                //  alert($('#hid' + i).val());
                if ($('#hid' + i).val() != null) {
                    OriginalValue = $('#hid' + i).val().toLowerCase();
                }
                else {
                    //alert(OriginalValue + "=" + k);
                    break;
                }
                //    alert(OriginalValue);

                if (OriginalValue.indexOf("date") > 0 && OriginalValue.toLowerCase() != '') {
                    //      alert('Im here ');
                    //s.split("").reverse().join("")
                    var str1 = $('#txtDate' + k).val();
                    
                    var dt1 = str1.substring(0, 2);
                    var mon1 = str1.substring(2, 4);
                    var yr1 = str1.substring(4, 8);
                    Txtvalue = yr1 + "-" + mon1 + "-" + dt1;
                    //  alert(Txtvalue);
                    k++;
                }
                else {
                    //   alert('DDDD');
                    Txtvalue = $('#txt' + i).val();
                }
                //  alert(Txtvalue);
                //alert($('#lbl1').html());

                //alert(Txtvalue);
                if (Txtvalue == "" || Txtvalue == '0' || Txtvalue == null) {
                    // alert('m here :)');
                    Txtvalue = "";

                }
                debugger
                var logicalOp = $('#sel' + i + ' option:selected').val();
                if (Txtvalue != undefined & LblValue != "" & LblValue != undefined) {
                    var op = OpValue.replace('&gt;', '>');
                    var op = op.replace('&lt;', '<');
                    op = op.trim();
                    //alert($('#hid' + i).val().trim());
                    if (op == "LIKE" || op == "like") {
                        if ($('#hid' + i).val().trim() == "Organization_Code" && Txtvalue != "" && Txtvalue != "null" && "<%= Session["rptOrgDrillDown"] + "" %>" == "YES") {
                            Filters = Filters + "(" + OriginalValue + "  " + "IN" + " ('" + Txtvalue + "') OR " + "parent_organization_code" + "  " + "IN" + " ('" + Txtvalue + "') )" + logicalOp + "  ";
                            FilVAl = FilVAl + LblValue + "#  " + op + "  #" + Txtvalue + "#";
                        }
                        else {
                            Filters = Filters + OriginalValue + "  " + op + " '#" + Txtvalue + "#' " + logicalOp + "  ";
                            FilVAl = FilVAl + LblValue + "#  " + op + "  #" + Txtvalue + "#";
                        }

                    }
                    else {
                        var op = OpValue.replace('&gt;', '>');
                        var op = op.replace('&lt;', '<');

                        if (logicalOp != undefined) {
                            // alert(Txtvalue);
                            if (Txtvalue.toUpperCase() == 'NULL' || Txtvalue == null) {
                                //  alert('if if');
                                Filters = Filters + OriginalValue + "  " + op + " " + Txtvalue + "   " + logicalOp + "   ";
                            }
                            else {
                                //   alert('if else ');
                                Filters = Filters + OriginalValue + "  " + op + " '" + Txtvalue + "'   " + logicalOp + "   ";
                            }
                            FilVAl = FilVAl + LblValue + "#  " + op + "  #" + Txtvalue + "#";
                        }
                        else {
                            if (Txtvalue.toUpperCase() == 'NULL' || Txtvalue == null) {
                                // alert('Else If');
                                Filters = Filters + OriginalValue + "  " + op + " " + Txtvalue + "   ";
                            }
                            else {
                                // alert('else else ');
                                Filters = Filters + OriginalValue + "  " + op + " '" + Txtvalue + "'   ";
                            }
                            FilVAl = FilVAl + LblValue + "#  " + op + "  #" + Txtvalue + "#";
                        }
                    }
                    i = i + 1;
                    //  alert(Filters);
                }
                else {
                    Itrate = false;
                }
                //     alert(Filters);
                // return;
                var v = "key=GenrateReport&Filters=" + Filters + "&FilVal=" + FilVAl + "&GroupID=" + GroupId +"&objType="+objType;
                // alert(Filters);
                //  alert(FilVAl);
                //  alert(v);

            }
            
            // alert(btnID);
            $.ajax({
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                type: "POST",
                data: v,
                success: function (msg) {
                    
                    $("#form_wizard_1").removeAttr("disabled");
                    $("#btnViewReport").removeAttr("disabled");
                    $("#btnExcelDownload").removeAttr("disabled");
                    $("#btnWordDownload").removeAttr("disabled");
                    //$("#btnBack").removeAttr("disabled");

                    $("#form_wizard_1").css("cursor", "pointer");
                    $(".tab-pane").css("cursor", "pointer");

                    if (btnID == 'btnViewReport') {
                        window.open('../Reports/ViewRptPage.aspx?key=ShowReport'  + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked"), '_blank', 'toolbar=0,scrollbars=1,location=0,menubar=0,resizable=yes');
                        //window.location.href = '../Reports/ViewRptPage.aspx?Key=ShowReport' + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked");
                    }
                    else if (btnID == 'btnExcelDownload') {
                        window.location.href = '../Reports/ViewRptPage.aspx?Key=Excel' + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked");
                    }

                    else if (btnID == 'btnWordDownload') {
                        window.location.href = '../Reports/ViewRptPage.aspx?Key=Word' + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked");
                    }
                    else if (btnID == 'btnPdfDownload') {
                        window.location.href = '../Reports/ViewRptPage.aspx?Key=Pdf' + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked");
                    }
                    // $(".tab-pane").css("cursor", "wait");
                    //$(".tab-pane").mask("<%=Resources.Resource.processing %>...");

                },
                Error: function (x, e) {
                    $("#form_wizard_1").removeAttr("disabled");
                    $("#btnViewReport").removeAttr("disabled");
                    $("#btnExcelDownload").removeAttr("disabled");
                    $("#btnWordDownload").removeAttr("disabled");
                    //$("#btnBack").attr("disabled", "");
                    $("#form_wizard_1").css("cursor", "pointer");
                    $(".tab-pane").css("cursor", "pointer");
                    $(".tab-pane").unmask();
                }

            });
        }

        function LoadTemplates(action) {
            if (action == "FilterValues") {
                var ID = $('#selTemplate option:selected').val();
                // alert(ID);
                var v = "key=GetAll&action=" + action + "&ID=" + ID + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked");
            }
            else if (action == "ApplyGroup") {
                var ID = $('#selTemplate option:selected').val();
                var v = "key=LoadGroups&ID=" + ID + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked");
            }
            else if (action == "GenrateReport") {

                var Filters = '';
                var Itrate = true;
                var i = 1;
              
                while (Itrate == true) {
                    //   alert("INSIDE THE WHILE LOOP  "  + i);
                    var Txtvalue = $('#txt' + i).val();
                    var LblValue = $('#lbl' + i).html();
                    var OpValue = $('#lblOp' + i).html();
                    var OriginalValue = $('#hid' + i).val();
                    //                       alert(OriginalValue);

                    //    alert(LblValue + "  " + OpValue + "  " + Txtvalue);
                    if (Txtvalue != "" & Txtvalue != undefined & LblValue != "" & LblValue != undefined) {
                        var op = OpValue.replace('&gt;', '>');
                        var op = op.replace('&lt;', '<');
                        //   alert(op.equal('LIKE'));
                        op.trim();
                        //  alert(op);
                        if (op == "LIKE") {
                            alert("OO");
                            Filters = Filters + OriginalValue + "  " + op + " % " + Txtvalue + " % " + ",";
                        }
                        else {
                            Filters = Filters + OriginalValue + "  " + op + " '" + Txtvalue + "'" + " ,";
                        }
                        alert(Filters);
                        i = i + 1;
                    }
                    else {
                        Itrate = false;
                    }

                    var v = "key=GetAll&action=" + action + "&Filters=" + Filters + "&GroupID=" + GroupID + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked");
                }
            }
            else {
                var v = "key=GetAll&action=" + action + "&includeInactive=" + $("#chkboxIncludeInActive").is(":checked");
            }

            var URL;
            if (action == "GenrateReport") {
                URL = '<%= Page.ResolveClientUrl("../RequestPages/ViewReport.aspx") %>'
            }
            else {
                URL = '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>'
            }
            //  alert(URL);
            $(".tab-pane").css("cursor", "wait");
            //$(".tab-pane").mask("<%=Resources.Resource.processing %>...");
            $.ajax({
                url: URL,
                type: "POST",
                data: v,
                success: function (msg) {
                    if (action == "getAllTemplate") {
                        $("#selTemplate").html(msg);
                        $("#selTemplate").trigger("liszt:updated");
                        $(".tab-pane").css("cursor", "pointer");
                        //$(".tab-pane").unmask();
                    }
                    else if (action == "FilterValues") {
                        // alert(msg);
                        $("#FilterValues").html(msg);
                        $(".tab-pane").css("cursor", "pointer");
                        FormComponents.init();
                        $('.date-picker').datepicker('change')
                        //$(".tab-pane").unmask();
                    }
                    else if (action == "GenrateReport") {
                        if (msg == "1") {
                            //window.location.href = "../Reports/ReportEngine.rpt";
                            $(".tab-pane").css("cursor", "pointer");
                            //$(".tab-pane").unmask();
                        }

                    }
                    else if (action == "ApplyGroup") {
                        //alert(msg);
                        if (msg != "") {
                            $("#divGroupValues").html(msg);
                            $(".tab-pane").css("cursor", "pointer");
                            //$(".tab-pane").unmask();
                        }

                    }
                },
                Error: function (x, e) {
                    // $("#Columns").html("Sorry No Data Found");
                    $(".tab-pane").css("cursor", "pointer");
                    //$(".tab-pane").unmask();
                }

            });
        }
    </script>
    <!-- END PAGE LEVEL STYLES -->


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-container row-fluid">

        <!-- BEGIN PAGE -->
        <div class="page">
            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

            <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
            <!-- BEGIN PAGE CONTAINER-->
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <h3 class="page-title">Report Wizard
                        </h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="#"><%=Resources.Resource.report %></a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="#"><%=Resources.Resource.reportWizard %></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->
                <div class="row-fluid">
                    <div class="span12">
                        <div class="portlet box blue" id="form_wizard_1">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="icon-reorder"></i><%= Resources.Resource.reportWizard %> <span class="step-title" id="step"></span>
                                </div>
                                <%-- <div class="tools hidden-phone">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="#portlet-config" data-toggle="modal" class="config"></a>
                           <a href="javascript:;" class="reload"></a>
                           <a href="javascript:;" class="remove"></a>
                        </div>--%>
                            </div>
                            <div class="portlet-body form">
                                <form action="#" class="form-horizontal">
                                    <div class="form-wizard">
                                        <%--<div onclick="ChangeLang()" style="display: inline; float: <%= pullDirectionStr%>; cursor: pointer;"> <%= Session["changeLanguage"] + "" %></div>
                                        --%>

                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab1">
                                                <h3 class="block"><%=Resources.Resource.selectReportTemplate %></h3>
                                                <div class="control-group">
                                                    <div id="divTemp" class="row-fluid">
                                                        <div>
                                                            <div class="control-group">
                                                                <label class="control-label"><%=Resources.Resource.selectReportTemplate %><span class="required">*</span></label>
                                                                <div class="controls">
                                                                    <select id="selTemplate" data-placeholder="<%=Resources.Resource.selectReportTemplate %>" class="chosen span6">
                                                                
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div>
                                                            <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.INCLUDE_INACTIVE_STAFF_IN_REPORTS) == true)
                                                               { %>
                                                                    <div class="control-group" style="">
                                                                <% } else { %>
                                                                    <div class="control-group" style="display:none;">
                                                                <% } %>
                                                                <label class="control-label">&nbsp;</label>
                                                                <div class="controls">
                                                                    <input id="chkboxIncludeInActive" type="checkbox" name="includeInactive" />
                                                                    <%=Resources.Resource.includeInactiveStaff %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row-->
                                                </div>
                                            </div>
                                        <div class="tab-pane" id="tab3">
                                            <div class="control-group">
                                                <h3 class="block"><%=Resources.Resource.chooseempgroup %></h3>
                                                <br />
                                            </div>
                                            <div id="divGroupValues">
                                            </div>
                                            <br />
                                        </div>

                                        <div class="tab-pane" id="tab2">
                                            <div class="control-group">
                                                <h3 class="block"><%=Resources.Resource.selectFilterValues %></h3>
                                                <br />
                                            </div>
                                            <div id="FilterValues">
                                            </div>
                                            <div>
                                                <br />
                                            </div>
                                        </div>



                                        <div class="form-actions clearfix">
                                            <a href="javascript:;" class="btn button-previous" id="btnBack">
                                                <i class="m-icon-swapleft"></i><%=Resources.Resource.back %> 
                                            </a>
                                            <a href="javascript:;" class="btn blue button-next" id="btnNext">
                                                <%=Resources.Resource.next %> <i class="m-icon-swapright m-icon-white"></i>
                                            </a>
                                            <a href="javascript:;" class="btn icn-only green" id="btnViewReport">
                                                <%=Resources.Resource.showReport %> <i class="m-icon-swapright m-icon-white"></i>
                                            </a>

                                            <a href="javascript:;" class="btn blue button-next" id="btnExcelDownload">
                                                <%=Resources.Resource.exportExcel %> <i class="m-icon-swapright m-icon-white"></i>
                                            </a>

                                            <a href="javascript:;" class="btn blue button-next" id="btnWordDownload">
                                                <%=Resources.Resource.exportWord %> <i class="m-icon-swapright m-icon-white"></i>
                                            </a>

                                            <a href="javascript:;" class="btn blue button-next" id="btnPdfDownload" style="display: none;">
                                                <%=Resources.Resource.exporttopdf %> <i class="m-icon-swapright m-icon-white"></i>
                                            </a>
                                            <a href="javascript:;" class="btn button-previous" id="btnCancel" style="display: none;">
                                                <%=Resources.Resource.cancel %> 
                                            </a>
                                            <a href="javascript:;" class="btn green button-submit" id="btnSave">
                                                <%=Resources.Resource.save %> <i class="icon-ok"></i>
                                            </a>
                                        </div>
                                    </div>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END PAGE CONTENT-->
        </div>
        <!-- END PAGE CONTAINER-->
    </div>
    <!-- END PAGE -->
    </div>
    
    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="../assets/<%= languageStr %>/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="../assets/<%= languageStr %>/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
   <script src="../assets/<%= languageStr %>/plugins/excanvas.js"></script>
   <script src="../assets/<%= languageStr %>/plugins/respond.js"></script>  
   <![endif]-->
    <script src="../assets/<%= languageStr %>/plugins/breakpoints/breakpoints.js" type="text/javascript"></script>
    <!-- IMPORTANT! jquery.slimscroll.min.js depends on jquery-ui-1.10.1.custom.min.js -->
    <script src="../assets/<%= languageStr %>/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="../assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>
    <script src="../assets/<%= languageStr %>/plugins/jquery.cookie.js" type="text/javascript"></script>
    <script src="../assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-validation/dist/additional-methods.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>


    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
    
    <%--<script src="../Assets/<%= languageStr %>/Scripts/jquery.loadmask.js"></script>--%>

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="../Assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="../Assets/<%= languageStr %>/scripts/form-wizard.js"></script>
    <script src="../Assets/<%= languageStr %>/scripts/form-components.js"></script>

    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>

    <script type="text/javascript" src="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>
    
    <!-- END PAGE LEVEL SCRIPTS -->
    <script>
        $(document).ready(function () {
            // initiate layout and plugins
            LoadTemplates("getAllTemplate");
            $('#btnBack').hide();
            $('#btnSave').hide();
            $('#btnViewReport').hide();
            $('#btnExcelDownload').hide();
            $('#btnWordDownload').hide();
            $('#btnPdfDownload').hide();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#liRpt").addClass("active");
            $("#liRpt .arrow").addClass("open");
            $("#liDyn").addClass("active");
            $("#liDyn .arrow").addClass("open");
            $("#liReportWizard").addClass("active");


            App.init();
            FormWizard.init();

            $("#chkboxIncludeInActive").removeAttr("checked");
            $("#uniform-chkboxIncludeInActive span").removeClass("checked");

            //chkboxIncludeInActive
            //    window.setTimeout(function () { FormComponents.init() }, 100);
            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
        });
        y = 0;
        function isEmpty(el) {
            return !$.trim(el.html())
        }


        function LoadDepartment() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var Region = $("[name='ddrgn']").val();
            // alert(ParentID);
            if (Region != "0")
                d = "key=GetDepartment&RegionID=" + Region;
            else
                d = "key=GetDepartment";

            //   alert('LoadDepartment' + Region);
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    //alert(html);
                    $("[name='ddorg']").html(html)
                    $("[name='ddorg']").trigger("liszt:updated");
                    LoadSection
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                      //     $("#form_sample_1").unmask();
                  }
            });
        }

          function LoadSection() {
              $("#divErrorMsg").css("display", "none");
              $("#spnSuccessMsg").css("display", "none");

              var ParentID = $("[name='ddorg']").val();
              var Region = $("[name='ddrgn']").val();
              //  alert(ParentID + Region);
              if (Region != "0" && ParentID == "0")
                  d = "key=getSection&RegionID=" + Region;
              else if (Region == "0" && ParentID != "0")
                  d = "key=getSection&ParentID=" + ParentID;
              else if (ParentID != "0" && Region != "0")
                  d = "key=getSection&RegionID=" + Region + "&ParentID=" + ParentID;
              else
                  d = "key=getSection";
              // alert('LoadSection' + d);
              $.ajax({
                  type: 'POST',
                  data: d,
                  url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    //alert(html);
                    $("[name='ddorg']").html(html)
                    $("[name='ddorg']").trigger("liszt:updated");
                    LoadEmployees();
                    LoadEmployeeManagers();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //     $("#form_sample_1").unmask();
                }
            });

          }

        function LoadEmployeeManagers() {

            if (!$("[name='ddMgr']").length) {
                return;
            }

            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var orgVal = $("[name='ddorg']").val();
            var rgnVal = $("[name='ddrgn']").val();
            var emptypVal = $("[name='ddemptype']").val();
            var ParentID = $("[name='ddorg']").val();
            var SchType = $("[name='ddSch']").val();
            d = "key=getManagerNameListByOrgID";

            // alert('O' + orgVal + 'R' + rgnVal + 'E' + emptypVal + 'P' + ParentID + 'S' + SchType);
            if (rgnVal != "0" && rgnVal != undefined)
                d += "&RegionID=" + rgnVal;

            if (ParentID != "0" && ParentID != undefined)
                d += "&ParentID=" + ParentID;

            if (orgVal != "0" && orgVal != undefined)
                d += "&orgID=" + orgVal;

            if (emptypVal != "0" && emptypVal != undefined)
                d += "&EmpTypeID=" + emptypVal;

            if (SchType != "0" && SchType != undefined)
                d += "&SchType=" + SchType;

            //  alert(d);
            // $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   //alert(html);
                   //      $("#form_sample_1").unmask();
                   // document.getElementsByName("ddemp").html = html;
                   // document.getElementByName("ddemp").innerHTML = html;
                   $("[name='ddMgr']").html(html)
                   $("[name='ddMgr']").trigger("liszt:updated");
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //     $("#form_sample_1").unmask();
               }
           });
       }


        function LoadEmployees() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var orgVal = $("[name='ddorg']").val();
            var rgnVal = $("[name='ddrgn']").val();
            var emptypVal = $("[name='ddemptype']").val();
            var ParentID = $("[name='ddorg']").val();
            var SchType = $("[name='ddSch']").val();
            d = "key=getEmpNameListByOrgID";

            // alert('O' + orgVal + 'R' + rgnVal + 'E' + emptypVal + 'P' + ParentID + 'S' + SchType);
            if (rgnVal != "0" && rgnVal != undefined)
                d += "&RegionID=" + rgnVal;

            if (ParentID != "0" && ParentID != undefined)
                d += "&ParentID=" + ParentID;

            if (orgVal != "0" && orgVal != undefined)
                d += "&orgID=" + orgVal;

            if (emptypVal != "0" && emptypVal != undefined)
                d += "&EmpTypeID=" + emptypVal;

            if (SchType != "0" && SchType != undefined)
                d += "&SchType=" + SchType;

            //  alert(d);
            // $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   //alert(html);
                   //      $("#form_sample_1").unmask();
                   // document.getElementsByName("ddemp").html = html;
                   // document.getElementByName("ddemp").innerHTML = html;
                   $("[name='ddemp']").html(html)
                   $("[name='ddemp']").trigger("liszt:updated");
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //     $("#form_sample_1").unmask();
               }
           });
       }


        $('#btnNext').click(function () {

            if (y == 0) {
                $('#step').html('-' + $('#selTemplate option:selected').text());
                //$("#divGroupValues").empty()

             //   LoadTemplates("ApplyGroup")
                window.setTimeout(function () {

                    if (!$.trim($('#divGroupValues').html()).length) {

                        LoadTemplates("FilterValues");

                        $('#tab1').hide();
                        $('#tab2').show();
                        $('#btnBack').show();
                        $('#btnNext').hide();
                        $('#btnViewReport').show();
                        $('#btnExcelDownload').show();
                        $('#btnWordDownload').show();
                     
                    }
                    else {
                        $('#tab1').hide();
                        $('#tab3').show();
                        $('#btnBack').show();
                    }

                }, 50);

                y = 1;
            }
            else if (y == 1) {
                LoadTemplates("FilterValues");
                $('#tab1').hide();
                $('#tab3').hide();
                $('#tab2').show();
                $('#btnBack').show();
                $('#btnNext').hide();
                $('#btnViewReport').show();
                $('#btnExcelDownload').show();
                $('#btnWordDownload').show();
                //  $('#btnPdfDownload').show();
                //window.setTimeout(function () { FormComponents.init() }, 1000);
                // window.onload( FormComponents.init() );
                y = 2;
            }
            else if (y == 2) {

                // GenerateReport();
                $('#tab2').hide();
                $('#tab3').show();
                y = 3;
            }
            //else if (i == 2) {

            //    $('#tab2').hide();
            //    $('#tab3').show();
            //}
        });
        $('#btnViewReport').click(function () {
            GenerateReport('btnViewReport');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });
        $('#btnExcelDownload').click(function () {
            GenerateReport('btnExcelDownload');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });
        $('#btnWordDownload').click(function () {
            GenerateReport('btnWordDownload');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });
        $('#btnPdfDownload').click(function () {
            GenerateReport('btnPdfDownload');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });



        $('#btnBack').click(function () {
            $('#step').html("");
            //if (y == 3) {
            //    alert('DDDDDD');
            //    $('#tab2').hide();
            //    $('#tab3').show();
            //    //$('#btnBack').hide();
            //    $('#btnViewReport').hide();
            //    $('#btnNext').show();
            //    y = 2;
            //}

            if (y == 1) {
                if (!$.trim($('#divGroupValues').html()).length) {
                    //  alert('P');
                    $('#tab2').hide();
                    $('#tab3').hide();
                    $('#tab1').show();
                    $('#btnBack').hide();
                    $('#btnNext').show();
                    $('#btnViewReport').hide();
                    $('#btnExcelDownload').hide();
                    $('#btnWordDownload').hide();

                    $('#btnPdfDownload').hide();
                }
                else {
                    //   alert('d');
                    $('#tab3').hide();
                    $('#tab2').hide();
                    $('#tab1').show();
                    //$('#btnBack').hide();
                    $('#btnViewReport').hide();
                    $('#btnExcelDownload').hide();
                    $('#btnWordDownload').hide();
                    $('#btnPdfDownload').hide();
                    $('#btnNext').show();
                    $('#btnBack').hide();
                }
                y = 0;
            }
            if (y == 2) {

                $('#tab2').hide();
                $('#tab1').hide();
                $('#tab3').show();
                //$('#btnBack').hide();
                $('#btnViewReport').hide();
                $('#btnExcelDownload').hide();
                $('#btnWordDownload').hide();
                $('#btnPdfDownload').hide();
                $('#btnNext').show();
                $('#btnBack').show();
                y = 1;
            }
        });


        var FormComponents = function () {

            var handlejQueryUIDatePickers = function () {
                $(".ui-date-picker").datepicker();
                //      alert("I'm here");
            }

            var handleDateTimePickers = function () {

                if (jQuery().datepicker) {
                    $('#txtDate1').datepicker({ format: 'dd-mm-yyyy' });
                    $('#txtDate2').datepicker({ format: 'dd-mm-yyyy' });
                }

                //$("#txtDate1").datepicker('update', '<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                //$("#txtDate2").datepicker('update', '<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                $("#txtDate1").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                $("#txtDate2").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');

            }

            var handleInputMasks = function () {
                //alert('p');
                $.extend($.inputmask.defaults, {
                    'autounmask': true
                });

                $("#txtDate1").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
                $("#txtDate2").inputmask("d-m-y", { autoUnmask: true });  //direct mask    

                $('.date-picker').on('change', function () {
                    $('.datepicker').hide();
                });
            }

            return {
                //main function to initiate the module
                init: function () {
                    handlejQueryUIDatePickers();
                    handleDateTimePickers();
                    handleInputMasks();
                }

            };

        }();
        ////////END OF FORM COMPONENTS////////

        ////////END OF FORM COMPONENTS////////

    </script>

</asp:Content>
