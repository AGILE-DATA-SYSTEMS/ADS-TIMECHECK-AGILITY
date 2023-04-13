<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveWorkflows.aspx.cs" Inherits="TAMSR2.Workflows.SaveWorkflows" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.workflow %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <!-- END PAGE LEVEL STYLES -->
    <link href="<%= path %>Styles/jquery.loadmask.css" rel="stylesheet" />
     
    <style>
        .inline-help1{
            display: inline-block;
            padding-top: 5px;
            color: #595959;
            padding-left: 5px;
            padding-right: 5px
        }
        .chzn-container .chzn-container-single{
            width: 100% !important;
        }
    </style>
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
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">
                    <%=Resources.Resource.workflow %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Workflows") %>'><%=Resources.Resource.workflow %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href='<%= Page.ResolveClientUrl("~/Workflow/Save-Workflow/0") %>'><%=Resources.Resource.workflow %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->

        <div id="divLabel" style="font-weight: bold; padding: 5px 0px;">
            &nbsp;
        </div>

        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">

                <!-- BEGIN FORM-->
                <form action="#" id="form_sample_1" class="form-horizontal">
                    <div id="divErrorMsg" class="alert alert-error hide">
                        <button class="close" data-dismiss="alert"></button>
                        <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                    </div>
                    <div id="divSuccessMsg" class="alert alert-success hide">
                        <button class="close" data-dismiss="alert"></button>
                        <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                    </div>
                    <div class="row-fluid">
                        <div class="span5 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                                  <div class="controls">
                                     <input type="text" id="txtCode" style="width:100%;" name="code" data-required="1" class="span6 m-wrap"/>
                                  </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span5 "> 
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.category %></label>
                                  <div class="controls">  
                                      <select id="ddCat" name="cat"  style="width:100%;" class="span6  chosen  " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.value %>" tabindex="1">
                                                        <option value=""><%=Resources.Resource.category %> </option> 
                                      </select>  
                                  </div>
                            </div> 
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                     <div class="row-fluid">
                         
                        <div class="span5"> 
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.levels %></label>
                                  <div class="controls"> 
                                     <input type="text" style="width:100%; display:none;" id="txtLevel" name="level" data-required="1" class="span6 m-wrap"/>
                                      <select id="ddLevel" name="value3"  style="width:100%;" class="span6  chosen  " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.value %>" tabindex="1">
                                                        <option value=""><%=Resources.Resource.choose + " " + Resources.Resource.level %> </option>
                                                        <option value="1">1</option>
                                                        <option value="2">2</option>
                                                        <option value="3">3</option>
                                                        <option value="4">4</option> 
                                      </select>  
                                  </div>
                            </div> 
                        </div>
                        <!--/span-->
                        <div class="span5 "> 
                            <div class="control-group"> 
                                  <div class="controls" style="margin-left:10px !important;"> 
                                    <button id="btnGenerate" type="button" onclick="Generate()" class="btn green"><%=Resources.Resource.generate %></button>

                                  </div>
                            </div> 
                        </div>
                        <!--/span-->
                    <!--/row-->
                     </div>
                    <div class="row-fluid" style="display:none;">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.descriptionEn %></label>
                                  <div class="controls">
                                     <input type="text" id="txtDescriptionEn" name="nameEn" data-required="1" class="span6 m-wrap"/>
                                  </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.descriptionAr %></label>
                                  <div class="controls">
                                     <input type="text" id="txtDescriptionAr" name="nameAr" data-required="1" class="span6 m-wrap"/>
                                  </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row--> 
                    <!--/row-->
                    <div class="form-section"">
                         
                    </div>

                    <div class="row-fluid" id="divWorkflowActions"    >
                        <div class="span12 ">
                            <table class="table table-striped table-bordered table-hover" id="sample_1">
                           <thead>
                              <tr style="background-color: #e8e3e3;"> 
                                 <th style="text-align: center; width:5% !important;">&nbsp;</th>
                                 <th style="text-align: center; width:20% !important;"><%=Resources.Resource.type %></th>
                                 <th style="text-align: center; width:20% !important;"><%=Resources.Resource.value %></th>
                                 <th style="text-align: center; width:20% !important;"><%=Resources.Resource.onSuccess %></th>
                                 <th style="text-align: center; width:20% !important;"><%=Resources.Resource.onFailure %></th>
                                 <th style="text-align: center; width:15% !important;"><%=Resources.Resource.statusText %></th> 
                              </tr>
                           </thead>
                           <tbody>
                               <tr id="row1" style="display:none;" >
                                   <td  style="text-align: center; width:5% !important;">1</td> 
                                   <td style="  width:20% !important;"> 
                                       
                                                        <select id="ddType1" name="type1" style="width:100%;" class="span6 chosen" data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                         
                                                        </select> 
                                          
                                   </td>
                                   <td style=" width:20% !important;"> 
                                                        <select id="ddValue1" name="value1"  style="width:100%;" class="span12  chosen  " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.value %>" tabindex="1">
                                                         
                                                        </select>  
                                    </td>
                                   <td style="  width:20% !important;"> 
                                                        <select id="ddStep1" name="step1" class="span12 chosen "  style="width:100%;" data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                        <option value="2"><%=Resources.Resource.step2 %> </option>
                                                        <option value="3"><%=Resources.Resource.step3 %> </option>
                                                        <option value="4"><%=Resources.Resource.step4 %> </option>
                                                        <option value="99"><%=Resources.Resource.approved %> </option> 
                                                        </select>  
                                    </td>
                                   <td style=" width:20% !important;"> 
                                                    <input type="text" id="txtRejected1" style="width:100%;"  name="rejected1" data-required="1" readonly="true" value="<%= Resources.Resource.rejected %>" class="span6 m-wrap"/>

                                    </td>
                                   <td style="text-align: center; width:15% !important;"> 
                                             <input type="text" id="txtStatus1" name="level" style="width:100%;"  data-required="1" class="span12 m-wrap"/>
                                        
                                    </td>
                               </tr>
                               <tr  id="row2"  style="display:none;">
                                   <td  style="text-align: center; width:5% !important;">2</td> 
                                   <td style="  width:20% !important;"> 
                                       
                                                        <select id="ddType2" name="type2"   style="width:100%;" class="span12 chosen  " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                        
                                                        </select> 
                                          
                                   </td>
                                   <td style=" width:20% !important;"> 
                                                        <select id="ddValue2" name="value2"  style="width:100%;" class="span12  chosen  " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.value %>" tabindex="1">
                                                       
                                                        </select>  
                                    </td>
                                   <td style="  width:20% !important;"> 
                                                        <select id="ddStep2" name="step2"  style="width:100%;"s class="span12  chosen " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                        <option value="2"><%=Resources.Resource.step2 %> </option>
                                                        <option value="3"><%=Resources.Resource.step3 %> </option>
                                                        <option value="4"><%=Resources.Resource.step4 %> </option>
                                                        <option value="99"><%=Resources.Resource.approved %> </option> 
                                                        </select>  
                                    </td>
                                   <td style=" width:20% !important;"> 
                                                    <input type="text" id="txtRejected2"  style="width:100%;"  name="level" data-required="1" readonly="true" value="<%= Resources.Resource.rejected %>" class="span6 m-wrap"/>

                                    </td>
                                   <td style="text-align: center; width:15% !important;"> 
                                             <input type="text" id="txtStatus2" name="level" style="width:100%;"  data-required="1" class="span12 m-wrap"/>
                                        
                                    </td>
                               </tr>
                               <tr  id="row3"  style="display:none;">
                                   <td  style="text-align: center; width:5% !important;">3</td> 
                                   <td style="  width:20% !important;"> 
                                       
                                                        <select id="ddType3" name="type3" class="span12 chosen  " style="width:100%;"  data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                     
                                                        </select> 
                                          
                                   </td>
                                   <td style=" width:20% !important;"> 
                                                        <select id="ddValue3" name="value3" style="width:100%;" class="span12  chosen  " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.value %>" tabindex="1">
                                                        
                                                        </select>  
                                    </td>
                                   <td style="  width:20% !important;"> 
                                                        <select id="ddStep3" name="step3" class="span12  chosen " style="width:100%;"  data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                        <option value="2"><%=Resources.Resource.step2 %> </option>
                                                        <option value="3"><%=Resources.Resource.step3 %> </option>
                                                        <option value="4"><%=Resources.Resource.step4 %> </option>
                                                        <option value="99"><%=Resources.Resource.approved %> </option>  
                                                        </select>  
                                    </td>
                                   <td style=" width:20% !important;"> 
                                                    <input type="text" id="txtRejected3" style="width:100%;" name="level" data-required="1" readonly="true" value="<%= Resources.Resource.rejected %>" class="span6 m-wrap"/>

                                    </td>
                                   <td style="text-align: center; width:15% !important;"> 
                                             <input type="text" id="txtStatus3" name="level" style="width:100%;" data-required="1" class="span12 m-wrap"/>
                                        
                                    </td>
                               </tr>
                               <tr  id="row4" style="display:none;">
                                   <td  style="text-align: center; width:5% !important;">4</td> 
                                   <td style="  width:20% !important;"> 
                                       
                                                        <select id="ddType4" name="type4" style="width:100%;" class="span12 chosen  " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                       
                                                        </select> 
                                          
                                   </td>
                                   <td style=" width:20% !important;"> 
                                                        <select id="ddValue4" name="value4" style="width:100%;" class="span12  chosen  " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.value %>" tabindex="1">
                                                         
                                                        </select>  
                                    </td>
                                   <td style="  width:20% !important;"> 
                                       <div class="control">
                                                        <select id="ddStep4" name="step4" style="width:100%;" class="span12  chosen " data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                        <option value="2"><%=Resources.Resource.step2 %> </option>
                                                        <option value="3"><%=Resources.Resource.step3 %> </option>
                                                        <option value="4"><%=Resources.Resource.step4 %> </option>
                                                        <option value="99"><%=Resources.Resource.approved %> </option> 
                                                        </select>  
                                           </div>
                                    </td>
                                   <td style=" width:20% !important;"> 
                                                    <input type="text" id="txtRejected4" style="width:100%;"  name="level" data-required="1" readonly="true" value="<%= Resources.Resource.rejected %>" class="span6 m-wrap"/>

                                    </td>
                                   <td style="text-align: center; width:15% !important;"> 
                                             <input type="text" id="txtStatus4" name="level" data-required="1" class="span12 m-wrap"/>
                                        
                                    </td>
                               </tr>
                           </tbody>
                        </table>
                        </div> 
                        <!--/span-->
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
        <!-- END PAGE CONTENT-->
        
        <div id="divHiddenValues" runat="server" style="display: none">
            <span id="spnSch">0</span>&nbsp;
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
    <script src="<%= path %>assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
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
    <script src="<%= path %>Scripts/jquery.loadmask.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">
        var tempOrg = false;
        var tempGroup = false;
        var tempEmp = false;

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
            $("#liGeneral").addClass("active");
            $("#liGeneral .arrow").addClass("open");
            $("#liWorkflows").addClass("active");
            $("#liWorkflows .arrow").addClass("open");
            $("#liWorkflows").addClass("active");
             

            LoadWorkflow();
            LoadCategories();
            $("#ddType1").change(function () {
                var Type = $("#ddType1").val(); 
                if (Type == "5") {
                    LoadOrganizations($("#ddValue1"));
                }
                if (Type == "4") {
                    LoadRoles($("#ddValue1"));
                }
                if (Type == "3") {
                    LoadGroups($("#ddValue1"));
                }
                if (Type == "1") {
                    LoadManagerList($("#ddValue1"));
                }
                if (Type == "0") {
                    LoadEmployeeList($("#ddValue1"));
                }

            });
            $("#ddType2").change(function () {
                var Type = $("#ddType2").val(); 
                if (Type == "5") {
                    LoadOrganizations($("#ddValue2"));
                }
                if (Type == "4") {
                    LoadRoles($("#ddValue2"));
                }
                if (Type == "3") {
                    LoadGroups($("#ddValue2"));
                }
                if (Type == "1") {
                    LoadManagerList($("#ddValue2"));
                }
                if (Type == "0") {
                    LoadEmployeeList($("#ddValue2"));
                }

            });
            $("#ddType3").change(function () {
                var Type = $("#ddType3").val(); 
                if (Type == "5") {
                    LoadOrganizations($("#ddValue3"));
                }
                if (Type == "4") {
                    LoadRoles($("#ddValue3"));
                }
                if (Type == "3") {
                    LoadGroups($("#ddValue3"));
                }
                if (Type == "1") {
                    LoadManagerList($("#ddValue3"));
                }
                if (Type == "0") {
                    LoadEmployeeList($("#ddValue3"));
                }

            });
            $("#ddType4").change(function () {
                var Type = $("#ddType4").val(); 
                if (Type == "5") {
                    LoadOrganizations($("#ddValue4"));
                }
                if (Type == "4") {
                    LoadRoles($("#ddValue4"));
                }
                if (Type == "3") {
                    LoadGroups($("#ddValue4"));
                }
                if (Type == "1") {
                    LoadManagerList($("#ddValue4"));
                }
                if (Type == "0") {
                    LoadEmployeeList($("#ddValue4"));
                }

            });
            // Declare a proxy to reference the hub. 
            var users = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            users.client.broadcastMessage = function (name, message) {
                if (name == "TAMSR2_Workflows") {
                    
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Workflows', '');
                    // Clear text box and reset focus for next comment. 
                });
            });
             

            if ($('#spnLeave').text() + "" != "0") {
                Edit();
            }
        });
         
          

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
            $("#spnLeave").html("0");

           $("#txtCode").val("");
           $("#txtDescriptionEn").val("");
           $("#txtDescriptionAr").val("");
           $("#txtCommentsEn").val("");
           $("#txtCommentsAr").val("");
           $("#txtMonthDays").val("");
           $("#txtYearDays").val("");



           $("#chkboxNeedApproval").removeAttr("checked");
           $("#uniform-chkboxNeedApproval span").removeClass("checked");

           $("#chkboxOfficial").removeAttr("checked");
           $("#uniform-chkboxOfficial span").removeClass("checked");


           $("#chkboxAllowAttachement").removeAttr("checked");
           $("#uniform-chkboxAllowAttachement span").removeClass("checked");


           $("#chkboxRequiredComments").removeAttr("checked");
           $("#uniform-chkboxRequiredComments span").removeClass("checked");

           $("#chkboxLeaveBalance").removeAttr("checked");
           $("#uniform-chkboxLeaveBalance span").removeClass("checked");


           $("#chkboxWorkingDays").removeAttr("checked");
           $("#uniform-chkboxWorkingDays span").removeClass("checked");

           $("#chkboxExcludeHolidays").removeAttr("checked");
           $("#uniform-chkboxExcludeHolidays span").removeClass("checked");



           $('#ddWorkflow option[value=""]').attr('selected', 'selected');
           $("#ddWorkflow").trigger("liszt:updated");

             
        }

        function Generate() {

           

            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }

            var Level = $('#ddLevel').val();
            
            if (Level == "") {
                $('#divWorkflowActions').css('display', 'none');
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.choose + " " + Resources.Resource.level %>");
                return;
            } 
            if (Level == "1") {
                $('#divWorkflowActions').css('display', 'block');
                $('#row1').css('display', 'table-row');
                $('#row2').css('display', 'none');
                $('#row3').css('display', 'none');
                $('#row4').css('display', 'none');

                $("#ddType1_chzn").css("width", "100%");
                $("#ddValue1_chzn").css("width", "100%");
                $("#ddStep1_chzn").css("width", "100%");
            }
            else if (Level == "2") {
                $('#divWorkflowActions').css('display', 'block');
                $('#row1').css('display', 'table-row');
                $('#row2').css('display', 'table-row');
                $('#row3').css('display', 'none');
                $('#row4').css('display', 'none');

                $("#ddType1_chzn").css("width", "100%");
                $("#ddValue1_chzn").css("width", "100%");
                $("#ddStep1_chzn").css("width", "100%");

                $("#ddType2_chzn").css("width", "100%");
                $("#ddValue2_chzn").css("width", "100%");
                $("#ddStep2_chzn").css("width", "100%");
            }
            if (Level == "3") {
                $('#divWorkflowActions').css('display', 'block');
                $('#row1').css('display', 'table-row');
                $('#row2').css('display', 'table-row');
                $('#row3').css('display', 'table-row');
                $('#row4').css('display', 'none');


                $("#ddType1_chzn").css("width", "100%");
                $("#ddValue1_chzn").css("width", "100%");
                $("#ddStep1_chzn").css("width", "100%");

                $("#ddType2_chzn").css("width", "100%");
                $("#ddValue2_chzn").css("width", "100%");
                $("#ddStep2_chzn").css("width", "100%");

                $("#ddType3_chzn").css("width", "100%");
                $("#ddValue3_chzn").css("width", "100%");
                $("#ddStep3_chzn").css("width", "100%");
            }
            else if (Level == "4") {
                $('#divWorkflowActions').css('display', 'block');
                $('#row1').css('display', 'table-row');
                $('#row2').css('display', 'table-row');
                $('#row3').css('display', 'table-row');
                $('#row4').css('display', 'table-row');

                $("#ddType1_chzn").css("width", "100%");
                $("#ddValue1_chzn").css("width", "100%");
                $("#ddStep1_chzn").css("width", "100%");

                $("#ddType2_chzn").css("width", "100%");
                $("#ddValue2_chzn").css("width", "100%");
                $("#ddStep2_chzn").css("width", "100%");

                $("#ddType3_chzn").css("width", "100%");
                $("#ddValue3_chzn").css("width", "100%");
                $("#ddStep3_chzn").css("width", "100%");

                $("#ddType4_chzn").css("width", "100%");
                $("#ddValue4_chzn").css("width", "100%");
                $("#ddStep4_chzn").css("width", "100%");
            } 
            $('.chzn-drop').css('width', '98%');
            $('.chzn-search').css('width', '98%');
            $('.chzn-search input').css('width', '88%');
            $('.chzn-results').css('width', '98%');

        }


        function LoadOrganizations(obj) { 
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
               success: function (html) { 
                   obj.html(html);
                   obj.trigger("liszt:updated");
                    
               },
               error: function (html) { 
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

        function LoadManagerList(obj) { 
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
               success: function (html) { 
                   obj.html(html);
                   obj.trigger("liszt:updated");
                     
               },
               error: function (html) { 
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

        function LoadGroups(obj) {

            var d = "key=getIdNameListString";
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeGroupPage.aspx") %>',
                success: function (html) {
                    obj.html(html);
                    obj.trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }
        function LoadRoles(obj) {
            var d = "key=getIdNameListString";
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/RolePage.aspx") %>',
                success: function (html) {
                    obj.html(html);
                    obj.trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadEmployeeList(obj) {
            var d = "key=getIdNameListString"; 
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    obj.html(html);
                    obj.trigger("liszt:updated"); 

                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }
        function Edit() {
            var id = $('#spnLeave').text() + "";
            if (id == 0)
                return;

            var v = "key=getByID&id=" + id;
          
            $.ajax({
                type: 'POST',
                data: v,
                 url: '<%= Page.ResolveClientUrl("../RequestPages/WorkflowPage.aspx") %>',
                  success: function (html) {
                     if (html != "") {
                         var j = $.parseJSON(html);
                         $("#spnID").val(j.ID); 
                         $("#txtCode").val(j.Code);

                         $('#ddLevel option[value="' + j.Level + '"]').attr('selected', 'selected');
                         $("#ddLevel").trigger("liszt:updated");
                         setTimeout(function () {
                             $('#ddCat option[value="' + j.Category + '"]').attr('selected', 'selected');
                             $("#ddCat").trigger("liszt:updated");
                         }, 3000);
                         
                         Generate();

                         if (j.Type1 == "5") {
                             LoadOrganizations($("#ddValue1"));
                         }
                         else if (j.Type1 == "4") {
                             LoadRoles($("#ddValue1"));
                         }
                         else if (j.Type1 == "3") {
                             LoadGroups($("#ddValue1"));
                         }
                         else if (j.Type1 == "1") {
                             LoadManagerList($("#ddValue1"));
                         }
                         else if (j.Type1 == "0") {
                             LoadEmployeeList($("#ddValue1"));
                         }

                         if (j.Type2 == "5") {
                             LoadOrganizations($("#ddValue2"));
                         }
                         else if (j.Type2 == "4") {
                             LoadRoles($("#ddValue2"));
                         }
                         else if (j.Type2 == "3") {
                             LoadGroups($("#ddValue2"));
                         }
                         else if (j.Type2 == "1") {
                             LoadManagerList($("#ddValue2"));
                         }
                         else if (j.Type2 == "0") {
                             LoadEmployeeList($("#ddValue2"));
                         }

                         if (j.Type3 == "5") {
                             LoadOrganizations($("#ddValue3"));
                         }
                         else if (j.Type3 == "4") {
                             LoadRoles($("#ddValue3"));
                         }
                         else if (j.Type3 == "3") {
                             LoadGroups($("#ddValue3"));
                         }
                         else if (j.Type3 == "1") {
                             LoadManagerList($("#ddValue3"));
                         }
                         else if (j.Type3 == "0") {
                             LoadEmployeeList($("#ddValue3"));
                         }

                         if (j.Type4 == "5") {
                             LoadOrganizations($("#ddValue4"));
                         }
                         else if (j.Type4 == "4") {
                             LoadRoles($("#ddValue4"));
                         }
                         else if (j.Type4 == "3") {
                             LoadGroups($("#ddValue4"));
                         }
                         else if (j.Type4 == "1") {
                             LoadManagerList($("#ddValue4"));
                         }
                         else if (j.Type4 == "0") {
                             LoadEmployeeList($("#ddValue4"));
                         }

                         if (j.Level == 1) {
                             $('#ddType1 option[value="' + j.Type1 + '"]').attr('selected', 'selected');
                             $("#ddType1").trigger("liszt:updated");

                             setTimeout(function () {
                                 $('#ddValue1 option[value="' + j.Value1 + '"]').attr('selected', 'selected');
                                 $("#ddValue1").trigger("liszt:updated");
                             }, 3000);
                             $('#ddStep1 option[value="' + j.OnSuccess1 + '"]').attr('selected', 'selected');
                             $("#ddStep1").trigger("liszt:updated");

                             $("#txtRejected1").val(j.OnFailure1);
                             $("#txtStatus1").val(j.StatusText1);

                         }
                         else if (j.Level == 2) {
                             $('#ddType1 option[value="' + j.Type1 + '"]').attr('selected', 'selected');
                             $("#ddType1").trigger("liszt:updated");

                             setTimeout(function () {
                                 $('#ddValue1 option[value="' + j.Value1 + '"]').attr('selected', 'selected');
                                 $("#ddValue1").trigger("liszt:updated");
                             }, 3000);

                             $('#ddStep1 option[value="' + j.OnSuccess1 + '"]').attr('selected', 'selected');
                             $("#ddStep1").trigger("liszt:updated");

                             $("#txtRejected1").val(j.OnFailure1);
                             $("#txtStatus1").val(j.StatusText1);

                             $('#ddType2 option[value="' + j.Type2 + '"]').attr('selected', 'selected');
                             $("#ddType2").trigger("liszt:updated");

                             setTimeout(function () {
                                 $('#ddValue2 option[value="' + j.Value2 + '"]').attr('selected', 'selected');
                                 $("#ddValue2").trigger("liszt:updated");
                             }, 3000);
                             $('#ddStep2 option[value="' + j.OnSuccess2 + '"]').attr('selected', 'selected');
                             $("#ddStep2").trigger("liszt:updated");

                             $("#txtRejected2").val(j.OnFailure2);
                             $("#txtStatus2").val(j.StatusText2);

                         }
                         else if (j.Level == 3) {
                             $('#ddType1 option[value="' + j.Type1 + '"]').attr('selected', 'selected');
                             $("#ddType1").trigger("liszt:updated");

                             setTimeout(function () {  
                             $('#ddValue1 option[value="' + j.Value1 + '"]').attr('selected', 'selected');
                             $("#ddValue1").trigger("liszt:updated");
                             }, 3000);
                             $('#ddStep1 option[value="' + j.OnSuccess1 + '"]').attr('selected', 'selected');
                             $("#ddStep1").trigger("liszt:updated");

                             $("#txtRejected1").val(j.OnFailure1);
                             $("#txtStatus1").val(j.StatusText1);

                             $('#ddType2 option[value="' + j.Type2 + '"]').attr('selected', 'selected');
                             $("#ddType2").trigger("liszt:updated");
                             setTimeout(function () {  
                             $('#ddValue2 option[value="' + j.Value2 + '"]').attr('selected', 'selected');
                             $("#ddValue2").trigger("liszt:updated");
                             }, 3000);
                             $('#ddStep2 option[value="' + j.OnSuccess2 + '"]').attr('selected', 'selected');
                             $("#ddStep2").trigger("liszt:updated");

                             $("#txtRejected2").val(j.OnFailure2);
                             $("#txtStatus2").val(j.StatusText2);

                             $('#ddType3 option[value="' + j.Type3 + '"]').attr('selected', 'selected');
                             $("#ddType3").trigger("liszt:updated");
                             setTimeout(function () {  
                             $('#ddValue3 option[value="' + j.Value3 + '"]').attr('selected', 'selected');
                             $("#ddValue3").trigger("liszt:updated");
                             }, 3000);
                             $('#ddStep3 option[value="' + j.OnSuccess3 + '"]').attr('selected', 'selected');
                             $("#ddStep3").trigger("liszt:updated");

                             $("#txtRejected3").val(j.OnFailure3);
                             $("#txtStatus3").val(j.StatusText3);
                         }
                         else if (j.Level == 4) {
                             $('#ddType1 option[value="' + j.Type1 + '"]').attr('selected', 'selected');
                             $("#ddType1").trigger("liszt:updated");

                             setTimeout(function () {
                                 $('#ddValue1 option[value="' + j.Value1 + '"]').attr('selected', 'selected');
                                 $("#ddValue1").trigger("liszt:updated");
                             }, 3000);

                             $('#ddStep1 option[value="' + j.OnSuccess1 + '"]').attr('selected', 'selected');
                             $("#ddStep1").trigger("liszt:updated");
                              
                             $("#txtRejected1").val(j.OnFailure1);
                             $("#txtStatus1").val(j.StatusText1);
                             
                             $('#ddType2 option[value="' + j.Type2 + '"]').attr('selected', 'selected');
                             $("#ddType2").trigger("liszt:updated");

                             setTimeout(function () {
                                 $('#ddValue2 option[value="' + j.Value2 + '"]').attr('selected', 'selected');
                                 $("#ddValue2").trigger("liszt:updated");
                             }, 3000);
                             $('#ddStep2 option[value="' + j.OnSuccess2 + '"]').attr('selected', 'selected');
                             $("#ddStep2").trigger("liszt:updated");

                             $("#txtRejected2").val(j.OnFailure2);
                             $("#txtStatus2").val(j.StatusText2);

                             $('#ddType3 option[value="' + j.Type3 + '"]').attr('selected', 'selected');
                             $("#ddType3").trigger("liszt:updated");

                             setTimeout(function () {
                                 $('#ddValue3 option[value="' + j.Value3 + '"]').attr('selected', 'selected');
                                 $("#ddValue3").trigger("liszt:updated");
                             }, 3000);

                             $('#ddStep3 option[value="' + j.OnSuccess3 + '"]').attr('selected', 'selected');
                             $("#ddStep3").trigger("liszt:updated");

                             $("#txtRejected3").val(j.OnFailure3);
                             $("#txtStatus3").val(j.StatusText3);

                             $('#ddType4 option[value="' + j.Type4 + '"]').attr('selected', 'selected');
                             $("#ddType4").trigger("liszt:updated");
                             setTimeout(function () { 
                             $('#ddValue4 option[value="' + j.Value4 + '"]').attr('selected', 'selected');
                             $("#ddValue4").trigger("liszt:updated");
                             }, 3000);
                             $('#ddStep4 option[value="' + j.OnSuccess4 + '"]').attr('selected', 'selected');
                             $("#ddStep4").trigger("liszt:updated");

                             $("#txtRejected4").val(j.OnFailure4);
                             $("#txtStatus4").val(j.StatusText4);
                         }

                          
                         
                         
                     }
                 },
                 error: function (html) {
  
                 }
             });
             
        }

        function Save() {

            var id = $("#spnLeave").html();

            var code = $("#txtCode").val();
            var Level = $("#ddLevel").val();
            var Cat = $("#ddCat").val();
             
            if (Level == "") {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.choose + " " + Resources.Resource.level %>");
                return;
            }
            var v = "key=save&id="+id+"&Code=" + code + "&Cat=" +Cat;
            if (Level == 1) {
                v += "&Level=" + Level + "&Type1=" + $("#ddType1").val();
                v += "&Value1=" + $("#ddValue1").val();
                v += "&ValueText1=" + $("#ddValue1 option:selected").text();
                v += "&Step1=" + $("#ddStep1").val();
                v += "&Rejected1=" + $("#txtRejected1").val();
                v += "&Status1=" + $("#txtStatus1").val();
            }
            else if (Level == 2) {
                v += "&Level=" + Level;
                v += "&Type1=" + $("#ddType1").val();
                v += "&Value1=" + $("#ddValue1").val();
                v += "&ValueText1=" + $("#ddValue1 option:selected").text();
                v += "&Step1=" + $("#ddStep1").val();
                v += "&Rejected1=" + $("#txtRejected1").val();
                v += "&Status1=" + $("#txtStatus1").val();

                v += "&Type2=" + $("#ddType2").val();
                v += "&Value2=" + $("#ddValue2").val();
                v += "&ValueText2=" + $("#ddValue2 option:selected").text();
                v += "&Step2=" + $("#ddStep2").val();
                v += "&Rejected2=" + $("#txtRejected2").val();
                v += "&Status2=" + $("#txtStatus2").val();

            }
            else if (Level == 3) {
                v += "&Level=" + Level;
                v += "&Type1=" + $("#ddType1").val();
                v += "&Value1=" + $("#ddValue1").val();
                v += "&ValueText1=" + $("#ddValue1 option:selected").text();
                v += "&Step1=" + $("#ddStep1").val();
                v += "&Rejected1=" + $("#txtRejected1").val();
                v += "&Status1=" + $("#txtStatus1").val();

                v += "&Type2=" + $("#ddType2").val();
                v += "&Value2=" + $("#ddValue2").val();
                v += "&ValueText2=" + $("#ddValue2 option:selected").text();
                v += "&Step2=" + $("#ddStep2").val();
                v += "&Rejected2=" + $("#txtRejected2").val();
                v += "&Status2=" + $("#txtStatus2").val();

                v += "&Type3=" + $("#ddType3").val();
                v += "&Value3=" + $("#ddValue3").val();
                v += "&ValueText3=" + $("#ddValue3 option:selected").text();
                v += "&Step3=" + $("#ddStep3").val();
                v += "&Rejected3=" + $("#txtRejected3").val();
                v += "&Status3=" + $("#txtStatus3").val();
            }
            else if (Level == 4) {
                v += "&Level=" + Level;
                v += "&Type1=" + $("#ddType1").val();
                v += "&Value1=" + $("#ddValue1").val();
                v += "&ValueText1=" + $("#ddValue1 option:selected").text();
                v += "&Step1=" + $("#ddStep1").val();
                v += "&Rejected1=" + $("#txtRejected1").val();
                v += "&Status1=" + $("#txtStatus1").val();

                v += "&Type2=" + $("#ddType2").val();
                v += "&Value2=" + $("#ddValue2").val();
                v += "&ValueText2=" + $("#ddValue2 option:selected").text();
                v += "&Step2=" + $("#ddStep2").val();
                v += "&Rejected2=" + $("#txtRejected2").val();
                v += "&Status2=" + $("#txtStatus2").val();

                v += "&Type3=" + $("#ddType3").val();
                v += "&Value3=" + $("#ddValue3").val();
                v += "&ValueText3=" + $("#ddValue3 option:selected").text();
                v += "&Step3=" + $("#ddStep3").val();
                v += "&Rejected3=" + $("#txtRejected3").val();
                v += "&Status3=" + $("#txtStatus3").val();

                v += "&Type4=" + $("#ddType4").val();
                v += "&Value4=" + $("#ddValue4").val();
                v += "&ValueText4=" + $("#ddValue4 option:selected").text();
                v += "&Step4=" + $("#ddStep4").val();
                v += "&Rejected4=" + $("#txtRejected4").val();
                v += "&Status4=" + $("#txtStatus4").val();
            }
              
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/WorkflowPage.aspx") %>',
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
                    //   window.location = '<%= Page.ResolveClientUrl("~/Common/Workflows") %>'; 
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("Error! " + html);
               }

           });
        }
        function CloseForm() {
            window.location = '<%= Page.ResolveClientUrl("~/Common/Workflows") %>'; 
        }


        function LoadWorkflow() {
            var d = "key=getActionIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/WorkflowPage.aspx") %>',
                success: function (html) {
                    $("#ddType1").html(html);
                    $("#ddType1").trigger("liszt:updated");
                    $("#ddType2").html(html);
                    $("#ddType2").trigger("liszt:updated");
                    $("#ddType3").html(html);
                    $("#ddType3").trigger("liszt:updated");
                    $("#ddType4").html(html);
                    $("#ddType4").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }


        function LoadCategories() {
            var d = "key=getCategoryIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/WorkflowPage.aspx") %>',
                success: function (html) {
                    $("#ddCat").html(html);
                    $("#ddCat").trigger("liszt:updated");  
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
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

        $("#txtFrom").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
        $("#txtToDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
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
                    code: {
                        required: true
                    },
                    value: {
                        required: true,
                        minlength: 1
                    } 
                },

                messages: { // custom messages for radio buttons and checkboxes
                    code: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    value: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    } 
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.attr("name") == "emp" || element.attr("name") == "leave") { // for uniform checkboxes, insert the after the given container
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
