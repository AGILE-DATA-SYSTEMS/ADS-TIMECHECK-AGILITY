<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewSynchronization.aspx.cs" Inherits="TAMSR2.SyncData.ViewSynchronization" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.dataSynchronizaton %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />

    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
    <!-- END PAGE LEVEL STYLES -->
    <style type="text/css">
        #btnSync:hover {
            cursor: pointer;
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


                <!-- START LIGHT BOX ERROR/MESSAGE -->
                <a data-toggle="modal" id="btnAlertError" style="display: none;" class="btn btn-danger" role="button" href="#msgAlertError"><%=Resources.Resource.error %></a>
                <div id="msgAlertError" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h3 id="H1"><%=Resources.Resource.error %></h3>
                    </div>
                    <div class="modal-body">
                        <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
                    </div>
                </div>
                <a data-toggle="modal" id="btnAlertMessage" style="display: none;" class="btn btn-danger" role="button" href="#myModal2"><%=Resources.Resource.success %></a>
                <div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h3 id="myModalLabel2"><%=Resources.Resource.message %></h3>
                    </div>
                    <div class="modal-body">
                        <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
                    </div>
                </div>
                <a data-toggle="modal" id="btnSyncConfirmPopup" style="display: none;" class="btn btn-danger" role="button" href="#divConfirmationForm"><%=Resources.Resource.dataSynchronizaton %></a>
                <div id="divConfirmationForm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="divConfirmationForm" aria-hidden="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h3 id="H2"><%=Resources.Resource.dataSynchronizaton %></h3>
                    </div>
                    <div class="modal-body">
                        <div class="">
                            <div class="control-group">
                                <div style="clear: both; display: inline;" class="controls chzn-controls">
                                    <label class="control-label"><%=Resources.Resource.syncAlert %></label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="btnPopupYes" onclick="return DataSynchronization()" class="btn icn-only green"><%=Resources.Resource.yes %></button>
                        <%--<button onclick="return VerificationAproveReject('reject')" class="btn icn-only red"><%=Resources.Resource.reject %></button>--%>
                        <button id="btnHideSyncConfirmPopup" data-dismiss="modal" class="btn danger"><%=Resources.Resource.no %></button>
                    </div>
                </div>
                <!-- END   LIGHT BOX ERROR/MESSAGE -->


                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">
                    <%=Resources.Resource.dataSynchronizaton %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.synchronization %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.dataSynchronizaton %></a></li>

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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.dataSynchronizaton %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
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
                            <div class="span12">
                                <div class="control-group">
                                    <label class="control-label" style="clear: both; width: 160px !important; display: inline; float: left"><%=Resources.Resource.syncProcessName %> <span class="required">*</span></label>
                                    <div style="clear: both; display: inline;" class="controls chzn-controls">
                                        <select id="ddSyncProcessList" name="syncProcessList" tabindex="1" data-placeholder="Choose Sync Process" class="span6 chosen" style="width: 220px;">
                                            <option value="">Choose Sync Process</option>
                                            <option value="SyncFusion">Sync Master Data with Fusion</option>
                                            <option value="SyncExistingTAMS" style="display: none;">Sync with Existing TAMS</option>
                                            <option value="SyncOvertimeWithFusion">Sync Overtime to Fusion</option>
                                            <option value="SyncTAWithFusion">Sync Time Info to Fusion</option>
                                            <option value="SyncScheduleWithFusion">Sync Schedules to Fusion</option>
                                        </select>
                                        <br>
                                        <br>
                                    </div>
                                </div>
                            </div>
                            <div class="span12">
                                <div class="spna6 btn-group pull-<%= pullDirectionStr %>" style="padding-right: 30px ! important;">
                                    <span id="spnSyncButtons" runat="server">
                                        <a id="btnSync" onclick="return ConfirmTakeAction()" class="label label-important label-mini">&nbsp; <%=Resources.Resource.proceedSync %> <i class="icon-share-alt"></i></a>
                                    </span>
                                </div>
                            </div>


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
        <script src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/js/bootstrap-tree.js"></script>

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

        <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
        <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
        <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
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
                //TableManaged.init();
                //  FormValidation.init();

                FormComponents.init();

                $("#page-sidebar li").removeClass("active");
                $("#page-sidebar li ul li").removeClass("active");
                $("#page-sidebar li ul li ul li").removeClass("active");
                $("#liSynchronization").addClass("active");
                $("#liSynchronization .arrow").addClass("open");
                $("#liDataSynchronization").addClass("active");

                if ('<%= Session["sidebar"] + "" %>' != '') {
                    $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
                }


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
                    if (name == "TAMSR2_Emp_Reprocesdata") {
                        // ReloadGrid();
                    }
                };

                // Start the connection.
                $.connection.hub.start().done(function () {
                    $('#btnBroadCast').click(function () {
                        // Call the Send method on the hub. 
                        users.server.send('TAMSR2_Emp_Reprocesdata', '');
                        // Clear text box and reset focus for next comment. 
                    });
                });
            });


            function imposeMaxLength(Object, evt, MaxLen) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
                return (Object.value.length < MaxLen);
            }

            function ConfirmTakeAction() {
                $("#divSuccessMsg").css("display", "none");
                $("#divErrorMsg").css("display", "none");
                $("#divSuccessMsg2").css("display", "none");
                $("#divErrorMsg2").css("display", "none");

                var syncProcess = $("#ddSyncProcessList").val();

                $("#btnPopupYes").attr("disabled", false);
                $("#btnPopupYes").css("cursor", "default");
                //alert(syncProcess);
                if (syncProcess == "") {
                    $("#divErrorMsg2").css("display", "block");
                    $("#spnErrorMsg2").html("<%=Resources.Resource.syncProcessAtLeastOne  %>");
                    return;
                }
                else
                    $("#btnSyncConfirmPopup").click();
           return;
       }

       function DataSynchronization() {

           $("#btnHideSyncConfirmPopup").click();
           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           $("#btnSync").attr("disabled", "disabled");
           $("#btnPopupYes").attr("disabled", "disabled");
           $(".container-fluid").css("cursor", "wait");
           $("#btnSync").css("cursor", "wait");
           $("#btnPopupYes").css("cursor", "wait");

           var v = "key=syncData&syncProcessName=" + $("#ddSyncProcessList").val();

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/SynchronizationPage.aspx") %>',
                    success: function (html) {
                        $(".container-fluid").css("cursor", "default");
                        $("#btnSync").css("cursor", "default");
                        $("#btnSync").attr("disabled", false);
                        $("#btnPopupYes").attr("disabled", false);
                        $("#btnPopupYes").css("cursor", "default");

                        var j = $.parseJSON(html);
                        if (j.ActionResult == "1") {
                            $("#ddSyncProcessList").val("");
                            $("#ddSyncProcessList").trigger("liszt:updated");
                            $("#btnHideSyncConfirmPopup").click();

                            $("#divSuccessMsg").css("display", "block");
                            $("#spnSuccessMsg").html(j.ActionMessage);
                            //$("#spnSuccessMsg").html("<%=Resources.Resource.msgDataProcessSuccessfully %>");
                            $("#btnAlertMessage").click();


                        }
                        else {
                            $("#btnHideSyncConfirmPopup").click();
                            $("#divErrorMsg").css("display", "block");
                            $("#spnErrorMsg").html(j.ActionMessage);
                            //$("#spnErrorMsg").html("<%=Resources.Resource.msgDataProcessFailed %>");
                            $("#btnAlertError").click();
                        }
                    },
                    error: function (html) {
                        $(".container-fluid").css("cursor", "default");
                        $("#btnSync").css("cursor", "default");
                        $("#btnSync").attr("disabled", false);
                        $("#btnPopupYes").attr("disabled", false);
                        $("#btnPopupYes").css("cursor", "default");

                        $("#btnHideSyncConfirmPopup").click();
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgDataProcessFailed %>");
                        $("#btnAlertError").click();
                    }
                });

            }


            var FormComponents = function () {

                var handlejQueryUIDatePickers = function () {
                    $(".ui-date-picker").datepicker();

                }

                var handleDateTimePickers = function () {

                    if (jQuery().datepicker) {
                        $('#txtFromDate').datepicker({ format: 'yyyy-mm-dd' });
                        $('#txtToDate').datepicker({ format: 'yyyy-mm-dd' })
                    }



                }

                var handleInputMasks = function () {
                    $.extend($.inputmask.defaults, {
                        'autounmask': true
                    });

                    $("#txtFromDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
                    $("#txtToDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
                }

                return {
                    //main function to initiate the module
                    init: function () {
                        handlejQueryUIDatePickers();
                        handleDateTimePickers();
                        //  handleInputMasks();
                    }

                };

            }();
            ////////END OF FORM COMPONENTS////////


        </script>
        <!-- END JAVASCRIPTS -->
</asp:Content>

