<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveManualTransactions.aspx.cs" Inherits="TAMSR2.Details.SaveManualTransactions" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.manualMovements %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
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
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">
                    <%=Resources.Resource.manualMovements %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.movements %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href='<%= Page.ResolveClientUrl("~/Details/ViewManualTransactions.aspx") %>'><%=Resources.Resource.manualMovements %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->

        <div id="div3" class="alert alert-success hide">
            <span id="Span5"><%=Resources.Resource.formErrorsRemoved %></span>
        </div>
        <div id="div4" class="alert alert-error hide">
            <span id="Span6"><%=Resources.Resource.formErrors %></span>
        </div>
        <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
        <div id="portlet-config" class="modal hide" style="left: 38%; width: 925px;">
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
                                <div id="div1" class="alert alert-success hide">
                                    <span id="Span1"><%=Resources.Resource.formErrorsRemoved %></span>
                                </div>
                                <div id="div2" class="alert alert-error hide">
                                    <span id="Span2"><%=Resources.Resource.formErrors %></span>
                                </div>
                                <div class="clearfix">
                                    <div class="btn-group">
                                        <span id="Span3">&nbsp;</span>
                                    </div>
                                    <div class="span12">
                                        <!-- BEGIN FORM-->
                                        <form action="#" id="form_1" class="form-horizontal">
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.name %><span class="required">*</span></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddEmp" name="emp" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.manager %> <span class="required">*</span></label>
                                                        <div class="controls">
                                                            <select id="ddMgr" name="mgr" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
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
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.designation %><span class="required">*</span></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddDesig" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.scheduleType %> <span class="required">*</span></label>
                                                        <div class="controls">
                                                            <select id="ddSchType" name="mgr" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.joinDate %> </label>
                                                        <div class="controls">
                                                            <input id="txtJoinDate" name="joindate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label">&nbsp;</label>
                                                        <div class="controls">
                                                            <input id="chkboxActive" type="checkbox" name="active" />
                                                            <%=Resources.Resource.active %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="span6 ">
                                                    <a id="btnSearch" class="label label-info label-mini">&nbsp; <%=Resources.Resource.search %> <i class="icon-share-alt"></i></a>
                                                    <span style="width: 40px;">&nbsp;</span>
                                                    <a id="btnSearchClear" onclick="return Clear(true)" class="label label-inverse label-mini">&nbsp; <%=Resources.Resource.clear %> <i class="icon-share-alt"></i></a>
                                                </div>
                                            </div>
                                        </form>
                                        <!-- END FORM-->
                                    </div>

                                    <div class="btn-group pull-<%= pullDirectionStr %>" style="clear: both;">
                                        <span id="Span4" runat="server">
                                            <a id="btnAddEmp" onclick="AddEmployeeInGrid()" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                        </span>
                                        <a data-dismiss="modal" class="btn" style="margin: 0px 5px;">&nbsp; <%=Resources.Resource.cancel %></i></a>
                                    </div>
                                    <div>&nbsp;</div>
                                    <table class="table table-striped table-bordered table-hover" id="sample_Employees" style="">
                                        <thead>
                                            <tr style="background-color: #e8e3e3;">
                                                <th style="text-align: center; width: 30px;">
                                                    <input type="checkbox" class="group-checkable" data-set="#sample_Employees .checkboxes" /></th>
                                                <th style="text-align: center; width: 50px !important;"><%=Resources.Resource.number %></th>
                                                <th style="text-align: center; width: 200px !important;"><%=Resources.Resource.name %></th>
                                                <th style="text-align: center; display: none;">&nbsp;</th>
                                                <th style="text-align: center; display: none;">&nbsp;</th>
                                                <th style="text-align: center; display: none;">&nbsp;</th>
                                                <th style="text-align: center; display: none;">&nbsp;</th>
                                                <th style="text-align: center; width: 150px !important;" class="hidden-480"><%=Resources.Resource.designation %></th>
                                                <th style="text-align: center; width: 200px !important;" class="hidden-480"><%=Resources.Resource.organization %></th>
                                                <th style="text-align: center; display: none;">&nbsp;</th>
                                                <th style="text-align: center; display: none;">&nbsp;</th>
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
                    <span id="spnTransactionTime" runat="server">
                        <div class="row-fluid">
                            <div class="span6 ">
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.fromTime %> <span class="required">*</span></label>
                                    <div class="controls">
                                        <div class="input-append bootstrap-timepicker-component">
                                            <input type="text" id="txtFromTime" name="fromTime" class="m-wrap m-ctrl-small timepicker-24">
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
                                            <input type="text" id="txtToTime" name="toTime" class="m-wrap m-ctrl-small timepicker-24">
                                            <span class="add-on"><i class="icon-time"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <!--/row-->
                    </span>
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label">&nbsp;</label>
                                <div class="controls">
                                    <input id="chkboxuseIndivi" type="checkbox" name="useIndivi" />
                                    <%=Resources.Resource.useIndividualValues %>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 "></div>
                        <!--/span-->
                    </div>
                    <div class="row-fluid">
                        <div class="span12">
                            <!-- BEGIN EXAMPLE TABLE PORTLET-->
                            <div class="portlet box light-grey">
                                <div class="portlet-title">
                                    <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.employeeMovements %></div>
                                    <div class="tools">
                                        <a href="javascript:;" class="collapse"></a>
                                        <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <button id="Button1" type="button" style="display: none;" class="btn purple">broadcast</button>
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
                                        <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                            <span id="spnAddButton" runat="server">
                                                <a class="btn green" data-toggle="modal" href="#portlet-config" id="A2"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                            </span>
                                            <span id="spnDeleteButton" runat="server">
                                                <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                            </span>
                                        </div>
                                    </div>
                                    <table class="table table-striped table-bordered table-hover" id="sample_1">
                                        <thead>
                                            <tr style="background-color: #e8e3e3;">
                                                <th style="text-align: center;">
                                                    <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                                <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.fromDate %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.toDate %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.fromTime %></th>
                                                <th style="text-align: center;"><%=Resources.Resource.toTime %></th>
                                                <th style="text-align: center;">&nbsp;</th>
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
                    <div class="form-actions">
                        <span id="spnID" style="display: none;">0</span>
                        <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                        <button id="btnSave" type="button" onclick="Save()" class="btn purple"><%=Resources.Resource.save %></button>
                        <button type="button" onclick="Cancel()" class="btn"><%=Resources.Resource.cancel %></button>
                        <button type="reset" id="btnCloseForm" style="display: none;" data-dismiss="modal" class="btn"><%=Resources.Resource.close %></button>
                    </div>
                </form>
                <!-- END FORM-->

            </div>
        </div>
        <!-- END PAGE CONTENT-->

        <div id="divHiddenValues" runat="server" style="display: none">
            <span id="spnTid">0</span>&nbsp;
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
            $("#liEvents").addClass("active");
            $("#liEvents .arrow").addClass("open");
            $("#liManualMovement").addClass("active");

            // Declare a proxy to reference the hub. 
            var users = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            users.client.broadcastMessage = function (name, message) {
                if (name == "TAMSR2_Manual_Movement") {
                    //ReloadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Manual_Movement', '');
                    // Clear text box and reset focus for next comment. 
                });
            });

            LoadEmployeeList();
            LoadOrganizations();
            LoadDesignations();
            LoadScheduleTypes();

            Clear(false);
            LoadEmplopyees(false);

            $("#btnSearch").click(function () {
                LoadEmplopyees(true);
            });

            if ($('#spnTid').text() != "" && $('#spnTid').text() != "0" && $('#spnTid').text() != "MA==") {
                Edit($('#spnTid').text());
            }
            $("#txtFromDate").change(function () {
                DateRangeChange("fromDate");
            });

            $("#txtToDate").change(function () {
                DateRangeChange("toDate");
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
            $("#chkboxuseIndivi").attr("checked", "checked");
            $("#uniform-chkboxuseIndivi span").addClass("checked");

        });


        function imposeMaxLength(Object, evt, MaxLen) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
            return (Object.value.length < MaxLen);
        }

        function LoadEmplopyees(filter) {
            var emp = $("#ddEmp").val();
            var mgr = $("#ddMgr").val();
            var org = $("#ddOrg").val();
            var desig = $("#ddDesig").val();
            var schType = $("#ddSchType").val();
            var joinDate = $("#txtJoinDate").val();
            var active = $("#chkboxActive").is(":checked");
            var wc = "&emp=" + emp + "&mgr=" + mgr + "&org=" + org + "&desig=" + desig;
            wc += "&schType=" + schType + "&joinDate=" + joinDate + "&active=" + active + "&filter=true";
            if (filter == false) {
                var wc = "&emp=" + '' + "&mgr=" + '' + "&org=" + '' + "&desig=" + '';
                wc += "&schType=" + '' + "&joinDate=" + '' + "&active=" + '' + "&filter=false";
            }
            var filterValue = '';
            filterValue = $("#txt_sample_1_filter").val();
            wc += "&sSearchFilter=" + filterValue;
            var oTable = $('#sample_Employees').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                    { "bSortable": false, sWidth: "5%" },
                    { "bSortable": true, sWidth: "5%" },
                    { "bSortable": true, sWidth: "20%" },
                    { "bSortable": true, sWidth: "5%", bVisible: false },
                    { "bSortable": true, sWidth: "5%", bVisible: false },
                    { "bSortable": true, sWidth: "5%", bVisible: false },
                    { "bSortable": true, sWidth: "5%", bVisible: false },
                    { "bSortable": true, sWidth: "15%" },
                    { "bSortable": true, sWidth: "15%" },
                    { "bSortable": true, sWidth: "15%", bVisible: false },
                    { "bSortable": false, sWidth: "3%", bVisible: false }
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
                "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx?key=getAllByFilters") %>' + wc
            });
            $('#sample_Employees').css('width', '100%');
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

        function LoadEmployeeList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    $("#ddEmp").html(html);
                    $("#ddEmp").trigger("liszt:updated");
                    $("#ddMgr").html(html);
                    $("#ddMgr").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
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
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DesignationPage.aspx") %>',
                success: function (html) {
                    $("#ddDesig").html(html);
                    $("#ddDesig").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadScheduleTypes() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ScheduleTypePage.aspx") %>',
                success: function (html) {
                    $("#ddSchType").html(html);
                    $("#ddSchType").trigger("liszt:updated");
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
            $('#sample_1').dataTable().fnDraw();
            $('#sample_Employees').dataTable().fnDraw();
        }

        function CloseForm() {
            Clear(false);
            ReloadGrid();
            $("#btnCloseForm").click();
        }

        function Cancel() {
            window.location = '<%= Page.ResolveClientUrl("~/Events/View-Manual-Movement") %>';
        }

        function Clear(reset) {
            $(':input', '#form_1')
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

            $("#txtJoinDate").val("");
            $("#txtJoinDate").datepicker({
                format: " yyyy",
                viewMode: "years"
            });

            $("#chkboxActive").attr("checked", "checked");
            $("#uniform-chkboxActive span").addClass("checked");

            $('#ddOrg option[value=""]').attr('selected', 'selected');
            $("#ddOrg").trigger("liszt:updated");
            $('#ddEmp option[value=""]').attr('selected', 'selected');
            $("#ddEmp").trigger("liszt:updated");
            $('#ddMgr option[value=""]').attr('selected', 'selected');
            $("#ddMgr").trigger("liszt:updated");
            $('#ddDesig option[value=""]').attr('selected', 'selected');
            $("#ddDesig").trigger("liszt:updated");
            $('#ddSchType option[value=""]').attr('selected', 'selected');
            $("#ddSchType").trigger("liszt:updated");
            if (reset == true) {
                LoadEmplopyees(false);
            }
        }

        function Edit(id) {
            //Edit code
            var v = "key=getManualMovementByID&id=" + id;
            $("#btnAdd").click();
            $("#spnGridMsg").html("&nbsp;");
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/TAEventPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);
                        $("#spnID").val(j.ID);
                        if (j.ID == "0") {
                            $("#spnID").html(j.ID);
                            return;
                        }

                        if (j.FromDateTimeStr != '') {
                            $('#txtFromDate').datepicker({ format: 'dd-mm-yyyy' });

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
                            $('#txtToDate').datepicker({ format: 'dd-mm-yyyy' });

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
                        $("#txtFromTime").val(j.FromTime);
                        $("#txtToTime").val(j.ToTime);

                    }

                    var v = "key=getEmployeeTempRecord";
                    v += "&fromDate=" + getServerDate("#txtFromDate") + "&fromTime=" + $("#txtFromTime").val() + "";
                    v += "&toDate=" + getServerDate("#txtToDate") + "&toTime=" + $("#txtToTime").val() + "&chk1=" + j.EmployeeID;

                    v += "&count=" + 1;
                    $.ajax({
                        type: 'POST',
                        data: v,
                        url: '<%= Page.ResolveClientUrl("../RequestPages/TAEventPage.aspx") %>',
                        success: function (html) {
                            $("#sample_1 tbody").html($("#sample_1 tbody").html() + html);
                        },
                        error: function (html) {

                        }
                    });
                },
                error: function (html) {

                }
            });
        }

        function AddEmployeeInGrid() {
            var v = "key=getEmployeeTempRecord";
            v += "&fromDate=" + $("#txtFromDate").val() + "&fromTime=" + $("#txtFromTime").val() + "";
            v += "&toDate=" + $("#txtToDate").val() + "&toTime=" + $("#txtToTime").val() + "&";

            $("#div1").css("display", "none");
            $("#div2").css("display", "none");

            var fromTime = $("#txtFromTime").val();
            var toTime = $("#txtToTime").val();
            if ((fromTime == "" || fromTime == "undefined") && (toTime != "" && toTime != "undefined")) {
                $("#div2").css("display", "block");
                $("#Span2").html("<%=Resources.Resource.msgFromAndToTimeRequired %>");
                return;
            }
            if ((toTime == "" || toTime == "undefined") && (fromTime != "" && fromTime != "undefined")) {
                $("#div2").css("display", "block");
                $("#Span2").html("<%=Resources.Resource.msgFromAndToTimeRequired %>");
                return;
            }
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
                $("#div2").css("display", "block");
                $("#Span2").html("<%=Resources.Resource.selectOne %>");
                return;
            }
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/TAEventPage.aspx") %>',
                success: function (html) {
                    $("#sample_1 tbody").html($("#sample_1 tbody").html() + html);
                },
                error: function (html) {

                }
            });
        }

        function Delete() {

            $("#sample_1 tbody").find("input:checkbox").each(function () {
                if (this.checked == true) {
                    $(this).closest('tr').remove();
                    //this.checked = chk.checked;
                }
            });
        }

        function Clear() {

            $("#divSuccessMsg2").css("display", "none");
            $("#divErrorMsg2").css("display", "none");
            $("#divErrorMsg").css("display", "none");
            $("#divErrorMsg").hide();
            $("#txtFromDate").val("");
            $("#txtToDate").val("");
            $("#txtFromTime").val("00:00");
            $("#txtToTime").val("00:00");
            $("#sample_1 > tbody").html("");
        }
        function Save() {


            var id = $('#spnTid').text();
            var empID = $("#ddEmployee").val();
            var fromDate = getServerDate("#txtFromDate");
            var toDate = getServerDate("#txtToDate");
            var fromTime = $("#txtFromTime").val();
            var toTime = $("#txtToTime").val();

            if (new Date(toDate) > new Date()) {
                $("#divErrorMsg").css("display", "block");
                //$("#spnErrorMsg").html("<%=Resources.Resource.msgFromAndToTimeRequired %>");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgForFutureEntry %>");
                return;
            }
            if ((fromDate && toDate) && new Date($("#txtFromDate").val()) > new Date($("#txtToDate").val())) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgErrorDateRange%>");
                return;
            }
            if ((fromTime == "" || fromTime == "undefined") && (toTime != "" && toTime != "undefined")) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgFromAndToTimeRequired %>");
                return;
            }
            if ((toTime == "" || toTime == "undefined") && (fromTime != "" && fromTime != "undefined")) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgFromAndToTimeRequired %>");
                return;
            }
            var hh1 = $("#txtFromTime").val().substring(0, 2);
            var mm1 = $("#txtFromTime").val().substring(3, 5);
            var hh2 = $("#txtToTime").val().substring(0, 2);
            var mm2 = $("#txtToTime").val().substring(3, 5);
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

            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }
            var individualValueProcess = $("#chkboxuseIndivi").is(":checked");
            var individualVal = "";
            if (individualValueProcess) {
                individualVal = "1"
            }
            else {
                individualVal = "0";
            }
            var v = "key=saveEmployeeManualTrans&id=" + id;
            v += "&fromDate=" + fromDate + "&fromTime=" + $("#txtFromTime").val() + "";
            v += "&toDate=" + toDate + "&toTime=" + $("#txtToTime").val() + "&";

            $("#divSuccessMsg2").css("display", "none");
            $("#divErrorMsg2").css("display", "none");
            $("#divErrorMsg").css("display", "none");

            var k = 0;
            var count = 1;
            var d = "";
            var fd = "";
            var td = "";
            var ft = "";
            var tt = "";
            var r = "";
            debugger;
            $("#sample_1 tbody").find("tr").each(function () {
                k = 0;
                $(this).find("td.sel").each(function () {
                    if (k == 0)
                        v += "eid" + count + "=" + $(this).attr("eid") + "&";
                    if (k == 1)
                        v += "fd" + count + "=" + $(this).attr("fd") + "&";
                    if (k == 2)
                        v += "td" + count + "=" + $(this).attr("td") + "&";
                    if (k == 3)
                        v += "ft" + count + "=" + $(this).attr("ft") + "&";
                    if (k == 4)
                        v += "tt" + count + "=" + $(this).attr("tt") + "&";
                    k += 1;
                });
                count += 1;

            });
            v += "count=" + count + '&remarks=' + '';
            v += "&individualValueProcess=" + individualVal;

            if (k == 0) {
                $("#divErrorMsg2").css("display", "block");
                $("#spnErrorMsg2").html("<%=Resources.Resource.selectOne %>");
                return;
            }

            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/TAEventPage.aspx") %>',
                success: function (html) {
                    if (html == '-3') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgMonthAlreadyClosed %>");
                    }
                    else if (html == '-2') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                    }
                    else if (html == '-1') {
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
                        if ($('#spnTid').text() != "" && $('#spnTid').text() != "0" && $('#spnTid').text() != "MA==") {
                            window.location = '<%= Page.ResolveClientUrl("~/Events/View-Manual-Movement") %>';
                        }
                        Clear();
                        LoadEmployeeList();
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
                if (!jQuery().datepicker || !jQuery().timepicker) {
                    return;
                }


                if (jQuery().datepicker) {
                    $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
                }
                $(".date-picker").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');


                if (jQuery().timepicker) {
                    $('.timepicker-default').timepicker();
                    $('.timepicker-24').timepicker({
                        minuteStep: 1,
                        showSeconds: false,
                        showMeridian: false
                    });
                }
            }

            var handleInputMasks = function () {


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
        function DateRangeChange(param) {

            var fromDate = new Date();
            var toDate = new Date();
            var str1 = $('#txtFromDate').val();
            var str2 = $('#txtToDate').val();

            if (str1.indexOf('-') > 0) {
                fromDate = new Date(str1.substring(6, 10), str1.substring(3, 5), str1.substring(0, 2));
            }
            else {
                fromDate = new Date(str1.substring(4, 8), str1.substring(2, 4), str1.substring(0, 2));
            }
            if (str2.indexOf('-') > 0) {
                toDate = new Date(str2.substring(6, 10), str2.substring(3, 5), str2.substring(0, 2));
            }
            else {
                toDate = new Date(str2.substring(4, 8), str2.substring(2, 4), str2.substring(0, 2));
            }

            if (param == "fromDate") {
                if ($("#txtFromDate").val() == "") {
                    $("#txtFromDate").val('<%= new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd-MM-yyyy") %>');
                    $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                }

                if (fromDate > toDate) {
                    $("#txtToDate").val($("#txtFromDate").val());
                }
            }
            else if (param == "toDate") {
                if ($("#txtToDate").val() == "") {
                    $("#txtFromDate").val('<%= new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd-MM-yyyy") %>');
                    $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                }

                if (fromDate > toDate) {
                    $("#txtFromDate").val($("#txtToDate").val());
                }
            }
            $("#txtFromDate").datepicker("update");
            $("#txtToDate").datepicker("update");
        }
        function getServerDate(obj) {
            var newDate;
            if ($(obj) && $(obj).length > 0) {

                var temp = $(obj).val();
                var arr = temp.split('-')

                if (arr && arr.length > 0) {
                    newDate = arr[2] + '-' + arr[1] + '-' + arr[0]
                }
                else
                    newDate = temp;

            }
            return newDate;
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
                            emp: {
                                required: true
                            },
                            leave: {
                                required: true
                            },
                            fromDate: {
                                required: true
                            },
                            toDate: {
                                required: true
                            }
                        },

                        messages: { // custom messages for radio buttons and checkboxes
                            emp: {
                                required: "<%=Resources.Resource.lblRequired %>"
                            },
                            fromDate: {
                                required: "<%=Resources.Resource.lblRequired %>"
                            },
                            toDate: {
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

