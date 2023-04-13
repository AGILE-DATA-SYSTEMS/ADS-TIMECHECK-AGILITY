<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewSeniorsList.aspx.cs" Inherits="TAMSR2.Details.ViewSeniorsList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.seniorEmployeeList %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <!-- END PAGE LEVEL STYLES -->
    
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    
         <!-- BEGIN ADD/REMOVE USERS MODAL FORM-->
         <div id="divAssignUsers" class="modal hide">
            <div class="modal-body">
               <div class="row-fluid">
               <div class="span12">
                  <!-- BEGIN POPUP ADD/REMOVE USERS FROM ROLE-->
                  <div class="portlet box purple">
                     <div class="portlet-title">
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.employees %> <span id="spnUserRole">&nbsp;</span></h4>
                         <span id="spnUserRoleID" style="display: none;">&nbsp;</span>
                     </div>
                      <div class="portlet-body form">
                          <!-- BEGIN FORM-->
                          <form action="#" id="form2" class="form-horizontal">
                              <div id="divErrorMsgUser" class="alert alert-error hide">
                                  <button class="close" data-dismiss="alert"></button>
                                  <span id="spnErrorMsgUser"><%=Resources.Resource.formErrors %></span>
                              </div>
                              <div id="divSuccessMsgUser" class="alert alert-success hide">
                                  <button class="close" data-dismiss="alert"></button>
                                  <span id="spnSuccessMsgUser"><%=Resources.Resource.formErrorsRemoved %></span>
                              </div>
                              <div class="control-group">
                                  <div class="controls" style="margin-left: 10px; width: 100%;">
                                      <table style="width: 100%;">
                                          <tr>
                                              <td style="padding: 0px 5px;">
                                                  <div class="control-group" style="font-weight: bold; text-align: center !important;"><%=Resources.Resource.allEmployees %></div>
                                              </td>
                                              <td style="padding: 0px 5px;"></td>
                                              <td style="padding: 0px 5px;">
                                                  <div class="control-group" style="font-weight: bold; text-align: center !important;"><%=Resources.Resource.selectedEmployees %></div>
                                              </td>
                                          </tr>
                                          <tr>
                                              <td style="padding: 0px 5px; width: 45%;">
                                                  <select id="ddFromUser" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                  </select>
                                              </td>
                                              <td style="padding: 0px 5px; width: 10%;">
                                                  <div>
                                                      <input type="button" id="addUser" onclick="AddUser()" value="  >>  " />
                                                      <br />
                                                      <br />
                                                      <br />
                                                      <input type="button" id="removeUser" onclick="RemoveUser()" value="  <<  " />
                                                  </div>
                                              </td>
                                              <td style="padding: 0px 5px; width: 45%;">
                                                  <select id="ddToUser" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                  </select>
                                              </td>
                                          </tr>
                                      </table>
                                  </div>
                              </div>
                              <div class="form-actions">
                                  <span id="Span6" style="display: none;">0</span>
                                  <button id="btnSave" type="button" onclick="Save()" class="btn purple"><%=Resources.Resource.save %></button>
                                  <button type="button" onclick="return CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
                              </div>
                          </form>
                          <!-- END FORM-->
                      </div>
                  </div>
                  <!-- END POPUP ADD/REMOVE USERS FROM ROLE-->
               </div>
            </div>
            </div>
         </div>
         <!-- END ADD/REMOVE USERS MODAL FORM-->


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
									<%=Resources.Resource.seniorEmployeeList %>	
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
				<li><a href="#"><%=Resources.Resource.seniorEmployeeList %></a></li>					
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12">

                   <div class="span12" style="display:none;">
                       <!-- BEGIN FORM-->
                       <form action="#" id="form_1" class="form-horizontal">
                           <div class="row-fluid">
                               <div class="span6 ">
                                   <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.name %><span class="required">*</span></label>
                                       <div class="controls chzn-controls">
                                           <select id="ddEmp" name="emp" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                               <option value=""></option>
                                           </select>
                                       </div>
                                   </div>
                               </div>
                               <div class="span6 ">
                                   <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.manager %> <span class="required">*</span></label>
                                       <div class="controls">
                                           <select id="ddMgr" name="mgr" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                               <option value=""></option>
                                           </select>
                                       </div>
                                   </div>
                               </div>
                           </div>
                           <div class="row-fluid">
                               <div class="span6 ">
                                   <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                       <div class="controls chzn-controls">
                                           <select id="ddOrg" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                               <option value=""></option>
                                           </select>
                                       </div>
                                   </div>
                               </div>
                               <div class="span6 ">
                                   <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.designation %><span class="required">*</span></label>
                                       <div class="controls chzn-controls">
                                           <select id="ddDesig" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                               <option value=""></option>
                                           </select>
                                       </div>
                                   </div>
                               </div>
                           </div>
                           <div class="row-fluid">
                               <div class="span6 ">
                                   <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.scheduleType %> <span class="required">*</span></label>
                                       <div class="controls">
                                           <select id="ddSchType" name="mgr" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                               <option value=""></option>
                                           </select>
                                       </div>
                                   </div>
                               </div>
                               <div class="span6 ">
                                   <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.joinDate %> </label>
                                       <div class="controls">
                                           <input id="txtJoinDate" name="joindate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                       </div>
                                   </div>
                               </div>
                           </div>
                           <div class="row-fluid">
                               <div class="span6 ">
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxActive" type="checkbox" name="active" />
                                           <%=Resources.Resource.active %>
                                       </div>
                                   </div>
                               </div>
                               <div class="span6 ">
                                   <a id="btnSearch" class="label label-info label-mini">&nbsp; <%=Resources.Resource.search %> <i class="icon-share-alt"></i></a>
                                   <span style="width: 40px;">&nbsp;</span>
                                   <a id="btnSearchClear" onclick="return Clear(true)" class="label label-inverse label-mini">&nbsp; <%=Resources.Resource.clear %> <i class="icon-share-alt"></i></a>
                               </div>
                           </div>
                       </form>
                       <!-- END FORM-->
                   </div>

                  <!-- BEGIN EXAMPLE TABLE PORTLET-->
                  <div class="portlet box light-grey">
                     <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.seniorEmployeeList %></div>
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
                                <span id="spnAddButton" runat="server">
                                    <a id="btnAdd"  href="#divAssignUsers" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                </span>
                                <span id="spnDeleteButton" runat="server">
                                    <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                </span>
                                <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                            </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                           <thead>
                              <tr style="background-color: #e8e3e3;">
                                 <th style="text-align: center; "><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                 <th style="text-align: center; "><%=Resources.Resource.number %></th>
                                 <th style="text-align: center; "><%=Resources.Resource.name %></th>
                                 <th style="text-align: center; "><%=Resources.Resource.joinDate %></th>
                                 <th style="text-align: center; "><%=Resources.Resource.manager %></th>
                                 <th style="text-align: center; "><%=Resources.Resource.punch %></th>
                                 <th style="text-align: center; "><%=Resources.Resource.active %></th>
                                 <th style="text-align: center; " class="hidden-480"><%=Resources.Resource.designation %></th>
                                 <th style="text-align: center; " class="hidden-480"><%=Resources.Resource.organization %></th>
                                 <th style="text-align: center; " class="hidden-480"><%=Resources.Resource.managerName %></th>
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
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>

    <!--Script references. -->
    <!--Reference the SignalR library. -->
    <script src="../Scripts/jquery.signalR-1.1.0.min.js"></script>
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
           $("#liEmp").addClass("active");
           $("#liEmp .arrow").addClass("open");
           $("#liEmpSeniorsList").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }


           LoadGrid();

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
               if (name == "TAMSR2_SeniorEmployees") {
                   //ReloadGrid();
               }
           };


           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_SeniorEmployees', '');
                   // Clear text box and reset focus for next comment. 
               });
           });


           LoadEmployeeList();
           LoadOrganizations();
           LoadDesignations();
           LoadScheduleTypes();

           Clear(false);
           //LoadEmplopyees(false);

           $("#btnSearch").click(function () {
               //LoadEmplopyees(true);
           });
       });

       function LoadGrid() {
           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false, sWidth: "3%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "20%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "15%" },
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
               "aaSorting": [[1, "desc"]],
               "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeSeniorListPage.aspx?key=getAll") %>'
           });

       }

       function LoadEmplopyees(filter) {
           var emp = $("#ddEmp").val();
           var mgr = $("#ddMgr").val();
           var org = $("#ddOrg").val();
           var desig = $("#ddDesig").val();
           var schType = $("#ddSchType").val();
           var joinDate = $("#txtJoinDate").val();
           var active = $("#chkboxActive").is(":checked");
           var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&desig=" + desig;
           wc += "&schType=" + schType + "&joinDate=" + joinDate + "&active=" + active + "&filter=true";
           if (filter == false) {
               var wc = "&emp=" + '' + "&mgr=" + '' + "&org=" + '' + "&desig=" + '';
               wc += "&schType=" + '' + "&joinDate=" + '' + "&active=" + '' + "&filter=false";
           }
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false, sWidth: "3%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "20%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": false, sWidth: "3%", sVisible: false }
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
               "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx?key=getAllByFilters") %>' + wc
           });
            $('#sample_1').css('width', '100%');
        }

        function LoadOrganizations() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    $("#ddOrg").html(html);
                    $("#ddOrg").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadEmployeeList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    $("#ddEmp").html(html);
                    $("#ddEmp").trigger("liszt:updated");
                    $("#ddFromUser").html(html);
                    $("#ddFromUser").trigger("liszt:updated");
                    $("#ddMgr").html(html);
                    $("#ddMgr").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadDesignations() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DesignationPage.aspx") %>',
                success: function (html) {
                    $("#ddDesig").html(html);
                    $("#ddDesig").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadScheduleTypes() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ScheduleTypePage.aspx") %>',
                success: function (html) {
                    $("#ddSchType").html(html);
                    $("#ddSchType").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function ReloadGrid() {
            LoadGrid();
        }

        function CloseForm() {
            Clear(false);
            $("#btnCloseForm").click();
        }

        function Clear(reset) {
            $(':input', '#form_sample_1')
            .not(':button, :submit, :reset, :hidden')
            .val('')
            .removeAttr('checked')
            .removeAttr('selected');
            $("#divErrorMsg").hide();
            $('.help-inline').hide();
            $('.control-group').removeClass('error');
            $('.control-group').removeClass('success');
            $('.help-inline ok valid').hide();
            $("#spnGridMsg").html("&nbsp;");
            $("#spnID").html("0");
            $("#txtFromDate").val("");
            $("#txtToDate").val("");
            $("#txtRemarks").val("");

            $("#txtJoinDate").val("");
            $("#txtJoinDate").datepicker({
                format: " yyyy",
                viewMode: "years"
            });

            $("#chkboxActive").attr("checked", "checked");
            $("#uniform-chkboxActive span").addClass("checked");

            $('#ddOrg option[value=""]').attr('selected', 'selected');
            $("#ddOrg").trigger("liszt:updated");
            $('#ddEmp option[value=""]').attr('selected', 'selected');
            $("#ddEmp").trigger("liszt:updated");
            $('#ddMgr option[value=""]').attr('selected', 'selected');
            $("#ddMgr").trigger("liszt:updated");
            $('#ddDesig option[value=""]').attr('selected', 'selected');
            $("#ddDesig").trigger("liszt:updated");
            $('#ddSchType option[value=""]').attr('selected', 'selected');
            $("#ddSchType").trigger("liszt:updated");
            if (reset == true) {
                //LoadEmplopyees(false);
            }
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
                   url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeSeniorListPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg2").css("display", "block");
                           $("#spnSuccessMsg2").html("<%=Resources.Resource.msgRecordDelete %>");
                           $('#btnBroadCast').click();
                           ReloadGrid();
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


       function Edit(id) {
           //Edit code
           var v = "key=getByID&id=" + id;
           $("#btnAdd").click();
           $("#spnID").html(id);
           $("#spnGridMsg").html("&nbsp;");
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       $("#spnID").val(j.ID);
                       $("#txtDescriptionEn").val(j.DescriptionEn);
                       $("#txtDescriptionAr").val(j.DescriptionAr);
                       $("#txtCode").val(j.Code);
                       $("#txtMaxPermissions").val(j.MaxPermissions);
                       $("#txtMaxMinutes").val(j.MaxMinutes);
                       $("#txtTcn").val(j.TCN);
                       $('#ddOrg option[value=' + j.OrgID + ']').attr('selected', 'selected');
                       $("#ddOrg").trigger("liszt:updated");
                       if (j.GroupApplyFlag + "" == "1") {
                           $("#chkboxGroupApply").attr("checked", "checked");
                           $("#uniform-chkboxGroupApply span").addClass("checked");
                       }
                       if (j.OfficialFlag + "" == "Y" || j.OfficialFlag + "" == "y") {
                           $("#chkboxOfficial").attr("checked", "checked");
                           $("#uniform-chkboxOfficial span").addClass("checked");
                       }
                   }
               },
               error: function (html) {

               }
           });
       }


       function AddUser() {
           var arr = $("#ddFromUser").val();
           var txt = $("#ddFromUser option:selected").text();
           var chk = false;
           $.each(arr, function (index, val) {
               if (0 == $('#ddToUser option[value=' + val + ']').length) {
                   $('#ddToUser').append($('<option>', {
                       value: val,
                       text: $("#ddFromUser option[value='" + val + "']").text()
                   }));
               }
               $("#ddFromUser option[value='" + val + "']").remove();
           });
       }

       function RemoveUser() {
           var arr = $("#ddToUser").val();
           var txt = $("#ddToUser option:selected").text();

           $.each(arr, function (index, val) {
               if (0 == $('#ddFromEmployee option[value=' + val + ']').length) {
                   $('#ddFromUser').append($('<option>', {
                       value: val,
                       text: $("#ddToUser option[value='" + val + "']").text()
                   }));
               }
               $("#ddToUser option[value='" + val + "']").remove();
           });
       }


       function Save() {
           var valuesToEmployee = $.map($('#ddToUser option'), function (e) { return e.value; });
           var empID = valuesToEmployee.toString();
           //if ($('#form_sample_1').validate().form() == false) {
           //    return false;
           //}
           var v = "key=save" + "&empid=" + empID;
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeSeniorListPage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#divErrorMsgUser").css("display", "block");
                       $("#spnErrorMsgUser").html("<%=Resources.Resource.msgRecordNotSaved %>");
                   }
                   else if (html == '0') {
                       //exists
                       $("#divErrorMsgUser").css("display", "block");
                       $("#spnErrorMsgUser").html("<%=Resources.Resource.msgRecordExists %>");
                   }
                   else {
                       //success
                       $("#divSuccessMsgUser").css("display", "block");
                       $("#spnSuccessMsgUser").html("<%=Resources.Resource.msgRecordSaved %>");
                       $('#btnBroadCast').click();
                       Clear(false);
                       ReloadGrid();
                   }
               },
               error: function (html) {
                   $("#divErrorMsgUser").css("display", "block");
                   $("#spnErrorMsgUser").html("Error! " + html);
               }

           });

   }
   var FormComponents = function () {

       var handlejQueryUIDatePickers = function () {
           $(".ui-date-picker").datepicker();
       }

       var handleDateTimePickers = function () {

           if (jQuery().datepicker) {
               $('.date-picker').datepicker({ format: 'yyyy-mm-dd', viewMode: "years" });
           }

           if (jQuery().timepicker) {
               $('.timepicker-default').timepicker();
               $('.timepicker-24').timepicker({
                   minuteStep: 1,
                   showSeconds: false,
                   showMeridian: false
               });
           }

           if (!jQuery().daterangepicker) {
               return;
           }

           $('.date-range').daterangepicker(
               {
                   opens: (App.isRTL() ? 'left' : 'right'),
                   format: 'yyyy-mm-dd',
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
               format: 'yyyy-mm-dd',
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

           $("#txtFrom").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
           $("#txtToDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
           $("#txtJoinDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
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
                       noOfCl: {
                           required: true
                       },
                       noOfSl: {
                           required: true
                       },
                       noOfAl: {
                           required: true
                       },
                       org: {
                           required: true
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
   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
