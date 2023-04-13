<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewLeaveApproval.aspx.cs" Inherits="TAMSR2.Details.ViewLeaveApproval" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.leaveApproval %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/css/bootstrap-tree.css" />
    <!-- END PAGE LEVEL STYLES -->
        
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
									<%=Resources.Resource.leaveApproval %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a>
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.leaves %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.leaveApproval %></a></li>					
						
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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.leaveApproval %></div>
                        <div class="tools">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                     </div>
                     <div class="portlet-body">
                        <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                           <div id="divSuccessMsg2" class="alert alert-success hide">
                              <span id="spnSuccessMsg2"> <%=Resources.Resource.formErrors %></span> 
                           </div>
                           <div id="divErrorMsg2" class="alert alert-error hide">
                              <span id="spnErrorMsg2"><%=Resources.Resource.formErrorsRemoved %></span> 
                           </div>
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="spnGridMsg">&nbsp;</span>
                            </div>
                           <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                              <span id="spnApproveButton" runat="server" >
                                  <a id="btnApprove" onclick="return Approve()" class="btn green"> &nbsp; <%=Resources.Resource.approve %></i></a> 
                              </span>
                              <span id="spnRejectButton" runat="server" >
                                  <a id="btnReject" onclick="return Reject()" style='margin: 0px 10px;' class="btn red"> &nbsp; <%=Resources.Resource.reject %></i></a> 
                              </span>
                           </div>
                        </div>

                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                                <tr style="background-color: #e8e3e3;">
                                    <th style="text-align: center;">
                                        <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                    <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                    <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.leave %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.fromDate %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.toDate %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.remarks %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.status %></th>
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
   <script src="<%= path %>assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script> 
   <!-- END CORE PLUGINS -->
   <!-- BEGIN PAGE LEVEL PLUGINS -->
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-validation/dist/additional-methods.min.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>
   <script src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/js/bootstrap-tree.js"></script>
   
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
           //TableManaged.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liLeaveGroup").addClass("active");
           $("#liLeaveGroup .arrow").addClass("open");
           $("#liLeaveApproval").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

           LoadGrid(false);

           $('#sample_1 .group-checkable').change(function () {
               var set = $(this).attr("data-set");
               var checked = $(this).is(":checked");
               jQuery(set).each(function () {
                   if (checked) {
                       $(this).attr("checked", true);
                   } else {
                       $(this).attr("checked", false);
                   }
               });
               jQuery.uniform.update(set);
           });


           // Declare a proxy to reference the hub. 
           var users = $.connection.chatHub;
           // Create a function that the hub can call to broadcast messages.
           users.client.broadcastMessage = function (name, message) {
               if (name == "TAMSR2_Emp_Leaves") {
                   LoadGrid(false);
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_Emp_Leaves', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
       });

       function LoadGrid(filter) {

           var url = '<%= Page.ResolveClientUrl("../RequestPages/EmployeeLeavePage.aspx?key=getAllPending") %>';
           var filterValue = "";
           if (filter == true) {
               filterValue = $("#txt_sample_1_filter").val();
               $("#sample_1_filter label input").val(filterValue);
           }
           url += "&sSearchFilter=" + filterValue;

           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                  { "bSortable": false, sWidth: "5%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "20%" },
                  { "bSortable": true, sWidth: "15%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "20%" },
                  { "bSortable": false, sWidth: "10%"}
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
               "sAjaxSource": url 
           });

           $("#sample_1_filter input").css("display", "none");
           $("txt_sample_1_filter").css("display", "");
           $("#sample_1_filter label").append("<input id='txt_sample_1_filter' value='' style='display: inline-block; margin-bottom: 0; border-color: rgba(82, 168, 236, 0.8); box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(82, 168, 236, 0.6); outline: 0 none;' />");
           if (filter == true) {
               $("#txt_sample_1_filter").val(filterValue);
               $("#sample_1_filter label input").val(filterValue);
           }
           $("#txt_sample_1_filter").keyup(function (e) {
               //alert(e.keyCode);
               if (e.keyCode == 13) {
                   //alert($("#txt_sample_1_filter").val());
                   //alert($("#sample_1_filter label input").val());
                   filterValue = $("#txt_sample_1_filter").val();
                   $("#sample_1_filter label input").val(filterValue);
                   $("#txt_sample_1_filter").val(filterValue);
                   LoadGrid(true);//$('#sample_1').dataTable().fnDraw();
                   //alert($("#sample_1_filter label input").val());
               }
           });

       }

       function ReloadGrid() {
           $('#sample_1').dataTable().fnDraw();
       }


       function Approve() {
           var v = "key=approveLeaves&";

           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           var k = 0;
           $("#sample_1 tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   k++;
                   v += "chk" + k + "=" + this.value + "&";
                   //this.checked = chk.checked;
               }
           });
           v += "count=" + k;

           if (k == 0) {
               $("#divErrorMsg2").css("display", "block");
               $("#spnErrorMsg2").html("<%=Resources.Resource.selectOne %>");
               return;
           }
           if (confirm("<%=Resources.Resource.approveConfirm %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeLeavePage.aspx") %>',
                  success: function (html) {
                      if (html == "1") {
                          $("#divSuccessMsg2").css("display", "block");
                          $("#spnSuccessMsg2").html("<%=Resources.Resource.approvedSuccessfully %>");
                           $('#btnBroadCast').click();
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

       function Reject() {
           var v = "key=rejectLeaves&";

           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           var k = 0;
           $("#sample_1 tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   k++;
                   v += "chk" + k + "=" + this.value + "&";
                   //this.checked = chk.checked;
               }
           });
           v += "count=" + k;

           if (k == 0) {
               $("#divErrorMsg2").css("display", "block");
               $("#spnErrorMsg2").html("<%=Resources.Resource.selectOne %>");
               return;
           }
           if (confirm("<%=Resources.Resource.rejectConfirm %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeLeavePage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg2").css("display", "block");
                           $("#spnSuccessMsg2").html("<%=Resources.Resource.rejectedSuccessfully %>");
                          $('#btnBroadCast').click();
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

   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>

