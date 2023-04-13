<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TeamEfficiency.aspx.cs" Inherits="TAMSR2.Dashboard.TeamEfficiency" %>
  

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.teamEfficiency %> - <%=Resources.Resource.applicationName %> </title>

    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/linecons/css/linecons.css'>
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/fontawesome-4.2.0/css/font-awesome.min.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>//plugins/jquery-ui/jquery-ui-1.10.1.custom.min.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/css/tams-dashboard.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <style type="text/css">
        .modal {
            left: 45%;
            width: 800px;
        }
        .lnk {
            color: blue !important ;
        }
        .row-fluid .span2
        {
            width: 11.983% !important;
            }
        
        .sparkline-chart .number {
            width: auto;
        }spnTimeIn

        .SchTimeSpan {
            margin-left: 4px;
        }

        #sample_1 tbody td:nth-child(4) {
            display: none;
        }

        #sample_Late_Early.leave tbody tr td:nth-child(5) {
            display: none;
        }

        #sample_Late_Early.absent tbody tr td:nth-child(5) {
            display: none;
        }

        #sample_Late_Early.leave thead tr th:nth-child(5) {
            display: none;
        }

        #container-live-attendance .highcharts-tooltip span {
            width: 250px !important;
            overflow: auto;
            white-space: normal !important;
        }

        #sample_Late_Early.absent thead tr th:nth-child(5) {
            display: none;
        }

        .row {
            margin-left: 0px;
            margin-right: 0px;
        }

        #wrapper {
            /*padding-left: 70px;*/
            transition: all .4s ease 0s;
            height: 100%;
        }

        #sidebar-wrapper {
            /*margin-left: -150px;*/
            /*left: 70px;*/
            width: 150px;
            background: #808080;
            position: relative;
            height: 400px;
            /*z-index: 10000;*/
            transition: all .4s ease 0s;
        }

        #container-employeeefficiency rect {
            cursor: pointer;
        }

        .sidebar-nav {
            display: block;
            float: left;
            width: 150px;
            list-style: none;
            margin: 0;
            padding: 0;
            min-height: 400px;
            max-height: 400px;
            overflow-y: scroll;
        }

            .sidebar-nav::-webkit-scrollbar {
                width: 0 !important;
            }

        #page-content-wrapper {
            padding-left: 0;
            margin-left: 0;
            width: 100%;
            height: auto;
        }

        #wrapper.active {
            /*padding-left: 150px;*/
        }

            #wrapper.active #sidebar-wrapper {
                /*left: 150px;*/
            }

        #page-content-wrapper {
            width: 100%;
        }

        #sidebar_menu li a, .sidebar-nav li a {
            color: #999;
            display: block;
            float: left;
            text-decoration: none;
            width: 150px;
            background: #808080;
            border-top: 1px solid #373737;
            border-bottom: 1px solid #1A1A1A;
            -webkit-transition: background .5s;
            -moz-transition: background .5s;
            -o-transition: background .5s;
            -ms-transition: background .5s;
            transition: background .5s;
        }

        .sidebar_name {
            padding-top: 25px;
            color: #fff;
            opacity: .7;
        }

        .sidebar-nav li {
            line-height: 40px;
            text-indent: 20px;
            cursor: pointer;
        }

            .sidebar-nav li a {
                color: #999999;
                display: block;
                text-decoration: none;
            }

                .sidebar-nav li a:hover {
                    color: #fff;
                    background: #808080;
                    text-decoration: none;
                }

                .sidebar-nav li a:active,
                .sidebar-nav li a:focus {
                    text-decoration: none;
                }

        .sidebar-nav > .sidebar-brand {
            height: 65px;
            line-height: 60px;
            font-size: 18px;
        }

            .sidebar-nav > .sidebar-brand a {
                color: #999999;
            }

                .sidebar-nav > .sidebar-brand a:hover {
                    color: #fff;
                    background: none;
                }

        #main_icon {
            float: right;
            padding-right: 65px;
            padding-top: 20px;
        }

        .sub_icon {
            float: right;
            padding-right: 65px;
            padding-top: 10px;
        }

        .content-header {
            height: 65px;
            line-height: 65px;
        }

            .content-header h1 {
                margin: 0;
                margin-left: 20px;
                line-height: 65px;
                display: inline-block;
            }

        @media (max-width:767px) {
            #wrapper {
                /*padding-left: 70px;
                transition: all .4s ease 0s;*/
            }

            #sidebar-wrapper {
                /*left: 70px;*/
            }

            #wrapper.active {
                /*padding-left: 150px;*/
            }

                #wrapper.active #sidebar-wrapper {
                    left: 150px;
                    width: 150px;
                    transition: all .4s ease 0s;
                }
        }

        @media (min-width: 980px) {
            #page-content-wrapper .page-content {
                margin-left: 150px;
                margin-top: 0px;
                min-height: 350px;
            }
        }

        .src-image {
            display: none;
        }

        .tams-dashboard #page-content-wrapper .page-content [class^="col-"]:not(.pad-no) {
            padding-left: 0px;
            padding-right: 0;
        }

        #page-content-wrapper .page-content .card {
            text-align: center;
            background: #fff;
        }

        #page-content-wrapper .page-content {
            background: #fff;
        }

        .card .header-bg {
            /* This stretches the canvas across the entire hero unit */
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 70px;
            border-bottom: 1px #FFF solid;
            /* This positions the canvas under the text */
            z-index: 1;
        }

        .card .avatar {
            position: relative;
            margin-top: 2px;
            z-index: 100;
        }

            .card .avatar img {
                width: 70px;
                -webkit-border-radius: 50% !important;
                -moz-border-radius: 50% !important;
                border-radius: 50%;
                border: 5px solid#808080;
            }
        .dashboard-stat .details .number{
            font-size:19px !important;
        }
        .dashboard-stat.red .more{
            background-color:#e7191b !important;
        }
        .dashboard-stat.yellow .more{
            background-color:#ffb848 !important;
        }
        .form-horizontal .control-label
        {
            width:25% !important;
        }
        .form-horizontal .controls{
            margin-left:30% !important;
        }
    </style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      
    <!-- START LIGHT BOX ERROR/MESSAGE -->
    <a data-toggle="modal" id="btnAlertError" style="display: none;" class="btn btn-danger" role="button" href="#msgAlertError"><%=Resources.Resource.error %></a>
    <div id="msgAlertError" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h3 id="H1"><%=Resources.Resource.error %></h3>
        </div>
        <div class="modal-body">
            <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
        </div>
        <div class="modal-footer">
            <button data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
        </div>
    </div>
    <a data-toggle="modal" id="btnAlertMessage" style="display: none;" class="btn btn-danger" role="button" href="#myModal2"><%=Resources.Resource.success %></a>
    <div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h3 id="myModalLabel2"><%=Resources.Resource.message %></h3>
        </div>
        <div class="modal-body">
            <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
        </div>
        <div class="modal-footer">
            <button data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
        </div>
    </div>
    <a data-toggle="modal" id="btnApproveRejectPopup" style="display: none;" class="btn btn-danger" role="button" href="#divVerificationForm"><%=Resources.Resource.verifications %></a>
    <div id="divVerificationForm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="divVerificationForm" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h3 id="H2"><%=Resources.Resource.verification %></h3>
        </div>
        <div class="modal-body">
            <h4 id="spnVerification">&nbsp;</h4>
            <span id="spnVrfNID" style="display: none;">0</span>
            <span id="spnVrfTab" style="display: none;">&nbsp;</span>
            <div class="span6">
                <div class="control-group">
                    <label class="control-label" style="clear: both; width: 100px !important; display: inline; float: left"><%=Resources.Resource.remarks %> <span class="required">*</span></label>
                    <div style="clear: both; display: inline;" class="controls chzn-controls">
                        <textarea id="txtRemarks" name="remarks" onkeydown="return imposeMaxLength(this, event, 480);" data-required="1" rows="3" class="medium m-wrap" style="width: 98% !important; resize: none;"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button onclick="return VerificationAproveReject('approve')" class="btn icn-only green"><%=Resources.Resource.approve %></button>
            <button onclick="return VerificationAproveReject('reject')" class="btn icn-only red"><%=Resources.Resource.reject %></button>
            <button id="btnHideVerificationPopup" data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
        </div>
    </div>
    <!-- END   LIGHT BOX ERROR/MESSAGE -->


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
                    <small><%=Resources.Resource.teamEfficiency %></small>
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("../Common/Home") %>'><%=Resources.Resource.home %> </a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.teamEfficiency %> </a></li>
                    
                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <div id="dashboard" style="width: 99%;" class="tams-dashboard">
             
        
        <!-- Dashboard Filters  Starts -->
         <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_FILTERS) == true)
            { %>
            <div class ="row" id="divTeam">
              <div class="box">
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
                <div class="panel-body"> 
                  <form class="form-horizontal">
                  <div class="row-fluid"> 
                        <div class="span4">
                            <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.organization %> </label>
                                    <div class="controls chzn-controls"  >
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
                      <div class="span3" style="display:none;">
                            <a class="btn green pull-<%= pullDirectionStr%>" id="btnSearch" style="background-color:#1d943b !important; color:#fff !important; "  data-toggle="modal"><%=Resources.Resource.apply %></a>
                      </div>
                      </div>
                      </form>
                </div>
             </div>
            </div>
         <% } %>
        
        <!-- Dashboard Filters  Ends -->
              <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_TEAM_EFFICIENCY) == true)
               { %>
            <div class="row" id="TeamBox">
                <div class="box">
                    <div class="panel-heading">
                        <div class="panel-heading-text">
                            <i class="fa fa-signal"></i>
                            <h3 class="panel-title">Team Efficiency </h3>
                        </div>
                        <div class="panel-control">
                            <div class="btn-group">


                                <button data-toggle="panel-overlay" data-target="#demo-panel-network" class="btn"><i class="fa fa-rotate-right"></i></button>
                                <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="btn-toggle" title="" data-original-title="collapse"><i class="fa fa-minus"></i></button>
                                <select id="performanceyear"></select>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <ul class="sidebar-nav" id="sidebar_teamefficiency" style="min-height:460px !important; max-height:460px !important;">
                        </ul>
                        <div id="page-content-wrapper">
                            <!-- Keep all page content within the page-content inset div! -->
                            <div class="page-content inset">
                                <div class="card">
                                    <div class="avatar">
                                        <img id="memberImage" alt="" src="" style="min-width: 100px; width: 100px;">
                                        <label style="font-weight: bold; font-size: 12px;" id="memberName"></label>
                                        <label style="font-weight: bold; font-size: 12px;" id="memberDesignation"></label>
                                        <label style="font-weight: bold; font-size: 12px;" id="memberGrade"></label>
                                        <label style="font-weight: bold; font-size: 12px;" id="memberOrganization"></label>
                                        <label style="font-weight: bold; font-size: 12px;" id="memberSchedule"></label>
                                        <label style="font-weight: bold; font-size: 12px;" id="memberType"></label>
                                    </div>

                                </div>

                                <a class="active-employeeefficiency" style="display: none; height: 304px; margin-top: 15px;"></a>
                                <div id='container-employeeefficiency' class="col-md-12" style="height: 300px">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <% } %> 

          

        </div>
      
     
    </div>
    <!-- END PAGE CONTAINER-->


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


    <link href="../LeanSlider/slider-styles.css" rel="stylesheet" />
    <link href="../LeanSlider/lean-slider.css" rel="stylesheet" />
    <script src="../LeanSlider/modernizr-2.6.1.min.js"  type="text/javascript"></script>
    <script src="../LeanSlider/lean-slider.js"  type="text/javascript"></script>
    <script src="../Scripts/jquery.loadmask.js"  type="text/javascript"></script>
    
    <!-- 1. Include jQuery and Highcharts scripts. -->
    <script src="../Styles/HighCharts/highcharts.js" type="text/javascript"></script>
    <script src="../Styles/HighCharts/drilldown.js" type="text/javascript"></script>
    <script src="../Styles/HighCharts/piedrill.js"  type="text/javascript"></script>

    <!-- END PAGE LEVEL SCRIPTS -->
    <script>
        var loadStep = 0;
        window.requestPageUrl = '<%= Page.ResolveClientUrl("~/RequestPages/DashboardTeamEfficiencyPage.aspx") %>';
        window.defaultDateFormat = "yyyy-mm-dd";


        function clearMainPopup() {

            //  $('#sample_Late_Early tbody').html('');
        }

        $(document).ready(function () {
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

            LoadEmployees();
            LoadOrganizations();
            LoadManager();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active"); 
            $("#liDashboard").addClass("active");
            $("#liDashboard .arrow").addClass("open");
            $("#liTeamEfficiency").addClass("active");
               
            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
             

            var currentDate = new Date()
            var day = currentDate.getDate()
            var month = currentDate.getMonth() + 1
            var year = currentDate.getFullYear();
            if (day < 10)
                day = "0" + day;
            if (month < 10)
                month = "0" + month; 
              
            if ($('#TeamBox') && $('#TeamBox').length > 0) {
                GetTeamList();
            } 

        });
           
        $("#ddOrg").change(function () {
            LoadManager();
            LoadEmployees();
        });

        $("#ddMgr").change(function () {
            LoadEmployees(); 
        });


        $("#ddEmp").change(function () {
            GetTeamList();
        });


            //var teamBoxTemplate = {
            //    listOfEmployee: [],
               // profileImageUrl: "<%= path %>Handlers/EmployeeProfileImage.ashx?id=",
        //    chartReference: null,
        //    currentEmployee: new TeamEmployee(),
        //    getTeamMemberById: function (id) {
        //        var mainList = this.listOfEmployee;
        //        for (var i = 0; i < mainList.length; i++) {
        //            if (mainList[i].encryptedID === id) {
        //                return mainList[i];
        //            }
        //        }
        //    }

        //};




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
                        GetTeamList();
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
                });
            }

            ///


        function TeamEmployee() {
            var
                encryptedID,
                nameEn,
                nameAr;

            return {
                encryptedID: encryptedID,
                nameEn: nameEn,
                nameAr: nameAr
            }
        };

        $('.teamMember').live('click', function () {
            var id = $(this).attr('teamMemberId');
            teamBoxTemplate.currentEmployee = teamBoxTemplate.getTeamMemberById(id); 
            SetMemberDetail();

        });
        
        var teamBoxTemplate = {
            listOfEmployee: [],
            profileImageUrl: "<%= Page.ResolveClientUrl("~/Handlers/EmployeeProfileImage.ashx?Type=Code&id=") %>", 
            chartReference: null,
            currentEmployee: new TeamEmployee(),
            getTeamMemberById: function (id) {
                var mainList = this.listOfEmployee;
                for (var i = 0; i < mainList.length; i++) {
                    if (mainList[i].encryptedID === id) {
                        return mainList[i];
                    }
                }
            }
        }

        $('#performanceyear').change(function () {
            SetMemberDetail();

        });
        var completeYear = {
            monthNames: {
                'Jan': '1', 'Feb': '2', 'Mar': '3', 'Apr': '4', 'May': '5', 'Jun': '6', 'Jul': '7', 'Aug': '8', 'Sep': '9',
                'Oct': '10', 'Nov': '11', 'Dec': '12'
            },
            getMonthValue: function (value) {
                if (value)
                    return this.monthNames[value.trim()]
            }
        };

        function GetTeamList() {
            $("#TeamBox").mask("<%=Resources.Resource.processing %>" + "....");

            var emp = $("#ddEmp").val();
            var mgr = $("#ddMgr").val();
            var org = $("#ddOrg").val();

            var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org;
            var d = "key=getIdNameTeamList" + wc;
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardTeamEfficiencyPage.aspx") %>',
                success: function (response) { 
                    var teamList = $.parseJSON(response);
                    if (teamList) {
                        var teamHtml = ""; 
                        teamBoxTemplate.listOfEmployee = []; 
                        for (var i = 0; i < teamList.length; i++) {
                            var newTeamObject = new TeamEmployee();
                            newTeamObject.encryptedID = teamList[i].EncryptedID;
                            newTeamObject.code = teamList[i].Code;
                            newTeamObject.nameEn = teamList[i].NameEn;
                            newTeamObject.nameAr = teamList[i].NameAr;
                            teamBoxTemplate.listOfEmployee.push(newTeamObject); 
                            teamHtml += " <li class='teamMember' teamMemberId=" + teamList[i].EncryptedID + "><div class='card'><div class='avatar'><img alt='' src='" + teamBoxTemplate.profileImageUrl + teamList[i].Code + "'style='min-width:100px;width: 100px;' /> </div> </div></li>";
                        }
                        $('#sidebar_teamefficiency').html(teamHtml);
                        teamBoxTemplate.currentEmployee = teamBoxTemplate.listOfEmployee.length > 0 ? teamBoxTemplate.listOfEmployee[0] : new TeamEmployee();

                        fillPerformanceYear();

                        teamBoxTemplate.chartReference = new Highcharts.Chart({
                            chart: {
                                renderTo: 'container-employeeefficiency',
                                type: 'column'

                            },
                            title: {
                                text: ''
                            },

                            xAxis: {
                                categories: [
                                    'Jan',
                                    'Feb',
                                    'Mar',
                                    'Apr',
                                    'May',
                                    'Jun',
                                    'Jul',
                                    'Aug',
                                    'Sep',
                                    'Oct',
                                    'Nov',
                                    'Dec'
                                ],
                                crosshair: true
                            },
                            yAxis: {
                                min: 0,
                                title: {
                                    text: 'Yearly Efficiency'
                                }
                            },
                            tooltip: {
                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                    '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
                                footerFormat: '</table>',
                                shared: true,
                                useHTML: true
                            },
                            plotOptions: {
                                column: {
                                    borderWidth: 0
                                }, series: {
                                    cursor: 'pointer',
                                    point: {
                                        events: {
                                            click: function (e, a, b) {
                                                var type = this.series.userOptions.violationType;
                                                if (type) {
                                                    $('.active-employeeefficiency').attr("href", "#portlet-config");
                                                    $('.active-employeeefficiency').attr("data-toggle", "modal");
                                                    $('.active-employeeefficiency').click();
                                                    LoadMyViolationPopup(type.toLowerCase(), 'single');
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        });
                        SetMemberDetail();
                    }
                    $("#TeamBox").unmask();
                },
                error: function (html) {
                    $("#TeamBox").unmask();
                }
            });

        };



        function SetMemberDetail() {


            $("#TeamBox").mask("<%=Resources.Resource.processing %>" + "....");
        
            $('#memberImage').attr('src', teamBoxTemplate.profileImageUrl + teamBoxTemplate.currentEmployee.code + '.jpg');
            $('#memberName').text(teamBoxTemplate.currentEmployee.nameEn);
           // $('#memberDesignation').text(teamBoxTemplate.currentEmployee.designation || 'Unknown');
           // $('#memberGrade').text(teamBoxTemplate.currentEmployee.grade || 'Unknown');
           // $('#memberOrganization').text(teamBoxTemplate.currentEmployee.organization || 'Unknown');

            while (teamBoxTemplate.chartReference.series.length > 0)
                teamBoxTemplate.chartReference.series[0].remove(true);
             

            var d = "key=getTeamYearlyStatisticByMemberId&EmployeeId=" + teamBoxTemplate.currentEmployee.encryptedID + "&year=" + $('#performanceyear').val();
           
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardTeamEfficiencyPage.aspx") %>',
                success: function (response) {



                    var data = $.parseJSON(response);

                    lateData = [];
                    earlyData = [];
                    absentData = [];
                    unAuthorizedAbsentData = [];
                    leavesData = [];
                    MissedInData = [];
                    MissedOutData = [];

                    for (var i = 0; i < data.length; i++) {
                        lateData.push(data[i].Late);
                        earlyData.push(data[i].Early);
                        absentData.push(data[i].Absent);
                        unAuthorizedAbsentData.push(data[i].UnAuthorizedAbsent);
                        leavesData.push(data[i].Leaves);
                        MissedInData.push(data[i].MissedIN);
                        MissedOutData.push(data[i].MissedOut);
                    }

                    teamBoxTemplate.chartReference.addSeries({ name: 'Late', color: colors.purple, data: lateData, violationType: "Late" });

                    teamBoxTemplate.chartReference.addSeries({
                        name: 'Early',
                        color: colors.pink,
                        data: earlyData,
                        violationType: "Early"

                    });
                    teamBoxTemplate.chartReference.addSeries({

                        name: 'Absent',
                        color: colors.red,
                        data: absentData,
                        violationType: "Absent"

                    });
                    teamBoxTemplate.chartReference.addSeries({

                        name: 'Unauthorized Absent',
                        color: colors.AtomicTangerine,
                        data: unAuthorizedAbsentData,
                        violationType: "Unauthorized Absent"

                    });
                    teamBoxTemplate.chartReference.addSeries({
                        name: 'Leaves',
                        color: colors.yellow,
                        data: leavesData,
                        violationType: "Leave"

                    });
                    teamBoxTemplate.chartReference.addSeries({ name: 'MissedIN', color: colors.seagreen, data: MissedInData, violationType: "MissedIn" });

                    teamBoxTemplate.chartReference.addSeries({ name: 'MissedOut', color: colors.skyblue, data: MissedOutData, violationType: "MissedOut" });


                    $("#TeamBox").unmask();
                },
                error: function (html) {
                    $("#TeamBox").unmask();
                }
            });
        };


        function fillPerformanceYear() {
            $('#performanceyear').html(''); 
            first = 2017; 
             
            second = new Date().getFullYear();
            var html = "<option>Choose year</options>";
            for (i = first; i <= second; i++)  
            {
                html += "<option value ='" +  i + "'>" + i + "</option>"
            } 
            $('#performanceyear').html(html);
            $('#performanceyear').val(new Date().getFullYear());
        }


        function imposeMaxLength(Object, evt, MaxLen) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
            return (Object.value.length < MaxLen);
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
    var colors = {
        blue: "#5fb4ef",
        purple: "#aa00ff",
        orange: "#ff851b",
        red: "#cc3f44",
        AtomicTangerine: "#00f58c",
        green: "#a1c436",
        seagreen: "#009688",
        skyblue: "#00BCD4",
        pink: "#e91e63",
        yellow:"#ff9800"

    };
 </script>
</asp:Content>
