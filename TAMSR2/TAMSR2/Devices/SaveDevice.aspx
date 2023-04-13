<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveDevice.aspx.cs" Inherits="TAMSR2.Devices.SaveDevice" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.readers %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link href="../Styles/aksFileUpload.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
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
            color: black !important;
        }

        .portlet-tabs .nav-tabs > li > a {
            color: white !important;
        }

            .portlet-tabs .nav-tabs > li > a:hover {
                color: black !important;
            }

        .aks-file-upload {
            width: 17%;
            height: 125px;
            position: absolute;
            top: 30%;
            left: 41%;
        }

        .aks-file-upload-preview {
            position: unset !important;
        }

        .aks-file-upload-p-main {
            position: absolute;
            top: 0px;
            left: 0px;
        }

        .aks-file-upload-content {
            height: 73px;
        }

        .deviceButton {
            border-radius: 5px !important;
            padding: 15px;
            width: 100px !important;
        }

        .deviceButtonIcon {
            font-size: 50px;
            text-align: center;
        }
    </style>
</asp:Content>





<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- END   LIGHT BOX ERROR/MESSAGE -->


    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="modalDeviceTime" class="modal hide" style="width: 50%">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4>&nbsp; <%=Resources.Resource.set%> <%=Resources.Resource.device%> <%=Resources.Resource.time%></h4>
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
                                    <div class="span11">
                                        <div class="control-group">
                                            <div class="controls" style="margin: 0px !important">
                                                <div class="input-append bootstrap-timepicker-component" style="width: 100%">
                                                    <input type="text" id="txtInTime1" name="inTime1" class="m-wrap m-ctrl-small timepicker-24" style="width: 100%">
                                                    <span class="add-on"><i class="icon-time"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <div class="pull-right">
                                        <a id="btnShowValidateForm" style="display: none;" onclick="return Clear()" href="#portlet-config-Reader-Validate" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                        <button type="button" class="btn btn-outline-primary btn-md purple" id="btnUpdateDeviceTime">
                                            <%=Resources.Resource.update %> <%=Resources.Resource.device %> <%=Resources.Resource.time %>
                                        </button>

                                        <button type="button" onclick="return CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
                                    </div>
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

    <!-- BEGIN Message MODAL FORM-->
    <div id="modalMessage" class="modal hide" style="width: 50%">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title" id="modalMessageTitle">
                            <h4>&nbsp; <%=Resources.Resource.confirm%></h4>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <form action="#" id="form1_DeviceValidate1" class="form-horizontal">
                                <div id="divErrorMsgValidate1" class="alert alert-error hide">
                                    <span id="spnErrorMsgValidate1"><%=Resources.Resource.formErrors %></span>
                                </div>
                                <div id="divSuccessMsgValidate1" class="alert alert-success hide">
                                    <button class="close" data-dismiss="alert"></button>
                                    <span id="spnSuccessMsgValidate1"><%=Resources.Resource.formErrorsRemoved %></span>
                                </div>

                                <div class="row-fluid">
                                        <span id="modalPopupMessage"></span>
                                        <p id="modalPopupStatus"></p>
                                </div>

                                <div class="form-actions">
                                    <div class="pull-right">
                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnAction">
                                        <span><%=Resources.Resource.restart %> <%=Resources.Resource.the%> <%=Resources.Resource.device %></span>
                                    </button>

                                        <button type="button" onclick="return CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
                                    </div>
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
    <!-- END Message MODAL FORM-->


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
                    <%=Resources.Resource.device %> 
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
                    <li><a href="#"><%=Resources.Resource.save %> <%=Resources.Resource.device %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <%-- Start Device Details --%>
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey" id="divDeviceDetails">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.device%> <%=Resources.Resource.details%></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" class="reload"></a>
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

                            <!-- END FORM-->
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
                                            <label class="control-label" id="lblDeviceCode"><%=Resources.Resource.code %></label>
                                            <div class="controls">
                                                <input type="text" class="span6 m-wrap" style="width: 220px !important;" data-placeholder="<%=Resources.Resource.device %>" <%=Resources.Resource.code %> id="deviceCode" data-required="1" name="deviceCode" required>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.device %> <%=Resources.Resource.name %><span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" class="span6 m-wrap" style="width: 220px !important;" data-placeholder="<%=Resources.Resource.device %>" <%=Resources.Resource.name %> id="deviceName" data-required="1" name="deviceName" required>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row-->
                                <div class="row-fluid">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.macAddress %><span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" class="span6 m-wrap" style="width: 220px !important;" data-placeholder="<%=Resources.Resource.macAddress %>" id="macAddress" name="macAddress" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.ipAdress %><span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" class="span6 m-wrap" style="width: 220px !important;" placeholder="<%=Resources.Resource.ipAdress %>" id="ipAddress" name="ipAddress" required>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row-->
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label">&nbsp;</label>
                                            <div class="controls">
                                                <input id="chkboxEnabled" type="checkbox" name="enable" />
                                                <%=Resources.Resource.activeInActive %>
                                            </div>

                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label">&nbsp;</label>
                                            <div class="controls">
                                                <button type="button" class="btn purple" id="btnSaveDevice">
                                                    <i class="btn-primary"></i><%=Resources.Resource.save %>
                                                </button>
                                                <button type="button" class="btn btn-outline-primary btn-md" id="btnCancelDevice" onclick="ReturnViewReaderPage();">
                                                    <i class="btn-primary"></i><%=Resources.Resource.cancel %>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <!--/row-->

                                    <!-- /Row -->
                                    <span id="spnID" style="display: none;">0</span>
                            </form>

                        </div>
                    </div>
                </div>
                <!-- END EXAMPLE TABLE PORTLET-->
            </div>
        </div>
        <%-- End Device Details --%>
        <div id="divHideDeviceFunctionality">
            <%-- Start Device Details --%>
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="portlet box light-grey" id="divDeviceOperations">
                        <div class="portlet-title">
                            <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.device%> <%=Resources.Resource.operations%></div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a>
                                <a href="javascript:void(0);" class="reload"></a>
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

                                <!-- END FORM-->
                                <%--                                <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                    <span id="spnAddButton" runat="server">
                                        <a id="btnAdd" onclick="return Clear()" href="#portlet-config" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                    </span>
                                    <span id="spnDeleteButton" runat="server">
                                        <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                    </span>
                                </div>--%>

                                <%--<div class="span3">
                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnShutdownDevice" style="width: 100%">
                                        <i class="btn-primary"></i><%=Resources.Resource.shutdown %>
                                    </button>
                                </div>--%>
                                <div class="row-fluid">
                                    <div class="span2">
                                        <div class="control-group">
                                            <div class="controls">
                                                <%--                                                <div class="input-append bootstrap-timepicker-component">
                                                    <input type="text" id="txtInTime1" name="inTime1" class="m-wrap m-ctrl-small timepicker-24">
                                                    <span class="add-on"><i class="icon-time"></i></span>
                                                </div>--%>
                                                <button type="button" class="btn btn-outline-primary btn-md pull-right deviceButton" id="btnDeviceTime" onclick="$('#modalDeviceTime').modal('show');">
                                                    <i class="fa fa-clock deviceButtonIcon"></i>
                                                    <br />
                                                    <%=Resources.Resource.set %> <%=Resources.Resource.device %> <%=Resources.Resource.time %>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span1">
                                        <button type="button" class="btn btn-outline-primary btn-md pull-right deviceButton" id="btnRestartDeviceConfirm" onclick="ShowPopupForActionButtons($(this).text(),'RestartDevice','This action will restart the device,Do you want to proceed?')">
                                            <i class="fa fa-refresh deviceButtonIcon"></i>
                                            <br />
                                            <span><%=Resources.Resource.restart %> <%=Resources.Resource.the%> <%=Resources.Resource.device %></span>
                                        </button>
                                    </div>
                                    <div class="span1" style="margin-left: 10px !important">
                                        <div class="control-group">
                                            <div class="controls" style="float: left; margin-left: 0px;">
                                                <button type="button" class="btn btn-outline-primary btn-md pull-right deviceButton" id="btnDeleteAllFromDevice" onclick="ShowPopupForActionButtons($(this).text(),'DeleteAllFromDevice','This action will delete offline records,Do you want to proceed?')">
                                                    <i class="fa fa-trash deviceButtonIcon" style="color: red;"></i>
                                                    <br />
                                                    <%=Resources.Resource.delete%> <%=Resources.Resource.all%> <%=Resources.Resource.from%> <%=Resources.Resource.device%>
                                                </button>

                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span1">
                                        <div class="control-group">
                                            <div class="controls" style="float: left; margin-left: 0px;">
                                                <button type="button" class="btn btn-outline-primary btn-md pull-right deviceButton" id="btnGetAllEnrolled" onclick="ShowPopupForActionButtons($(this).text(),'GetAllEnrolled','This action will upload enrollment to device,Do you want to proceed?')">
                                                    <i class="fa fa-download deviceButtonIcon" style="color: green;"></i>
                                                    <br />
                                                    <%=Resources.Resource.push%> <%=Resources.Resource.all%> <%=Resources.Resource.to%> <%=Resources.Resource.device%>
                                                </button>

                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span1">
                                        <div class="control-group">
                                            <div class="controls" style="float: left; margin-left: 0px;">
                                                <button type="button" class="btn btn-outline-primary btn-md pull-right deviceButton" id="btnPushAllToDevice" onclick="ShowPopupForActionButtons($(this).text(),'PushAllToDevice','This action will download enrollment to device,Do you want to proceed?')">
                                                    <i class="fa fa-upload deviceButtonIcon" style="color: blue;"></i>
                                                    <br />
                                                    <%=Resources.Resource.get%> <%=Resources.Resource.all%> <%=Resources.Resource.enrolled%>
                                                </button>

                                            </div>
                                        </div>
                                    </div>

                                    <!--/span-->
                                    <div class="span1">
                                        <div class="control-group">
                                            <div class="controls" style="float: left; margin-left: 0px;">
                                                <button type="button" class="btn btn-outline-primary btn-md pull-right deviceButton" id="btnSyncUsers" onclick="ShowPopupForActionButtons($(this).text(),'SyncUsers','This action sync users with device,Do you want to proceed?')">
                                                    <i class="fa fa-user deviceButtonIcon"></i>
                                                    <br />
                                                    <span><%=Resources.Resource.sync%> <%=Resources.Resource.employee%></span>
                                                </button>

                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <br />
                                <div class="row-fluid">
                                    <div class="span2">
                                        <div class="control-group">
                                            <div class="controls" style="float: left; margin-left: 0px;">
                                                <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnDeleteSync" onclick="ShowPopupForActionButtons($(this).text(),'DeleteSync','This action will delete offline records, Do you want to proceed?')">
                                                    <i class="btn-primary"></i><%=Resources.Resource.delete%> <%=Resources.Resource.offline%> <%=Resources.Resource.records%>
                                                </button>

                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->

                                </div>

                                <div class="row-fluid">
                                    <div class="span12">
                                        <table class="table table-striped table-bordered table-hover dataTable" id="tblSync" style="width: 100%">
                                            <thead>
                                                <tr style="background-color: #e8e3e3;">
                                                    <th style="text-align: center;">
                                                        <input id="chkSelectAll" type="checkbox" name="authorizeFlag" /></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.type%></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.created%> <%=Resources.Resource.date%></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.status%></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.remarks%></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.employeeCode%></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.employeeName%></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->
                </div>
            </div>
            <%-- End Device Details --%>
            <%-- Start Set Wallpaper --%>
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="portlet box light-grey" id="divSetWallpaper">
                        <div class="portlet-title">
                            <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.set%> <%=Resources.Resource.wallpaper%></div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a>
                                <a href="javascript:void(0);" class="reload"></a>
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

                                <!-- END FORM-->
                                <div class="span12" style="text-align: center; position: relative;">
                                    <img src='../Images/Wallpaper_Transparent.png' width="25%" />
                                    <aks-file-upload class="span12" style="opacity: 0;"></aks-file-upload>
                                    <p id="uploadfile" type="json"></p>
                                </div>
                                <div class="row-fluid">
                                    <div class="span3 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.file %> <%=Resources.Resource.extension %></label>
                                            <label><%=Resources.Resource.extension %></label>

                                        </div>
                                    </div>
                                    <div class="span3 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.file %> <%=Resources.Resource.size %></label>
                                            <label><%=Resources.Resource.size %></label>

                                        </div>
                                    </div>
                                    <div class="span3 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.file %> <%=Resources.Resource.resolution %></label>
                                            <label>Kindly use 850x350 resolution which is recommended</label>

                                        </div>
                                    </div>
                                    <div class="span3 ">
                                        <div class="control-group">
                                            <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnSetWallpaper" style="width: 100%">
                                                <i class="btn-primary"></i><%=Resources.Resource.set %> <%=Resources.Resource.wallpaper %>
                                            </button>

                                        </div>
                                    </div>
                                    <!--/span-->

                                    <!--/span-->
                                </div>
                                <!--/row-->
                            </div>
                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->

                </div>
            </div>
            <%-- End Set Wallpaper --%>
            <%-- Start Function Keys --%>
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="portlet box light-grey" id="divFunctionKeys">
                        <div class="portlet-title">
                            <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.function%> <%=Resources.Resource.keys%></div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a>
                                <a href="javascript:void(0);" class="reload"></a>
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


                                <!-- END FORM-->
                                <form action="#" id="form_functionKeys" class="form-horizontal">

                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.f1 %></label>
                                                <div class="controls">
                                                    <input type="text" class="span6 m-wrap" style="width: 220px !important;" data-placeholder="<%=Resources.Resource.device %>" <%=Resources.Resource.code %> id="txtF1" data-required="1" name="txtF1" required>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.f4 %></label>
                                                <div class="controls">
                                                    <input type="text" class="span6 m-wrap" style="width: 220px !important;" data-placeholder="<%=Resources.Resource.device %>" <%=Resources.Resource.name %> id="txtF4" data-required="1" name="txtF4" required>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                    </div>

                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.f2%></label>
                                                <div class="controls">
                                                    <input type="text" class="span6 m-wrap" style="width: 220px !important;" data-placeholder="<%=Resources.Resource.device %>" <%=Resources.Resource.code %> id="txtF2" data-required="1" name="txtF2" required>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.f5%></label>
                                                <div class="controls">
                                                    <input type="text" class="span6 m-wrap" style="width: 220px !important;" data-placeholder="<%=Resources.Resource.device %>" <%=Resources.Resource.name %> id="txtF5" data-required="1" name="txtF5" required>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.f3%></label>
                                                <div class="controls">
                                                    <input type="text" class="span6 m-wrap" style="width: 220px !important;" data-placeholder="<%=Resources.Resource.device %>" <%=Resources.Resource.code %> id="txtF3" data-required="1" name="txtF3" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <div class="controls">
                                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnFunctionApply" style="width: 220px !important;">
                                                        <i class="btn-primary"></i><%=Resources.Resource.apply%>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->
                </div>
            </div>
            <%-- End Function Keys --%>
            <%-- Start Message --%>
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="portlet box light-grey" id="divMessage">
                        <div class="portlet-title">
                            <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.message%></div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a>
                                <a href="javascript:void(0);" class="reload"></a>
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


                                <!-- END FORM-->
                                <form action="#" id="form_ScreenMsg" class="form-horizontal">

                                    <div class="row-fluid">
                                        <div class="span4">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.choose %> <%=Resources.Resource.employee %></label>
                                                <div class="controls">
                                                    <select id="ddlUser" style="width: 220px;" name="ddlUser" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>">
                                                        <option value="001">001</option>
                                                        <option value="002" selected>002</option>
                                                        <option value="003">003</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span4">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.screen %> <%=Resources.Resource.message %></label>
                                                <div class="controls">
                                                    <input type="text" class="span12 m-wrap" data-placeholder="<%=Resources.Resource.screen %>" <%=Resources.Resource.message %> id="ScreenMsg" data-required="1" name="ScreenMsg" required>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span2">
                                            <div class="control-group">
                                                <div class="controls" style="float: left; margin-left: 0px;">
                                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnApply">
                                                        <i class="btn-primary"></i><%=Resources.Resource.apply%>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->
                </div>
            </div>
            <%-- End Message --%>
            <%-- Start Enrollment --%>
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="portlet box light-grey" id="divStartEnrollment">
                        <div class="portlet-title">
                            <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.start%> <%=Resources.Resource.enrollment%></div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a>
                                <a href="javascript:void(0);" class="reload"></a>
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


                                <!-- END FORM-->
                                <form action="#" id="form_sample_2" class="form-horizontal">

                                    <div class="row-fluid">
                                        <div class="span4">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.choose %> <%=Resources.Resource.employee %></label>
                                                <div class="controls">
                                                    <select id="ddlEmployee" style="width: 220px;" name="ddlEmployee" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>">
                                                        <option value="001">001</option>
                                                        <option value="002" selected>002</option>
                                                        <option value="003">003</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span1">
                                            <div class="control-group pull-right">
                                                <div class="controls" style="float: left; margin-left: 0px;">
                                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnEnroll" onclick="ShowPopupForActionButtons($(this).text(),'Enroll','This action will enroll selected user to device,Do you want to proceed?')">
                                                        <i class="btn-primary"></i><%=Resources.Resource.start%> <%=Resources.Resource.enrollment%>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <%--  <div class="span2">
                                            <div class="control-group">
                                                <div class="controls" style="float: left; margin-left: 0px;">
                                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnSyncEnroll">
                                                        <i class="btn-primary"></i><%=Resources.Resource.sync%> <%=Resources.Resource.enrollment%>
                                                    </button>

                                                </div>
                                            </div>
                                        </div>--%>
                                        <!--/span-->
                                        <div class="span1">
                                            <div class="control-group">
                                                <div class="controls" style="float: left; margin-left: 0px;">
                                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnDeleteSelectedFromDevice" onclick="ShowPopupForActionButtons($(this).text(),'DeleteSelectedFromDevice','This action will delete selected user from device,Do you want to proceed?')">
                                                        <i class="btn-primary"></i><%=Resources.Resource.delete%> <%=Resources.Resource.device%> <%=Resources.Resource.user%>
                                                    </button>

                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span1">
                                            <div class="control-group">
                                                <div class="controls" style="float: left; margin-left: 0px;">
                                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnGetSelectedEnrolled" onclick="ShowPopupForActionButtons($(this).text(),'GetSelectedEnrolled','This action will download selected user to device,Do you want to proceed?')">
                                                        <i class="btn-primary"></i><%=Resources.Resource.push%> <%=Resources.Resource.to%> <%=Resources.Resource.device%>
                                                    </button>

                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span1">
                                            <div class="control-group">
                                                <div class="controls" style="float: left; margin-left: 0px;">
                                                    <button type="button" class="btn btn-outline-primary btn-md pull-right" id="btnPushSelectedToDevice" onclick="ShowPopupForActionButtons($(this).text(),'PushSelectedToDevice','This action will upload selected user to device,Do you want to proceed?')">
                                                        <i class="btn-primary"></i><%=Resources.Resource.get%> <%=Resources.Resource.from%> <%=Resources.Resource.device%>
                                                    </button>

                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->
                </div>
            </div>
            <%-- End Message --%>
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
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>

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
    <script src="../Scripts/aksFileUpload.min.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">
        var glbDeviceId = 0;
        var imagebase64 = "";
        var DeviceFunctionId = "";
        $(document).ready(function () {
            //alert(typeof String.prototype.trim);
            if (typeof String.prototype.trim != 'function') {
                String.prototype.trim = function () {
                    return this.replace(/^\s+|\s+$/g, '');
                }
            }
        });

        $(document).ready(function () {
            debugger;
            var UrlParam = window.location.href.split('?')[1].replaceAll('%20', '');
            glbDeviceId = UrlParam.split('=')[1];

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

            //LoadGrid();
            //LoadRegionList();
            //LoadReaderTypeList();
            //LoadConnectionTypeList();
            //LoadDeviceLocationList();
            //LoadDeviceGroupList();
            //LoadBuildings(); // load buidlings dropdown list
            LoadEmployee();
            LoadSyncGrid();
            //Bind Event
            (function ($) {

                var origAppend = $.fn.append;

                $.fn.append = function () {
                    if ($('.aks-file-upload').parent().find('.drop-active').length > 0)
                        $('aks-file-upload').css('opacity', '1');
                    var result = origAppend.apply(this, arguments).trigger("append");
                    $(result).find('.aks-file-upload-image').find('img').attr('style', 'height:150px');



                    return result;
                };
            })(jQuery);



            $(".aks-file-upload-content").bind("append", function () {
                $('aks-file-upload').css('opacity', '1');
                $('.aks-file-upload-image').find('img').css('height', '150px !important');

            });
            //$(".aks-file-upload-preview").bind("delete", function () {
            //    $('aks-file-upload').css('opacity', '1');
            //});
            //End Bind Event


            $("aks-file-upload").aksFileUpload({

                fileUpload: "#uploadfile",
                dragDrop: true,
                maxSize: "1 MB",
                multiple: false,
                maxFile: 1,
                fileType: [

                    "png",

                ],
                ajaxUpload: false,
                ajax: {
                    directlyLoad: false,
                    url: "upload.php",
                    type: "POST",
                    data: "formData",
                    contentType: false,
                    processData: false,
                    cache: false,
                    async: true,
                    enctype: "multipart/form-data"
                },

            });
            $('#aksfileupload').change(function () {
                //$('.aks-file-upload-p-main').height($('.aks-file-upload').height());
                $('aks-file-upload').css('opacity', '1');

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


            //var refreshId = setInterval(function () {
            //    ReloadGrid();
            //}, 30000)
            if (window.location.href.split('?').length > 1) {
                var UrlParam = window.location.href.split('?')[1].replaceAll('%20', '');
                EditDevice(UrlParam.split('=')[1]);
                $('#lblDeviceCode').find('span.required').remove();
                $('#deviceCode').removeAttr('required');
                $('#divHideDeviceFunctionality').show();
            }
            else {
                $('#lblDeviceCode').append('<span class="required">*</span>');
                $('#deviceCode').attr('required', 'required');
                $('#divHideDeviceFunctionality').hide();
            }


            //if (jQuery().timepicker) {
            $('.timepicker-24').timepicker({
                minuteStep: 1,
                showSeconds: true,
                showMeridian: false
            });
            //}
            $('#divSetWallpaper').find('.collapse,.expand').click();
            $('#divFunctionKeys').find('.collapse,.expand').click();
            $('#divMessage').find('.collapse,.expand').click();
            $('#divStartEnrollment').find('.collapse,.expand').click();
        });


        $("#ddDeviceTypes").change(function () {
            LoadGrid();
        });
        $("#ddStatus").change(function () {
            LoadGrid();
        });
        function EditDevice(deviceId) {
            glbDeviceId = deviceId;
            var v = "key=getDevixceByID&id=" + deviceId;
            var DeviceUrl = "~/RequestPages/ReaderPage.aspx?key=getDeviceByID&id=" + deviceId;
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx?key=getDeviceByID&id=") %>' + deviceId;
            //$("#spnGridMsg").html("&nbsp;");
            //  alert(v);
            $.ajax({
                type: 'POST',
                data: v,
                url: url,
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);
                        //$("#spnID").html(j.ID);
                        //if (j.ID == "0" || j.ID == "") {
                        //    $("#spnID").html(j.ID);
                        //    return;
                        //}
                        $("#deviceCode").val(j.DeviceCode);
                        $("#deviceName").val(j.DeviceName);
                        $("#macAddress").val(j.MACAddress);
                        $("#ipAddress").val(j.IPAddress);
                        //$("#txtSystemActiveDate").val(j.SystemActivationDateStr);



                        if (j.IsActive) {
                            $("#chkboxEnabled").parent('span').addClass("checked");
                        }
                        else
                            $("#chkboxEnabled").parent('span').removeClass("checked");
                    }
                },
                error: function (html) {

                }

            });
            var v = "key=getFunctionKeysByDeviceID&id=" + deviceId;
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx?key=getFunctionKeysByDeviceID&id=") %>' + deviceId;

            $.ajax({
                type: 'POST',
                data: v,
                url: url,
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);

                        $(j.aaData).each(function (i, key) {
                            $('#txtF' + $(key)[0].split('_')[0]).val($(key)[0].split('_')[1]);
                        });

                    }
                },
                error: function (html) {

                }

            });
            var v = "key=getScreenMessageByDeviceID&id=" + deviceId;
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx?key=getScreenMessageByDeviceID&id=") %>' + deviceId;

            $.ajax({
                type: 'POST',
                data: v,
                url: url,
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);

                        $(j.aaData).each(function (i, key) {
                            $('#ScreenMsg').val($(key)[0]);
                        });
                    }
                },
                error: function (html) {

                }

            });

        }
        function EditFunctionKeys(deviceId) {
            var v = "key=getFunctionKeysByDeviceID&id=" + deviceId;
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx?key=getFunctionKeysByDeviceID&id=") %>' + deviceId;
            //$("#spnGridMsg").html("&nbsp;");
            //  alert(v);
            $.ajax({
                type: 'POST',
                data: v,
                url: url,
                success: function (html) {
                    //if (html != "") {
                    //    var j = $.parseJSON(html);
                    //    //$("#spnID").html(j.ID);
                    //    //if (j.ID == "0" || j.ID == "") {
                    //    //    $("#spnID").html(j.ID);
                    //    //    return;
                    //    //}
                    //    $("#deviceCode").val(j.DeviceCode);
                    //    $("#deviceName").val(j.DeviceName);
                    //    $("#macAddress").val(j.MACAddress);
                    //    $("#ipAddress").val(j.IPAddress);
                    //    //$("#txtSystemActiveDate").val(j.SystemActivationDateStr);



                    //}
                },
                error: function (html) {

                }

            });

        }

        function LoadGrid() {


            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx?key=GetDeviceData")%>';
            //alert(url);

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
        function CloseForm() {

            Clear();
            $("#divSuccessMsg").hide();

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


                CreateAction("FIRMWARE", ActionType);
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
                CreateAction("STATS", ActionType);
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
                CreateAction("RESTART", ActionType);
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
                CreateAction("SETUP", ActionType);
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
                CreateAction("INITIALIZE", ActionType);
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

        var baseUrl = "";
        var baseUrl = "";
        //Get CMI Base URL
        var d = "key=GetCMIBaseUrl";
        $.ajax({
            type: 'GET',
            data: d,
            url: '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>',
            success: function (html) {

                if (html != "") {
                    baseUrl = html;
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

        //Add Device
        $('#btnSaveDevice').click(function () {
            var msg = "";
            var d = "";
            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';

            code = $('#deviceCode').val();
            name = $('#deviceName').val();
            macAddress = $('#macAddress').val();
            ipAddress = $('#ipAddress').val();
            var IsDelete = $('#chkboxEnabled').prop('checked');
            //if ($('#btnSaveDevice').text() == 'Add Device') {
            if (glbDeviceId == 0) {
                d = "key=saveDevice" + "&Id=" + glbDeviceId + "&code=" + code + "&name=" + name + "&macAddress=" + macAddress + "&ipAddress=" + ipAddress + "&isDelete=" + IsDelete;
                $('#deviceCode').attr('required', 'required');
                msg = "Device added Successfully";
            }
            else {
                d = "key=editDevice" + "&id=" + glbDeviceId + "&name=" + name + "&macAddress=" + macAddress + "&ipAddress=" + ipAddress + "&isDelete=" + IsDelete;
                $('#deviceCode').removeAttr('required');
                msg = "Device updated Successfully";
            }
            //var data = "{'ID':" + DeviceId + "}";
            $.ajax({
                type: "GET",
                url: url,
                data: d,
                async: false,
                cache: false,
                success: function (response) {
                    clear();
                    alert(msg);
                }
            });
        });
        //Shutdown Device
        $('#btnShutdownDevice').click(function () {
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            d = "key=PowerOff" + "&id=" + glbDeviceId;
            $.ajax({
                type: "POST",
                url: url,
                data: d,
                async: false,
                cache: false,
                success: function (response) {
                    alert("Device Shutdown Successfully");
                }
            });
        });
        //Restart Device
        /*$('#btnRestartDevice').click(function () */
        function RestartDevice() {
            //var url = baseUrl + "/api/Device/" + glbDeviceId + "/RebootDevice";
            ////var data = "{'ID':" + DeviceId + "}";
            //$.ajax({
            //    type: "PUT",
            //    url: url,
            //    //data: data,
            //    async: false,
            //    cache: false,
            //    success: function (response) {
            //        alert("Device Restarted Successfully");
            //    }
            //});
            $('#modalPopupStatus').text('Restarting...');

            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            d = "key=RebootDevice" + "&id=" + glbDeviceId;
            $.ajax({
                type: "POST",
                url: url,
                data: d,
                async: true,
                cache: false,
                success: function (response) {
                    $('#modalPopupStatus').text('Device Restarted Successfully');

                }
            });
        }
        //});
        //Set Device Time
        $('#btnUpdateDeviceTime').click(function () {
        //function UpdateDeviceTime() {
            var dt = new Date();
            var month = (dt.getMonth() + 1).toString().padStart(2, "0");
            var day = dt.getDate().toString().padStart(2, "0");
            var year = dt.getFullYear();
            //var month = '00';
            //var day = '00';
            //var year = '00';
            var minute = $('#txtInTime1').val().split(':')[1];
            var hour = $('#txtInTime1').val().split(':')[0];
            var second = $('#txtInTime1').val().split(':')[2];
            var dateTime = month + "" + day + "" + hour + "" + minute + "" + year + "." + second;
            //var data = "{'ID':" + DeviceId + ",'dateTime':" + dateTime + "'}";
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            d = "key=SetSpecificTime" + "&id=" + glbDeviceId + "&dateTime=" + dateTime;
            $.ajax({
                type: "POST",
                url: url,
                data: d,
                async: true,
                cache: false,
                success: function (response) {
                    alert("Device Time Set Successfully");
                }
            });
        //}
            });
        //Function Keys
        $('#btnFunctionApply').click(function () {

            var KeyLabel = "";
            if ($('#form_functionKeys').validate().form() == false) {
                return false;
            }
            var keyNumber = "";
            var keyNumberForDB = "";
            for (var i = 1; i <= 5; i++) {
                keyNumber += i + ",";
                keyNumberForDB += "F" + i + ",";
                KeyLabel += $('#txtF' + i).val() + ",";
            }
            keyNumber = keyNumber.substring(0, keyNumber.length - 1);
            KeyLabel = KeyLabel.substring(0, KeyLabel.length - 1);
            var apiUrl = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            d = "key=UpdateKeyLabels" + "&id=" + glbDeviceId + "&keyNumber=" + keyNumber + "&label=" + KeyLabel + "&DevicefunctionIdNotIn=" + DeviceFunctionId;
            //if (KeyLabel != "") {
            $.ajax({
                type: "POST",
                url: apiUrl,
                data: d,
                async: true,
                cache: false,
                //contentType: 'application/json',
                success: function (response) {

                    alert("Function keys set successfully");

                }, error: function (response) {
                    debugger;
                    alert("error");
                }
            });
            //}

            //$.ajax({
            //    type: "GET",
            //    url: url,
            //    data: d,
            //    async: false,
            //    cache: false,
            //    success: function (response) {
            //        DeviceFunctionId = response + "," + (DeviceFunctionId == "0" ? "" : DeviceFunctionId);
            //        DeviceFunctionId = DeviceFunctionId[DeviceFunctionId.length - 1] == "," ? DeviceFunctionId.substring(0, DeviceFunctionId.length - 1) : DeviceFunctionId;
            //        console.log(DeviceFunctionId);
            //    }
            //});


            DeviceFunctionId = "";
        });
        //Show Message on Device
        $('#btnApply').click(function () {

            var Msg = $('#ScreenMsg').val();
            var uid = $('#ddlUser').val();
            //var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            //d = "key=UpdateUserMessage" + "&id=" + glbDeviceId + "&message=" + Msg + "&uid=" + uid;

            if ($('#form_ScreenMsg').validate().form() == false) {
                return false;
            }

            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            //d = "key=saveDeviceMessage" + "&DeviceId=" + glbDeviceId + "&Message=" + Msg;

            //$.ajax({
            //    type: "GET",
            //    url: url,
            //    data: d,
            //    async: false,
            //    cache: false,
            //    success: function (response) {
            //        //alert("Fuc");
            //    }
            //}); --%>

            d = "key=UpdateUserMessage" + "&id=" + glbDeviceId + "&message=" + Msg + "&uid=" + uid;
            $.ajax({
                type: "POST",
                url: url,
                data: d,
                async: false,
                cache: false,
                success: function (response) {
                    alert("Display Message updated Successfully");
                    //Insert Message in DB
                    var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
                    d = "key=saveDeviceMessage" + "&DeviceId=" + glbDeviceId + "&Message=" + Msg;
                    $.ajax({
                        type: "GET",
                        url: url,
                        data: d,
                        async: false,
                        cache: false,
                        success: function (response) {
                            //alert("Fuc");
                        }
                    });

                    //End Insert
                }
            });
        });
        //Start Enrollment on Device
        //$('#btnEnroll').click(function () {
        function Enroll() {
            //var url = baseUrl + "/api/Device/" + glbDeviceId + "/StartEnrollment";

            $('#modalPopupStatus').text('Restarting...');
            var EmployeeId = $('#ddlEmployee').val();
            if (EmployeeId == "") {
                alert("Please select employee.");
                return;
            }
            var name = $('#ddlEmployee option:selected').text();
            //var data = "{'UID':" + EmployeeId + "}";
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            d = "key=StartEnrollment" + "&id=" + glbDeviceId + "&uid=" + EmployeeId + "&name=" + name;

            $.ajax({
                type: "POST",
                url: url,
                data: d,
                async: false,
                cache: false,
                success: function (response) {
                    $('#modalPopupStatus').text("Employee enrolled Successfully");
                }
            });
        }
        //});
        //Start Enrollment on Device
        //$('#btnSyncUsers').click(function () {
        function SyncUsers() {
            //var url = baseUrl + "/api/Device/" + glbDeviceId + "/StartEnrollment";
            //var EmployeeId = $('#ddlEmployee').val();
            //var name = $('#ddlEmployee option:selected').text();
            //var data = "{'UID':" + EmployeeId + "}";
            $('#modalPopupStatus').text('Syncing...');
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            d = "key=SyncUsers" + "&id=" + glbDeviceId;

            $.ajax({
                type: "POST",
                url: url,
                data: d,
                async: false,
                cache: false,
                success: function (response) {
                    $('#modalPopupStatus').text('Employee profiles pushed to device Successfully');
                }
            });
            //});
        }
        //Start Enrollment on Device
        $('#btnSyncEnroll').click(function () {
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            d = "key=SyncEnrollment" + "&id=" + glbDeviceId;

            $.ajax({
                type: "PUT",
                url: url,
                //data: data,
                async: false,
                cache: false,
                success: function (response) {
                    alert("Enrollment synced Successfully");
                }
            });
        });
        $('#btnSetWallpaper').click(function (i, key) {
            //var Msg = $('#ScreenMsg').val();
            //var apiUrl = baseUrl + "/api/Device/" + glbDeviceId + "";

            var base64Image = "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";
            var image = convertImageToBinary(base64Image);
            var data = "{'Wallpaper':" + base64Image + "}";




            //Insert Wallpaper in DB
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            encodeImageFileAsURL($($('input[type=file]'))[0]);


            var file = $($('input[type=file]'))[0].files[0];
            var reader = new FileReader();
            reader.onloadend = function () {
                imagebase64 = reader.result;
                //var image = convertImageToBinary(imagebase64);
                var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
                d = "key=UpdateWallpaper" + "&id=" + glbDeviceId + "&image=" + imagebase64;


                $.ajax({
                    type: "POST",
                    url: url,
                    data: d,
                    async: false,
                    cache: false,
                    success: function (response) {
                        alert("Wallpaer set successfully");

                        var formData = new FormData();
                        formData.append("Key", "saveDeviceWallpaper");
                        formData.append("DeviceId", glbDeviceId);
                        formData.append("RequestPhoto", $($('input[type=file]'))[0].files[0]);

                        //d = "key=saveDeviceWallpaper" + "&DeviceId=" + glbDeviceId + "&Image='" + imagebase64 + "'";
                        //var requestObj = {};
                        //requestObj["DeviceId"] = glbDeviceId;
                        //requestObj["Image"] = base64Image;

                        $.ajax({
                            type: "POST",
                            url: url,
                            dataType: 'json',
                            data: formData,
                            processData: false,
                            contentType: false,
                            //async: false,
                            //cache: false,
                            success: function (response) {
                                //alert("Fuc");
                            }
                        });

                    }
                });
            }
            reader.readAsDataURL(file);

            //End Insert


<%--            $.ajax({
                type: "PUT",
                url: apiUrl,
                data: data,
                async: false,
                cache: false,
                success: function (response) {
                    alert("Wallpaer set successfully");


                }
            });--%>
        });
        //$('#btnDeleteAllFromDevice').click(function () {
        function DeleteAllFromDevice() {
            $('#modalPopupStatus').text('Deleting...');
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            var data = "key=AddToSyncTableWithDeleteFlag" + "&id=" + glbDeviceId + "&type=delete";

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                async: true,
                cache: false,
                success: function (response) {
                    LoadSyncGrid();
                    $('#modalPopupStatus').text("Offline operation is registered successfully.");
                }
            });
            //});
        }
        //$('#btnGetAllEnrolled').click(function () {
        function GetAllEnrolled() {
            $('#modalPopupStatus').text('Downloading...');
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            var data = "key=AddToSyncTableWithDeleteFlag" + "&id=" + glbDeviceId + "&type=download";
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                async: true,
                cache: false,
                success: function (response) {
                    LoadSyncGrid();
                    $('#modalPopupStatus').text("Offline operation is registered successfully.");
                }
            });
        }
        //});
        //$('#btnPushAllToDevice').click(function () {
        function PushAllToDevice() {
            $('#modalPopupStatus').text('Uploading...');
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            var data = "key=AddToSyncTableWithDeleteFlag" + "&id=" + glbDeviceId + "&type=upload";
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                async: true,
                cache: false,
                success: function (response) {
                    LoadSyncGrid();
                    $('#modalPopupStatus').text('Offline operation is registered successfully.');
                }
            });
        }
        //});
        //$('#btnDeleteSelectedFromDevice').click(function () {
        function DeleteSelectedFromDevice() {
            $('#modalPopupStatus').text('Deleting...');
            var EmployeeCode = $('#ddlEmployee').val();
            if (EmployeeCode == "") {
                alert("Please select employee.");
                return;
            }
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            var data = "key=AddSelectedToSyncTableWithDeleteFlag" + "&id=" + glbDeviceId + "&type=delete&EmployeeCode=" + EmployeeCode;
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                async: true,
                cache: false,
                success: function (response) {
                    LoadSyncGrid();
                    $('#modalPopupStatus').text("Offline operation is registered successfully.");
                }
            });
        }
        //});
        function PushSelectedToDevice() {
            $('#modalPopupStatus').text('Downloading...');
            var EmployeeCode = $('#ddlEmployee').val();
            if (EmployeeCode == "") {
                alert("Please select employee.");
                return;
            }
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            var data = "key=AddSelectedToSyncTableWithDeleteFlag" + "&id=" + glbDeviceId + "&type=upload&EmployeeCode=" + EmployeeCode;
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                async: true,
                cache: false,
                success: function (response) {
                    LoadSyncGrid();
                    $('#modalPopupStatus').text("Offline operation is registered successfully.");
                }
            });
            //});
        }
        //$('#btnGetSelectedEnrolled').click(function () {
        function GetSelectedEnrolled() {
            $('#modalPopupStatus').text('Enrolling...');
            var EmployeeCode = $('#ddlEmployee').val();
            if (EmployeeCode == "") {
                alert("Please select employee.");
                return;
            }
            var url = '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>';
            var data = "key=AddSelectedToSyncTableWithDeleteFlag" + "&id=" + glbDeviceId + "&type=download&EmployeeCode=" + EmployeeCode;
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                async: true,
                cache: false,
                success: function (response) {
                    LoadSyncGrid();
                    $('#modalPopupStatus').text("Offline operation is registered successfully.");
                }
            });
            //});
        }
        function ReturnViewReaderPage() {
            window.location.href = window.location.protocol + "//" + window.location.host + "/Devices/view-devices";
        }
        function encodeImageFileAsURL(element) {
            var file = element.files[0];
            var reader = new FileReader();
            reader.onloadend = function () {
                imagebase64 = reader.result;
            }
            reader.readAsDataURL(file);
        }
        function convertImageToBinary(dataURI) {
            var BASE64_MARKER = ';base64,';
            var base64Index = dataURI.indexOf(BASE64_MARKER) + BASE64_MARKER.length;
            var base64 = dataURI.substring(base64Index);
            var raw = window.atob(base64);
            var rawLength = raw.length;
            var array = new Uint8Array(new ArrayBuffer(rawLength));

            for (i = 0; i < rawLength; i++) {
                array[i] = raw.charCodeAt(i);
            }
            return array;
        }
        function CreateAction(Action, ActionType) {



            $("#divError2").css("display", "none");
            $("#divSuccess2").css("display", "none");

            if (ActionType == 'undefined' || ActionType == '')
                ActionType = 0

            var code = $("#txtCode").val();
            var d = "key=createAction&DeviceCode=" + code + "&Action=" + Action + "&ActionType=" + ActionType

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
                    else {
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
                    else {
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
                    exit(1);
                }
                else {
                    if (rslt == '[object XMLDocument]')
                        rslt = '""'
                    else {
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
                        $("#selDisplay option[value='" + j.Display + "']").attr("selected", "selected");
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


                        if (j.Authentication_Type == 0 || j.Authentication_Type == '0') {
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
                            initMap(24.452458453458874, 54.37738799761837, j.NameEn, zoom);
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

            var v = "key=validateDevice" + "&id=" + id + "&code=" + code + "&name=" + name + "&RegionID=" + region + "&authorizeFlag=" + authorizeFlag;
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
                    var formFunctionKeys = $('#form_functionKeys');
                    var formScreenMsg = $('#form_ScreenMsg');

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
                            },
                            txtF1: {
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
                                    depends: function (element) {
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

                    formFunctionKeys.validate({
                        errorElement: 'span', //default input error message container
                        errorClass: 'help-inline', // default input error message class
                        focusInvalid: false, // do not focus the last invalid input
                        ignore: "",
                        rules: {
                            txtF1: {
                                required: true,
                            },
                            txtF2: {
                                required: true,
                            },
                            txtF3: {
                                required: true,
                            },
                            txtF4: {
                                required: true,
                            },
                            txtF5: {
                                required: true,
                            },

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
                    formScreenMsg.validate({
                        errorElement: 'span', //default input error message container
                        errorClass: 'help-inline', // default input error message class
                        focusInvalid: false, // do not focus the last invalid input
                        ignore: "",
                        rules: {
                            ScreenMsg: {
                                required: true,
                            },
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
            google.maps.event.addListener(map, 'click', function (event) {

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
        function clear() {
            $("#uniform-chkboxEnabled span").removeClass("checked");
            $('#deviceCode').val('').parents('.control-group').removeClass('success');
            $('#deviceName').val('').parents('.control-group').removeClass('success');
            $('#macAddress').val('').parents('.control-group').removeClass('success');
            $('#ipAddress').val('').parents('.control-group').removeClass('success');

        }
        function LoadEmployee() {
            var data = "key=getUsers";
            $.ajax({
                type: 'POST',
                data: data,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>',
                async: false,
                cache: false,
                success: function (html) {
                    if (html == "")
                        return;
                    $("#ddlUser").html(html);
                    $("#ddlUser").trigger("liszt:updated");
                    $("#ddlEmployee").html(html);
                    $("#ddlEmployee").trigger("liszt:updated");

                    //ddRegions
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }
        function LoadSyncGrid() {
            var data = "key=getSync&id=" + glbDeviceId;
            $.ajax({
                type: 'POST',
                data: data,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>',
                async: true,
                cache: false,
                success: function (html) {
                    var json = JSON.parse(html);
                    if (json.Data == "[]" || json.Data == "")
                        return;
                    var data = "";
                    var jsonData = JSON.parse(json.Data);
                    $(jsonData).each(function (i, key) {
                        data += "<tr>";
                        data += "<td><input type='checkbox' id=" + key.ADS_SyncID + "></input></td>";
                        data += "<td>" + key.ADS_Type + "</td>";
                        data += "<td>" + key.ADS_CreatedDate + "</td>";
                        data += "<td>" + key.Status + "</td>";
                        data += "<td>" + key.Remarks + "</td>";
                        data += "<td>" + key.ADS_PersonID + "</td>";
                        data += "<td>" + key.name_eng + "</td>";
                        data += "</tr>";
                    });
                    if ($('#tblSync tbody').find('tr:first').hasClass('odd'))
                        $('#tblSync').dataTable().fnDestroy();
                    $('#tblSync tbody').empty();
                    $('#tblSync').append(data);
                    $('#tblSync').dataTable({
                        "aoColumnDefs": [
                            { "bSortable": false, "aTargets": [0] }
                        ]
                    });

                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }
        //$('#btnDeleteSync').click(function () {
        function DeleteSync() {
            $('#modalPopupMessage').text('Deleting...');
            var requestData = "";
            $($('#tblSync').dataTable().fnGetNodes()).find('td').find('input[type=checkbox]:checked').each(function (i, key) {
                requestData += $(key).prop('id') + ",";
            });
            requestData = requestData.substring(0, requestData.length - 1);
            var data = "key=deleteSyncData&id=" + glbDeviceId + "&syncIds=" + requestData;
            $.ajax({
                type: 'POST',
                data: data,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>',
                async: true,
                cache: false,
                success: function (html) {
                    $('#modalPopupMessage').text('Success');
                    LoadSyncGrid();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
            //});
        }
        $('#chkSelectAll').change(function () {
            $($('#tblSync').dataTable().fnGetNodes()).find('td').find('input[type=checkbox]').prop('checked', $(this).prop('checked'));
        });

        function ShowPopupForActionButtons(buttonText,functionName,message) {
            $('#modalPopupMessage').text(message);
            $('#modalPopupStatus').text("");

            //$('#btnAction').after('<button id=' + buttonId + ' type="button" onclick="' + functionName + '()">' + buttonText + '</button>')
            $('#modalMessage').modal('show');
            $('#btnAction').attr('onclick', functionName+'()').text(buttonText);
            //$('#btnAction').remove();
            
        }
    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>



