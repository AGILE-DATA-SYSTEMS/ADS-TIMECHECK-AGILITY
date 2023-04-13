<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveScheduleTime.aspx.cs" Inherits="TAMSR2.Details.SaveScheduleTime" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.scheduleTimes %> - <%=Resources.Resource.applicationName %></title>
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
									<%=Resources.Resource.scheduleTimes %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Default.aspx") %>' ><%=Resources.Resource.home %></a> 
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.schedule %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href='<%= Page.ResolveClientUrl("~/Details/ViewScheduleTime.aspx") %>' ><%=Resources.Resource.scheduleTimes %></a></li>					
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12">
                  
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
                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.scheduleLocation %><span class="required">*</span></label>
                                        <div class="controls chzn-controls">
                                            <select id="ddSchLocation" name="schLocation" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row-fluid">
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                                        <div class="controls">
                                            <input type="text" id="txtCode" name="code" data-required="1" class="span8 m-wrap" />
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.color %><span class="required">*</span></label>
                                        <div class="controls">
                                            <div data-color-format="rgba" data-color="#3865a8" class="input-append color colorpicker-default">
                                                <input type="text" id="txtColor" name="color" readonly="" value="#3865a8" class="m-wrap">
                                                <span class="add-on"><i style="background-color: #3865a8;"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row-fluid">
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.inTime1 %><span class="required">*</span></label>
                                        <div class="controls">
                                            <div class="input-append bootstrap-timepicker-component">
                                                <input type="text" id="txtInTime1" name="inTime1" class="m-wrap m-ctrl-small timepicker-24">
                                                <span class="add-on"><i class="icon-time"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.outTime1 %><span class="required">*</span></label>
                                        <div class="controls">
                                            <div class="input-append bootstrap-timepicker-component">
                                                <input type="text" id="txtOutTime1" name="outTime1" class="m-wrap m-ctrl-small timepicker-24">
                                                <span class="add-on"><i class="icon-time"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row-fluid">
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.inTime2 %> </label>
                                        <div class="controls">
                                            <div class="input-append bootstrap-timepicker-component">
                                                <input type="text" id="txtInTime2" name="inTime2" class="m-wrap m-ctrl-small timepicker-24">
                                                <span class="add-on"><i class="icon-time"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.outTime2 %> </label>
                                        <div class="controls">
                                            <div class="input-append bootstrap-timepicker-component">
                                                <input type="text" id="txtOutTime2" name="outTime2" class="m-wrap m-ctrl-small timepicker-24">
                                                <span class="add-on"><i class="icon-time"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row-fluid">
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.inTime3 %> </label>
                                        <div class="controls">
                                            <div class="input-append bootstrap-timepicker-component">
                                                <input type="text" id="txtInTime3" name="inTime3" class="m-wrap m-ctrl-small timepicker-24">
                                                <span class="add-on"><i class="icon-time"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.outTime3 %> </label>
                                        <div class="controls">
                                            <div class="input-append bootstrap-timepicker-component">
                                                <input type="text" id="txtOutTime3" name="outTime3" class="m-wrap m-ctrl-small timepicker-24">
                                                <span class="add-on"><i class="icon-time"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row-fluid">
                                <div class="span6 ">                                    
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.graceIn %> </label>
                                        <div class="controls">
                                            <input type="text" id="txtGraceIn" name="graceIn" data-required="1" class="span8 m-wrap" />
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.graceOut %> </label>
                                        <div class="controls">
                                            <input type="text" id="txtGraceOut" name="graceOut" data-required="1" class="span8 m-wrap" />
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row-fluid">
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label"><%=Resources.Resource.flexible %> </label>
                                        <div class="controls">
                                            <input type="text" id="txtFlexible" name="flexible" data-required="1" class="span8 m-wrap" />
                                        </div>
                                    </div>                                     
                                </div>
                                <!--/span-->
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label">&nbsp;</label>
                                        <div class="controls">
                                            <input id="chkboxOpenShift" type="checkbox" name="openShift" />
                                            <%=Resources.Resource.openShift %>
                                            <br />
                                            <input id="chkboxNightShift" type="checkbox" name="nightShift" />
                                            <%=Resources.Resource.nightShift %>
                                        </div>
                                    </div>                                   
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
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
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script> 
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
           $("#liSch").addClass("active");
           $("#liSch .arrow").addClass("open");
           $("#liSchTime").addClass("active");


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
           LoadSchLocations();
           
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
                   var sch = $.getQueryString('sch') + "";
                   tempOrg = true;
                   if (sch != "" && tempLoc == true) {
                       Edit(sch);
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

       function LoadSchLocations() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleLocationPage.aspx") %>',
               success: function (html) {
                   $("#ddSchLocation").html(html);
                   $("#ddSchLocation").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var sch = $.getQueryString('sch') + "";
                   tempLoc = true;
                   if (sch != "" && tempOrg == true) {
                       Edit(sch);
                   }
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
           $("#txtInTime1").val("");
           $("#txtOutTime1").val("");
           $("#txtFlexible").val("");
           $("#txtGraceIn").val("");
           $("#txtCode").val("");

           $("#chkboxNightShift").removeAttr("checked");
           $("#uniform-chkboxNightShift span").removeClass("checked");

           $("#chkboxOpenShift").removeAttr("checked");
           $("#uniform-chkboxOpenShift span").removeClass("checked");

           $('#ddOrg option[value=""]').attr('selected', 'selected');
           $("#ddOrg").trigger("liszt:updated");
           //$("#txtCategory").val("");
           //$("#txtService").val("");
       }

       function Edit(id) {
           //Edit code
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

           var id = $.getQueryString('sch') + "";
          var orgID = $("#ddOrg").val();
          var schLocationID = $("#ddSchLocation").val();
          var code = $("#txtCode").val();
          var color = $("#txtColor").val();
          var inTime1 = $("#txtInTime1").val();
          var outTime1 = $("#txtOutTime1").val();
          var inTime2 = $("#txtInTime2").val();
          var outTime2 = $("#txtOutTime2").val();
          var inTime3 = $("#txtInTime3").val();
          var outTime3 = $("#txtOutTime3").val();
          var flexible = $("#txtFlexible").val();
          var graceIn = $("#txtGraceIn").val();
          var graceOut = $("#txtGraceOut").val();
          var openShift = $("#chkboxOpenShift").is(":checked");
          var nightShift = $("#chkboxNightShift").is(":checked");

          if ($('#form_sample_1').validate().form() == false) {
              return false;
          }
          var v = "key=save" + "&id=" + id + "&code=" + code + "&color=" + color + "&orgID=" + orgID + "&schLocationID=" + schLocationID;
          v += "&inTime1=" + inTime1 + "&outTime1=" + outTime1 + "&inTime2=" + inTime2 + "&outTime2=" + outTime2 + "&inTime3=" + inTime3 + "&outTime3=" + outTime3;
          v += "&flexible=" + flexible + "&graceIn=" + graceIn + "&graceOut=" + graceOut + "&openShift=" + openShift + "&nightShift=" + nightShift;
          
          $.ajax({
              type: 'POST',
              data: v,
              url: '<%= Page.ResolveClientUrl("../RequestPages/SchedulePage.aspx") %>',
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
                           window.location = '<%= Page.ResolveClientUrl("../Details/ViewScheduleTime.aspx") %>';
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
                           schLocation: {
                               required: true
                           },
                           code: {
                               minlength: 2,
                               required: true
                           },
                           inTime1: {
                               required: true,
                           },
                           outTime1: {
                               required: true,
                           },
                           flexible: {
                               minlength: 1,
                               required: true,
                               digits: true
                           },
                           graceIn: {
                               minlength: 1,
                               required: true,
                               digits: true
                           },
                           graceOut: {
                               minlength: 1,
                               required: true,
                               digits: true
                           }
                       },

                       messages: { // custom messages for radio buttons and checkboxes
                           code: {
                               required: "Pease enter code for schedule"
                           },
                           flexible: {
                               required: "Please enter flexible minutes"
                           },
                           graceIn: {
                               required: "Please enter grace in minutes"
                           },
                           graceOut: {
                               required: "Please enter grace out minutes"
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

       var FormComponents = function () {

           var handleColorPicker = function () {
               if (!jQuery().colorpicker) {
                   return;
               }
               $('.colorpicker-default').colorpicker({
                   format: 'hex'
               });
               $('.colorpicker-rgba').colorpicker();
           }

           var handlejQueryUIDatePickers = function () {
               $(".ui-date-picker").datepicker();
           }


           var handleDateTimePickers = function () {


               if (jQuery().timepicker) {
                   $('.timepicker-24').timepicker({
                       minuteStep: 1,
                       showSeconds: false,
                       showMeridian: false
                   });
               }

               if (!jQuery().datepicker || !jQuery().timepicker) {
                   return;
               }
           }

           return {
               //main function to initiate the module
               init: function () {
                   handleDateTimePickers();
                   handleColorPicker();
               }

           };

       }();

   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
