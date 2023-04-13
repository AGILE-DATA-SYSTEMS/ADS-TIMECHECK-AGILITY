<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TAMSR2.Common.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.home %> - <%=Resources.Resource.applicationName %> </title>

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
                    <li><a href="#"><%=Resources.Resource.dashboard %> </a></li>
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
                            <i class="fa fa-cloud"></i>
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
                                    <div class="number"><strong><%= Resources.Resource.personal + " " + Resources.Resource.permissions %></strong></div>
                                   <div class="desc"><span id="spnPermission">&nbsp;0</span></div>
                                </div>
                                <a class="more" href="#portlet-config" style="text-align: <%= floatStr %> ; min-height: 30px!important;" onclick="clearMainPopup(); return LoadMyViolationPopup('permissions', 'single')" data-toggle="modal"> 
                                 <label style="float: left; margin-right: 10px;"><%=Resources.Resource.total + ' ' + Resources.Resource.personal + ' ' + Resources.Resource.permissions %></label> 
                                     <span style="float: left;" id="spnPermissionMinutes"></span> <i class="m-icon-swapright m-icon-white"></i>
                                </a>     
                     </div>

                         </div>
                         </div>
                    </div>
                </div>

            </div>
        <!-- Dashboard Filters  Starts -->
         <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_FILTERS) == true)
            { %>
            <div class ="row" id="divTeam">
              <div class="box">
                <div class="panel-heading">
                    <div class="panel-heading-text">
                        <i class="fa fa-filter"></i>
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
                        <div class="span3">
                            <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.organization %> </label>
                                    <div class="controls chzn-controls"  >
                                        <select id="ddOrg" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        <div class="span3">
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.manager %>  </label>
                                    <div class="controls">

                                        <select id="ddMgr" name="mgr" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.manage %>">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        <div class="span3">
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.employee %> </label>
                                    <div class="controls chzn-controls">
                                        <select id="ddEmp" name="emp" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>">
                                            <option value=""></option>
                                        </select>
                                        
                                    
                                    </div>
                                </div>
                            </div> 
                      <div class="span3">
                            <a class="btn green pull-<%= pullDirectionStr%>" id="btnSearch" style="background-color:#1d943b !important; color:#fff !important; float='"  data-toggle="modal"><%=Resources.Resource.apply %></a>
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
                        <i class="fa fa-cloud"></i>
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
            <div class="row" >
                   <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ATTENDANCE_ACTIVITY) == true)
                   { %>
                  <div class="col-sm-6 col-lg-6 " id="divAttendanceActivity">
                    <div class="box">
                        <div class="panel-heading">
                            <div class="panel-heading-text">
                                <i class="fa fa-signal"></i>
                                <h3 class="panel-title"><%=Resources.Resource.attendanceActivity %></h3>
                            </div>

                            <div class="panel-control">

                                <div class="btn-group">
                                    <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="btn-toggle" title="" data-original-title="collapse"><i class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div id="container-live-attendance" class="collapse" style="height: 304px; margin-top: 15px;"></div>
                        </div>
                    </div>
                </div>
                 <% } %>

                 <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.TREND_VIOLATION_DRILLDOWN_WIDGET) == true)
                   { %> 
                     <div class="col-sm-6 col-lg-6 " id="divDrillDownWidget" style="float: <%= floatStr %>">
                    <div class="box">
                        <div class="panel-heading">
                            <div class="panel-heading-text">
                                <i class="fa fa-signal"></i>
                                <h3 class="panel -title"><%= Resources.Resource.attendanceTrend %> </h3>
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
                                <i class="fa fa-rocket"></i>
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

                 <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_MAP) == true)
                 { %>
                
                 <div class="col-sm-6 col-lg-6" id="divReaderMap" style="min-height:410px !important; height:410px !Important;float: <%= floatStr %>" >
                    <div class="box">
                        <div class="panel-heading">
                            <div class="panel-heading-text">
                                <i class="fa fa-rocket"></i>
                                <h3 class="panel-title"><%=Resources.Resource.map %></h3>
                            </div>

                            <div class="panel-control">

                                <div class="btn-group">
                                    <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="min-height:370px !important;">
                             <div id="map" style="position:absolute !important; width:93% !important; min-height:80% !important; height:80% !important;"></div> 
                        </div>
                    </div>
                </div>
                
                <% } %>
                 <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DATA_PROCESS_ACTIVITY) == true)
                   { %>
                <div class="col-sm-6 col-lg-6 " id="divDataProcessActivity" style="float: <%= floatStr %>">
                    <div class="box">
                        <div class="panel-heading">
                            <div class="panel-heading-text">
                                <i class="fa fa-signal"></i>
                                <h3 class="panel-title"><%= Resources.Resource.dataProcessActivity %> </h3>
                            </div>
                            <div class="panel-control">

                                <div class="btn-group">
                                    <button onclick="return GetDataProcessActivity()" data-toggle="panel-overlay" data-target="#demo-panel-network" class="btn"><i class="fa fa-rotate-right"></i></button>
                                    <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="btn-toggle" title="" data-original-title="collapse"><i class="fa fa-minus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div id="container-data-process-activity" class="collapse" style="height: 304px; margin-top: 15px;"></div>

                        </div>
                    </div>
                </div>
                <% } %>
            </div>

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
                        <ul class="sidebar-nav" id="sidebar_teamefficiency">
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
               <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_VERIFICATION_WIDGET) == true)
               { %>
            <div class="row" id="divVerifications" >
                <div class="box">
                    <div class="panel-heading">
                        <div class="panel-heading-text">
                            <i class="fa fa-check"></i>
                            <h3 class="panel-title"><%=Resources.Resource.verifications %></h3>
                        </div>

                        <div class="panel-control">
                            <div class="btn-group">
                                <button class="dropdown-toggle btn" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-gear"></i></button>
                                <button class="btn btn-info btn-xs" data-widget="collapse" data-toggle="tooltip" title="" data-original-title="Collapse"><i class="fa fa-minus"></i></button>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <li id="fli_LEAVES" style="display: block; text-align: <%= floatStr %>" class="active"><a href="#tab_1_1" onclick="return LoadNotification('leaves')" data-toggle="tab"><%=Resources.Resource.leaves %>   &nbsp; <span id="leavesTab">(0)</span></a> </li>
                                    <li id="fli_PERMISSIONS" style="display: block; text-align: <%= floatStr %>" class="active"><a href="#tab_1_1" onclick="return LoadNotification('permissions')" data-toggle="tab"><%=Resources.Resource.permissions %>   &nbsp; <span id="permissionsTab">(0)</span></a> </li>
                                    <li id="fli_MOVEMENTS" style="display: block; text-align: <%= floatStr %>" class="active"><a href="#tab_1_1" onclick="return LoadNotification('movements')" data-toggle="tab"><%=Resources.Resource.movement %>   &nbsp; <span id="movementsTab">(0)</span></a> </li>
                                    <li id="fli_MISSTIME" style="display: none; text-align: <%= floatStr %>" class="active"><a href="#tab_1_1" onclick="return LoadNotification('missTime')" data-toggle="tab"><%=Resources.Resource.missTime %>   &nbsp; <span id="missTimeTab">(0)</span></a> </li>
                                    <li id="fli_EXTRATIME" style="display: none; text-align: <%= floatStr %>" class="active"><a href="#tab_1_1" onclick="return LoadNotification('extraTime')" data-toggle="tab"><%=Resources.Resource.extraTime %>   &nbsp; <span id="extraTimeTab">(0)</span></a> </li>
                                    <li id="fli_LATE" style="display: block; text-align: <%= floatStr %>" class="active"><a href="#tab_1_1" onclick="return LoadNotification('late')" data-toggle="tab"><%=Resources.Resource.late %>   &nbsp; <span id="lateTab">(0)</span></a> </li>
                                    <li id="fli_EARLY" style="display: block; text-align: <%= floatStr %>" class="active"><a href="#tab_1_1" onclick="return LoadNotification('early')" data-toggle="tab"><%=Resources.Resource.early %>   &nbsp; <span id="earlyTab">(0)</span></a> </li>
                                    <li id="fli_ABSENT" style="display: block; text-align: <%= floatStr %>" class="active"><a href="#tab_1_1" onclick="return LoadNotification('absent')" data-toggle="tab"><%=Resources.Resource.absent %>   &nbsp; <span id="absentTab">(0)</span></a> </li>
                                </ul>
                            </div>
                        </div>

                    </div>
                    <div class="panel-body">
                        <div class="morris-full-content" style="width: 100%; position: relative;">
                            <div class="tab-pane active" id="tab_1_1">
                                <div class="scroller" data-always-visible="1" data-rail-visible="0" style="max-height: 250px">
                                    <ul class="feeds">
                                        <li></li>
                                    </ul>
                                </div>
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
                            <i class="fa fa-database"></i>
                            <h3><%= (Session["Username"] +"").ToUpper() + "  " + Resources.Resource.monvementsFor + " " %> <span id="spnMovementDate">&nbsp;</span></h3>
                        </div>
                        <div class="panel-control">
                            <button onclick="return LoadGrid()" data-toggle="panel-overlay" data-target="#demo-panel-network" class="btn"><i class="fa fa-rotate-right"></i></button>
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

    
    <script async defer type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDZMwwL1hvA0CP1mgah6f1rxe8paenOxoo"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="../Assets/<%= languageStr %>/scripts/app.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/scripts/index.js" type="text/javascript"></script>
    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>


    <link href="../LeanSlider/slider-styles.css" rel="stylesheet" />
    <link href="../LeanSlider/lean-slider.css" rel="stylesheet" />
    <script src="../LeanSlider/modernizr-2.6.1.min.js"></script>
    <script src="../LeanSlider/lean-slider.js"></script>
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
            GetReaderTransactionsCount();

            PieDrill();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#liAdmin .arrow").removeClass("open");
            $("#liHome").addClass("active");


            $("#ddOrg").change(function () {
                LoadManager();
                LoadEmployees();
            });

            $("#ddMgr").change(function () {
                LoadEmployees();
            });
            

            $("#btnSearch").click(function () { 
                loadStep = 2;
                LoadGroupVoilations(true);
                LoadGraph("tab1")
                PieDrill(); 
                LoadGrid();
                LoadDashboard(); 
            });


            $("#txtDashboardDateMain").change(function () {
                $('.datepicker').hide();
                $("ul.nav-tabs li.active a").click();
                Index.setDashBoardDate();
                loadStep = 2;

                LoadGroupVoilations(true);
                LoadGraph("tab1")
                PieDrill();
                LoadGrid();
                LoadDashboard();
                GetTeamList();
                GetReaderTransactionsCount();

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
          
            if (!$('#trendsAndPercentage').is(":visible")) {
                $('#statswidgets').addClass('widget-full-width');
                $('#statswidgets .col-sm-3.col-lg-6').addClass('widget-20per-width');
            }
            else
                $('#statswidgets').removeClass('tams-widget');
            if ($('#container-live-attendance') && $('#container-live-attendance').length > 0) {
                BindPresentStatus();
            } 
            if ($('#TeamBox') && $('#TeamBox').length > 0) {
               GetTeamList();
             }
            if ($('#container-data-process-activity') && $('#container-data-process-activity').length > 0) {
                    GetDataProcessActivity();
                }

        });

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


        ////----------------------------/////////


            function LoadManager() {
                $("#spnErrorMsg").css("display", "none");
                $("#spnSuccessMsg").css("display", "none");
                
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
        var teamBoxTemplate = {
            listOfEmployee: [],
            profileImageUrl: "<%= path %>Handlers/EmployeeProfileImage.ashx?id=",
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

        };
        $('.teamMember').live('click', function () {
            var id = $(this).attr('teamMemberId');
            teamBoxTemplate.currentEmployee = teamBoxTemplate.getTeamMemberById(id);
            SetMemberDetail();

        });

        function GetTeamList() {
            $("#TeamBox").mask("<%=Resources.Resource.processing %>" + "....");

            var emp = $("#ddEmp").val();
            var mgr = $("#ddMgr").val();
            var org = $("#ddOrg").val();

            var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org    ;
            var d = "key=getIdNameTeamList" +wc;
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>',
                success: function (response) {

                    var teamList = $.parseJSON(response);
                    if (teamList) {
                        var teamHtml = "";
                        for (var i = 0; i < teamList.length; i++) {
                            var newTeamObject = new TeamEmployee();
                            newTeamObject.encryptedID = teamList[i].EncryptedID;
                            newTeamObject.nameEn = teamList[i].NameEn;
                            newTeamObject.nameAr = teamList[i].NameAr;
                            teamBoxTemplate.listOfEmployee.push(newTeamObject);
                            teamHtml += " <li class='teamMember' teamMemberId=" + teamList[i].EncryptedID + "><div class='card'><div class='avatar'><img alt='' src='" + teamBoxTemplate.profileImageUrl + teamList[i].EncryptedID + "'style='min-width:100px;width: 100px;' /></div></div></li>";
                        }
                        $('#sidebar_teamefficiency').html(teamHtml);
                        teamBoxTemplate.currentEmployee = teamBoxTemplate.listOfEmployee.length > 0 ? teamBoxTemplate.listOfEmployee[0] : new TeamEmployee();
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
            $('#memberImage').attr('src', teamBoxTemplate.profileImageUrl + teamBoxTemplate.currentEmployee.encryptedID);
            $('#memberName').text(teamBoxTemplate.currentEmployee.nameEn);
            $('#memberDesignation').text(teamBoxTemplate.currentEmployee.designation || 'Unknown');

            
            while (teamBoxTemplate.chartReference.series.length > 0)
                teamBoxTemplate.chartReference.series[0].remove(true);

            
                teamBoxTemplate.chartReference.addSeries({ name: 'Late', color: colors.blue, data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4], violationType: "Late" });

                teamBoxTemplate.chartReference.addSeries({
                    name: 'Early',
                    color: colors.purple,
                    data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3],
                    violationType: "Early"

                });
                teamBoxTemplate.chartReference.addSeries({

                    name: 'Absent',
                    color: colors.red,
                    data: [48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2],
                    violationType: "Absent"

                });
                teamBoxTemplate.chartReference.addSeries({
                    name: 'Leaves',
                    color: colors.orange,
                    data: [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1],
                    violationType: "Leave"

                });

                var emp = $("#ddEmp").val();
                var mgr = $("#ddMgr").val();
                var org = $("#ddOrg").val();

                var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org;
         
                var d = "getMemberYearlyStatistic" + wc;
                 
        };

        function imposeMaxLength(Object, evt, MaxLen) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
            return (Object.value.length < MaxLen);
        }

        function ReloadVerifications() {
            $("#ulVerifications li.active a").click();
        }

        function ReloadGraphs() {
            $("#ulGraphs li.active a").click();
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
                    LoadDashboard();

                },
                error: function (html) {
                    LoadDashboard();
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
    //LoadGrid();
    //LoadDashboard();
    //LoadGroupVoilations();
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
        "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/DashboardPage.aspx?key=getAllTrans") %>' + '&dt=' + dt
    });

    $("#divMovements").unmask();
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
        //$('#sample_Late_Early').addClass('leave');
    }
    if (type == "missed out") {
        $("#popupTitle").html("<%=Resources.Resource.missedOut %>");
        $("#thRemarks").html("<%=Resources.Resource.remarks %>");
        //$('#sample_Late_Early').addClass('leave');
    }

    var emp = $("#ddEmp").val();
    var mgr = $("#ddMgr").val();
    var org = $("#ddOrg").val();

    var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";
    var urlsource=   '<%= Page.ResolveClientUrl("../RequestPages/DashboardPage.aspx?key=getDepartmentViolationDetails") %>' + '&type=' + type + '&code=' 
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
        "sAjaxSource":urlsource
    });
    $('#sample_Late_Early').css("width", "100%");


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
        "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/DashboardPage.aspx?key=getMyViolations") %>' + '&type=' + type + '&scope=' + scope + '&dt=' + $("#txtDashboardDate").val() + wc
    });
    $('#sample_Late_Early').css("width", "100%");


}



function LoadDashboard() {
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
        url: '<%= Page.ResolveClientUrl("../RequestPages/DashboardPage.aspx") %>',
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
            LoadGroupVoilations(); 
        },
        error: function (html) {
            $("#spnFlexible").html("00:00");
            $("#spnGraceIn").html("00:00");
            $("#spnGraceOut").html("00:00"); 
            LoadGroupVoilations(false);
        }
    });
}

function LoadNotificationCount() {
    var dt = $("#txtDashboardDate").val();
    if (dt == "" || dt == "Select date...") {
        dt = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
    }
      <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_VIOLATION) == false)
         { %>
             loadStep = 4;
             LoadNotification("<%= (ViewState["features"] + "").Split(',').GetValue(0) %>");
             return;
       <% } %>

    if (loadStep != 3)
        return;
    loadStep = 4;
    var d = "key=getTabNotificationsCount";
    d += "&dt=" + dt;
    //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
    $.ajax({
        type: 'POST',
        data: d,
        url: '<%= Page.ResolveClientUrl("~/RequestPages/MyNotificationPage.aspx") %>',
        success: function (html) {
            var j = $.parseJSON(html);
            $("#leavesTab").html("(" + j.Leave + ")");
            $("#permissionsTab").html("(" + j.Permission + ")");
            $("#movementsTab").html("(" + j.Movement + ")");
            $("#missTimeTab").html("(" + j.MissTime + ")");
            $("#extraTimeTab").html("(" + j.ExtraTime + ")");
            $("#lateTab").html("(" + j.Late + ")");
            $("#earlyTab").html("(" + j.Early + ")");
            $("#absentTab").html("(" + j.Absent + ")");

            LoadNotification("<%= (ViewState["features"] + "").Split(',').GetValue(0) %>");
        },
        error: function (html) {
            $("#leavesTab").html("(0)");
            $("#permissionsTab").html("(0)");
            $("#movementsTab").html("(0)");
            $("#missTimeTab").html("(0)");
            $("#extraTimeTab").html("(0)");
            $("#lateTab").html("(0)");
            $("#earlyTab").html("(0)");
            $("#absentTab").html("(0)");
            $("#divErrorMsg").css("display", "block");
            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");

            LoadNotification("<%= (ViewState["features"] + "").Split(',').GetValue(0) %>");
        }
    });
}

function LoadNotification(tab) {
    var dt = $("#txtDashboardDate").val();
    if (dt == "" || dt == "Select date...") {
        dt = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
    }

    <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_VIOLATION) == false  )
         { %>
            return;
      <% } %>

    if (loadStep != 4)
        return;
    var d = "key=getTabNotifications&tab=" + tab;
    d += "&dt=" + dt;
    $(".feeds").html("<li>&nbsp;</li>");
    //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
    $.ajax({
        type: 'POST',
        data: d,
        url: '<%= Page.ResolveClientUrl("~/RequestPages/MyNotificationPage.aspx") %>',
        success: function (html) {
            $(".feeds").html(html);
            $("#" + tab + "Tab").html("(" + $("#spnNotifyCount" + tab).html() + ")");

        },
        error: function (html) {
            $(".feeds").html("<li>&nbsp;</li>");
            $("#divErrorMsg").css("display", "block");
            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");

        }
    });
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
            LoadNotificationCount();
            return;
    <% } %>

    if (loadStep != 2)
        return;
    loadStep = 3;
    var wc = "";
    if (filter == true) {
        var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&filter=true";
    }
    else{
         wc = "&emp=" + '' + "&mgr=" + '' + "&org=" + '';
    }

    var d = "key=getGroupVoilations" + wc;
    d += "&dt=" + dt;
 
    $("#divTeamStats").mask("<%=Resources.Resource.processing %>" + "....");
    $.ajax({
        type: 'POST',
        data: d,
        url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>',
        success: function (html) {
            var j = $.parseJSON(html);

            $(".easy-pie-chart div").attr("data-percent", j.MonthlyAchievedHours);
            $('.easy-pie-chart .number.bounce').easyPieChart({
                animate: 1000,
                size: 75,
                lineWidth: 3,
                barColor: App.getLayoutColorCode(j.MonthlyAchievedHoursColor)
            }); 
            var late = j.MonthlyLate.split(',').map(function (str) { return Number(str); });
            var early = j.MonthlyEarly.split(',').map(function (str) { return Number(str); });
            var leaves = j.MonthlyLeave.split(',').map(function (str) { return Number(str); });
            var absent = j.MonthlyAbsent.split(',').map(function (str) { return Number(str); });
            var missIN = j.MonthlyMissedIn.split(',').map(function (str) { return Number(str); });
            var missOut = j.MonthlyMissedOut.split(',').map(function (str) { return Number(str); });
            var permissions = j.MonthlyPermissions.split(',').map(function (str) { return Number(str); });
            

            $("#sparkline_bar").sparkline(late , {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#aa00ff',
                negBarColor: '#e02222'
            }
            );

            $("#sparkline_bar2").sparkline(early , {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#e91e63',
                negBarColor: '#e02222'
            }
             );

            $("#sparkline_bar3").sparkline(leaves , {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#ff9800',
                negBarColor: '#e02222'
            }
              );

            $("#sparkline_bar4").sparkline(absent , {
                type: 'bar',
                width: '100',
                barWidth: 4,
                height: '55',
                barColor: '#e7191b',
                negBarColor: '#e02222'
            }
             );
            $("#sparkline_bar5").sparkline(missIN , {
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

            LoadNotificationCount();
            $("#divTeamStats").unmask();

        },
        error: function (html) {
            $(".feeds").html("<li>&nbsp;</li>");
            $("#divErrorMsg").css("display", "block");
            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");

            LoadNotificationCount();
            $("#divTeamStats").unmask();

        }

    });
        }

        function VerificationTakeAction(nID, tab, approveReject, desc) {

            $("#txtRemarks").val("");
            $("#spnVrfNID").html(0);
            $("#spnVrfTab").html('&nbsp;');
            $("#spnVerification").html('&nbsp;');


            $("#spnVrfNID").html(nID);
            $("#spnVrfTab").html(tab);
            $("#spnVerification").html(desc);
            $("#btnApproveRejectPopup").click();
            return;
        }

        function VerificationAproveReject(approveReject) {
            var dt = $("#txtDashboardDate").val();
            if (dt == "" || dt == "Select date...") {
                dt = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
            }
            var nID, tab, approveReject;
            nID = $("#spnVrfNID").html();
            tab = $("#spnVrfTab").html();

            if (tab == '&nbsp;')
                tab = '';
            var d = "&dt=" + dt;
            //var msg = "Are you sure you want to approve this record?";
            //if (approveReject == "reject")
            //    msg = "Are you sure you want to reject this record?";
            //if (confirm(msg)) {
            d += "&key=approveVerification&nID=" + nID + "&approveReject=" + approveReject + "&tab=" + tab;
            d += "&remarks=" + $("#txtRemarks").val();

            if (($("#txtRemarks").val() + "").trim() == "" || $("#txtRemarks").val() == "&nbsp;") {
                alert('<%=Resources.Resource.remarksRequired %>');
                return;
            }
            //var redirecturl = $("#fli" + nID).attr("rdrurl") + "";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/MyNotificationPage.aspx") %>',
                success: function (html) {
                    //if (redirecturl != "#") {
                    //    window.open(redirecturl, '_blank');
                    //}
                    $("#txtRemarks").val("");
                    $("#spnVrfNID").html(0);
                    $("#spnVrfTab").html('&nbsp;');
                    $("#btnHideVerificationPopup").click();

                    $("#divSuccessMsg").css("display", "block");
                    $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                    $("#btnAlertMessage").click();

                    LoadNotification(tab);
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                    $("#btnAlertError").click();
                }
            });
            //}
            return true;
        }


        function MarkRead(nID, tab) {
            var d = "key=markRead&nID=" + nID;
            var redirecturl = $("#fli" + nID).attr("rdrurl") + "";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/MyNotificationPage.aspx") %>',
        success: function (html) {
            if (redirecturl != "#") {
                window.open(redirecturl, '_blank');
            }
            LoadNotification(tab);
        },
        error: function (html) {
            $("#divErrorMsg").css("display", "block");
            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
            }
         });
        }

       <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.DASHBOARD_WIDGET) == true)
          { %>
        function MarkRead22(nID, tab) {
            var d = "key=markRead&nID=" + nID;
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/MyNotificationPage.aspx") %>',
                success: function (html) {
                    LoadNotification(tab);
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        <% } %>

    </script>
    <!-- END JAVASCRIPTS -->



    <script type="text/javascript">

        $(function () {
            Highcharts.setOptions({
                global: {
                    useUTC: false
                }
            });
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_VIOLATION) == false)
                   { %>
            return;
            <% } %>
          

           <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_VIOLATION) == false)
                   { %>
                        LoadGraph("tab1");
             <% } %>
          
        });

        function LoadGraph(tab) {
            var dt = $("#txtDashboardDate").val();
            if (dt == "" || dt == "Select date...") {

                dt = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>';
            }

                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_VIOLATION) == false)
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
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>',
                    success: function (html) {
                        var j = $.parseJSON(html);
                        if ($('#chart_div1') && $('#chart_div1').length > 0) {
                        
                            Tab1(j.LatePercentage, j.EarlyPercentage, j.AbsentPercentage, j.LeavePercentage, j.PresentPercentage, j.MissedInPercentage, j.MissedOutPercentage);
                            
                        }  
                        setTimeout(function () { $("#divViolationTrends").unmask() }, 3000); 
                    },
                    error: function (html) {
                        Tab3(0, 0, 0, 0, 100);
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                        $("#divViolationTrends").unmask();
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
                            name: '<%=Resources.Resource.leave %>',
                            y: leave,
                            color: '#ffb848'
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
                        }
                        ,
                        {
                            name: '<%=Resources.Resource.missedin %>',
                            y: missedIn,
                            color: '#009688'
                        }
                        ,
                        {
                            name: '<%=Resources.Resource.missedOut %>',
                            y: missedOut,
                            color: '#f45042',

                        
                        }
        ]
    }]
});
};
        var activityClosure = {

            activityLastTransactionTime: '<%= DateTime.UtcNow.AddHours(TAMSR2Framework.DAL.AppSetting.defaultTimeZone).ToString("yyyy-MM-dd 00:00:00") %>',
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

function RequestData() {
    var chart = $('#container-live-attendance').highcharts();
    var dt = $("#txtDashboardDate").val();
    if (dt == "" || dt == "Select date...") {
        dt = '<%= DateTime.UtcNow.AddHours(TAMSR2Framework.DAL.AppSetting.defaultTimeZone).ToString("yyyy-MM-dd") %>';
    };
    var d = "key=getAttendanceActivity";
    d += "&dt=" + dt + "&activityLastTransactionTime=" + activityClosure.activityLastTransactionTime;
    $.ajax({
        type: 'POST',
        data: d,
        url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>',
        success: function (html) {
            var result = $.parseJSON(html);
            var x = (new Date()).getTime(); // current time
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


            setTimeout(RequestData, 5000);
        },
        error: function (html) {
            Tab3(0, 0, 0, 0, 100);
            $("#divErrorMsg").css("display", "block");
            $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
        },
        cache: false
    });


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



    function GetReaderTransactionsCount() {


        <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_MAP) == false)
            { %> 
             return;
        <%  } %>


        var dt = $("#txtDashboardDate").val();
        if (dt == "" || dt == "Select date...") {
            dt = '<%= DateTime.UtcNow.AddHours(TAMSR2Framework.DAL.AppSetting.defaultTimeZone).ToString("yyyy-MM-dd") %>';
                }
        var v = "key=GetReaderTransactionsCount&dt=" + dt;
        
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>',
                    success: function (html) {
                        if (html != "") {
                            initMap(html);
                        }
                    },
                    error: function (html) {
                        $("#divErrorMsgValidate").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
                });
         
        } 

    var map, infoWindow;
    function initMap(locations) {

        var j = $.parseJSON(locations); 
        var infowindow = new google.maps.InfoWindow({});
        var center = { lat:25.205056, lng:55.270583};
        var marker, count;
        //var locations = [
        //                ['546837809  (Transactions =8)', 24.484104, 54.373858],
        //                ['B6 Admin [10.64.85.100]  (Transactions =53)', 24.584204, 54.473958],
        //                ['DM2 Reception [10.137.19.101]  (Transactions =5)', 24.684304, 54.574058],
        //                ['B3 Sales [10.3.19.100]  (Transactions =60)', 24.784404, 54.674158],
        //                ['IT NAMI B3 GF [10.76.80.206]  (Transactions =1)', 24.884504, 54.774258]
        //                    ];

        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 7,
            center: center
        });
        //var marker = new google.maps.Marker({
        //    position: { lat: locations[count][1], locations[count][2] },
        //    title: Name
        //});
        for (count = 0; count < j.length; count++) { 
            var pos = { lat: parseFloat(j[count].Latitude), lng: parseFloat(j[count].Longitude) };
             
            marker = new google.maps.Marker({
                position: pos,
                icon: '../Images/reader-min.png',
                title: j[count].NameEn
            }); 
            marker.setMap(map);  
        }
    }

    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
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
