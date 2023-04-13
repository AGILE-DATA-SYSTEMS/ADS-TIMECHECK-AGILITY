<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TeamStats.aspx.cs" Inherits="TAMSR2.Dashboard.TeamStats" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.reportingEmployeeStats %> - <%=Resources.Resource.applicationName %> </title>

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

    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="portlet-config" class="modal hide">
        <div class="modal-header">
            <button data-dismiss="modal" class="close" type="button"></button>
            <h3 id="popupTitle">Widget Settings</h3>
        </div>
        <div class="modal-body">
            <!-- BEGIN EXAMPLE TABLE PORTLET-->
            <div class="portlet box light-grey">
                <div class="portlet-title">
                    <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.movement %></div>
                    <div class="tools">
                        <a href="javascript:;" class="collapse"></a>
                        <a style="display: none;" href="javascript:void(0);" onclick="return LoadGrid()" class="reload"></a>
                    </div>
                </div>
                <div class="portlet-body">
                    <div id="div1" class="alert alert-success hide">
                        <span id="Span1"><%=Resources.Resource.formErrors %></span>
                    </div>
                    <div id="div2" class="alert alert-error hide">
                        <span id="Span2"><%=Resources.Resource.formErrorsRemoved %></span>
                    </div>
                    <div class="clearfix">
                        <div class="btn-group">
                            <span id="Span3">&nbsp;</span>
                        </div>
                    </div>
                    <table class="table table-striped table-bordered table-hover" id="sample_Late_Early" style="width: 100%;">
                        <thead>
                            <tr style="background-color: #e8e3e3;">
                                <th style="text-align: center; width: 5px;"><%=Resources.Resource.date %></th>
                                <th style="text-align: center; width: 10px;"><%=Resources.Resource.number %></th>
                                <th style="text-align: center; width: 30px;"><%=Resources.Resource.name %></th>
                                <th style="text-align: center; width: 5px;" id="thSchedule"><%=Resources.Resource.schedule %></th>
                                <th style="text-align: center; width: 20px;" id="thPunch"><%=Resources.Resource.punch %></th>
                                <th style="text-align: center; width: 20px;" id="thRemarks"><%=Resources.Resource.remarks %></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- END EXAMPLE TABLE PORTLET-->

        </div>
        <!-- END OF MODAL-BODY -->

    </div>
    <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
     
    <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
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
                <h3 class="page-title" style="margin: 0px;min-height:20px !Important;" runat="server" id="pgTitle" >
                    <small style="display: none;">statistics and more</small>
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("../Common/Home") %>'><%=Resources.Resource.home %> </a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.reportingEmployeeStats %> </a></li>
                     <li class="pull-<%= pullDirectionStr %> no-text-shadow" style="margin-top: -8px; padding: 0px 20px;">
                        <span id="liWebPunch">&nbsp;</span>
                    </li>
                    <li style="" class="pull-<%= pullDirectionStr %> no-text-shadow">

                        <input  class="m-wrap" type="text" style="font-size: 11px; width: 80%; margin-top: -10px; background-color: #EFEFEF; border: none; cursor: pointer; direction: <%= pullDirectionStr %>" value="" id="txtDashboardDateMain" placeholder="<%=Resources.Resource.selectDate %>" />
                        <input style="display:none" class="m-wrap" type="text" style="font-size: 11px; width: 80%; margin-top: -10px; background-color: #EFEFEF; border: none; cursor: pointer; direction: <%= pullDirectionStr %>" value="" id="txtDashboardDate" placeholder="<%=Resources.Resource.selectDate %>" />

                    </li>
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
            <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_TEAM_STATISTICS) == true)
            { %>
                <div class="row" id="divTeamStats">
                <div class="box">
                <div class="panel-heading">
                    <div class="panel-heading-text"> 
                        <h3 class="panel-title"><%=Resources.Resource.reportingEmployeeStats %></h3>
                    </div>
                    <div class="panel-control">
                        <div class="btn-group">
                            <button onclick="LoadGroupVoilations()" data-toggle="panel-overlay" data-target="#demo-panel-network" class="btn"><i class="fa fa-rotate-right"></i></button>
                            <button style="display:none;" class="btn btn-info" id="btnTeamStatsFilter" data-widget="" onclick="#portlet-config1" data-toggle="tooltip" title="" data-original-title="Filters"><i class="fa  icon-filter"></i></button>
                            <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus"></i></button>
                             
                        </div>
                    </div> 
                </div>
                <div class="panel-body">
                        <div class="row-fluid">
                    <div class="span2">
                        <div class="sparkline-chart">
                                    <div class="number" id="sparkline_bar"></div>
                                    <a class="title" href="#portlet-config" onclick="clearMainPopup(); return LoadMyViolationPopup('late', 'group')" data-toggle="modal"><%=Resources.Resource.late %>  <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                                
                    </div>
                    <div class="span2" >
                            
                                <div class="sparkline-chart">
                                    <div class="number" id="sparkline_bar2"></div>
                                    <a class="title" href="#portlet-config" onclick="clearMainPopup(); return LoadMyViolationPopup('early', 'group')" data-toggle="modal"><%=Resources.Resource.early %> <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                                 
                             
                    </div>
                    <div class="span2">

                             
                                <div class="sparkline-chart">
                                    <div class="number" id="sparkline_bar3"></div>
                                    <a class="title" href="#portlet-config" onclick=" clearMainPopup(); return LoadMyViolationPopup('leave', 'group')" data-toggle="modal"><%=Resources.Resource.leaves %> <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                          

                    </div>
                    <div class="span2"> 
                        <div class="sparkline-chart">
                                    <div class="number" id="sparkline_bar4"></div>
                                    <a class="title" href="#portlet-config" onclick=" clearMainPopup(); return LoadMyViolationPopup('absent', 'group')" data-toggle="modal"><%=Resources.Resource.absent %> <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                                
                    </div>
                    <div class="span2">
                             
                                <div class="sparkline-chart">
                                    <div class="number" id="sparkline_bar5"></div>
                                    <a class="title" href="#portlet-config" onclick="clearMainPopup(); return LoadMyViolationPopup('missedin', 'group')" data-toggle="modal"><%=Resources.Resource.missedin %> <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                                
                    </div>
                    <div class="span2">
                             
                                <div class="sparkline-chart">
                                    <div class="number" id="sparkline_bar6"></div>
                                    <a class="title" href="#portlet-config" onclick="clearMainPopup(); return LoadMyViolationPopup('missedOut', 'group')" data-toggle="modal"><%=Resources.Resource.missedOut %> <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                                
                </div> 
                     <div class="span2">
                             
                                <div class="sparkline-chart">
                                    <div class="number" id="sparkline_bar7"></div>
                                    <a class="title" href="#portlet-config" onclick="clearMainPopup(); return LoadMyViolationPopup('permissions', 'group')" data-toggle="modal"><%=Resources.Resource.permissions %> <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                                
                    </div> 
                 
                </div>
            </div>
        </div></div> 

            <% } %>

            
              <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_MY_PENDING_REQUESTS) == true)
                {%>
            <div id="divPendingRequests" class="row" >
              <div class="col-sm-3 col-lg-3 " id="divAttendanceActivity" style="min-width:25% !Important">
                  <div class="box" style="min-height:527px !Important;">
                        <div class="panel-heading">
                            <div class="panel-heading-text"> 
                                <h3 class="panel-title"><%=Resources.Resource.pending + " " + Resources.Resource.approvals %></h3>
                            </div>

                            <div class="panel-control">

                                <div class="btn-group">
                                    <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="btn-toggle" title="" data-original-title="collapse"><i class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" > 
                          <div class="row-fluid">
                              <div class="span12">
                                 <div class="easy-pie-chart">
                                    <div  class="number Leaves easyPieChart" data-percent="100" style="width: 50px; height: 50px; line-height: 50px;">
                                        <span id="spnLeaves"></span>  
                                    </div>
                                    <a class="title" href="javascript:void(0)"   onclick="LoadPendingGrid('Leaves');" style="font-size:12px !Important;"><%=Resources.Resource.leaves %></a>
                                 </div>
                              </div>
                              <div class="margin-bottom-10 visible-phone"></div> 
                              </div>
                          <div class="row-fluid">
                              <div class="span12">
                                 <div class="easy-pie-chart">
                                    <div class="number Permissions easyPieChart" data-percent="100"  style="width: 50px; height: 50px; line-height: 50px;">
                                        <span id="spnPermissions"></span></div>
                                    <a class="title" href="javascript:void(0)" onclick="LoadPendingGrid('Short Permission');" style="font-size:12px !Important;"><%=Resources.Resource.permissions %></a>
                                 </div>
                              </div>
                              <div class="margin-bottom-10 visible-phone"></div> 
                           </div>
                          <div class="row-fluid">
                              <div class="span12">
                                 <div class="easy-pie-chart">
                                    <div class="number MissingMovements easyPieChart"  data-percent="100" style="width: 50px; height: 50px; line-height: 50px;">
                                        <span id="spnMissing"></span></div>
                                    <a class="title" href="javascript:void(0)" onclick="LoadPendingGrid('Missing Movements');" style="font-size:12px !Important;"><%=Resources.Resource.missingMovements %></a>
                                 </div>
                              </div>
                              <div class="margin-bottom-10 visible-phone"></div> 
                            </div>
                          <div class="row-fluid" style="display:none;">
                              <div class="span12">
                                 <div class="easy-pie-chart">
                                    <div class="number ManualMovements easyPieChart"  data-percent="100" style="width: 50px; height: 50px; line-height: 50px;"> <span id="spnManual"  ></span>
                                        </div>
                                    <a class="title" href="javascript:void(0)" onclick="LoadPendingGrid('Manual Movements');" style="font-size:12px !Important;"><%=Resources.Resource.manualMovements %></a>
                                 </div>
                              </div>
                              <div class="margin-bottom-10 visible-phone"></div> 
                           </div> 
                    </div>
                    </div> 
              </div>
              <div class="col-sm-6 col-lg-6 " id="divPendingReq"  style="min-width:75% !Important;  " >
                  <div class="box">
                        <div class="panel-heading">
                            <div class="panel-heading-text">
                                <i class="fa fa-signal" style="display:none;"></i>
                                <h3 class="panel-title"><%=Resources.Resource.pending + " " + Resources.Resource.approvals %></h3>
                            </div>

                            <div class="panel-control">

                                <div class="btn-group">
                                    <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="btn-toggle" title="" data-original-title="collapse"><i class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="min-height: 490px !important">
                             
                        <div class="table-responsive">
                       <table class="table table-hover" id="Sample_2"  ">
                                <thead>
                                    <tr> 
                                         <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                         <th style="text-align: center;"><%=Resources.Resource.employee %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.request + " " + Resources.Resource.type %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.type %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.fromDate %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.toDate %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.fromTime %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.toTime %></th> 
                                         <th style="text-align: left;"><%=Resources.Resource.status %></th>
                                         <th style="text-align: left;"> </th>
                                         <th style="text-align: left;"> </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        </div>
                    </div>
              </div>
            
             </div> 
            
            <% } %>

            <div class="row" >
                 <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.TREND_VIOLATION_DRILLDOWN_WIDGET) == true)
                   { %> 
                     <div class="col-sm-6 col-lg-6 " id="divDrillDownWidget" style="float: <%= floatStr %>">
                    <div class="box">
                        <div class="panel-heading">
                            <div class="panel-heading-text"> 
                                <h3 class="panel-title"><%= Resources.Resource.attendanceTrend %> </h3>
                            </div>

                            <div class="panel-control">

                                <div class="btn-group">
                                    <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="btn-toggle" title="" data-original-title="collapse"><i class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div id="container-trend-drilldown" class="collapse" style="height: 304px; margin-top: 15px;"></div>
                            <a class="active-drilldown" style="display: none; height: 304px; margin-top: 15px;"></a>
                        </div>
                    </div>
                </div>
                <% } %>
                 <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.TREND_VIOLATION_WIDGET) == true)
                   { %>  
                 <div class="col-sm-6 col-lg-6" id="divViolationTrends" style="float: <%= floatStr %>">
                    <div class="box">
                        <div class="panel-heading">
                            <div class="panel-heading-text"> 
                                <h3 class="panel-title"><%=Resources.Resource.violationTrends %></h3>
                            </div>

                            <div class="panel-control">

                                <div class="btn-group">
                                    <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div id="chart_div1" style="height: 304px; margin-top: 15px;"></div>
                        </div>
                    </div>
                </div>                
                <% } %>                 
            </div> 

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
     
    <script src="../Scripts/jquery.loadmask.js"></script>
    
    <!-- 1. Include jQuery and Highcharts scripts. -->
    <script src="../Styles/HighCharts/highcharts.js" type="text/javascript"></script>
    <script src="../Styles/HighCharts/drilldown.js" type="text/javascript"></script>
    <script src="../Styles/HighCharts/piedrill.js"></script>

    <!-- END PAGE LEVEL SCRIPTS -->
    <script>
        var loadStep = 0;
        window.requestPageUrl = '<%= Page.ResolveClientUrl("~/RequestPages/DashboardTeamStatsPage.aspx") %>';
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
        var latitude;
        var longitude;
        jQuery(document).ready(function () {

            App.init(); // initlayout and core plugins

            LoadEmployees();
            LoadOrganizations();
            LoadManager();

            Index.initDashboardDaterange();
            Index.setDashBoardDate();
            Index.init();


            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liDashboard").addClass("active");
            $("#liDashboard .arrow").addClass("open");
            $("#liTeamStats").addClass("active");



            PieDrill();

            LoadGroupVoilations(false);
            LoadGraph("tab1");


            LoadPendingCountCharts();

            $("#ddOrg").change(function () {
                LoadManager();
                LoadEmployees();
                loadStep = 2;
                LoadGroupVoilations(true);
                LoadGraph("tab1")
                PieDrill();
                LoadPendingCountCharts() 
            });

            $("#ddMgr").change(function () {
                LoadEmployees();
                loadStep = 2;
                LoadGroupVoilations(true);
                LoadGraph("tab1")
                PieDrill(); 
                LoadPendingCountCharts() 
            });


            $("#ddEmp").change(function () {
                loadStep = 2;
                LoadGroupVoilations(true);
                LoadGraph("tab1")
                PieDrill();
                LoadPendingCountCharts() 
            });

            /*$("#btnSearch").click(function () {
                loadStep = 2;
                LoadGroupVoilations(true);
                LoadGraph("tab1")
                PieDrill();
                LoadGrid();
                LoadDashboard(true);
            }); */


            $("#txtDashboardDateMain").change(function () {
                $('.datepicker').hide();
                $("ul.nav-tabs li.active a").click();
                Index.setDashBoardDate();
                loadStep = 2;

                LoadGroupVoilations(true);
                LoadGraph("tab1")
                PieDrill();
                

            });
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
             

            if (!$('#trendsAndPercentage').is(":visible")) {
                $('#statswidgets').addClass('widget-full-width');
                $('#statswidgets .col-sm-3.col-lg-6').addClass('widget-20per-width');
            }
            else
                $('#statswidgets').removeClass('tams-widget');


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
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
                });
            }

            ///

            function imposeMaxLength(Object, evt, MaxLen) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
                return (Object.value.length < MaxLen);
            }

function ReloadDashboard() {
    loadStep = 0;
    LoadWebPunchReasons(); 
    $("ul.nav-tabs li.active a").click();

}


function LoadMyViolationPopup(type, scope) {

    var dt = $("#txtDashboardDate").val();
    var emp = $("#ddEmp").val();
    var mgr = $("#ddMgr").val();
    var org = $("#ddOrg").val();

    var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";

    if (type == "late") {
        $("#popupTitle").html("<%=Resources.Resource.late %>");
        $("#thRemarks").html("<%=Resources.Resource.late %>");
    }
    if (type == "early") {
        $("#popupTitle").html("<%=Resources.Resource.early %>");
        $("#thRemarks").html("<%=Resources.Resource.early %>");
    }
    if (type == "absent") {
        $("#popupTitle").html("<%=Resources.Resource.absent %>");
        $("#thRemarks").html("<%=Resources.Resource.remarks %>");

    }
    if (type == "leave") {
        $("#popupTitle").html("<%=Resources.Resource.leave %>");
        $("#thRemarks").html("<%=Resources.Resource.leaveType %>");
    }
    if (type == "missedin") {
        $("#popupTitle").html("<%=Resources.Resource.missedin %>");
        $("#thRemarks").html("<%=Resources.Resource.remarks %>");
    }
    if (type == "missedOut") {
        $("#popupTitle").html("<%=Resources.Resource.missedOut %>");
        $("#thRemarks").html("<%=Resources.Resource.remarks %>");
    }
    if (type == "permissions") {
        $("#popupTitle").html("<%=Resources.Resource.permissions %>");
        $("#thPunch").html("<%=Resources.Resource.permissionType %>");
        $("#thRemarks").html("<%=Resources.Resource.time %>");
        $("#thSchedule").html("<%=Resources.Resource.status %>");
    }
    var oTable = $('#sample_Late_Early').dataTable({
        "bProcessing": true,
        "bServerSide": true,
        "bDestroy": true,
        "sPaginationType": "bootstrap",
        "aoColumns": [
          { "bSortable": true, sWidth: "5%" },
          { "bSortable": true, sWidth: "10%" },
          { "bSortable": true, sWidth: "30%" },
          { "bSortable": true, sWidth: "5%" },
          { "bSortable": true, sWidth: "20%" },
          { "bSortable": true, sWidth: "20%" }
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
        "aaSorting": [[0, "desc"]],
        "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/DashboardTeamStatsPage.aspx?key=getMyViolations") %>' + '&type=' + type + '&scope=' + scope + '&dt=' + $("#txtDashboardDate").val() + wc
    });
    $('#sample_Late_Early').css("width", "100%");


}

function LoadDepartmentViolationPopup(type, code) {

    $('#sample_Late_Early').removeClass('absent');
    $('#sample_Late_Early').removeClass('leave');

    ////////Get Users and load in grid/////////
    if (type == "late") {
        $("#popupTitle").html("<%=Resources.Resource.late %>");
        $("#thRemarks").html("<%=Resources.Resource.late %>");

        $('#sample_Late_Early').removeClass('absent');
        $('#sample_Late_Early').removeClass('leave');

    }
    if (type == "early") {
        $("#popupTitle").html("<%=Resources.Resource.early %>");
        $("#thRemarks").html("<%=Resources.Resource.early %>");
        $('#sample_Late_Early').removeClass('absent');
        $('#sample_Late_Early').removeClass('leave');
    }
    if (type == "absent") {
        $("#popupTitle").html("<%=Resources.Resource.absent %>");
        $("#thRemarks").html("<%=Resources.Resource.remarks %>");
        $('#sample_Late_Early').addClass('absent');
    }
    if (type == "leave") {
        $("#popupTitle").html("<%=Resources.Resource.leave %>");
        $("#thRemarks").html("<%=Resources.Resource.leaveType %>");
        $('#sample_Late_Early').addClass('leave');
    }
    if (type == "missed in") {
        $("#popupTitle").html("<%=Resources.Resource.missedin %>");
        $("#thRemarks").html("<%=Resources.Resource.remarks %>"); 
    }
    if (type == "missed out") {
        $("#popupTitle").html("<%=Resources.Resource.missedOut %>");
        $("#thRemarks").html("<%=Resources.Resource.remarks %>"); 
    }

    var emp = $("#ddEmp").val();
    var mgr = $("#ddMgr").val();
    var org = $("#ddOrg").val();

    var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";
    var urlsource = '<%= Page.ResolveClientUrl("../RequestPages/DashboardPage.aspx?key=getDepartmentViolationDetails") %>' + '&type=' + type + '&code='
                         + code + '&dt=' + $("#txtDashboardDate").val();
    urlsource += wc;
    var oTable = $('#sample_Late_Early').dataTable({
        "bProcessing": true,
        "bServerSide": true,
        "bDestroy": true,
        "sPaginationType": "bootstrap",
        "aoColumns": [
          { "bSortable": true, sWidth: "15%" },
          { "bSortable": true, sWidth: "5%" },
          { "bSortable": true, sWidth: "30%" },
          { "bSortable": true, sWidth: "5%" },
          { "bSortable": true, sWidth: "20%" },
          { "bSortable": true, sWidth: "10%" }
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
        "aaSorting": [[0, "desc"]],
        "sAjaxSource": urlsource
    });
    $('#sample_Late_Early').css("width", "100%");


}  

function LoadGroupVoilations(filter) {
    var dt = $("#txtDashboardDate").val();
    var emp = $("#ddEmp").val();
    var mgr = $("#ddMgr").val();
    var org = $("#ddOrg").val();

    var active = $("#chkboxActive").is(":checked");
    if (dt == "" || dt == "Select date...") {
        dt = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
    }
     <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_TEAM_STATISTICS) == false)
     { %>
     loadStep = 3; 
    return;
    <% } %> 
    var wc = "";
    if (filter == true) {
        var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";
    }
    else {
        wc = "&emp=" + '' + "&mgr=" + '' + "&org=" + '';
    }

    var d = "key=getGroupVoilations" + wc;
    d += "&dt=" + dt;

    $("#divTeamStats").mask("<%=Resources.Resource.processing %>" + "....");
     $.ajax({
         type: 'POST',
         data: d,
         url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardTeamStatsPage.aspx") %>',
        success: function (html) {
            var j = $.parseJSON(html);

            //$(".easy-pie-chart div").attr("data-percent", j.MonthlyAchievedHours);
            //$('.easy-pie-chart .number.bounce').easyPieChart({
            //    animate: 1000,
            //    size: 75,
            //    lineWidth: 3,
            //    barColor: App.getLayoutColorCode(j.MonthlyAchievedHoursColor)
            //});
            var late = j.MonthlyLate.split(',').map(function (str) { return Number(str); });
            var early = j.MonthlyEarly.split(',').map(function (str) { return Number(str); });
            var leaves = j.MonthlyLeave.split(',').map(function (str) { return Number(str); });
            var absent = j.MonthlyAbsent.split(',').map(function (str) { return Number(str); });
            var missIN = j.MonthlyMissedIn.split(',').map(function (str) { return Number(str); });
            var missOut = j.MonthlyMissedOut.split(',').map(function (str) { return Number(str); });
            var permissions = j.MonthlyPermissions.split(',').map(function (str) { return Number(str); });


            $("#sparkline_bar").sparkline(late, {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#aa00ff',
                negBarColor: '#e02222'
            }
            );

            $("#sparkline_bar2").sparkline(early, {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#e91e63',
                negBarColor: '#e02222'
            }
             );

            $("#sparkline_bar3").sparkline(leaves, {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#ff9800',
                negBarColor: '#e02222'
            }
              );

            $("#sparkline_bar4").sparkline(absent, {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#e7191b',
                negBarColor: '#e02222'
            }
             );
            $("#sparkline_bar5").sparkline(missIN, {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#009688',
                negBarColor: '#e02222'
            }
             );
            $("#sparkline_bar6").sparkline(missOut, {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#00BCD4',
                negBarColor: '#e02222'
            }
             );
            $("#sparkline_bar7").sparkline(permissions, {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#7f380a',//'#FFB848',
                negBarColor: '#e02222'
            }
             );

            // LoadNotificationCount();
            $("#divTeamStats").unmask();

        },
        error: function (html) {
            $(".feeds").html("<li>&nbsp;</li>");
            $("#divErrorMsg").css("display", "block");
            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");

            // LoadNotificationCount();
            $("#divTeamStats").unmask();

        }

    });
}


        /// Pending Count Charts 

        function LoadPendingCountCharts() {
            var emp = $("#ddEmp").val();
            var mgr = $("#ddMgr").val();
            var org = $("#ddOrg").val();

            var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";
            var d = "key=getPendingRequests" + wc;
            $.ajax({
                type: 'GET',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardTeamStatsPage.aspx") %>',
                success: function (html) {
                    var j = $.parseJSON(html);
                    LoadPieChart(j.LeavesCount, j.PermissionCount, j.MissingMovementCount, j.ManualMovementCount);
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
            });
            }


            function LoadPieChart(Leaves, Permission, MissingMovement, ManualMovements) {
                //Leaves 
                $('.easy-pie-chart .number.Leaves').easyPieChart({
                    easing: 'easeOutElastic',
                    delay: 3000,
                    size: 100,
                    scaleColor: false,
                    lineWidth: 3,
                    trackWidth: 16,
                    lineCap: 'butt',
                    barColor: '#ffb848',
                    data: 20
                });
                $("#spnLeaves").html(Leaves);
                //Permissions
                $('.easy-pie-chart .number.Permissions').easyPieChart({
                    easing: 'easeOutElastic',
                    delay: 3000,
                    size: 100,
                    scaleColor: false,
                    lineWidth: 3,
                    trackWidth: 16,
                    lineCap: 'butt',
                    barColor: '#7f380a'
                });
                $("#spnPermissions").html(Permission);

                //MissingMovements
                $('.easy-pie-chart .number.MissingMovements').easyPieChart({
                    easing: 'easeOutElastic',
                    delay: 3000,
                    size: 100,
                    scaleColor: false,
                    lineWidth: 3,
                    trackWidth: 16,
                    lineCap: 'butt',
                    barColor: '#009688'
                });
                $("#spnMissing").html(MissingMovement);

                //ManaualMovements
                $('.easy-pie-chart .number.ManualMovements').easyPieChart({
                    easing: 'easeOutElastic',
                    delay: 3000,
                    size: 100,
                    scaleColor: false,
                    lineWidth: 3,
                    trackWidth: 16,
                    lineCap: 'butt',
                    barColor: '#00BCD4'
                });
                $("#spnManual").html(ManualMovements);
                 
                LoadPendingGrid("");

            }


            /// End


           
        /// Load Pending Requests Lists


        function LoadPendingGrid(type) {
   
            var emp = $("#ddEmp").val();
            var mgr = $("#ddMgr").val();
            var org = $("#ddOrg").val();

            var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true&type=" +type;
            var filterValue = "";
            if($("#txt_Sample_2_filter").val() != 'undefined' && $("#txt_Sample_2_filter").val() != '' && $("#txt_Sample_2_filter").val() != undefined)
                filterValue = $("#txt_Sample_2_filter").val();

            $("#Sample_2_filter label input").val(filterValue);

            
           ////////Get Users and load in grid/////////
           var oTable = $('#Sample_2').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "bFilter": false,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "19%" },
                 { "bSortable": true, sWidth: "12%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "9%" },
                 { "bSortable": true, sWidth: "9%" },
                 { "bSortable": true, sWidth: "9%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "9%" },
                 { "bSortable": true, sWidth: "4%" },
                 { "bSortable": true, sWidth: "4%" }
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
               "aaSorting": [[1, "desc"]],
               "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/DashboardTeamStatsPage.aspx?key=getAllPendingRequests") %>' + "&sSearchFilter=" + filterValue + wc
           });

           $("#Sample_2").width("99.5%");
       }

       //END

        function RedirectToApprovalPage(type)
        {

            var emp = $("#ddEmp").val();
            var mgr = $("#ddMgr").val();
            var org = $("#ddOrg").val();

            if (emp == "")
                emp = "0";
            if (mgr == "")
                mgr = "0";
            if (org == "")
                org = "0";

            if (type == 'Permission')
                type = 1;
            else if (type == 'Manual')
                type = 2;
            else if (type == 'Missing')
                type = 3;
            else
                type = '';

            var url = '<%= Page.ResolveClientUrl("~/Approval/Pending-Approval") %>' + '/' + org + '/' + mgr + '/' + emp + '/' + type;
            
            document.location.href = url;
        }

    </script>
    <!-- END JAVASCRIPTS -->



    <script type="text/javascript">

        $(function () {
            Highcharts.setOptions({
                global: {
                    useUTC: false
                }
            });
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.TREND_VIOLATION_WIDGET) == false)
                   { %>
            return;
            <% } %>
          

           <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.TREND_VIOLATION_DRILLDOWN_WIDGET) == true)
                   { %>
            LoadGraph("tab1");
             <% } %>

        }); 

        function LoadGraph(tab) {
            var dt = $("#txtDashboardDate").val();
            if (dt == "" || dt == "Select date...") {

                dt = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
            }

                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.TREND_VIOLATION_WIDGET) == false)
                 { %>
            return;
                <% } %>

            if (tab == "tab1") {
                var emp = $("#ddEmp").val();
                var mgr = $("#ddMgr").val();
                var org = $("#ddOrg").val();

                var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";
                var d = "key=getPercentage";
                d += "&dt=" + dt;
                d += wc;
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardTeamStatsPage.aspx") %>',
                    success: function (html) {
                        var j = $.parseJSON(html);
                        if ($('#chart_div1') && $('#chart_div1').length > 0) {

                            Tab1(j.LatePercentage, j.EarlyPercentage, j.AbsentPercentage, j.LeavePercentage, j.PresentPercentage, j.MissedInPercentage, j.MissedOutPercentage);
                            $("#divViolationTrends").unmask();
                        } 
                    },
                    error: function (html) {
                        Tab3(0, 0, 0, 0, 100);
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>"); 
                    }
                });
            }
            else if (tab == "tab2") {
                var d = "key=getTrends";
                d += "&dt=" + dt;
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>',
                    success: function (html) {
                        var j = $.parseJSON(html);

                        var late = j.Late.split(',').map(function (str) { return Number(str); });
                        var early = j.Early.split(',').map(function (str) { return Number(str); });
                        var leave = j.Leave.split(',').map(function (str) { return Number(str); });
                        var absent = j.Absent.split(',').map(function (str) { return Number(str); });
                        var average = j.Average.split(',').map(function (str) { return Number(str); });

                        Tab2(late, early, leave, absent, average);

                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
                });
            }
            else if (tab == "tab3") {
                var d = "key=getTrendsPercentage";
                d += "&dt=" + dt;
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>',
                    success: function (html) {
                        var j = $.parseJSON(html);

                        var late = j.Late.split(',').map(function (str) { return Number(str); });
                        var early = j.Early.split(',').map(function (str) { return Number(str); });
                        var leave = j.Leave.split(',').map(function (str) { return Number(str); });
                        var absent = j.Absent.split(',').map(function (str) { return Number(str); });
                        var average = j.Average.split(',').map(function (str) { return Number(str); });

                        Tab3(late, early, leave, absent);
                        //  $("#divDrillDownWidget").unmask();

                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                        //  $("#divDrillDownWidget").unmask();
                    }
                });
            }
            else
                if (tab == "tab4") {
                    Tab4();
                }
}



function Tab2(late, early, leave, absent, average) {
    $('#chart_div1').highcharts({
        chart: {
        },
        title: {
            text: '<%=Resources.Resource.violationTrends %>'
        },
        subtitle: {
            text: '<%=Resources.Resource.late %> / <%=Resources.Resource.early %> / <%=Resources.Resource.absent %>'
        },
        xAxis: {
            categories: ['<%=Resources.Resource.jan %>', '<%=Resources.Resource.feb %>', '<%=Resources.Resource.mar %>', '<%=Resources.Resource.apr %>', '<%=Resources.Resource.may %>', '<%=Resources.Resource.jun %>', '<%=Resources.Resource.jul %>', '<%=Resources.Resource.aug %>', '<%=Resources.Resource.sep %>', '<%=Resources.Resource.oct %>', '<%=Resources.Resource.nov %>', '<%=Resources.Resource.dec %>']
        },
        yAxis: {
            title: {
                text: '<%=Resources.Resource.value %>'
            }
        },
        tooltip: {
            useHTML: true,
            formatter: function () {
                var s;
                if (this.point.name) { // the pie chart
                    s = '' +
                        this.point.name + ': ' + this.y + ' %';
                } else {
                    s = '' +
                        this.x + ': ' + this.y;
                }
                return '<span style="float:<%= floatStr %>;">' + s + '</span>';
            }
        },
        labels: {
            items: [{
                html: '',
                style: {
                    left: '40px',
                    top: '8px',
                    color: 'black'
                }
            }]

        },
        legend: {
            itemStyle: {
                color: '#000000',
                fontWeight: 'bold',
                itemWidth: 150
            },
            useHTML: true
        },
        series: [{
            type: 'column',
            name: '<%=Resources.Resource.late %>',
            color: '#55acee',
            data: late
        }, {
            type: 'column',
            name: '<%=Resources.Resource.early %>',
            color: '#7c38bc',
            data: early
        }, {
            type: 'column',
            name: '<%=Resources.Resource.leave %>',
            color: '#f7aa47',
            data: leave
        }, {
            type: 'column',
            name: '<%=Resources.Resource.absent %>',
            color: '#cc3f44',
            data: absent
        }, {
            type: 'spline',
            name: '<%=Resources.Resource.average %>',
            data: average,
            marker: {
                lineWidth: 1,
                lineColor: Highcharts.getOptions().colors[3],
                fillColor: 'white'
            }
        }]
    });
}

function Tab3(late, early, leave, absent) {

    $('#chart_div1').highcharts({
        chart: {
            type: 'column',
        },
        title: {
            text: '<%=Resources.Resource.violationTrends %>'
        },
        subtitle: {
            text: '<%=Resources.Resource.late %> / <%=Resources.Resource.early %> / <%=Resources.Resource.absent %>'
        },
        xAxis: {
            categories: ['<%=Resources.Resource.jan %>', '<%=Resources.Resource.feb %>', '<%=Resources.Resource.mar %>', '<%=Resources.Resource.apr %>', '<%=Resources.Resource.may %>', '<%=Resources.Resource.jun %>', '<%=Resources.Resource.jul %>', '<%=Resources.Resource.aug %>', '<%=Resources.Resource.sep %>', '<%=Resources.Resource.oct %>', '<%=Resources.Resource.nov %>', '<%=Resources.Resource.dec %>']
        },
        yAxis: {
            min: 0,
            max: 100,
            title: {
                text: '<%=Resources.Resource.percentage %>'
            }
        },
        tooltip: {
            headerFormat: '<span style="float:<%= floatStr %>;font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0,
                borderWidth: 0
            }
        },
        series: [{
            name: '<%=Resources.Resource.late %>',
            color: '#27A9E3',
            data: late

        }, {
            name: '<%=Resources.Resource.early %>',
            color: '#852B99',
            data: early

        }, {
            name: '<%=Resources.Resource.leave %>',
            color: '#FFB848',
            data: leave

        }, {
            name: '<%=Resources.Resource.absent %>',
            color: '#E7191B',
            data: absent

        }]
    });
};
function Tab1(late, early, absent, leave, present, missedIn, missedOut) {

    $("#divViolationTrends").mask("<%=Resources.Resource.processing %>" + "....");
    $('#chart_div1').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '<span style="float:<%= floatStr %>;">{series.name}: <b>{point.percentage:.1f}%</b></span>',
            useHTML: true
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<span style="float:<%= floatStr %>;"><b>{point.name}</b>: {point.percentage:.1f} %</span>'
            }
        }
    },
        series: [{
            type: 'pie',
            name: '<%=Resources.Resource.value %>',
        data: [
              {
                  name: '<%=Resources.Resource.leave %>',
                  y: leave,
                  color: '#ffb848'
              },
             {
                 name: '<%=Resources.Resource.late %>',
                 y: late,
                 color: '#aa00ff'
             },
             {
                 name: '  <%=Resources.Resource.early %>',
                 y: early,
                 color: '#e91e63'
             },
              {
                  name: '<%=Resources.Resource.absent %>',
                  y: absent,
                  color: '#e7191b',
                  sliced: true,
                  selected: true
              },
              {
                  name: '<%=Resources.Resource.normal %>',
                  y: present,
                  color: '#28b779'
              },
              {
                  name: '<%=Resources.Resource.missedin %>',
                  y: missedIn,
                  color: '#009688'
              },
              {
                  name: '<%=Resources.Resource.missedOut %>',
                  y: missedOut,
                  color: '#00BCD4',
              }
        ]
    }]
    });
};


        

        function Approve(id, type) {
           var v = "key=approvePermissions&";
           var u = "";
           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           var k = 1;
           v += "chk1=" + id + "&";
           v += "Type1=" + type + "&";
           v += "count=1";
          
           if (k == 0) {
               $("#divErrorMsg2").css("display", "block");
               $("#spnErrorMsg2").html("<%=Resources.Resource.selectOne %>");
              return;
          }
          if (confirm("<%=Resources.Resource.approveConfirm %>")) {
              $.ajax({
                  type: 'POST',
                  data: v,
                  url: '<%= Page.ResolveClientUrl("~/RequestPages/ApprovalPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           LoadPendingCountCharts();
                           LoadPendingGrid("");
                       }
                       else if (html == "-1") {
                           $("#divErrorMsg2").css("display", "block");
                           $("#spnErrorMsg2").html("<%=Resources.Resource.errorPayrollDataAlreadyProcessed %>");
                       }
                       else {
                           $("#divErrorMsg2").css("display", "block");
                           $("#spnErrorMsg2").html("<%=Resources.Resource.error %>");
                       }
                   },
                   error: function (html) {

                   }
               });
           }
           else {
           }
       }

        function Reject(id, type) {
           var v = "key=rejectPermissions&";

           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           var k = 1;
           v += "chk1=" + id + "&";
           v += "Type1=" + type + "&";
           v += "count=1"; 

           if (k == 0) {
               $("#divErrorMsg2").css("display", "block");
               $("#spnErrorMsg2").html("<%=Resources.Resource.selectOne %>");
               return;
           }
           if (confirm("<%=Resources.Resource.rejectConfirm %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("~/RequestPages/ApprovalPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           LoadPendingCountCharts();
                           LoadPendingGrid("");
                      }
                      else if (html == "-1") {
                          $("#divErrorMsg2").css("display", "block");
                          $("#spnErrorMsg2").html("<%=Resources.Resource.errorPayrollDataAlreadyProcessed %>");
                      }
                      else {
                          $("#divErrorMsg2").css("display", "block");
                          $("#spnErrorMsg2").html("<%=Resources.Resource.error %>");
                       }
                  },
                   error: function (html) {

                   }
               });
       }
       else {
       }
   }

var activityClosure = {

    activityLastTransactionTime: '<%= DateTime.UtcNow.AddHours(TAMSR2Framework.DAL.AppSetting.defaultTimeZone).ToString("yyyy-MM-dd 00:00:00") %>',
    totalCount: 0,
    ActiveEmpIds: [],
    toolTipHtml: ""

};

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
    purple: "#7c38bc",
    orange: "#ff851b",
    red: "#cc3f44",
    green: "#a1c436"

};

function Clear(reset) {

    $('#ddOrg option[value=""]').attr('selected', 'selected');
    $("#ddOrg").trigger("liszt:updated");
    $('#ddEmp option[value=""]').attr('selected', 'selected');
    $("#ddEmp").trigger("liszt:updated");
    $('#ddMgr option[value=""]').attr('selected', 'selected');
    $("#ddMgr").trigger("liszt:updated");

    if (reset == true) {
        loadStep = 2;
        LoadGroupVoilations(false);
        LoadGraph("tab1")
        PieDrill();
    }
}
var FormComponents = function () {

    var handlejQueryUIDatePickers = function () {
        $(".ui-date-picker").datepicker();

    }

    var handleDateTimePickers = function () {

        if (jQuery().datepicker) {
            $('#txtDashboardDate').datepicker({ format: 'yyyy-mm-dd', viewMode: "years" });
        }



    }

    var handleInputMasks = function () {
        $.extend($.inputmask.defaults, {
            'autounmask': true
        });

        $("#txtDashboardDate").inputmask("y-m-d", { autoUnmask: true });
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
    </script>
</asp:Content>