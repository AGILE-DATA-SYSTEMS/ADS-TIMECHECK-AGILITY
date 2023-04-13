<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewSettingSummary.aspx.cs" Inherits="TAMSR2.Details.ViewSettingSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <title><%=Resources.Resource.settings %> - <%=Resources.Resource.applicationName %></title> <link href="assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" type="text/css"/>
   <link href="../assets/<%= languageStr %>/plugins/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <!-- BEGIN STYLE CUSTOMIZER -->
                        <div style="display: block;" class="color-panel hidden-phone">
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
                        <h3 class="page-title" style="margin: 0px;"><%=Resources.Resource.security %> 					<small style="display: none;">statistics and more</small>
                        </h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href='<%= Page.ResolveClientUrl("../Common/Home") %>'><%=Resources.Resource.home %> </a>

                                <i class="icon-angle-right"></i>
                            </li>
                            <li><a href="#"><%=Resources.Resource.security %> </a></li>

                            <li style="display: none !important;" class="pull-<%= pullDirectionStr %> no-text-shadow">
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
                
               
            <div class="clearfix"></div>
                <div id="dashboard" style="min-height:50px;">
               <!-- BEGIN DASHBOARD STATS -->
               
               </div>
               <!-- END DASHBOARD STATS -->
               <div class="clearfix"></div>
               <div class="row-fluid">
                  <div class="span6" style="width:98%">
                     <div class="portlet">
                       
                        <div class="portlet-body">
                               <%
             if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_READERS) == true 
                )
            { %>         <div class="row-fluid">
                             
                               
                              <div class="span4">
                                 <div class="easy-pie-chart">
                                    <div class="number transactions"  data-percent="55"><span>55</span> </div>
                                    <a class="title" href='<%= Page.ResolveClientUrl("~/Details/ViewAppSettings.aspx") %>'><%= Resources.Resource.appSetting %> <i class="m-icon-swapright"></i></a>
                                 </div>
                              </div>
                          
                          <div class="span4">
                                 <div class="easy-pie-chart">
                                    <div class="number visits"  data-percent="20"><span>20</span> </div>
                                    <a class="title" href='<%= Page.ResolveClientUrl("~/Details/ViewConnectionTypes.aspx") %>'><%= Resources.Resource.connectionType %>  <i class="m-icon-swapright"></i></a>
                                 </div>
                              </div>
                               <div class="span4">
                                 <div class="easy-pie-chart">
                                    <div class="number transactions"  data-percent="25"><span>25</span> </div>
                                    <a class="title" href='<%= Page.ResolveClientUrl("~/Details/ViewDeviceGroups.aspx") %>'><%= Resources.Resource.deviceGroup %> <i class="m-icon-swapright"></i></a>
                                 </div>
                              </div>
                          
                          </div>
                             
                         <div class="row-fluid">
                              <div class="span4">
                                 <div class="easy-pie-chart">
                                    <div class="number visits"  data-percent="20"><span>20</span> </div>
                                    <a class="title" href='<%= Page.ResolveClientUrl("~/Details/ViewDeviceConnections.aspx") %>'><%= Resources.Resource.deviceConnection %> <i class="m-icon-swapright"></i></a>
                                 </div>
                              </div>
                            
                               <div class="span4">
                                 <div class="easy-pie-chart">
                                    <div class="number transactions"  data-percent="15"><span>15</span> </div>
                                    <a class="title" href='<%= Page.ResolveClientUrl("~/Details/ViewPanels.aspx") %>'><%= Resources.Resource.panel %>  <i class="m-icon-swapright"></i></a>
                                 </div>
                              </div>
                          
                          
                              <div class="span4">
                                 <div class="easy-pie-chart">
                                    <div class="number visits"  data-percent="80"><span>80</span> </div>
                                    <a class="title" href='<%= Page.ResolveClientUrl("~/Details/ViewReaderTypes.aspx") %>'><%= Resources.Resource.readerType %> <i class="m-icon-swapright"></i></a>
                                 </div>
                             
                            </div>
                                  </div>
                         <% } %>
                     </div>
                     </div>
                  </div>
                 
               </div>
               <div class="clearfix"></div>
             
               <div class="clearfix"></div>
               
            
       </div>
           
            <!-- END PAGE CONTAINER-->

   <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
   <!-- BEGIN CORE PLUGINS -->
   <script src="../assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>   
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
   <script src="../assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script> 
   <!-- END CORE PLUGINS -->
   <!-- BEGIN PAGE LEVEL PLUGINS -->
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-validation/dist/additional-methods.min.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>
   
    <!--Script references. -->
    <!--Reference the SignalR library. -->
    <script src="../Scripts/jquery.signalR-1.1.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="../signalr/hubs"></script>

    <!-- END PAGE LEVEL PLUGINS -->
    
   <!-- BEGIN PAGE LEVEL SCRIPTS -->
   <script src="../Assets/<%= languageStr %>/plugins/jquery-easy-pie-chart/jquery.easy-pie-chart.js" type="text/javascript"></script>
   <script src="../Assets/<%= languageStr %>/plugins/jquery.sparkline.min.js" type="text/javascript"></script>  
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
   <script src="../Assets/<%= languageStr %>/scripts/app.js" type="text/javascript"></script>
   <!-- END PAGE LEVEL SCRIPTS -->  
   <script>
       jQuery(document).ready(function () {
           App.init(); // initlayout and core plugins

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }


           $(function () {
               $('.easy-pie-chart .number.transactions').easyPieChart({
                   animate: 1000,
                   size: 200,
                   lineWidth: 3,
                   barColor: App.getLayoutColorCode('red')
               });

               $('.easy-pie-chart .number.visits').easyPieChart({
                   animate: 1000,
                   size: 200,
                   lineWidth: 3,
                   barColor: App.getLayoutColorCode('green')
               });

               $('.easy-pie-chart .number.bounce').easyPieChart({
                   animate: 1000,
                   size: 200,
                   lineWidth: 3,
                   barColor: App.getLayoutColorCode('blue')
               });

           });


           $("#liSettings").addClass("active");
           $("#liSettings .arrow").addClass("open");
           $("#liReaders").addClass("active");


       });
   </script>
</asp:Content>
