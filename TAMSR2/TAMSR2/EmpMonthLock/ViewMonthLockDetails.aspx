<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewMonthLockDetails.aspx.cs" Inherits="TAMSR2.EmpMonthLock.ViewMonthLockDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.monthLock %>   <%=Resources.Resource.details %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>plugins/bootstrap-fileupload/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
    <!-- END PAGE LEVEL STYLES -->
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM--> 
     <div id="divVerificationForm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="divVerificationForm" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h3 id="H2"><%=Resources.Resource.alert %></h3>
        </div>
        <div class="modal-body">
            <div id="spnVerification" style="font-size: 12px;"><%=Resources.Resource.intendedZeroValues %></div>
        </div>
        <div class="modal-footer">
            <button onclick="return SetIntendedValueFlag()" class="btn icn-only green"><%=Resources.Resource.yes %></button>
            <button id="btnHideVerificationPopup" data-dismiss="modal" class="btn danger"><%=Resources.Resource.no %></button>
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
                    <%=Resources.Resource.monthLock %>   <%=Resources.Resource.details %>
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href='<%= Page.ResolveClientUrl("~/Freeze/Month-Lock") %>'><%=Resources.Resource.monthLock %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.monthLock %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12"> 
                 <!-- BEGIN FORM-->
                <form action="#" id="form_1" class="form-horizontal"  >
                    <div id="divErrorMsg" class="alert alert-error hide">
                        <button class="close" data-dismiss="alert"></button>
                        <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                    </div>
                    <div id="divSuccessMsg" class="alert alert-success hide">
                        <button class="close" data-dismiss="alert"></button>
                        <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                    </div>
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                     <select id="ddOrg" name="Org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>">
                                               <option value=""></option>
                                      </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.manager %></label>
                                <div class="controls chzn-controls">
                                  
                                    <select id="ddMgr" name="manager" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.manage %>">
                                        <option value=""></option>
                                       
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row--> 
                </form>
                <!-- END FORM-->
                <div style="min-height: 20px; clear: both;">&nbsp;</div>
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.monthLock %>   <%=Resources.Resource.details %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return LoadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="Span3">&nbsp;</span>
                            </div>
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="display:none">
                                <span id="spnAddButton" runat="server">
                                    <a id="btnLock" onclick="return Lock()" href="javascript:void(0);" data-toggle="modal" class="btn green"><i class="icon-lock">&nbsp; <%=Resources.Resource.btnlock %></i></a>
                                     <a id="btnUnlock" onclick="return Unlock()" style='margin: 0px 10px;' class="btn blue"><i class="icon-unlock">&nbsp; <%=Resources.Resource.unlock %></i></a>
                                </span>
                            </div>
                        </div>
                        <div style=" overflow-y: hidden; padding: 20px 0px; max-width:100% !important;" >
                            <table class="table table-striped table-bordered table-hover" id="sample_1" style=" max-width:100% !important;">
                                <thead>
                                  <tr style="background-color: #e8e3e3;">
                                     <th style="text-align: center;width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                     <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                     <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.organization %></th>
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.rivisions %></th> 
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.status %></th>
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.updatedBy %></th>
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.updatedOn %></th> 
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.action %></th> 
                                  </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>


                        <br />

                    </div>
                </div>
                <!-- END EXAMPLE TABLE PORTLET-->

                <div style="min-height: 20px; clear: both;">&nbsp;</div>

                <div>
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
                </div>

                <div style="min-height: 20px; clear: both;">&nbsp;</div>
                <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>

            </div>
        </div>
        <!-- END PAGE CONTENT-->
        
        <div id="divHiddenValues" runat="server"  >
            <span id="spnEmp">0</span>&nbsp;
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
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>   
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script> 
   
   <script type="text/javascript" src="<%= path %>Assets/<%= languageStr %>/plugins/bootstrap-fileupload/bootstrap-fileupload.js"></script>
    
   <script type="text/javascript" src="<%= path %>Assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>




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
   <script src="<%= path %>Scripts/ajaxfileupload.js"></script>    
   <!-- START OF PAGE LEVEL SCRIPT-->

   <script type="text/javascript">
       var tempOrg = false;
       var tempLoc = false;
       var tempLoadCount = 0;
       var isIntendedValues = false;
       var requestType = "";
       var recordID = "";

       $(document).ready(function () {
           //alert(typeof String.prototype.trim);
           if (typeof String.prototype.trim != 'function') {
               String.prototype.trim = function () {
                   return this.replace(/^\s+|\s+$/g, '');
               }
           }
       });

       $(document).ready(function () { 
           App.init(); // initlayout and core plugins $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");

           $("#liMonthLockMain").addClass("active");
           $("#liMonthLockMain .arrow").addClass("open");
           $("#liMonthLock").addClass("active");
           $("#liMonthLock .arrow").addClass("open");
           $("#liMonthLock").addClass("active");

           LoadOrganizations();
           LoadGrid();


           $("#ddOrg").change(function () {
               LoadManager();
               LoadGrid();
           });

           $("#ddMgr").change(function () {
               LoadGrid();
           });


           if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
            

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
               if (name == "TAMSR2_MonthLockDetails") {
                   LoadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_MonthLockDetails', '');
                   // Clear text box and reset focus for next comment. 
               });
           });

       });


       function LoadGrid() {
           
           var id = '<%= ID %>';
           var mgr = $("#ddMgr").val();
           var org = $("#ddOrg").val();
           
           var wc = "&ID=" + id + "&mgr=" + mgr + "&org=" + org;
           var urlStr = '<%= Page.ResolveClientUrl("../RequestPages/MonthLockPage.aspx?key=getEmployeeByMonthID") %>' + wc;
      
            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false, sWidth: "5%" },
                  { "bSortable": true, sWidth: "5%" },
                  { "bSortable": true, sWidth: "25%" },
                  { "bSortable": true, sWidth: "25%" },
                  { "bSortable": true, sWidth: "2%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": false, sWidth: "8%" }
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
                "sAjaxSource": urlStr
            });
       }



       function Unlock(id) { 

           var v = "key=unlockByID&ID=" + id;
            
           if (!isIntendedValues) { 
               return;
           };

           isIntendedValues = false;

               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/MonthLockPage.aspx") %>',
                   success: function (html) {
                       if (html == "success" || html == "Success") {
                           $("#divSuccessMsg").css("display", "block");
                           $("#spnSuccessMsg").css("display", "block");
                           $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordUnlock %>");
                           $('#btnBroadCast').click();
                       }
                       else {
                           $("#spnErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html(html);
                           $("#divErrorMsg").css("display", "block");
                       }
                   },
                   error: function (html) {

                   }
               });
       }
       function Lock(id) {
            

           var v = "key=lockByID&ID=" + id;
           if (!isIntendedValues) {
               return;
           };
           isIntendedValues = false;

               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/MonthLockPage.aspx") %>',
                   success: function (html) {
                       if (html == "success" || html == "Success") {
                           $("#divSuccessMsg").css("display", "block");
                           $("#spnSuccessMsg").css("display", "block");
                           $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordLock %>");
                           $('#btnBroadCast').click();
                       }
                       else {
                           $("#spnErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html(html);
                           $("#divErrorMsg").css("display", "block");
                       }
                   },
                   error: function (html) {

                       $("#spnErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html(html);
                       $("#divErrorMsg").css("display", "block");
                   }
               });
       };


       function PreSave(id, type) {

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");
           requestType = type;
           recordID = id; 
           if (type == "unlock") {
               $("#spnVerification").html("<%=Resources.Resource.msgConfirmUnlock %>");
               $('#divVerificationForm').modal('show');
           }
           else if (type == "lock") { 
               $("#spnVerification").html("<%=Resources.Resource.msgConfirmLock %>");
               $('#divVerificationForm').modal('show');
           }
       }
       function SetIntendedValueFlag() {
           isIntendedValues = true;
           $('#divVerificationForm').modal('hide');
       }
        
       $('#divVerificationForm').on('hidden.bs.modal', function (e) {
           
           if (requestType != "" && requestType == "lock")
               Lock(recordID);
           else if(requestType != ""  && requestType == "unlock")
               Unlock(recordID); 
       })

       ////----------------------------/////////


       function LoadManager() {
           $("#spnErrorMsg").css("display", "none");
           $("#spnSuccessMsg").css("display", "none");
            
           var d = "key=getMgrIdNameListString&orgID=" + $("#ddOrg").val()  ;
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

                      
                     var d = "key=getIdNameListString";
                     $.ajax({
                         type: 'POST',
                         data: d,
                         url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                    success: function (html) {
                        $("#ddOrg").html(html);
                        $("#ddOrg").trigger("liszt:updated");
                        LoadManager();
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
                });
            }
    </script>
</asp:Content>
