<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewUsers.aspx.cs" Inherits="TAMSR2.Admin.ViewUsers" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.users %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
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
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.applicationName %> <%=Resources.Resource.userDetails %></h4>
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
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.username %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="text" id="txtUsername" name="username" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.password %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="password" id="txtPassword" name="password" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.email %><span class="required">*</span></label>
                              <div class="controls">
                                 <input name="email" id="txtEmail" type="text" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.company %><span class="required">*</span></label>
                              <div class="controls chzn-controls">
                                 <select id="ddCompany" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="company" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>" tabindex="1">
                                    <option value=""></option>
                                 </select>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.permissions %><span class="required">*</span></label>
                              <div class="controls">
                                 <label class="checkbox line">
                                 <input type="checkbox" id="chkboxView" value="1" name="service"/> <%=Resources.Resource.view %>
                                 </label>
                                 <label class="checkbox line">
                                 <input type="checkbox" id="chkboxAdd"  value="2" name="service"/> <%=Resources.Resource.add %>
                                 </label>
                                 <label class="checkbox line">
                                 <input type="checkbox" id="chkboxUpdate"  value="3" name="service"/> <%=Resources.Resource.update %>
                                 </label>
                                 <label class="checkbox line">
                                 <input type="checkbox" id="chkboxDelete"  value="4" name="service"/> <%=Resources.Resource.delete %>
                                 </label>
                                 <label class="checkbox line">
                                 <input type="checkbox" id="chkboxIsActive"  value="4" name="service"/> <%=Resources.Resource.active %>
                                 </label>
                                 <span class="help-block">(<%=Resources.Resource.selectOne %>)</span>
                                 <div id="form_2_service_error"></div>
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
									<%=Resources.Resource.users %>					<small>manage TAMSR2USERS</small>
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href="index.html"><%=Resources.Resource.home %></a> 
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.users %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.users %></a></li>
						
						
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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.users %></div>
                        <div class="tools">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                     </div>
                     <div class="portlet-body">
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="spnGridMsg">&nbsp;</span>
                            </div>
                           <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                              <span id="spnAddButton" runat="server" >
                                  <a id="btnAdd" href="#portlet-config" data-toggle="modal" class="btn green"><%=Resources.Resource.add %><i class="icon-plus"></i></a> 
                              </span>
                           </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                           <thead>
                              <tr>
                                 <th style="width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                 <th><%=Resources.Resource.name %></th>
                                 <th class="hidden-480"><%=Resources.Resource.username %></th>
                                 <th class="hidden-480"><%=Resources.Resource.view %></th>
                                 <th class="hidden-480"><%=Resources.Resource.add %></th>
                                 <th class="hidden-480"><%=Resources.Resource.update %></th>
                                 <th class="hidden-480"><%=Resources.Resource.delete %></th>
                                 <th class="hidden-480"><%=Resources.Resource.active %></th>
                                 <th style="width: 80px !important;"><%=Resources.Resource.active %></th>
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

       $(document).ready(function () {
           App.init(); // initlayout and core plugins
           FormValidation.init();
           //TableManaged.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#liAdmin .arrow").removeClass("open");
           $("#liUser").addClass("active");

           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": false }
               ],
               "oLanguage": {
                   "sLengthMenu": "_MENU_ records per page"
               },
               "aaSorting": [[1, "desc"]],
               "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/UserPage.aspx?key=getAll") %>'
           });

           LoadCompanies();

           // Declare a proxy to reference the hub. 
           var users = $.connection.chatHub;
           // Create a function that the hub can call to broadcast messages.
           users.client.broadcastMessage = function (name, message) {
               if (name == "TAMSR2Users") {
                   ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2Users', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
       });

       function ReloadGrid() {
           $('#sample_1').dataTable().fnDraw();
       }

       function LoadCompanies() {
           var d = "key=getIdNameListString";
           
          $.ajax({
              type: 'POST',
              data: d,
              url: '<%= Page.ResolveClientUrl("../RequestPages/CompanyPage.aspx") %>',
              success: function (html) {
                  $("#ddCompany").html(html);
                   $("#ddCompany").trigger("liszt:updated");
               },
              error: function (html) {
                  $("#divErrorMsg").css("display", "block");
                  $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
               }
          });
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

           $("#spnGridMsg").html("&nbsp;");
           $("#spnID").html("0");
           $("#txtName").val("");
           $("#txtUsername").val("");
           $("#txtPassword").val("");
           $("#txtEmail").val("");

           $("#chkboxView").attr("checked", false);
           $("#uniform-chkboxView span").removeClass("checked");

           $("#chkboxAdd").attr("checked", false);
           $("#uniform-chkboxAdd span").removeClass("checked");

           $("#chkboxUpdate").attr("checked", false);
           $("#uniform-chkboxUpdate span").removeClass("checked");

           $("#chkboxDelete").attr("checked", false);
           $("#uniform-chkboxDelete span").removeClass("checked");

           $("#chkboxIsActive").attr("checked", false);
           $("#uniform-chkboxIsActive span").removeClass("checked");
           //$("#txtCategory").val("");
           //$("#txtService").val("");

       }
       
       function Delete(id) {
           if (confirm("Are you sure you want to delete this record?")) {
               var v = "key=deleteByID&id=" + id;

               $("#spnGridMsg").html("&nbsp;");
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/UserPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#spnGridMsg").html("<div class='alert alert-success'><button data-dismiss='alert' class='close'></button> <strong>Success!</strong> Record has been deleted.  </div> &nbsp;");
                           $('#btnBroadCast').click();
                       }
                       else {
                           $("#spnGridMsg").html("<div class='alert alert-error'> <button data-dismiss='alert' class='close'></button> <strong>Error!</strong> Record has not been deleted. </div> &nbsp;");
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
           Clear();
           $("#spnID").html(id);
           $("#btnAdd").click();
           $("#spnGridMsg").html("&nbsp;");
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/UserPage.aspx") %>',
                   success: function (html) {
                       if (html != "") {
                           var j = $.parseJSON(html);
                           $("#spnID").val(j.ID);
                           $("#txtNameEn").val(j.NameEn);
                           $("#txtNameAr").val(j.NameAr);
                           $("#txtUsername").val(j.Username);
                           $("#txtPassword").attr("value", j.Password);
                           $("#txtEmail").val(j.Email);
                           if (j.CanView) {
                               $("#chkboxView").attr("checked", "checked");
                               $("#uniform-chkboxView span").addClass("checked");
                           }
                           if (j.CanAdd) {
                               $("#chkboxAdd").attr("checked", "checked");
                               $("#uniform-chkboxAdd span").addClass("checked");
                           }
                           if (j.CanUpdate) {
                               $("#chkboxUpdate").attr("checked", "checked");
                               $("#uniform-chkboxUpdate span").addClass("checked");
                           }
                           if (j.CanDelete) {
                               $("#chkboxDelete").attr("checked", "checked");
                               $("#uniform-chkboxDelete span").addClass("checked");
                           }
                           if (j.IsActive) {
                               $("#chkboxIsActive").attr("checked", "checked");
                               $("#uniform-chkboxIsActive span").addClass("checked");
                           }
                           $('#ddCompany option[value=' + j.CompanyID + ']').attr('selected', 'selected');
                           $("#ddCompany").trigger("liszt:updated");
                       }
                   },
                   error: function (html) {

                   }
               });
       }

       function Save() {
           var id = $("#spnID").html();
           var nameEn = $("#txtNameEn").val();
           var nameAr = $("#txtNameAr").val();
           var username = $("#txtUsername").val();
           var password = $("#txtPassword").val();
           var email = $("#txtEmail").val();
           var companyID = $("#ddCompany").val();
           var view = $('#chkboxView').is(":checked");
           var add = $('#chkboxAdd').is(":checked");
           var update = $('#chkboxUpdate').is(":checked");
           var del = $('#chkboxDelete').is(":checked");
           var isActive = $("#chkboxIsActive").is(":checked");
           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }
           var v = "key=save" + "&id=" + id + "&nameEn=" + nameEn + "&nameAr=" + nameAr + "&username=" + username + "&password=" + password;
           v += "&email=" + email + "&companyID=" + companyID + "&view=" + view + "&add=" + add + "&update=" + update + "&del=" + del + "&isActive=" + isActive;


           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/UserPage.aspx") %>',
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
                   else if (html == '1') {
                       //success
                       $("#divSuccessMsg").css("display", "block");
                       $("#spnSuccessMsg").html("Sucessfully saved in database.");
                       $('#btnBroadCast').click();
                       Clear();
                   }
                   else {
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("Error! ");
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
                           username: {
                               minlength: 3,
                               required: true
                           },
                           password: {
                               minlength: 5,
                               required: true
                           },
                           email: {
                               required: true,
                               email: true
                           },
                           company: {
                               required: true
                           },
                           service: {
                               required: true,
                               minlength: 1
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
