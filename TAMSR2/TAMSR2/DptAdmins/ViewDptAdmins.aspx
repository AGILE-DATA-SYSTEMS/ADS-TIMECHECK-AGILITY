<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewDptAdmins.aspx.cs" Inherits="TAMSR2.DptAdmins.ViewDptAdmins" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.DeptAdmins %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/css/bootstrap-tree.css" />  
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />

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
                         <button data-dismiss="modal" class="close" type="button"></button>
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.DeptAdmins %></h4>
                     </div>
                     <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <form action="#" id="form_sample_1" class="form-horizontal">

                           <div id="divDelegatedFeatures" style="width: 100%; padding: 10px;">
                            &nbsp;
                               
                           </div>
                       <div id="divTransaferFeatures" style="display:none;width: 100%;  padding: 10px;">
                        <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label" style="padding: 5px !important; width: 70px !Important;"><%=Resources.Resource.fromDate %> <span class="required">*</span></label>
                                <div class="controls" style="margin-left:5px !important;">
                                    <input id="txtFromDate" readonly="true" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label" style="padding: 2px !important; width: 70px !Important;"><%=Resources.Resource.toDate %> <span class="required">*</span></label>
                                <div class="controls" style="margin-left:5px !important;">
                                    <input id="txtToDate" name="toDate" readonly="true" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <div class="row-fluid">
                         <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"  style="padding: 2px !important; width: 70px !Important;">&nbsp;</label>
                                <div class="controls" style="margin-left:5px !important;">
                                    <input id="chkboxStatus" type="checkbox" name="status" />
                                    <%=Resources.Resource.status %>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                        <div class="row-fluid">
                        <div class="span12 ">
                            <div class="control-group">
                                <div style="padding: 20px;">
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
                                                <select id="ddFromEmployee" name="ddFromEmployee" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                </select>
                                            </td>
                                            <td style="padding: 0px 5px; width: 10%;">
                                                <div>
                                                    <input type="button" id="btnAddEmployee" onclick="AddEmployee()" value="  >>  " />
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <input type="button" id="btnRemoveEmployee" onclick="RemoveEmployee()" value="  <<  " />
                                                </div>
                                            </td>
                                            <td style="padding: 0px 5px; width: 45%;">
                                                <select id="ddToEmployee" name="ddToEmployee" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0px 5px;">
                                                <div class="control-group" style="font-weight: bold; text-align: center !important;"><%=Resources.Resource.allOrganizations %></div>
                                            </td>
                                            <td style="padding: 0px 5px;"></td>
                                            <td style="padding: 0px 5px;">
                                                <div class="control-group" style="font-weight: bold; text-align: center !important;"><%=Resources.Resource.selectedOrganizations %></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0px 5px; width: 45%;">
                                                <select id="ddFromOrg" name="ddFromOrg" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                </select>
                                            </td>
                                            <td style="padding: 0px 5px; width: 10%;">
                                                <div>
                                                    <input type="button" id="btnAddOrg" onclick="AddOrg()" value="  >>  " />
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <input type="button" id="btnRemoveOrg" onclick="RemoveOrg()" value="  <<  " />
                                                </div>
                                            </td>
                                            <td style="padding: 0px 5px; width: 45%;">
                                                <select id="ddToOrg" name="ddToOrg" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span12 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.remarks %></label>
                                <div class="controls">
                                    <textarea id="txtRemarks" name="remarks" onkeydown="return imposeMaxLength(this, event, 490);" data-required="1" rows="3" class="medium m-wrap" style="width: 86% !important; resize: none;"></textarea>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                            </div>
                            <div >

                             <div id="divErrorMsg" class="alert alert-error hide" style="display:none;">
                              <%--<button class="close" data-dismiss="alert"></button>--%>
                              <span id="spnErrorMsg"> <%=Resources.Resource.formErrors %></span> 
                           </div>
                           <div id="divSuccessMsg" class="alert alert-success hide" style="display:none;">
                              <%--<button class="close" data-dismiss="alert"></button>--%>
                              <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span> 
                           </div>
                            </div>
                           <div class="form-actions">
                              <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                              <button type="button" onclick="CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
                               
                              <button type="button" class="btn green" data-toggle="modal"  onclick="return Save()" id="A1"> &nbsp; <%=Resources.Resource.save %></button>
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
									<%=Resources.Resource.DeptAdmins %>	
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
				<li><a href="#"><%=Resources.Resource.DeptAdmins %></a></li>					
						
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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.DeptAdmins %></div>
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
                              <a style="display: none;" id="btnShowFeatures" href="#portlet-config" data-toggle="modal" class="btn green"><i class="icon"> &nbsp; <%=Resources.Resource.feature %></i></a> 
                                  <span id="spnAddButton" runat="server" >
                                  <a id="btnAdd" onclick="return Clear()" href='<%= Page.ResolveClientUrl("~/Emp/Save-Department-Admins/" + TAMSR2.CustomClasses.Encryption.Encrypt("0")) %>' data-toggle="modal" class="btn green"><i class="icon-plus"> &nbsp; <%=Resources.Resource.add %></i></a> 
                              </span>
                              <span id="spnDeleteButton" runat="server" >
                                  <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash"> &nbsp; <%=Resources.Resource.delete %></i></a> 
                              </span>
                           </div>
                        </div>

                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                           <thead>
                              <tr style="background-color: #e8e3e3;">
                                 <th style="text-align: center; "><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                 <th style="text-align: center; "><%=Resources.Resource.number %></th>
                                 <th style="text-align: center; "><%=Resources.Resource.name %></th>
                                 <th style="text-align: center; "></th>
                                 <th style="text-align: center; "><%=Resources.Resource.fromDate %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.toDate %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.active %></th>
                                 <th style="text-align: center; "><%=Resources.Resource.createdBy %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.updated %></th>
                                 <th style="text-align: center; ">&nbsp;</th>
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
   <script src="../assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/js/bootstrap-tree.js"></script>
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
          // FormComponents.init();
           //TableManaged.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liEmp").addClass("active");
           $("#liEmp .arrow").addClass("open");
           $("#liViewDeptAdmins").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }
           $("#A1").hide();

           $("#chkboxStatus").attr("checked", "checked");
           $("#uniform-chkboxStatus span").addClass("checked");


           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false, sWidth: "5%" },
                 { "bSortable": true, sWidth: "7%" },
                 { "bSortable": true, sWidth: "25%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "20%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": false, sWidth: "7%" }
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
               "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx?key=getAll") %>'
           });

           $('#sample_1 .group-checkable').change(function () {
               var set = $(this).attr("data-set");
               var checked = $(this).is(":checked");
               jQuery(set).each(function () {
                   if (checked) {
                       if (!$(this).is(':disabled')) {
                           $(this).attr("checked", true);
                       }
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
               if (name == "TAMSR2_Cmp_Org") {
                   ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_Cmp_Org', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
       });

       function ViewDeptAdminOrganizations(dID) {
           var d = "key=viewDeptAdminOrganizations&dID=" + dID;
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           Clear();
           $("#A1").hide();
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/DeptAdminPage.aspx") %>',
               success: function (html) {
                   $("#divTransaferFeatures").css("display", "none");
                   $("#divDelegatedFeatures").html(html);
                   $("#btnShowFeatures").click();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }



       function TransferDeptAdminOrganizations(dID) {

           Clear();
           $("#A1").show();

           Edit(dID);
           LoadOrgFilterList();
           window.setTimeout(LoadEmployeeList, 1000);
          // LoadEmployeeList();
          // LoadEmployeeNotDeptAdminList
           $("#divTransaferFeatures").css("display", "block");
           $("#btnShowFeatures").click();          
       }

       function LoadEmployeeList() {
           //alert('p');
           var d = "key=getIdNameListWithDept";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    $("#ddFromEmployee").html(html);
                    $("#ddFromEmployee").trigger("liszt:updated");                    
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
       }

       function LoadEmployeeNotDeptAdminList() {
           var d = "key=getEmployeeNotDeptAdmin&orgID=" + $("#ddOrgFilter").val();
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
             $.ajax({
                 type: 'POST',
                 data: d,
                 url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                success: function (html) {
                    $("#ddFromEmployee").html(html);
                    $("#ddFromEmployee").trigger("liszt:updated");
                    $("#ddFromEmployee option[value=<%= Session["ID"] + "" %>]").remove();
                    tempEmp = true;
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

       function LoadOrgFilterList() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    $("#ddOrgFilter").html(html);
                    $("#ddOrgFilter").trigger("liszt:updated");
                    $("#ddFromOrg").html(html);
                    $("#ddFromOrg").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    LoadEmployeeNotDeptAdminList();
                    tempOrg = true;
                    var dlg = $('#spnDlg').text();
                    
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    
                }
            });
        }

       function AddEmployee() {
           var arr = $("#ddFromEmployee").val();
           var txt = $("#ddFromEmployee option:selected").text();
           var chk = false;
           $.each(arr, function (index, val) {
               if (0 == $('#ddToEmployee option[value=' + val + ']').length) {
                   $('#ddToEmployee').append($('<option>', {
                       value: val,
                       text: $("#ddFromEmployee option[value='" + val + "']").text()
                   }));
               }
               $("#ddFromEmployee option[value='" + val + "']").remove();
           });
       }

       function RemoveEmployee() {
           var arr = $("#ddToEmployee").val();
           var txt = $("#ddToEmployee option:selected").text();

           $.each(arr, function (index, val) {
               if (0 == $('#ddFromEmployee option[value=' + val + ']').length) {
                   $('#ddFromEmployee').append($('<option>', {
                       value: val,
                       text: $("#ddToEmployee option[value='" + val + "']").text()
                   }));
               }
               $("#ddToEmployee option[value='" + val + "']").remove();
           });
       }

       function AddOrg() {
           var arr = $("#ddFromOrg").val();
           var txt = $("#ddFromOrg option:selected").text();

           $.each(arr, function (index, val) {
               if (0 == $('#ddToOrg option[value=' + val + ']').length) {
                   $('#ddToOrg').append($('<option>', {
                       value: val,
                       text: $("#ddFromOrg option[value='" + val + "']").text()
                   }));
               }
               $("#ddFromOrg option[value='" + val + "']").remove();
           });
       }

       function RemoveOrg() {
           var arr = $("#ddToOrg").val();
           var txt = $("#ddToOrg option:selected").text();

           $.each(arr, function (index, val) {
               if (0 == $('#ddFromOrg option[value=' + val + ']').length) {
                   $('#ddFromOrg').append($('<option>', {
                       value: val,
                       text: $("#ddToOrg option[value='" + val + "']").text()
                   }));
               }
               $("#ddToOrg option[value='" + val + "']").remove();
           });
       }


       function Edit(id) {
           //Edit code
           var v = "key=getByID&id=" + id;
           //$("#spnGridMsg").html("&nbsp;");
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);

                        $("#spnID").val(j.ID);
                        if (j.ID == "0") {
                            $("#spnID").html(j.ID);
                            return;
                        }// alert(j.FromDateStr + j.ToDateStr);
                        if (j.FromDateStr != '') {
                          $("#txtFromDate").val(j.FromDateStr);
                           
                        }
                        if (j.ToDateStr != '') {
                            
                            $("#txtToDate").val(j.ToDateStr);
                        }
                       
                        if (j.Status.toLowerCase() + "" == "true") {
                            $("#chkboxStatus").attr("checked", "checked");
                            $("#uniform-chkboxStatus span").addClass("checked");
                        }
                        else {
                            $("#chkboxStatus").removeAttr("checked");
                            $("#uniform-chkboxStatus span").removeClass("checked");
                        }
                        //   alert(j.remarks);
                        //$("#txtRemarks").val(j.remarks);
                        //$('#ddEmployee option[value=' + j.EmployeeID + ']').attr('selected', 'selected');
                        //$("#ddEmployee").trigger("liszt:updated");
                        //$('#ddOrg option[value=' + j.OrgID + ']').attr('selected', 'selected');
                        //$("#ddOrg").trigger("liszt:updated");

                       // LoadEmployeeList();

                    }
                },
                error: function (html) {

                }
            });
        }


       function ReloadGrid() {
           $('#sample_1').dataTable().fnDraw();
       }

       function CloseForm() {
           Clear();
           $("#btnCloseForm").click();
       }

       function Clear() {
           $('#form_sample_1')
               .closest('.control-group').removeClass('error'); // set error class to the control group
           $(':input', '#form_sample_1')
            .not(':button, :submit, :reset, :hidden')
            .val('')
            .removeAttr('checked')
            .removeAttr('selected');
           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");


           $("#spnGridMsg").html("&nbsp;");
           $("#divErrorMsg").css("display", "none");
           $("#divDelegatedFeatures").html(" &nbsp; ");
           $("#ddToOrg").html("");
           $("#ddToEmployee").html("");

           
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
                   url: '<%= Page.ResolveClientUrl("../RequestPages/DeptAdminPage.aspx") %>',
                   success: function (html) {
                       //alert(html);
                       if (html == "1") {
                           $("#divSuccessMsg2").css("display", "block");
                           $("#spnSuccessMsg2").html("<%=Resources.Resource.msgRecordDelete %>");
                           $('#btnBroadCast').click();

                           $("#divSuccessMsg2").css("display", "none");
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



       function Save() {

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");

           var id = $('#spnDlg').text();

           var valuesToEmployee = $.map($('#ddToEmployee option'), function (e) { return e.value; });
           var empID = valuesToEmployee.toString();
           var valuesToOrg = $.map($('#ddToOrg option'), function (e) { return e.value; });
           var orgID = valuesToOrg.toString();
         
           if (empID == "") {
              $("#divErrorMsg").css("display", "block");
              $("#spnErrorMsg").html("<%=Resources.Resource.msgFeatureRequired %>"); 
               return false;
            } 
            if (orgID == "") {
                $("#divSuccessMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgFeatureRequired %>");
                return false;
            } 

            var fromDate = $("#txtFromDate").val();
            var toDate = $("#txtToDate").val();
            var remarks = $("#txtRemarks").val();
            var status = $("#chkboxStatus").is(":checked");

            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }
            var v = "key=save" + "&id=" + id + "&empID=" + empID + "&orgID=" + orgID + "&status=" + status;
            v += "&fromDate=" + fromDate + "&toDate=" + toDate + "&remarks=" + remarks;
         //   alert(v);
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                success: function (html) {
                    if (html == '-1') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                    }
                    else if (html == '0') {
                        //exists
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                    }
                    else {
                        //success
                        $("#divSuccessMsg").css("display", "block");
                        $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                        $('#btnBroadCast').click();
                        if ($('#spnDlg').text() + "" != "" && $('#spnDlg').text() + "" != "MA==") {
                            window.location = '<%= Page.ResolveClientUrl("~/Emp/Department-Admins") %>';
                       }
                       Clear();
                        //LoadOrgFilterList();
                        //LoadEmployeeDeptAdminList();
                       LoadEmployeeNotDeptAdminList();
                   }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("Error! " + html);
                }

            });

   }


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
                           //},
                           //ddToEmployee: {
                           //    minlength: 1,
                           //    required: true
                           //},
                           //ddToOrg: {
                           //    required: true
                           //}

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
                           },
                           ddToEmployee: {
                               required: "<%=Resources.Resource.lblRequired %>"
                       },
                           ddToOrg: {
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



       var FormComponents = function () {

           var handlejQueryUIDatePickers = function () {
               $(".ui-date-picker").datepicker();
           }

           var handleDateTimePickers = function () {

               if (jQuery().datepicker) {
                   $('.date-picker').datepicker({ format: 'yyyy-mm-dd' });
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

               $("#txtFromDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
               $("#txtToDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
           }

           return {
               //main function to initiate the module
               init: function () {
                  // handlejQueryUIDatePickers();
                 //  handleDateTimePickers();
                //   handleInputMasks();
               }

           };

       }();
       ////////END OF FORM COMPONENTS////////


   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
