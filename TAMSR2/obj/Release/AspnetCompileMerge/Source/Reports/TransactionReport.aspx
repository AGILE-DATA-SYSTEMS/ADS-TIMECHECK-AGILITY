<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TransactionReport.aspx.cs" Inherits="TAMSR2.Reports.TransactionReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.transactionReport %> - <%=Resources.Resource.applicationName %></title>
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

        .widthtbl {
            text-align: center;
            width: 150px
        }
    </style>

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
                    <%=Resources.Resource.transactionReport %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.report %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.transactionReport %></a></li>

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
                    </div>

                    <div class="row-fluid">
                        <div class="span12">
                            <div class="row-fluid">
                                <!--/span-->
                                <div class="span6" style="display:none;">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.manager %><span class="required">*</span></label>
                                        <div class="controls chzn-controls">
                                            <select id="ddManager" order="2" hide="1" name="Group" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.manager %>">
                                                <option value=""></option>
                                            </select>

                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="span6" style="display:none;">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.employee %><span class="required">*</span></label>
                                        <div class="controls chzn-controls">
                                            <select id="ddEmp" order="3" hide="1" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/row-->
                            <div class="row-fluid">

                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                        <div class="controls chzn-controls">
                                            <select id="ddOrg" order="1" hide="0" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.year %><span class="required">*</span></label>
                                        <div class="controls chzn-controls">
                                            <select id="ddYear" order="4" hide="0" name="year" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->

                            </div>

                            <div class="row-fluid">
                                <div class="span6">

                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.month %></label>
                                        <div class="controls chzn-controls">

                                            <select id="ddMonth" order="5" hide="0" name="month" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.month %>">
                                                <option value=""></option>
                                                <option value="1"><%=Resources.Resource.january %></option>
                                                <option value="2"><%=Resources.Resource.february %></option>
                                                <option value="3"><%=Resources.Resource.march %></option>
                                                <option value="4"><%=Resources.Resource.april %></option>
                                                <option value="5"><%=Resources.Resource.may %></option>
                                                <option value="6"><%=Resources.Resource.june %></option>
                                                <option value="7"><%=Resources.Resource.july %></option>
                                                <option value="8"><%=Resources.Resource.august %></option>
                                                <option value="9"><%=Resources.Resource.september %></option>
                                                <option value="10"><%=Resources.Resource.october %></option>
                                                <option value="11"><%=Resources.Resource.november %></option>
                                                <option value="12"><%=Resources.Resource.december %></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">

                                        <div class="controls">
                                            <input id="cbShowDetail" type="checkbox" name="cbShowDetail" />
                                            Show Detail Report?
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/row-->
                </form>
                <!-- END FORM-->
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.transactionReport %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return LoadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="spnGridMsg">&nbsp;</span>
                            </div>
                            <div class="btn-group pull-<%= pullDirectionStr %>">
                                <span id="Span2" runat="server">
                                    <a id="btnExportToExcel" class="btn blue button-next" onclick="ExportTableToExcel();" style="margin-right: 10px;">&nbsp; <%=Resources.Resource.exportExcel %>&nbsp;<i class="m-icon-swapright m-icon-white"></i></a>
                                    <a id="btnProcess" class="btn icn-only green" onclick="LoadGrid();" style="margin-right: 10px;">&nbsp; <%=Resources.Resource.showReport %>&nbsp;<i class="m-icon-swapright m-icon-white"></i></a>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div style="overflow-x: auto;">
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                                <tr style="background-color: #e8e3e3;">
                                    <th class="widthtbl"><%=Resources.Resource.employeeNumber %></th>
                                    <th class="widthtbl"><%=Resources.Resource.employeeName %></th>
                                    <th style=""><%=Resources.Resource.organization %></th>
                                    <%--                                    <th class="widthtbl">1</th>
                                    <th class="widthtbl">2</th>
                                    <th class="widthtbl">3</th>
                                    <th class="widthtbl">4</th>
                                    <th class="widthtbl">5</th>
                                    <th class="widthtbl">6</th>
                                    <th class="widthtbl">7</th>
                                    <th class="widthtbl">8</th>
                                    <th class="widthtbl">9</th>
                                    <th class="widthtbl">10</th>
                                    <th class="widthtbl">11</th>
                                    <th class="widthtbl">12</th>
                                    <th class="widthtbl">13</th>
                                    <th class="widthtbl">14</th>
                                    <th class="widthtbl">15</th>
                                    <th class="widthtbl">16</th>
                                    <th class="widthtbl">17</th>
                                    <th class="widthtbl">18</th>
                                    <th class="widthtbl">19</th>
                                    <th class="widthtbl">20</th>
                                    <th class="widthtbl">21</th>
                                    <th class="widthtbl">22</th>
                                    <th class="widthtbl">23</th>
                                    <th class="widthtbl">24</th>
                                    <th class="widthtbl">25</th>
                                    <th class="widthtbl">26</th>
                                    <th class="widthtbl">27</th>
                                    <th class="widthtbl">28</th>
                                    <th class="widthtbl">29</th>
                                    <th class="widthtbl">30</th>
                                    <th class="widthtbl">31</th>--%>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- END EXAMPLE TABLE PORTLET-->
        </div>
        <!-- END PAGE CONTENT-->
        <!-- END PAGE CONTAINER-->
    </div>
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
    <%--<script src="../Assets/En/plugins/TableToExcel/tableToExcel.js"></script>--%>
    <script src="../Assets/En/plugins/tableexport-xls-bold-headers/tableexport-xls-bold-headers.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">

        var summaryResult = [];

        $(document).ready(function () {
            App.init(); // initlayout and core plugins

            //alert(typeof String.prototype.trim);
            if (typeof String.prototype.trim != 'function') {
                String.prototype.trim = function () {
                    return this.replace(/^\s+|\s+$/g, '');
                }
            }
            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liRpt").addClass("active");
            $("#liRpt .arrow").addClass("open");
            $("#liTransactionRpt").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

            $("#divSuccessMsg").css("display", "none");
            $("#divErrorMsg").css("display", "none");


            LoadOrganizations();
            LoadYears();
            $("#ddOrg").change(function () {

                LoadManager();
                LoadEmployees();
            });
            $("#ddManager").change(function () {
                LoadEmployees();
            });


        });


        function LoadGrid() {
            $('#sample_1 tbody').html("");

            var RptType = "summary";
            var EmpID = $("#ddEmp option:selected").val();
            var Year = $("#ddYear option:selected").val();
            var Month = $("#ddMonth option:selected").val();
            var Org = $("#ddOrg option:selected").val();
            var MgrId = $("#ddManager option:selected").val();
            if ($('#cbShowDetail').is(":checked")) {
                RptType = "detail";
            }

            var d = "key=TransactionRpt&Org=" + Org + "&Year=" + Year + "&Month=" + Month + "&EmpID=" + EmpID + "&MgrId=" + MgrId + "&ReportType=" + RptType;
            var url = '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>';

            $.ajax({
                type: 'POST',
                url: url,
                data: d,
                success: function (html) {
                    var weekDay = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                    var data = $.parseJSON(html);
                    summaryResult = data;
                    //Add days header to table 
                    var header = '<th class="widthtbl dynamicCols">1' + weekDay[(new Date($('#ddMonth').val() + ' / 01 / ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">2' + weekDay[(new Date($('#ddMonth').val() + ' / 02 / ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">3' + weekDay[(new Date($('#ddMonth').val() + ' / 03/ ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">4' + weekDay[(new Date($('#ddMonth').val() + ' / 04/ ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">5' + weekDay[(new Date($('#ddMonth').val() + ' / 05/ ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">6' + weekDay[(new Date($('#ddMonth').val() + ' / 06/ ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">7' + weekDay[(new Date($('#ddMonth').val() + ' / 07/ ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">8' + weekDay[(new Date($('#ddMonth').val() + ' / 08/ ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">9' + weekDay[(new Date($('#ddMonth').val() + ' / 09/ ' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">10' + weekDay[(new Date($('#ddMonth').val() + '/ 10/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">11' + weekDay[(new Date($('#ddMonth').val() + '/ 11/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">12' + weekDay[(new Date($('#ddMonth').val() + '/ 12/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">13' + weekDay[(new Date($('#ddMonth').val() + '/ 13/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">14' + weekDay[(new Date($('#ddMonth').val() + '/ 14/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">15' + weekDay[(new Date($('#ddMonth').val() + '/ 15/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">16' + weekDay[(new Date($('#ddMonth').val() + '/ 16/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">17' + weekDay[(new Date($('#ddMonth').val() + '/ 17/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">18' + weekDay[(new Date($('#ddMonth').val() + '/ 18/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">19' + weekDay[(new Date($('#ddMonth').val() + '/ 19/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">20' + weekDay[(new Date($('#ddMonth').val() + '/ 20/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">21' + weekDay[(new Date($('#ddMonth').val() + '/ 21/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">22' + weekDay[(new Date($('#ddMonth').val() + '/ 22/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">23' + weekDay[(new Date($('#ddMonth').val() + '/ 23/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">24' + weekDay[(new Date($('#ddMonth').val() + '/ 24/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">25' + weekDay[(new Date($('#ddMonth').val() + '/ 25/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">26' + weekDay[(new Date($('#ddMonth').val() + '/ 26/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">27' + weekDay[(new Date($('#ddMonth').val() + '/ 27/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">28' + weekDay[(new Date($('#ddMonth').val() + '/ 28/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">29' + weekDay[(new Date($('#ddMonth').val() + '/ 29/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">30' + weekDay[(new Date($('#ddMonth').val() + '/ 30/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols">31' + weekDay[(new Date($('#ddMonth').val() + '/ 31/' + $('#ddYear').val())).getDay()] + '</th>';
                    header += '<th class="widthtbl dynamicCols TimeStamp" style="display:none;">' + data[0].CurrentTimeStamp + '</th>';
                    $('.dynamicCols').remove();

                    $('#sample_1 thead tr').append(header);
                    if ($('#sample_1+.row-fluid').find('.dataTables_info').length > 0) {
                        $('#sample_1').DataTable().fnDestroy();
                    }
                    $('#sample_1 tbody').empty();
                    for (var i = 0; i < data.length; i++) {
                        var date = new Date();
                        $('#sample_1 tbody').append(
                            "<tr>"
                            + "<td>" + data[i].EmployeeNumber + "</td>"
                            + "<td>" + data[i].EmployeeName + "</td>"
                            + "<td>" + data[i].DepartmentName + "</td>"
                            + "<td>" + data[i].Col1 + "</td>"
                            + "<td>" + data[i].Col2 + "</td>"
                            + "<td>" + data[i].Col3 + "</td>"
                            + "<td>" + data[i].Col4 + "</td>"
                            + "<td>" + data[i].Col5 + "</td>"
                            + "<td>" + data[i].Col6 + "</td>"
                            + "<td>" + data[i].Col7 + "</td>"
                            + "<td>" + data[i].Col8 + "</td>"
                            + "<td>" + data[i].Col9 + "</td>"
                            + "<td>" + data[i].Col10 + "</td>"
                            + "<td>" + data[i].Col11 + "</td>"
                            + "<td>" + data[i].Col12 + "</td>"
                            + "<td>" + data[i].Col13 + "</td>"
                            + "<td>" + data[i].Col14 + "</td>"
                            + "<td>" + data[i].Col15 + "</td>"
                            + "<td>" + data[i].Col16 + "</td>"
                            + "<td>" + data[i].Col17 + "</td>"
                            + "<td>" + data[i].Col18 + "</td>"
                            + "<td>" + data[i].Col19 + "</td>"
                            + "<td>" + data[i].Col20 + "</td>"
                            + "<td>" + data[i].Col21 + "</td>"
                            + "<td>" + data[i].Col22 + "</td>"
                            + "<td>" + data[i].Col23 + "</td>"
                            + "<td>" + data[i].Col24 + "</td>"
                            + "<td>" + data[i].Col25 + "</td>"
                            + "<td>" + data[i].Col26 + "</td>"
                            + "<td>" + data[i].Col27 + "</td>"
                            + "<td>" + data[i].Col28 + "</td>"
                            + "<td>" + data[i].Col29 + "</td>"
                            + "<td>" + data[i].Col30 + "</td>"
                            + "<td>" + data[i].Col31 + "</td>"
                            + "<td class='TimeStamp' style='display:none;'>" + data[i].CurrentTimeStamp + "</td>"
                            + "</tr>");
                    }
                    if ($('#sample_1+.row-fluid').find('.dataTables_info').length <= 0) {
                        $('#sample_1').dataTable({
                            "scrollX": true
                        });
                    }
                    else {
                        $('#sample_1').DataTable().fnDestroy();
                        $('#sample_1').dataTable({
                            "scrollX": true
                        });

                    }
                },
                error: function (html) {

                }
            });


        }

        function LoadOrganizations() {
            var d = "key=getIdNameListString";

            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    $("#ddOrg").html(html);
                    $('#ddOrg option[value=<%= Session["orgID"] %>]').attr('selected', 'selected');
                    $("#ddOrg").trigger("liszt:updated");
                    LoadManager();
                    LoadEmployees();
                    // LoadGrid();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadEmployees() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var d = "key=getIdNameListByOrgID&orgID=" + $("#ddOrg").val() + "&managerID=" + $("#ddManager").val();
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    $("#ddEmp").html(html);
                    $("#ddEmp").trigger("liszt:updated");
                    //LoadGrid();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadManager() {
            $("#page-content").mask("<%=Resources.Resource.processing %>" + "....");
            $("#spnErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var d = "key=getMgrIdNameListString&orgID=" + $("#ddOrg").val();
            $("#page-content").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                success: function (html) {

                    $("#page-content").unmask();
                    $("#ddManager").html(html);
                    $("#ddManager").trigger("liszt:updated");

                },
                error: function (html) {
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    $("#page-content").unmask();
                    $("#spnErrorMsg").css("display", "block");
                    $("#btnAlertError").click();
                }
            });
        }

        function LoadYears() {
            var curMonth = new Date().getMonth() + 1;
            $('#ddMonth option[value=' + curMonth + ']').attr('selected', 'selected');
            $("#ddMonth").trigger("liszt:updated");
            var curYear = new Date().getFullYear();
            var k = curYear - 2;
            var val = curYear + 5;
            var temp = "<option value=''><%=Resources.Resource.choose %> &nbsp; <%=Resources.Resource.year %></option>";
            while (k <= val) {
                if (k == curYear) {
                    temp += "<option selected='selected' value='" + k + "'>" + k + "</option>";
                }
                else {
                    temp += "<option value='" + k + "'>" + k + "</option>";
                }
                k++;
            }
            $("#ddYear").html(temp);
            $("#ddYear").trigger("liszt:updated");
        }
        function ExportTableToExcel() {
            //TableToExcel.convert(document.getElementById("sample_1"), {
            //    name: "TransactionReport.xlsx",
            //    sheet: {
            //        name: "Sheet1"
            //    }
            //});
            $('#sample_1').tableExport({
                type: 'excel',
                escape: 'false',
                filename: 'TransactionReport.xls'
            });
        }

        ////////END OF FORM COMPONENTS////////

    </script>
</asp:Content>
