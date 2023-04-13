<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompanyWizard.aspx.cs" Inherits="TAMSR2.Admin.CompanyWizard" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
   <title><%=Resources.Resource.companies %> - <%=Resources.Resource.applicationName %></title>
   <!-- BEGIN PAGE LEVEL STYLES -->
   <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-fileupload/bootstrap-fileupload.css" />
   <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
   <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
   <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
   <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
   <!-- END PAGE LEVEL STYLES -->
    
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
         <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
         <div id="portlet-config" class="modal hide">
            <div class="modal-header">
               <button data-dismiss="modal" class="close" type="button"></button>
               <h3>portlet Settings</h3>
            </div>
            <div class="modal-body">
               <p>Here will be a configuration form</p>
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
                  <h3 class="page-title">
                     <%=Resources.Resource.company %> <%=Resources.Resource.wizard %>
                     <small><%=Resources.Resource.companyWizardDescription %></small>
                  </h3>
                  <ul class="breadcrumb">
                     <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("../Common/Home") %>'><%=Resources.Resource.home %></a> 
                        <span class="icon-angle-right"></span>
                     </li>
                     <li>
                        <a href="#"><%=Resources.Resource.wizard %></a>
                        <span class="icon-angle-right"></span>
                     </li>
                     <li><a href="#"><%=Resources.Resource.company %></a></li>
                  </ul>
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12">
                  <div class="portlet box blue" id="form_wizard_1">
                     <div class="portlet-title">
                        <div class="caption">
                           <i class="icon-reorder"></i> <%=Resources.Resource.company %> <%=Resources.Resource.wizard %> - <span class="step-title">Step 1 of 4</span>
                        </div>
                        <div class="tools hidden-phone">
                           <a href="javascript:;" class="collapse"></a>
                           <%--<a href="#portlet-config" data-toggle="modal" class="config"></a>--%>
                           <a href="CompanyWizard.aspx" class="reload"></a>
                           <%--<a href="javascript:;" class="remove"></a>--%>
                        </div>
                     </div>
                     <div class="portlet-body form">
                        <form id="form_sample_1" action="#" class="form-horizontal">
                           <div class="form-wizard">
                              <div class="navbar steps">
                                 <div class="navbar-inner">
                                    <ul class="row-fluid">
                                       <li class="span3">
                                          <a href="#tab1" data-toggle="tab" class="step active">
                                          <span class="number">1</span>
                                          <span class="desc"><i class="icon-ok"></i> <%=Resources.Resource.companySetup %></span>   
                                          </a>
                                       </li>
                                       <li class="span3">
                                          <a href="#tab2" data-toggle="tab" class="step">
                                          <span class="number">2</span>
                                          <span class="desc"><i class="icon-ok"></i> <%=Resources.Resource.companyLogo %></span>   
                                          </a>
                                       </li>
                                       <li class="span3">
                                          <a href="#tab3" data-toggle="tab" class="step">
                                          <span class="number">3</span>
                                          <span class="desc"><i class="icon-ok"></i> <%=Resources.Resource.defaultCreation %></span>   
                                          </a>
                                       </li>
                                       <li class="span3">
                                          <a href="#tab4" data-toggle="tab" class="step">
                                          <span class="number">4</span>
                                          <span class="desc"><i class="icon-ok"></i> <%=Resources.Resource.defaultEnteries %></span>   
                                          </a> 
                                       </li>
                                    </ul>
                                 </div>
                              </div>
                              <div id="bar" class="progress progress-success progress-striped">
                                 <div class="bar"></div>
                              </div>
                              <div class="tab-content">
                                 <div class="tab-pane active" id="tab1">
                                    <h3 class="block"><%=Resources.Resource.companyDetails %></h3>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.nameEn %></label>
                                       <div class="controls">
                                          <input id="txtNameEn" name="nameEn" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.nameAr %></label>
                                       <div class="controls">
                                          <input id="txtNameAr" name="nameAr" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.serialKey %></label>
                                       <div class="controls">
                                          <input id="txtSerialKey" name="serial" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group" style="display: none;">
                                       <label class="control-label"><%=Resources.Resource.license %></label>
                                       <div class="controls">
                                          <select id="ddLicense" name="ddLicense" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="license" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.license %>" >
                                            <option value=""></option>
                                         </select>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.startDate %></label>
                                       <div class="controls">
                                          <input id="txtStartDate" name="startDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.descriptionEn %></label>
                                       <div class="controls">
                                          <textarea id="txtDescriptionEn" class="span6 m-wrap" rows="3"></textarea>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.descriptionAr %></label>
                                       <div class="controls">
                                          <textarea id="txtDescriptionAr" class="span6 m-wrap" rows="3"></textarea>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.dbType %></label>
                                       <div class="controls">
                                          <select id="ddDbType" name="ddDbType" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.dbType %>" >
                                            <option value=""></option>
                                            <option value="SQL"><%=Resources.Resource.msSqlServer %></option>
                                            <option value="ORACLE"><%=Resources.Resource.oracle %></option>
                                         </select>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.dbName %></label>
                                       <div class="controls">
                                          <input id="txtDbName" name="dbName" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.dbUser %></label>
                                       <div class="controls">
                                          <input id="txtDbUser" name="dbUser" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.dbPassword %></label>
                                       <div class="controls">
                                          <input id="txtDbPassword" name="dbPassword" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.termsAndConditions %></label>
                                       <div class="controls">
                                           <iframe src="../Handlers/ViewFile.ashx" style="width: 90%;" class="span6 m-wrap" >&nbsp;</iframe>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxIsActive" type="checkbox" name="isActive" /> <%=Resources.Resource.agreeWithTerms %>
                                       </div>
                                       <span id="spnIsActive">&nbsp;</span>
                                    </div>
                                 </div>
                                 <div class="tab-pane" id="tab2">
                                    <h3 class="block"><%=Resources.Resource.uploadLogo %></h3>  
                                       <div class="control-group">
                                                  <label class="control-label"><%=Resources.Resource.logo %></label>
                                          <div class="controls">
                                             <div class="fileupload fileupload-new" data-provides="fileupload">
                                                <div class="input-append"><div class="uneditable-input">
                                                      <i class="icon-file fileupload-exists"></i> 
                                                      <span class="fileupload-preview"></span>
                                                   </div><span class="btn btn-file">
                                                   <span class="fileupload-new"><%=Resources.Resource.selectFile %></span>
                                                   <span class="fileupload-exists"><%=Resources.Resource.change %></span>
                                                   <input id="fileToUpload" name="fileToUpload" type="file" class="default" />
                                                   </span>
                                                   <a href="#" class="btn fileupload-exists" data-dismiss="fileupload"><%=Resources.Resource.remove %></a>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                       <div>
                                           <img id="loading" src="../Images/loading.gif" style="display: none;" />	 &nbsp; &nbsp; &nbsp; &nbsp;
                                       </div> 
                                 </div>
                                 <div class="tab-pane" id="tab3">   
                                    <div class="control-group">
                                       <label class="control-label"></label>
                                       <div class="controls">
                                          <label class="checkbox"> <%=Resources.Resource.createDefaultEntities %>
                                          </label>
                                       </div>
                                    </div>                        
                                 </div>
                                 <div class="tab-pane" id="tab4">
                                    <h3 class="block"><%=Resources.Resource.appSetting %></h3>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.smtpOrWebMail %></label>
                                       <div class="controls">
                                          <label class="radio">
                                          <input type="radio" name="smtpOrWebMail" id="optionsRadios1" value="SMTP" checked />
                                          <%=Resources.Resource.smtp %>
                                          </label>
                                          <div class="clearfix"></div>
                                          <label class="radio">
                                          <input type="radio" name="smtpOrWebMail" id="optionsRadios2" value="WEBMAIL" />
                                          <%=Resources.Resource.webMail %>
                                          </label>  
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.server %></label>
                                       <div class="controls">
                                          <input id="txtServer" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div style="padding: 0px; margin: 0px;" id="spnSmtp">
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.smtpPort %></label>
                                       <div class="controls">
                                          <input id="txtSmtpPort" type="text" class="span6 m-wrap" />
                                          
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.smtpEmail %></label>
                                       <div class="controls">
                                          <input id="txtSmtpEmail" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.smtpPassword %></label>
                                       <div class="controls">
                                          <input id="txtSmtpPassword" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.fromEmail %></label>
                                       <div class="controls">
                                          <input id="txtFromEmail" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.bccEmail %></label>
                                       <div class="controls">
                                          <input id="txtBccEmail" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.ccEmail %></label>
                                       <div class="controls">
                                          <input id="txtCcEmail" type="text" class="span6 m-wrap" />
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.timeZone %></label>
                                       <div class="controls">
                                          <input id="txtTimeZone" type="text" class="span6 m-wrap" />
                                          <span class="help-inline"></span>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="chkboxDefault" type="checkbox" name="default" /> <%=Resources.Resource.addDefaultEnteries %>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div class="form-actions clearfix">
                                 <a href="javascript:;" style="cursor: pointer;" class="btn button-previous">
                                 <i class="m-icon-swapleft"></i> <%=Resources.Resource.back %> 
                                 </a>
                                 <a href="javascript:;" style="cursor: pointer;" id="btnNext" onclick="return Next()" class="btn blue">
                                 <%=Resources.Resource.next %> <i class="m-icon-swapright m-icon-white"></i>
                                 </a>
                                 <a href="javascript:;" style="display: none; cursor: pointer;" class="btn blue button-next">
                                 <%=Resources.Resource.next %> <i class="m-icon-swapright m-icon-white"></i>
                                 </a>
                                 <a href="javascript:;" onclick="return Next()" class="btn green button-submit">
                                 <%=Resources.Resource.submit %> <i class="m-icon-swapright m-icon-white"></i>
                                 </a>
                                  <button id="btnBroadCast" type="button" style="display: none;" class="btn purple"><%=Resources.Resource.broadcast %></button>
                                  <br /> <br />
                                  <div id="divSuccessMsg" style="display: none;" class="alert alert-success"><span id="spnSuccessMsg">&nbsp;</span></div>
                                  <div id="divErrorMsg" style="display: none;" class="alert alert-error"><span id="spnErrorMsg">&nbsp;</span></div>
                                 <span id="spnID" style="display: none;">0</span>
                                 <span id="spnTab" style="display: none;">1</span> 
                              </div>
                           </div>
                        </form>
                     </div>
                  </div>
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
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-fileupload/bootstrap-fileupload.js"></script>
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
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>   
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
  <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
   <script src="../assets/<%= languageStr %>/scripts/app.js"></script>
   <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>    
    <script src="../Scripts/jquery.loadmask.js"></script>
   <%--<script src="../assets/<%= languageStr %>/scripts/form-wizard.js"></script>  --%>     
    <script src="../Scripts/ajaxfileupload.js"></script>
<%--   <script src="../assets/<%= languageStr %>/scripts/form-components.js"></script>       --%>
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
           FormWizard.init();
           //FormValidation.init();
           //TableManaged.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#liAdmin .arrow").removeClass("open");
           $("#liCompany").addClass("active");

           LoadLicense();

           FormComponents.init();
           FormValidation.init();


           // Declare a proxy to reference the hub. 
           var users = $.connection.chatHub;

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2Company', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
       });

       function Next() {
           var current = $("#spnTab").html();
           $("#btnNext").attr("disabled", "disabled");
           if (current == "1") {
               SaveCompany(); //////function call to save company details
           }
           else if (current == "2") {
               ajaxFileUpload(); //////function call to upload company logo
           }
           else if (current == "3") {
               DefaultEntities(); //////function call to create default entities
           }
           else if (current == "4") {
               DefaultEnteries(); //////function call to insert default entries
           }
           else {
               $("#spnTab").html("1");
               $("#btnNext").html("<%=Resources.Resource.next %> <i class='m-icon-swapright m-icon-white'></i>");
               $(".button-next").css("display", "none");
           }

           $("#btnNext").attr("disabled", "");
       }

       function TabChange() {
           var current = $("#spnTab").html();
           current = (parseInt(current) + 1);

           if (current == "4") {
               $("#btnNext").html("<%=Resources.Resource.finish %> <i class='m-icon-swapright m-icon-white'></i>");
           }
           else {
               $("#btnNext").html("<%=Resources.Resource.next %> <i class='m-icon-swapright m-icon-white'></i>");
           }
           $("#spnTab").html(current);
           $(".button-next").click();
           //if (current == "5") {
           //    $(".button-previous").css("display", "none");
           //}
           $(".button-next").css("display", "none");
           $(".button-submit").css("display", "none");
       }

       function ajaxFileUpload() {
           var desc = $("#txtDesc").val();

           var d = "id=" + $("#spnID").html() + "&userID=<%= Session["ID"] %>";
           var path = '<%= Page.ResolveClientUrl("~/Handlers/AjaxFileUpload.ashx") %>' + '?' + d;

           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg").css("display", "none");

           $("#loading")
          .ajaxStart(function () {
              $(this).show();
              $(".form-wizard").mask("<%=Resources.Resource.processing %>" + "....");
          })
          .ajaxComplete(function () {
              $(this).hide();
              $(".form-wizard").unmask();
          });

          $.ajaxFileUpload({
              url: path,
              secureuri: false,
              fileElementId: 'fileToUpload',
              dataType: 'json',
              data: d,
              success: function (data, status) {
                  if (typeof (data.error) != 'undefined') {
                      if (data.error != '') {
                          $("#divErrorMsg").css("display", "block");
                          $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>" + data.error);
                          $(".form-wizard").unmask();
                      } else {
                          $("#divSuccessMsg").css("display", "block");
                          $("#spnSuccessMsg").html("<%=Resources.Resource.msgLogoUpload %>");
                          $(".form-wizard").unmask();
                          TabChange();
                      }
                  }
              },
              error: function (data, status, e) {
                  $("#divErrorMsg").css("display", "block");
                  $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                  $(".form-wizard").unmask();
              }
          })
          return false;
      }
      /////////////////END OF UPLOAD FUNCTION//////////////////////////////////////////////

      function LoadLicense() {
          var d = "key=getIdNameListString";
          $(".form-wizard").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/LicensePage.aspx") %>',
               success: function (html) {
                   $("#ddLicense").html(html);
                   $("#ddLicense").trigger("liszt:updated");
                   $(".form-wizard").unmask();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $(".form-wizard").unmask();
               }
           });
       }


       function SaveCompany() {
           var id = $("#spnID").html();
           var nameEn = $("#txtNameEn").val();
           var nameAr = $("#txtNameAr").val();
           var dbType = $("#ddDbType").val();
           var dbName = $("#txtDbName").val();
           var dbUser = $("#txtDbName").val();
           var dbPassword = $("#txtDbName").val();
           var startDate = $("#txtStartDate").val();
           var serialKey = $("#txtSerialKey").val();
           var licenseID = $("#ddLicense").val();
           var descriptionEn = $("#txtDescriptionEn").val();
           var descriptionAr = $("#txtDescriptionAr").val();
           var isActive = $('#chkboxIsActive').is(":checked");

           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg").css("display", "none");
           
           if ($('#form_sample_1').validate().form() == false) {
               $("#divErrorMsg").css("display", "block");
               $("#spnErrorMsg").html("<%=Resources.Resource.formErrors %>");
               return false;
           }
           var v = "key=save" + "&id=" + id + "&nameEn=" + nameEn + "&nameAr=" + nameAr + "&descriptionEn=" + descriptionEn;
           v += "&descriptionAr=" + descriptionAr + "&dbType=" + dbType + "&dbName=" + dbName;
           v += "&dbUser=" + dbUser + "&dbPassword=" + dbPassword + "&startDate=" + startDate + "&licenseID=" + licenseID;
           v += "&isActive=" + isActive + "&serialKey=" + serialKey;

           $(".form-wizard").mask("<%=Resources.Resource.processing %>" + "....");

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/CompanyPage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $(".button-previous").click();
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                       $(".form-wizard").unmask();
                   }
                   else if (html == '0') {
                       //exists
                       $(".button-previous").click();
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                       $(".form-wizard").unmask();
                   }
                   else {
                       //success
                       $("#spnID").html(html);
                       $("#divSuccessMsg").css("display", "block");
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                       $('#btnBroadCast').click();
                       $(".form-wizard").unmask();
                       TabChange();
                   }
               },
               error: function (html) {
                   $(".button-previous").click();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %> " + html);
                   $(".form-wizard").unmask();
               }

           });
       }

       function DefaultEntities() {
           var d = "key=defaultCreation" + "&dbName=" + $("#txtDbName").val();
           $(".form-wizard").mask("<%=Resources.Resource.processing %>" + "....");

           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg").css("display", "none");

           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/CompanyPage.aspx") %>',
               success: function (html) {
                   if (html == "0") {
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                       $(".form-wizard").unmask();
                   }
                   else {
                       //success
                       $("#divSuccessMsg").css("display", "block");
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgDefaultCreatedSuccess %>");
                       $(".form-wizard").unmask();
                       TabChange();
                   }
               },
               error: function (html) {
                   $(".button-previous").click();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $(".form-wizard").unmask();
               }
           });
       }

       function DefaultEnteries() {
           var d = "key=defaultInsertion&cmpID=" + $("#spnID").html();
           var smtpOrWebMail = $('[name=smtpOrWebMail]:checked').val();
           var server = $("#txtServer").val();
           var smtpPort = $("#txtSmtpPort").val();
           var smtpEmail = $("#txtSmtpEmail").val();
           var smtpPassword = $("#txtSmtpPassword").val();
           var fromEmail = $("#txtFromEmail").val();
           var bccEmail = $("#txtBccEmail").val();
           var ccEmail = $("#txtCcEmail").val();
           var timeZone = $("#txtTimeZone").val();
           var defaultvalues = $("#chkboxDefault").is(":checked");


           d += "&smtpOrWebMail=" + smtpOrWebMail + "&server=" + server + "&smtpPort=" + smtpPort + "&smtpEmail=" + smtpEmail;
           d += "&smtpPassword=" + smtpPassword + "&fromEmail=" + fromEmail + "&bccEmail=" + bccEmail + "&ccEmail=" + ccEmail;
           d += "&timeZone=" + timeZone + "&defaultvalues=" + defaultvalues + "&dbName=" + $("#txtDbName").val();;

           $(".form-wizard").mask("<%=Resources.Resource.processing %>" + "....");

           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg").css("display", "none");

           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/CompanyPage.aspx") %>',
               success: function (html) {
                   if (html == '0') {
                       $(".button-previous").click();
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                       $(".form-wizard").unmask();
                   }
                   else {
                       //success
                       Clear();
                       $("#divSuccessMsg").css("display", "block");
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgDefaultEnteriesSuccess %>");
                       $(".form-wizard").unmask();
                       TabChange();
                   }
               },
               error: function (html) {
                   $(".button-previous").click();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $(".form-wizard").unmask();
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

           $("#spnSuccessMsg").html("&nbsp;");
           $("#spnErrorMsg").html("&nbsp;");
           $("#spnID").html("0");
           $("#spnTab").val("1");
           $("#txtNameEn").val("");
           $("#txtNameAr").val("");
           $("#txtDbName").val("");
           $("#txtDbUser").val("");
           $("#txtDbPassword").val("");
           $("#txtStartDate").val("");
           $("#txtDescriptionEn").val("");
           $("#txtDescriptionAr").val("");

           $("#txtServer").val("");
           $("#txtSmtpPort").val("");
           $("#txtSmtpEmail").val("");
           $("#txtSmtpPassword").val("");
           $("#txtFromEmail").val("");
           $("#txtBccEmail").val("");
           $("#txtCcEmail").val("");
           $("#txtTimeZone").val("");

           $("#chkboxIsActive").attr("checked", "");
           $("#uniform-chkboxIsActive span").removeClass("checked");
           //$("#txtCategory").val("");
           //$("#txtService").val("");

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

               $("#txtStartDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
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
                           ddDbType: {
                               required: true
                           },
                           dbName: {
                               minlength: 3,
                               required: true
                           },
                           dbUser: {
                               minlength: 2,
                               required: true
                           },
                           dbPassword: {
                               minlength: 3,
                               required: true
                           },
                           serial: {
                               required: true,
                               minlength: 16,
                               maxlength: 16
                           },
                           startDate: {
                               required: true
                           },
                           isActive: {
                               required: true
                           }
                       },

                       errorPlacement: function (error, element) { // render error placement for each input type
                           if (element.attr("name") == "isActive") { // for uniform checkboxes, insert the after the given container
                               error.addClass("no-left-padding").insertAfter("#spnIsActive");
                           } else if (element.attr("name") == "ddDbType") { // for uniform checkboxes, insert the after the given container
                               error.addClass("no-left-padding").insertAfter("#ddDbType-chzn");
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
       ////////END OF FORM VALIDATION////////


       var FormWizard = function () {


           return {
               //main function to initiate the module
               init: function () {
                   if (!jQuery().bootstrapWizard) {
                       return;
                   }

                   // default form wizard
                   $('#form_wizard_1').bootstrapWizard({
                       'nextSelector': '.button-next',
                       'previousSelector': '.button-previous',
                       onTabClick: function (tab, navigation, index) {
                           alert('on tab click disabled');
                           return false;
                       },
                       onNext: function (tab, navigation, index) {
                           var total = navigation.find('li').length;
                           var current = index + 1;
                           // set wizard title
                           $('.step-title', $('#form_wizard_1')).text('Step ' + (index + 1) + ' of ' + total);
                           // set done steps
                           jQuery('li', $('#form_wizard_1')).removeClass("done");
                           var li_list = navigation.find('li');
                           for (var i = 0; i < index; i++) {
                               jQuery(li_list[i]).addClass("done");
                           }

                           if (current == 1) {
                               $('#form_wizard_1').find('.button-previous').hide();
                           } else {
                               $('#form_wizard_1').find('.button-previous').show();
                           }
                           if (current >= total) {
                               $('#form_wizard_1').find('.button-next').hide();
                               $('#form_wizard_1').find('.button-submit').show();
                           } else {
                               $('#form_wizard_1').find('.button-next').show();
                               $('#form_wizard_1').find('.button-submit').hide();
                           }
                           App.scrollTo($('.page-title'));
                       },
                       onPrevious: function (tab, navigation, index) {
                           var total = navigation.find('li').length;
                           var current = index + 1;
                           // set wizard title
                           $('.step-title', $('#form_wizard_1')).text('Step ' + (index + 1) + ' of ' + total);
                           // set done steps
                           jQuery('li', $('#form_wizard_1')).removeClass("done");
                           var li_list = navigation.find('li');
                           for (var i = 0; i < index; i++) {
                               jQuery(li_list[i]).addClass("done");
                           }

                           if (current == 1) {
                               $('#form_wizard_1').find('.button-previous').hide();
                           } else {
                               $('#form_wizard_1').find('.button-previous').show();
                           }

                           if (current >= total) {
                               $('#form_wizard_1').find('.button-next').hide();
                               $('#form_wizard_1').find('.button-submit').show();
                           } else {
                               $('#form_wizard_1').find('.button-next').show();
                               $('#form_wizard_1').find('.button-submit').hide();
                           }

                           App.scrollTo($('.page-title'));
                       },
                       onTabShow: function (tab, navigation, index) {
                           var total = navigation.find('li').length;
                           var current = index + 1;
                           var $percent = (current / total) * 100;
                           $('#form_wizard_1').find('.bar').css({
                               width: $percent + '%'
                           });
                       }
                   });

                   $('#form_wizard_1').find('.button-previous').hide();
                   $('#form_wizard_1 .button-submit').click(function () {
                       //DefaultEnteries(); //////function call to insert default entries
                       //alert('Finished! Hope you like it :)');
                       Next();
                   }).hide();
               }

           };

       }();

   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
