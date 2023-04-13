<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignGroupEmployees.aspx.cs" Inherits="TAMSR2.Details.AssignGroupEmployees" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.groupMembers %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->
    <style type="text/css">
        
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
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.employees %></h4>
                     </div>
                     <div class="portlet-body form" style="height: 400px; overflow-y: auto; overflow-x: hidden;">
                           <div id="divSuccessMsg" class="alert alert-success hide">
                              <span id="spnSuccessMsg"> <%=Resources.Resource.formErrors %></span> 
                           </div>
                           <div id="divErrorMsg" class="alert alert-error hide">
                              <span id="spnErrorMsg"><%=Resources.Resource.formErrorsRemoved %></span> 
                           </div>
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="spnGridMsg">&nbsp;</span>
                            </div>
                                 <div class="span6">
                                     <!-- BEGIN FORM-->
                                     <form action="#" id="form_1" class="form-horizontal">
                                         <div class="control-group">
                                             <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                             <div class="controls chzn-controls">
                                                 <select id="ddOrg" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                     <option value=""></option>
                                                 </select>
                                             </div>
                                         </div>
                                     </form>
                                 </div>

                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="spnAddButton" runat="server">
                                    <a id="A1" onclick="SaveGroupMembers()" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                </span>
                                    <a data-dismiss="modal" class="btn" style="margin: 0px 5px;">&nbsp; <%=Resources.Resource.cancel %></i></a>

                            </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_Employees" style="width: 648px !important;">
                           <thead>
                              <tr style="background-color: #e8e3e3;">
                                 <th style="text-align: center; width:30px;"><input type="checkbox" class="group-checkable" data-set="#sample_Employees .checkboxes" /></th>
                                 <th style="text-align: center; width: 50px !important;"><%=Resources.Resource.number %></th>
                                 <th style="text-align: center; width: 200px !important;"><%=Resources.Resource.name %></th>
                                 <th style="text-align: center; width: 150px !important;" class="hidden-480"><%=Resources.Resource.designation %></th>
                                 <th style="text-align: center; width: 200px !important;" class="hidden-480"><%=Resources.Resource.organization %></th>
                              </tr>
                           </thead>
                           <tbody>
                           </tbody>
                        </table>
                        </div>
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
                    <%=Resources.Resource.groupMembers %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.employee %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="<%= Page.ResolveClientUrl("~/Emp/Employee-Groups") %>"><%=Resources.Resource.employeeGroups %></a>
                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.groupMembers %></a></li>

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
                        <div class="caption"><i class="icon-globe"></i> <%= groupName %> - <%=Resources.Resource.groupMembers %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div id="divSuccessMsg2" class="alert alert-success hide">
                            <span id="spnSuccessMsg2"><%=Resources.Resource.formErrors %></span>
                        </div>
                        <div id="divErrorMsg2" class="alert alert-error hide">
                            <span id="spnErrorMsg2"><%=Resources.Resource.formErrorsRemoved %></span>
                        </div>
                        <div class="clearfix">                            
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="Span2" runat="server">
                                    <a id="btnAdd" onclick="return Clear()" href="#portlet-config" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                </span>
                                <span id="spnDeleteButton" runat="server">
                                    <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                </span>
                            </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_Members">
                            <thead>
                              <tr style="background-color: #e8e3e3;">
                                 <th style="text-align: center; "><input type="checkbox" class="group-checkable" data-set="#sample_Members .checkboxes" /></th>
                                 <th style="text-align: center; "><%=Resources.Resource.number %></th>
                                 <th style="text-align: center; "><%=Resources.Resource.name %></th>
                                 <th style="text-align: center; " class="hidden-480"><%=Resources.Resource.designation %></th>
                                 <th style="text-align: center; " class="hidden-480"><%=Resources.Resource.organization %></th>
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

        <div id="divHiddenValues" runat="server" style="display: none">
            <span id="spnGID">0</span>&nbsp;
        </div>

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
           //TableManaged.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liEmp").addClass("active");
           $("#liEmp .arrow").addClass("open");
           $("#liGroup").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

           LoadOrganizations();
           $("#ddOrg").change(function () {
               var oTable = $('#sample_Employees').dataTable({
                   "bProcessing": true,
                   "bServerSide": true,
                   "bDestroy": true,
                   "sPaginationType": "bootstrap",
                   "aoColumns": [
                     { "bSortable": false, sWidth: "5%" },
                     { "bSortable": true, sWidth: "5%" },
                     { "bSortable": true, sWidth: "30%" },
                     { "bSortable": true, sWidth: "30%" },
                     { "bSortable": true, sWidth: "30%" }
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
                   "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/AssignGroupMemberPage.aspx?key=getAllEmployeesByOrgIDGroupID&orgID=" ) %>' + $("#ddOrg").val() + '&groupID=<%= gID %>'
               });
           });

           LoadMemberGrid(false);

           $('#sample_Members .group-checkable').change(function () {
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

           $('#sample_Employees .group-checkable').change(function () {
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
               if (name == "TAMSR2_GroupMembers") {
                   ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_GroupMembers', '');
                   // Clear text box and reset focus for next comment. 
               });
           });

       });

       function LoadMemberGrid(filter) {
           var url = '<%= Page.ResolveClientUrl("~/RequestPages/AssignGroupMemberPage.aspx?key=getAllMembersByOrgIDGroupID&orgID=" ) %>' + $("#ddOrg").val() + '&groupID=<%= gID %>';

           var filterValue = "";
           if (filter == true) {
               filterValue = $("#txt_sample_Members_filter").val();
               $("#sample_Members_filter label input").val(filterValue);
           }
           url += "&sSearchFilter=" + filterValue;

           ////////Get Employees not in Group and load in grid/////////
           var oTableMembers = $('#sample_Members').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                     { "bSortable": false, sWidth: "5%" },
                     { "bSortable": true, sWidth: "5%" },
                     { "bSortable": true, sWidth: "30%" },
                     { "bSortable": true, sWidth: "30%" },
                     { "bSortable": true, sWidth: "30%" }
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

           $("#sample_Members_filter input").css("display", "none");
           $("txt_sample_Members_filter").css("display", "");
           $("#sample_Members_filter label").append("<input id='txt_sample_Members_filter' value='' style='display: inline-block; margin-bottom: 0; border-color: rgba(82, 168, 236, 0.8); box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(82, 168, 236, 0.6); outline: 0 none;' />");
           if (filter == true) {
               $("#txt_sample_Members_filter").val(filterValue);
               $("#sample_Members_filter label input").val(filterValue);
           }
           $("#txt_sample_Members_filter").keyup(function (e) {
               //alert(e.keyCode);
               if (e.keyCode == 13) {
                   //alert($("#txt_sample_Members_filter").val());
                   //alert($("#sample_Members_filter label input").val());
                   filterValue = $("#txt_sample_Members_filter").val();
                   $("#sample_Members_filter label input").val(filterValue);
                   $("#txt_sample_Members_filter").val(filterValue);
                   LoadMemberGrid(true);//$('#sample_Members').dataTable().fnDraw();
                   //alert($("#sample_Members_filter label input").val());
               }
           });

       }

       function LoadEmployeeGrid(filter) {
           var url = '<%= Page.ResolveClientUrl("~/RequestPages/AssignGroupMemberPage.aspx?key=getAllEmployeesByOrgIDGroupID&orgID=" ) %>' + $("#ddOrg").val() + '&groupID=<%= gID %>';
           var filterValue = "";
           if (filter == true) {
               filterValue = $("#txt_sample_Employees_filter").val();
               $("#sample_Employees_filter label input").val(filterValue);
           }
           url += "&sSearchFilter=" + filterValue;

           ////////Get Employees not in Group and load in grid/////////
           var oTableEmployee = $('#sample_Employees').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                     { "bSortable": false, sWidth: "5%" },
                     { "bSortable": true, sWidth: "5%" },
                     { "bSortable": true, sWidth: "30%" },
                     { "bSortable": true, sWidth: "30%" },
                     { "bSortable": true, sWidth: "30%" }
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

           $("#sample_Employees_filter input").css("display", "none");
           $("txt_sample_Employees_filter").css("display", "");
           $("#sample_Employees_filter label").append("<input id='txt_sample_Employees_filter' value='' style='display: inline-block; margin-bottom: 0; border-color: rgba(82, 168, 236, 0.8); box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(82, 168, 236, 0.6); outline: 0 none;' />");
           if (filter == true) {
               $("#txt_sample_Employees_filter").val(filterValue);
               $("#sample_Employees_filter label input").val(filterValue);
           }
           $("#txt_sample_Employees_filter").keyup(function (e) {
               //alert(e.keyCode);
               if (e.keyCode == 13) {
                   //alert($("#txt_sample_Employees_filter").val());
                   //alert($("#sample_Employees_filter label input").val());
                   filterValue = $("#txt_sample_Employees_filter").val();
                   $("#sample_Employees_filter label input").val(filterValue);
                   $("#txt_sample_Employees_filter").val(filterValue);
                   LoadEmployeeGrid(true);//$('#sample_Employees').dataTable().fnDraw();
                   //alert($("#sample_Employees_filter label input").val());
               }
           });

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

       function ReloadGrid() {
           $('#sample_Members').dataTable().fnDraw();
           $('#sample_Employees').dataTable().fnDraw();
       }

       function CloseForm() {
           Clear();
           ReloadGrid();
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

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");

           $("#spnGridMsg").html("&nbsp;");
           $("#spnID").html("0");
           $("#txtDescriptionEn").val("");
           $("#txtDescriptionAr").val("");
           $("#txtMaxPermissions").val("");
           $("#txtMaxMinutes").val("");
           $("#txtTcn").val("");
           $("#txtCode").val("");

           $('#ddOrg option[value=""]').attr('selected', 'selected');
           $("#ddOrg").trigger("liszt:updated");
           //$("#txtCategory").val("");
           //$("#txtService").val("");
           LoadEmployeeGrid(false);
       }

       function SaveGroupMembers() {
           var v = "key=assignGroupMembers&groupID=<%= gID %>&";

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");

           var k = 0;
           $("#sample_Employees tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   k++;
                   v += "chk" + k + "=" + this.value + "&";
                   //this.checked = chk.checked;
               }
           });
           v += "count=" + k;

           if (k == 0) {
               $("#divErrorMsg").css("display", "block");
               $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
               return;
           }
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/AssignGroupMemberPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg").css("display", "block");
                           $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                           $('#btnBroadCast').click();
                           ReloadGrid();
                       }
                       else {
                           $("#divErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                       }
                   },
                   error: function (html) {

                   }
               });
       }

       function Delete() {
           var v = "key=removeGroupMembers&groupID=<%= gID %>&";

           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           var k = 0;
           $("#sample_Members tbody").find("input:checkbox").each(function () {
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
                   url: '<%= Page.ResolveClientUrl("~/RequestPages/AssignGroupMemberPage.aspx") %>',
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
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
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

       function Save() {
           var id = $("#spnID").html();
           var descriptionEn = $("#txtDescriptionEn").val();
           var descriptionAr = $("#txtDescriptionAr").val();
           var maxPermissions = $("#txtMaxPermissions").val();
           var maxMinutes = $("#txtMaxMinutes").val();
           var tcn = $("#txtTcn").val();
           var code = $("#txtCode").val();
           var orgID = $("#ddOrg").val();
           var groupApply = $("#chkboxGroupApply").is(":checked");
           var official = $("#chkboxOfficial").is(":checked");
           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }
           var v = "key=save" + "&id=" + id + "&code=" + code + "&orgID=" + orgID + "&groupApply=" + groupApply;
           v += "&descriptionEn=" + descriptionEn + "&descriptionAr=" + descriptionAr;
           v += "&maxPermissions=" + maxPermissions + "&maxMinutes=" + maxMinutes + "&tcn=" + tcn + "&official=" + official;

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
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
                       LoadOrganizations();
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
