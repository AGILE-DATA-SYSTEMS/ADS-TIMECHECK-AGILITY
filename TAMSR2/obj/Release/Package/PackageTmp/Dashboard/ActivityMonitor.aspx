<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityMonitor.aspx.cs" Inherits="TAMSR2.Dashboard.ActivityMonitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title><%=Resources.Resource.activityMonitor %> - <%=Resources.Resource.applicationName %> </title>
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/linecons/css/linecons.css'>
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/fontawesome-4.2.0/css/font-awesome.min.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>//plugins/jquery-ui/jquery-ui-1.10.1.custom.min.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/css/tams-dashboard.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />

    <style>
        .tile {
            display: block;
            letter-spacing: 0.02em;
            float: left;
            height: 180px;
            width: 204px !important;
            cursor: pointer;
            text-decoration: none;
            color: #ffffff;
            position: relative;
            font-weight: 300;
            font-size: 12px;
            letter-spacing: 0.02em;
            line-height: 26px;
            font-smooth: always;
            overflow: hidden;
            border: 4px solid transparent;
            margin: 0 10px 10px 0;
        }

            .tile .tile-body > i {
                margin-top: 40px;
                display: block;
                font-size: 56px;
                text-align: center;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                        <p>THEME COLOR</p>
                        <ul class="inline">
                            <li class="color-black current color-default" data-style="default"></li>
                            <li class="color-blue" data-style="blue"></li>
                            <li class="color-brown" data-style="brown"></li>
                            <li class="color-purple" data-style="purple"></li>
                            <li class="color-white color-light" data-style="light"></li>
                        </ul>
                        <label class="hidden-phone">
                            <input type="checkbox" class="header" checked value="" />
                            <span class="color-mode-label">Fixed Header</span>
                        </label>
                    </div>
                </div>
                <!-- END BEGIN STYLE CUSTOMIZER -->
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title" style="margin: 0px;" runat="server" id="pgTitle">
                    <small><%=Resources.Resource.activityMonitor %></small>
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("../Common/Home") %>'><%=Resources.Resource.home %> </a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.activityMonitor %> </a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <div id="dashboard" style="width: 99%;" class="tams-dashboard">


            <!-- Dashboard Filters  Starts -->
            <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_FILTERS) == true)
                { %>
            <div id="divTeam">
                <div class="box row" style="width: 102.1% !important;">
                    <div class="panel-heading">
                        <div class="panel-heading-text">
                            <h3 class="panel-title"><%= Resources.Resource.filters %></h3>
                        </div>

                        <div class="panel-control">
                            <div class="btn-group">
                                <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus"></i></button>

                            </div>
                        </div>
                    </div>
                    <div class="panel-body" style="margin-left: -6%;">
                        <form class="form-horizontal">
                            <div class="row-fluid">
                                <div class="span4">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.organization %> </label>
                                        <div class="controls chzn-controls">
                                            <select id="ddOrg" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="span4">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.manager %>  </label>
                                        <div class="controls">

                                            <select id="ddMgr" name="mgr" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.manage %>">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="span4">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.employee %> </label>
                                        <div class="controls chzn-controls">
                                            <select id="ddEmp" name="emp" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>">
                                                <option value=""></option>
                                            </select>


                                        </div>
                                    </div>
                                </div>
                                <div class="span4">
                                    <div class="control-group">
                                        <label class="control-label">Zone </label>
                                        <div class="controls chzn-controls">
                                            <select id="ddZone" name="zone" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.zones %>">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="span4">
                                    <div class="control-group">
                                        <label class="control-label">Buildings </label>
                                        <div class="controls chzn-controls">
                                            <select id="ddBuilding" name="building" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.building %>">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="span3" style="display: none;">
                                    <a class="btn green pull-<%= pullDirectionStr%>" id="btnSearch" style="background-color: #1d943b !important; color: #fff !important;" data-toggle="modal"><%=Resources.Resource.apply %></a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>

            <!-- Dashboard Filters  Ends -->
            <div class="row" style="padding-left: 15px !important;">
                <div class="row-fluid">
                    <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ATTENDANCE_ACTIVITY) == true)
                        { %>
                    <div class="span12" id="divAttendanceActivity">
                        <!-- BEGIN BASIC CHART PORTLET-->
                        <div class="span2">
                            <div class="tiles">
                                <div class="tile selected bg-green">
                                    <div class="tile-body">
                                        <i class="icon" style="color: white !important;" id="spnInCount"></i>
                                    </div>
                                    <div class="tile-object">
                                        <div class="name">
                                            <%=Resources.Resource.inCount %>
                                        </div>
                                    </div>
                                </div>
                                <div class="tile selected bg-red">
                                    <div class="tile-body">
                                        <i class="icon" style="color: white !important;" id="spnOutCount"></i>
                                    </div>
                                    <div class="tile-object">
                                        <div class="name">
                                            <%=Resources.Resource.outCount %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="span10">
                            <div class="portlet box red">
                                <div class="portlet-title">
                                    <div class="caption"><i class="icon-reorder"></i><%=Resources.Resource.attendanceActivity %></div>
                                    <div class="tools">
                                        <a href="javascript:;" class="collapse"></a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <div id="container-live-attendance" class="collapse" style="height: 304px; margin-top: 15px;"></div>

                                </div>
                            </div>
                            <!-- END BASIC CHART PORTLET-->
                        </div>
                    </div>
                    <% } %>
                </div>
                <div class="row-fluid">
                    <div class="span12" id="divLiveTransactions">
                        <!-- BEGIN BASIC CHART PORTLET-->
                        <div class="portlet box red">
                            <div class="portlet-title">
                                <div class="caption"><i class="icon-reorder"></i><%=Resources.Resource.movements %></div>
                                <div class="tools">
                                    <a href="javascript:;" class="collapse"></a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="table-responsive">
                                    <table class="table table-hover" id="sample_1">
                                        <thead>
                                            <tr style="background-color: #e8e3e3;">
                                                <th style="text-align: center;">
                                                    <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                                <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.reason %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.reader %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.transactionDate %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.userEntryFlag %></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- END BASIC CHART PORTLET-->
                    </div>
                </div>
            </div>
        </div>

    </div>




    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="../Styles/HighCharts/jquery.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="../Assets/<%= languageStr %>/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
   <script src="../Assets/<%= languageStr %>/plugins/excanvas.js"></script>
   <script src="../Assets/<%= languageStr %>/plugins/respond.js"></script>  
   <![endif]-->
    <script src="../Assets/<%= languageStr %>/plugins/breakpoints/breakpoints.js" type="text/javascript"></script>
    <!-- IMPORTANT! jquery.slimscroll.min.js depends on jquery-ui-1.10.1.custom.min.js -->
    <script src="../Assets/<%= languageStr %>/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.cookie.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="../Assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery-easy-pie-chart/jquery.easy-pie-chart.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/gritter/js/jquery.gritter.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.pulsate.min.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/flot/jquery.flot.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/flot/jquery.flot.resize.js" type="text/javascript"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>


    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="../Assets/<%= languageStr %>/scripts/app.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/scripts/index.js" type="text/javascript"></script>
    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>


    <script src="../Scripts/jquery.loadmask.js"></script>

    <!-- 1. Include jQuery and Highcharts scripts. -->
    <script src="../Styles/HighCharts/highcharts.js" type="text/javascript"></script>
    <script src="../Styles/HighCharts/drilldown.js" type="text/javascript"></script>
    <script src="../Styles/HighCharts/piedrill.js"></script>

    <!-- END PAGE LEVEL SCRIPTS -->
    <script>
        var loadStep = 0;
        window.requestPageUrl = '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>';
        window.defaultDateFormat = "yyyy-mm-dd";



        $(document).ready(function () {
            LoadZones();
            if (typeof String.prototype.trim != 'function') {
                String.prototype.trim = function () {
                    return this.replace(/^\s+|\s+$/g, '');
                }
            }
            if (checkbrowser()) {
                $('#ui-datepicker-div').addClass("datepicker-IE");
            }
        });
        jQuery(document).ready(function () {

            App.init(); // initlayout and core plugins 


            Index.init();

            LoadEmployees();
            LoadOrganizations();
            LoadManager();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liDashboard").addClass("active");
            $("#liDashboard .arrow").addClass("open");
            $("#liActivityMonitor").addClass("active");


            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

            $("[data-widget='collapse']").click(function () {
                //Find the box parent        
                var box = $(this).parents(".box").first();
                //Find the body and the footer
                var bf = box.find(".panel-body");
                if (!box.hasClass("collapsed-box")) {
                    box.addClass("collapsed-box");
                    bf.slideUp();
                } else {
                    box.removeClass("collapsed-box");
                    bf.slideDown();
                }
            });


            var currentDate = new Date()
            var day = currentDate.getDate()
            var month = currentDate.getMonth() + 1
            var year = currentDate.getFullYear();
            if (day < 10)
                day = "0" + day;
            if (month < 10)
                month = "0" + month;
            $("#spnMovementDate").html(day + "-" + month + "-" + year);




            if (!$('#trendsAndPercentage').is(":visible")) {
                $('#statswidgets').addClass('widget-full-width');
                $('#statswidgets .col-sm-3.col-lg-6').addClass('widget-20per-width');
            }
            else
                $('#statswidgets').removeClass('tams-widget');
            if ($('#container-live-attendance') && $('#container-live-attendance').length > 0) {
                BindPresentStatus();
            }
            if ($('#container-data-process-activity') && $('#container-data-process-activity').length > 0) {
                GetDataProcessActivity();
            }

        });

        $("#ddZone").change(function () {
            LoadBuildings();
        });
        $("#ddBuilding").change(function () {
            LoadGrid();
        });
        $("#ddOrg").change(function () {
            LoadManager();
            LoadEmployees();
        });

        $("#ddMgr").change(function () {
            LoadEmployees();
        });


        $("#ddEmp").change(function () {
            LoadTransactionCount();
            LoadGrid();
        });

        ////----------------------------/////////


        function LoadManager() {
            $("#spnErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_FILTERS) == false)
        { %>
            return;
                 <% } %>
            var includeInactive = $("#chkboxIncludeInActive").is(":checked");

            if (includeInactive == true || includeInactive == 'true')
                includeInactive = 1;
            else
                includeInactive = 0;

            var d = "key=getMgrIdNameListString&orgID=" + $("#ddOrg").val() + "&includeInactive=" + includeInactive;
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                success: function (html) {

                    $("#ddMgr").html(html);
                    $("#ddMgr").trigger("liszt:updated");

                },
                error: function (html) {
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    $("#spnErrorMsg").css("display", "block");
                }
            });
        }

        function LoadOrganizations() {

                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_FILTERS) == false)
        { %>
                return;
                 <% } %>

                var includeInactive = $("#chkboxIncludeInactiveOrgs").is(":checked");

                if (includeInactive == true || includeInactive == 'true')
                    includeInactive = 1;
                else
                    includeInactive = 0;
                var d = "key=getIdNameListString&includeInactive=" + includeInactive;
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                        success: function (html) {
                            $("#ddOrg").html(html);
                            $("#ddOrg").trigger("liszt:updated");
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

                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_FILTERS) == false)
        { %>
                     return;
                 <% } %>
                     var orgVal = $("#ddOrg").val();
                     var ParentID = $("#ddOrg").val();
                     var includeInactive = $("#chkboxIncludeInActive").is(":checked");
                     var ManagerId = $("#ddMgr").val();
                     if (ManagerId == 'Undefined' || ManagerId == 'undefined' || ManagerId == undefined)
                         ManagerId = '';

                     if (includeInactive == true || includeInactive == 'true')
                         includeInactive = 1;
                     else
                         includeInactive = 0;

                     var d = "key=getIdNameListByOrgID&orgID=" + $("#ddOrg").val() + "&managerID=" + ManagerId + "&includeInactive=" + includeInactive;

                     $.ajax({
                         type: 'POST',
                         data: d,
                         url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                    success: function (html) {
                        $("#ddEmp").html(html)
                        $("#ddEmp").trigger("liszt:updated");
                        LoadTransactionCount();
                        LoadGrid();
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        ///

        function BindDataProcessActivity(statusArray, queueArray) {
            var colorList = {
                blue: "#5fb4ef",
                purple: "#7c38bc",
                orange: "#ff851b",
                red: "#cc3f44",
                green: "#a1c436"

            };
            var categories = [];//['Roster'] // get dynamics modules
            var series = [];//[{name: 'Pending',data: [5]}, {name: 'Sucessfull',data: [2]}, {name: 'Failed',data: [3]},{name: 'Processing',data: [3]}]
            for (var i = 0; i < queueArray.length; i++) {
                if (categories.indexOf(queueArray[i].ModuleName) === -1) {
                    categories.push(queueArray[i].ModuleName);

                }
            }
            var color;
            for (var i = 0; i < statusArray.length; i++) {
                if (statusArray[i].StatusId === 0) { color = colorList.blue; }
                else if (statusArray[i].StatusId === 1) { color = colorList.green; }
                else if (statusArray[i].StatusId === 2) { color = colorList.red; }
                else if (statusArray[i].StatusId === 3) { color = colorList.purple; }
                else { color = color.orange; }
                series.push({ name: statusArray[i].Description, StatusId: statusArray[i].StatusId, data: [], color: color });
            }

            for (var i = 0; i < categories.length; i++) {
                var category = categories[i];//module

                for (var j = 0; j < statusArray.length; j++) {

                    var statusId = statusArray[j].StatusId; //status

                    var statusCount = 0;
                    for (var k = 0; k < queueArray.length; k++) {

                        if (category === queueArray[k].ModuleName && statusId === queueArray[k].Status) {
                            statusCount++;
                        }

                    }

                    series[j].data.push(statusCount);
                }
            }

            $('#container-data-process-activity').highcharts({
                chart: {
                    type: 'column',
                },
                title: {
                    text: ''
                },
                xAxis: {
                    categories: categories
                },
                plotOptions: {
                    column: {
                        stacking: 'normal',
                        dataLabels: {
                            enabled: true,
                            color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
                            style: {
                                textShadow: '0 0 3px black'
                            }
                        }
                    }
                },
                series: series

            });
        }

        function GetDataProcessActivity() {
            var d = "key=getDataReprocessActivity";
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>',
                success: function (response) {

                    var data = $.parseJSON(response);

                    BindDataProcessActivity(data[0], data[1]);
                },
                error: function (html) {

                }
            });

        };
        function imposeMaxLength(Object, evt, MaxLen) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
            return (Object.value.length < MaxLen);
        }

        function ReloadDashboard() {
            loadStep = 0;
            //LoadGrid();
            //LoadDashboard();
            //LoadGroupVoilations();
            $("ul.nav-tabs li.active a").click();

        }
        var activityClosure = {
            activityLastTransactionTime: '<%=  DateTime.UtcNow.AddHours(TAMSR2Framework.DAL.AppSetting.defaultTimeZone).ToString("yyyy-MM-dd") %>',
            totalCount: 0,
            ActiveEmpIds: [],
            toolTipHtml: ""

        };


        function BindPresentStatus() {
            $('#container-live-attendance').highcharts({
                chart: {
                    type: 'spline',
                    animation: Highcharts.svg, // don't animate in old IE
                    marginRight: 10,
                    events: {
                        load: RequestData
                    }
                },

                title: {
                    text: ''
                },
                xAxis: {
                    type: 'datetime',
                    tickPixelInterval: 150,
                    maxZoom: 20 * 1000
                },
                yAxis: {
                    allowDecimals: false,
                    title: {
                        text: '<%=Resources.Resource.msgAttendanceActivity %>',
                        style: {
                            fontSize: '13px'
                        }
                    },
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                tooltip: {
                    formatter: function () {
                        activityClosure.toolTipHtml = "";

                        if (this.point.dataArray && this.point.dataArray.length > 0) {
                            for (var i = 0; i < this.point.dataArray.length; i++) {
                                activityClosure.toolTipHtml += "<span style='width:100px'><b>" + this.point.dataArray[i].employeeName + "</b></span>&nbsp;&nbsp;";
                                activityClosure.toolTipHtml += "<img src=" + this.point.dataArray[i].activityImage + " />";
                                activityClosure.toolTipHtml += "<br />"


                            }
                            activityClosure.toolTipHtml += "Time :" + Highcharts.dateFormat('%H:%M:%S', this.x)
                            return activityClosure.toolTipHtml;
                        }
                        else {
                            return '<b>' + this.series.name + '</b><br/>Time : ' +
                                Highcharts.dateFormat('%H:%M:%S', this.x) + '<br/>' +
                                'No.:' + Highcharts.numberFormat(this.y, 0) + '';
                        }
                    },
                    useHTML: true,
                    shared: false

                },
                legend: {
                    enabled: false
                },
                exporting: {
                    enabled: false
                },
                series: [{
                    name: 'Attendance Activity',
                    data: [],
                    pointStart: 0
                }]
            });


        }


        /// Pending Count Charts 

        function LoadTransactionCount() {
            var dt = $("#txtDashboardDate").val();
            if (dt == "" || dt == "Select date..." || dt == undefined || dt == 'undefined') {
                dt = '<%= DateTime.UtcNow.AddHours(TAMSR2Framework.DAL.AppSetting.defaultTimeZone).ToString("yyyy-MM-dd") %>';
            }

            var emp = $("#ddEmp").val();
            var mgr = $("#ddMgr").val();
            var org = $("#ddOrg").val();

            var d = "key=getTransactionCount&dt=" + dt + "&emp=" + emp + "&mgr=" + mgr + "&org=" + org;
            $.ajax({
                type: 'GET',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardActivityMonitorPage.aspx") %>',
                success: function (html) {
                    var j = $.parseJSON(html);

                    $("#spnInCount").html(j.InCount);
                    $("#spnOutCount").html(j.OutCount);
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function RequestData() {
            var chart = $('#container-live-attendance').highcharts();
            var dt = $("#txtDashboardDate").val();
            if (dt == "" || dt == "Select date..." || dt == undefined || dt == 'undefined') {
                dt = '<%= DateTime.UtcNow.AddHours(TAMSR2Framework.DAL.AppSetting.defaultTimeZone).ToString("yyyy-MM-dd") %>';
    };
    var today = new Date();

    var d = "key=getAttendanceActivity";
    d += "&dt=" + dt + "&activityLastTransactionTime=" + activityClosure.activityLastTransactionTime;
    $.ajax({
        type: 'POST',
        data: d,
        url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardActivityMonitorPage.aspx") %>',
        success: function (html) {
            var result = $.parseJSON(html);
            var x = (new Date()).getTime() + 240 * 60000; // current time
            if (result.length > 0) {
                activityClosure.toolTipHtml = "";
                var point = 0;

                var series = chart.series[0],
                    shift = series.data.length > 20;

                var dataArray = [];
                // counter

                var inCount = 0;

                var InArray = [];
                var outArray = [];
                for (var i = 0; i < result.length; i++) {
                    if (result[i].ReasonMode == 1) {
                        InArray.push(result[i]);
                    }
                    else {
                        outArray.push(result[i]);
                    }
                }

                for (var i = 0; i < InArray.length; i++) {
                    if (activityClosure.ActiveEmpIds.indexOf(InArray[i].EmployeeId) === -1) {
                        activityClosure.ActiveEmpIds.push(InArray[i].EmployeeId);
                    }
                }

                for (var i = 0; i < outArray.length; i++) {
                    var index = activityClosure.ActiveEmpIds.indexOf(outArray[i].EmployeeId);
                    if (index !== -1) {
                        activityClosure.ActiveEmpIds.splice(index, 1);
                    }
                }

                activityClosure.totalCount = activityClosure.ActiveEmpIds.length;

                //end counter logic

                for (var i = 0; i < result.length; i++) {
                    if (result[i].ReasonMode == 1) {

                        //activityClosure.totalCount = activityClosure.totalCount + 1;

                        dataArray.push({
                            employeeName: result[i].EmployeeName, activityImage:
                               '../assets/<%= languageStr %>/img/activity_in.png'
                        });
                    }
                    else {
                        //activityClosure.totalCount = activityClosure.totalCount - 1;
                        //if (activityClosure.totalCount <= 0) activityClosure.totalCount = 0;
                        dataArray.push({
                            employeeName: result[i].EmployeeName, activityImage:
                                   '../assets/<%= languageStr %>/img/activity_out.png'
                        });
                    }
                }

                chart.series[0].addPoint({ x: x, y: activityClosure.totalCount, dataArray: dataArray, isToolTipRendered: false }, true, shift);
                result = result.sort(function (a, b) {
                    return b.Transaction_Time - a.Transaction_Time;
                });

                activityClosure.activityLastTransactionTime = result[result.length - 1].Transaction_Time;
            }
            else {
                chart.series[0].addPoint({ x: x, y: activityClosure.totalCount, dataArray: [] }, true, shift);
                //   activityClosure.activityLastTransactionTime = new Date();
            }

            // GetReaderTransactionsCount(); 
            LoadGrid();
            LoadTransactionCount();
            setTimeout(RequestData, 300000);
        },
        error: function (html) {
            $("#divErrorMsg").css("display", "block");
            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                },
                cache: false
            });


        };


        function LoadGrid() {
            var fromDate = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
            var toDate = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';

            var emp = $("#ddEmp").val();
            var mgr = $("#ddMgr").val();
            var org = $("#ddOrg").val();
            var zone = $("#ddZone").val();
            var building = $("#ddBuilding").val();

            var wc = "&empID=" + emp + "&mgrID=" + mgr + "&orgID=" + org + "&zoneID=" + zone + "&buildingID=" + building;

            if (fromDate == "" || toDate == "")
                return;

            var urlStr = '<%= Page.ResolveClientUrl("~/RequestPages/TAEventPage.aspx?key=getAll") %>' + '&fromDate=' + fromDate + '&toDate=' + toDate + wc;

            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bFilter": false,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                    { "bSortable": false, sWidth: "5%" },
                    { "bSortable": true, sWidth: "7%" },
                    { "bSortable": true, sWidth: "20%" },
                    { "bSortable": true, sWidth: "15%" },
                    { "bSortable": true, sWidth: "20%" },
                    { "bSortable": true, sWidth: "15%" },
                    { "bSortable": true, sWidth: "15%" }
                ],
                "oLanguage": {
                    "sLengthMenu": "_MENU_ <%=Resources.Resource.recordsPerPage %>",
                    "sProcessing": "<%=Resources.Resource.processing %>...",
                    "sZeroRecords": "<%=Resources.Resource.noRecordFound %>",
                    "sInfo": "<%=Resources.Resource.showing %> _START_ <%=Resources.Resource.to %> _END_ <%=Resources.Resource.of %> _TOTAL_ <%=Resources.Resource.records %>",
                    "sSearch": "<%=Resources.Resource.search %>:",
                    "sUrl": "",
                    "oPaginate": {
                        "sFirst": "<%=Resources.Resource.first %>",
                        "sPrevious": "<%=Resources.Resource.previous %>",
                        "sNext": "<%=Resources.Resource.next %>",
                        "sLast": "<%=Resources.Resource.last %>"
                    }
                },
                "aaSorting": [[5, "desc"]],
                "sAjaxSource": urlStr
            });
        }

        function checkbrowser() {

            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");

            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))  // If Internet Explorer, return version number
            {
                return true
            }
            else  // If another browser, return 0
            {
                return false;
            }

            return false;
        }

        function LoadZones() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_FILTERS) == false)
        { %>
            return;
                 <% } %>

            var d = "key=getZonesList";

            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                  success: function (html) {
                      $("#ddZone").html(html)
                      $("#ddZone").trigger("liszt:updated");
                  },
                  error: function (html) {
                      $("#divErrorMsg").css("display", "block");
                      $("#spnErrorMsg").css("display", "block");
                      $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadBuildings() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_FILTERS) == false)
        { %>
            return;
                 <% } %>
            var ZoneId = $("#ddZone").val();
            var d = "key=getBuildingsListByZone&zoneID=" + ZoneId;

            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                        success: function (html) {
                            $("#ddBuilding").html(html)
                            $("#ddBuilding").trigger("liszt:updated");
                        },
                        error: function (html) {
                            $("#divErrorMsg").css("display", "block");
                            $("#spnErrorMsg").css("display", "block");
                            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   }
               });
           }
          
    </script >
</asp:Content>
