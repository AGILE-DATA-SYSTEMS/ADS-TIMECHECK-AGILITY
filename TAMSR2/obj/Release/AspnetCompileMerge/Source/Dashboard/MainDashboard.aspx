<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MainDashboard.aspx.cs" Inherits="TAMSR2.Dashboard.MainDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.home %> - <%=Resources.Resource.applicationName %> </title>

    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/linecons/css/linecons.css'>
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/fontawesome-4.2.0/css/font-awesome.min.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>//plugins/jquery-ui/jquery-ui-1.10.1.custom.min.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
   <link href="assets/EN/plugins/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen"/>
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
        Sample_2
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
    
    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="portlet-config1" class="modal hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.dashboardFilters %>  </h4>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <form action="#" id="form_1" class="form-horizontal" style="min-height:350px !Important;">
                                   
                                <div class="row-fluid datecontrol">
                                    <div class="span6 ">
                                          <div class="control-group">
                                               <label class="control-label"><%=Resources.Resource.date %><span class="required">*</span></label>
                                                   <div class="controls">
                                                   <input id="txtDashboardDate12" name="DashboardDate1" style="width: 211px;" data-required="1" class="m-wrap m-ctrl-medium date-picker reportcalendar" size="16" type="text" value="" />
                                              </div>
                                         </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <div class="control-group">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="controls">
                                        <input id="chkboxActive" type="checkbox" name="active" />
                                        <%=Resources.Resource.active %>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <span id="spnID" style="display: none;">0</span>
                                    <a id="btnSearch1" class="label label-info label-mini"><%=Resources.Resource.search %></a>
                                    <a id="btnSearchClear" onclick="return Clear(true)" class="label label-inverse label-mini"><%=Resources.Resource.clear %></a>
                                    <a id="btnClosePopup" data-dismiss="modal" class="label label-mini"><%=Resources.Resource.close %></a>
                                </div>
                            </form>
                            <!-- END FORM-->
                        </div>
                    </div>
                    <!-- END VALIDATION STATES-->
                </div>
            </div>
        </div>
    </div>
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
                    <small style="display: none;">statistics and more</small>
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("../Common/Home") %>'><%=Resources.Resource.home %> </a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="javascript:void(0)"><%=Resources.Resource.dashboard %> </a></li>
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
            
            <div class="row" id="divSelfStats">
                <div class="box">
                    <div class="panel-heading">
                        <div class="panel-heading-text">
                            <i class="fa fa-cloud" style="display:none;"></i>
                            <h3 class="panel-title"><%= Resources.Resource.selfStatistic %></h3>
                        </div>

                    </div>
                    <div class="panel-body">
                        <div id="statswidgets" class="row-fluid" style="float: <%= floatStr %>">
                           
                            <div class="span3 responsive" style="float: <%= floatStr %>" data-tablet="span6" data-desktop="span3">
                             <div class="dashboard-stat blue">
                                <div class="visual">
                                   <i class="linecons-clock"></i>
                                </div>
                                <div class="details"  style="margin-top:-20px !important;">
                                    <div class="number" ><strong id="spnSchName">Normal</strong>  </div>
                                   <div class="desc">
                                            <span class="SchTimeSpan" id="spnSchTime">07:00 - 15:00</span>
                                            <br />
                                            <span class="SchTimeSpan" id="spnSchTimeWithFlexible">09:00 - 17:00</span></div>
                                </div>
                                <a class="more" href="#" style="text-align: <%= floatStr %> ; min-height: 30px!important;" data-toggle="modal">
                                 <span style="float: left;">
                                        <label style="float: left; margin-right: 10px;"><%=Resources.Resource.timeIn %></label><span id="spnTimeIn" style="font-size: 11px; color: #fff;">&nbsp;</span><%--<i class="m-icon-swapright m-icon-white"></i>--%>
                                 </span>
                                  <span style="float: right;">
                                    <label style="float: left; margin-right: 10px;"><%=Resources.Resource.expectedTimeOut %></label><span id="spnExpectedTimeOut" style="float: right;font-size: 11px; color: #fff;">&nbsp;</span>              
                                </span>
                                </a>      
                                  
                             </div>
                          </div>
                            <div class="span3 responsive" style="float: <%= floatStr %>" data-tablet="span6" data-desktop="span3">
                             <div class="dashboard-stat lightpurple">
                                <div class="visual">
                                   <i class="icon-tag"></i>
                                </div>
                                <div class="details">
                                   <div class="number"><strong><%=Resources.Resource.late  %> </strong></div>
                                   <div class="desc"><span id="spnLateIn"  ></span> </div>
                                </div>
                                <a class="more" href="#portlet-config" style="text-align: <%= floatStr %> ; min-height: 30px!important;" onclick="clearMainPopup(); return LoadMyViolationPopup('late', 'single')" data-toggle="modal"  >
                                <label style="float: left; margin-right: 10px;"><%=Resources.Resource.totalLate %></label><span style="float: left;" id="spnLateMinutes"></span> <i class="m-icon-swapright m-icon-white"></i>
                                </a>                 
                             </div>
                          </div>
                            <div class="span3 responsive" style="float: <%= floatStr %>" data-tablet="span6  fix-offset" data-desktop="span3">
                             <div class="dashboard-stat pink">
                                <div class="visual">
                                   <i class="icon-tags"></i>
                                </div>
                                <div class="details">
                                   <div class="number"><strong><%=Resources.Resource.early  %></strong></div>
                                   <div class="desc"><span id="spnEarlyOut"  >&nbsp;</span> </div>
                                </div>
                                <a class="more" style="min-height: 30px!important;" href="#portlet-config" onclick="return LoadMyViolationPopup('early', 'single')" data-toggle="modal" >
                                <label style="float: left; margin-right: 10px;"><%=Resources.Resource.totalEarly %></label>
                                            <span style="float: left;" id="spnEarlyMinutes"></span> <i class="m-icon-swapright m-icon-white"></i>
                                </a>                 
                             </div>
                          </div>
                            <div class="span3 responsive" style="float: <%= floatStr %>" data-tablet="span6" data-desktop="span3">
                             <div class="dashboard-stat yellow">
                                <div class="visual">
                                   <i class=" icon-certificate"></i>
                                </div>
                                <div class="details">
                                   <div class="number"><strong><%=Resources.Resource.leaves %></strong></div>
                                   <div class="desc"><span   id="spnLeave">&nbsp;</span></div>
                                </div>
                                <a class="xe-lower more" href="#portlet-config" onclick="return LoadMyViolationPopup('leave', 'single')" data-toggle="modal" style="min-height: 30px!important;">
                                <label style="float: left; margin-right: 10px;"><%=Resources.Resource.viewDetails %></label><span style="float: left;" id="spnLeaveMinutes"></span><i class="m-icon-swapright m-icon-white"></i>
                                </a>                 
                             </div>
                          </div>
                  
  
                         </div>
                         <div id="Div3" class="row-fluid" style="float: <%= floatStr %>">
                              <div class="span3 responsive" data-tablet="span6" data-desktop="span3">
                             <div class="dashboard-stat red">
                                <div class="visual">
                                   <i class="icon-bell"></i>
                                </div>
                                <div class="details">
                                   <div class="number"><strong><%=Resources.Resource.absent %></strong></div>
                                   <div class="desc"><span id="spnAbsent">&nbsp;</span></div>
                                </div>
                                <a class="more" href="#portlet-config" style="text-align: <%= floatStr %> ; min-height: 30px!important;" onclick="return LoadMyViolationPopup('absent', 'single')" data-toggle="modal"> 
                                 <label style="float: left; margin-right: 10px;"><%=Resources.Resource.viewDetails %></label><span style="float: left;"></span><i class="m-icon-swapright m-icon-white"></i>
                                </a>                 
                             </div>
                          </div>
                              <div class="span3 responsive" style="float: <%= floatStr %>" data-tablet="span6" data-desktop="span3">
                             <div class="dashboard-stat Seagreen">
                                <div class="visual">
                                   <i class="icon-signin"></i>
                                </div>
                                <div class="details">
                                    <div class="number"><strong><%=Resources.Resource.missedin %></strong></div>
                                   <div class="desc"><span id="spnMissIN">&nbsp;</span></div>
                                </div>
                                <a class="more" href="#portlet-config" style="text-align: <%= floatStr %> ; min-height: 30px!important;" onclick="return LoadMyViolationPopup('missedin', 'single')" data-toggle="modal"> 
                                 <label style="float: left; margin-right: 10px;"><%=Resources.Resource.viewDetails %></label><span style="float: left;"></span><i class="m-icon-swapright m-icon-white"></i>
                                </a>         
                             </div>
                          </div>
                          <div class="span3 responsive" style="float: <%= floatStr %>" data-tablet="span6" data-desktop="span3">
                             <div class="dashboard-stat Skyblue">
                                <div class="visual">
                                   <i class="icon-signout"></i>
                                </div>
                               <div class="details">
                                            <div class="number"><strong><%=Resources.Resource.missedOut %></strong></div>
                                           <div class="desc"><span id="spnMissOut">&nbsp;</span></div>
                                        </div>
                                        <a class="more" href="#portlet-config" style="text-align: <%= floatStr %> ; min-height: 30px!important;" onclick="return LoadMyViolationPopup('missedOut', 'single')" data-toggle="modal"> 
                                         <label style="float: left; margin-right: 10px;"><%=Resources.Resource.viewDetails %></label><span style="float: left;"></span><i class="m-icon-swapright m-icon-white"></i>
                                        </a>     
                             </div>
                        </div>
                             
                          <div class="span3 responsive" style="float: <%= floatStr %>" data-tablet="span6" data-desktop="span3">
                             <div class="dashboard-stat Brown">
                        <div class="visual">
                           <i class="icon-table"></i>
                        </div>
                       <div class="details">
                                    <div class="number"><strong>  <%= Resources.Resource.permissions %></strong></div>
                                   <div class="desc"><span id="spnPermission">&nbsp;0</span></div>
                                </div>
                                <a class="more" href="#portlet-config" style="text-align: <%= floatStr %> ; min-height: 30px!important;" onclick="clearMainPopup(); return LoadMyViolationPopup('permissions', 'single')" data-toggle="modal"> 
                                 <label style="float: left; margin-right: 10px;"><%=Resources.Resource.total + ' ' + Resources.Resource.permissions %></label> 
                                     <span style="float: left;" id="spnPermissionMinutes"></span> <i class="m-icon-swapright m-icon-white"></i>
                                </a>     
                     </div>

                         </div>
                         </div>
                    </div>
                </div>

            </div> 
             

            <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_MY_PENDING_REQUESTS) == true)
                {%>
            <div id="divPendingRequests" class="row" >
              <div class="col-sm-3 col-lg-3 " id="divAttendanceActivity" style="min-width:25% !Important">
                  <div class="box" style="min-height:527px !Important;">
                        <div class="panel-heading">
                            <div class="panel-heading-text">
                                <i class="fa fa-signal" style="display:none;"></i>
                                <h3 class="panel-title"><%=Resources.Resource.pending + " " + Resources.Resource.requests %></h3>
                            </div>

                            <div class="panel-control">

                                <div class="btn-group">
                                    <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="btn-toggle" title="" data-original-title="collapse"><i class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" > 
                          <div class="row-fluid"  >
                              <div class="span12">
                                 <div class="easy-pie-chart">
                                    <div class="number Leaves easyPieChart" data-percent="100" style="width: 50px; height: 50px; line-height: 50px;"><span id="spnLeaves"></span> </div>
                                    <a class="title" href="javascript:void(0)" style="font-size:12px !Important;"><%=Resources.Resource.leaves %></a>
                                 </div>
                              </div>
                              <div class="margin-bottom-10 visible-phone"></div> 
                              </div>
                          <div class="row-fluid">
                              <div class="span12">
                                 <div class="easy-pie-chart">
                                    <div class="number Permissions easyPieChart" data-percent="100"  style="width: 50px; height: 50px; line-height: 50px;"><span id="spnPermissions"></span> </div>
                                    <a class="title" href="javascript:void(0)" style="font-size:12px !Important;"><%=Resources.Resource.permissions %></a>
                                 </div>
                              </div>
                              <div class="margin-bottom-10 visible-phone"></div> 
                           </div>
                          <div class="row-fluid">
                              <div class="span12">
                                 <div class="easy-pie-chart">
                                    <div class="number MissingMovements easyPieChart"  data-percent="100" style="width: 50px; height: 50px; line-height: 50px;"><span id="spnMissing"></span> </div>
                                    <a class="title" href="javascript:void(0)" style="font-size:12px !Important;"><%=Resources.Resource.missingMovements %></a>
                                 </div>
                              </div>
                              <div class="margin-bottom-10 visible-phone"></div> 
                            </div>
                          <div class="row-fluid" style="display:none;">
                              <div class="span12">
                                 <div class="easy-pie-chart">
                                    <div class="number ManualMovements easyPieChart"  data-percent="100" style="width: 50px; height: 50px; line-height: 50px;"><span id="spnManual"></span> </div>
                                    <a class="title" href="javascript:void(0)" style="font-size:12px !Important;"><%=Resources.Resource.manualMovements %></a>
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
                                <h3 class="panel-title"><%=Resources.Resource.pending + " " + Resources.Resource.requests %></h3>
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
                                         <th style="text-align: left;"><%=Resources.Resource.request + " " + Resources.Resource.type %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.type %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.fromDate %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.toDate %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.fromTime %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.toTime %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.duration %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.remarks %></th>
                                         <th style="text-align: left;"><%=Resources.Resource.status %></th>
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
            <div class="row" id="divMovements">
                <div class="box">
                    <div class="panel-heading">
                        <div class="panel-heading-text">
                            <i class="fa fa-database" style="display:none;"> </i>
                            <h3><%= (Session["Username"] +"").ToUpper() + "  " + Resources.Resource.monvementsFor + " " %> <span id="spnMovementDate">&nbsp;</span></h3>
                        </div>
                        <div class="panel-control">
                            <button style="display:none;" onclick="return LoadGrid()" data-toggle="panel-overlay" data-target="#demo-panel-network" class="btn"><i class="fa fa-rotate-right"></i></button>
                            <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus"></i></button>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div id="divSuccessMsg2" class="alert alert-success hide">
                            <span id="spnSuccessMsg2"><%=Resources.Resource.formErrors %></span>
                        </div>
                        <div id="divErrorMsg2" class="alert alert-error hide">
                            <span id="spnErrorMsg2"><%=Resources.Resource.formErrorsRemoved %></span>
                        </div>
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="spnGridMsg">&nbsp;</span>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover" id="sample_1">
                                <thead>
                                    <tr>
                                        <th><%=Resources.Resource.code %></th>
                                        <th><%=Resources.Resource.name %></th>
                                        <th><%=Resources.Resource.device %></th>
                                        <th class="text-center" style="display: none"><%=Resources.Resource.location %></th>
                                        <th class="text-right"><%=Resources.Resource.direction %></th>
                                        <th class="hidden-480"><%=Resources.Resource.transactionTime %></th>
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

     

    <!-- END PAGE LEVEL SCRIPTS -->
    <script>
        var loadStep = 0;
        window.requestPageUrl = '<%= Page.ResolveClientUrl("~/RequestPages/DashboardSelfStatsPage.aspx") %>';
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
            Index.initDashboardDaterange();
            Index.setDashBoardDate();
            Index.init();
            LoadPendingCountCharts(); 
            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liDashboard").addClass("active");
            $("#liDashboard .arrow").addClass("open");
            $("#liHome").addClass("active");
               
            $('.page-container').on('classChange', function () {
                alert('ddd');
            });
            $("#txtDashboardDateMain").change(function () {
                $('.datepicker').hide();
                $("ul.nav-tabs li.active a").click();
                Index.setDashBoardDate();
                loadStep = 2;   
                LoadGrid();
                LoadDashboard(true); 
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
            $("#spnMovementDate").html(day + "-" + month + "-" + year);


            if ('true' == '<%= (Session["rootUser"] + "").ToLower() %>') {
                $("#dashboard").css("display", "none");
            }
            else {

                LoadGrid();
                LoadWebPunchReasons();
                if ("<%= (ViewState["features"] + "").Split(',').GetValue(0) %>" != "") {
                    $("#ulVerifications li").removeClass("active");
                    $("#fli_" + "<%= (ViewState["features"] + "").Split(',').GetValue(0) %>").addClass("active");
                }
            }
             
        });
         
         
        function imposeMaxLength(Object, evt, MaxLen) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
            return (Object.value.length < MaxLen);
        }
         
        function LoadWebPunchReasons() {
            loadStep = 1;
            var d = "key=webpunchReasons";
            $(".feeds").html("<li>&nbsp;</li>");
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/WebpunchPage.aspx") %>',
                success: function (html) {
                    $("#liWebPunch").html(html);
                    LoadDashboard(false);

                },
                error: function (html) {
                    LoadDashboard(false);
                    $("#liWebPunch").html("&nbsp;");
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");

                }
            });
        }
        var IsError = "1";
        function EmpWebPunch(rMode, rID, msg) {
            <% if(EnabledGeoLocation.ToLower() == "true" || EnabledGeoLocation.ToLower() == "yes") 
              {  %>
            $.ajax(getLocationUpdate()).then(function (html) {

                var location = latitude + ',' + longitude


                if (location != "" && location != '' && location != 'undefined,undefined') {
                    AddWebPunch(rMode, rID, msg, location);
                }
                else {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                        $("#spnErrorMsg").css("display", "block");
                        $("#btnAlertError").click();
                    }
                });
            <% } 
               else 
               { %>
            AddWebPunch(rMode, rID, msg, location)
            <% } %>

        }
        function AddWebPunch(rMode, rID, msg, location) {

            var v = "key=saveWebPunch" + "&rMode=" + rMode + "&rID=" + rID + "&rlocation=" + location;

            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/TAEventPage.aspx") %>',
                success: function (html) {
                    if (html == '-1') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                        $("#spnErrorMsg").css("display", "block");
                        $("#btnAlertError").click();
                    }
                    else if (html == '-2') {
                        //exists
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>" + " You are not allowed to punch again before  <%= Session["WebPunchDelay"] + " minutes" %>");
                        $("#spnErrorMsg").css("display", "block");
                        $("#btnAlertError").click();
                    }
                    else if (html == '0') {
                        //exists
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                        $("#spnErrorMsg").css("display", "block");
                        $("#btnAlertError").click();
                    }
                    else {
                        //success
                        $("#divSuccessMsg").css("display", "block");
                        $("#spnSuccessMsg").html(msg + " <br />" + "<%=Resources.Resource.msgRecordSaved %>");
                        $("#spnSuccessMsg").css("display", "block");
                        $("#btnAlertMessage").click();
                        ReloadDashboard();
                    }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("Error! " + html);
                    $("#spnErrorMsg").css("display", "block");
                    $("#btnAlertError").click();
                }

            });
}
function ReloadDashboard() {
    loadStep = 0;
    LoadWebPunchReasons();
    LoadGrid();
    LoadDashboard();
    LoadGroupVoilations();
    LoadPendingGrid()
    $("ul.nav-tabs li.active a").click();

}

function LoadGrid() {

    var dt = $("#txtDashboardDate").val();
    if (dt == "" || dt == "Select date...") {
        dt = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
    }
    $("#divMovements").mask("<%=Resources.Resource.processing %>" + "....");
    ////////Get Users and load in grid/////////
    var oTable = $('#sample_1').dataTable({
        "bProcessing": true,
        "bServerSide": true,
        "bDestroy": true,
        "bFilter": false,
        "sPaginationType": "bootstrap",
        "aoColumns": [
          { "bSortable": true },
          { "bSortable": true },
          { "bSortable": true },
          { "bSortable": true },
          { "bSortable": true },
          { "bSortable": true }
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
        "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/DashboardSelfStatsPage.aspx?key=getAllTrans") %>' + '&dt=' + dt
    });

    $("#divMovements").unmask();
    LoadPendingGrid();
}
         
function LoadMyViolationPopup(type, scope) {

    var dt = $("#txtDashboardDate").val();
    var emp = $("#ddEmp").val();
    var mgr = $("#ddMgr").val();
    var org = $("#ddOrg").val();

    var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";
    ////////Get Users and load in grid/////////
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
        "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/DashboardSelfStatsPage.aspx?key=getMyViolations") %>' + '&type=' + type + '&scope=' + scope + '&dt=' + $("#txtDashboardDate").val() + wc
    });
    $('#sample_Late_Early').css("width", "100%");
    

}

        /// Pending Count Charts 

 function LoadPendingCountCharts()
      { 
            var d = "key=getMyPendingRequests";
            $.ajax({
                type: 'GET',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardSelfStatsPage.aspx") %>',
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

         //   $(".easy-pie-chart div").attr("data-percent", 60);
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
             
            //$('.easy-pie-chart-reload').click(function () {
            //    $('.easy-pie-chart .number').each(function () {
            //        var newValue = Math.floor(100 * Math.random());
            //        $(this).data('easyPieChart').update(newValue);
            //        $('span', this).text(newValue);
            //    });
            //});

        } 


        /// End


        /// Load Pending Requests Lists


        function LoadPendingGrid() {
  
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/DashboardSelfStatsPage.aspx") %>' + '?key=getAllPendingRequests'; 
           
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
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "8%" },
                 { "bSortable": true, sWidth: "9%" },
                 { "bSortable": true, sWidth: "9%" },
                 { "bSortable": true, sWidth: "9%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "17%" },
                 { "bSortable": false, sWidth: "12%" }
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
               "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/DashboardSelfStatsPage.aspx?key=getAllPendingRequests") %>' + "&sSearchFilter=" + filterValue
           });

            $("#Sample_2").width("99.5%");
        }

        //END

function LoadDashboard(applyFilters) {
    var dt = $("#txtDashboardDate").val();
    if (dt == "" || dt == "Select date..." || dt == "Select Date") {
        dt = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
    }

    loadStep = 2;

    var d = "key=getDashboardStat";
    d += "&dt=" + dt;

    $.ajax({
        type: 'POST',
        data: d,
        url: '<%= Page.ResolveClientUrl("../RequestPages/DashboardSelfStatsPage.aspx") %>',
        success: function (html) {

            if (html != "") {
                var j = $.parseJSON(html);
                $("#spnSchName").html(j.SchCode);
                $("#spnSchTime").html(j.Shift1);
                //  spnLateIn   spnEarlyOut   spnAbsent     
                $("#spnFlexible").html(j.Flexible);
                $("#spnGraceIn").html(j.GraceIn);
                $("#spnGraceOut").html(j.GraceOut);
                $("#spnTimeIn").html(j.TimeIn);
                $("#spnTimeOut").html(j.TimeOut);
                $('#spnExpectedTimeOut').html(j.ExpectedTimeOut);
                $('#spnSchTimeWithFlexible').html(j.SchWithFlexible);
                //$("#spnLateIn").html(j.Late + "/" + j.MonthlyLate);
                //$("#spnEarlyOut").html(j.Early + "/" + j.MonthlyEarly);
                //$("#spnAbsent").html(j.Absent + "/" + j.MonthlyAbsent);
                $("#spnLateIn").html(j.LateMinutes);
                $("#spnEarlyOut").html(j.EarlyMinutes);
                $("#spnAbsent").html(j.MonthlyAbsent);
                $("#spnLeave").html(j.Leave);
                $("#spnLateMinutes").html(j.MonthlyLateMinutes + " / " + j.MonthlyLate);
                $("#spnEarlyMinutes").html(j.MonthlyEarlyMinutes + " / " + j.MonthlyEarly);

                $("#spnMissIN").html(j.MissedIn);
                $("#spnMissOut").html(j.MissedOut);

                $("#spnPermission").html(j.PermissionMinutes);
                $("#spnPermissionMinutes").html(j.MonthlyPermissionMinutes + " / " + j.MonthlyPermission);

            }
            if ($("#spnFlexible").html() == "&nbsp;" || $("#spnFlexible").html() == "")
                $("#spnFlexible").html("00:00");
            if ($("#spnGraceIn").html() == "&nbsp;" || $("#spnGraceIn").html() == "")
                $("#spnGraceIn").html("00:00");
            if ($("#spnGraceOut").html() == "&nbsp;" || $("#spnGraceOut").html() == "")
                $("#spnGraceOut").html("00:00");
           
        },
        error: function (html) {
            $("#spnFlexible").html("00:00");
            $("#spnGraceIn").html("00:00");
            $("#spnGraceOut").html("00:00"); 
        }
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
function Clear(reset) { 
    if (reset == true) {
        loadStep = 2; 
    }
}

var watchID;
var geoLoc;

function showLocation(position) {
    latitude = position.coords.latitude.toFixed(5);
    longitude = position.coords.longitude.toFixed(5);
}

function errorHandler(err) {
    if (err.code == 1) {
        location = "";
        alert("Error: Access is denied!");
    } else if (err.code == 2) {
        alert("Error: Position is unavailable!");
    }
}

var getLocationUpdate = function () {
    var r = $.Deferred();
    if (navigator.geolocation) {

        // timeout at 60000 milliseconds (60 seconds)
        var options = { timeout: 60000 };
        geoLoc = navigator.geolocation;
        watchID = geoLoc.getCurrentPosition(showLocation, errorHandler, options);

    } else {
        alert("Sorry, browser does not support geolocation!");
    }
    return r;
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