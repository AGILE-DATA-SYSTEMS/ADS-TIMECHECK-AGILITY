<%@ page title="" language="C#" masterpagefile="~/Site.Master" autoeventwireup="true" codebehind="CMIReaders.aspx.cs" inherits="TAMSR2.Devices.CMIReaders" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.readers %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->
    <style>
        .modal {
            margin-left: -35% !important;
            width: 75%;
           
        }
         .modal-body {
            overflow-y: visible !important;
        }
      .portlet-tabs .nav-tabs > .active > a {
            color:black !important;
        }
        .portlet-tabs .nav-tabs > li > a {
             color:white !important;
        }
        .portlet-tabs .nav-tabs > li > a:hover {
             color:black !important;
        }
         
    
    </style>
</asp:Content>





<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="server">
    
            <!-- END   LIGHT BOX ERROR/MESSAGE -->

    
    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="portlet-config-Reader-Validate" class="modal hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4><i class="icon-reorder"></i>&nbsp; <%--<%=Resources.Resource.validateReader %--%>></h4>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <form action="#" id="form1_DeviceValidate" class="form-horizontal">
                                <div id="divErrorMsgValidate" class="alert alert-error hide">
                                    <button class="close" data-dismiss="alert"></button>
                                    <span id="spnErrorMsgValidate"><%=Resources.Resource.formErrors %></span>
                                </div>
                                <div id="divSuccessMsgValidate" class="alert alert-success hide">
                                    <button class="close" data-dismiss="alert"></button>
                                    <span id="spnSuccessMsgValidate"><%=Resources.Resource.formErrorsRemoved %></span>
                                </div>
                                
                                <div class="row-fluid">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" id="txtReaderCode" name="deviceCode" style="width: 220px !important;" data-required="1" class="span6 m-wrap" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.name %><span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" id="txtReaderName" name="deviceName" style="width: 220px !important;" data-required="1" class="span6 m-wrap" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row-->
                                <div class="row-fluid">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.ipAdress %><span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" id="txtReaderIPAddress" disabled="disabled" readonly="readonly" style="width: 220px !important;" data-required="1" class="span6 m-wrap" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->

                                     <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.region %><span class="required">*</span></label>
                                            <div class="controls">
                                                <select id="ddRegions" style="width: 220px;" name="regions" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.region %>">
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    
                                <!--/row-->
                                 </div>
                                <div class="row-fluid">
                                    <div class="span6 ">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label">&nbsp;</label>
                                            <div class="controls">
                                                <input id="chkBoxAuthorizeFlag" type="checkbox" name="authorizeFlag" />
                                               <%-- <%=Resources.Resource.authorize %>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                    </div>
                                <!--/row-->
                                <div class="row-fluid">
                                    <div class="span6 ">

                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row-->
                                
                                <div class="form-actions">
                                    <a id="btnShowValidateForm" style="display: none;" onclick="return Clear()" href="#portlet-config-Reader-Validate" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                    <button id="btnValidateDevice" type="button" onclick="ValidateDevice()" class="btn purple"><%--<%=Resources.Resource.validate %>--%></button>
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
                    <%=Resources.Resource.readers %> 
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
                    <li><a href="#"><%=Resources.Resource.readers %></a></li>

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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.readers %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
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

                            <!-- BEGIN FORM-->
                        <%--    <form action="#" id="form_1" class="form-horizontal" >
                                <div class="row-fluid">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.deviceType%> </label>
                                            <div class="controls">
                                                <select id="ddDeviceTypes" tabindex="1" data-placeholder="Choose Verification" class="span6 chosen" name="sex" style="width: 220px;">
                                                     
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.status%> </label>
                                            <div class="controls">
                                                <select id="ddStatus" tabindex="2" data-placeholder="Choose Verification" class="span6 chosen" name="sex" style="width: 220px;">
                                                    <option value=""><%=Resources.Resource.choose%>  <%=Resources.Resource.status%></option>
                                                    <option value="0"><%=Resources.Resource.online%></option>
                                                    <option value="1"><%=Resources.Resource.offline%></option>
                                                    <option value="2"><%=Resources.Resource.unknown%></option>
                                                </select>
                                                <br>
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row-->
                                <div class="row-fluid" style="display:none !important;">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.fromDate%> </label>
                                            <div class="controls">
                                                <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.toDate%> </label>
                                            <div class="controls">
                                                <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row-->
                            </form>--%>
                            <!-- END FORM-->
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="spnAddButton" runat="server">
                                    <a id="btnAdd" onclick="return Clear()" href="#portlet-config" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
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
                         
                                    <th style="text-align: center;"><%=Resources.Resource.device %> <%=Resources.Resource.id %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.device %> <%=Resources.Resource.name %></th>                                    
                                    <th style="text-align: center;"><%=Resources.Resource.macAddress %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.ipAdress%></th>
                                   <%-- <th style="text-align: center;"><%=Resources.Resource.region %></th> --%>
                                    <th style="text-align: center;"></th>
                                  <%--  <th style="text-align: center;"><%=Resources.Resource.type %></th>--%>
                                  <%--  <th style="text-align: center;"><%=Resources.Resource.lastCommunicationTime %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.firmware %></th>--%>
                                  
                                    <%--<th style="text-align: center;"><%=Resources.Resource.address %></th>--%>
                                   
                                  <%--  <th style="text-align: center;"></th>--%>
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
    <script async defer type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDZMwwL1hvA0CP1mgah6f1rxe8paenOxoo"></script>
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
            $("#li_Readers").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
            
            LoadGrid();
            LoadRegionList();
            LoadReaderTypeList();
            LoadConnectionTypeList();
            LoadDeviceLocationList();
            LoadDeviceGroupList();
            LoadBuildings(); // load buidlings dropdown list

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
                if (name == "TAMSR2_Cmp_OrgTypes") {
                    ReloadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Cmp_OrgTypes', '');
                    // Clear text box and reset focus for next comment. 
                });
            });

           
                var refreshId = setInterval(function () {
                    ReloadGrid();
                }, 30000)
             
             
        });


        $("#ddDeviceTypes").change(function () {
            LoadGrid();
        });
        $("#ddStatus").change(function () {
            LoadGrid();
        });
        function LoadGrid() {


            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx?key=GetDeviceData")%>';
                    //alert(url);
                    ////////Get Users and load in grid/////////
                    var oTable = $('#sample_1').dataTable({
                        "bProcessing": true,
                        "bServerSide": true,
                        "bDestroy": true,
                        "sPaginationType": "bootstrap",
                        "aoColumns": [
                            { "bSortable": false, sWidth: "5%" },
                            { "bSortable": false, sWidth: "20%" },
                            { "bSortable": true, sWidth: "45%" },
                            { "bSortable": true, sWidth: "20%" },
                            //{ "bSortable": true, sWidth: "20%" },
                            { "bSortable": true, sWidth: "5%" },
                            //{ "bSortable": true, sWidth: "5%" }
                            //{ "bSortable": true, sWidth: "15%" },
                            //{ "bSortable": true, sWidth: "10%" },
                            //{ "bSortable": true, sWidth: "10%" },
                            //{ "bSortable": true, sWidth: "10%" },
                            //{ "bSortable": true, sWidth: "10%" },
                            //{ "bSortable": false, sWidth: "5%" },
                            //{ "bSortable": false, sWidth: "5%" },

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
                "sAjaxSource": url
            });

            $('#sample_1').css("width", "100%");
        }

<%--        function LoadGrid() {
            // page updated by Shajar to consider the add button.
            var deviceType = $('#ddDeviceTypes option:selected').val();
            if (deviceType == undefined || deviceType == 'undefined')
                deviceType = "";

            var deviceStatus = $('#ddStatus option:selected').val();
            if (deviceStatus == undefined || deviceStatus == 'undefined')
                deviceStatus = "";

            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx?key=getAll")%>' + '&DeviceType=' + deviceType + '&status=' +deviceStatus;
            //alert(url);
            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false, sWidth: "5%" },
                   { "bSortable": false, sWidth: "20%" },
                  { "bSortable": true, sWidth: "45%" },
                  { "bSortable": true, sWidth: "20%" },
                  //{ "bSortable": true, sWidth: "20%" },
                  { "bSortable": true, sWidth: "5%" },
                  { "bSortable": true, sWidth: "5%" }
                  //{ "bSortable": true, sWidth: "15%" },
                  //{ "bSortable": true, sWidth: "10%" },
                  //{ "bSortable": true, sWidth: "10%" },
                  //{ "bSortable": true, sWidth: "10%" },
                  //{ "bSortable": true, sWidth: "10%" },
                  //{ "bSortable": false, sWidth: "5%" },
                  //{ "bSortable": false, sWidth: "5%" },

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
                "sAjaxSource": url
            });
            
            $('#sample_1').css("width", "100%");
        }--%>

        function ReloadGrid() {
            $('#sample_1').dataTable().fnDraw();
        }

        function ChkValues() {
            alert("check rows will be deleted");
            //var count = $("#spnCount").html();
            var check = "false";
            var v = "key=finallyApprove&";

            var k = 1;
            $("#sample_1 tbody").find("input:checkbox").each(function () {
                if (this.checked == true) {
                    v += "chk" + k + "=" + this.value + "&";
                    k++;
                    //this.checked = chk.checked;
                }
            });
            v += "count=" + k;
            alert(v);
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
            $("#txtRemarks").val("");

            $("#txtReaderCode").val("");
            $("#txtReaderName").val("");
            $("#chkboxEnabled").removeAttr("checked");
            $("#uniform-chkboxEnabled span").removeClass("checked");
            $("#chkboxWebPunch").removeAttr("checked");
            $("#uniform-chkboxWebPunch span").removeClass("checked");

            $('#ddReaderType option[value=""]').attr('selected', 'selected');
            $("#ddReaderType").trigger("liszt:updated");
            $('#ddConnection option[value=""]').attr('selected', 'selected');
            $("#ddConnection").trigger("liszt:updated");
            $('#ddReaderDirection option[value=""]').attr('selected', 'selected');
            $("#ddReaderDirection").trigger("liszt:updated");
            $('#ddDeviceGroup option[value=""]').attr('selected', 'selected');
            $("#ddDeviceGroup").trigger("liszt:updated");
            $('#ddLocation option[value=""]').attr('selected', 'selected');
            $("#ddLocation").trigger("liszt:updated");
            $('#ddRegion option[value=""]').attr('selected', 'selected');
            $("#ddRegion").trigger("liszt:updated");

            $('#ddBuildingsList option[value=""]').attr('selected', 'selected');
            $("#ddBuildingsList").trigger("liszt:updated");





        }

        function clearSettings() {


           
             

            $("#selDisplay option[value='10']").attr("selected", "selected");
            $("#selDisplay").trigger("liszt:updated");
            $("#selSound option[value='80").attr("selected", "selected");
            $("#selSound").trigger("liszt:updated");

            $("#selscreenTimeOut option[value='600']").attr("selected", "selected");
            $("#selscreenTimeOut").trigger("liszt:updated");
            $("#selMsgTimeOut option[value='2']").attr("selected", "selected");
            $("#selMsgTimeOut").trigger("liszt:updated");
         
            $("#logo").val("");
            $("#screen1").val("");
            $("#screen2").val("");
            $("#screen3").val("");
            $("#screen4").val("");
            $("#screen5").val("");
            $("#txtButton1").val("");
            $("#txtButton2").val("");
            $("#txtButton3").val("");
            $("#txtButton4").val("");
            //$("#txtButton5").val("");
            $("#txtServerAddress").val("");
            $("#firmware").val("");

            $(".checker").find("span").removeClass("checked");

            $('input[name="authentication"]:checked').val(0);

        }

        /// Devie Action 

        $("#btnDBReload").click(function () {
            var result = window.confirm('Are you sure?');
            
            if (result == false) {
                e.preventDefault();
            }
            else {

                var ActionType = $('input[name="DBRELOAD"]:checked').val();
               
                CreateAction("DBRELOAD", ActionType);
                $('input[name="DBRELOAD"]:checked').val(0);
            }

        });

        $("#btnFirmware").click(function () {
            var result = window.confirm('Are you sure?');

            if (result == false) {
                e.preventDefault();
            }
            else {
                var ActionType = $('input[name="FIRMWARE"]:checked').val();

              
                CreateAction("FIRMWARE",ActionType);
                $('input[name="FIRMWARE"]:checked').val(0);
            }

        });

        $("#btnStats").click(function () {
            var result = window.confirm('Are you sure?');

            if (result == false) {
                e.preventDefault();
            }
            else {
                var ActionType = $('input[name="STATS"]:checked').val();
                CreateAction("STATS",ActionType);
                $('input[name="STATS"]:checked').val(0);
            }

        });

        $("#btnRestart").click(function () {
            var result = window.confirm('Are you sure?');

            if (result == false) {
                e.preventDefault();
            }
            else {
                var ActionType = $('input[name="RESTART"]:checked').val();
                CreateAction("RESTART",ActionType);
                $('input[name="RESTART"]:checked').val(0);
            }

        });

        $("#btnUpdateDeviceSetting").click(function () {
            var result = window.confirm('Are you sure?');

            if (result == false) {
                e.preventDefault();
            }
            else {
                var ActionType = $('input[name="SETUP"]:checked').val();
                CreateAction("SETUP",ActionType);
                $('input[name="SETUP"]:checked').val(0);
            }

        });

        $("#btnRestoreFS").click(function () {
            var result = window.confirm('Are you sure?');

            if (result == false) {
                e.preventDefault();
            }
            else {
                var ActionType = $('input[name="INITIALIZE"]:checked').val();
                CreateAction("INITIALIZE",ActionType);
                $('input[name="INITIALIZE"]:checked').val(0);
            }

        }); 

        $("#btnUpdateLogo").click(function () {
            var result = window.confirm('Are you sure?');

            if (result == false) {
                e.preventDefault();
            }
            else {
                var ActionType = $('input[name="LOGO"]:checked').val();
                CreateAction("LOGO", ActionType);
                $('input[name="LOGO"]:checked').val(0);
            }

        });  

        function CreateAction(Action, ActionType) {



            $("#divError2").css("display", "none");
            $("#divSuccess2").css("display", "none");

            if (ActionType == 'undefined' || ActionType == '')
                ActionType = 0

            var code = $("#txtCode").val();
            var d = "key=createAction&DeviceCode=" + code + "&Action=" + Action  + "&ActionType=" +ActionType

            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>',
                success: function (html) {
                     
                    if (html == "1") {
                        $("#divSuccess2").css("display", "block");
                        $("#spnSuccess2").html("<%=Resources.Resource.successful %>");
                    }
                    else {
                        $("#divError2").css("display", "block");
                        $("#spnError2").html("<%=Resources.Resource.msgError %>");
                    }
                },
                error: function (html) {
                    $("#divError2").css("display", "block");
                    $("#spnError2").html("<%=Resources.Resource.msgError %>");
               }
            });
       }

        ////// Device Actions


        var rslt = "";
        function ajaxFileUpload(fileUpload, code, ImageName) {

            //var id = $("#spnID").html();
            var str = "";

            //var id = $("#spnID").html();
            var str = "";

            // var fileUpload = $("#screen1").get(0);  
            var files = fileUpload.files;
            
                //var img = new Image();
                //var rstl2
                //img.src = window.URL.createObjectURL( files );

                //img.onload = function() {
                //    var width = img.naturalWidth,
                //        height = img.naturalHeight;

                //    window.URL.revokeObjectURL( img.src );

                //    if( width <= 480 && height <= 800 && ImageName != 'Logo' ) {
                //        rstl2 = true;
                //    }
                //    else if( width <= 266 && height <= 232 && ImageName == 'Logo' )
                //    {
                //        rstl2 = true;
                //    }
                //    else {
                //        rstl2 = false;
                //    }
                  
                //    if (!rstl2) {
                //        alert("Image Size is not correct");
                //    }
                //    else 
                //    {
                        var data = new FormData();
                        for (var i = 0; i < files.length; i++) {
                            data.append(files[i].name, files[i]);
                        }
                         var v = '<%= path %>Handlers/ImageUploader.ashx?DeviceID=' + code + '&ImageName=' + ImageName;
                     //      alert('im here' + v);
                        $.ajax({
                            url: v,
                            type: "POST",
                            data: data,
                            async: false,
                            contentType: false,
                            processData: false,
                            success: function (result) {

                                rslt = result;
                            },
                            error: function (err) {
                                return err.statusText;
                            }
                        });
                //}
              
             

            


        } ///////////////////////////////END OF FUNCTION ajaxFileUpload/////////////////////////////////////////
        ///// Device Settings 

        function SaveSettings(SavenApply) {

            var code = $("#txtCode").val();
            
            
            var Screen1 = "";
            var Screen2 = "";
            var Screen3 = "";
            var Screen4 = "";
            var Screen5 = "";
            var Logo = "";


            ajaxFileUpload($("#logo").get(0), code, "Logo");

            $.when(ajaxFileUpload($("#logo").get(0), code, "Logo")).done(function () {

                if (rslt == -1) {
                    alert('Logo File Type Not Supported');
                    exit(1);
                }
                else if (rslt == -2) {
                    alert('Logo Image Size is not compatible, size should be less than 266x232');
                    exit(1);
                }
                else {
                    if (rslt == '[object XMLDocument]')
                        rslt = '""'
                    else
                        Logo = rslt;
                    ajaxFileUpload($("#screen1").get(0), code, "Screen1");
                }

             });
                             
                $.when(ajaxFileUpload($("#screen1").get(0), code, "Screen1")).done(function () {
                   
                    if (rslt == -1) {
                        alert('Screen1 File Type Not Supported');
                        exit(1);
                    }
                    else if (rslt == -3) {
                        alert('Screen1 Image Size is not compatible, size should be less than 480x800');
                        exit(1);
                    }
                    else {
                        if (rslt == '[object XMLDocument]')
                            rslt = '""'
                        else {
                            Screen1 = rslt;
                            ajaxFileUpload($("#screen2").get(0), code, "Screen2");
                        }
                    }
                    
               });
               $.when(ajaxFileUpload($("#screen2").get(0), code, "Screen2")).done(function () {
                   if (rslt == -1) {
                       alert('Screen2 File Type Not Supported');
                       exit(1);
                   }
                   else if (rslt == -3) {
                       alert('Screen2 Image Size is not compatible, size should be less than 480x800');
                       exit(1);
                   }
                   else {
                       if (rslt == '[object XMLDocument]')
                           rslt = '""'
                       else {
                           Screen2 = rslt;
                           ajaxFileUpload($("#screen3").get(0), code, "Screen3");
                       }
                   }
                    
               });
               $.when(ajaxFileUpload($("#screen3").get(0), code, "Screen3")).done(function () {
                   if (rslt == -1) {
                       alert('Screen3 File Type Not Supported');
                       exit(1);
                   } else if (rslt == -3) {
                       alert('Screen3 Image Size is not compatible, size should be less than 480x800');
                       exit(1);
                   }
                   else {
                       if (rslt == '[object XMLDocument]')
                           rslt = '""'
                       else
                       {
                           Screen3 = rslt;
                  
                           ajaxFileUpload($("#screen4").get(0), code, "Screen4");
                       }
                   }
                   
               });
               $.when(ajaxFileUpload($("#screen4").get(0), code, "Screen4")).done(function () {
                   if (rslt == -1) {
                       alert('Screen4 File Type Not Supported');
                       exit(1);
                   } else if (rslt == -3) {
                       alert('Screen Image Size is not compatible, size should be less than 480x800');
                       exit(1);
                   }
                   else {
                       if (rslt == '[object XMLDocument]')
                           rslt = '""'
                       else
                       {
                           Screen4 = rslt;
                           ajaxFileUpload($("#screen5").get(0), code, "Screen5");
                       }
                   }
                   
               });
               $.when(ajaxFileUpload($("#screen5").get(0), code, "Screen5")).done(function () {
                   if (rslt == -1) {
                       alert('Screen5 File Type Not Supported');
                       exit(1);
                   } else if (rslt == -3) {
                       alert('Screen Image Size is not compatible, size should be less than 480x800');
                       exit(1) ;
                   }
                   else {
                       if (rslt == '[object XMLDocument]')
                           rslt = '""'
                       else
                       {
                           Screen5 = rslt;
                           ajaxFileUpload($("#logo").get(0), code, "Logo");
                       }

                   }
                    
               });
         
             //  alert(encodeURI(Screen1));
               var v = "key=SaveSettings&Code= " + code + "&Screen1=" + encodeURI(Screen1) + "&Screen2=" + encodeURI(Screen2) +
                       "&Screen3=" + encodeURI(Screen3) + "&Screen4=" + encodeURI(Screen4) + "&Screen5=" + encodeURI(Screen5) +
                       "&Logo=" + encodeURI(Logo);

               
              
            var Button1 = $("#txtButton1").val();
            var Button2 = $("#txtButton2").val();
            var Button3 = $("#txtButton3").val();
            var Button4 = $("#txtButton4").val();
           // var Button5 = $("#txtButton5").val();
            
            var screen1 = $("#txtscreen1").val();
            var screen2 = $("#txtscreen2").val();
            var screen3 = $("#txtscreen3").val();
            var screen4 = $("#txtscreen4").val();
            var screen5 = $("#txtscreen5").val();

            
            var ServerAddress = $("#txtServerAddress").val();
            var firmware = $("#firmware").val();

            var sound = $("#selSound").val();
            var display = $("#selDisplay").val();
            var messagetimeout = $("#selMsgTimeOut").val();
            var devicetimeout = $("#selscreenTimeOut").val();

            var enableAddUser = $("#chkAddUser").is(':checked') ? 1 : 0; //$("#chkAddUser").val();
            var enableUpdateUser = $("#chkUpdateUser").is(':checked') ? 1 : 0; //$("#chkUpdateUser").val();
            var enableDeleteUser = $("#chkDeleteUser").is(':checked') ? 1 : 0; //$("#chkDeleteUser").val();
             
               
             
            v = v + "&Button1=" + encodeURI(Button1) + "&Button2=" + encodeURI(Button2) + "&Button3=" + encodeURI(Button3) + "&Button4=" + encodeURI(Button4) //+ "&Button5=" + encodeURI(Button5)
            v = v + "&sound=" + sound + "&display=" + display + "&messagetimeout=" + messagetimeout + "&devicetimeout=" + devicetimeout
            v = v + "&enableAddUser=" + enableAddUser + "&enableUpdateUser=" + enableUpdateUser + "&enableDeleteUser=" + enableDeleteUser
            v = v + "&AuthenticationType=" + $('input[name="authentication"]:checked').val();  //SavenApply
            v = v + "&SavenApply=" + SavenApply + "&Firmware=" + encodeURI(firmware) + "&ServerAddress=" + encodeURI(ServerAddress);

           // alert(v);
           // var u = encodeURIComponent(v);
         //   alert(u);


            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderPage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#divError3").css("display", "block");
                       $("#spnError3").html("<%=Resources.Resource.msgRecordNotSaved %>");
                   }
                   else if (html == '0') {
                       //exists
                       $("#divError3").css("display", "block");
                       $("#spnError3").html("<%=Resources.Resource.msgRecordExists %>");
                   }
                   else {
                       //success
                       $("#divSuccess3").css("display", "block");
                       $("#spanSuccess3").html("<%=Resources.Resource.msgRecordSaved %>");
                       // $('#btnBroadCast').click();
                       clearSettings(); 
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("Error! " + html);
               }

           });
            //clearSettings();
            //return;
        }

 
        //// Device Settings 

        // Load Buildings list for dropdown

        function LoadBuildings() {

            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/BuildingsPage.aspx") %>',
                success: function (html) {
                    $("#ddBuildingsList").html(html);
                    $("#ddBuildingsList").trigger("liszt:updated");

                    //tempLoadCount++;
                    //var temp = $('#ddZonesList').text();
                    //if (temp != "" && tempLoadCount == 8) {
                    //    Clear();
                    //    //Edit(temp);
                    //}
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
            });
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
                   $("#ddRegions").html(html);
                   $("#ddRegions").trigger("liszt:updated");
                   //ddRegions
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
                    $("#ddDeviceTypes").html(html);
                    $("#ddDeviceTypes").trigger("liszt:updated"); 
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadConnectionTypeList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ConnectionTypePage.aspx") %>',
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

        function LoadDeviceLocationList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/LocationPage.aspx") %>',
                success: function (html) {
                    $("#ddLocation").html(html);
                    $("#ddLocation").trigger("liszt:updated");
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
                    $("#ddDeviceGroup").html(html);
                    $("#ddDeviceGroup").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function Delete() {
            var v = "key=deleteByID&";

            $("#divSuccessMsg2").css("display", "none");
            $("#divErrorMsg2").css("display", "none");

            var k = 0;
            $("#sample_1 tbody").find("input:checkbox").each(function () {
                if (this.checked == true) {
                    k++;
                    v += "chk" + k + "=" + this.value + "&";
                    //this.checked = chk.checked;
                }
            });
            v += "count=" + k;

            if (k == 0) {
                $("#divErrorMsg2").css("display", "block");
                $("#spnErrorMsg2").html("<%=Resources.Resource.selectOne %>");
                return;
            }
            if (confirm("<%=Resources.Resource.deleteMessage %>")) {
                $.ajax({
                    type: 'POST',
                    data: v,
                    url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderPage.aspx") %>',
                    success: function (html) {
                        if (html == "1") {
                            $("#divSuccessMsg2").css("display", "block");
                            $("#spnSuccessMsg2").html("<%=Resources.Resource.msgRecordDelete %>");
                            ReloadGrid();
                            $('#btnBroadCast').click();
                        }
                        else {
                            $("#divErrorMsg2").css("display", "block");
                            $("#spnErrorMsg2").html("<%=Resources.Resource.msgRecordNotDelete %>");
                        }
                    },
                    error: function (html) {

                    }
                });
            }
            else {
            }
        }


        function LoadDeviceSettings(code) {


            $("#divError3").css("display", "none");
            $("#divSuccess3").css("display", "none");

            var v = "key=GetDeviceSettingByCode&Code=" + code;

            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        //alert(html);
                        var j = $.parseJSON(html);
                        //alert(j);
                        $("#selDisplay option[value='"+j.Display+"']").attr("selected", "selected");
                        $("#selDisplay").trigger("liszt:updated");

                        $("#selSound option[value='" + j.Sound + "']").attr("selected", "selected");
                        $("#selSound").trigger("liszt:updated");
                        
                        $("#selscreenTimeOut option[value='" + j.Display_Timeout + "']").attr("selected", "selected");
                        $("#selscreenTimeOut").trigger("liszt:updated");
                        $("#selMsgTimeOut option[value='" + j.Message_Timeout + "']").attr("selected", "selected");
                        $("#selMsgTimeOut").trigger("liszt:updated");
                        //$("#logo").val(j.Logo);
                        //$("#screen1").val(j.Screen1);
                        //$("#screen2").val(j.Screen2);
                        //$("#screen3").val(j.Screen3);
                        //$("#screen4").val(j.Screen4);
                        //$("#screen5").val(j.Screen5);
                        $("#txtButton1").val(j.Button1);
                        $("#txtButton2").val(j.Button2);
                        $("#txtButton3").val(j.Button3);
                        $("#txtButton4").val(j.Button4);
                       // $("#txtButton5").val(j.Button5);
                        $("#txtServerAddress").val(j.Server_Address);
                        $("#firmware").val(j.Firmware);
                         

                        if (j.Add_User == true || j.Add_User == 'True') {
                            $("#chkAddUser").attr("checked", "checked");
                            $("#uniform-chkAddUser span").addClass("checked");
                        }
                        else
                            $("#uniform-chkAddUser span").removeClass("checked");

                        if (j.Update_User == true || j.Update_User == 'True') {
                            $("#chkUpdateUser").attr("checked", "checked");
                            $("#uniform-chkUpdateUser span").addClass("checked");
                        }
                        else
                            $("#uniform-chkUpdateUser span").removeClass("checked");

                        if (j.Delete_User == true || j.Delete_User == 'True') {
                            $("#chkDeleteUser").attr("checked", "checked");
                            $("#uniform-chkDeleteUser span").addClass("checked");
                        }
                        else
                            $("#uniform-chkDeleteUser span").removeClass("checked");


                        if (j.Authentication_Type == 0 || j.Authentication_Type == '0' ) {
                            $("#uniform-User span").removeClass("checked");
                            $("#uniform-Mixed span").removeClass("checked");
                            $("#uniform-Device span").addClass("checked");
                          //  $('input[name="authentication"]:checked').val(0);
                        }
                        if (j.Authentication_Type == 1 || j.Authentication_Type == '1') {

                            $("#uniform-Device span").removeClass("checked");
                            $("#uniform-Mixed span").removeClass("checked");
                            $("#uniform-User span").addClass("checked");
                     //       $('input[name="authentication"]:checked').val(1);
                        }
                        if (j.Authentication_Type == 2 || j.Authentication_Type == '2') {

                            $("#uniform-User span").removeClass("checked");
                            $("#uniform-Device span").removeClass("checked");
                            $("#uniform-Mixed span").addClass("checked");
                      //      $('input[name="authentication"]:checked').val(2);
                        }
                    }
                }
            });
        }

       function Edit(id) {
           //Edit code
           // Clear();
           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg").css("display", "none");
           
           $("#btnAdd").click();
           $("#spnID").html(id);
           
           $("#spnGridMsg").html("&nbsp;");
           var v = "key=getByID&id=" + id;

       //    alert(id);
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderPage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       debugger
                       if (j.ReaderTypeName == "CS Infotel") {
                           
                           $("#settings").show();
                           $("#action").show();
                           $("#portlet_tab2").css("visibility", "visible"); // and $("#dv1").css("visibility","hidden");
                           $("#portlet_tab3").css("visibility", "visible"); // and $("#dv1").css("visibility","hidden");
                          
                           LoadDeviceSettings(j.Code);
                            
                       }
                       else {

                           
                           $("#portlet_tab2").css("visibility", "hidden"); // and $("#dv1").css("visibility","hidden");
                           $("#portlet_tab3").css("visibility", "hidden"); // and $("#dv1").css("visibility","hidden");

                           $("#settings").hide();
                           $("#action").hide();

                       }
                       $("#spnID").val(j.ID);

                       $("#txtCode").val(j.Code);
                       $("#txtName").val(j.NameEn);

                       $("#txtIPAddress").val(j.IPAddress);
                       $("#txtPort").val(j.Port);
                       if (j.BaudRate != "")
                           $("#txtBaudRate").val(j.BaudRate);
                       if (j.Timeout != "")
                           $("#txtTimeOut").val(j.Timeout);
                       
                       if (j.ReaderLocation != "") {
                           $("#txtLocation").val(j.ReaderLocation);
                           var res = j.ReaderLocation.split(",");
                            var latitude = res[0];
                            var longitude = res[1];
                            var zoom = 16; 
                            initMap(parseFloat(latitude, 16), parseFloat(longitude, 16), j.NameEn, zoom);
                       }
                       else {
                           $("#txtLocation").val("24.452458453458874, 54.37738799761837");
                           var zoom = 10;
                           initMap(24.452458453458874, 54.37738799761837, j.NameEn,zoom);
                       }

                       $('#ddReaderType option[value=' + j.ReaderTypeID + ']').attr('selected', 'selected');
                       $("#ddReaderType").trigger("liszt:updated");
                       $('#ddConnection option[value=' + j.ConnectionTypeID + ']').attr('selected', 'selected');
                       $("#ddConnection").trigger("liszt:updated");
                       $('#ddReaderDirection option[value=' + j.DirectionID + ']').attr('selected', 'selected');
                       $("#ddReaderDirection").trigger("liszt:updated");
                       $('#ddDeviceGroup option[value=' + j.GroupID + ']').attr('selected', 'selected');
                       $("#ddDeviceGroup").trigger("liszt:updated");
                       $('#ddLocation option[value=' + j.LocationID + ']').attr('selected', 'selected');
                       $("#ddLocation").trigger("liszt:updated");
                       $('#ddRegion option[value=' + j.RegionID + ']').attr('selected', 'selected');
                       $("#ddRegion").trigger("liszt:updated");
                       $('#ddBuildingsList option[value=' + j.building_id + ']').attr('selected', 'selected');
                       $("#ddBuildingsList").trigger("liszt:updated");

                       if (j.EnableFlag + "" == "1") {
                           $("#chkboxEnabled").attr("checked", "checked");
                           $("#uniform-chkboxEnabled span").addClass("checked");
                       }
                       if (j.WebPunchFlag + "" == "1") {
                           $("#chkboxWebPunch").attr("checked", "checked");
                           $("#uniform-chkboxWebPunch span").addClass("checked");
                       }
                       $("#portlet-config").modal('show');
                       $("#portlet_tab1").modal('show');
               
                       
                       //$('#portlet-config').show();
                   }
               },
               error: function (html) {

               }
           });
       }





        function Validate(id) {
            //Edit code
            Clear();
            var v = "key=getByID&id=" + id;
            $("#btnShowValidateForm").click();
            $("#spnID").html(id);
            $("#spnGridMsg").html("&nbsp;");
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderPage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       $("#spnID").val(j.ID);
                       alert
                       $("#txtReaderCode").val(j.Code);
                       $("#txtReaderName").val(j.NameEn);

                       $("#txtReaderIPAddress").val(j.IPAddress);
                   }
               },
               error: function (html) {

               }
           });
        }
        

        function InValidateDevice(ReaderID) {
        
            if (confirm("test")) {
                //alert('Yes');
                var v = "key=InValidateDevice&id=" + ReaderID;
                $.ajax({
                    type: 'POST',
                    data: v,
                    url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        ReloadGrid();
                    }
                },
                error: function (html) {
                    $("#divErrorMsgValidate").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
                });
            }
            else {
                //alert('NO');

                return false;
            }

       }
        function ValidateDevice() {
            var id = $("#spnID").html();

            var code = $("#txtReaderCode").val();
            var name = $("#txtReaderName").val();
            var region = $("#ddRegions").val();
            var authorizeFlag = $("#chkBoxAuthorizeFlag").is(":checked");

            if ($('#form1_DeviceValidate').validate().form() == false) {
                return false;
            }
            
            var v = "key=validateDevice" + "&id=" + id + "&code=" + code + "&name=" + name + "&RegionID=" +region+"&authorizeFlag=" + authorizeFlag;
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderPage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#divErrorMsgValidate").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                   }
                   else if (html == '0') {
                       //exists
                       $("#divErrorMsgValidate").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   }
                   else {
                       //success
                       $("#divSuccessMsgValidate").css("display", "block");
                       $("#spnSuccessMsgValidate").html("<%=Resources.Resource.msgRecordSaved %>");
                       $('#btnBroadCast').click();
                       Clear();
                   }
               },
               error: function (html) {
                   $("#divErrorMsgValidate").css("display", "block");
                   $("#spnErrorMsg").html("Error! " + html);
               }

           });

   }

        function Save() {

            $("#divSuccessMsg").css("display", "none");
            $("#divErrorMsg").css("display", "none");
           

           var code = $("#txtCode").val();


           var name = $("#txtName").val();
           var ipAddress = $("#txtIPAddress").val();
           var port = $("#txtPort").val();
           var baudRate = $("#txtBaudRate").val();
           var connTimeout = $("#txtTimeOut").val();

           var readerType = $("#ddReaderType").val();
           var connectionType = $("#ddConnection").val();
           var direction = $("#ddReaderDirection").val();
           var region = $("#ddRegion").val();
           var locationID = $("#ddLocation").val();
           var groupID = $("#ddDeviceGroup").val();
           var ReaderLocation = $("#txtLocation").val();

           var slctd_building_id = $("#ddBuildingsList").val();
           
           var enableFlag = $("#chkboxEnabled").is(":checked");
           var webPunchFlag = $("#chkboxWebPunch").is(":checked");
           
           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }

           var id = $("#spnID").html();
           var v = "key=save" + "&id=" + id + "&code=" + code + "&name=" + name + "&ipAddress=" + ipAddress + "&port=" + port;
           v += "&baudRage=" + baudRate + "&connTimeout=" + connTimeout + "&readerType=" + readerType + "&connectionType=" + connectionType;           
           v += "&direction=" + direction + "&groupID=" + groupID + "&locationID=" + locationID + "&region=" + region
           v += "&enableFlag=" + enableFlag + "&webPunchFlag=" + webPunchFlag + "&ReaderLocation=" + ReaderLocation + "&building_id=" + slctd_building_id;
           
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderPage.aspx") %>',
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
                       ReloadGrid();
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

   var FormValidation = function () {


       return {
           //main function to initiate the module
           init: function () {

               // for more info visit the official plugin documentation: 
               // http://docs.jquery.com/Plugins/Validation

               var form1 = $('#form_sample_1');
               var error1 = $('.alert-error', form1);
               var success1 = $('.alert-success', form1);
               var form2 = $('#form1_DeviceValidate');
               var error2 = $('.alert-error', form2);
               var success2 = $('.alert-success', form2);
               $.validator.addMethod('IP4Checker', function (value) {
                   var ip = /^(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))$/;
                   return value.match(ip);
               }, '<%=Resources.Resource.reader %>');

               form1.validate({
                   errorElement: 'span', //default input error message container
                   errorClass: 'help-inline', // default input error message class
                   focusInvalid: false, // do not focus the last invalid input
                   ignore: "",
                   rules: {
                       code: {
                           minlength: 1,
                           required: true,
                           maxlength: 50
                       },
                       nameEn: {
                           minlength: 3,
                           required: true,
                           maxlength: 100
                       },
                       BuildingsList: {
                           required: true
                       },
                       ipAddress: {
                           minlength: 1,
                           required: true,
                           IP4Checker: true,
                           maxlength: 50
                       },
                       port: {
                           minlength: 1,
                           required: true,
                           number: true,
                           maxlength: 50
                       },
                       baudRate: {
                           number: true
                       },
                       timeout: {
                           number: true
                       },
                       direction: {
                           required: true
                       },
                       region: {
                           required: true
                       },
                       location: {
                           required: false
                       },
                       readerType: {
                           required: false
                       },
                       connectionType: {
                           required: true
                       }
                   },
                   message: {
                       nameEn: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       },
                       nameAr: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       },
                       BuildingsList: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       }
                   },
                   errorPlacement: function (error, element) { // render error placement for each input type
                       if (element.attr("name") == "readerType" || element.attr("name") == "connectionType"
                            || element.attr("name") == "direction" || element.attr("name") == "region") { // for uniform checkboxes, insert the after the given container
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


               form2.validate({
                   errorElement: 'span', //default input error message container
                   errorClass: 'help-inline', // default input error message class
                   focusInvalid: false, // do not focus the last invalid input
                   ignore: "",
                   rules: {
                       deviceCode: {
                           minlength: 1,
                           required: true,
                           maxlength: 50
                       },
                       deviceName: {
                           minlength: 3,
                           required: true,
                           maxlength: 100
                       },
                       regions: {
                           required: {
                               depends: function(element) {
                                   return $("#ddRegions").val() == "";
                               }
                           }
                       }
                   },
                   message: {
                       nameEn: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       },
                       nameAr: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       },
                       regions: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       }
                   },
                   errorPlacement: function (error, element) { // render error placement for each input type
                       if (element.attr("name") == "readerType" || element.attr("name") == "connectionType"
                            || element.attr("name") == "direction" || element.attr("name") == "region") { // for uniform checkboxes, insert the after the given container
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


        var map, infoWindow;
        function initMap(latitude, longitude, Name, Zoom) {
           
            var myLatLng = { lat: latitude, lng: longitude };
            
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: latitude, lng: longitude },
                zoom: Zoom,
            });
            //infoWindow = new google.maps.InfoWindow;
            //handleLocationError(false, infoWindow, map.getCenter());
            //infoWindow.setPosition(myLatLng);
            //infoWindow.setContent('Reader:' + Name);
            //infoWindow.open(map);
            //map.setCenter(myLatLng);
            var marker = new google.maps.Marker({
                position: myLatLng,
                icon: '../Images/reader-min.png',
                title: Name
            });

            // To add the marker to the map, call setMap();
            marker.setMap(map);
            // Update lat/long value of div when anywhere in the map is clicked    
            google.maps.event.addListener(map,'click',function(event) {                
               
                $("#txtLocation").val(event.latLng.lat() + ',' + event.latLng.lng());
                var marker = new google.maps.Marker({
                    position: { lat: event.latLng.lat(), lng: event.latLng.lng() },
                    title: Name
                });
                // To add the marker to the map, call setMap();
                marker.setMap(map);
            }); 
        }

        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
            infoWindow.setPosition(pos);
            infoWindow.setContent(browserHasGeolocation ?
                                  'Error: The Geolocation service failed.' :
                                  'Error: Your browser doesn\'t support geolocation.');
            infoWindow.open(map);
        }

    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:content>



