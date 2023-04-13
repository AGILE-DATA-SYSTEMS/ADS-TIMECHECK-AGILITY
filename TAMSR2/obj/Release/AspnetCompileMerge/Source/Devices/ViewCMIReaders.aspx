<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewCMIReaders.aspx.cs" Inherits="TAMSR2.Devices.ViewCMIReaders" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.cmiReaders %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->
    <style type="text/css">
        .chzn-results {
            max-height: 120px !important;
        }
    </style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="portlet-config-Reader" class="modal hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.cmiReaders %></h4>
                        </div>
                        <div class="portlet-body form">
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
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="text" id="txtCode" name="code" data-required="1" class="span6 m-wrap" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.name %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="text" id="txtName" name="nameEn" data-required="1" class="span6 m-wrap" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.readerType %><span class="required">*</span></label>
                                    <div class="controls">
                                        <select id="ddReaderType" style="width: 220px;" name="readerType" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.readerType %>">
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.deviceConnection %><span class="required">*</span></label>
                                    <div class="controls">
                                        <select id="ddConnection" style="width: 220px;" name="deviceConnection" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.deviceConnection %>">
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.deviceGroup %><span class="required">*</span></label>
                                    <div class="controls">
                                        <select id="ddGroup" style="width: 220px;" name="deviceGroup" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.deviceGroup %>">
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.region %><span class="required">*</span></label>
                                    <div class="controls">
                                        <select id="ddRegion" style="width: 220px;" name="region" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.region %>">
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.direction %><span class="required">*</span></label>
                                    <div class="controls">
                                        <select id="ddReaderDirection" style="width: 220px;" name="direction" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.direction %>">
                                            <option value="0"><%=Resources.Resource.rIN %> </option>
                                            <option value="1"><%=Resources.Resource.rOUT %> </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="controls">
                                        <input id="chkboxWebPunch" type="checkbox" name="webPunch" />
                                        <%=Resources.Resource.webPunch %>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="controls">
                                        <input id="chkboxEnabled" type="checkbox" name="enable" />
                                        <%=Resources.Resource.enable %>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <span id="spnID" style="display: none;">0</span>
                                    <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                                    <button id="btnSaveReader" type="button" onclick="SaveReader()" class="btn purple"><%=Resources.Resource.save %></button>
                                    <button type="button" onclick="return CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
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
                    <%=Resources.Resource.cmiReaders %> 
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.devices %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.cmiReaders %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">

                <div id="divSuccessMsg2" class="alert alert-success hide">
                    <span id="spnSuccessMsg2"><%=Resources.Resource.formErrors %></span>
                </div>
                <div id="divErrorMsg2" class="alert alert-error hide">
                    <span id="spnErrorMsg2"><%=Resources.Resource.formErrorsRemoved %></span>
                </div>

                <div class="btn-group pull-<%= pullDirectionStr %>" style="padding-bottom: 5px;">
                    <span id="spnAddButton" runat="server">
                        <a id="btnShowPopup" style="display: none;" href="#portlet-config-Reader" data-toggle="modal"></a>
                        <a id="btnAddReader" onclick="return ShowPopup()" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                    </span>
                    <span id="spnDeleteButton" runat="server">
                        <a id="btnDeleteReader" onclick="return DeleteReader()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                    </span>
                </div>

                <!-- BEGIN SAMPLE FORM PORTLET-->
                <div class="portlet box blue tabbable">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-reorder"></i>
                            <span class="hidden-480"><%=Resources.Resource.readerOperations %></span>
                        </div>
                    </div>
                    <div class="portlet-body form">

                        <div class="tabbable portlet-tabs">
                            <ul class="nav nav-tabs">
                                <li id="li3"><a href="#portlet_tab5_locations" onclick="return LoadLocationGrid();" data-toggle="tab"><%=Resources.Resource.locations %></a></li>
                                <li id="li2"><a href="#portlet_tab4_ConnectionsTypes" onclick="return LoadConnectionTypeGrid();" data-toggle="tab"><%=Resources.Resource.connectionTypes %></a></li>
                                <li id="li1"><a href="#portlet_tab3_DeviceConnections" onclick="return LoadConnectionGrid();" data-toggle="tab"><%=Resources.Resource.deviceConnections %></a></li>
                                <li id="liTabEmployees"><a href="#portlet_tab2_DeviceGroups" onclick="return LoadDeviceGroupGrid();" data-toggle="tab"><%=Resources.Resource.deviceGroups %></a></li>
                                <li class="active" id="liTabReaders"><a href="#portlet_tab1_Readers" onclick="return LoadReaderGrid();" data-toggle="tab"><%=Resources.Resource.readers %></a></li>
                            </ul>

                            <div class="tab-content">
                                <div class="clearfix">
                                    <div class="btn-group">
                                        <span id="Span1">&nbsp;</span>
                                    </div>
                                </div>
                                <div class="tab-pane active" id="portlet_tab1_Readers">
                                    <!-- BEGIN FORM-->
                                    <form action="#" id="form1" class="form-horizontal">

                                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                                            <thead>
                                                <tr style="background-color: #e8e3e3;">
                                                <tr style="background-color: #e8e3e3;">
                                                    <th style="text-align: center;">
                                                        <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.deviceGroup %></th>
                                                    <th style="text-align: center; display: none;"><%=Resources.Resource.location %></th>
                                                    <th style="text-align: center; display: none;"><%=Resources.Resource.connection %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.address %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.active %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.pollingType %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.enable %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.deleteable %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.punch %></th>
                                                    <th style="text-align: center;"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>

                                    </form>
                                    <!-- END FORM-->
                                </div>

                                <div class="tab-pane" id="portlet_tab2_DeviceGroups">
                                    <!-- BEGIN FORM-->
                                    <form action="#" id="form2" class="form-horizontal">

                                        <table class="table table-striped table-bordered table-hover" id="sample_deviceGroups">
                                            <thead>
                                                <tr style="background-color: #e8e3e3;">
                                                    <th style="text-align: center; width: 8px;">
                                                        <input type="checkbox" class="group-checkable" data-set="#sample_deviceGroups .checkboxes" /></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.organization %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.updated %></th>
                                                    <th style="text-align: center; width: 24px !important;">&nbsp;</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </form>
                                    <!-- END FORM-->

                                </div>

                                <div class="tab-pane" id="portlet_tab3_DeviceConnections">
                                    <!-- BEGIN FORM-->
                                    <form action="#" id="form3" class="form-horizontal">

                                        <table class="table table-striped table-bordered table-hover" id="Table1">
                                            <thead>
                                                <tr style="background-color: #e8e3e3;">
                                                    <th style="text-align: center;">
                                                        <input type="checkbox" class="group-checkable" data-set="#sample_2 .checkboxes" /></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.location %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.connectionTypes %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.port %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.ipAdress %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.status %></th>
                                                    <th style="text-align: center; width: 24px !important;">&nbsp;</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </form>
                                    <!-- END FORM-->

                                </div>

                                <div class="tab-pane" id="portlet_tab4_ConnectionsTypes">
                                    <!-- BEGIN FORM-->
                                    <form action="#" id="form4" class="form-horizontal">

                                        <table class="table table-striped table-bordered table-hover" id="sample_connectionType">
                                            <thead>
                                                <tr style="background-color: #e8e3e3;">
                                                    <th style="text-align: center;">
                                                        <input type="checkbox" class="group-checkable" data-set="#sample_2 .checkboxes" /></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.updated %></th>
                                                    <th style="text-align: center; width: 24px !important;">&nbsp;</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </form>
                                    <!-- END FORM-->

                                </div>

                                <div class="tab-pane" id="portlet_tab5_locations">
                                    <!-- BEGIN FORM-->
                                    <form action="#" id="form5" class="form-horizontal">

                                        <table class="table table-striped table-bordered table-hover" id="Table3">
                                            <thead>
                                                <tr style="background-color: #e8e3e3;">
                                                    <th style="text-align: center;">
                                                        <input type="checkbox" class="group-checkable" data-set="#sample_2 .checkboxes" /></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.organization %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.cardNoLength %></th>
                                                    <th style="text-align: center; width: 24px !important;">&nbsp;</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </form>
                                    <!-- END FORM-->

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
    <script src="../assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
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
    <script src="../Scripts/jquery.signalR-1.1.0.min.js"></script>
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
            //TableManaged.init();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liDevices").addClass("active");
            $("#liDevices .arrow").addClass("open");
            $("#liCMI").addClass("active");
            $("#liCMI").addClass("open");
            $("#liCMI_Readers").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

            $("#chkboxEnabled").attr("checked", "checked");
            $("#uniform-chkboxEnabled span").addClass("checked");

            LoadReaderGrid();

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
                if (name == "TAMSR2_Readers") {
                    LoadReaderGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Readers', '');
                    // Clear text box and reset focus for next comment. 
                });
            });
        });

        function ShowPopup() {
            LoadDropDownLists();
            if ($("#liTabReaders").attr("class") == "active")
                $("#btnShowPopup").click();
        }

        function LoadDropDownLists() {

            LoadRegionList();
            LoadReaderTypeList();
            LoadDeviceConnectionList();
            LoadDeviceGroupList();

        }

        function LoadReaderGrid() {
            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false, sWidth: "5%" },
                  { "bSortable": true, sWidth: "7%" },
                  { "bSortable": true, sWidth: "20%" },
                  { "bSortable": true, sWidth: "15%" },
                  { "bSortable": true, sWidth: "15%", "bVisible": false },
                  { "bSortable": true, sWidth: "10%", "bVisible": false },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "5%" },
                  { "bSortable": true, sWidth: "5%" },
                  { "bSortable": false, sWidth: "5%" }
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
                "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/ReaderOpsPage.aspx?key=getAllByType") %>' + '&type=CMIReader'
            });
            $('#sample_1').css("width", "100%");
        }

        function LoadDeviceGroupGrid() {
            ////////Get Users and load in grid/////////
            var oTable = $('#sample_deviceGroups').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false, sWidth: "3%" },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": false },
                  { "bSortable": false }
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
                "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/DeviceGroupPage.aspx?key=getAll") %>'
            });
            $('#sample_deviceGroups').css("width", "100%");
        }

        function LoadConnectionTypeGrid() {
            ////////Get Users and load in grid/////////
            var oTable = $('#sample_connectionType').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false, sWidth: "3%" },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": false },
                  { "bSortable": false }
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
                "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/ConnectionTypePage.aspx?key=getAll") %>'
            });
            $('#sample_connectionType').css("width", "100%");
        }


        function ReloadGrid() {
            $('#sample_1').dataTable().fnDraw();
        }


        function CloseForm() {
            Clear();
            $("#divSuccessMsg").hide();

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

            $("#txtCode").val("");
            $("#txtName").val("");

            $("#ddReaderType").val("");
            $("#ddReaderType").trigger("liszt:updated");
            $("#ddConnection").html("");
            $("#ddConnection").trigger("liszt:updated");
            $("#ddGroup").html("");
            $("#ddGroup").trigger("liszt:updated");
            $("#ddRegion").html("");
            $("#ddRegion").trigger("liszt:updated");

            $("#chkboxEnabled").attr("checked", "checked");
            $("#uniform-chkboxEnabled span").addClass("checked");

        }

        function LoadRegionList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/RegionPage.aspx") %>',
                success: function (html) {
                    $("#ddRegion").html(html);
                    $("#ddRegion").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadReaderTypeList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ReaderTypePage.aspx") %>',
                success: function (html) {
                    $("#ddReaderType").html(html);
                    $("#ddReaderType").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadDeviceConnectionList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DeviceConnectionPage.aspx") %>',
                success: function (html) {
                    $("#ddConnection").html(html);
                    $("#ddConnection").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadDeviceGroupList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DeviceGroupPage.aspx") %>',
                success: function (html) {
                    $("#ddGroup").html(html);
                    $("#ddGroup").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function SaveReader() {
            var id = $("#spnID").html();
            var code = $("#txtCode").val();
            var name = $("#txtName").val();
            var readerType = $("#ddReaderType").val();
            var connection = $("#ddConnection").val();
            var group = $("#ddGroup").val();
            var region = $("#ddRegion").val();
            var direction = $("#ddReaderDirection").val();
            var webPunch = $("#chkboxWebPunch").is(":checked");
            var enabled = $("#chkboxEnabled").is(":checked");

            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }
            var v = "key=save" + "&id=" + id + "&code=" + code + "&name=" + name + "&readerType=" + readerType;
            v += "&connection=" + connection + "&group=" + group + "&region=" + region + "&direction=" + direction;
            v += "&webPunch=" + webPunch + "&enabled=" + enabled;

            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>',
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
        }/////////////////SAVEREADER()/////////////////


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
                           required: true,
                           maxlength: 50
                       },
                       nameAr: {
                           minlength: 3,
                           required: true,
                           maxlength: 50
                       }
                   },
                   message: {
                       nameEn: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       },
                       nameAr: {
                           required: "<%=Resources.Resource.lblRequired %>"
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


