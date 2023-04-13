<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewCompanies.aspx.cs" Inherits="TAMSR2.Admin.ViewCompanies" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
   <title><%=Resources.Resource.companies %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->
    
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    
         <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
         <div id="portlet-config" class="modal hide">
            <div class="modal-body">
               <div class="row-fluid">
               <div class="span12">
                  <!-- BEGIN VALIDATION STATES-->
                  <div class="portlet box purple">
                     <div class="portlet-title">
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.applicationName %> <%=Resources.Resource.userDetails %></h4>
                     </div>
                     <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                         
                        <!-- END FORM-->
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
                  <div class="color-panel hidden-phone">
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
									<%=Resources.Resource.companies %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href="index.html"><%=Resources.Resource.home %></a> 
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.companies %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.companies %></a></li>
						
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12">
                  <!-- BEGIN EXAMPLE TABLE PORTLET-->
                  <div class="portlet box light-grey">
                     <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.companies %></div>
                        <div class="tools">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                     </div>
                     <div class="portlet-body">
                        <div id="divSuccessMsg" style="display: none;" class="alert alert-success"><span id="spnSuccessMsg">&nbsp;</span></div>
                        <div id="divErrorMsg" style="display: none;" class="alert alert-error"><span id="spnErrorMsg">&nbsp;</span></div>
                        <div class="clearfix">
                            <div class="btn-group">
                            </div>
                           <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                              <span id="spnAddButton" runat="server" >
                                <a id="btnAdd" href="CompanyWizard.aspx"  class="btn green"><%=Resources.Resource.add %><i class="icon-plus"></i></a> 
                                <button id="btnBroadCast" type="button" style="display: none;" class="btn purple"><%=Resources.Resource.broadcast %></button>
                              </span>
                           </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                           <thead>
                              <tr>
                                 <th style="width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                 <th><%=Resources.Resource.name %></th>
                                 <th class="hidden-480"><%=Resources.Resource.dbName %></th>
                                 <th class="hidden-480"><%=Resources.Resource.startDate %></th>
                                 <th class="hidden-480"><%=Resources.Resource.description %></th>
                                 <th class="hidden-480"><%=Resources.Resource.updatedBy %></th>
                                 <th class="hidden-480"><%=Resources.Resource.updatedOn %></th>
                                 <th class="hidden-480"><%=Resources.Resource.active %></th>
                                 <th style="width: 80px !important;">&nbsp;</th>
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
    <script src="../Scripts/jquery.signalR-1.1.0-beta1.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="../signalr/hubs"></script>

    <!-- END PAGE LEVEL PLUGINS -->
    
   <!-- BEGIN PAGE LEVEL SCRIPTS -->
  <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
   <script src="../assets/<%= languageStr %>/scripts/app.js"></script>
   <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>      
   <!-- START OF PAGE LEVEL SCRIPT-->
   <script type="text/javascript">

       $(document).ready(function () {
           App.init(); // initlayout and core plugins

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#liAdmin .arrow").removeClass("open");
           $("#liCompany").addClass("active");

           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": false }
               ],
               "oLanguage": {
                   "sLengthMenu": "_MENU_ records per page"
               },
               "aaSorting": [[1, "desc"]],
               "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/CompanyPage.aspx?key=getAll") %>'
           });


           // Declare a proxy to reference the hub. 
           var users = $.connection.chatHub;
           // Create a function that the hub can call to broadcast messages.
           users.client.broadcastMessage = function (name, message) {
               if (name == "TAMSR2Company") {
                   ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2Company', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
       });

       function ReloadGrid() {
           $('#sample_1').dataTable().fnDraw();
       }

       function Delete(id) {
           if (confirm("Are you sure you want to delete this record?")) {
               var v = "key=deleteByID&id=" + id;

               $("#divSuccessMsg").css("display", "none");
               $("#divErrorMsg").css("display", "none");
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/CompanyPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg").css("display", "block");
                           $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordDelete %>");
                           $('#btnBroadCast').click();
                       }
                       else {
                           $("#divErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotDelete %>");
                       }
                   },
                   error: function (html) {

                   }
               });
           }
           else {
           }
       }
   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
