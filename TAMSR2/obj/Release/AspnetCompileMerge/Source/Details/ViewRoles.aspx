<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewRoles.aspx.cs" Inherits="TAMSR2.Details.ViewRoles" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.roles %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->
    <style type="text/css">
        #tblPrivilegeScope tbody .checkboxes {
            margin: 5px;
        }
        .modal-body {
            max-height: 550px;
        }
    </style>
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
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.roles %></h4>
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
                              <label class="control-label"><%=Resources.Resource.nameEn %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="text" id="txtNameEn" name="nameEn" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.nameAr %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="text" id="txtNameAr" name="nameAr" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="form-actions">
                               <span id="spnID" style="display: none;">0</span>
                              <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                              <button id="btnSave" type="button" onclick="Save()" class="btn purple"><%=Resources.Resource.save %></button>
                              <button type="button" onclick="return CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
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
    
         <!-- BEGIN PRIVILEGES MODAL FORM-->
         <div id="divAssignPrivileges" class="modal hide">
            <div class="modal-body">
               <div class="row-fluid">
               <div class="span12">
                  <!-- BEGIN VALIDATION STATES-->
                  <div class="portlet box purple">
                      <div class="portlet-title">
                          <button data-dismiss="modal" class="close" type="button"></button>
                          <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.role %> <span id="spnPrivilegeRole">&nbsp;</span></h4>
                          <span id="spnPrivilegeRoleID" style="display: none;">&nbsp;</span>
                      </div>
                     <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                         <form action="#" id="form1" class="form-horizontal">
                             <div id="divErrorMsgPrivilege" class="alert alert-error hide">
                                 <button class="close" data-dismiss="alert"></button>
                                 <span id="spnErrorMsgPrivilege"><%=Resources.Resource.formErrors %></span>
                             </div>
                             <div id="divSuccessMsgPrivilege" class="alert alert-success hide">
                                 <button class="close" data-dismiss="alert"></button>
                                 <span id="spnSuccessMsgPrivilege"><%=Resources.Resource.formErrorsRemoved %></span>
                             </div>
                             <div style="max-height: 350px; overflow: auto; overflow-x: hidden;">
                                 <div class="control-group">
                                     <table id="tblPrivilegeScope" style="width: 100%; text-align: <%= floatStr %>;">
                                         <thead>
                                             <tr>
                                                 <th style="width:10% !important;"><input type="checkbox" class="group-checkable" data-set="#tblPrivilegeScope .checkboxes" /></th>
                                                 <th style='width: 45%;'>Name</th>
                                                 <th style='width: 45%; text-align: center;'>scope</th>
                                             </tr>
                                         </thead>
                                         <tbody>
                                             <tr>
                                             </tr>
                                         </tbody>
                                     </table>
                                 </div>
                             </div>
                                 <div class="form-actions">
                                     <span id="Span3" style="display: none;">0</span>
                                     <button id="btnSaveAssignPrivileges" type="button" onclick="ConfigureRolePRivileges()" class="btn purple"><%=Resources.Resource.save %></button>
                                     <button type="button" onclick="return CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
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
         <!-- END PRIVILEGES MODAL FORM-->
    
         <!-- BEGIN ADD/REMOVE USERS MODAL FORM-->
         <div id="divAssignUsers" class="modal hide">
            <div class="modal-body">
               <div class="row-fluid">
               <div class="span12">
                  <!-- BEGIN POPUP ADD/REMOVE USERS FROM ROLE-->
                  <div class="portlet box purple">
                     <div class="portlet-title">
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.role %> <span id="spnUserRole">&nbsp;</span></h4>
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
                                  <button id="btnSaveAssignUsers" type="button" onclick="SaveAssignUsers()" class="btn purple"><%=Resources.Resource.save %></button>
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
									<%=Resources.Resource.roles %> 
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a>
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.settings %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.roles %></a></li>					
				
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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.roles %></div>
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
                                  <a id="btnAssignUsers" style='display: none; margin: 0px 10px;' onclick="return Clear()" href="#divAssignUsers" data-toggle="modal" class="btn green"><i class="icon-plus"> &nbsp; <%=Resources.Resource.users %></i></a> 
                                  <a id="btnAssignPrivileges" style='display: none; margin: 0px 10px;' onclick="return Clear()" href="#divAssignPrivileges" data-toggle="modal" class="btn green"><i class="icon-plus"> &nbsp; <%=Resources.Resource.privileges %></i></a> 
                                  <a id="btnAdd" onclick="return Clear()" style='margin: 0px 10px;' href="#portlet-config" data-toggle="modal" class="btn green"><i class="icon-plus"> &nbsp; <%=Resources.Resource.add %></i></a> 
                                  <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash"> &nbsp; <%=Resources.Resource.delete %></i></a>                                   
                              </span>
                           </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                           <thead>
                              <tr style="background-color: #e8e3e3;">
                                 <th style="text-align: center; width:5% !important;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                 <th style="text-align: center; width:40%;"><%=Resources.Resource.name %></th>
                                 <th style="text-align: center; width:15%;">&nbsp;</th>
                                 <th style="text-align: center; width:15%;">&nbsp;</th>
                                 <th style="text-align: center; width:10%;"><%=Resources.Resource.users %></th>
                                 <th style="text-align: center; width:5%;">&nbsp;</th>
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
           //TableManaged.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liSecurity").addClass("active");
           $("#liSecurity .arrow").addClass("open");
           $("#liRoles").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false },
                 { "bSortable": true },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false }
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
               "aaSorting": [[1, "asc"]],
               "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/RolePage.aspx?key=getAll") %>'
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

           $('#tblPrivilegeScope .group-checkable').change(function () {
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
               if (name == "TAMSR2_Roles") {
                   ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_Roles', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
       });

       function ReloadGrid() {
           $('#sample_1').dataTable().fnDraw();
       }
       //spnSuccessMsgPrivilege

       function LoadAllPrivilegeScope(rID) {
           $("#tblPrivilegeScope tbody").html("<tr><td colspan='3'></td></tr>");
           var d = "key=getAllPrivilegeScopeGrid&rID=" + rID;
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/SecPrivilegePage.aspx") %>',
               success: function (html) {
                   $("#tblPrivilegeScope tbody").html(html);
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
           });
       }

       function GetUsersNotInRoleByRoleID(rID) {
           $("#ddFromUser").html("<option value=''></option>");
           var d = "key=getUsersNotInRoleByRoleID&rID=" + rID;
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    $("#ddFromUser").html(html);
                    $("#ddFromUser").trigger("liszt:updated");
                    $("#ddFromUser option[value='']").remove();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
       }
       
       function GetUsersInRoleByRoleID(rID) {
           $("#ddToUser").html("<option value=''></option>");
           var d = "key=getUsersInRoleByRoleID&rID=" + rID;
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    $("#ddToUser").html(html);
                    $("#ddToUser").trigger("liszt:updated");
                    $("#ddToUser option[value='']").remove();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

       function ChkValues() {
           alert("check rows will be deleted");
           //var count = $("#spnCount").html();
           var check = "false";
           var v = "key=finallyApprove&";

           var k = 1;
           $("#sample_1 tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   v += "chk" + k + "=" + this.value + "&";
                   k++;
                   //this.checked = chk.checked;
               }
           });
           v += "count=" + k;
           alert(v);
       }

       function ConfigureRolePRivileges() {
           $("#divSuccessMsgPrivilege").css("display", "none");
           $("#divErrorMsgPrivilege").css("display", "none");

           var rID = $("#spnPrivilegeRoleID").html();
           var v = "key=configureRolePrivileges&rID=" + rID;

           var k = 1;
           var checked = false;
           var prvList = "";
           var scopeList = "";

           $("#tblPrivilegeScope tbody tr").each(function () {
               
               $(this).find("td .checkboxes").each(function () { //rewrite
                   if ($(this).is(":checked"))
                   {
                       checked = true;
                       if (prvList != "")
                           prvList += ",";
                       prvList += $(this).val();
                   }
                   else                       
                   {
                       checked = false;
                   }
               });
               $(this).find("td .ddScope").each(function () { //rewrite
                   if (checked) {
                       if (scopeList != "")
                           scopeList += ",";
                       scopeList += $(this).val();
                       k++;
                   }
               });
               
           });

           v += "&count=" + k + "&prvList=" + prvList + "&scopeList=" + scopeList;
           
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/SecPrivilegePage.aspx") %>',
               contentType: 'application/x-www-form-urlencoded; charset=utf-8',
               success: function (html) {
                   if (html == '-1' || html == '0') {
                       //failed
                       $("#divSuccessMsgPrivilege").css("display", "none");
                       $("#divErrorMsgPrivilege").css("display", "block");
                       $("#spnErrorMsgPrivilege").html("Error! Record not saved successfully.");
                   }
                   else {
                       //success
                       $("#divErrorMsgPrivilege").css("display", "none");
                       $("#divSuccessMsgPrivilege").css("display", "block");
                       $("#spnSuccessMsgPrivilege").html("Sucessfully saved in database.");
                   }
               },
               error: function (html) {
                   $("#divSuccessMsgPrivilege").css("display", "none");
                   $("#divErrorMsgPrivilege").css("display", "block");
                   $("#spnErrorMsgPrivilege").html("Error! " + html);
               }

           });
       }

       function CloseForm() {
           Clear();
           $("#divSuccessMsg").hide();
       }

    
           function Clear() {

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

           $("#txtNameEn").val("");
           $("#txtNameAr").val("");
           //$("#txtCategory").val("");
           //$("#txtService").val("");

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
                   url: '<%= Page.ResolveClientUrl("../RequestPages/RolePage.aspx") %>',
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

       function Edit(id) {
           //Edit code
           var v = "key=getByID&id=" + id;
           $("#btnAdd").click();
           $("#spnID").html(id);
           $("#spnGridMsg").html("&nbsp;");
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/RolePage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       $("#spnID").val(j.ID);
                       $("#txtNameEn").val(j.NameEn);
                       $("#txtNameAr").val(j.NameAr);
                   }
               },
               error: function (html) {

               }
           });
       }

       function Save() {

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");

           var id = $("#spnID").html();
           var nameEn = $("#txtNameEn").val();
           var nameAr = $("#txtNameAr").val();
           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }
           var v = "key=save" + "&id=" + id + "&nameEn=" + nameEn + "&nameAr=" + nameAr;

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/RolePage.aspx") %>',
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
                       Clear();
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("Error! " + html);
               }

           });

       }

       function AssignPrivileges(rID, rName) {

           $("#divSuccessMsgPrivilege").css("display", "none");
           $("#divErrorMsgPrivilege").css("display", "none");

           $("#spnPrivilegeRole").html("&nbsp;");
           $("#spnPrivilegeRoleID").html("&nbsp;");
           $("#spnPrivilegeRole").html(rName + "");
           $("#spnPrivilegeRoleID").html(rID + "");

           $("#btnAssignPrivileges").click();

           LoadAllPrivilegeScope(rID);
       }

       function AssignUsers(rID, rName) {
           window.location = '<%= Page.ResolveClientUrl("../Security/Assign-Employees-To-Roles/") %>' + rID + "/" + rName;
           return;
           $("#divSuccessMsgUser").css("display", "none");
           $("#divErrorMsgUser").css("display", "none");

           $("#spnUserRole").html("&nbsp;");
           $("#spnUserRoleID").html("&nbsp;");
           $("#spnUserRole").html(rName + "");
           $("#spnUserRoleID").html(rID + "");

           $("#btnAssignUsers").click();

           GetUsersNotInRoleByRoleID(rID);
           GetUsersInRoleByRoleID(rID);
       }

       function AddUser() {
           var arr = $("#ddFromUser").val();
           var txt = $("#ddFromUser option:selected").text();
           $.each(arr, function (index, val) {
               $('#ddToUser').append($('<option>', {
                   value: val,
                   text: $("#ddFromUser option[value='" + val + "']").text()
               }));
               $("#ddFromUser option[value='" + val + "']").remove();
           });           
       }

       function RemoveUser() {
           var arr = $("#ddToUser").val();
           var txt = $("#ddToUser option:selected").text();
           $.each(arr, function (index, val) {
               $('#ddFromUser').append($('<option>', {
                   value: val,
                   text: $("#ddToUser option[value='" + val + "']").text()
               }));
               $("#ddToUser option[value='" + val + "']").remove();
           });
       }

       function SaveAssignUsers() {
           var roleID = $("#spnUserRoleID").html() + "";

           var valuesToUser = $.map($('#ddToUser option'), function (e) { return e.value; });
           var toUser = valuesToUser.toString();
           var valuesFromUser = $.map($('#ddFromUser option'), function (e) { return e.value; });
           var fromUser = valuesFromUser.toString();

           if (roleID == "" || roleID == "&nbsp;") {
               if (fromUSer == "" && toUser == "") {
                   $("#divSuccessMsgUser").css("display", "none");
                   $("#divErrorMsgUser").css("display", "block");
                   $("#spnErrorMsgUser").html("Error! Record not saved successfully.");
               }
               //SaveRemoveUsers();
               return;
           }

           toUser += ",-1";

           var v = "key=saveAssignUsers" + "&roleID=" + roleID + "&toUser=" + toUser;

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/RolePage.aspx") %>',
               contentType: 'application/x-www-form-urlencoded; charset=utf-8',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#divSuccessMsgUser").css("display", "none");
                       $("#divErrorMsgUser").css("display", "block");
                       $("#spnErrorMsgUser").html("Error! Record not saved successfully.");
                   }
                   else {
                       //success
                       $("#divErrorMsgUser").css("display", "none");
                       $("#divSuccessMsgUser").css("display", "block");
                       $("#spnSuccessMsgUser").html("Sucessfully saved in database.");
                       SaveRemoveUsers();
                       ReloadGrid();
                   }
               },
               error: function (html) {
                   $("#divSuccessMsgUser").css("display", "none");
                   $("#divErrorMsgUser").css("display", "block");
                   $("#spnErrorMsgUser").html("Error! " + html);
               }

           });
       }

       function SaveRemoveUsers() {
           var roleID = $("#spnUserRoleID").html();
           var valuesToUser = $.map($('#ddToUser option'), function (e) { return e.value; });
           var toUser = valuesToUser.toString();
           var valuesFromUser = $.map($('#ddFromUser option'), function (e) { return e.value; });
           var fromUser = valuesFromUser.toString();
           if (roleID == "" || roleID == "&nbsp;") {
               if (fromUSer == "" && toUser == "") {
                   $("#divSuccessMsgUser").css("display", "none");
                   $("#divErrorMsgUser").css("display", "block");
                   $("#spnErrorMsgUser").html("Error! Record not saved successfully.");
               }
               return;
           }
           fromUser += ",-1";
           var v = "key=saveRemoveUsers" + "&roleID=" + roleID + "&fromUser=" + fromUser;

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/RolePage.aspx") %>',
               contentType: 'application/x-www-form-urlencoded; charset=utf-8',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#divSuccessMsgUser").css("display", "none");
                       $("#divErrorMsgUser").css("display", "block");
                       $("#spnErrorMsgUser").html("Error! Record not saved successfully.");
                   }
                   else {
                       //success
                       $("#divErrorMsgUser").css("display", "none");
                       $("#divSuccessMsgUser").css("display", "block");
                       $("#spnSuccessMsgUser").html("Sucessfully saved in database.");
                       ReloadGrid();
                       Clear();
                   }
               },
               error: function (html) {
                   $("#divSuccessMsgUser").css("display", "none");
                   $("#divErrorMsgUser").css("display", "block");
                   $("#spnErrorMsgUser").html("Error! " + html);
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
                               required: true,
                               maxlength: 50
                           },
                           nameAr: {
                               minlength: 3,
                               required: true,
                               maxlength: 50
                           }
                       },
                       message: {
                           nameEn: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           } , 
                           nameAr : {
                               required: "<%=Resources.Resource.lblRequired %>"
                           }
                       },

                       errorPlacement: function (error, element) { // render error placement for each input type
                           if (element.attr("name") == "service") { // for uniform checkboxes, insert the after the given container
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
