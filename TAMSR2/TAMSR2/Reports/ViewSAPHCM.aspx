<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewSAPHCM.aspx.cs" Inherits="TAMSR2.Reports.ViewSAPHCM" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.businessIntelligence %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <link href="<%= path %>Styles/jquery.loadmask.css" rel="stylesheet" />
    <!-- END PAGE LEVEL STYLES -->

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .modal-lg {
            width: 1200px !important;
            left: 26% !important;
        }

        .ml105 {
            margin-left: 105px;
        }

        .text-bold {
            font-weight: bold;
        }

        .bordercustom {
            border: 1px solid lightgrey;
            padding: 10px;
        }
    </style>
    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="portlet-config" class="modal modal-lg hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.employeeDetails %></h4>
                        </div>
                        <div class="portlet-body form">
                            <div class="bordercustom">
                                <div class="row-fluid">
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.fromDate %> </label>
                                            <div class="controls">
                                                <input id="txtDFromDate" name="dFromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span4">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.toDate %> </label>
                                            <div class="controls">
                                                <input id="txtDToDate" name="dToDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDTrimTimeInSchIn" type="checkbox" name="trimTimeInSchIn" />
                                                <%=Resources.Resource.trimTimeInSchIn %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDTrimTimeOutSchOut" type="checkbox" name="trimTimeOutSchOut" />
                                                <%=Resources.Resource.trimTimeOutSchOut %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDMissingInOutDaysAsAbsent" type="checkbox" name="missingInOutDaysAsAbsent" />
                                                <%=Resources.Resource.missingInOutDaysAsAbsent %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDExcludeHolidaysHours" type="checkbox" name="excludeHolidaysHours" />
                                                <%=Resources.Resource.excludeHolidaysHours %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDExcludeRestDaysHours" type="checkbox" name="excludeRestDaysHours" />
                                                <%=Resources.Resource.excludeRestDaysHours %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDExcludeLeaveHours" type="checkbox" name="excludeLeaveHours" />
                                                <%=Resources.Resource.excludeLeaveHours %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDAbsentDaysOfSickLeave" type="checkbox" name="absentDaysOfSickLeave" />
                                                    <%=Resources.Resource.considerAbsentAfter %> <%= noOfDays %> <%=Resources.Resource.daysOfSickLeave %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDFullDayWorkingMissedInOut" type="checkbox" name="fullDayWorkingMissedInOut" />
                                                <%=Resources.Resource.fullDayWorkingMissedInOut %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input id="chkboxDFullDayWorkingWithoutInOrOut" type="checkbox" name="fullDayWorkingWithoutInOrOut" />
                                                <%=Resources.Resource.fullDayWorkingWithoutInOrOut %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row-fluid">
                                    <div class="span3">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.employeeName %> </label>
                                            <label class="lblEmpName text-bold"></label>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span3">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.employeeCode %> </label>
                                            <label class="lblEmpCode text-bold"></label>
                                        </div>
                                    </div>
                                    <div class="span3">
                                        <div class="btn-group" id="processDButton" style="padding-left: 100px;"></div>
                                    </div>
                                    <div class="span3">
                                        <div class="control-group">
                                            <a id="btnDetails" class="btn green" onclick="exportDetailToExcel();"><i class="icon-download-alt">&nbsp; <%=Resources.Resource.exportExcel %></i></a>
                                        </div>
                                    </div>

                                    <!--/span-->
                                </div>
                            </div>

                            <table class="table table-striped table-bordered table-hover" id="sample_details">
                                <thead>
                                    <tr style="background-color: #e8e3e3;">
                                        <th style="text-align: center; width: 68px !important;"><%=Resources.Resource.transactionDate %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.day %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.punchIn %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.punchOut %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.late %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.early %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.requiredWorkHours %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.workTime %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.missingTime %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.extraTime %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.lblComments %></th>
                                        <th style="text-align: center; width: 250px !important;"><%=Resources.Resource.remarks %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- END VALIDATION STATES-->
                </div>
            </div>
        </div>
    </div>
    <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->


    <!-- BEGIN PAGE CONTAINER-->
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN STYLE CUSTOMIZER -->
                <div style="display: none;" class="color-panel hidden-phone">
                    <div class="color-mode-icons icon-color"></div>
                    <div class="color-mode-icons icon-color-close"></div>
                    <div class="color-mode">
                        <p><%=Resources.Resource.themeColor %></p>
                        <ul class="inline">
                            <li class="color-black current color-default" data-style="default"></li>
                            <li class="color-blue" data-style="blue"></li>
                            <li class="color-brown" data-style="brown"></li>
                            <li class="color-purple" data-style="purple"></li>
                            <li class="color-white color-light" data-style="light"></li>
                        </ul>
                        <label class="hidden-phone">
                            <input type="checkbox" class="header" checked value="" />
                            <span class="color-mode-label"><%=Resources.Resource.fixedHeader %></span>
                        </label>
                    </div>
                </div>
                <!-- END BEGIN STYLE CUSTOMIZER -->
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">
                    <%=Resources.Resource.saphcm %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.businessIntelligence %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.saphcm %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN FORM-->
                <form action="#" id="form_1" class="form-horizontal bordercustom">
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="span4 ">
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.fromDate %> </label>
                                    <div class="controls">
                                        <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                            <div class="span4">
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.toDate %> </label>
                                    <div class="controls">
                                        <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!--/span-->
                    </div>
                    <!--/row-->

                    <div class="row-fluid">
                        <div class="span12">
                            <div class="span4">
                                <div class="control-group">
                                    <div class="controls ml105">
                                        <input id="chkboxTrimTimeInSchIn" type="checkbox" name="trimTimeInSchIn" />
                                        <%=Resources.Resource.trimTimeInSchIn %>
                                    </div>
                                </div>
                            </div>
                            <div class="span4">
                                <div class="control-group">
                                    <div class="controls ml105">
                                        <input id="chkboxTrimTimeOutSchOut" type="checkbox" name="trimTimeOutSchOut" />
                                        <%=Resources.Resource.trimTimeOutSchOut %>
                                    </div>
                                </div>
                            </div>
                            <div class="span4">
                                <div class="control-group">
                                    <div class="controls ml105">
                                        <input id="chkboxMissingInOutDaysAsAbsent" type="checkbox" name="missingInOutDaysAsAbsent" />
                                        <%=Resources.Resource.missingInOutDaysAsAbsent %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span4">
                            <div class="control-group">
                                <div class="controls ml105">
                                    <input id="chkboxExcludeHolidaysHours" type="checkbox" name="excludeHolidaysHours" />
                                    <%=Resources.Resource.excludeHolidaysHours %>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <div class="controls ml105">
                                    <input id="chkboxExcludeRestDaysHours" type="checkbox" name="excludeRestDaysHours" />
                                    <%=Resources.Resource.excludeRestDaysHours %>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <div class="controls ml105">
                                    <input id="chkboxExcludeLeaveHours" type="checkbox" name="excludeLeaveHours" />
                                    <%=Resources.Resource.excludeLeaveHours %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span4">
                            <div class="control-group">
                                <div class="controls ml105">
                                    <input id="chkboxAbsentDaysOfSickLeave" type="checkbox" name="absentDaysOfSickLeave" />
                                    <%=Resources.Resource.considerAbsentAfter %> <%= noOfDays %> <%=Resources.Resource.daysOfSickLeave %>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <div class="controls ml105">
                                    <input id="chkboxFullDayWorkingMissedInOut" type="checkbox" name="fullDayWorkingMissedInOut" />
                                    <%=Resources.Resource.fullDayWorkingMissedInOut %>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <div class="controls ml105">
                                    <input id="chkboxFullDayWorkingWithoutInOrOut" type="checkbox" name="fullDayWorkingWithoutInOrOut" />
                                    <%=Resources.Resource.fullDayWorkingWithoutInOrOut %>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <!-- END FORM-->
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.saphcm %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="spnGridMsg">&nbsp;</span>
                            </div>
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="spnAddButton" runat="server">
                                    <a id="btnAdd" class="btn green" onclick="exportSummaryToExcel();"><i class="icon-download-alt">&nbsp; <%=Resources.Resource.exportExcel %></i></a>
                                </span>
                            </div>
                            <div class="btn-group pull-<%= pullDirectionStr %>">
                                <span id="Span2" runat="server">
                                    <a id="btnProcess" class="btn blue" onclick="LoadGrid();" style="margin-right: 10px;">&nbsp; <%=Resources.Resource.process %></a>
                                </span>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-bordered table-hover" id="sample_1">
                        <thead>
                            <tr style="background-color: #e8e3e3;">
                                <th style="text-align: center;" colspan="2"><%=Resources.Resource.employee %></th>
                                <th style="text-align: center;"></th>
                                <th style="text-align: center;"></th>
                                <th style="text-align: center;" colspan="2"><%=Resources.Resource.expected %></th>
                                <th style="text-align: center;" colspan="2"><%=Resources.Resource.actual %></th>
                                <th style="text-align: center;"></th>
                                <th style="text-align: center;" colspan="2"><%=Resources.Resource.missing %></th>
                                <th style="text-align: center;" colspan="2"><%=Resources.Resource.delay %></th>
                                <th style="text-align: center;" colspan="2"><%=Resources.Resource.early %></th>
                            </tr>
                            <tr style="background-color: #e8e3e3;">
                                <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                <th style="text-align: center;"><%=Resources.Resource.joinDate %></th>
                                <th style="text-align: center;"><%=Resources.Resource.inactiveDate %></th>
                                <th style="text-align: center;"><%=Resources.Resource.workDays %></th>
                                <th style="text-align: center;"><%=Resources.Resource.workHours %></th>
                                <th style="text-align: center;"><%=Resources.Resource.workDays %></th>
                                <th style="text-align: center;"><%=Resources.Resource.workHours %></th>
                                <th style="text-align: center;"><%=Resources.Resource.absents %></th>
                                <th style="text-align: center;"><%=Resources.Resource.inn %></th>
                                <th style="text-align: center;"><%=Resources.Resource.outt %></th>
                                <th style="text-align: center;"><%=Resources.Resource.count %></th>
                                <th style="text-align: center;"><%=Resources.Resource.sum %></th>
                                <th style="text-align: center;"><%=Resources.Resource.count %></th>
                                <th style="text-align: center;"><%=Resources.Resource.sum %></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- END EXAMPLE TABLE PORTLET-->
        </div>
    </div>
    <!-- END PAGE CONTENT-->
    </div>
    <!-- END PAGE CONTAINER-->

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
   <script src="<%= path %>assets/<%= languageStr %>/plugins/excanvas.js"></script>
   <script src="<%= path %>assets/<%= languageStr %>/plugins/respond.js"></script>  
   <![endif]-->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/breakpoints/breakpoints.js" type="text/javascript"></script>
    <!-- IMPORTANT! jquery.slimscroll.min.js depends on jquery-ui-1.10.1.custom.min.js -->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery.cookie.js" type="text/javascript"></script>
    <script src="<%= path %>assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-validation/dist/additional-methods.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>

    <!--Script references. -->
    <!--Reference the SignalR library. -->
    <script src="<%= path %>Scripts/jquery.signalR-1.1.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="<%= path %>signalr/hubs"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src='<%= path %>Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
    <script src="<%= path %>assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="<%= path %>assets/<%= languageStr %>/scripts/table-managed.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">

        var summaryResult = [];
        var detailsResult = [];
        var openningDetails = false;

        $(document).ready(function () {
            //alert(typeof String.prototype.trim);
            if (typeof String.prototype.trim != 'function') {
                String.prototype.trim = function () {
                    return this.replace(/^\s+|\s+$/g, '');
                }
            }
        });

        $(document).ready(function () {
            App.init(); // initlayout and core plugins
            FormComponents.init();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

            $("#txtFromDate").val('<%= DateTime.UtcNow.AddHours(-172).ToString("dd-MM-yyyy") %>');
            $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');


            $("#txtFromDate").change(function () {
                DateRangeChange("fromDate");
                LoadGrid();
            });

            $("#txtToDate").change(function () {
                DateRangeChange("toDate");
                LoadGrid();
            });

        });

        function DateRangeChange(param) {

            var fromDate = new Date();
            var toDate = new Date();
            var str1 = $('#txtFromDate').val();
            var str2 = $('#txtToDate').val();

            if (str1.indexOf('-') > 0) {
                fromDate = new Date(str1.substring(6, 10), str1.substring(3, 5), str1.substring(0, 2));
            }
            else {
                fromDate = new Date(str1.substring(4, 8), str1.substring(2, 4), str1.substring(0, 2));
            }
            if (str2.indexOf('-') > 0) {
                toDate = new Date(str2.substring(6, 10), str2.substring(3, 5), str2.substring(0, 2));
            }
            else {
                toDate = new Date(str2.substring(4, 8), str2.substring(2, 4), str2.substring(0, 2));
            }

            if (param == "fromDate") {
                if ($("#txtFromDate").val() == "") {
                    $("#txtFromDate").val('<%= DateTime.UtcNow.AddHours(-172).ToString("dd-MM-yyyy") %>');
                    $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                }

                if (fromDate > toDate) {
                    $("#txtToDate").val($("#txtFromDate").val());
                }
            }
            else if (param == "toDate") {
                if ($("#txtToDate").val() == "") {
                    $("#txtFromDate").val('<%= DateTime.UtcNow.AddHours(-172).ToString("dd-MM-yyyy") %>');
                    $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                }

                if (fromDate > toDate) {
                    $("#txtFromDate").val($("#txtToDate").val());
                }
            }
        }

        function LoadGrid() {
            
            
            $('#sample_1 tbody').html("");
            
            //$('#sample_1').dataTable().fnDraw();
            var fromDate = "";
            var toDate = "";
            var str1 = $('#txtFromDate').val();
            var str2 = $('#txtToDate').val();

            if (str1.indexOf('-') > 0) {
                fromDate = str1.substring(6, 10) + "-" + str1.substring(3, 5) + "-" + str1.substring(0, 2);
            }
            else {
                fromDate = str1.substring(4, 8) + "-" + str1.substring(2, 4) + "-" + str1.substring(0, 2);
            }
            if (str2.indexOf('-') > 0) {
                toDate = str2.substring(6, 10) + "-" + str2.substring(3, 5) + "-" + str2.substring(0, 2);
            }
            else {
                toDate = str2.substring(4, 8) + "-" + str2.substring(2, 4) + "-" + str2.substring(0, 2);
            }
            var trimTimeInSchIn = $("#chkboxTrimTimeInSchIn").is(":checked");
            var trimTimeOutSchOut = $("#chkboxTrimTimeOutSchOut").is(":checked");
            var missingInOutDaysAsAbsent = $("#chkboxMissingInOutDaysAsAbsent").is(":checked");
            var excludeHolidaysHours = $("#chkboxExcludeHolidaysHours").is(":checked");
            var excludeRestDaysHours = $("#chkboxExcludeRestDaysHours").is(":checked");
            var excludeLeaveHours = $("#chkboxExcludeLeaveHours").is(":checked");
            var absentDaysOfSickLeave = $("#chkboxAbsentDaysOfSickLeave").is(":checked");
            var fullDayWorkingMissedInOut = $("#chkboxFullDayWorkingMissedInOut").is(":checked");
            var fullDayWorkingWithoutInOrOut = $("#chkboxFullDayWorkingWithoutInOrOut").is(":checked");


            var url = '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx?key=ShowBIDefault") %>' + '&fromDate=' + fromDate + '&toDate=' + toDate;
            url += '&trimTimeInSchIn=' + trimTimeInSchIn + '&trimTimeOutSchOut=' + trimTimeOutSchOut + '&missingInOutDaysAsAbsent=' + missingInOutDaysAsAbsent;
            url += '&excludeHolidaysHours=' + excludeHolidaysHours + '&excludeRestDaysHours=' + excludeRestDaysHours + '&excludeLeaveHours=' + excludeLeaveHours;
            url += '&absentDaysOfSickLeave=' + absentDaysOfSickLeave + '&fullDayWorkingMissedInOut=' + fullDayWorkingMissedInOut + '&fullDayWorkingWithoutInOrOut=' + fullDayWorkingWithoutInOrOut;
            $.ajax({
                type: 'POST',
                url: url,
                success: function (html) {

                    var data = $.parseJSON(html);
                    summaryResult = data;

                    for (var i = 0; i < data.length; i++) {

                        var employee_id = data[i].employee_id;
                        var employee_code = data[i].employee_code;
                        var employee_name = data[i].employee_name;
                        var join_date = data[i].join_date;
                        var inactive_date = data[i].inactive_date;
                        var expected_work_days = data[i].expected_work_days;
                        var expected_hours = data[i].expected_hours;
                        var actual_work_days = data[i].actual_work_days;
                        var actual_work_hours = data[i].actual_work_hours;
                        var absentcount = data[i].absentcount;
                        var missingIN = data[i].missingIN;
                        var missingOUT = data[i].missingOUT;
                        var delaycount = data[i].delaycount;
                        var delaysum = data[i].delaysum;
                        var earlycount = data[i].earlycount;
                        var earlysum = data[i].earlysum;

                        $('#sample_1 tbody').append("<tr><td>" + employee_code + "</td><td><a id='showDetails' onclick='replicateParams(); LoadDetailGrid(" + employee_id + ")' href='#portlet-config' data-toggle='modal'>" + employee_name + "</a></td><td>" + join_date + "</td><td>" + inactive_date + "</td><td>" + expected_work_days + "</td><td>" + expected_hours + "</td><td>" + actual_work_days + "</td><td>" + actual_work_hours + "</td><td>" + absentcount + "</td><td>" + missingIN + "</td><td>" + missingOUT + "</td><td>" + delaycount + "</td><td>" + delaysum + "</td><td>" + earlycount + "</td><td>" + earlysum + "</td></tr>");
                    }
                    $('#sample_1').dataTable();//.fnDraw();
                    
                },
                error: function (html) {

                }
            });
        }

        function replicateParams() {

            var sumFDate = $('#txtFromDate').val();
            var sumTDate = $('#txtToDate').val();
            $('#txtDFromDate').val(sumFDate);
            $('#txtDToDate').val(sumTDate);
            debugger

            if ($("#chkboxTrimTimeInSchIn").is(":checked")) {
                $("#chkboxDTrimTimeInSchIn").attr("checked", "checked");
                $("#uniform-chkboxDTrimTimeInSchIn span").addClass("checked");
            }
            if ($("#chkboxTrimTimeOutSchOut").is(":checked")) {
                $("#chkboxDTrimTimeOutSchOut").attr("checked", "checked");
                $("#uniform-chkboxDTrimTimeOutSchOut span").addClass("checked");
            }
            if ($("#chkboxMissingInOutDaysAsAbsent").is(":checked")) {
                $("#chkboxDMissingInOutDaysAsAbsent").attr("checked", "checked");
                $("#uniform-chkboxDMissingInOutDaysAsAbsent span").addClass("checked");
            }
            if ($("#chkboxExcludeHolidaysHours").is(":checked")) {
                $("#chkboxDExcludeHolidaysHours").attr("checked", "checked");
                $("#uniform-chkboxDExcludeHolidaysHours span").addClass("checked");
            }
            if ($("#chkboxExcludeRestDaysHours").is(":checked")) {
                $("#chkboxDExcludeRestDaysHours").attr("checked", "checked");
                $("#uniform-chkboxDExcludeRestDaysHours span").addClass("checked");
            }
            if ($("#chkboxExcludeLeaveHours").is(":checked")) {
                $("#chkboxDExcludeLeaveHours").attr("checked", "checked");
                $("#uniform-chkboxDExcludeLeaveHours span").addClass("checked");
            }
            if ($("#chkboxAbsentDaysOfSickLeave").is(":checked")) {
                $("#chkboxDAbsentDaysOfSickLeave").attr("checked", "checked");
                $("#uniform-chkboxDAbsentDaysOfSickLeave span").addClass("checked");
            }
            if ($("#chkboxFullDayWorkingMissedInOut").is(":checked")) {
                $("#chkboxDFullDayWorkingMissedInOut").attr("checked", "checked");
                $("#uniform-chkboxDFullDayWorkingMissedInOut span").addClass("checked");
            }
            if ($("#chkboxFullDayWorkingWithoutInOrOut").is(":checked")) {
                $("#chkboxDFullDayWorkingWithoutInOrOut").attr("checked", "checked");
                $("#uniform-chkboxDFullDayWorkingWithoutInOrOut span").addClass("checked");
            }
        }

        function LoadDetailGrid(employeeID) {
           
            $('#processDButton').html("");
            $('#processDButton').append(' <a id="btnDProcess" class="btn blue" onclick="LoadDetailGrid(' + employeeID + ');">&nbsp; <%=Resources.Resource.process %></a>');

            detailsResult = [];
            var fromDate = "";
            var toDate = "";
            var str1 = $('#txtDFromDate').val();
            var str2 = $('#txtDToDate').val();

            if (str1.indexOf('-') > 0) {
                fromDate = str1.substring(6, 10) + "-" + str1.substring(3, 5) + "-" + str1.substring(0, 2);
            }
            else {
                fromDate = str1.substring(4, 8) + "-" + str1.substring(2, 4) + "-" + str1.substring(0, 2);
            }
            if (str2.indexOf('-') > 0) {
                toDate = str2.substring(6, 10) + "-" + str2.substring(3, 5) + "-" + str2.substring(0, 2);
            }
            else {
                toDate = str2.substring(4, 8) + "-" + str2.substring(2, 4) + "-" + str2.substring(0, 2);
            }

            var trimTimeInSchIn = $("#chkboxDTrimTimeInSchIn").is(":checked");
            var trimTimeOutSchOut = $("#chkboxDTrimTimeOutSchOut").is(":checked");
            var missingInOutDaysAsAbsent = $("#chkboxDMissingInOutDaysAsAbsent").is(":checked");
            var excludeHolidaysHours = $("#chkboxDExcludeHolidaysHours").is(":checked");
            var excludeRestDaysHours = $("#chkboxDExcludeRestDaysHours").is(":checked");
            var excludeLeaveHours = $("#chkboxDExcludeLeaveHours").is(":checked");
            var absentDaysOfSickLeave = $("#chkboxDAbsentDaysOfSickLeave").is(":checked");
            var fullDayWorkingMissedInOut = $("#chkboxDFullDayWorkingMissedInOut").is(":checked");
            var fullDayWorkingWithoutInOrOut = $("#chkboxDFullDayWorkingWithoutInOrOut").is(":checked");

            var url = '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx?key=ShowBIDetails") %>' + '&fromDate=' + fromDate + '&toDate=' + toDate + '&employeeID=' + employeeID;
            url += '&trimTimeInSchIn=' + trimTimeInSchIn + '&trimTimeOutSchOut=' + trimTimeOutSchOut + '&missingInOutDaysAsAbsent=' + missingInOutDaysAsAbsent;
            url += '&excludeHolidaysHours=' + excludeHolidaysHours + '&excludeRestDaysHours=' + excludeRestDaysHours + '&excludeLeaveHours=' + excludeLeaveHours;
            url += '&absentDaysOfSickLeave=' + absentDaysOfSickLeave + '&fullDayWorkingMissedInOut=' + fullDayWorkingMissedInOut + '&fullDayWorkingWithoutInOrOut=' + fullDayWorkingWithoutInOrOut;
            $.ajax({
                type: 'POST',
                url: url,
                success: function (html) {
                    $('#sample_details tbody').html(" ");

                    var data = $.parseJSON(html);
                    $('.lblEmpName').html("");
                    $('.lblEmpName').append(data[0].Employee_Name_English);
                    $('.lblEmpCode').html("");
                    $('.lblEmpCode').append(data[0].employee_code);
                    detailsResult = data;
                    for (var i = 0; i < data.length; i++) {
                        var Transaction_date = data[i].Transaction_date;
                        var day_name = data[i].day_name;
                        var Punch_In = data[i].Punch_In;
                        var Punch_Out = data[i].Punch_Out;
                        var Late_HH_MM = data[i].Late_HH_MM;
                        var Early_HH_MM = data[i].Early_HH_MM;
                        var Required_Work_HH_MM = data[i].Required_Work_HH_MM;
                        var Work_Time_HH_MM = data[i].Work_Time_HH_MM;
                        var Missing_Time_HH_MM = data[i].Missing_Time_HH_MM;
                        var ExtraWorkedTime_HH_MM = data[i].ExtraWorkedTime_HH_MM;
                        var Comment_English = data[i].Comment_English;
                        var Remarks_English = data[i].Remarks_English;

                        $('#sample_details tbody').append("<tr><td>" + Transaction_date + "</td><td>" + day_name + "</td><td>" + Punch_In + "</td><td>" + Punch_Out + "</td><td>" + Late_HH_MM + "</td><td>" + Early_HH_MM + "</td><td>" + Required_Work_HH_MM + "</td><td>" + Work_Time_HH_MM + "</td><td>" + Missing_Time_HH_MM + "</td><td>" + ExtraWorkedTime_HH_MM + "</td><td>" + Comment_English + "</td><td>" + Remarks_English + "</td></tr>");
                    }
                    $('#sample_details').dataTable();
                },
                error: function (html) {

                }
            });
        }

        function exportDetailToExcel() {
            var exportData = [];
            for (var i = 0; i < detailsResult.length; i++) {
                var objInner = {
                    Transaction_date: detailsResult[i].Transaction_date,
                    day_name: detailsResult[i].day_name,
                    Punch_In: detailsResult[i].Punch_In,
                    Punch_Out: detailsResult[i].Punch_Out,
                    Late_HH_MM: detailsResult[i].Late_HH_MM,
                    Early_HH_MM: detailsResult[i].Early_HH_MM,
                    Required_Work_HH_MM: detailsResult[i].Required_Work_HH_MM,
                    Work_Time_HH_MM: detailsResult[i].Work_Time_HH_MM,
                    Missing_Time_HH_MM: detailsResult[i].Missing_Time_HH_MM,
                    ExtraWorkedTime_HH_MM: detailsResult[i].ExtraWorkedTime_HH_MM,
                    Comment_English: detailsResult[i].Comment_English,
                    Remarks_English: detailsResult[i].Remarks_English
                };

                exportData.push(objInner);
            }

            var exportHeader = ["TRANSACTION_DATE", "DAY_NAME", "PUNCH_IN", "PUNCH_OUT", "LATE_HH_MM", "EARLY_HH_MM", "REQUIRED_Work_HH_MM", "WORK_TIME_HH_MM", "MISSING_TIME_HH_MM", "EXTRA_WORKED_TIME_HH_MM", "COMMENTS_ENGLISH", "REMARKS_ENGLISH"]
            exportCsv(exportData, exportHeader, "DETAIL");
        }

        function exportSummaryToExcel() {
            var exportData = [];
            for (var i = 0; i < summaryResult.length; i++) {

                var objInner = {
                    employee_code: summaryResult[i].employee_code,
                    employee_name: summaryResult[i].employee_name,
                    join_date: summaryResult[i].join_date,
                    inactive_date: summaryResult[i].inactive_date,
                    expected_work_days: summaryResult[i].expected_work_days,
                    expected_hours: summaryResult[i].expected_hours,
                    actual_work_days: summaryResult[i].actual_work_days,
                    actual_work_hours: summaryResult[i].actual_work_hours,
                    absentcount: summaryResult[i].absentcount,
                    missingIN: summaryResult[i].missingIN,
                    missingOUT: summaryResult[i].missingOUT,
                    delaycount: summaryResult[i].delaycount,
                    delaysum: summaryResult[i].delaysum,
                    earlycount: summaryResult[i].earlycount,
                    earlysum: summaryResult[i].earlysum
                };

                exportData.push(objInner);
            }

            var exportHeader = ["EMPLOYEECODE", "EMPLOYEENAME", "JOINDATE", "INACTIVEDATE", "EXOECTEDWORKDAYS", "EXPECTEDWORKHOURS", "ACTUALWORKDAYS", "ACTUALWORKHOURS", "ABSENTCOUNT", "MISSINGIN", "MISSINGOUT", "DELAYCOUNT", "DELAYSUM", "EARLYCOUNT", "EARLYSUM"]
            exportCsv(exportData, exportHeader, "SUMMARY");
        }

        function exportCsv(rows, header, type) {

            var csvContent = "data:text/csv;charset=utf-8,";

            var data = rows.map(obj => Object.values(obj));
            var finalArray = [];
            finalArray.push(header);

            data.forEach(function (objdata) {
                finalArray.push(objdata);
            });
            finalArray.forEach(function (rowArray) {
                var row = rowArray.join(",");
                csvContent += row + "\r\n";
            });

            var exportFileName = "SAP_HCM_EXTRACT_" + type;

            var encodedUri = encodeURI(csvContent);
            var link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", exportFileName + ".csv");
            document.body.appendChild(link); // Required for FF
            link.click(); // This will download the data file named "my_data.csv".
        }

        var FormComponents = function () {

            var handlejQueryUIDatePickers = function () {
                $(".ui-date-picker").datepicker();
            }

            var handleDateTimePickers = function () {

                if (jQuery().datepicker) {
                    $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
                }

                if (jQuery().timepicker) {
                    $('.timepicker-default').timepicker();
                    $('.timepicker-24').timepicker({
                        minuteStep: 1,
                        showSeconds: true,
                        showMeridian: false
                    });
                }

                if (!jQuery().daterangepicker) {
                    return;
                }

                $('.date-range').daterangepicker(
                    {
                        opens: (App.isRTL() ? 'left' : 'right'),
                        format: 'dd-mm-yyyy',
                        separator: ' to ',
                        startDate: Date.today().add({
                            days: -29
                        }),
                        endDate: Date.today(),
                        minDate: '01-01-2000',
                        maxDate: '31-12-2999',
                    }
                );

                $('#form-date-range').daterangepicker({
                    ranges: {
                        'Today': ['today', 'today'],
                        'Yesterday': ['yesterday', 'yesterday'],
                        'Last 7 Days': [Date.today().add({
                            days: -6
                        }), 'today'],
                        'Last 29 Days': [Date.today().add({
                            days: -29
                        }), 'today'],
                        'This Month': [Date.today().moveToFirstDayOfMonth(), Date.today().moveToLastDayOfMonth()],
                        'Last Month': [Date.today().moveToFirstDayOfMonth().add({
                            months: -1
                        }), Date.today().moveToFirstDayOfMonth().add({
                            days: -1
                        })]
                    },
                    opens: (App.isRTL() ? 'left' : 'right'),
                    format: 'yyyy-mm-dd',
                    separator: ' to ',
                    startDate: Date.today().add({
                        days: -29
                    }),
                    endDate: Date.today(),
                    minDate: '2012-01-01',
                    maxDate: '2999-01-01',
                    locale: {
                        applyLabel: 'Submit',
                        fromLabel: 'From',
                        toLabel: 'To',
                        customRangeLabel: 'Custom Range',
                        daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
                        monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                        firstDay: 1
                    },
                    showWeekNumbers: true,
                    buttonClasses: ['btn-danger']
                },

                    function (start, end) {
                        $('#form-date-range span').html(start.toString('MMMM d, yyyy') + ' - ' + end.toString('MMMM d, yyyy'));
                    });

                $('#form-date-range span').html(Date.today().add({
                    days: -29
                }).toString('MMMM d, yyyy') + ' - ' + Date.today().toString('MMMM d, yyyy'));


                if (!jQuery().datepicker || !jQuery().timepicker) {
                    return;
                }
            }

            var handleInputMasks = function () {
                $.extend($.inputmask.defaults, {
                    'autounmask': true
                });

                $("#txtFromDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
                $("#txtToDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
            }

            return {
                //main function to initiate the module
                init: function () {
                    handlejQueryUIDatePickers();
                    handleDateTimePickers();
                    //  handleInputMasks();
                }

            };

        }();
        ////////END OF FORM COMPONENTS////////

    </script>
</asp:Content>
