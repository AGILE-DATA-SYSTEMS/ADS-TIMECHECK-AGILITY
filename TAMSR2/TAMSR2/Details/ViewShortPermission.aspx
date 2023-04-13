<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewShortPermission.aspx.cs" Inherits="TAMSR2.Details.ViewShortPermission" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.shortPermission %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/css/bootstrap-tree.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link href="<%= path %>Styles/jquery.loadmask.css" rel="stylesheet" />
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
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.organizationTypes %></h4>
                     </div>
                     <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <form action="#" id="form_sample_1" class="form-horizontal">
                           <div id="divErrorMsg" class="alert alert-error hide">
                              <button class="close" data-dismiss="alert"></button>
                              <span id="spnErrorMsg"> <%=Resources.Resource.formErrors %></span> 
                           </div>
                           <div id="divSuccessMsg" class="alert alert-success hide">
                              <button class="close" data-dismiss="alert"></button>
                              <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span> 
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                              <div class="controls chzn-controls">
                                 <select id="ddOrgType" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="orgType" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>" tabindex="1">
                                    <option value=""></option>
                                 </select>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.employee %></label>
                              <div class="controls chzn-controls">
                                 <select id="ddOrgParent" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="orgParent" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>" tabindex="1">
                                    <option value=""></option>
                                 </select>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="text" id="txtCode" name="code" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.descriptionEn %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="text" id="txtDescriptionEn" name="nameEn" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.descriptionAr %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="text" id="txtDescriptionAr" name="nameAr" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="form-actions">
                               <span id="spnID" style="display: none;">0</span>
                              <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                              <button id="btnSave" type="button" onclick="Save()" class="btn purple"><%=Resources.Resource.save %></button>
                              <button type="button" onclick="CloseForm()" class="btn"><%=Resources.Resource.cancel %></button>
                              <button type="reset" id="btnCloseForm" style="display: none;" data-dismiss="modal" class="btn"><%=Resources.Resource.close %></button>
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
									<%=Resources.Resource.shortPermission %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a>
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.employee %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.shortPermission %></a></li>					
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12">
                <!-- BEGIN FORM-->
                <form action="#" id="form_1" class="form-horizontal">

                    
                                <div class="row-fluid">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.status %> </label>
                                            <div class="controls">
                                                <select id="ddStatus" tabindex="2" data-placeholder='<%=Resources.Resource.status %>' class="span6 chosen" name="status" style="width: 220px;">
                                                    <option value=""><%=Resources.Resource.all %></option>
                                                    <option value="Pending Manager"><%=Resources.Resource.pendingManager %></option>
                                                    <option value="Pending HR"><%=Resources.Resource.pendingHR %></option>
                                                    <option value="Approved"><%=Resources.Resource.approved %></option>
                                                    <option value="Rejected"><%=Resources.Resource.rejected %></option>
                                                    <option value="Cancelled"><%=Resources.Resource.cancelled %></option>
                                                </select>
                                                <br>
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row-->


                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.fromDate %> </label>
                                <div class="controls">
                                    <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.toDate %> </label>
                                <div class="controls">
                                    <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                </form>
                <!-- END FORM-->
                  <!-- BEGIN EXAMPLE TABLE PORTLET-->
                  <div class="portlet box light-grey">
                     <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.shortPermission %></div>
                        <div class="tools">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                     </div>
                     <div class="portlet-body">
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
                              <span id="spnAddButton" runat="server" >
                                  <a id="btnAdd" href='<%= Page.ResolveClientUrl("~/Leaves/Save-Short-Permission/" + TAMSR2.CustomClasses.Encryption.Encrypt("0")) %>' data-toggle="modal" class="btn green"><i class="icon-plus"> &nbsp; <%=Resources.Resource.add %></i></a> 
                              </span>
                              <span id="spnDeleteButton" runat="server" >
                                  <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash"> &nbsp; <%=Resources.Resource.delete %></i></a> 
                              </span>
                           </div>

                        </div>
                         
                        <input type="file" id="medicalPassAttachment" accept="application/pdf" name="medicalPassAttachment" style="display: none;" />
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                           <thead>
                              <tr style="background-color: #e8e3e3;">
                                 <th style="text-align: center;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                 <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.employee %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.type %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.fromDate %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.toDate %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.fromTime %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.toTime %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.duration %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.status %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.actionBy %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.actionDate %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.edit %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.print %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.upload %></th>
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
   
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/clockface/js/clockface.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/daterangepicker.js"></script> 

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
           FormValidation.init();
           FormComponents.init();
           //TableManaged.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liLeaveGroup").addClass("active");
           $("#liLeaveGroup .arrow").addClass("open");
           $("#liShortPermission").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }
           $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });

           $("#txtFromDate").val('<%= new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd-MM-yyyy") %>');
            $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
           $("#txtFromDate").datepicker("update");
           $("#txtToDate").datepicker("update");
       
           $('#ddStatus option[value="Pending Manager"]').attr('selected', 'selected');
           $("#ddStatus").trigger("liszt:updated");

           LoadGrid(false);

           $("#txtFromDate").change(function () {
               DateRangeChange("fromDate");
               LoadGrid(true);
           });

           $("#txtToDate").change(function () {
               DateRangeChange("toDate");
               LoadGrid(true);
           });

           $("#ddStatus").change(function () {
               LoadGrid(true);
           });

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
               if (name == "TAMSR2_Single_Permission") {
                   LoadGrid(true);
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_Single_Permission', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
            

       });

       function DateRangeChange(param) {

           var fromDate = new Date();
           var toDate = new Date();
           var str1 = $('#txtFromDate').val();
           var str2 = $('#txtToDate').val();

           if (str1.indexOf('-') > 0) {
               fromDate = new Date(str1.substring(6, 10), str1.substring(3, 5), str1.substring(0, 2));
           }
           else {
               fromDate = new Date(str1.substring(4, 8), str1.substring(2, 4), str1.substring(0, 2));
           }
           if (str2.indexOf('-') > 0) {
               toDate = new Date(str2.substring(6, 10), str2.substring(3, 5), str2.substring(0, 2));
           }
           else {
               toDate = new Date(str2.substring(4, 8), str2.substring(2, 4), str2.substring(0, 2));
           }

           if (param == "fromDate") {
               if ($("#txtFromDate").val() == "") {
                   $("#txtFromDate").val('<%= new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd-MM-yyyy") %>');
                    $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                }

                if (fromDate > toDate) {
                    $("#txtToDate").val($("#txtFromDate").val());
                }
            }
            else if (param == "toDate") {
                if ($("#txtToDate").val() == "") {
                    $("#txtFromDate").val('<%= new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd-MM-yyyy") %>');
                   $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
               }

               if (fromDate > toDate) {
                   $("#txtFromDate").val($("#txtToDate").val());
               }
           }
       $("#txtFromDate").datepicker("update");
       $("#txtToDate").datepicker("update");
   }


       function LoadGrid(filter) {
           var fromDate = "";
           var toDate = "";
           var str1 = $('#txtFromDate').val();
           var str2 = $('#txtToDate').val();
           var status = $("#ddStatus").val();

           if (str1.indexOf('-') > 0) {
               fromDate = str1.substring(6, 10) + "-" + str1.substring(3, 5) + "-" + str1.substring(0, 2);
           }
           else {
               fromDate = str1.substring(4, 8) + "-" + str1.substring(2, 4) + "-" + str1.substring(0, 2);
           }
           if (str2.indexOf('-') > 0) {
               toDate = str2.substring(6, 10) + "-" + str2.substring(3, 5) + "-" + str2.substring(0, 2);
           }
           else {
               toDate = str2.substring(4, 8) + "-" + str2.substring(2, 4) + "-" + str2.substring(0, 2);
           }

           var url = '<%= Page.ResolveClientUrl("../RequestPages/SinglePermissionPage.aspx?key=getAll") %>' + '&fromDate=' + fromDate + '&toDate=' + toDate + '&status=' + status;
           
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
                 { "bSortable": false, sWidth: "3%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "14%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "6%" },
                 { "bSortable": true, sWidth: "6%" },
                 { "bSortable": true, sWidth: "6%" },
                 { "bSortable": true, sWidth: "6%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "7%" },
                 { "bSortable": true, sWidth: "13%" },
                 { "bSortable": true, sWidth: "7%" },
                 { "bSortable": false, sWidth: "3%" },
                 //{ "bSortable": false, sWidth: "3%" },
                 { "bSortable": false, sWidth: "3%" },
                 { "bSortable": false, sWidth: "3%" }
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
               "aaSorting": [[11, "desc"]],
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


      function Cancel(ID) {
          var v = "key=cancelByID&Id="+ ID;

          $("#divSuccessMsg2").css("display", "none");
          $("#divErrorMsg2").css("display", "none");
           
          if (confirm("<%=Resources.Resource.cancelMsg %>")) {
              $.ajax({
                  type: 'POST',
                  data: v,
                  url: '<%= Page.ResolveClientUrl("~/RequestPages/SinglePermissionPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg2").css("display", "block");
                           $("#spnSuccessMsg2").html("<%=Resources.Resource.msgRecordDelete %>");
                           $('#btnBroadCast').click();
                       }
                       else {
                           $("#divErrorMsg2").css("display", "block");
                           $("#spnErrorMsg2").html("<%=Resources.Resource.msgRecordNotDelete %>");
                       }
                   },
                   error: function (html) {

                   }
               });
           }
           else {
           }
      }

       function Download(PermID) {
            
           var d = "key=ShowStandardReport&action=ViewReport&ReportName=MedicalPassReport&ReportCode=MedicalPassReport";
           d += "&PermissionId=" + PermID;
           window.open('../Reports/ViewStandardRptPage.aspx?' + d, '_blank', 'height=' + screen.height + ',width=' + screen.width + 'toolbar=0,scrollbars=1,location=0,menubar=0,resizable=yes');
       }

       function Upload(PermId) {
           $('#medicalPassAttachment').click();
           var Attachment = document.getElementById("medicalPassAttachment");
           Attachment.onchange = function (e) {
               $('#divErrorMsg2').css("display", "none");
               $('#divSuccessMsg2').css("display", "none");
               $('#divInfoMsg').addClass('hide');
               e.stopPropagation(); // Stop stuff happening
               e.preventDefault(); // Totally stop stuff happening
               //msgErrorFileSize
               var ext = this.value.match(/\.(.+)$/)[1];
               switch (ext) {
                   case 'pdf':
                       break;
                   default:
                       $('#spnErrorMsg2').html("<%=Resources.Resource.msgWrongFileError %>");
                       $('#divMsgError2').removeClass('hide');
                       this.value = '';
               }
               FileUpload(PermId);
           };
        
       }

       var data = new FormData();
       function FileUpload(PermID) {

           if ($('#medicalPassAttachment')[0].files.length == 0) {
               $("#divErrorMsg2").css("display", "block");
               $("#spnErrorMsg2").html("<%=Resources.Resource.lblRequired %>" + "." + "<%=Resources.Resource.attachment %>");
                   return;
               } 
               var filesObject = $('#medicalPassAttachment');
               var fileSize = filesObject[0].size;

               var files = filesObject[0].files;
               var sizeInMB = ($('#medicalPassAttachment')[0].files[0].size / (1024 * 1024));

               if (sizeInMB > 2.0) {
                   $("#divErrorMsg2").css("display", "block");
                   $("#spnErrorMsg2").html("<%= String.Format(Resources.Resource.msgErrorFileSize,"2 MB.") %>");
                    $('#medicalPassAttachment').val('');
                    return;
                }
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);

                }


           var url = '<%= Page.ResolveClientUrl("~/RequestPages/SinglePermissionPage.aspx") %>';
           var v = "key=UploadAttachment&PermissionID=" + PermID;
           url = url + "?" + v;
           $.ajax({
               type: 'POST',
               data: data,
               url: url,
               contentType: false,
               processData: false,
               success: function (html) {

                   if (html == 'Success' || html == 'SUCCESS') {
                       //success
                       $("#divSuccessMsg2").css("display", "block");
                       $("#spnSuccessMsg2").html("<%=Resources.Resource.msgRecordSaved %>"); 
                       alert("Success: File Successfully Uploaded ");
                       LoadGrid();
                       $("#divSuccessMsg2").css("display", "none");
                    }
                    else {
                        $("#divErrorMsg2").css("display", "block");
                        $("#spnErrorMsg2").html(html);
                    } 

                },
                error: function (html) {

                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("Error! " + html);
                }

            });

            
       }
      function Delete() {
          var v = "key=deleteByID&";

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
           if (confirm("<%=Resources.Resource.deleteMessage %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("~/RequestPages/SinglePermissionPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg2").css("display", "block");
                           $("#spnSuccessMsg2").html("<%=Resources.Resource.msgRecordDelete %>");
                           $('#btnBroadCast').click();
                       }
                       else {
                           $("#divErrorMsg2").css("display", "block");
                           $("#spnErrorMsg2").html("<%=Resources.Resource.msgRecordNotDelete %>");
                       }
                   },
                   error: function (html) {

                   }
               });
           }
           else {
           }
       }

       var FormComponents = function () {

           var handlejQueryUIDatePickers = function () {
               $(".ui-date-picker").datepicker();
           }

           var handleDateTimePickers = function () {

               if (jQuery().datepicker) {
                   $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
               }
               
               if (jQuery().timepicker) {
                   $('.timepicker-default').timepicker();
                   $('.timepicker-24').timepicker({
                       minuteStep: 1,
                       showSeconds: true,
                       showMeridian: false
                   });
               }

               if (!jQuery().daterangepicker) {
                   return;
               }

               $('.date-range').daterangepicker(
                   {
                       opens: (App.isRTL() ? 'left' : 'right'),
                       format: 'dd-mm-yyyy',
                       separator: ' to ',
                       startDate: Date.today().add({
                           days: -29
                       }),
                       endDate: Date.today(),
                       minDate: '2012-01-01',
                       maxDate: '2999-01-01',
                   }
               );

               $('#form-date-range').daterangepicker({
                   ranges: {
                       'Today': ['today', 'today'],
                       'Yesterday': ['yesterday', 'yesterday'],
                       'Last 7 Days': [Date.today().add({
                           days: -6
                       }), 'today'],
                       'Last 29 Days': [Date.today().add({
                           days: -29
                       }), 'today'],
                       'This Month': [Date.today().moveToFirstDayOfMonth(), Date.today().moveToLastDayOfMonth()],
                       'Last Month': [Date.today().moveToFirstDayOfMonth().add({
                           months: -1
                       }), Date.today().moveToFirstDayOfMonth().add({
                           days: -1
                       })]
                   },
                   opens: (App.isRTL() ? 'left' : 'right'),
                   format: 'dd-mm-yyyy',
                   separator: ' to ',
                   startDate: Date.today().add({
                       days: -29
                   }),
                   endDate: Date.today(),
                   minDate: '2012-01-01',
                   maxDate: '2999-01-01',
                   locale: {
                       applyLabel: 'Submit',
                       fromLabel: 'From',
                       toLabel: 'To',
                       customRangeLabel: 'Custom Range',
                       daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
                       monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                       firstDay: 1
                   },
                   showWeekNumbers: true,
                   buttonClasses: ['btn-danger']
               },

               function (start, end) {
                   $('#form-date-range span').html(start.toString('MMMM d, yyyy') + ' - ' + end.toString('MMMM d, yyyy'));
               });

               $('#form-date-range span').html(Date.today().add({
                   days: -29
               }).toString('MMMM d, yyyy') + ' - ' + Date.today().toString('MMMM d, yyyy'));


               if (!jQuery().datepicker || !jQuery().timepicker) {
                   return;
               }
           }

           var handleInputMasks = function () {
               $.extend($.inputmask.defaults, {
                   'autounmask': true
               });

               $("#txtFromDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
               $("#txtToDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
           }

           return {
               //main function to initiate the module
               init: function () {
                   handlejQueryUIDatePickers();
                   handleDateTimePickers();
                   //  handleInputMasks();
               }

           };

       }();
       ////////END OF FORM COMPONENTS////////

   var FormValidation = function () {


       return {
           //main function to initiate the module
           init: function () {

               // for more info visit the official plugin documentation: 
               // http://docs.jquery.com/Plugins/Validation

               var form1 = $('#form_sample_1');
               var error1 = $('.alert-error', form1);
               var success1 = $('.alert-success', form1);

               form1.validate({
                   errorElement: 'span', //default input error message container
                   errorClass: 'help-inline', // default input error message class
                   focusInvalid: false, // do not focus the last invalid input
                   ignore: "",
                   rules: {
                       nameEn: {
                           minlength: 3,
                           required: true
                       },
                       nameAr: {
                           minlength: 3,
                           required: true
                       },
                       code: {
                           minlength: 2,
                           required: true
                       },
                       orgType: {
                           required: true
                       }
                   },
                   message: {
                       nameEn: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       },
                       nameAr: {
                           required: "<%=Resources.Resource.lblRequired %>"
                           },
                       code: {
                           required: "<%=Resources.Resource.lblRequired %>"
                           },
                       orgType: {
                           required: "<%=Resources.Resource.lblRequired %>"
                           }
                   },


                   errorPlacement: function (error, element) { // render error placement for each input type
                       if (element.attr("name") == "orgType") { // for uniform checkboxes, insert the after the given container
                           error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                       } else {
                           error.insertAfter(element); // for other inputs, just perform default behavoir
                       }
                   },
                   invalidHandler: function (event, validator) { //display error alert on form submit              
                       success1.hide();
                       error1.show();
                       App.scrollTo(error1, -200);
                   },

                   highlight: function (element) { // hightlight error inputs
                       $(element)
                           .closest('.help-inline').removeClass('ok'); // display OK icon
                       $(element)
                           .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                   },

                   unhighlight: function (element) { // revert the change dony by hightlight
                       $(element)
                           .closest('.control-group').removeClass('error'); // set error class to the control group
                   },

                   success: function (label) {
                       label
                           .addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                       .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                   },

                   submitHandler: function (form) {
                       success1.show();
                       error1.hide();
                   }
               });
           }
       };
   }();
       ////////////END OF VALIDATIONS/////////////

   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>

