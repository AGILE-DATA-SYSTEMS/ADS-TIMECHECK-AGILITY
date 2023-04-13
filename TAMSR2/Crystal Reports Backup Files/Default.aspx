<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TAMSR2.Common.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title><%=Resources.Resource.home %> - <%=Resources.Resource.applicationName %> </title>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
            <div id="portlet-config" class="modal hide">
                <div class="modal-header">
                    <button data-dismiss="modal" class="close" type="button"></button>
                    <h3>Widget Settings</h3>
                </div>
                <div class="modal-body">
                    Widget settings form goes here
                </div>
            </div>
            <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
            <!-- BEGIN PAGE CONTAINER-->
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <!-- BEGIN STYLE CUSTOMIZER -->
                        <div class="color-panel hidden-phone">
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
                        <h3 class="page-title">Dashboard					<small>statistics and more</small>
                        </h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="index.html">Home</a>

                                <i class="icon-angle-right"></i>
                            </li>
                            <li><a href="#">Dashboard</a></li>

                            <li class="pull-<%= pullDirectionStr %> no-text-shadow">
                                <div id="dashboard-report-range" class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive" data-tablet="" data-desktop="tooltips" data-placement="top" data-original-title="Change dashboard date range">
                                    <i class="icon-calendar"></i>
                                    <span></span>
                                    <i class="icon-angle-down"></i>
                                </div>
                            </li>

                        </ul>
                        <!-- END PAGE TITLE & BREADCRUMB-->
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <div id="dashboard">
                    <!-- BEGIN DASHBOARD STATS -->
                    <div class="row-fluid">
                        <div class="span3 responsive" data-tablet="span6" data-desktop="span3">
                            <div class="dashboard-stat blue">
                                <div class="visual">
                                    <i class="icon-comments"></i>
                                </div>
                                <div class="details">
                                    <div class="number">
                                        1349
                                    </div>
                                    <div class="desc">
                                        New Feedbacks
                                    </div>
                                </div>
                                <a class="more" href="#">View more <i class="m-icon-swapright m-icon-white"></i>
                                </a>
                            </div>
                        </div>
                        <div class="span3 responsive" data-tablet="span6" data-desktop="span3">
                            <div class="dashboard-stat green">
                                <div class="visual">
                                    <i class="icon-shopping-cart"></i>
                                </div>
                                <div class="details">
                                    <div class="number">549</div>
                                    <div class="desc">New Orders</div>
                                </div>
                                <a class="more" href="#">View more <i class="m-icon-swapright m-icon-white"></i>
                                </a>
                            </div>
                        </div>
                        <div class="span3 responsive" data-tablet="span6  fix-offset" data-desktop="span3">
                            <div class="dashboard-stat purple">
                                <div class="visual">
                                    <i class="icon-globe"></i>
                                </div>
                                <div class="details">
                                    <div class="number">+89%</div>
                                    <div class="desc">Brand Popularity</div>
                                </div>
                                <a class="more" href="#">View more <i class="m-icon-swapright m-icon-white"></i>
                                </a>
                            </div>
                        </div>
                        <div class="span3 responsive" data-tablet="span6" data-desktop="span3">
                            <div class="dashboard-stat yellow">
                                <div class="visual">
                                    <i class="icon-bar-chart"></i>
                                </div>
                                <div class="details">
                                    <div class="number">12,5M$</div>
                                    <div class="desc">Total Profit</div>
                                </div>
                                <a class="more" href="#">View more <i class="m-icon-swapright m-icon-white"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- END DASHBOARD STATS -->
                    <div class="clearfix"></div>
                    <div class="row-fluid">
                        <div class="span6">
                            <div class="portlet box purple">
                                <div class="portlet-title">
                                    <div class="caption"><i class="icon-calendar"></i>General Stats</div>
                                    <div class="actions">
                                        <a href="javascript:;" class="btn yellow easy-pie-chart-reload"><i class="icon-repeat"></i>Reload</a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="row-fluid">
                                        <div class="span4">
                                            <div class="easy-pie-chart">
                                                <div class="number transactions" data-percent="55"><span>+55</span>%</div>
                                                <a class="title" href="#">Transactions <i class="m-icon-swapright"></i></a>
                                            </div>
                                        </div>
                                        <div class="margin-bottom-10 visible-phone"></div>
                                        <div class="span4">
                                            <div class="easy-pie-chart">
                                                <div class="number visits" data-percent="85"><span>+85</span>%</div>
                                                <a class="title" href="#">New Visits <i class="m-icon-swapright"></i></a>
                                            </div>
                                        </div>
                                        <div class="margin-bottom-10 visible-phone"></div>
                                        <div class="span4">
                                            <div class="easy-pie-chart">
                                                <div class="number bounce" data-percent="46"><span>-46</span>%</div>
                                                <a class="title" href="#">Bounce <i class="m-icon-swapright"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="span6">
                            <div class="portlet box blue">
                                <div class="portlet-title">
                                    <div class="caption"><i class="icon-calendar"></i>Server Stats</div>
                                    <div class="tools">
                                        <a href="javascript:;" class="collapse"></a>
                                        <a href="#portlet-config" data-toggle="modal" class="config"></a>
                                        <a href="javascript:;" class="reload"></a>
                                        <a href="javascript:;" class="remove"></a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="row-fluid">
                                        <div class="span4">
                                            <div class="sparkline-chart">
                                                <div class="number" id="sparkline_bar"></div>
                                                <a class="title" href="#">Network <i class="m-icon-swapright"></i></a>
                                            </div>
                                        </div>
                                        <div class="margin-bottom-10 visible-phone"></div>
                                        <div class="span4">
                                            <div class="sparkline-chart">
                                                <div class="number" id="sparkline_bar2"></div>
                                                <a class="title" href="#">CPU Load <i class="m-icon-swapright"></i></a>
                                            </div>
                                        </div>
                                        <div class="margin-bottom-10 visible-phone"></div>
                                        <div class="span4">
                                            <div class="sparkline-chart">
                                                <div class="number" id="sparkline_line"></div>
                                                <a class="title" href="#">Load Rate <i class="m-icon-swapright"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END PAGE CONTAINER-->


   <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
   <!-- BEGIN CORE PLUGINS -->
   <script src="../Assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>   
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
   <script src="../Assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script> 
   <!-- END CORE PLUGINS -->
   <!-- BEGIN PAGE LEVEL PLUGINS -->
   <script src="../Assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js" type="text/javascript"></script>
   <script src="../Assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>    
   <script src="../Assets/<%= languageStr %>/plugins/jquery-easy-pie-chart/jquery.easy-pie-chart.js" type="text/javascript"></script>
   <script src="../Assets/<%= languageStr %>/plugins/jquery.sparkline.min.js" type="text/javascript"></script>  
   <!-- END PAGE LEVEL PLUGINS -->
   <!-- BEGIN PAGE LEVEL SCRIPTS -->
   <script src="../Assets/<%= languageStr %>/scripts/app.js" type="text/javascript"></script>
   <script src="../Assets/<%= languageStr %>/scripts/index.js" type="text/javascript"></script>        
   <!-- END PAGE LEVEL SCRIPTS -->  
   <script>
       jQuery(document).ready(function () {
           App.init(); // initlayout and core plugins
           Index.init();
           Index.initCharts(); // init index page's custom scripts
           Index.initChat();
           Index.initMiniCharts();
           Index.initDashboardDaterange();
           Index.initIntro();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#liAdmin .arrow").removeClass("open");
           $("#liHome").addClass("active");
       });
   </script>
   <!-- END JAVASCRIPTS -->
</asp:Content>
