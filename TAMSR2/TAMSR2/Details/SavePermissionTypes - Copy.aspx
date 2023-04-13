<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SavePermissionTypes.aspx.cs" Inherits="TAMSR2.Details.SavePermissionTypes" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.permissionTypes %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <!-- END PAGE LEVEL STYLES -->
<%--<style>
/*.alert-danger, .alert-error {
    color: #b94a48;
    background-color: #f2dede;
    border-color: #eed3d7;
    display: none !important;
}*/

</style>--%>
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
                    <%=Resources.Resource.permissionTypes %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Permission-Types") %>'><%=Resources.Resource.permissionTypes %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href='#'><%=Resources.Resource.permissionTypes %></a></li>

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
                        <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                    </div>
                    <div id="divSuccessMsg" class="alert alert-success hide">
                        <button class="close" data-dismiss="alert"></button>
                        <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                    </div>
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.reason %> <span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddReason" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="reason" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.reason %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.code %> <span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <input type="text" id="txtCode" name="code" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.descriptionEn %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input type="text" id="txtDescriptionEn" name="nameEn" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.descriptionAr %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input type="text" id="txtDescriptionAr" name="nameAr" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.maxMinutesPerDay %> </label>
                                <div class="controls">
                                    <input type="text" id="txtMaxMinutesPerDay" name="maxMinutesPerDay" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.maxPermissionPerDay %></label>
                              <div class="controls">
                                 <input type="text" id="txtMaxPermPerDay" name="maxPermPerDay" data-required="1"  style="width: 220px !important;" class="span6 m-wrap"/>
                              </div>
                           </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.maxMinutesPerMonth %> </label>
                                <div class="controls">
                                    <input type="text" id="txtMaxMinutesPerMonth" name="maxMinutesPerMonth" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.maxPermissionPerMonth %></label>
                              <div class="controls">
                                 <input type="text" id="txtMaxPermPerMonth" name="maxPermPerMonth" data-required="1"  style="width: 220px !important;" class="span6 m-wrap"/>
                              </div>
                           </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.minPermissionTime %></label>
                                <div class="controls">
                                    <input type="text" id="txtMinDurationPerPermission" name="minDurationPerPermission" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.maxPermissionTime %></label>
                              <div class="controls">
                                 <input type="text" id="txtMaxDurationPerPermission" name="maxDurationPerPermission" data-required="1"  style="width: 220px !important;" class="span6 m-wrap"/>
                              </div>
                           </div>
                        </div>
                        <!--/span-->
                    </div>

                    <div class="row-flud">
                        <h4 class="form-section"> Policy </h4>
                    </div>
                    <div class="row-flud form-section">
                        <div class="control-group" id="divWorkflow">
                                <label class="control-label"><%=Resources.Resource.workflow %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddWorkflow" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="Workflow" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                             <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxGroupApply" type="checkbox" name="groupApply" /> <%=Resources.Resource.groupApply %>
                               </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                             <div class="control-group">
                               <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxOfficial" type="checkbox" name="official" /> <%=Resources.Resource.official %>
                               </div>

                           </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    
                    <div class="row-fluid">
                        <div class="span6 ">
                             <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxHRonly" type="checkbox" name="hrOnly" /> <%=Resources.Resource.hrOnly %>
                               </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                             <div class="control-group">
                               <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxAllowAttachement" type="checkbox" name="allowAttachement" /> <%=Resources.Resource.allowAttachement %>
                               </div>
                           </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                             <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="ckhboxApplyRamadanRestriction" type="checkbox" name="ApplyRamadanRestriction" /> <%=Resources.Resource.applyRamadanRestriction %>
                               </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                             
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="portlet">
                            <div class="portlet-title"></div>
                            <div class="portlet-body">
                                <div class="span6 ">
                                     <label class="control-label">&nbsp;</label>
                                       <div class="controls">
                                           <input id="ckboxNationality" type="checkbox" name="nationality" /> <%=Resources.Resource.nationalityRestrictions %>
                                       </div>
                                </div>
                                <!--/span-->
                                <div class="span6 ">
                                      <div class="control-group" style="display:none;" id ="divNat">
                                      <label class="control-label"><%=Resources.Resource.nationality %></label>
                                      <div class="controls chzn-controls">
                                         <select id="ddNat" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="nationality" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.nationality %>" tabindex="1">
                                            <option value=""></option>
                                            <option value="1"><%=Resources.Resource.late  %></option>
                                            <option value="2"><%=Resources.Resource.early %></option>
                                            <option value="3"><%=Resources.Resource.missTime %></option>
                                         </select>
                                      </div>
                                   </div>
                                </div>
                                <!--/span-->
                            </div>
                        </div>
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                         <div class="portlet">
                            <div class="portlet-title"></div>
                            <div class="portlet-body">
                                <div class="span6 ">
                                    <div class="control-group">
                                      <label class="control-label"></label>
                                        <div class="controls">
                                        <label class="radio">
                                         <div class="radio" id="divHoursPermissions"><span class=""><input type="radio" name="Permission" value="1"  style="opacity: 0;"></span></div>
                                          <%=Resources.Resource.byHoursPermissions %>
                                  </label>
                                  
                                       </div>
                                   </div>
                                </div>
                        <!--/span-->
                            <div class="span6 ">
                               <div class="control-group" id="divPriority" style="display:none;">
                                  <label class="control-label"><%=Resources.Resource.priority %></label>
                                  <div class="controls chzn-controls">
                                     <select id="ddPriority" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="priority" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.priority %>" tabindex="1">
                                  
                                        <option value="1"><%=Resources.Resource.late  %></option>
                                        <option value="2"><%=Resources.Resource.early %></option>
                                        <option value="3"><%=Resources.Resource.missTime %></option>
                                     </select>
                                  </div>
                               </div>
                            </div>
                            <!--/span-->
                            </div>
                            </div>
                    </div>
                    <!--/row-->
                    
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                              <label class="control-label"></label>
                                <div class="controls">
                                  <label class="radio">
                                      <div class="radio" id="divTimePermissions"><span class="checked"><input type="radio" name="Permission" value="0" checked="" style="opacity: 0;"></span></div>
                                                  <%=Resources.Resource.byTimePermissions %>
                                  </label>
                               </div>
                           </div>
                        </div>
                        <div class="span6 ">
                        </div>
                    </div>
                    <!-- /row -->
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                              <label class="control-label"></label>
                                <div class="controls">
                                  <label class="radio">
                                    <div class="radio" id="divWeekPermssions"><span><input type="radio" name="Permission" value="2" style="opacity: 0;"></span></div>
                                          <%=Resources.Resource.byWeekPermssions %>
                                  </label>   
                               </div>
                           </div>
                        </div>
                        <div class="span6 ">

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
        <!-- END PAGE CONTENT-->
        
        <div id="divHiddenValues" runat="server" style="display: none">
            <span id="spnPerm">0</span>&nbsp;
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
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">
        var tempEmp = false;
        var tempLeave = false;

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
            $("#liGeneralPermissionType").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

            $('input[type=radio][name=Permission]').change(function () {
                if (this.value == '1' || this.value == '2') {
                    $("#divPriority").css("display", "block");
                }
                else   {
                    $("#divPriority").css("display", "none");
                }
            });
            $("#ckboxNationality").change(function () {
                if ($(this).is(":checked")) {
                    $("#divNat").css("display", "block");
                }
                else {
                    $("#divNat").css("display", "none");
                }
            });
            // Declare a proxy to reference the hub. 
            var users = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            users.client.broadcastMessage = function (name, message) {
                if (name == "TAMSR2_Single_Permission") {
                    //ReloadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Single_Permission', '');
                    // Clear text box and reset focus for next comment. 
                });
            });

            LoadReasons();
            LoadWorkflow();
            LoadCountries();
        });
         
        function CloseForm() {
            window.location = '<%= Page.ResolveClientUrl("~/Common/Permission-Types") %>';
        }
        
        function LoadCountries() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/CountryPage.aspx") %>',
               success: function (html) {
                   $("#ddNat").html(html);
                   $("#ddNat").trigger("liszt:updated");
                   var id = $("#spnPerm").html();

                   if (id != "" && id != "0") {
                       Edit(id);
                   }
               },
               error: function (html) { 
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

        function LoadReasons() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ReasonPage.aspx") %>',
               success: function (html) {
                   $("#ddReason").html(html);
                   $("#ddReason").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
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
                url: '<%= Page.ResolveClientUrl("../RequestPages/PermissionTypePage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       $("#spnID").val(j.ID);
                       $("#txtDescriptionEn").val(j.DescriptionEn);
                       $("#txtDescriptionAr").val(j.DescriptionAr);
                       $("#txtCode").val(j.Code);
                       $("#txtMaxPermissions").val(j.MaxPermissions);
                       $("#txtMaxMinutes").val(j.MaxMinutes);


                       $("#txtMaxPermPerDay").val(j.MaxPermissionsPerDay);
                       $("#txtMaxMinutesPerDay").val(j.MaxMinutesPerDay);

                       $("#txtMaxPermPerMonth").val(j.MaxPermissionsPerMonth);
                       $("#txtMaxMinutesPerMonth").val(j.MaxMinutesMinutesPerMonth);

                       $("#txtMinDurationPerPermission").val(j.MinPermissionTime);
                       $("#txtMaxDurationPerPermission").val(j.MaxPermissionTime);


                       $('#ddReason option[value=' + j.ReasonID + ']').attr('selected', 'selected');
                       $("#ddReason").trigger("liszt:updated");
                       if (j.GroupApplyFlag + "" == "1") {
                           $("#chkboxGroupApply").attr("checked", "checked");
                           $("#uniform-chkboxGroupApply span").addClass("checked");
                       }
                       if (j.OfficialFlag + "" == "Y" || j.OfficialFlag + "" == "y") {
                           $("#chkboxOfficial").attr("checked", "checked");
                           $("#uniform-chkboxOfficial span").addClass("checked");
                       }
                       if (j.HrOnlyFlag + "" == "1") {
                           $("#chkboxHRonly").attr("checked", "checked");
                           $("#uniform-chkboxHRonly span").addClass("checked");
                       }
                       if (j.AllowAttachment + "" == "1") {
                           $("#chkboxAllowAttachement").attr("checked", "checked");
                           $("#uniform-chkboxAllowAttachement span").addClass("checked");
                       } 
                       if (j.ApplyNationalityRestriction + "" == "1") {
                           $("#ckboxNationality").attr("checked", "checked");
                           $("#uniform-ckboxNationality span").addClass("checked");
                           $("#divNat").css("display", "block");
                       }
                       else
                       {
                           $("#divNat").css("display", "none");
                       } 

                       if (j.ApplyRamadanRestriction + "" == "1") {
                           $("#ckhboxApplyRamadanRestriction").attr("checked", "checked");
                           $("#uniform-ckhboxApplyRamadanRestriction span").addClass("checked");
                       }
                       $('#ddNat option[value=' + j.NationalityID + ']').attr('selected', 'selected');
                       $("#ddNat").trigger("liszt:updated");

                       $('#ddPriority option[value=' + j.PriorityID + ']').attr('selected', 'selected');
                       $("#ddPriority").trigger("liszt:updated");
                       
                       if (j.PermissionTypeID == "0") {
                           $("#divTimePermissions span").addClass('checked');
                           $("#divHoursPermissions span").removeClass('checked');
                           $("#divWeekPermssions span").removeClass('checked');
                           $("#divPriority").css("display", "none");
                       }
                       else if(j.PermissionTypeID == "1")
                       { 
                           $("#divHoursPermissions span").addClass('checked');
                           $("#divTimePermissions span").removeClass('checked');
                           $("#divWeekPermssions span").removeClass('checked');
                           $("#divPriority").css("display", "block");
                       }
                       else if(j.PermissionTypeID == "2")
                       {
                           $("#divWeekPermssions span").addClass('checked'); 
                           $("#divTimePermissions span").removeClass('checked');
                           $("#divHoursPermissions span").removeClass('checked');
                           $("#divPriority").css("display", "block");
                       }
                       else {
                           $("#divTimePermissions span").addClass('checked');
                           $("#divHoursPermissions span").removeClass('checked');
                           $("#divWeekPermssions span").removeClass('checked');
                           $("#divPriority").css("display", "none");
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
          
           var code = $("#txtCode").val();
           var reasonID = $("#ddReason").val();
           var groupApply = $("#chkboxGroupApply").is(":checked");
           var official = $("#chkboxOfficial").is(":checked");
           var hrOnly = $("#chkboxHRonly").is(":checked");
           var allowAttachment = $("#chkboxAllowAttachement").is(":checked");
           var applyNationality = $("#ckboxNationality").is(":checked");
           var ApplyRamadanRestriction = $("#ckhboxApplyRamadanRestriction").is(":checked");

           var NationalityID = $("#ddNat").val();
           var PriorityID = $("#ddPriority").val();

           var maxPermissionsPerDay = $("#txtMaxPermPerDay").val();
           var maxMinutesPerDay = $("#txtMaxMinutesPerDay").val();

           var maxPermissionsPerMonth = $("#txtMaxPermPerMonth").val();
           var maxMinutesPerMonth = $("#txtMaxMinutesPerMonth").val();

           var MinPermissionTime = $("#txtMinDurationPerPermission").val();
           var MaxPermissionTime = $("#txtMaxDurationPerPermission").val();

           var PermissionTypeID = $('input[type=radio][name=Permission]:checked').val();
           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }

           var v = "key=save" + "&id=" + id + "&code=" + code + "&reasonID=" + reasonID;
           v += "&descriptionEn=" + descriptionEn + "&descriptionAr=" + descriptionAr + "&groupApply=" + groupApply+ "&official=" + official;
           v += "&hrOnly=" + hrOnly + "&allowAttachment=" + allowAttachment + "&applyNationality=" + applyNationality;
           v += "&NationalityID=" + NationalityID + "&PriorityID=" + PriorityID + "&PermissionTypeID=" + PermissionTypeID;
           v += "&ApplyRamadanRestriction=" + ApplyRamadanRestriction;
           v += "&maxPermissionsPerDay=" + maxPermissionsPerDay + "&maxMinutesPerDay=" + maxMinutesPerDay;
           v += "&maxPermissionsPerMonth=" + maxPermissionsPerMonth + "&maxMinutesPerMonth=" + maxMinutesPerMonth;
           v += "&MinPermissionTime=" + MinPermissionTime + "&MaxPermissionTime=" + MaxPermissionTime;
            
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/PermissionTypePage.aspx") %>',
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

        function LoadWorkflow() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/WorkflowPage.aspx") %>',
                success: function (html) {
                     
                    $("#ddWorkflow").html(html);
                    $("#ddWorkflow").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
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

            $("#txtDescriptionEn").val("");
            $("#txtDescriptionAr").val("");
            $("#txtMaxPermissions").val("");
            $("#txtMaxMinutes").val("");
            $("#txtCode").val("");

            $("#chkboxOfficial").removeAttr("checked");
            $("#uniform-chkboxOfficial span").removeClass("checked");

            $("#chkboxGroupApply").removeAttr("checked");
            $("#uniform-chkboxGroupApply span").removeClass("checked");

            $("#chkboxHRonly").removeAttr("checked");
            $("#uniform-chkboxHRonly span").removeClass("checked");

            $("#chkboxAllowAttachement").removeAttr("checked");
            $("#uniform-chkboxAllowAttachement span").removeClass("checked");

            $("#ckboxNationality").removeAttr("checked");
            $("#uniform-ckboxNationality span").removeClass("checked");


            $("#ckhboxApplyRamadanRestriction").removeAttr("checked");
            $("#uniform-ckhboxApplyRamadanRestriction span").removeClass("checked");

            
            $('#ddReason option[value=""]').attr('selected', 'selected');
            $("#ddReason").trigger("liszt:updated");

            $('#ddNat option[value=""]').attr('selected', 'selected');
            $("#ddNat").trigger("liszt:updated");

            $('#ddPriority option[value=""]').attr('selected', 'selected');
            $("#ddPriority").trigger("liszt:updated");

        }

var FormComponents = function () {

    var handlejQueryUIDatePickers = function () {
        $(".ui-date-picker").datepicker();
    }

    var handleDateTimePickers = function () {

        if (jQuery().datepicker) {
            $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
        }

        $(".date-picker").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
        if (jQuery().timepicker) {
            //$('.timepicker-default').timepicker();
            //$('.timepicker-24').timepicker({
            //    minuteStep: 1,
            //    showSeconds: false,
            //    showMeridian: false
            //});
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

        $("#txtFrom").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
        $("#txtToDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
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
                    emp: {
                        required: true
                    },
                    permType: {
                        required: true
                    },
                    fromDate: {
                        required: true
                    },
                    toDate: {
                        required: true
                    },
                    fromTime: {
                        required: true
                    },
                    toTime: {
                        required: true
                    },
                    remarks: {
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    emp: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    permType: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    fromDate: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    toDate: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    fromTime: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    toTime: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    remarks: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    //if (element.attr("name") == "emp" || element.attr("name") == "permType") { // for uniform checkboxes, insert the after the given container
                    //    error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                    //} else {
                    //    error.insertAfter(element); // for other inputs, just perform default behavoir
                    //}
                    error.insertAfter(element);
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

