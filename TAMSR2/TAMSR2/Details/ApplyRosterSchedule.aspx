<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApplyRosterSchedule.aspx.cs" Inherits="TAMSR2.Details.ApplyRosterSchedule" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.monthlyRoster %> - <%=Resources.Resource.applicationName %></title>

    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
    <!-- END PAGE LEVEL STYLES -->

    <script src="../DragDrop/jquery-1.9.1.js"></script>
    <script src="../DragDrop/ui/jquery.ui.position.js"></script>
    <script src="../DragDrop/ui/jquery.ui.core.js"></script>
    <script src="../DragDrop/ui/jquery.ui.widget.js"></script>
    <script src="../DragDrop/ui/jquery.ui.mouse.js"></script>
    <script src="../DragDrop/ui/jquery.ui.draggable.js"></script>
    <script src="../DragDrop/ui/jquery.ui.droppable.js"></script>


    <style>
        .ui-draggable, .ui-droppable
        {
            background-position: top;
        }

        .draggable
        {
            cursor: move;
            padding: 5px;
            margin: 10px;
            float: left;
        }

        .droppable
        {
            text-align: center !important;
            font-weight: bold;
            font-size: 12px;
            color: white;
            cursor: pointer;
        }

        .highlighter_focus_in {
            border: 1px solid Black !important;
        }

        .highlighter_focus_out {
            border-style: none !important;
        }

        #sample_1 thead th, #sample_1 tbody td, #sample_2 thead th, #sample_2 tbody td
        {
            padding: 3px !important;
            line-height: 15px !important;
        }
    </style>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="portlet-config" class="modal hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.borrowEmployee %></h4>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <form action="#" id="form_sample_1" class="form-horizontal">
                                <div id="div1" class="alert alert-error hide">
                                    <button class="close" data-dismiss="alert"></button>
                                    <span id="Span1"><%=Resources.Resource.formErrors %></span>
                                </div>
                                <div id="div2" class="alert alert-success hide">
                                    <button class="close" data-dismiss="alert"></button>
                                    <span id="Span2"><%=Resources.Resource.formErrorsRemoved %></span>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                    <div class="controls chzn-controls">
                                        <select id="ddBorrowOrg" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div> 
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.scheduleType %><span class="required">*</span></label>
                                    <div class="controls">
                                        <select id="ddBorrowSchType" name="schType" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.scheduleType %>">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.employee %><span class="required">*</span></label>
                                    <div class="controls">
                                        <select id="ddBorrowEmp" name="borrowEmp" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.fromDate %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.toDate %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.remarks %></label>
                                    <div class="controls">
                                        <input type="text" id="txtBorrowRemarks" name="remarks" data-required="1" class="span6 m-wrap" />
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button id="btnSaveBorrow" type="button" onclick="SaveBorrow()" class="btn purple"><%=Resources.Resource.save %></button>
                                    <button type="button" onclick="return ClosePopup()" data-dismiss="modal"  class="btn"><%=Resources.Resource.cancel %></button>
                                    <button type="reset" id="btnCloseForm" style="display: none;" class="btn"><%=Resources.Resource.close %></button>
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
                    <%=Resources.Resource.monthlyRoster %> 
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
                    <li><a href="#"><%=Resources.Resource.monthlyRoster %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN FORM-->
                <form action="#" id="form_1" class="form-horizontal">
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddOrg" name="orgEmp" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.year %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddYear" name="year" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
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
                                <label class="control-label"><%=Resources.Resource.month %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddMonth" name="month" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.month %>">
                                        <option value=""></option>
                                        <option value="1"><%=Resources.Resource.january %></option>
                                        <option value="2"><%=Resources.Resource.february %></option>
                                        <option value="3"><%=Resources.Resource.march %></option>
                                        <option value="4"><%=Resources.Resource.april %></option>
                                        <option value="5"><%=Resources.Resource.may %></option>
                                        <option value="6"><%=Resources.Resource.june %></option>
                                        <option value="7"><%=Resources.Resource.july %></option>
                                        <option value="8"><%=Resources.Resource.august %></option>
                                        <option value="9"><%=Resources.Resource.september %></option>
                                        <option value="10"><%=Resources.Resource.october %></option>
                                        <option value="11"><%=Resources.Resource.november %></option>
                                        <option value="12"><%=Resources.Resource.december %></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.employee %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddEmp" name="employee" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>">
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
                                <label class="control-label"><%=Resources.Resource.versionNo %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddVersionNo" name="versionNo" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.version %>">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.applyVersionFilter %></label>
                                <div class="controls chzn-controls" style="padding-top: 5px; margin-left: 20px; float: <%= floatStr %>;">
                                    <input type="checkbox" id="chkboxApplyVersionFilter"  />
                                </div>
                                <label class="control-label"><%=Resources.Resource.chkIncludeWorkingDayEmployees %></label>
                                <div class="controls chzn-controls" style="padding-top: 5px; margin-left: 20px; float: <%= floatStr %>;">
                                    <input type="checkbox" id="chkboxWorkingDayEmployees"  />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                </form>
                <!-- END FORM-->
                <a data-toggle="modal" id="btnCopyRoster" style="float: <%= pullDirectionStr %>;" class="btn btn-danger" role="button" href="#divDialogCopyRoster"><%=Resources.Resource.copyRoster %></a>
                <div id="divDialogCopyRoster" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h3 id="H2"><%=Resources.Resource.copyRoster %></h3>
                    </div>
                    <div class="modal-body" style="overflow-y: visible !important; ">
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.year %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddCopyRosterYear" name="year" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.month %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddCopyRosterMonth" name="month" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.month %>">
                                        <option value=""></option>
                                        <option value="1"><%=Resources.Resource.january %></option>
                                        <option value="2"><%=Resources.Resource.february %></option>
                                        <option value="3"><%=Resources.Resource.march %></option>
                                        <option value="4"><%=Resources.Resource.april %></option>
                                        <option value="5"><%=Resources.Resource.may %></option>
                                        <option value="6"><%=Resources.Resource.june %></option>
                                        <option value="7"><%=Resources.Resource.july %></option>
                                        <option value="8"><%=Resources.Resource.august %></option>
                                        <option value="9"><%=Resources.Resource.september %></option>
                                        <option value="10"><%=Resources.Resource.october %></option>
                                        <option value="11"><%=Resources.Resource.november %></option>
                                        <option value="12"><%=Resources.Resource.december %></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    </div>
                    <div class="modal-footer">
                        <button onclick="CopyRoster()" class="btn green"><%=Resources.Resource.copyRoster %></button>
                        <button data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
                    </div>
                </div>
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
                <!-- BEGIN -->
                <div class="row-fluid">
                    <div class="span12 ">
                        <div class="control-group">
                            <label style="display: inline; font-size: 10px;" class="control-label"><%=Resources.Resource.msgCopySchedule %></label>.
                            &nbsp;<label style="display: inline; font-size: 10px;" class="control-label"><%=Resources.Resource.msgCopyOverride %></label>

                        </div>
                    </div>
                    <!--/span-->
                </div>
                <div id="divSchedules" style="padding: 20px;">
                    &nbsp;
                </div>
                <!-- END -->
                <div style="min-height: 20px; clear: both;">&nbsp;</div>
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.monthlyRoster %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return LoadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">

                        <div style="width: 100%; overflow: scroll; overflow-y: hidden; padding: 0px 0px;">
                            <div style="float: <%= pullDirectionStr %>">
                                <button id="btnSelectRoster" onclick="SelectEmployeeRoster()" class="btn danger" ><%=Resources.Resource.copy %></button>
                                <button id="btnPastRoster" onclick="PasteEmployeeRoster()" class="btn green"><%=Resources.Resource.paste %></button>
                                <button id="btnClearSelection" onclick="ClearSelection()" class="btn red"><%=Resources.Resource.clear %></button>
                            </div>
                            <table class="table table-striped table-bordered table-hover" id="sample_1">
                                <thead>
                              <tr style="background-color: #e8e3e3;">
                                        <th style="text-align: center;width: 24px !important;">
                                            <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                        <th style="text-align: center;width: 44px !important;"><%=Resources.Resource.number %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                        <th style="text-align: center;width: 44px !important;"><%=Resources.Resource.version %></th>
                                        <th style="text-align: center;width: 12px !important;">1</th>
                                        <th style="text-align: center; width: 12px !important;">2</th>
                                        <th style="text-align: center; width: 12px !important;">3</th>
                                        <th style="text-align: center; width: 12px !important;">4</th>
                                        <th style="text-align: center; width: 12px !important;">5</th>
                                        <th style="text-align: center; width: 12px !important;">6</th>
                                        <th style="text-align: center; width: 12px !important;">7</th>
                                        <th style="text-align: center; width: 12px !important;">8</th>
                                        <th style="text-align: center; width: 12px !important;">9</th>
                                        <th style="text-align: center; width: 12px !important;">10</th>
                                        <th style="text-align: center; width: 12px !important;">11</th>
                                        <th style="text-align: center; width: 12px !important;">12</th>
                                        <th style="text-align: center; width: 12px !important;">13</th>
                                        <th style="text-align: center; width: 12px !important;">14</th>
                                        <th style="text-align: center; width: 12px !important;">15</th>
                                        <th style="text-align: center; width: 12px !important;">16</th>
                                        <th style="text-align: center; width: 12px !important;">17</th>
                                        <th style="text-align: center; width: 12px !important;">18</th>
                                        <th style="text-align: center; width: 12px !important;">19</th>
                                        <th style="text-align: center; width: 12px !important;">20</th>
                                        <th style="text-align: center; width: 12px !important;">21</th>
                                        <th style="text-align: center; width: 12px !important;">22</th>
                                        <th style="text-align: center; width: 12px !important;">23</th>
                                        <th style="text-align: center; width: 12px !important;">24</th>
                                        <th style="text-align: center; width: 12px !important;">25</th>
                                        <th style="text-align: center; width: 12px !important;">26</th>
                                        <th style="text-align: center; width: 12px !important;">27</th>
                                        <th style="text-align: center; width: 12px !important;">28</th>
                                        <th style="text-align: center; width: 12px !important;">29</th>
                                        <th style="text-align: center; width: 12px !important;">30</th>
                                        <th style="text-align: center; width: 12px !important;">31</th>
                                        <th style="text-align: center; width: 24px !important; padding: 5px;"><%=Resources.Resource.workHours %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>


                        <br />

                    </div>
                </div>
                <!-- END EXAMPLE TABLE PORTLET-->

                <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                    <span id="Span3" runat="server">
                        <a id="btnOpenPopup" onclick="return ClearPopup()" href="#portlet-config" data-toggle="modal" class="btn green">
                            <i class="icon-plus">&nbsp; <%=Resources.Resource.borrowEmployee %></i>
                        </a>
                    </span>
                </div>

                <div style="min-height: 20px; clear: both;">&nbsp;</div>

                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.borrowEmployee %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return LoadRequestGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">

                        <div style="width: 100%; overflow: scroll; overflow-y: hidden; padding: 20px 0px;">
                            <table class="table table-striped table-bordered table-hover" id="sample_2">
                                <thead>
                              <tr style="background-color: #e8e3e3;">
                                        <th style="text-align: center; width: 24px !important; padding-left: 3px;">
                                            <input type="checkbox" class="group-checkable" data-set="#sample_2 .checkboxes" /></th>
                                        <th style="text-align: center; width: 44px !important;"><%=Resources.Resource.number %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                        <th style="text-align: center; width: 12px !important;">1</th>
                                        <th style="text-align: center; width: 12px !important;">2</th>
                                        <th style="text-align: center; width: 12px !important;">3</th>
                                        <th style="text-align: center; width: 12px !important;">4</th>
                                        <th style="text-align: center; width: 12px !important;">5</th>
                                        <th style="text-align: center; width: 12px !important;">6</th>
                                        <th style="text-align: center; width: 12px !important;">7</th>
                                        <th style="text-align: center; width: 12px !important;">8</th>
                                        <th style="text-align: center; width: 12px !important;">9</th>
                                        <th style="text-align: center; width: 12px !important;">10</th>
                                        <th style="text-align: center; width: 12px !important;">11</th>
                                        <th style="text-align: center; width: 12px !important;">12</th>
                                        <th style="text-align: center; width: 12px !important;">13</th>
                                        <th style="text-align: center; width: 12px !important;">14</th>
                                        <th style="text-align: center; width: 12px !important;">15</th>
                                        <th style="text-align: center; width: 12px !important;">16</th>
                                        <th style="text-align: center; width: 12px !important;">17</th>
                                        <th style="text-align: center; width: 12px !important;">18</th>
                                        <th style="text-align: center; width: 12px !important;">19</th>
                                        <th style="text-align: center; width: 12px !important;">20</th>
                                        <th style="text-align: center; width: 12px !important;">21</th>
                                        <th style="text-align: center; width: 12px !important;">22</th>
                                        <th style="text-align: center; width: 12px !important;">23</th>
                                        <th style="text-align: center; width: 12px !important;">24</th>
                                        <th style="text-align: center; width: 12px !important;">25</th>
                                        <th style="text-align: center; width: 12px !important;">26</th>
                                        <th style="text-align: center; width: 12px !important;">27</th>
                                        <th style="text-align: center; width: 12px !important;">28</th>
                                        <th style="text-align: center; width: 12px !important;">29</th>
                                        <th style="text-align: center; width: 12px !important;">30</th>
                                        <th style="text-align: center; width: 12px !important;">31</th>
                                        <th style="text-align: center; width: 24px !important; padding: 5px;"><%=Resources.Resource.workHours %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- END EXAMPLE TABLE PORTLET-->

                <div>
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
                                <a id="btnSave" onclick="return Save()" style='margin: 0px 5px;' class="btn blue"><i class="icon-plus">&nbsp; <%=Resources.Resource.save %></i></a>
                                <a id="btnFinlaize" onclick="return Finalize()" style='margin: 0px 5px;' class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.finalize %></i></a>
                                <a id="btnClear" onclick="return ClearRoster()" style='margin: 0px 5px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.clear %></i></a>
                            </span>
                        </div>
                    </div>
                </div>

                <div style="min-height: 20px; clear: both;">&nbsp;</div>

                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.approve %> / <%=Resources.Resource.reject %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return LoadPendingApprovalRequestGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">

                        <div style="width: 100%; overflow: scroll; overflow-y: hidden; padding: 20px 0px;">
                            <table class="table table-striped table-bordered table-hover" id="sample_3">
                                <thead>
                              <tr style="background-color: #e8e3e3;">
                                        <th style="text-align: center; width: 24px !important; padding-left: 3px;">
                                            <input type="checkbox" class="group-checkable" data-set="#sample_2 .checkboxes" /></th>
                                        <th style="text-align: center; width: 44px !important;"><%=Resources.Resource.number %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                        <th style="text-align: center; width: 12px !important;">1</th>
                                        <th style="text-align: center; width: 12px !important;">2</th>
                                        <th style="text-align: center; width: 12px !important;">3</th>
                                        <th style="text-align: center; width: 12px !important;">4</th>
                                        <th style="text-align: center; width: 12px !important;">5</th>
                                        <th style="text-align: center; width: 12px !important;">6</th>
                                        <th style="text-align: center; width: 12px !important;">7</th>
                                        <th style="text-align: center; width: 12px !important;">8</th>
                                        <th style="text-align: center; width: 12px !important;">9</th>
                                        <th style="text-align: center; width: 12px !important;">10</th>
                                        <th style="text-align: center; width: 12px !important;">11</th>
                                        <th style="text-align: center; width: 12px !important;">12</th>
                                        <th style="text-align: center; width: 12px !important;">13</th>
                                        <th style="text-align: center; width: 12px !important;">14</th>
                                        <th style="text-align: center; width: 12px !important;">15</th>
                                        <th style="text-align: center; width: 12px !important;">16</th>
                                        <th style="text-align: center; width: 12px !important;">17</th>
                                        <th style="text-align: center; width: 12px !important;">18</th>
                                        <th style="text-align: center; width: 12px !important;">19</th>
                                        <th style="text-align: center; width: 12px !important;">20</th>
                                        <th style="text-align: center; width: 12px !important;">21</th>
                                        <th style="text-align: center; width: 12px !important;">22</th>
                                        <th style="text-align: center; width: 12px !important;">23</th>
                                        <th style="text-align: center; width: 12px !important;">24</th>
                                        <th style="text-align: center; width: 12px !important;">25</th>
                                        <th style="text-align: center; width: 12px !important;">26</th>
                                        <th style="text-align: center; width: 12px !important;">27</th>
                                        <th style="text-align: center; width: 12px !important;">28</th>
                                        <th style="text-align: center; width: 12px !important;">29</th>
                                        <th style="text-align: center; width: 12px !important;">30</th>
                                        <th style="text-align: center; width: 12px !important;">31</th>
                                        <th style="text-align: center; width: 24px !important; padding: 5px;"><%=Resources.Resource.workHours %></th>
                                        <th style="text-align: center; width: 24px !important; padding: 5px;"><%=Resources.Resource.action %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- END EXAMPLE TABLE PORTLET-->
                <div style="display: none;">
                    <input type="button" id="btnBroadCastRequest" value="broad cast request" />
                    <input type="button" id="btnBroadCastRequestApproveReject" value="broad cast request" />
                    <input type="hidden" id="lblRqstApproveRejectID" value="" />
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

    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
    <script src="../assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>
    <script src="../Scripts/jquery.loadmask.js"></script>
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
            FormComponents.init();


            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liSch").addClass("active");
            $("#liSch .arrow").addClass("open");
            $("#liSchRoster").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

            $("#btnSelectRoster").attr("disabled", false);
            $("#btnPastRoster").attr("disabled", "disabled");

            LoadOrganizations();
            LoadYears();
            LoadPendingApprovalRequestGrid();

            LoadBorrowSchTypeList();
            LoadBorrowOrgList();

            $("#spnSchedule9").draggable({ revert: true });


            $("#ddOrg").change(function () {
                LoadGrid();
                LoadEmployees();
                LoadVersionList();
                LoadSchedules();
            });

            $("#ddYear").change(function () {
                LoadVersionList();
            });

            $("#ddMonth").change(function () {
                LoadVersionList();
            });

            $("#ddEmp").change(function () {
                LoadVersionList();
            });

            $("#ddBorrowOrg").change(function () {
                LoadBorrowEmpList();
            });

            $("#ddBorrowSchType").change(function () {
                LoadBorrowEmpList();
            });

            $("#ddVersionNo").change(function () {
                LoadGrid();
            });

            $("#chkboxApplyVersionFilter").change(function () {
                LoadGrid();
            });
            $("#chkboxWorkingDayEmployees").change(function () {
                LoadGrid();
            });



            $('#sample_1 .group-checkable').change(function () {
                var set = $(this).attr("data-set");
                var checked = $(this).is(":checked");
                jQuery(set).each(function () {
                    if (checked) {
                        $(this).attr("checked", true);
                    } else {
                        $(this).attr("checked", undefined);
                    }
                });
                jQuery.uniform.update(set);
            });

            $('#sample_2 .group-checkable').change(function () {
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
                if (name == "TAMSR2_Request_Updated") {
                    LoadPendingApprovalRequestGrid();
                }
                if (name == "TAMSR2_Request_Approve_Reject") {
                    if (message != "") {
                        $("table#sample_2 tr.sample_2_" + message).remove();
                    }
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCastRequest').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Request_Updated', '');
                    // Clear text box and reset focus for next comment. 
                });
                $('#btnBroadCastRequestApproveReject').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Request_Approve_Reject', $("#lblRqstApproveRejectID").val());
                    // Clear text box and reset focus for next comment. 
                });
            });


        });

        //START - User confirmation before leaving page
        window.onbeforeunload = Unload_Call;

        function Unload_Call() {
            var Message = "Are you sure to leave this page?";
            return Message;
        }
        //END - User confirmation before leaving page


        function SelectEmployeeRoster() {
            var chkID = "";
            var empID = "";
            $('#sample_1 .checkboxes:checked').each(function () {
                if (chkID == "") {
                    chkID = $(this).attr("id");
                    empID = $(this).val();
                }
            });
            $("#" + chkID).attr("disabled", "disabled");
            $("#btnSelectRoster").attr("disabled", "disabled");
            $("#btnPastRoster").attr("disabled", false);
        }

        function PasteEmployeeRoster() {
            var tempIDs = "";
            $('#sample_1 .checkboxes:checked').each(function () {
                if ($(this).attr("disabled") != "disabled") {
                    tempIDs += $(this).val() + ",";
                }
            });
            var srcEmpID = $('#sample_1 .checkboxes:disabled').val();
            var selectedEmpList = tempIDs.split(",");
            var k = 1;
            var total = 0;
            var hr = 0;
            var mn = 0;
            while (k <= 31) {
                var schID = $("#td_" + srcEmpID + "_" + k).attr("schid");
                var schCode = $("#td_" + srcEmpID + "_" + k).html();
                var schHrs = $("#td_" + srcEmpID + "_" + k).attr("schhrs");
                var schMin = $("#td_" + srcEmpID + "_" + k).attr("schmin");
                var bgColor = $("#td_" + srcEmpID + "_" + k).css("background-color");
                var totalMin = $("#sample_1_" + srcEmpID + " .totalWorkHours").attr("schmin");
                var totalHrd = $("#sample_1_" + srcEmpID + " .totalWorkHours").text();
                $.each(selectedEmpList, function (index, value) {
                    if (value != ",") {
                        if ($("#td_" + value + "_" + k).attr("class") != "" && $("#td_" + value + "_" + k).attr("class") != "NaN") {
                            if (schMin == "" || schMin == "NaN")
                                schMin = 0;
                            total = parseInt(total) + parseInt(schMin);
                            $("#td_" + value + "_" + k).attr("schid", schID);
                            $("#td_" + value + "_" + k).html(schCode);
                            $("#td_" + value + "_" + k).attr("schhrs", schHrs);
                            $("#td_" + value + "_" + k).attr("schmin", schMin);
                            $("#td_" + value + "_" + k).css("background-color", bgColor);
                            hr = parseInt(total / 60) < 10 ? "0" + parseInt(total / 60) : parseInt(total / 60);
                            mn = parseInt(total % 60) < 10 ? "0" + parseInt(total % 60) : parseInt(total % 60);
                            $("#sample_1_" + value + " .totalWorkHours").attr("schmin", totalMin);
                            $("#sample_1_" + value + " .totalWorkHours").text(totalHrd);
                            //$("#sample_1_" + value + " .totalWorkHours").text(hr + ":" + mn);
                        }
                        schMin = 0;
                    }
                });
                k++;
            }

            ClearSelection();
        }

        function ClearSelection() {
            $("#btnSelectRoster").attr("disabled", false);
            $("#btnPastRoster").attr("disabled", "disabled");
            $("#sample_1 .checkboxes").attr("disabled", false);
            $("#sample_1 .checkboxes").attr("checked", false);
        }

        function LoadOrganizations() {
            $("#spnErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var d = "key=getIdNameListStringForRoster";
            $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   $("#form_sample_1").unmask();
                   $("#ddOrg").html(html);
                   $('#ddOrg option[value=<%= Session["orgID"] %>]').attr('selected', 'selected');
                   $("#ddOrg").trigger("liszt:updated");
                   LoadGrid();
                   LoadEmployees();
                   LoadVersionList();
                   LoadSchedules();
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#form_sample_1").unmask();
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }
           });
           }

           function LoadEmployees() {
               $("#spnErrorMsg").css("display", "none");
               $("#spnSuccessMsg").css("display", "none");

               var d = "key=getIdNameListByOrgID&orgID=" + $("#ddOrg").val();
               $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   $("#form_sample_1").unmask();
                   $("#ddEmp").html(html);
                   $("#ddEmp").trigger("liszt:updated");
                   //LoadGrid();
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#form_sample_1").unmask();
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }
           });
           }

           function LoadYears() {
               var curMonth = new Date().getMonth() + 1;
               $('#ddMonth option[value=' + curMonth + ']').attr('selected', 'selected');
               $("#ddMonth").trigger("liszt:updated");
               $('#ddCopyRosterMonth option[value=' + curMonth + ']').attr('selected', 'selected');
               $("#ddCopyRosterMonth").trigger("liszt:updated");
               var curYear = new Date().getFullYear();
               var k = curYear - 2;
               var val = curYear + 5;
               var temp = "<option value=''><%=Resources.Resource.choose %> &nbsp; <%=Resources.Resource.year %></option>";
           while (k <= val) {
               if (k == curYear) {
                   temp += "<option selected='selected' value='" + k + "'>" + k + "</option>";
               }
               else {
                   temp += "<option value='" + k + "'>" + k + "</option>";
               }
               k++;
           }
           $("#ddYear").html(temp);
           $("#ddYear").trigger("liszt:updated");

           $("#ddCopyRosterYear").html(temp);
           $("#ddCopyRosterYear").trigger("liszt:updated");
       }
       function CopyRoster() {
           $("#spnErrorMsg").css("display", "none");
           $("#spnSuccessMsg").css("display", "none");
           var versionNo = $("#ddVersionNo").val();
           var year = $("#ddYear").val();
           var month = $("#ddMonth").val();
           var copyRosterYear = $("#ddCopyRosterYear").val();
           var copyRosterMonth = $("#ddCopyRosterMonth").val();

           var d = "key=copyRosterVersion" + "&versionNo=" + versionNo + "&year=" + year + "&month=" + month;
           d += "&copyRosterYear=" + copyRosterYear + "&copyRosterMonth=" + copyRosterMonth;
           $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRosterPage.aspx") %>',
               success: function (html) {
                   $("#form_sample_1").unmask();
                   $("#btnCopyRoster").click();
                   $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                   $("#spnSuccessMsg").css("display", "block");
                   $("#btnAlertMessage").click();
               },
               error: function (html) {
                   $("#form_sample_1").unmask();
                   $("#btnCopyRoster").click();
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }
           });
       }

       function LoadSchedules() {
           $("#spnErrorMsg").css("display", "none");
           $("#spnSuccessMsg").css("display", "none");

           var d = "key=getAllTagsRosterPage&org=" + $("#ddOrg").val();
           $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleTimePage.aspx") %>',
               success: function (html) {
                   $("#form_sample_1").unmask();
                   $("#divSchedules").html(html);
                   $(".draggable").draggable({ helper: "clone", revert: true });
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#form_sample_1").unmask();
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }
           });
           }

           function AddHours(trID, hrs, mins) {
               if (hrs == "" && mins == "")
                   return;
               var previousMinutes = parseInt(mins);
               var totalMinutes = parseInt($("#" + trID + " .totalWorkHours").attr("schmin"));
               var remainingMinutes = totalMinutes + previousMinutes;
               var sHHMM = "";

               if (remainingMinutes <= 0) {
                   sHHMM = "00:00";
               }
               else if (remainingMinutes < 60) {
                   sHHMM = "00:" + (remainingMinutes % 60 < 10 ? "0" + remainingMinutes % 60 : remainingMinutes % 60 + "");
               }
               else {
                   sHHMM = (remainingMinutes / 60 < 10 ? "0" + parseInt(remainingMinutes / 60) : parseInt(remainingMinutes / 60) + "") + ":" + (remainingMinutes % 60 < 10 ? "0" + remainingMinutes % 60 : remainingMinutes % 60 + "");
               }
               $("#" + trID + " .totalWorkHours").attr("schmin", remainingMinutes);
               $("#" + trID + " .totalWorkHours").html(sHHMM);
           }

           function DeductHours(trID, hrs, mins) {
               if (hrs == "" && mins == "")
                   return;
               var previousMinutes = parseInt(mins);
               var totalMinutes = parseInt($("#" + trID + " .totalWorkHours").attr("schmin"));
               var remainingMinutes = totalMinutes - previousMinutes;
               var sHHMM = "";

               if (remainingMinutes < 0) {
                   sHHMM = "00:00";
               }
               else if (remainingMinutes < 60) {
                   sHHMM = "00:" + (remainingMinutes % 60 < 10 ? "0" + remainingMinutes % 60 : remainingMinutes % 60 + "");
               }
               else {
                   sHHMM = (remainingMinutes / 60 < 10 ? "0" + parseInt(remainingMinutes / 60) : parseInt(remainingMinutes / 60) + "") + ":" + (remainingMinutes % 60 < 10 ? "0" + remainingMinutes % 60 : remainingMinutes % 60 + "");
               }
               $("#" + trID + " .totalWorkHours").attr("schmin", remainingMinutes);
               $("#" + trID + " .totalWorkHours").html(sHHMM);

           }


           function LoadVersionList() {
               var d = "key=getVersionList&orgID=" + $("#ddOrg").val() + "&empID=" + $("#ddEmp").val();
               d += "&year=" + $("#ddYear").val() + "&month=" + $("#ddMonth").val() + "&iDisplayLength=100";

               $("#sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRosterPage.aspx") %>',
               success: function (html) {
                   $("#ddVersionNo").html(html);
                   $("#ddVersionNo").trigger("liszt:updated");
                   $("#sample_1").unmask();
                   LoadGrid();
               },
               error: function (html) {
                   $("#spnSuccessMsg").css("display", "none");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#sample_1").unmask();
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
                   LoadGrid();
               }
           });
       }

       function LoadGrid() {
           var d = "key=getAllRecordsGrid&orgID=" + $("#ddOrg").val() + "&empID=" + $("#ddEmp").val();
           d += "&year=" + $("#ddYear").val() + "&month=" + $("#ddMonth").val() + "&iDisplayLength=100";

           if ($("#ddVersionNo").val() != "" && $("#chkboxApplyVersionFilter").is(":checked") == true) {
               d += "&version=" + $("#ddVersionNo").val();
           }
           else {
               d += "&version=" + "";
           }
           if ($("#chkboxWorkingDayEmployees").is(":checked") == true) {
               d += "&workingDayEmployees=1";
           }
           else {
               d += "&workingDayEmployees=0";
           }

           $("#sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRosterPage.aspx") %>',
               success: function (html) {
                   $("#sample_1 tbody").html(html);
                   $("#sample_1").unmask();
                   LoadRequestGrid();
                   BindGridDragDrop("sample_1");
               },
               error: function (html) {
                   $("#spnSuccessMsg").css("display", "none");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#sample_1").unmask();
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }
           });
       }

       function LoadRequestGrid() {
           $("#spnErrorMsg").css("display", "none");
           $("#spnSuccessMsg").css("display", "none");

           var d = "key=getAllRecordsGrid&orgID=" + $("#ddOrg").val() + "&empID=" + $("#ddEmp").val();
           d += "&year=" + $("#ddYear").val() + "&month=" + $("#ddMonth").val() + "&iDisplayLength=100";

           $("#sample_2").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRoasterBorrowPage.aspx") %>',
               success: function (data) {
                   $("#sample_2").unmask();
                   $("#sample_2 tbody").html(data);
                   BindGridDragDrop("sample_2");
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#sample_2").unmask();
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }
           });
           }

           function LoadPendingApprovalRequestGrid() {
               $("#spnErrorMsg").css("display", "none");
               $("#spnSuccessMsg").css("display", "none");

               var d = "key=getAllPendingApprovalRecordsGrid&orgID=" + $("#ddOrg").val() + "&empID=" + $("#ddEmp").val();
               d += "&year=" + $("#ddYear").val() + "&month=" + $("#ddMonth").val() + "&iDisplayLength=100";

               $("#sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRoasterBorrowPage.aspx") %>',
               success: function (data) {
                   $("#sample_3 tbody").html(data);
                   $("#sample_3").unmask();
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#sample_3").unmask();
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }
           });
           }
           function Save() {
               $("#spnErrorMsg").css("display", "none");
               $("#spnSuccessMsg").css("display", "none");

               if ($("#chkboxApplyVersionFilter").is(":checked")) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgErrorOlderVersion %>");
                $("#spnErrorMsg").css("display", "block");
                $("#btnAlertError").click();
                return;
            }

            //save the current schedule roster for all employee for select month untill manager make any change
            //but its not finalize
            var v = "";
            var k = 1;
            var lsat = -1;
            var rowCount = 1;
            $("#sample_1 tbody tr").each(function () {
                var rowEid = $(this).attr("eid");
                var rowDay = "";
                var rowSch = "";
                $(this).find("td.droppable").each(function () { //rewrite
                    //alert($(this).attr("schId") + " \n\n " + rowIndex);
                    if ($(this).attr("schId") != "-1" && $(this).attr("schId") != "" && $(this).html("") != "") {
                        var eid = $(this).attr("eid");
                        var d = $(this).attr("d");
                        var sch = $(this).attr("schId");
                        var code = $(this).attr("code");
                        //v += "&d" + k + "=" + d + "&eid" + k + "=" + eid + "&sch" + k + "=" + sch;
                        //alert(" eid" + k + "=" + eid + "\n schid" + k + "=" + schid + "\n code" + k + "=" + code);
                        rowDay += d + ",";
                        rowSch += sch + ",";
                        k++;
                    }
                });

                v += "&rowEID" + rowCount + "=" + rowEid + "&rowDay" + rowCount + "=" + rowDay + "&rowSch" + rowCount + "=" + rowSch;
                rowCount++;
                rowDay = "";
                rowSch = "";
                rowEid = "";
            });

            //if ($('#form_sample_1').validate().form() == false) {
            //    return false;
            //}

            v = "key=save&count=" + rowCount + v + "&orgID=" + $("#ddOrg").val() + "&empID=" + $("#ddEmp").val();
            v += "&month=" + $("#ddMonth").val() + "&year=" + $("#ddYear").val();

            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRosterPage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                       $("#spnErrorMsg").css("display", "block");
                       $("#btnAlertError").click();
                   }
                   else if (html == '0') {
                       //exists
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                       $("#spnErrorMsg").css("display", "block");
                       $("#btnAlertError").click();
                   }
                   else {
                       //success
                       if ($("#sample_1 .droppable").attr("schId") != "" || $("#sample_1 .droppable").attr("schId") != "-1") {
                           $("#sample_1 .droppable").html("")
                       }
                       UpdateBorrow();
                       LoadGrid();
                       LoadVersionList();
                       $("#spnSuccessMsg").html("Sucessfully saved in database.");
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                       $("#spnSuccessMsg").css("display", "block");
                       $("#myModal2").css("display", "block");
                   }
               },
               error: function (html) {
                   $("#spnErrorMsg").html("Error! " + html);
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }

           });
   }

   function ShowAlertBox(chk) {
       $("#msgAlertError").css("display", "none");
       $("#myModal2").css("display", "none");
       if (chk) {
           $("#spnSuccessMsg").css("display", "block");
           $("#btnAlertMessage").click();
       }
       else {
           $("#spnErrorMsg").css("display", "block");
           $("#btnAlertError").click();
       }
   }

   function Finalize() {
       $("#spnErrorMsg").css("display", "none");
       $("#spnSuccessMsg").css("display", "none");
       //finalize the current version of roster for next months untill manager will agin update.
       var v = 'key=finalizeRoster';
       $.ajax({
           type: 'POST',
           data: v,
           url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRosterPage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRosterNotFinalized %>");
                       $("#spnErrorMsg").css("display", "block");
                       $("#btnAlertError").click();
                   }
                   else if (html == '0') {
                       //exists
                       $("#spnErrorMsg").html("Error!");
                       $("#spnErrorMsg").css("display", "block");
                       $("#btnAlertError").click();
                   }
                   else {
                       //success
                       if ($("#sample_1 .droppable").attr("schId") != "" || $("#sample_1 .droppable").attr("schId") != "-1") {
                           $("#sample_1 .droppable").html("");
                       }
                       UpdateBorrow();
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgRosterFinalised %>");
                       $("#spnSuccessMsg").css("display", "block");
                       $("#btnAlertMessage").click();
                   }
               },
               error: function (html) {
                   $("#spnErrorMsg").html("Error! " + html);
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }

           });
   }

   function ClearRoster() {
       LoadGrid();
   }

   function BindGridDragDrop(tableID) {

       if ($("#chkboxApplyVersionFilter").is(":checked") != true) {
           $("#" + tableID + " .droppable").droppable({
               over: function (event, ui) {
                   $(this).addClass('highlighter_focus_in');
                   var tempCal = false;
                   if ($(this).attr("schId") == "")
                       tempCal = true;
                   if ((event.ctrlKey && event.shiftKey) || (event.ctrlKey && $(this).attr("schId") == "")) {

                       $(this).removeClass('highlighter_focus_in');
                       $(this).css("background-color", ui.draggable.attr("color"));
                       $(this).attr("schId", ui.draggable.attr("schId"));
                       $(this).attr("code", ui.draggable.attr("code"));
                       $(this).attr("schMin", ui.draggable.attr("schMin"));
                       $(this).attr("schHrs", ui.draggable.attr("schHrs"));
                       $(this).html(ui.draggable.attr("code"));
                       if (tempCal)
                           AddHours("" + tableID + "_" + $(this).attr("eid"), $(this).attr("schHrs"), $(this).attr("schMin"));
                   }

               },
               out: function (event, ui) {
                   $(this).removeClass('highlighter_focus_in');
               },
               drop: function (event, ui) {
                   var tempCal = false;
                   if ($(this).attr("schId") == "") {
                       tempCal = true;
                   }
                   else {
                       DeductHours("" + tableID + "_" + $(this).attr("eid"), $(this).attr("schHrs"), $(this).attr("schMin"));
                   }
                   $(this).removeClass('highlighter_focus_in');
                   $(this).css("background-color", ui.draggable.attr("color"));
                   $(this).attr("schId", ui.draggable.attr("schId"));
                   $(this).attr("code", ui.draggable.attr("code"));
                   $(this).attr("schMin", ui.draggable.attr("schMin"));
                   $(this).attr("schHrs", ui.draggable.attr("schHrs"));
                   $(this).html(ui.draggable.attr("code"));
                   AddHours("" + tableID + "_" + $(this).attr("eid"), $(this).attr("schHrs"), $(this).attr("schMin"));
               }
           });
           $("#" + tableID + " .droppable").click(function () {
               $(this).css("background-color", "White");
               DeductHours("" + tableID + "_" + $(this).attr("eid"), $(this).attr("schHrs"), $(this).attr("schMin"));
               $(this).attr("schId", "");
               $(this).attr("code", "");
               $(this).attr("schMin", "");
               $(this).attr("schHrs", "");
               $(this).html("");
           });
       }
   }


   function ClosePopup() {
       ClearPopup();
       Clear();
       $("#btnCloseForm").click();
       $("#divSuccessMsg").hide();
   }

   function Clear() {

       $(':input', '#form_sample_1')
        .not(':button, :submit, :reset, :hidden')
        .val('')
        .removeAttr('checked')
        .removeAttr('selected');
       $("#div1").hide();
       $('.help-inline').hide();
       $('.control-group').removeClass('error');
       $('.control-group').removeClass('success');
       $('.help-inline ok valid').hide();
       $("#spnGridMsg").html("&nbsp;");
       $("#spnID").html("0");

       $('#ddBorrowOrg option[value=""]').attr('selected', 'selected');
       $("#ddBorrowOrg").trigger("liszt:updated");
       $('#ddBorrowSchType option[value=""]').attr('selected', 'selected');
       $("#ddBorrowSchType").trigger("liszt:updated");
       $('#ddBorrowEmp option[value=""]').attr('selected', 'selected');
       $("#ddBorrowEmp").trigger("liszt:updated");

       $("#txtFromDate").val("");
       $("#txtToDate").val("");
       //$("#txtService").val("");

   }

   function ClearPopup() {
       Clear();
       $('#ddBorrowEmp option[value=""]').attr('selected', 'selected');
       $("#ddBorrowEmp").trigger("liszt:updated");
       $("#txtBorrowRemarks").val("");
   }

   function ApprovePendingRequest(rid) {
       $("#spnErrorMsg").css("display", "none");
       $("#spnSuccessMsg").css("display", "none");

       if (confirm("<%=Resources.Resource.confirmApproveBorrow %>")) {
               var d = "key=approve&rID=" + rid;
               $("#lblRqstApproveRejectID").val(rid);
               //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
               $.ajax({
                   type: 'POST',
                   data: d,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRoasterBorrowPage.aspx") %>',
                   success: function (html) {
                       if (html == 1) {
                           $("#spnSuccessMsg").css("display", "block");
                           $("#spnSuccessMsg").html("<%=Resources.Resource.approvedSuccessfully %>");
                           $('#btnBroadCastRequestApproveReject').click();
                           $("#sample_3_" + rid).remove();
                           $("#spnSuccessMsg").css("display", "block");
                           $("#btnAlertMessage").click();
                       }
                       else {
                           $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                           $("#lblRqstApproveRejectID").val("");
                           $("#spnErrorMsg").css("display", "block");
                           $("#btnAlertError").click();
                       }
                   },
                   error: function (html) {
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                       $("#lblRqstApproveRejectID").val("");
                       $("#spnErrorMsg").css("display", "block");
                       $("#btnAlertError").click();
                       //$("#form_sample_1").unmask();
                   }
               });
               }
           }

           function RejectPendingRequest(rid) {
               $("#spnErrorMsg").css("display", "none");
               $("#spnSuccessMsg").css("display", "none");

               if (confirm("<%=Resources.Resource.confirmRejectBorrow %>")) {
                var d = "key=reject&rID=" + rid;
                $("#lblRqstApproveRejectID").val(rid);
                //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRoasterBorrowPage.aspx") %>',
                   success: function (html) {
                       if (html == 1) {
                           $("#spnSuccessMsg").html("<%=Resources.Resource.rejectedSuccessfully %>");
                           $('#btnBroadCastRequestApproveReject').click();
                           $("#sample_3_" + rid).remove();
                           $("#spnSuccessMsg").css("display", "block");
                           $("#btnAlertMessage").click();
                       }
                       else {
                           $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                           $("#lblRqstApproveRejectID").val("");
                           $("#spnErrorMsg").css("display", "block");
                           $("#btnAlertError").click();
                       }
                   },
                   error: function (html) {
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                       $("#lblRqstApproveRejectID").val("");
                       $("#spnErrorMsg").css("display", "block");
                       $("#btnAlertError").click();
                       //$("#form_sample_1").unmask();
                   }
               });
               }
           }

           function LoadBorrowOrgList() {
               $("#spnErrorMsg").css("display", "none");
               $("#spnSuccessMsg").css("display", "none");

               var d = "key=getAllIdNameListString";
               //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   $("#ddBorrowOrg").html(html);
                   $("#ddBorrowOrg").trigger("liszt:updated");
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
                   //$("#form_sample_1").unmask();
               }
           });
           }

           function LoadBorrowSchTypeList() {
               $("#spnErrorMsg").css("display", "none");
               $("#spnSuccessMsg").css("display", "none");

               var d = "key=getIdNameListString";
               //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleTypePage.aspx") %>',
               success: function (html) {
                   $("#ddBorrowSchType").html(html);
                   $("#ddBorrowSchType").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
                   //$("#form_sample_1").unmask();
               }
           });
           }

           function LoadBorrowEmpList() {
               $("#divErrorMsg").css("display", "none");
               $("#spnSuccessMsg").css("display", "none");

               var d = "key=getIdNameListByOrgEmpType&orgID=" + $("#ddBorrowOrg").val() + "&schType=" + $("#ddBorrowSchType").val();

               //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   $("#ddBorrowEmp").html(html);
                   $("#ddBorrowEmp").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
                   //$("#form_sample_1").unmask();
               }
           });
           }

           function UpdateBorrow() {

               //save the current schedule roster for all employee for select month untill manager make any change
               //but its not finalize
               var v = "";
               var k = 1;
               var lsat = -1;
               var rowCount = 1;
               $("#sample_2 tbody tr").each(function () {
                   var rowEid = $(this).attr("eid");
                   var rowDay = "";
                   var rowSch = "";
                   var rowFromDate = "";
                   var rowToDate = "";
                   $(this).find("td.droppable").each(function () { //rewrite
                       //alert($(this).attr("schId") + " \n\n " + rowIndex);
                       if ($(this).attr("schId") != "-1" && $(this).attr("schId") != "") {
                           var eid = $(this).attr("eid");
                           var d = $(this).attr("d");
                           var sch = $(this).attr("schId");
                           var code = $(this).attr("code");
                           var fromDate = $(this).attr("fromDate");
                           var toDate = $(this).attr("toDate");
                           //v += "&d" + k + "=" + d + "&eid" + k + "=" + eid + "&sch" + k + "=" + sch;
                           //alert(" eid" + k + "=" + eid + "\n schid" + k + "=" + schid + "\n code" + k + "=" + code);
                           rowDay += d + ",";
                           rowSch += sch + ",";
                           rowFromDate = fromDate;
                           rowToDate = toDate;
                           k++;
                       }
                   });
                   v += "&rowEID" + rowCount + "=" + rowEid + "&rowDay" + rowCount + "=" + rowDay + "&rowSch" + rowCount + "=" + rowSch;
                   v += "&fromDate" + rowCount + "=" + rowFromDate + "&toDate" + rowCount + "=" + rowToDate;
                   rowFromDate = "";
                   rowToDate = "";
                   rowCount++;
                   rowDay = "";
                   rowSch = "";
                   rowEid = "";
               });

               v = "key=save&count=" + rowCount + v + "&orgID=" + $("#ddOrg").val() + "&empID=" + $("#ddEmp").val();
               v += "&month=" + $("#ddMonth").val() + "&year=" + $("#ddYear").val();

               if (k == 1) {
                   return;
               }

               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRoasterBorrowPage.aspx") %>',
               success: function (html) {
                   if (html == '-1' || html == '0') {
                       //failed
                       $("#spnSuccessMsg").css("display", "none");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                       $("#spnErrorMsg").css("display", "block");
                       $("#btnAlertError").click();
                   }
                   else {
                       //success
                       //SaveBorrow();
                       $("#spnErrorMsg").css("display", "none");
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                       $('#btnBroadCastRequestApproveReject').click();
                       $("#spnSuccessMsg").css("display", "block");
                       $("#btnAlertMessage").click();
                   }
               },
               error: function (html) {
                   $("#spnSuccessMsg").css("display", "none");
                   $("#spnErrorMsg").html("Error! " + html);
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
               }

           });
       }

       function SaveBorrow() {
           $("#spnErrorMsg").css("display", "none");
           $("#spnSuccessMsg").css("display", "none");

           var empID = $("#ddBorrowEmp").val();
           var remarks = $("#txtBorrowRemarks").val();
           var d = "key=borrowEmployee&empID=" + empID + "&month=" + $("#ddMonth").val();
           d += "&year=" + $("#ddYear").val() + "&remarks=" + remarks;
           d += "&fromDate=" + $("#txtFromDate").val() + "&toDate=" + $("#txtToDate").val();


           if ($('#form_sample_1').validate().form() == false) {

               return false;
           }

           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRosterPage.aspx") %>',
               success: function (data) {
                   var temp = $("#sample_2 tbody").html();
                   $("#sample_2 tbody").html(data + " " + temp);
                   BindGridDragDrop("sample_2");
                   ClosePopup();
                   //$("#form_sample_1").unmask();
               },
               error: function (html) {
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#spnErrorMsg").css("display", "block");
                   $("#btnAlertError").click();
                   //$("#form_sample_1").unmask();
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


                   if (!jQuery().daterangepicker) {
                       return;
                   }

                   if (!jQuery().datepicker || !jQuery().timepicker) {
                       return;
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
                               org: {
                                   required: true
                               },
                               fromDate: {
                                   required: true
                               },
                               toDate: {
                                   required: true
                               },
                               borrowEmp: {

                                   required: true
                               },
                               schType: {
                                   required: true
                               }
                           },
                           message: {
                               borrowEmp: {
                                   required: "<%=Resources.Resource.lblRequired %>"
                           },
                           fromDate: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           toDate: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           schType: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           org: {
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
