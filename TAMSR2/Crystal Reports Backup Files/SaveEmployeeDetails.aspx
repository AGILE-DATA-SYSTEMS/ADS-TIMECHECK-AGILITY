<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveEmployeeDetails.aspx.cs" Inherits="TAMSR2.Details.SaveEmployeeDetails" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.employeeDetails %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
   <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
   <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
   <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
    <!-- END PAGE LEVEL STYLES -->
    
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
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
									<%=Resources.Resource.employeeDetails %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Default.aspx") %>' ><%=Resources.Resource.home %></a> 
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href='<%= Page.ResolveClientUrl("~/Details/ViewEmployee.aspx") %>'><%=Resources.Resource.employee %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href='#' ><%=Resources.Resource.employeeDetails %></a></li>					
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12">
                  
                  <!-- BEGIN SAMPLE FORM PORTLET-->   
                  <div class="portlet box blue tabbable">
                     <div class="portlet-title">
                        <div class="caption">
                           <i class="icon-reorder"></i>
                           <span class="hidden-480">General Layouts</span>
                        </div>
                     </div>
                     <div class="portlet-body form">

                        <div class="tabbable portlet-tabs">
                           <ul class="nav nav-tabs">
                              <li><a href="#portlet_tab3" data-toggle="tab">Basic</a></li>
                              <li><a href="#portlet_tab2" data-toggle="tab">Business</a></li>
                              <li class="active"><a href="#portlet_tab1" data-toggle="tab">Personal</a></li>
                           </ul>
                           <div class="tab-content">
                              <div class="tab-pane active" id="portlet_tab1">
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
                                         <select id="ddOrg" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>" tabindex="1">
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
                                      <label class="control-label"><%=Resources.Resource.salutationEn %></label>
                                      <div class="controls">
                                         <input type="text" id="txtSalutationEn" name="salutationEn" class="span6 m-wrap"/>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.salutationAr %></label>
                                      <div class="controls">
                                         <input type="text" id="txtSalutationAr" name="salutationAr" class="span6 m-wrap"/>
                                      </div>
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
                                         <input type="text" id="txtNameAr" name="nameAr" class="span6 m-wrap"/>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.sex %><span class="required">*</span></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddSex" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.sex %>" tabindex="1">
                                            <option value=""></option>
                                            <option value="0"><%=Resources.Resource.male %> </option>
                                            <option value="1"><%=Resources.Resource.female %> </option>
                                         </select>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.cardNo %> </label>
                                      <div class="controls">
                                         <input type="text" id="txtCardNo" name="cardNo" class="span6 m-wrap"/>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.pin %> </label>
                                      <div class="controls">
                                         <input type="text" id="txtPIN" name="pin" class="span6 m-wrap"/>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.email %> </label>
                                      <div class="controls">
                                         <input type="text" id="txtEmail" name="email" class="span6 m-wrap"/>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.joinDate %> </label>
                                      <div class="controls">
                                          <input id="txtJoinDate" name="joindate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.inactiveDate %> </label>
                                      <div class="controls">
                                          <input id="txtInactiveDate" name="inactivedate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.remarks %> </label>
                                      <div class="controls">
                                         <input type="text" id="txtRemarks" name="remarks" class="span6 m-wrap"/>
                                      </div>
                                   </div>
                                </form>
                                <!-- END FORM-->
                              </div>
                              <div class="tab-pane " id="portlet_tab2">
                                <form action="#" id="form1" class="form-horizontal">
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.employeeType %><span class="required">*</span></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddEmpType" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employeeType %>" tabindex="1">
                                            <option value=""></option>
                                         </select>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.manager %><span class="required">*</span></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddMgr" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.manager %>" tabindex="1">
                                            <option value=""></option>
                                         </select>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.nationality %><span class="required">*</span></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddCountry" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.nationality %>" tabindex="1">
                                            <option value=""></option>
                                         </select>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.grade %><span class="required">*</span></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddGrade" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.grade %>" tabindex="1">
                                            <option value=""></option>
                                         </select>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.designation %><span class="required">*</span></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddDesig" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.designation %>" tabindex="1">
                                            <option value=""></option>
                                         </select>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.schedule %><span class="required">*</span></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddSch" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                                            <option value=""></option>
                                         </select>
                                      </div>
                                   </div>
                                   <div class="control-group">
                                      <label class="control-label"><%=Resources.Resource.region %><span class="required">*</span></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddRegion" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.region %>" tabindex="1">
                                            <option value=""></option>
                                         </select>
                                      </div>
                                   </div>
                                    </form>
                              </div>
                              <div class="tab-pane " id="portlet_tab3">
                                <form action="#" id="form2" class="form-horizontal">
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxMgr" type="checkbox" name="groupApply" /> <%=Resources.Resource.manager %>
                                       </div>
                                   </div>
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxActive" type="checkbox" name="official" /> <%=Resources.Resource.active %>
                                       </div>
                                   </div>
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxLocal" type="checkbox" name="official" /> <%=Resources.Resource.local %>
                                       </div>
                                   </div>  
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxPunch" type="checkbox" name="official" /> <%=Resources.Resource.punch %>
                                       </div>
                                   </div>
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxShift" type="checkbox" name="official" /> <%=Resources.Resource.shift %>
                                       </div>
                                   </div>
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxOvertime" type="checkbox" name="official" /> <%=Resources.Resource.overtime %>
                                       </div>
                                   </div>
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxOnReport" type="checkbox" name="official" /> <%=Resources.Resource.onReport %>
                                       </div>
                                   </div>
                                   <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxInPayroll" type="checkbox" name="official" /> <%=Resources.Resource.inpayroll %>
                                       </div>
                                   </div>
                                 </form>
                              </div>
                               <div class="form-actions">
                                   <span id="spnID" style="display: none;">0</span>
                                   <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                                   <button id="btnSave" type="button" onclick="Save()" class="btn purple"><%=Resources.Resource.save %></button>
                                   <button type="button" onclick="CloseForm()" class="btn"><%=Resources.Resource.cancel %></button>
                                   <button type="reset" id="btnCloseForm" style="display: none;" data-dismiss="modal" class="btn"><%=Resources.Resource.close %></button>
                               </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- END SAMPLE FORM PORTLET-->
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
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>   
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script> 
   
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
       var tempOrg = false;
       var tempLoc = false;
       $(document).ready(function () {
           App.init(); // initlayout and core plugins
           FormValidation.init();
           FormComponents.init();
           //TableManaged.init();

           GetQueryString();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#liEmp").addClass("active");
           $("#liEmp .arrow").addClass("open");
           $("#liEmpEmployee").addClass("active");


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
               if (name == "TAMSR2_ScheduleTime") {
                   //ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_ScheduleTime', '');
                   // Clear text box and reset focus for next comment. 
               });
           });

           LoadOrganizations();
           LoadEmployeeTypes();
           LoadManagerList();
           LoadCountries();
           LoadGrades();
           LoadDesignations();
           LoadSchedules();
           LoadRegions();

       });

       function GetQueryString() {
           ; (function ($) {
               $.extend({
                   getQueryString: function (name) {
                       function parseParams() {
                           var params = {},
                               e,
                               a = /\+/g,  // Regex for replacing addition symbol with a space
                               r = /([^&=]+)=?([^&]*)/g,
                               d = function (s) { return decodeURIComponent(s.replace(a, " ")); },
                               q = window.location.search.substring(1);

                           while (e = r.exec(q))
                               params[d(e[1])] = d(e[2]);

                           return params;
                       }

                       if (!this.queryStringParams)
                           this.queryStringParams = parseParams();

                       return this.queryStringParams[name];
                   }
               });
           })(jQuery);
       } ///////////////////////////////END OF FUNCTION GetQueryString/////////////////////////////////////////

       function LoadOrganizations() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   $("#ddOrg").html(html);
                   $("#ddOrg").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var org = $.getQueryString('org') + "";
                   //tempOrg = true;
                   //if (sch != "" && tempLoc == true) {
                   //    Edit(sch);
                   //}
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadEmployeeTypes() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeTypePage.aspx") %>',
               success: function (html) {
                   $("#ddEmpType").html(html);
                   $("#ddEmpType").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var empType = $.getQueryString('empType') + "";
                   //tempLoc = true;
                   //if (sch != "" && tempOrg == true) {
                   //    Edit(sch);
                   //}
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadManagerList() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   $("#ddMgr").html(html);
                   $("#ddMgr").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var mgr = $.getQueryString('mgr') + "";
                   //tempLoc = true;
                   //if (sch != "" && tempOrg == true) {
                   //    Edit(sch);
                   //}
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadCountries() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/CountryPage.aspx") %>',
               success: function (html) {
                   $("#ddCountry").html(html);
                   $("#ddCountry").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var country = $.getQueryString('cnt') + "";
                   //tempLoc = true;
                   //if (sch != "" && tempOrg == true) {
                   //    Edit(sch);
                   //}
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadGrades() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/GradePage.aspx") %>',
               success: function (html) {
                   $("#ddGrade").html(html);
                   $("#ddGrade").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var grade = $.getQueryString('grd') + "";
                   //tempLoc = true;
                   //if (sch != "" && tempOrg == true) {
                   //    Edit(sch);
                   //}
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
               url: '<%= Page.ResolveClientUrl("../RequestPages/DesignationPage.aspx") %>',
               success: function (html) {
                   $("#ddDesig").html(html);
                   $("#ddDesig").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var desig = $.getQueryString('desig') + "";
                   //tempLoc = true;
                   //if (sch != "" && tempOrg == true) {
                   //    Edit(sch);
                   //}
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadSchedules() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleTypePage.aspx") %>',
               success: function (html) {
                   $("#ddSch").html(html);
                   $("#ddSch").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var sch = $.getQueryString('sch') + "";
                   //tempLoc = true;
                   //if (sch != "" && tempOrg == true) {
                   //    Edit(sch);
                   //}
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

       function LoadRegions() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/RegionPage.aspx") %>',
               success: function (html) {
                   $("#ddRegion").html(html);
                   $("#ddRegion").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var rgn = $.getQueryString('rgn') + "";
                   //tempLoc = true;
                   //if (sch != "" && tempOrg == true) {
                   //    Edit(sch);
                   //}
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

       function Clear() {
           $('#form_sample_1')
               .closest('.control-group').removeClass('error'); // set error class to the control group
           $(':input', '#form_sample_1')
            .not(':button, :submit, :reset, :hidden')
            .val('')
            .removeAttr('checked')
            .removeAttr('selected');

           $("#spnGridMsg").html("&nbsp;");
           $("#spnID").html("0");
           $("#txtCode").val("");
           $("#txtSalutationEn").val("");
           $("#txtSalutationAr").val("");
           $("#txtNameEn").val("");
           $("#txtNameAr").val("");
           $("#txtCardNo").val("");
           $("#txtPIN").val("");
           $("#txtEmail").val("");
           $("#txtRemarks").val("");

           $('#ddSex option[value=""]').attr('selected', 'selected');
           $("#ddSex").trigger("liszt:updated");
           $('#ddOrg option[value=""]').attr('selected', 'selected');
           $("#ddOrg").trigger("liszt:updated");
           $('#ddEmpType option[value=""]').attr('selected', 'selected');
           $("#ddEmpType").trigger("liszt:updated");
           $('#ddMgr option[value=""]').attr('selected', 'selected');
           $("#ddMgr").trigger("liszt:updated");
           $('#ddCountry option[value=""]').attr('selected', 'selected');
           $("#ddCountry").trigger("liszt:updated");
           $('#ddGrade option[value=""]').attr('selected', 'selected');
           $("#ddGrade").trigger("liszt:updated");
           $('#ddDesig option[value=""]').attr('selected', 'selected');
           $("#ddDesig").trigger("liszt:updated");
           $('#ddSch option[value=""]').attr('selected', 'selected');
           $("#ddSch").trigger("liszt:updated");
           $('#ddRegion option[value=""]').attr('selected', 'selected');
           $("#ddRegion").trigger("liszt:updated");

           $("#chkboxMgr").removeAttr("checked");
           $("#uniform-chkboxMgr span").removeClass("checked");
           $("#chkboxActive").removeAttr("checked");
           $("#uniform-chkboxActive span").removeClass("checked");
           $("#chkboxLocal").removeAttr("checked");
           $("#uniform-chkboxLocal span").removeClass("checked");
           $("#chkboxShift").removeAttr("checked");
           $("#uniform-chkboxShift span").removeClass("checked");
           $("#chkboxOvertime").removeAttr("checked");
           $("#uniform-chkboxOvertime span").removeClass("checked");
           $("#chkboxOnReport").removeAttr("checked");
           $("#uniform-chkboxOnReport span").removeClass("checked");
           $("#chkboxInPayroll").removeAttr("checked");
           $("#uniform-chkboxInPayroll span").removeClass("checked");

       }

       function Edit(id) {
           //Edit code
           //    txtCode txtSalutationEn txtSalutationAr txtNameEn txtNameAr txtCardNo txtPIN txtEmail txtRemarks
           //      ddSex   ddOrg   ddEmpType   ddMgr  ddCountry  ddGrade  ddDesig  ddSch  ddRegion
           //      chkboxMgr   chkboxActive   chkboxLocal  chkboxShift  chkboxOvertime  chkboxOnReport  chkboxInPayroll
           var v = "key=getByID&id=" + id;
           $("#btnAdd").click();
           $("#spnGridMsg").html("&nbsp;");
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/SchedulePage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       $("#spnID").val(j.ID);
                       if (j.ID == "0") {
                           $("#spnID").html(j.ID);
                           return;
                       }
                       $("#txtInTime1").val(j.InTime1);
                       $("#txtOutTime1").val(j.OutTime1);
                       $("#txtInTime2").val(j.InTime2);
                       $("#txtOutTime2").val(j.OutTime2);
                       $("#txtInTime3").val(j.InTime3);
                       $("#txtOutTime3").val(j.OutTime3);

                       $("#txtCode").val(j.Code);
                       $("#txtColor").val(j.SchColor);

                       $("#txtFlexible").val(j.FlexibleMinutes);
                       $("#txtGraceIn").val(j.GraceInMinutes);
                       $("#txtGraceOut").val(j.GraceOutMinutes);

                       $('#ddOrg option[value=' + j.OrgID + ']').attr('selected', 'selected');
                       $("#ddOrg").trigger("liszt:updated");
                       $('#ddSchLocation option[value=' + j.SchLocationID + ']').attr('selected', 'selected');
                       $("#ddSchLocation ").trigger("liszt:updated");

                       if (j.OpenShift + "" == "1") {
                           $("#chkboxOpenShift").attr("checked", "checked");
                           $("#uniform-chkboxOpenShift span").addClass("checked");
                       }
                       if (j.NightShift + "" == "1") {
                           $("#chkboxNightShift").attr("checked", "checked");
                           $("#uniform-chkboxNightShift span").addClass("checked");
                       }
                   }
               },
               error: function (html) {

               }
           });
       }

       function Save() {
           
           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           //    txtCode txtSalutationEn txtSalutationAr txtNameEn txtNameAr txtCardNo txtPIN txtEmail txtRemarks
           //      ddSex   ddOrg   ddEmpType   ddMgr  ddCountry  ddGrade  ddDesig  ddSch  ddRegion
           //      chkboxMgr   chkboxActive   chkboxLocal  chkboxShift  chkboxOvertime  chkboxOnReport  chkboxInPayroll

           var id = $("#spnID").html(); //$.getQueryString('sch') + "";
           var orgID = $("#ddOrg").val();
           var sex = $("#ddSex").val();
           var code = $("#txtCode").val();
           var salEn = $("#txtSalutationEn").val();
           var salAr = $("#txtSalutationAr").val();
           var nameEn = $("#txtNameEn").val();
           var nameAr = $("#txtNameAr").val();
           var card = $("#txtCardNo").val();
           var pin = $("#txtPIN").val();
           var email = $("#txtEmail").val();
           var join = $("#txtJoinDate").val();
           var inactive = $("#txtInactiveDate").val();
           var remarks = $("#txtRemarks").val();

           var empType = $("#ddEmpType").val();
           var mgr = $("#ddMgr").val();
           var cnt = $("#ddCountry").val();
           var grd = $("#ddGrade").val();
           var desig = $("#ddDesig").val();
           var sch = $("#ddSch").val();
           var rgn= $("#ddRegion").val();

           var ismgr = $("#chkboxMgr").is(":checked");
           var active = $("#chkboxActive").is(":checked");
           var local = $("#chkboxLocal").is(":checked");
           var shift = $("#chkboxShift").is(":checked");
           var overtime = $("#chkboxOvertime").is(":checked");
           var onreport = $("#chkboxOnReport").is(":checked");
           var inpayroll = $("#chkboxInPayroll").is(":checked");

           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }
           var v = "key=save" + "&id=" + id + "&code=" + code + "&salEn=" + salEn + "&salAr=" + salAr + "&nameEn=" + nameEn;
           v += "&nameAr=" + nameAr + "&card=" + card + "&pin=" + pin + "&email=" + email + "&empType=" + empType + "&mgr=" + mgr;
           v += "&orgID=" + orgID + "&cnt=" + cnt + "&grd=" + grd + "&desig=" + desig + "&sch=" + sch + "&rgn=" + rgn + "&photo=" + "" + "&sex=" + sex;
           v += "&ismgr=" + ismgr + "&active=" + active + "&local=" + local + "&shift=" + shift + "&overtime=" + overtime;
           v += "&onreport=" + onreport + "&inpayroll=" + inpayroll + "&join=" + join + "&inactive=" + txtInactiveDate + "&remarks=" + remarks;

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
              success: function (html) {
                  if (html == '-1') {
                      //failed
                      $("#divErrorMsg").css("display", "block");
                      $("#spnErrorMsg").html("Error! Record not saved successfully.");
                  }
                  else if (html == '0') {
                      //exists
                      $("#divErrorMsg").css("display", "block");
                      $("#spnErrorMsg").html("Error! User already exists in database.");
                  }
                  else {
                      //success
                      $("#divSuccessMsg").css("display", "block");
                      $("#spnSuccessMsg").html("Sucessfully saved in database.");
                      $('#btnBroadCast').click();
                      if ($.getQueryString('sch') + "" != "") {
                          window.location = '<%= Page.ResolveClientUrl("../Details/ViewEmployees.aspx") %>';
                   }
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

               $("#txtJoinDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
               $("#txtInactiveDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
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
                    org: {
                        required: true
                    },
                    code: {
                        required: true
                    },
                    nameEn: {
                        minlength: 2,
                        required: true
                    },
                    nameAr: {
                        minlength: 2,
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    code: {
                        required: "Pease enter employee code"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.attr("name") == "org" || element.attr("name") == "schLocation") { // for uniform checkboxes, insert the after the given container
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
