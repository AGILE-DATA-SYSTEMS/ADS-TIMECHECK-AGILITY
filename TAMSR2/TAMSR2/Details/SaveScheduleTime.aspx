<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveScheduleTime.aspx.cs" Inherits="TAMSR2.Details.SaveScheduleTime" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.scheduleTimes %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
    <!-- END PAGE LEVEL STYLES -->
    <style>
       #divVerificationForm .modal-footers .btn {
            font-weight: bold;
        }
    </style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div id="divVerificationForm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="divVerificationForm" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h3 id="H2"><%=Resources.Resource.alert %></h3>
        </div>
        <div class="modal-body">
            <div id="spnVerification" style="font-size: 12px;"><%=Resources.Resource.intendedZeroValues %></div>
        </div>
        <div class="modal-footer">
            <button onclick="return SetIntendedValueFlag()" class="btn icn-only green"><%=Resources.Resource.yes %></button>
            <button id="btnHideVerificationPopup" data-dismiss="modal" class="btn danger"><%=Resources.Resource.no %></button>
        </div>
    </div>
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
                    <%=Resources.Resource.scheduleTimes %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.schedule %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href='<%= Page.ResolveClientUrl("~/Sch/Schedule-Times") %>'><%=Resources.Resource.scheduleTimes %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">
                
                <!-- BEGIN SAMPLE FORM PORTLET-->
                <div class="portlet box blue tabbable">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-reorder"></i>
                            <span class="hidden-480"><%=Resources.Resource.schedule + " " + Resources.Resource.settings %></span>
                        </div>
                    </div>
                    <div class="portlet-body form">

                        <div class="tabbable portlet-tabs">
                            <ul class="nav nav-tabs">
                                <li id="liPolicy"><a href="#portlet_tab3" data-toggle="tab"><%=Resources.Resource.policy %></a></li>
                                <li id="liRamadanSch"><a href="#portlet_tab2" data-toggle="tab"><%=Resources.Resource.ramadan %></a></li>
                                <li class="active" id="liNormalSch"><a href="#portlet_tab1" data-toggle="tab"><%=Resources.Resource.normal %></a></li>
                            </ul>

                            <div class="tab-content">
                                <div id="divErrorMsg" class="alert alert-error hide">
                                    <button class="close" data-dismiss="alert"></button>
                                    <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                                </div>
                                <div id="divSuccessMsg" class="alert alert-success hide">
                                    <button class="close" data-dismiss="alert"></button>
                                    <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                                </div>
                                <div class="clearfix">
                                    <div class="btn-group">
                                        <span id="spnGridMsg">&nbsp;</span>
                                    </div>
                                    <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                    </div>
                                </div>
                                <div class="tab-pane active" id="portlet_tab1">
                                    <!-- BEGIN FORM-->
                                    <form action="#" id="form_sample_1" class="form-horizontal">
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
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.scheduleLocation %><span class="required">*</span></label>
                                                    <div class="controls chzn-controls">
                                                        <select id="ddSchLocation" name="schLocation" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                            <option value=""></option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <input type="text" id="txtCode" name="code" data-required="1" style="width: 220px !important;" class="span8 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.color %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <div data-color-format="rgba" data-color="#3865a8" class="input-append color colorpicker-default">
                                                            <input type="text" id="txtColor" name="color" readonly="" value="#3865a8" class="m-wrap">
                                                            <span class="add-on"><i style="background-color: #3865a8;"></i></span>
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
                                                    <label class="control-label"><%=Resources.Resource.inTime1 %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtInTime1" name="inTime1" class="m-wrap m-ctrl-small timepicker-24">
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.outTime1 %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtOutTime1" name="outTime1" class="m-wrap m-ctrl-small timepicker-24">
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
                                                    <label class="control-label"><%=Resources.Resource.requiredWorkHours %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtRequiredWorkHours" name="inTime2" class="m-wrap m-ctrl-small timepicker-24">
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label">&nbsp;</label>
                                                    <div class="controls">
                                                        <input id="chkboxOpenShift" type="checkbox" name="openShift" />
                                                        <%=Resources.Resource.openShift %>
                                                        <br />
                                                        <input id="chkboxNightShift" type="checkbox" name="nightShift" />
                                                        <%=Resources.Resource.nightShift %>
                                                        
                                                        
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.inTime2 %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtInTime2" name="inTime2" class="m-wrap m-ctrl-small timepicker-24">
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.outTime2 %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtOutTime2" name="outTime2" class="m-wrap m-ctrl-small timepicker-24">
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
                                                    <label class="control-label"><%=Resources.Resource.requiredWorkHours %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtRequiredWorkHours2" name="inTime2" class="m-wrap m-ctrl-small timepicker-24">
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label">&nbsp;</label>
                                                    <div class="controls">
                                                        <input id="chkboxOpenShift2" type="checkbox" name="openShift" />
                                                        <%=Resources.Resource.openShift %>
                                                        <br />
                                                        <input id="chkboxNightShift2" type="checkbox" name="nightShift" />
                                                        <%=Resources.Resource.nightShift %>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.inTime3 %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtInTime3" name="inTime3" class="m-wrap m-ctrl-small timepicker-24">
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.outTime3 %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtOutTime3" name="outTime3" class="m-wrap m-ctrl-small timepicker-24">
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
                                                    <label class="control-label"><%=Resources.Resource.requiredWorkHours %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtRequiredWorkHours3" name="outTime3" class="m-wrap m-ctrl-small timepicker-24">
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label">&nbsp;</label>
                                                    <div class="controls">
                                                        <input id="chkboxOpenShift3" type="checkbox" name="openShift" />
                                                        <%=Resources.Resource.openShift %>
                                                        <br />
                                                        <input id="chkboxNightShift3" type="checkbox" name="nightShift" />
                                                        <%=Resources.Resource.nightShift %>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.graceIn %> (<%=Resources.Resource.minutes %>) </label>
                                                    <div class="controls">
                                                        <input type="text" id="txtGraceIn" name="graceIn" value="0" data-required="1" style="width: 220px !important;" class="span8 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.graceOut %> (<%=Resources.Resource.minutes %>) </label>
                                                    <div class="controls">
                                                        <input type="text" id="txtGraceOut" name="graceOut" value="0" data-required="1" style="width: 220px !important;" class="span8 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.flexible %> (<%=Resources.Resource.minutes %>) </label>
                                                    <div class="controls">
                                                        <input type="text" id="txtFlexible" name="flexible" value="0" data-required="1" style="width: 220px !important;" class="span8 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label">  <%=Resources.Resource.inactiveDate %></label>
                                                   <div class="controls">
                                                    <input id="txtInactiveDate" name="inactivedate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                                      
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                    </form>
                                    <!-- END FORM-->
                                </div>
                                <div class="tab-pane" id="portlet_tab2">
                                    <!-- BEGIN FORM-->
                                    <form action="#" id="form3" class="form-horizontal">
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                                    <div class="controls chzn-controls">
                                                        <select id="ddOrgSpl" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                            <option value=""></option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.scheduleLocation %><span class="required">*</span></label>
                                                    <div class="controls chzn-controls">
                                                        <select id="ddSchLocationSpl" name="schLocation" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                            <option value=""></option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <input type="text" id="txtCodeSpl" disabled="disabled" name="code" data-required="1" style="width: 220px !important;" class="span8 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.color %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <div data-color-format="rgba" data-color="#3865a8" class="input-append color colorpicker-default">
                                                            <input type="text" id="txtColorSpl" disabled="disabled" name="color" readonly="" value="#3865a8" class="m-wrap">
                                                            <span class="add-on"><i style="background-color: #3865a8;"></i></span>
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
                                                    <label class="control-label"><%=Resources.Resource.inTime1 %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component">
                                                            <input type="text" id="txtInTime1Spl" name="inTime1" class="m-wrap m-ctrl-small timepicker-24" >
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.outTime1 %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component">
                                                            <input type="text" id="txtOutTime1Spl" name="outTime1" class="m-wrap m-ctrl-small timepicker-24" >
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
                                                    <label class="control-label"><%=Resources.Resource.requiredWorkHours %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component"> 
                                                            <input type="text" id="txtRequiredWorkHoursSpl" name="inTime2" class="m-wrap m-ctrl-small timepicker-24" >
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label">&nbsp;</label>
                                                    <div class="controls">
                                                        <input id="chkboxOpenShiftSpl" type="checkbox" name="openShift" />
                                                        <%=Resources.Resource.openShift %>
                                                        <br />
                                                        <input id="chkboxNightShiftSpl" type="checkbox" name="nightShift" />
                                                        <%=Resources.Resource.nightShift %>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.inTime2 %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component">
                                                            <input type="text" id="txtInTime2Spl" name="inTime2" class="m-wrap m-ctrl-small timepicker-24" > 
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.outTime2 %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component">
                                                            <input type="text" id="txtOutTime2Spl" name="outTime2" class="m-wrap m-ctrl-small timepicker-24" >
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
                                                    <label class="control-label"><%=Resources.Resource.requiredWorkHours %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component">
                                                            <input type="text" id="txtRequiredWorkHoursSpl2" name="inTime2" class="m-wrap m-ctrl-small timepicker-24" >
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label">&nbsp;</label>
                                                    <div class="controls">
                                                        <input id="chkboxOpenShiftSpl2" type="checkbox" name="openShift" />
                                                        <%=Resources.Resource.openShift %>
                                                        <br />
                                                        <input id="chkboxNightShiftSpl2" type="checkbox" name="nightShift" />
                                                        <%=Resources.Resource.nightShift %>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.inTime3 %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component">
                                                            <input type="text" id="txtInTime3Spl" name="inTime3" class="m-wrap m-ctrl-small timepicker-24" >
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.outTime3 %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component">
                                                            <input type="text" id="txtOutTime3Spl" name="outTime3" class="m-wrap m-ctrl-small timepicker-24" >
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
                                                    <label class="control-label"><%=Resources.Resource.requiredWorkHours %> </label>
                                                    <div class="controls">
                                                        <div class="input-append bootstrap-timepicker-component">
                                                            <input type="text" id="txtRequiredWorkHoursSpl3" name="inTime2" class="m-wrap m-ctrl-small timepicker-24" >
                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label">&nbsp;</label>
                                                    <div class="controls">
                                                        <input id="chkboxOpenShiftSpl3" type="checkbox" name="openShift" />
                                                        <%=Resources.Resource.openShift %>
                                                        <br />
                                                        <input id="chkboxNightShiftSpl3" type="checkbox" name="nightShift" />
                                                        <%=Resources.Resource.nightShift %>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.graceIn %> (<%=Resources.Resource.minutes %>) </label>
                                                    <div class="controls">
                                                        <input type="text" id="txtGraceInSpl" name="graceIn" value="0" data-required="1" style="width: 220px !important;" class="span8 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.graceOut %> (<%=Resources.Resource.minutes %>) </label>
                                                    <div class="controls">
                                                        <input type="text" id="txtGraceOutSpl" name="graceOut" value="0" data-required="1" style="width: 220px !important;" class="span8 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.flexible %> (<%=Resources.Resource.minutes %>) </label>
                                                    <div class="controls">
                                                        <input type="text" id="txtFlexibleSpl" name="flexible" value="0" data-required="1" style="width: 220px !important;" class="span8 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                 <%--<div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.showOnReport %>  </label>
                                                <div class="controls">
                                                    <label class="radio  " style="margin:10px;  ">
                                                        <div class="radio" id="Ramdan-FINFOUT">
                                                            <span class="checked">
                                                                 <input type="radio" checked   value="0" name="dmrRmdTransactions" style="opacity: 0;" />
                                                             </span>
                                                        </div>
                                                         <%=Resources.Resource.firstINlastOUT %>
                                                     </label>
                                                     <label class="radio  " style="margin:10px;">
                                                         <div class="radio" id="Ramdan-AllTrans">
                                                             <span class=""><input type="radio"   value="1" name="dmrRmdTransactions" style="opacity: 0;"></span>

                                                         </div>
                                                         <%=Resources.Resource.alltransaction %>
                                                     </label>  
                                                    </div>
                                                    </div>--%>
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                    </form>
                                    <!-- END FORM-->
                                </div>
                                <div class="tab-pane" id="portlet_tab3">
                                    <!-- BEGIN FORM-->
                                    <form action="#" id="form2" class="form-horizontal">
                                        


                                        <!--/row-->
                                         <div class="row-fluid" id="divProcessTrans" style="display:none !important;">
                                             <div class="span6 ">                                                    
                                               <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.process + " " + Resources.Resource.transaction   %>  </label>
                                                    <div class="controls">
                                                    <label class="radio  " style="margin:10px;  " id="Label1">
                                                        <div class="radio" id="processtranstimeout">
                                                            <span class="checked">
                                                                 <input type="radio" checked   value="0" name="processTransaction" style="opacity: 0;" />
                                                             </span>
                                                        </div>
                                                         <%=Resources.Resource.timeOut + " " + Resources.Resource.day  %>
                                                     </label>
                                                     <label class="radio  " style="margin:10px;" id="Label2">
                                                         <div class="radio" id="processtranstimein" >
                                                             <span class=""><input type="radio"   value="1" name="processTransaction" style="opacity: 0;"></span>

                                                         </div>
                                                         <%=Resources.Resource.timeIn + " " + Resources.Resource.day  %>
                                                     </label>  
                                                    </div>
                                             </div>
                                            </div>
                                            <!--/span-->
                                             <div class="span6 ">
                                              
                                            </div>
                                            <!--/span-->
                                        
                                        <!--/row-->
                                        </div>

                                        <div class="row-fluid">
                                           
                                            <div class="span6 ">
                                                 <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.showOnReport %>  </label>
                                                <div class="controls">
                                                    <label class="radio  " style="margin:10px;  ">
                                                        <div class="radio" id="uniform-FINFOUT">
                                                            <span class="checked">
                                                                 <input type="radio" checked   value="0" name="dmrTransactions" style="opacity: 0;" />
                                                             </span>
                                                        </div>
                                                         <%=Resources.Resource.firstINlastOUT %>
                                                     </label>
                                                     <label class="radio  " style="margin:10px;">
                                                         <div class="radio" id="uniform-AllTrans">
                                                             <span class=""><input type="radio"   value="1" name="dmrTransactions" style="opacity: 0;"></span>

                                                         </div>
                                                         <%=Resources.Resource.alltransaction %>
                                                     </label>  
                                                    </div>
                                                    </div>
                                            </div>
                                            <!--/span-->
                                            <div class="span6 ">
                                                
                                            </div>
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                         <div class="row-fluid">
                                             <div class="span6 ">                                                    
                                               <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.emailNotification %>  </label>
                                                    <div class="controls">
                                                    <label class="radio  " style="margin:10px;  " id="lblFinFout">
                                                        <div class="radio" id="Notification_FINFOUT">
                                                            <span class="checked">
                                                                 <input type="radio" checked   value="0" name="notification" style="opacity: 0;" />
                                                             </span>
                                                        </div>
                                                         <%=Resources.Resource.firstINlastOUT %>
                                                     </label>
                                                     <label class="radio  " style="margin:10px;" id="lblAll">
                                                         <div class="radio" id="Notification_ALL" >
                                                             <span class=""><input type="radio"   value="1" name="notification" style="opacity: 0;"></span>

                                                         </div>
                                                         <%=Resources.Resource.alltransaction %>
                                                     </label>  
                                                    </div>
                                             </div>
                                            </div>
                                            <!--/span-->
                                             <div class="span6 ">
                                              
                                            </div>
                                            <!--/span-->
                                        
                                        <!--/row-->
                                        </div>
                                        
                                        <div class="row-fluid">
                                            <div class="span6 ">
                                               <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.workHours  + " " + Resources.Resource.settings%>  </label>
                                                    <div class="controls" style="padding-top:0.8% !important">
                                                        <div class="checker" id="uniform-chkboxWorkHoursFromSchStart"><span class=""><input id="chkboxWorkHoursFromSchStart" name="enable" style="opacity: 0;" checked="checked" type="checkbox"></span></div>
                                                        <%=Resources.Resource.strCalculateWorkedHoursFromSchStart%>
                                                    </div>
                                             </div>
                                             </div>
                                            <div class="span6">

                                            </div>
                                        </div>
                                        <div class="row-fluid">
                                             <div class="span6 ">                                                    
                                               <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.overtime  + " " + Resources.Resource.settings%>  </label>
                                                    <div class="controls" style="padding-top:0.8% !important">
                                                        <div class="checker" id="uniform-chkboxOvertime"><span class=""><input id="chkboxOvertime" name="enable" style="opacity: 0;" checked="checked" type="checkbox"></span></div>
                                                        <%=Resources.Resource.enable  + " " + Resources.Resource.strdefault  + " " + Resources.Resource.overtime%>
                                                    </div>
                                             </div>
                                                  <div class="control-group">
                                                    <label class="control-label" id="lblOvertimeMins" style="display:none;"><%=Resources.Resource.overtime %> (<%=Resources.Resource.minutes %>)<span class="required">*</span></label>
                                                    <div class="controls">
                                                        <input id="txtOvertimeMins" name="OvertimeMins" value="0" data-required="1" style="width: 220px !important; display:none;" class="span6 m-wrap" type="text">
                                                    </div>
                                                </div>
                                                </div>
                                            <!--/span-->
                                            
                                            <!--/span-->
                                        </div>
                                        <div class="row-fluid">
                                             <div class="span6 ">                                                    
                                               <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.breakhours  + " " + Resources.Resource.settings%>  </label>
                                                    <div class="controls" style="padding-top:0.8% !important">
                                                        <div class="checker" id="uniform-chkBreakHours"><span class=""><input id="chkBreakHours" name="enable" style="opacity: 0;" checked="checked" type="checkbox"></span></div>
                                                        <%=Resources.Resource.enable  + " " + Resources.Resource.strdefault  + " " + Resources.Resource.breakhours%>
                                                    </div>
                                             </div>
                                                  <div class="control-group">
                                                    <label class="control-label" id="lblBreakHours" style="display:none;"><%=Resources.Resource.breakhours %> (<%=Resources.Resource.minutes %>)<span class="required">*</span></label>
                                                    <div class="controls">
                                                        <input id="txtBreakHours" name="OvertimeMins" value="0" data-required="1" style="width: 220px !important; display:none;" class="span6 m-wrap" type="text">
                                                    </div>
                                                </div>
                                                </div>
                                            <!--/span-->
                                            
                                            <!--/span-->
                                        </div>
                                        <!--/row-->
                                           <div class="row-fluid">
                                                <div class="span6 ">                                                    
                                               <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.overrideScheduleOnHoliday  + " " + Resources.Resource.settings%>  </label>
                                                    <div class="controls" style="padding-top:0.8% !important">
                                                          <div class="checker" id="uniform_ScheduleOverride"><span class=""><input id="chkScheduleOverride" name="ScheduleOverride" style="opacity: 0;"   type="checkbox"></span></div>
                                                        <%=Resources.Resource.overrideScheduleOnHoliday %>
                                                    </div>
                                               </div>  
                                            </div>
                                        </div>
                                            <div class="row-fluid">
                                                <div class="span6 ">                                                    
                                               <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.allowPermissionReduction%></label>
                                                    <div class="controls" style="padding-top:0.8% !important">
                                                          <div class="checker" id="uniform_ReduceWorkMts"><span class=""><input id="chkReduceWorkMts" name="ReduceWorkMts" style="opacity: 0;"   type="checkbox"></span></div>
                                                        <%=Resources.Resource.ReducePermissionHourFromSchedule %>
                                                    </div>
                                               </div>  
                                            </div>
                                        </div>
                                    </form>
                                    <!-- END FORM-->
                                </div>
                                 </div>
                                <div class="form-actions">
                                    <span id="spnID" style="display: none;">0</span>
                                    <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                                    <button id="btnSave" type="button" onclick="PreSave()" class="btn purple"><%=Resources.Resource.save %></button>
                                    <button type="button" onclick="CloseForm()" class="btn"><%=Resources.Resource.cancel %></button>
                                    <button type="reset" id="btnCloseForm" style="display: none;" data-dismiss="modal" class="btn"><%=Resources.Resource.close %></button>
                                </div>

                            </div>
                       
                    </div>
                </div>
                <!-- END SAMPLE FORM PORTLET-->

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
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
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
       var tempOrg = false;
       var tempLoc = false;
       var isIntendedValues = false;

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
           $("#liSch").addClass("active");
           $("#liSch .arrow").addClass("open");
           $("#liSchTime").addClass("active");


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
               if (name == "TAMSR2_ScheduleTime") {
                   //ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_ScheduleTime', '');
                   // Clear text box and reset focus for next comment. 
               });
           });

           LoadOrganizations();
           LoadSchLocations();
           $("#ddOrg").change(function () {
               $('#ddOrgSpl option[value=' + $("#ddOrg").val() + ']').attr('selected', 'selected');
               $("#ddOrgSpl").trigger("liszt:updated");

           });
           $("#ddSchLocation").change(function () {
               $('#ddSchLocationSpl option[value=' + $("#ddSchLocation").val() + ']').attr('selected', 'selected');
               $("#ddSchLocationSpl ").trigger("liszt:updated");
           });
           $("#ddOrgSpl").change(function () {
               $('#ddOrg option[value=' + $("#ddOrgSpl").val() + ']').attr('selected', 'selected');
               $("#ddOrg").trigger("liszt:updated");

           });
           $("#ddSchLocationSpl").change(function () {
               $('#ddSchLocation option[value=' + $("#ddSchLocationSpl").val() + ']').attr('selected', 'selected');
               $("#ddSchLocation ").trigger("liszt:updated");
           });
           $("#txtCode").change(function () {
               $("#txtCodeSpl").val($("#txtCode").val());
           });
           $("#txtColor").change(function () {
               $("#txtColorSpl").val($("#txtColor").val());
           });
           $('input[name="dmrTransactions"]').change(function () {
               var val = $('input[name="dmrTransactions"]:checked').val();
               
               if (val == '0')
                   $("#lblAll").css("display", "none");
               else
                   $("#lblAll").css("display", "inline");
           });
           ///////////////////END OF -- If adding new record it should reflect Special Schedule according to Normal Schedule///////////////////
           var sch = $("#spnSch").text();
           if (sch == "0" || sch == "MA==") {
               $("#txtInTime1").change(function () {
                   $("#txtInTime1Spl").val($("#txtInTime1").val());
               });
               $("#txtOutTime1").change(function () {
                   $("#txtOutTime1Spl").val($("#txtOutTime1").val());
               });
               $("#txtGraceIn").change(function () {
                   $("#txtGraceInSpl").val($("#txtGraceIn").val());
               });
               $("#txtGraceOut").change(function () {
                   $("#txtGraceOutSpl").val($("#txtGraceOut").val());
               });
               $("#txtFlexible").change(function () {
                   $("#txtFlexibleSpl").val($("#txtFlexible").val());
               });
               $("#chkboxOpenShift").change(function () {
                   if ($("#chkboxOpenShift").is(":checked") == true) {
                       $("#chkboxOpenShiftSpl").attr("checked", "checked");
                       $("#uniform-chkboxOpenShiftSpl span").addClass("checked");
                   } else {
                       $("#chkboxOpenShiftSpl").removeAttr("checked");
                       $("#uniform-chkboxOpenShiftSpl span").removeClass("checked");
                   }
               });
               $("#chkboxNightShift").change(function () {
                   if ($("#chkboxNightShift").is(":checked") == true) {
                       $("#chkboxNightShiftSpl").attr("checked", "checked");
                       $("#uniform-chkboxNightShiftSpl span").addClass("checked");
                   } else {
                       $("#chkboxNightShiftSpl").removeAttr("checked");
                       $("#uniform-chkboxNightShiftSpl span").removeClass("checked");
                   }
               });
           }
           $("#chkboxNightShift").change(function () {
               if ($("#chkboxNightShift").is(":checked") == true) {
                   $("#divProcessTrans").css("display", "block");
                   $("#divSuccessMsg").css("display", "block");
                   $("#spnSuccessMsg").html("<%=Resources.Resource.msgdefaultProcessTransSettings %>");
               }
               else {
                   $("#divProcessTrans").css("display", "none");
                   $("#divSuccessMsg").css("display", "none");
               }
           });
           $("#chkboxNightShift2").change(function () {
               if ($("#chkboxNightShift2").is(":checked") == true) {
                   $("#divProcessTrans").css("display", "block");
                   $("#divSuccessMsg").css("display", "block");
                   $("#spnSuccessMsg").html("<%=Resources.Resource.msgdefaultProcessTransSettings %>");
               }
               else {
                   $("#divProcessTrans").css("display", "none");
                   $("#divSuccessMsg").css("display", "none");
               }
           }); $("#chkboxNightShift3").change(function () {
               if ($("#chkboxNightShift3").is(":checked") == true) {
                   $("#divProcessTrans").css("display", "block");
                   $("#divSuccessMsg").css("display", "block");
                   $("#spnSuccessMsg").html("<%=Resources.Resource.msgdefaultProcessTransSettings %>");
               }
               else {
                   $("#divProcessTrans").css("display", "none");
                   $("#divSuccessMsg").css("display", "none");
               }
           }); $("#chkboxNightShiftSpl").change(function () {
               if ($("#chkboxNightShiftSpl").is(":checked") == true) {
                   $("#divProcessTrans").css("display", "block");
                   $("#divSuccessMsg").css("display", "block");
                   $("#spnSuccessMsg").html("<%=Resources.Resource.msgdefaultProcessTransSettings %>");
               }
               else {
                   $("#divProcessTrans").css("display", "none");
                   $("#divSuccessMsg").css("display", "none");
               }
           }); $("#chkboxNightShiftSpl2").change(function () {
               if ($("#chkboxNightShiftSpl2").is(":checked") == true) {
                   $("#divProcessTrans").css("display", "block");
                   $("#divSuccessMsg").css("display", "block");
                   $("#spnSuccessMsg").html("<%=Resources.Resource.msgdefaultProcessTransSettings %>");
               }
               else {
                   $("#divProcessTrans").css("display", "none");
                   $("#divSuccessMsg").css("display", "none");
               }
           }); $("#chkboxNightShiftSpl3").change(function () {
               if ($("#chkboxNightShiftSpl3").is(":checked") == true) {
                   $("#divProcessTrans").css("display", "block");
                   $("#divSuccessMsg").css("display", "block");
                   $("#spnSuccessMsg").html("<%=Resources.Resource.msgdefaultProcessTransSettings %>");
               }
               else {
                   $("#divProcessTrans").css("display", "none");
                   $("#divSuccessMsg").css("display", "block");
               }
           });
           $("#chkboxOvertime").change(function () {
               if ($("#chkboxOvertime").is(":checked") == true) {
                   $("#chkboxOvertime").attr("checked", "checked");
                   $("#uniform-chkboxOvertime span").addClass("checked");
                   $("#txtOvertimeMins").css("display", "block");
                   $("#lblOvertimeMins").css("display", "block");
               } else {
                   $("#chkboxOvertime").removeAttr("checked");
                   $("#uniform-chkboxOvertime span").removeClass("checked");
                   $("#txtOvertimeMins").css("display", "none");
                   $("#lblOvertimeMins").css("display", "none");
               }
           });

           $("#chkBreakHours").change(function () {
               if ($("#chkBreakHours").is(":checked") == true) {
                   $("#chkBreakHours").attr("checked", "checked");
                   $("#uniform-chkBreakHours span").addClass("checked");
                   $("#lblBreakHours").css("display", "block");
                   $("#txtBreakHours").css("display", "block");
               } else {
                   $("#chkBreakHours").removeAttr("checked");
                   $("#uniform-chkBreakHours span").removeClass("checked");
                   $("#lblBreakHours").css("display", "none");
                   $("#txtBreakHours").css("display", "none");
               }
           });
           $("#chkboxWorkHoursFromSchStart").change(function () {
               if ($("#chkboxWorkHoursFromSchStart").is(":checked") == true) {
                   $("#chkboxWorkHoursFromSchStart").attr("checked", "checked");
                   $("#uniform-chkboxWorkHoursFromSchStart span").addClass("checked");
                   
               } else {
                   $("#chkboxWorkHoursFromSchStart").removeAttr("checked");
                   $("#uniform-chkboxWorkHoursFromSchStart span").removeClass("checked");
               }
           });
           $("#chkScheduleOverride").change(function () {
               
               if ($("#chkScheduleOverride").is(":checked") == true) {
                   $("#chkScheduleOverride").attr("checked", "checked");
                   $("#uniform_ScheduleOverride span").addClass("checked");

               } else {
                   $("#chkScheduleOverride").removeAttr("checked");
                   $("#uniform_ScheduleOverride span").removeClass("checked");
               }
           });

           $("#chkReduceWorkMts").change(function () {

               if ($("#chkReduceWorkMts").is(":checked") == true) {
                   $("#chkReduceWorkMts").attr("checked", "checked");
                   $("#uniform_ReduceWorkMts span").addClass("checked");

               } else {
                   $("#chkReduceWorkMts").removeAttr("checked");
                   $("#uniform_ReduceWorkMts span").removeClass("checked");
               }
           });

           $('#divVerificationForm').on('hidden.bs.modal', function (e) {
               Save();
           })

           //if (!$.isNumeric($("#txtOvertimeMins").val())) {
           //    alert("All the text boxes must have numeric values!");
           //    return false;
           //}
           //$("#txtOvertimeMins").keypress(function () {

           //    if ($("#txtOvertimeMins").val() !== "" && !$.isNumeric($("#txtOvertimeMins").val())) {
           //        alert("All the text boxes must have numeric values!");
           //        return false;
           //    }
           //});
           ///////////////////END OF -- If adding new record it should reflect Special Schedule according to Normal Schedule///////////////////
           
       });


       //START - User confirmation before leaving page
       window.onbeforeunload = Unload_Call;
       function Unload_Call() {
           var Message = "Are you sure to leave this page?";
           if ($("#txtCode").val() != "" || $("#txtInTime1").val() != "" || $("#txtOutTime1").val() != "")
               return Message;

       }
       //END - User confirmation before leaving page

       function SetIntendedValueFlag() {
           isIntendedValues = true;
           $('#divVerificationForm').modal('hide');
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
                   $("#ddOrgSpl").html(html);
                   $("#ddOrgSpl").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var sch = $("#spnSch").text();
                   tempOrg = true;
                   if (sch != "" && tempLoc == true) {
                       Edit(sch);
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

       function LoadSchLocations() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/ScheduleLocationPage.aspx") %>',
               success: function (html) {
                   $("#ddSchLocation").html(html);
                   $('#ddSchLocation option[value=' + 1 + ']').attr('selected', 'selected');
                   $("#ddSchLocation").trigger("liszt:updated");
                   $("#ddSchLocationSpl").html(html);
                   $('#ddSchLocationSpl option[value=' + 1 + ']').attr('selected', 'selected');
                   $("#ddSchLocationSpl").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
                   var sch = $("#spnSch").text();
                   tempLoc = true;
                   if (sch != "" && tempOrg == true) {
                       Edit(sch);
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
            Clear();
            window.location = '<%= Page.ResolveClientUrl("~/Sch/Schedule-Times") %>';
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

            $("#txtInTime1").val("");
            $("#txtOutTime1").val("");
            $("#txtFlexible").val("0");
            $("#txtGraceIn").val("0");
            $("#txtCode").val("");

            $("#txtInTime1Spl").val("00:00");
            $("#txtOutTime1Spl").val("00:00");
            $("#txtFlexibleSpl").val("0");
            $("#txtGraceInSpl").val("0");
            $("#txtCodeSpl").val("");

            $("#chkboxNightShift").removeAttr("checked");
            $("#uniform-chkboxNightShift span").removeClass("checked");

            $("#chkboxOpenShift").removeAttr("checked");
            $("#uniform-chkboxOpenShift span").removeClass("checked");

            $("#chkboxInActive").removeAttr("checked");
            $("#uniform-chkboxInActive span").removeClass("checked");

            $('#ddOrg option[value=""]').attr('selected', 'selected');
            $("#ddOrg").trigger("liszt:updated");

            $("#chkboxNightShiftSpl").removeAttr("checked");
            $("#uniform-chkboxNightShiftSpl span").removeClass("checked");
            $("#chkboxOpenShiftSpl").removeAttr("checked");
            $("#uniform-chkboxOpenShiftSpl span").removeClass("checked");
            $('#ddOrgSpl option[value=""]').attr('selected', 'selected');
            $("#ddOrgSpl").trigger("liszt:updated");
           //$("#txtCategory").val("");
           //$("#txtService").val("");
       }

       function Edit(id) {
           //Edit code
           
           var v = "key=getByID&id=" + id;
           $("#btnAdd").click();
           $("#spnGridMsg").html("&nbsp;");
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/ScheduleTimePage.aspx") %>',
              success: function (html) {
                  if (html != "") {
                      var j = $.parseJSON(html);
                      $("#spnID").val(j.ID);
                      if (j.ID == "0") {
                          $("#spnID").html(j.ID);
                          return;
                      }
                      $("#txtInTime1").val(j.InTime1 || "00:00");
                      $("#txtOutTime1").val(j.OutTime1 || "00:00");
                      $("#txtRequiredWorkHours").val(j.RequiredWorkHours || "00:00");
                      $("#txtInTime2").val(j.InTime2 || "00:00");
                      $("#txtOutTime2").val(j.OutTime2 || "00:00");
                      $("#txtRequiredWorkHours2").val(j.RequiredWorkHours2 || "00:00");
                      $("#txtInTime3").val(j.InTime3 || "00:00");
                      $("#txtOutTime3").val(j.OutTime3 || "00:00");
                      $("#txtRequiredWorkHours3").val(j.RequiredWorkHours3 || "00:00");

                      $("#txtCode").val(j.Code);
                      $("#txtColor").val(j.SchColor);

                      $("#txtFlexible").val(j.FlexibleMinutes);
                      $("#txtGraceIn").val(j.GraceInMinutes);
                      $("#txtGraceOut").val(j.GraceOutMinutes);

                      $('#ddOrg option[value=' + j.OrgID + ']').attr('selected', 'selected');
                      $("#ddOrg").trigger("liszt:updated");
                      $('#ddSchLocation option[value=' + j.SchLocationID + ']').attr('selected', 'selected');
                      $("#ddSchLocation ").trigger("liszt:updated");
                     // j.EnableOvertime
                       
                      if (j.TransactionType == 0 || j.TransactionType == '0') {
                          $('input[name="dmrTransactions"]:selected').val(j.TransactionType);
                          $("#uniform-FINFOUT span").addClass("checked");
                          $("#uniform-AllTrans span").removeClass("checked");
                          $("#lblAll").css("display", "none"); 
                      }
                      if (j.TransactionType == 1 || j.TransactionType == '1') {
                          $('input[name="dmrTransactions"]:selected').val(j.TransactionType);
                          $("#lblAll").css("display", "inline");
                          $("#uniform-FINFOUT span").removeClass("checked");
                          $("#uniform-AllTrans span").addClass("checked"); 
                      }
                    
                      if (j.NotificationType == 0 || j.NotificationType == '0') {
                          $('input[name="notification"]:selected').val(j.NotificationType);
                          $("#Notification_FINFOUT span").addClass("checked");
                          $("#Notification_ALL span").removeClass("checked"); 
                      }
                      if (j.NotificationType == 1 || j.NotificationType == '1') {
                          $('input[name="notification"]:selected').val(j.NotificationType);
                          $("#Notification_FINFOUT span").removeClass("checked");
                          $("#Notification_ALL span").addClass("checked"); 
                      }

                      if (j.ProcessTransaction == 0 || j.ProcessTransaction == '0') {
                          $('input[name="processTransaction"]:selected').val(j.ProcessTransaction);
                          $("#processtranstimeout span").addClass("checked");
                          $("#processtranstimein span").removeClass("checked");
                          
                      }
                      if (j.ProcessTransaction == 1 || j.ProcessTransaction == '1') {
                          $('input[name="processTransaction"]:selected').val(j.ProcessTransaction);
                          $("#processtranstimeout span").removeClass("checked");
                          $("#processtranstimein span").addClass("checked");
                          
                      }
                      
                      if (j.ScheduleOverride + "" == "1") {
                          $("#chkScheduleOverride").attr("checked", "checked");
                          $("#uniform_ScheduleOverride span").addClass("checked");
                      }

                      if (j.OpenShift + "" == "1") {
                          $("#chkboxOpenShift").attr("checked", "checked");
                          $("#uniform-chkboxOpenShift span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.NightShift + "" == "1") {
                          $("#chkboxNightShift").attr("checked", "checked");
                          $("#uniform-chkboxNightShift span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.OpenShift2 + "" == "1") {
                          $("#chkboxOpenShift2").attr("checked", "checked");
                          $("#uniform-chkboxOpenShift2 span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.NightShift2 + "" == "1") {
                          $("#chkboxNightShift2").attr("checked", "checked");
                          $("#uniform-chkboxNightShift2 span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.OpenShift3 + "" == "1") {
                          $("#chkboxOpenShift3").attr("checked", "checked");
                          $("#uniform-chkboxOpenShift3 span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.NightShift3 + "" == "1") {
                          $("#chkboxNightShift3").attr("checked", "checked");
                          $("#uniform-chkboxNightShift3 span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }

                      if (j.OpenShiftSpl + "" == "1") {
                          $("#chkboxOpenShiftSpl").attr("checked", "checked");
                          $("#uniform-chkboxOpenShiftSpl span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.NightShiftSpl + "" == "1") {
                          $("#chkboxNightShiftSpl").attr("checked", "checked");
                          $("#uniform-chkboxNightShiftSpl span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.OpenShiftSpl2 + "" == "1") {
                          $("#chkboxOpenShiftSpl2").attr("checked", "checked");
                          $("#uniform-chkboxOpenShiftSpl2 span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.NightShiftSpl2 + "" == "1") {
                          $("#chkboxNightShiftSpl2").attr("checked", "checked");
                          $("#uniform-chkboxNightShiftSpl2 span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.OpenShiftSpl3 + "" == "1") {
                          $("#chkboxOpenShiftSpl3").attr("checked", "checked");
                          $("#uniform-chkboxOpenShiftSpl3 span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.NightShiftSpl3 + "" == "1") {
                          $("#chkboxNightShiftSpl3").attr("checked", "checked");
                          $("#uniform-chkboxNightShiftSpl3 span").addClass("checked");
                          $("#divProcessTrans").css("display", "block");
                      }
                      if (j.ReduceWorkMts + "" == "1") {
                          $("#chkReduceWorkMts").attr("checked", "checked");
                          $("#uniform_ReduceWorkMts span").addClass("checked");
                      }
                      $("#txtCodeSpl").val(j.Code);
                      $("#txtColorSpl").val(j.SchColor);
                      $("#txtInTime1Spl").val(j.InTime1Spl || "00:00");
                      $("#txtOutTime1Spl").val(j.OutTime1Spl || "00:00");
                      $("#txtRequiredWorkHoursSpl").val(j.RequiredWorkHoursSpl || "00:00");
                      $("#txtInTime2Spl").val(j.InTime2Spl || "00:00");
                      $("#txtOutTime2Spl").val(j.OutTime2Spl || "00:00");
                      $("#txtRequiredWorkHoursSpl2").val(j.RequiredWorkHoursSpl2 || "00:00");
                      $("#txtInTime3Spl").val(j.InTime3Spl || "00:00");
                      $("#txtOutTime3Spl").val(j.OutTime3Spl || "00:00");
                      $("#txtRequiredWorkHoursSpl3").val(j.RequiredWorkHoursSpl3 || "00:00");

                      $("#txtFlexibleSpl").val(j.FlexibleMinutesSpl);
                      $("#txtGraceInSpl").val(j.GraceInMinutesSpl);
                      $("#txtGraceOutSpl").val(j.GraceOutMinutesSpl);
                       
                      //if (j.TransactionTypeSpl == 0 || j.TransactionTypeSpl == '0') {
                      //    $('input[name="dmrSplTransactions"]').val(j.TransactionTypeSpl);
                      //    $("#Ramdan-FINFOUT span").addClass("checked");
                      //    $("#Ramdan-AllTrans span").removeClass("checked");
                      //    //  $('input[name="authentication"]:checked').val(0);
                      //}
                      //if (j.TransactionTypeSpl == 1 || j.TransactionTypeSpl == '1') {
                      //    $('input[name="dmrSplTransactions"]').val(j.TransactionTypeSpl);
                      //    $("#Ramdan-FINFOUT span").removeClass("checked");
                      //    $("#Ramdan-AllTrans span").addClass("checked");
                      //    //       $('input[name="authentication"]:checked').val(1);
                      //}
                      

                      $('#ddOrgSpl option[value=' + j.OrgID + ']').attr('selected', 'selected');
                      $("#ddOrgSpl").trigger("liszt:updated");
                      $('#ddSchLocationSpl option[value=' + j.SchLocationID + ']').attr('selected', 'selected');
                      $("#ddSchLocationSpl").trigger("liszt:updated");

                      if (j.OpenShiftSpl + "" == "1") {
                          $("#chkboxOpenShiftSpl").attr("checked", "checked");
                          $("#uniform-chkboxOpenShiftSpl span").addClass("checked");
                      }
                      if (j.NightShiftSpl + "" == "1") {
                          $("#chkboxNightShiftSpl").attr("checked", "checked");
                          $("#uniform-chkboxNightShiftSpl span").addClass("checked");
                      }

                      //if (j.InactiveDateStr + "" == "1") {
                      //    $("#chkboxInActive").attr("checked", "checked");
                      //    $("#uniform-chkboxInActive span").addClass("checked");
                      //}

                      if (j.EnableOvertime + "" == "1") {
                          $("#chkboxOvertime").attr("checked", "checked");
                          $("#uniform-chkboxOvertime span").addClass("checked");
                          $("#txtOvertimeMins").val(j.OvertimeMinutes);
                          $("#txtOvertimeMins").css("display", "block");
                          $("#lblOvertimeMins").css("display", "block");
                          
                      } else {
                          $("#chkboxOvertime").removeAttr("checked");
                          $("#uniform-chkboxOvertime span").removeClass("checked");
                          $("#txtOvertimeMins").css("display", "none");
                          $("#lblOvertimeMins").css("display", "none");
                      }
                      if (j.EnableBreakHours + "" == "1") {
                          $("#chkBreakHours").attr("checked", "checked");
                          $("#uniform-chkBreakHours span").addClass("checked");
                          $("#txtBreakHours").val(j.BreakHours);
                          $("#txtBreakHours").css("display", "block");
                          $("#lblBreakHours").css("display", "block");

                      } else {
                          $("#chkBreakHours").removeAttr("checked");
                          $("#uniform-chkBreakHours span").removeClass("checked");
                          $("#txtBreakHours").css("display", "none");
                          $("#lblBreakHours").css("display", "none");
                      }
                      if (j.CalculateWorkHoursFromSchStartTime + "" == "1") {
                          $("#chkboxWorkHoursFromSchStart").attr("checked", "checked");
                          $("#uniform-chkboxWorkHoursFromSchStart span").addClass("checked");
                      } else {
                          $("#chkboxWorkHoursFromSchStart").removeAttr("checked");
                          $("#uniform-chkboxWorkHoursFromSchStart span").removeClass("checked");
                          
                      }


                      $("#txtInactiveDate").val(j.InactiveDateStr);
                  }
              },
              error: function (html) {

              }
          });
      }
        function PreSave (){
            $('#divVerificationForm').modal('show');
        
        }
        function Save() {

           // var isIntendedValues = confirm("This schedule is intended to be shift schedules");
          
            if (!isIntendedValues) {
                $('.timepicker-24').each(function () {
                    if ($(this).val() == "00:00") {
                        console.log("in change");
                        $(this).val('');
                    }
                });
            };
            if ($('#txtInTime2').val() === "00:00" && $('#txtOutTime2').val() === "00:00") {

                $('#txtInTime2').val('');
                $('#txtOutTime2').val('');

            }
            if ($('#txtInTime3').val() === "00:00" && $('#txtOutTime3').val() === "00:00") {

                $('#txtInTime3').val('');
                $('#txtOutTime3').val('');

            }
            if ($('#txtInTime2Spl').val() === "00:00" && $('#txtOutTime2Spl').val() === "00:00") {

                $('#txtInTime2Spl').val('');
                $('#txtOutTime2Spl').val('');

            }
            if ($('#txtInTime3Spl').val() === "00:00" && $('#txtOutTime3Spl').val() === "00:00") {

                $('#txtInTime3Spl').val('');
                $('#txtOutTime3Spl').val('');

            }
            
           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           var id = $("#spnSch").text();
          var orgID = $("#ddOrg").val();
          var schLocationID = $("#ddSchLocation").val();
          var code = $("#txtCode").val();
          var color = $("#txtColor").val();
          var inTime1 =  $("#txtInTime1").val() ;
          var outTime1 = $("#txtOutTime1").val() ;
          var rwHours =  $("#txtRequiredWorkHours").val() ;
          var openShift = $("#chkboxOpenShift").is(":checked");
          var nightShift = $("#chkboxNightShift").is(":checked");

          var inTime2 =  $("#txtInTime2").val() ;
          var outTime2 = $("#txtOutTime2").val() ;
          var rwHours2 =  $("#txtRequiredWorkHours2").val() ;
          var openShift2 = $("#chkboxOpenShift2").is(":checked");
          var nightShift2 = $("#chkboxNightShift2").is(":checked");

          var inTime3 = $("#txtInTime3").val();
          var outTime3 =  $("#txtOutTime3").val();
          var rwHours3 =  $("#txtRequiredWorkHours3").val();
          var openShift3 = $("#chkboxOpenShift3").is(":checked");
          var nightShift3 = $("#chkboxNightShift3").is(":checked");

          var flexible = $("#txtFlexible").val();
          var graceIn = $("#txtGraceIn").val();
          var graceOut = $("#txtGraceOut").val();

          var inTime1Spl =  $("#txtInTime1Spl").val();
          var outTime1Spl = $("#txtOutTime1Spl").val();
          var rwHoursSpl = $("#txtRequiredWorkHoursSpl").val();
          var openShiftSpl = $("#chkboxOpenShiftSpl").is(":checked");
          var nightShiftSpl = $("#chkboxNightShiftSpl").is(":checked");

          var inTime2Spl =  $("#txtInTime2Spl").val() ;
          var outTime2Spl =  $("#txtOutTime2Spl").val() ;
          var rwHoursSpl2 = $("#txtRequiredWorkHoursSpl2").val();
          var openShiftSpl2 = $("#chkboxOpenShiftSpl2").is(":checked");
          var nightShiftSpl2 = $("#chkboxNightShiftSpl2").is(":checked");

          var inTime3Spl = $("#txtInTime3Spl").val();
          var outTime3Spl = $("#txtOutTime3Spl").val();
          var rwHoursSpl3 =  $("#txtRequiredWorkHoursSpl3").val();
          var openShiftSpl3 = $("#chkboxOpenShiftSpl3").is(":checked");
          var nightShiftSpl3 = $("#chkboxNightShiftSpl3").is(":checked");

          var flexibleSpl = $("#txtFlexibleSpl").val();
          var graceInSpl = $("#txtGraceInSpl").val();
          var graceOutSpl = $("#txtGraceOutSpl").val();

          var transactionType = $('input[name="dmrTransactions"]:checked').val();
          var notificationType = $('input[name="notification"]:checked').val();

          var processTransaction = $('input[name="processTransaction"]:checked').val();
          
          var defaultOvertime = $("#chkboxOvertime").is(":checked");

          var defaultBreakHours = $("#chkBreakHours").is(":checked");


          var inActive = $("#txtInactiveDate").val();
         // var inActive = $("#chkboxInActive").is(":checked");

          var textOvertimeMinutes = 0;
          var textBreakHours = 0;

          if (defaultOvertime == true)
              textOvertimeMinutes = $("#txtOvertimeMins").val();

          if (defaultBreakHours == true)
              textBreakHours = $("#txtBreakHours").val();

          if (textBreakHours == "")
              textBreakHours = 0;
          
          var CalculateWorkHoursFromSchStartTime = $("#chkboxWorkHoursFromSchStart").is(":checked");

          var ScheduleOverride = $("#chkScheduleOverride").is(":checked");
          var reduceWorkMts = $("#chkReduceWorkMts").is(":checked");
           //if (!$.isNumeric($("#txtOvertimeMins").val())) {
           //    alert("All the text boxes must have numeric values!");
           //    return false;
           //}
          //alert(transactionType);
          //return;
          //var transactionTypeSpl = $('input[name="dmrRmdTransactions"]:checked').val();
           
          if ($('#form_sample_1').validate().form() == false) {
              $('.timepicker-24').val("00:00");
              return false;
          }

          if ($('#form2').validate().form() == false) {
              $('.timepicker-24').val("00:00");
              return false;
          }
          var v = "key=save" + "&id=" + id + "&code=" + code + "&color=" + color + "&orgID=" + orgID + "&schLocationID=" + schLocationID;
          v += "&inTime1=" + inTime1 + "&outTime1=" + outTime1 + "&inTime2=" + inTime2 + "&outTime2=" + outTime2 + "&inTime3=" + inTime3 + "&outTime3=" + outTime3;
          v += "&flexible=" + flexible + "&graceIn=" + graceIn + "&graceOut=" + graceOut;
          v += "&openShift=" + openShift + "&openShift2=" + openShift2 + "&openShift3=" + openShift3;
          v += "&nightShift=" + nightShift + "&nightShift2=" + nightShift2 + "&nightShift3=" + nightShift3 + "&TransactionType=" + transactionType + "&NotificationType=" + notificationType;
          v += "&EnableOvertime=" + defaultOvertime + "&OvertimeMinutes=" + textOvertimeMinutes + "&CalculateWorkHoursFromSchStartTime=" + CalculateWorkHoursFromSchStartTime;
          v += "&ProcessTransaction=" + processTransaction + "&ScheduleOverride=" + ScheduleOverride + "&EnableBreakHours=" + defaultBreakHours + "&BreakHours=" + textBreakHours;
          v += "&inTime1Spl=" + inTime1Spl + "&outTime1Spl=" + outTime1Spl + "&inTime2Spl=" + inTime2Spl + "&outTime2Spl=" + outTime2Spl + "&inTime3Spl=" + inTime3Spl + "&outTime3Spl=" + outTime3Spl;
          v += "&flexibleSpl=" + flexibleSpl + "&graceInSpl=" + graceInSpl + "&graceOutSpl=" + graceOutSpl;
          v += "&openShiftSpl=" + openShiftSpl + "&openShiftSpl2=" + openShiftSpl2 + "&openShiftSpl3=" + openShiftSpl3;
          v += "&nightShiftSpl=" + nightShiftSpl + "&nightShiftSpl2=" + nightShiftSpl2 + "&nightShiftSpl3=" + nightShiftSpl3;
          v += "&rwHours=" + rwHours + "&rwHours2=" + rwHours2 + "&rwHours3=" + rwHours3;
          v += "&rwHoursSpl=" + rwHoursSpl + "&rwHoursSpl2=" + rwHoursSpl2 + "&rwHoursSpl3=" + rwHoursSpl3 + "&ReduceWorkMts=" + reduceWorkMts + "&inactive=" + inActive;
          
           
          $.ajax({
              type: 'POST',
              data: v,
              url: '<%= Page.ResolveClientUrl("~/RequestPages/ScheduleTimePage.aspx") %>',
              success: function (html) { 
                  isIntendedValues = false;
                  
                  if (html == '-1') {
                      //failed 
                      $("#divErrorMsg").css("display", "block");
                      $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                  }
                  else if (html == 'Success') {
                      //success  
                      Clear();
                      $("#divSuccessMsg").css("display", "block");
                      $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                      $('#btnBroadCast').click();
                      if ($('#spnSch').text() != "" && $('#spnSch').text() != "0") {
                          window.location = '<%= Page.ResolveClientUrl("~/Sch/Schedule-Times") %>';
                      }
                  }
                  else if (html == '0') {
                      //exists 
                      $("#divErrorMsg").css("display", "block");
                      $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                  }
                  else { //failed 
                      $("#divErrorMsg").css("display", "block");
                      $("#spnErrorMsg").html(html);
                  } 
                    
               },
              error: function (html) {
                  isIntendedValues = false;
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

                   var form3 = $('#form_sample_1');
                   var form2 = $('#form2');
                   var error1 = $('.alert-error', form3);
                   var success1 = $('.alert-success', form3);

                   form2.validate({
                       errorElement: 'span', //default input error message container
                       errorClass: 'help-inline', // default input error message class
                       focusInvalid: false, // do not focus the last invalid input
                       ignore: "",
                       rules: {
                           OvertimeMins: {
                               minlength: 1,
                               required: true,
                               digits: true
                           }
                       },

                       messages: { // custom messages for radio buttons and checkboxes
                           OvertimeMins: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           }
                       },

                       errorPlacement: function (error, element) { // render error placement for each input type
                           if (element.attr("name") == "org" || element.attr("name") == "schLocation") { // for uniform checkboxes, insert the after the given container
                               error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                           } else {
                               error.insertAfter(element); // for other inputs, just perform default behavoir
                           }
                       },
                       invalidHandler: function (event, validator) { //display error alert on form submit              
                           success1.hide();
                           error1.show();
                           //App.scrollTo(error1, -200);
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

                   form3.validate({
                       errorElement: 'span', //default input error message container
                       errorClass: 'help-inline', // default input error message class
                       focusInvalid: false, // do not focus the last invalid input
                       ignore: "",
                       rules: {
                           org: {
                               required: true
                           },
                           schLocation: {
                               required: true
                           },
                           code: {
                               minlength: 1,
                               required: true,
                               maxlength: 10
                           },
                           inTime1: {
                               required: true,
                           },
                           outTime1: {
                               required: true,
                              
                           },
                           flexible: {
                               minlength: 1,
                               required: true,
                               digits: true
                           },
                           graceIn: {
                               minlength: 1,
                               required: true,
                               digits: true
                           },
                           graceOut: {
                               minlength: 1,
                               required: true,
                               digits: true
                           },
                           color: {
                               required: true,
                               maxlength:10
                           },
                           OvertimeMins: {
                               minlength: 1,
                               required: true,
                               digits: true
                           }
                       },

                       messages: { // custom messages for radio buttons and checkboxes
                           code: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           flexible: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           graceIn: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           graceOut: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           OvertimeMins: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           }
                       },

                       errorPlacement: function (error, element) { // render error placement for each input type
                           if (element.attr("name") == "org" || element.attr("name") == "schLocation") { // for uniform checkboxes, insert the after the given container
                               error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                           } else {
                               error.insertAfter(element); // for other inputs, just perform default behavoir
                           }
                       },
                       invalidHandler: function (event, validator) { //display error alert on form submit              
                           success1.hide();
                           error1.show();
                           //App.scrollTo(error1, -200);
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

       var FormComponents = function () {

           var handleColorPicker = function () {
               if (!jQuery().colorpicker) {
                   return;
               }
               $('.colorpicker-default').colorpicker({
                   format: 'hex'
               });
               $('.colorpicker-rgba').colorpicker();
           }

           var handlejQueryUIDatePickers = function () {
               $(".ui-date-picker").datepicker();
           }


           var handleDateTimePickers = function () {


               $('#txtInactiveDate').datepicker({ format: 'yyyy-mm-dd', viewMode: "years" });
               if (jQuery().timepicker) {
                   $('.timepicker-24').timepicker({
                       minuteStep: 1,
                       showSeconds: false,
                       showMeridian: false
                   });
               }

               if (!jQuery().datepicker || !jQuery().timepicker) {
                   return;
               }
           }

           return {
               //main function to initiate the module
               init: function () {
                   handleDateTimePickers();
                   handleColorPicker();
               }

           };

       }();

    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
