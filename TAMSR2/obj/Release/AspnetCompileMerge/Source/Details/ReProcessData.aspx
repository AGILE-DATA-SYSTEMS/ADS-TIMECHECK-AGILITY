<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReProcessData.aspx.cs" Inherits="TAMSR2.Details.ReProcessData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.reprocessData %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
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

            
            <!-- START LIGHT BOX ERROR/MESSAGE -->
            <a data-toggle="modal" id="btnAlertError" style="display: none;" class="btn btn-danger" role="button" href="#msgAlertError"><%=Resources.Resource.error %></a>
            <div id="msgAlertError" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h3 id="H1"><%=Resources.Resource.error %></h3>
                </div>
                <div class="modal-body">
                    <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
                </div>
            </div>
            <a data-toggle="modal" id="btnAlertMessage" style="display: none;" class="btn btn-danger" role="button" href="#myModal2"><%=Resources.Resource.success %></a>
            <div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h3 id="myModalLabel2"><%=Resources.Resource.message %></h3>
                </div>
                <div class="modal-body">
                    <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
                </div>
            </div>
            <a data-toggle="modal" id="btnApproveRejectPopup" style="display: none;" class="btn btn-danger" role="button" href="#divVerificationForm"><%=Resources.Resource.reprocessData %></a>
            <div id="divVerificationForm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="divVerificationForm" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h3 id="H2"><%=Resources.Resource.reprocessData %></h3>
                </div>
                <div class="modal-body">
                    <div class="">
                        <div class="control-group">
                            <div style="clear: both; display: inline;" class="controls chzn-controls">
                                <label class="control-label" ><%=Resources.Resource.reprocessdataalert %></label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <img src="../Assets/En/img/ajax-loading.gif"  id="loading" style="display:none;"/>
                    <button onclick="return VerificationAproveReject('yes')" class="btn icn-only green"><%=Resources.Resource.yes %></button>
                    <%--<button onclick="return VerificationAproveReject('reject')" class="btn icn-only red"><%=Resources.Resource.reject %></button>--%>
                    <button id="btnHideVerificationPopup" data-dismiss="modal" class="btn danger"><%=Resources.Resource.no %></button>
                </div>
            </div>
            <!-- END   LIGHT BOX ERROR/MESSAGE -->


                  <!-- BEGIN PAGE TITLE & BREADCRUMB-->			
			<h3 class="page-title">
									<%=Resources.Resource.reprocessData %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a>
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.report %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.reprocessData %></a></li>					
						
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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.reprocessData %></div>
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
                            <div class="span9">
                                <div class="span6">
                                    <div class="control-group">
                                        <label class="control-label" style="clear: both; width: 100px !important; display: inline; float: left"><%=Resources.Resource.organization %> <span class="required">*</span></label>
                                        <div style="clear: both; display: inline;" class="controls chzn-controls">
                                            <select id="ddOrganizations" tabindex="1" data-placeholder="Choose Organization" class="span6 chosen" name="sex" style="width: 220px;">
                                                
                                            </select>
                                            <br>
                                            <br>
                                        </div>
                                    </div>
                                </div>
                                <div class="span6">
                                    <div class="control-group">
                                        <label class="control-label" style="clear: both; width: 100px !important; display: inline; float: left"><%=Resources.Resource.employee %> <span class="required">*</span></label>
                                        <div style="clear: both; display: inline;" class="controls chzn-controls">
                                            <select id="ddEmployees" tabindex="2" data-placeholder="Choose Employee" class="span6 chosen" name="sex" style="width: 220px;">
                                               
                                            </select>
                                            <br>
                                            <br>
                                        </div>
                                    </div>
                                </div>
                                </div>
                                <div class="span9">
                                    <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label" style="clear: both; width: 100px !important; display: inline; float: left"><%=Resources.Resource.fromDate %> <span class="required">*</span></label>
                                                <div style="clear: both; display: inline;" class="controls chzn-controls">
                                                    <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                                </div>
                                            </div>
                                        </div>
                                     <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label" style="clear: both; width: 100px !important; display: inline; float: left"><%=Resources.Resource.toDate %> <span class="required">*</span></label>
                                                <div style="clear: both; display: inline;" class="controls chzn-controls">
                                                    <input id="txtToDate" name="todate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value=""  />
                                                </div>
                                            </div>
                                        </div>
                            </div>
                            <div class="span9">
                                <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label" style="clear: both; width: 100px !important; display: inline; float: left"><%=Resources.Resource.deleteverifications %> </label>
                                                <div style="clear: both; display: inline;" class="controls chzn-controls">
                                                   <input type="checkbox" ID="chkVerifications" class="checkbox" />
                                                </div>
                                            </div>
                                        </div>
                            </div>
                            <div class="span12">
                                <div class="spna6 btn-group pull-<%= pullDirectionStr %>" style="padding-right: 30px ! important;">
                                    <span id="spnApproveButton" runat="server">
                                        <a id="btnApprove" onclick="return VerificationTakeAction()" class="label label-important label-mini">&nbsp; <%=Resources.Resource.takeAction %> <i class="icon-share-alt"></i></a>
                                    </span>
                                </div>
                            </div>

                       
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
   
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>   
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>           
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
         //  FormValidation.init();

           FormComponents.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liRpt").addClass("active");
           $("#liRpt .arrow").addClass("open");
           $("#liReprocessData").addClass("active");

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
               if (name == "TAMSR2_Emp_Reprocesdata") {
                  // ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_Emp_Reprocesdata', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
           LoadEmployeeList();
           LoadOrganizations();
       });


       function imposeMaxLength(Object, evt, MaxLen) {
           var charCode = (evt.which) ? evt.which : evt.keyCode;
           if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
           return (Object.value.length < MaxLen);
       }

       function VerificationTakeAction() {
        var org =  $("#ddOrganizations").val();
        var emp = $("#ddEmployees").val();
        var fdate = $("#txtFromDate").val();
        var tdate = $("#txtToDate").val();
        

      //  alert(fdate);
         if (org == "" && emp == "") {
              $("#divErrorMsg2").css("display", "block");
               $("#spnErrorMsg2").html("<%=Resources.Resource.selectOneEmployee  %>");
               return;
           }
         else if (fdate == "" ) {
             $("#divErrorMsg2").css("display", "block");
             $("#spnErrorMsg2").html("<%=Resources.Resource.selectfromdate %>");
              return;
         }
         else if (tdate == "") {
             $("#divErrorMsg2").css("display", "block");
             $("#spnErrorMsg2").html("<%=Resources.Resource.selecttodate  %>");
             return;
         }
         else if (tdate < fdate) {
             $("#divErrorMsg2").css("display", "block");
             $("#spnErrorMsg2").html("To Date should be greater than or equal to From Date");
              return;
         }
         else
             $("#btnApproveRejectPopup").click();
           return;
       }

       function VerificationAproveReject(approveReject) {
           $('#loading').show();
           var delverifications
           if ($("#chkVerifications").prop('checked') == true)
                delverifications = 1;
           else
               delverifications = 0;
           var fromDate;
           var toDate;
           if ($("#txtFromDate").val() != "") {
               var str1 = $("#txtFromDate").val().split('-');
               fromDate = str1[2] + '-' + str1[1] + '-' + str1[0];
           }
           if ($("#txtToDate").val() != "") {
               var str2 = $("#txtToDate").val().split('-');
               toDate = str2[2] + '-' + str2[1] + '-' + str2[0];
           }
         //  alert(date);
           var v = "key=ReprocessData&OrganizationID=" + $("#ddOrganizations").val() + "&EmployeeID=" + $("#ddEmployees").val();
           v += "&FromDate=" +fromDate + "&ToDate="  + toDate + "&DeleteVerifications=" +delverifications;
         //  alert($("#txtFromDate").val());
           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");
          
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/DataReprocessPage.aspx") %>',
               success: function (html) {
                   if (html == "1") {

                       $("#btnHideVerificationPopup").click();
                       $("#uniform-chkVerifications").find("span").removeClass("checked");
                       
                       $("#divSuccessMsg").css("display", "block");
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgDataProcessSuccessfully %>");
                       $("#btnAlertMessage").click();
                       $("#txtFromDate").val("");
                       $("#txtToDate").val("");
               
                      LoadEmployeeList();
                      LoadOrganizations();
                      $('#loading').hide();
                   }
                   else {
                       $("#btnHideVerificationPopup").click();
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgDataProcessFailed %>");
                       $("#btnAlertError").click();
                   }
               },
               error: function (html) {

               }
           });

       }


       var FormComponents = function () {

           var handlejQueryUIDatePickers = function () {
               $(".ui-date-picker").datepicker();

           }

           var handleDateTimePickers = function () {

               if (jQuery().datepicker) {
                   $('#txtFromDate').datepicker({ format: 'dd-mm-yyyy'});
                   $('#txtToDate').datepicker({ format: 'dd-mm-yyyy' })
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
                   handlejQueryUIDatePickers();
                   handleDateTimePickers(); 
               }

           };

       }();
       ////////END OF FORM COMPONENTS////////

       function LoadOrganizations() {
           var d = "key=getIdNameListString"; 
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    $("#ddOrganizations").html(html);
                    $("#ddOrganizations").trigger("liszt:updated"); 
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>"); 
                }
            });
        }

       function LoadEmployeeList() {
           var d = "key=getIdNameListString"; 
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                success: function (html) { 
                    $("#ddEmployees").html(html);
                    $("#ddEmployees").trigger("liszt:updated"); 
                },
                error: function (html) { 
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>"); 
                }
            });
        }


   </script>
   <!-- END JAVASCRIPTS -->
    
</asp:Content>
