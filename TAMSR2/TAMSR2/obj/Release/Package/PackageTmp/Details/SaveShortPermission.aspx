<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveShortPermission.aspx.cs" Inherits="TAMSR2.Details.SaveShortPermission" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.shortPermission %> - <%=Resources.Resource.applicationName %></title>
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
                    <%=Resources.Resource.shortPermission %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="<%= Page.ResolveClientUrl("~/Leaves/Short-Permission") %>"><%=Resources.Resource.shortPermission %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href='#'><%=Resources.Resource.apply +  Resources.Resource.permissions  %></a></li>

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
                    <div>&nbsp;</div>
                    
                    <div id="divInfoMsg" class="alert alert-success hide">
                        <button class="close" data-dismiss="alert"></button>
                        <span id="spnInfoMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                    </div>

                    <div class="row-fluid  hide" id="permBalanceRow">
                        <div class="span12 alert alert-block alert-info fade in">
                            <div id="permBalance">
                                <h4 class="alert-heading"></h4>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label" id="lblTxt"><%=Resources.Resource.employee %> <span class="required">*</span></label>
                                <div class="controls chzn-controls" id="divEmp">
                                    <select id="ddEmployee" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="emp" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                                <div class="controls chzn-controls hide" id="divEmpGroup">
                                    <select id="ddEmpGroup" name="ddgroup" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.group %>">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->

                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.permissionType %> <span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddPermType" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="permType" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>" tabindex="1">
                                        <option value=""></option>
                                    </select>

                                    <div id="permissionAttachmentBox" style="display: none; cursor: pointer;">
                                        <img src="<%= Page.ResolveClientUrl("/images/attachement.png") %>" alt="click here to upload" />
                                        <span><%=Resources.Resource.msgAttachment %></span>
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
                                <label class="control-label"><%=Resources.Resource.fromDate %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.toDate %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid" id="divTime">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.fromTime %> <span class="required">*</span></label>
                                <div class="controls">
                                    <div class="input-append bootstrap-timepicker-component">
                                        <input type="text" id="txtFromTime" name="fromTime" class="m-wrap m-ctrl-small timepicker-24" value="00:00">
                                        <span class="add-on"><i class="icon-time"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.toTime %> <span class="required">*</span></label>
                                <div class="controls">
                                    <div class="input-append bootstrap-timepicker-component">
                                        <input type="text" id="txtToTime" name="toTime" class="m-wrap m-ctrl-small timepicker-24" value="00:00">
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
                                <label class="control-label"><%=Resources.Resource.justification %>  </label>
                                <div class="controls">
                                    <input type="text" id="txtRemarks" name="remarks" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                    <input type="file" id="permissionAttachment" accept="application/pdf" name="permissionAttachment" style="display: none;" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group" id="divMinutes" style="display: none;">
                                <label class="control-label"><%=Resources.Resource.minutes %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input type="text" id="txtMinutes" onkeypress="return isNumberKey(event);" name="minutes" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row -->
                    <div class="row-fluid">
                        <div class="span6 hide" id="divAutoApprove">
                            <div class="control-group">
                                <label class="control-label">&nbsp;</label>
                                <div class="controls">
                                    <input id="chkboxAutoApprove" type="checkbox" name="autoApprove" checked="checked" />
                                    <%=Resources.Resource.approve %>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>

                    <!--/row-->

                    <div class="row-fluid" id="divWeekDays" style="display: none;">
                        <div class="span10" style="margin-left: 7% !important;">
                            <table class="table table-striped table-bordered table-advance table-hover">
                                <thead>
                                    <tr>
                                        <th><%= Resources.Resource.saturday %></th>
                                        <th><%= Resources.Resource.sunday %></th>
                                        <th><%= Resources.Resource.monday %></th>
                                        <th><%= Resources.Resource.tuesday %></th>
                                        <th><%= Resources.Resource.wednesday %></th>
                                        <th><%= Resources.Resource.thursday %></th>
                                        <th><%= Resources.Resource.friday %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input type="text" id="txtSat" name="sat" onkeypress="return isNumberKey(event);" data-required="1" class="span12 m-wrap" disabled="disabled" /></td>
                                        <td>
                                            <input type="text" id="txtSun" name="sun" onkeypress="return isNumberKey(event);" data-required="1" class="span12 m-wrap" /></td>
                                        <td>
                                            <input type="text" id="txtMon" name="mon" onkeypress="return isNumberKey(event);" data-required="1" class="span12 m-wrap" /></td>
                                        <td>
                                            <input type="text" id="txtTue" name="tue" onkeypress="return isNumberKey(event);" data-required="1" class="span12 m-wrap" /></td>
                                        <td>
                                            <input type="text" id="txtWed" name="wed" onkeypress="return isNumberKey(event);" data-required="1" class="span12 m-wrap" /></td>
                                        <td>
                                            <input type="text" id="txtThu" name="thu" onkeypress="return isNumberKey(event);" data-required="1" class="span12 m-wrap" /></td>
                                        <td>
                                            <input type="text" id="txtFri" name="fri" onkeypress="return isNumberKey(event);" data-required="1" class="span12 m-wrap" disabled="disabled" /></td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!--/row-->


                    <div class="row-fluid">

                        <div class="span12 " id="divCommentsMsg" style="width: 90%; padding-left: 7%; padding-right: 6%; padding-top: 3%; display: none;">
                            <div class="control-group">
                                <div class="alert alert-block alert-info fade in">
                                    <h4 class="alert-heading"><%= Resources.Resource.note %></h4>
                                    <span id="spanCommentsMsg">
                                    </span>
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
            $("#liLeaveGroup").addClass("active");
            $("#liLeaveGroup .arrow").addClass("open");
            $("#liShortPermission").addClass("active");


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

            $("#txtFromTime").val("00:00");
            $("#txtToTime").val("00:00");
            $("#txtFromTime").change(function () {
                if ($("#txtFromTime").val() == '')
                    $("#txtFromTime").val("00:00");
            });

            $("#txtToTime").change(function () {
                if ($("#txtToTime").val() == '')
                    $("#txtToTime").val("00:00");
            });

            $("#txtFromDate").change(function () {
               LoadPermissionBalance();
            });
            $("#txtToDate").change(function () {
                LoadPermissionBalance();
            });
            $('#ddEmpGroup').change(function () {

                var GroupEmployees = $('#ddEmpGroup :selected').attr('employeescount')
                $("#divCommentsMsg").css("display", "none");
                debugger;
                if (GroupEmployees == "0" || GroupEmployees == 0) {
                    $("#btnSave").attr("disabled", "disabled");
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("Sorry! you can not apply this permission, there is no employee in selected group.");

                }
                else {
                    $("#divErrorMsg").css("display", "none");
                    $("#btnSave").removeAttr("disabled", "disabled");


                    $("#divCommentsMsg").css("display", "block");
                    $("#spanCommentsMsg").html("Selected Group Employee : " + GroupEmployees);

                }
            });
            $('#ddPermType').change(function () {
                debugger
                if ($("#ddEmployee").val() != "0" || $("#ddEmployee").val() != "") {
                    LoadPermissionBalance();
                }
                else { 
                    var mesg = "<span id='spanCommentsMsg'>Please Select Employee to get Permission Balance</span>";
                     $('#permBalanceRow').removeClass('hide');
                     $("#permBalance").html(mesg);
                }
                $('#divErrorMsg').addClass('hide');
                $('#divSuccessMsg').addClass('hide');
                $('#divInfoMsg').addClass('hide');

                var allowAttachement = $('#ddPermType :selected').attr('allowAttachement')
                var hrOnly = $('#ddPermType :selected').attr('hrOnly')
                var NationalityRestrictions = $('#ddPermType :selected').attr('NationalityRestrictions')
                var PermissionType = $('#ddPermType :selected').attr('PermissionType')
                var AttachmentRemarks = $('#ddPermType :selected').attr('Comments')
                var GroupApply = $('#ddPermType :selected').attr('GroupApply')


                if (GroupApply == "1") {

                    $('#lblTxt').html("<%= Resources.Resource.groups %>" + "  <span class='required'>*</span>");
                    $('#ddEmployee option[value=""]').attr('selected', 'selected');
                    $("#ddEmployee").trigger("liszt:updated");
                    $('#divEmp').addClass('hide');
                    $('#divEmpGroup').removeClass('hide');
                    $('#divAutoApprove').removeClass('hide');

                }
                else {
                    $('#ddEmpGroup').val("");
                    $("#ddEmpGroup").trigger("liszt:updated");
                    $('#lblTxt').html("<%= Resources.Resource.employee %>" + "  <span class='required'>*</span>");
                    $('#divEmp').removeClass('hide');
                    $('#divEmpGroup').addClass('hide');

                    $("#chkboxOvertime").attr("checked", "checked");
                    $("#uniform-chkboxAutoApprove span").removeClass("checked");
                    $('#divAutoApprove').addClass('hide');

                }


                if (allowAttachement == "1") {

                    $('#spnInfoMsg').html("<%= Resources.Resource.limitFileUpload %>");
                    $('#divInfoMsg').removeClass('hide');
                    $('#permissionAttachmentBox').show();
                }
                else {
                    $('#permissionAttachmentBox').hide();
                }

                if (AttachmentRemarks != "") {
                    $('#spanCommentsMsg').html(AttachmentRemarks);
                    $('#divCommentsMsg').css('display', 'block');
                }
                else {
                    $('#divCommentsMsg').css('display', 'none');
                }

                $("#txtFromTime").val("00:00");
                $("#txtToTime").val("00:00");
                $("#txtMinutes").val("");

                $("#txtSun").val("");
                $("#txtMon").val("");
                $("#txtTue").val("");
                $("#txtWed").val("");
                $("#txtThu").val("");
                $("#txtFri").val("");
                $("#txtSat").val("");


                if (PermissionType == "1") {
                    $('#divMinutes').css("display", "block");
                    $('#divTime').css("display", "none");
                    $('#divWeekDays').css("display", "none");
                }
                else if (PermissionType == "2") {
                    $('#divMinutes').css("display", "none");
                    $('#divTime').css("display", "none");
                    $('#divWeekDays').css("display", "block");
                }
                else {
                    $('#divMinutes').css("display", "none");
                    $('#divTime').css("display", "block");
                    $('#divWeekDays').css("display", "none");
                }

                if (allowAttachement == "1") {

                    $('#spnInfoMsg').html("<%= Resources.Resource.limitFileUpload %>");
                    $('#divInfoMsg').removeClass('hide');
                    $('#permissionAttachmentBox').show();
                }
                else {
                    $('#permissionAttachmentBox').hide();
                }
                CheckCountaryCombatibility();
                DateChangeCheck();
            });

            $("#ddEmployee").change(function () {
                LoadPermissionBalance();
                CheckCountaryCombatibility();
            });
            LoadEmployeeList();
            LoadPermissionTypeList();
            LoadGroups();

            $('#permissionAttachmentBox').click(function () {
                $('#permissionAttachment').click();
            });

            var permissionAttachment = document.getElementById("permissionAttachment");
            permissionAttachment.onchange = function (e) {
                $('#divErrorMsg').addClass('hide');
                $('#divSuccessMsg').addClass('hide');
                $('#divInfoMsg').addClass('hide');
                e.stopPropagation(); // Stop stuff happening
                e.preventDefault(); // Totally stop stuff happening
                //msgErrorFileSize
                var ext = this.value.match(/\.(.+)$/)[1];
                switch (ext) {
                    case 'pdf':
                        break;
                    default:
                        $('#spnErrorMsg').html("<%=Resources.Resource.msgWrongFileError %>");
                        $('#divMsgError').removeClass('hide');
                        this.value = '';
                }
            };
        });

        function DateChangeCheck() {
            var PermissionType = $('#ddPermType :selected').text();

            var str1 = $('#txtFromDate').val();
            var dt1 = "";
            var mon1 = "";
            var yr1 = "";
            var hh1 = "";
            var mm1 = "";
            var fromDate = "";
            if (str1.indexOf('-') > 0) {
                dt1 = str1.substring(0, 2);
                mon1 = str1.substring(3, 5);
                yr1 = str1.substring(6, 10);
            }
            else {
                dt1 = str1.substring(0, 2);
                mon1 = str1.substring(2, 4);
                yr1 = str1.substring(4, 8);
            }
            fromDate = yr1 + "-" + mon1 + "-" + dt1;

            var str2 = $('#txtToDate').val();
            var dt2 = "";
            var mon2 = "";
            var yr2 = "";
            var hh2 = "";
            var mm2 = "";
            var toDate = "";
            if (str2.indexOf('-') > 0) {
                dt2 = str2.substring(0, 2);
                mon2 = str2.substring(3, 5);
                yr2 = str2.substring(6, 10);
            }
            else {
                dt2 = str2.substring(0, 2);
                mon2 = str2.substring(2, 4);
                yr2 = str2.substring(4, 8);
            }
            toDate = yr2 + "-" + mon2 + "-" + dt2;

            if (PermissionType.trim() == "Medical Pass") {

                var todayDate = new Date();
                if (new Date(fromDate).setHours(0, 0, 0, 0) < todayDate.setHours(0, 0, 0, 0) || new Date(toDate).setHours(0, 0, 0, 0) < todayDate.setHours(0, 0, 0, 0)) {

                    $("#btnSave").attr("disabled", "disabled");
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("Sorry! you can not apply back dated permission. Please change the date of permission to apply.");

                }
                else {

                    $("#divErrorMsg").css("display", "none");
                    $("#btnSave").removeAttr("disabled", "disabled");
                }
            }
            else {
                $("#divErrorMsg").css("display", "none");
                $("#btnSave").removeAttr("disabled", "disabled");
            }
        }

        function CheckCountaryCombatibility() {

            var PermNatID = $('#ddPermType :selected').attr('nationalityid')
            var EmpNatID = $('#ddEmployee :selected').attr('countryid')
            if (PermNatID != "" && EmpNatID != "" && PermNatID != undefined && EmpNatID != undefined && PermNatID != "0") {
                if (PermNatID != EmpNatID) {
                    $("#btnSave").attr("disabled", "disabled");
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("Sorry! you can not apply this permission, nationality restriction applies. Please change the type of permission to apply.");

                }
                else {
                    $("#divErrorMsg").css("display", "none");
                    $("#btnSave").removeAttr("disabled", "disabled");
                }
            }
            else {
                $("#divErrorMsg").css("display", "none");
                $("#btnSave").removeAttr("disabled", "disabled");
            }
        }


        function LoadGroups() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");
            var d = "key=getIdNameListString";
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeGroupPage.aspx") %>',
                success: function (html) {
                    $("#ddEmpGroup").html(html);
                    $("#ddEmpGroup").trigger("liszt:updated");
                    LoadEmployees();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }


        function LoadEmployeeList() {
            var d = "key=getIdNameListWithDept";
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    $("#ddEmployee").html(html);
                    if ("<%= Session["ID"] %>" != "1")
                        $("#ddEmployee").val("<%= Session["ID"] %>");
                    $("#ddEmployee").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    tempEmp = true;
                    var spnPerm = $('#spnPerm').text();
                    if (spnPerm != "0" && spnPerm != "MA==" && spnPerm == true) {
                        Edit(spnPerm);
                    }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadPermissionTypeList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/PermissionTypePage.aspx") %>',
                success: function (html) {
                    $("#ddPermType").html(html);
                    $("#ddPermType").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    spnPerm = true;
                    var spnPerm = $('#spnPerm').text();
                    if (spnPerm != "0" && spnPerm != "MA==" && tempEmp == true) {
                        Edit(spnPerm);
                    }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }
        function CloseForm() {
            window.location = '<%= Page.ResolveClientUrl("~/Leaves/Short-Permission") %>';
        }

        function Clear() {

            $('#permissionAttachment').val("");
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
            $("#txtFromDate").val("");
            $("#txtToDate").val("");
            $("#txtFromTime").val("00:00");
            $("#txtToTime").val("00:00");
            $("#txtRemarks").val("");

            $('#ddEmployee option[value=""]').attr('selected', 'selected');
            $("#ddEmployee").trigger("liszt:updated");
            //$("#txtCategory").val("");
            //$("#txtService").val("");
            $('#permissionAttachment').val("");
        }

        function Edit(id) {
            //Edit code
            var v = "key=getByID&id=" + id;
            $("#btnAdd").click();
            $("#spnGridMsg").html("&nbsp;");
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/SinglePermissionPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);
                        $("#spnID").val(j.ID);
                        if (j.ID == "0") {
                            $("#spnID").html(j.ID);
                            return;
                        }

                        if (j.FromDateTimeStr != '') {
                            $('#txtFromDate').datepicker({ format: 'yyyy-mm-dd' });

                            $("#txtFromDate").datepicker('update', j.FromDateTimeStr);
                            //  $('.date-picker').datepicker('setStartDate', j.JoinDateStr);
                        }
                        else {
                            $("#txtFromDate").datepicker({
                                format: " yyyy",
                                viewMode: "days",
                                minViewMode: "years"
                            });
                        }
                        if (j.ToDateTimeStr != '') {
                            $('#txtToDate').datepicker({ format: 'yyyy-mm-dd' });

                            $("#txtToDate").datepicker('update', j.ToDateTimeStr);
                            //  $('.date-picker').datepicker('setStartDate', j.JoinDateStr);
                        }
                        else {
                            $("#txtToDate").datepicker({
                                format: " yyyy",
                                viewMode: "days",
                                minViewMode: "years"
                            });
                        }
                        if (j.FromTime == "")
                            j.FromTime = "00:00";
                        if (j.ToTime == "")
                            j.ToTime = "00:00";
                        $("#txtFromTime").val(j.FromTime);
                        $("#txtToTime").val(j.ToTime);
                        $("#txtRemarks").val(j.Remarks);
                        $('#ddEmployee option[value=' + j.EmployeeID + ']').attr('selected', 'selected');
                        $("#ddEmployee").trigger("liszt:updated");
                        $('#ddPermType option[value=' + j.PermissionTypeID + ']').attr('selected', 'selected');
                        $("#ddPermType").trigger("liszt:updated");

                        if (j.CategoryID == "1") {
                            $("#txtMinutes").val(j.Minutes);
                            $('#divMinutes').css("display", "block");
                            $('#divTime').css("display", "none");
                            $('#divWeekDays').css("display", "none");
                        }
                        else if (j.CategoryID == "2") {
                            $("#txtMinutes").val(j.Minutes);

                            $("#txtSun").val(j.Sunday);
                            $("#txtMon").val(j.Monday);
                            $("#txtTue").val(j.Tuesday);
                            $("#txtWed").val(j.Wednesday);
                            $("#txtThu").val(j.Thursday);
                            $("#txtFri").val(j.Friday);
                            $("#txtSat").val(j.Saturday);


                            $('#divMinutes').css("display", "none");
                            $('#divTime').css("display", "none");
                            $('#divWeekDays').css("display", "block");
                        }
                        else {

                            $('#divMinutes').css("display", "none");
                            $('#divTime').css("display", "block");
                            $('#divWeekDays').css("display", "none");
                        }
                    }
                },
                error: function (html) {

                }
            });
        }

        function isNumberKey(evt) {
            $("#divErrorMsg").css("display", "none");
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {

                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("Error: Only numberic values are allowed.");
                return false;
            }
            return true;
        }


        function Save() {

            $("#divErrorMsg").css("display", "none");
            $("#spnErrorMsg").html("");
            $("#divSuccessMsg").css("display", "none");
            $("#spnSuccessMsg").html("");

            var id = $('#spnPerm').text();
            var empID = $("#ddEmployee").val();
            var permTypeID = $("#ddPermType").val();

            var groupID = $("#ddEmpGroup").val();
            var AutoApprove = $("#chkboxAutoApprove").is(":checked");

            var PermCatID = $('#ddPermType :selected').attr('permissiontype')
            var AllowAttachement = $('#ddPermType :selected').attr('allowattachement')


            var remarks = $("#txtRemarks").val();
            var CommentsRequired = $('#ddPermType :selected').attr('CommentsRequired')
            if (CommentsRequired == "1" && remarks == "") {
                $('#divErrorMsg').css("display", "block");;
                $("#spnErrorMsg").html("<%=Resources.Resource.lblRequired %>" + "." + "<%=Resources.Resource.remarks %>");
                return;
            }

            var str1 = $('#txtFromDate').val();
            var dt1 = "";
            var mon1 = "";
            var yr1 = "";
            var hh1 = "";
            var mm1 = "";
            var fromDate = "";
            if (str1.indexOf('-') > 0) {
                dt1 = str1.substring(0, 2);
                mon1 = str1.substring(3, 5);
                yr1 = str1.substring(6, 10);
            }
            else {
                dt1 = str1.substring(0, 2);
                mon1 = str1.substring(2, 4);
                yr1 = str1.substring(4, 8);
            }
            fromDate = yr1 + "-" + mon1 + "-" + dt1;

            var str2 = $('#txtToDate').val();
            var dt2 = "";
            var mon2 = "";
            var yr2 = "";
            var hh2 = "";
            var mm2 = "";
            var toDate = "";
            if (str2.indexOf('-') > 0) {
                dt2 = str2.substring(0, 2);
                mon2 = str2.substring(3, 5);
                yr2 = str2.substring(6, 10);
            }
            else {
                dt2 = str2.substring(0, 2);
                mon2 = str2.substring(2, 4);
                yr2 = str2.substring(4, 8);
            }
            toDate = yr2 + "-" + mon2 + "-" + dt2;

            hh1 = $("#txtFromTime").val().substring(0, 2);
            mm1 = $("#txtFromTime").val().substring(3, 5);
            hh2 = $("#txtToTime").val().substring(0, 2);
            mm2 = $("#txtToTime").val().substring(3, 5);

            var fromTime = $("#txtFromTime").val();
            var toTime = $("#txtToTime").val();
            var minutes = $("#txtMinutes").val();

            var Sun = $("#txtSun").val();
            var Mon = $("#txtMon").val();
            var Tue = $("#txtTue").val();
            var Wed = $("#txtWed").val();
            var Thu = $("#txtThu").val();
            var Fri = $("#txtFri").val();
            var Sat = $("#txtSat").val();
            debugger;
            if ($('#form_sample_1').validate().form() == false) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                return;
            }

            $("#divErrorMsg").css("display", "none");
            $("#divSuccessMsg").css("display", "none");

            if (PermCatID == "0") {
                if (hh1 === "00" && mm1 === "00") {
                    //failed
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgFromAndToTimeRequired %>");
                    return;
                }
                if (hh2 === "00" && mm2 === "00") {
                    //failed
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgFromAndToTimeRequired %>");
                    return;
                }
            }
            else if (PermCatID == "1") {
                if (minutes == "" || minutes == "0") {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgRequiredMinutes %>");
                    return;
                }
            }
            if (new Date(yr1, mon1, dt1) > new Date(yr2, mon2, dt2)) {
                //failed
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgErrorDateRange %>");
                return;
            }
            if (PermCatID == "0") {
                if (new Date(yr1, mon1, dt1, hh1, mm1) > new Date(yr2, mon2, dt2, hh2, mm2)) {
                    //failed
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgErrorTimeRange %>");
                    return;
                }
                if (new Date(yr1, mon1, dt1, hh1, mm1) < new Date(yr2, mon2, dt2, hh2, mm2) && (hh1 == "00" && mm1 == "00" && hh2 == "00" && mm2 == "00")) {
                    //failed
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.errorMsgFulldayPermission %>");
                    return;
                }
            }

            var data = new FormData();
            if (AllowAttachement == "1") {
                if ($('#permissionAttachment')[0].files.length == 0) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.lblRequired %>" + "." + "<%=Resources.Resource.attachment %>");
                    return;
                }

                var filesObject = $('#permissionAttachment');
                var fileSize = filesObject[0].size;

                var files = filesObject[0].files;
                var sizeInMB = ($('#permissionAttachment')[0].files[0].size / (1024 * 1024));

                if (sizeInMB > 2.0) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%= String.Format(Resources.Resource.msgErrorFileSize,"2 MB.") %>");
                    $('#permissionAttachment').val('');
                    return;
                }
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);

                }
            }

            var url = '<%= Page.ResolveClientUrl("~/RequestPages/SinglePermissionPage.aspx") %>';

            var v = "key=save" + "&id=" + id + "&empID=" + empID + "&permTypeID=" + permTypeID;
            v += "&fromDate=" + fromDate + "&toDate=" + toDate + "&fromTime=" + fromTime + "&toTime=" + toTime;
            v += "&remarks=" + remarks + "&Minutes=" + minutes + "&Sun=" + Sun + "&Mon=" + Mon + "&Tue=" + Tue
            v += "&Wed=" + Wed + "&Thu=" + Thu + "&Fri=" + Fri + "&Sat=" + Sat + "&CatId=" + PermCatID;
            v += "&AllowAttachement=" + AllowAttachement + "&GroupID=" + groupID + "&AutoApprove=" + AutoApprove;
            url = url + "?" + v;

            $.ajax({
                type: 'POST',
                data: data,
                url: url,
                contentType: false,
                processData: false,
                success: function (html) {

                    if (html == 'Success' || html == 'SUCCESS') {
                        //success
                        $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                        $("#spnSuccessMsg").css("display", "block");
                        $("#divSuccessMsg").css("display", "block");
                        $('#btnBroadCast').click();
                        if ($('#spnPerm').text() != "" && $('#spnPerm').text() != "0" && $('#spnPerm').text() != "MA==") {
                            window.location = '<%= Page.ResolveClientUrl("~/Leaves/Short-Permission") %>';
                        }

                        Clear();
                        LoadEmployeeList();
                    }
                    else {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html(html);
                    }

//               if (html == '-2') {
//                       //failed
//                       $("#divErrorMsg").css("display", "block");
//                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
//                    }
//                    else if (html == '-3') {
//                        //failed
//                        $("#divErrorMsg").css("display", "block");
//                        $("#spnErrorMsg").html("<%=Resources.Resource.permExceedingMonthlyHours %>");
//                    }
//                    else if (html == '-4') {
//                        //failed
//                        $("#divErrorMsg").css("display", "block");
//                        $("#spnErrorMsg").html("<%=Resources.Resource.permExceedingDailyHours %>");
//                    }
//                    else if (html == '-5') {
//                        //failed
//                        $("#divErrorMsg").css("display", "block");
//                        $("#spnErrorMsg").html("<%=Resources.Resource.permExceedingDailyCount %>");
//                    }
//                    else if (html == '-6') {
//                        //failed
//                        $("#divErrorMsg").css("display", "block");
//                        $("#spnErrorMsg").html("<%=Resources.Resource.prmnMinimunMsg %>");
//                    }
//                    else if (html == '-1') {
//                        //failed
//                        $("#divErrorMsg").css("display", "block");
//                        $("#spnErrorMsg").html("<%=Resources.Resource.errorPayrollDataAlreadyProcessed %>");
//                    }
//                    else if (html == '-7') {
//                        //failed
//                        $("#divErrorMsg").css("display", "block");
//                        $("#spnErrorMsg").html("<%=Resources.Resource.msgMonthAlreadyClosed %>");
//                    }
//                    else if (html == '0') {
//                        //exists
//                        $("#divErrorMsg").css("display", "block");
//                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
//                    }
//                    else {
//                        //success
//                        $("#divSuccessMsg").css("display", "block");
//                        $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
//                        $('#btnBroadCast').click();
//                        if ($('#spnPerm').text() != "" && $('#spnPerm').text() != "0" && $('#spnPerm').text() != "MA==") {
//                           window.location = '<%= Page.ResolveClientUrl("~/Leaves/Short-Permission") %>';
                    //                      } 

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
                                required: {
                                    depends: function (element) {
                                        if ($("#ddEmpGroup").val() == "" && $("#ddEmployee").val() == "") { return true } else { return false }
                                    }
                                }
                            },
                            ddgroup:
                            {
                                required:
                                {
                                    depends: function (element) {
                                        if ($("#ddEmpGroup").val() == "" && $("#ddEmployee").val() == "") { return true } else { return false }
                                    }
                                }
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
                            }
                        },

                        messages: { // custom messages for radio buttons and checkboxes
                            emp: {
                                required: "<%=Resources.Resource.lblRequired %>"
                    },
                    ddgroup:
                    {
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
                        required: function (element) {
                            if ($('#ddPermType :selected').attr('permissiontype') == '0')
                                return "<%=Resources.Resource.lblRequired %>"
                            else
                                return false
                        }
                    },
                    toTime: {
                        required: function (element) {
                            if ($('#ddPermType :selected').attr('permissiontype') == '0')
                                return "<%=Resources.Resource.lblRequired %>"
                                    else
                                        return false;
                                }
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

        function LoadPermissionBalance() {
            var str1 = $('#txtFromDate').val();
            var dt1 = "";
            var mon1 = "";
            var yr1 = "";
            var fromDate = "";
            if (str1.indexOf('-') > 0) {
                dt1 = str1.substring(0, 2);
                mon1 = str1.substring(3, 5);
                yr1 = str1.substring(6, 10);
            }
            else {
                dt1 = str1.substring(0, 2);
                mon1 = str1.substring(2, 4);
                yr1 = str1.substring(4, 8);
            }
            fromDate = yr1 + "-" + mon1 + "-" + dt1;

            var str2 = $('#txtToDate').val();
            var dt2 = "";
            var mon2 = "";
            var yr2 = "";
            var toDate = "";
            if (str2.indexOf('-') > 0) {
                dt2 = str2.substring(0, 2);
                mon2 = str2.substring(3, 5);
                yr2 = str2.substring(6, 10);
            }
            else {
                dt2 = str2.substring(0, 2);
                mon2 = str2.substring(2, 4);
                yr2 = str2.substring(4, 8);
            }
            toDate = yr2 + "-" + mon2 + "-" + dt2;
            var permTypeID = $("#ddPermType").val();
            var employeeID = $("#ddEmployee").val();
            debugger;
            var d = "key=permissionbalance" + "&permTypeID=" + permTypeID + "&fromDate=" + fromDate + "&toDate=" + toDate + "&employeeID=" + employeeID;
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/SinglePermissionPage.aspx") %>',
                success: function (html) {
                    if (html.length > 0) {
                        $('#permBalanceRow').removeClass('hide');
                        $("#permBalance").html(html);
                    } else {// this elese condition is added by Shajar to hide the message bar 
                        $('#permBalanceRow').addClass('hide');
                        $("#permBalance").html("");
                    }

                },
                error: function (html) {
                    $('#permBalanceRow').addClass('hide');
                }
            });
        }
    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>

