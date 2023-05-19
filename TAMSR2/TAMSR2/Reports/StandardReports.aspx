<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StandardReports.aspx.cs" Inherits="TAMSR2.Reports.StandardReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.standard + " " + Resources.Resource.reports %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <%--   <link href="../Assets/<%= languageStr %>/Styles/jquery.loadmask.css" rel="stylesheet" />
    <link href='../Assets/<%= languageStr %>/css/pages/login.css' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />--%>
    <link rel="stylesheet" href='../Assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.css" />

    <script type="text/javascript" src="../Assets/<%= languageStr %>plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>

    <script type="text/javascript" src="../Assets/<%= languageStr %>/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
    <!-- END PAGE LEVEL STYLES -->


    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-fileupload/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/select2/select2_metro.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/clockface/css/clockface.css" />

    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />

    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-toggle-buttons/static/stylesheets/bootstrap-toggle-buttons.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/daterangepicker.css" />
    <script src="<%= path %>assets/<%= languageStr %>/scripts/xlsx.full.min.js"></script>

    <style>
        .form-actions.nopadding {
            padding-left: 10px;
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
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.excelFormats %></h4>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <form action="#" id="form_sample_1">
                                <div id="divErrorMsg" class="alert alert-error hide">
                                    <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                                </div>

                                <div class="control-group">
                                    <div class="controls" style="float: left; margin-right: 6px; line-height: 1px;">
                                        <input type="radio" name="excelexport" id="dataonly" value="dataonly">
                                    </div>
                                    <label for="dataonly" class="control-label" style="font-size: 12px;">Data only</label>
                                </div>
                                <div class="control-group">
                                    <div class="controls" style="float: left; margin-right: 6px; line-height: 1px;">
                                        <input type="radio" name="excelexport" id="datawithformat" value="datawithformat">
                                    </div>
                                    <label for="datawithformat" class="control-label" style="font-size: 12px;">Data with format</label>
                                </div>

                                <div class="form-actions nopadding">
                                    <button id="btnSave" type="button" onclick="exportExcel()" class="btn purple"><%=Resources.Resource.confirm %></button>
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
    <div class="page-container row-fluid">

        <!-- BEGIN PAGE -->
        <div class="page">
            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

            <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
            <!-- BEGIN PAGE CONTAINER-->
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <h3 class="page-title"><%= Resources.Resource.standard + " " + Resources.Resource.reports %>
                        </h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>
                                <span class="icon-angle-right"></span>
                            </li>
                             
                            <li><a href="#"><%= Resources.Resource.standard + " " + Resources.Resource.reports %></a></li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT0-->
                <div class="row-fluid">
                    <div class="span12">
                        <div class="portlet box blue" id="form_wizard_1">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="icon-reorder"></i><%= Resources.Resource.standard + " " + Resources.Resource.reports %> <span class="step-title" id="step"></span>
                                </div>
                                <%-- <div class="tools hidden-phone">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="#portlet-config" data-toggle="modal" class="config"></a>
                           <a href="javascript:;" class="reload"></a>
                           <a href="javascript:;" class="remove"></a>
                        </div>--%>
                            </div>
                            <div class="portlet-body form">
                                <form action="#" id="form_1" class="form-horizontal">
                                    <%--<div onclick="ChangeLang()" style="display: inline; float: <%= pullDirectionStr%>; cursor: pointer;"> <%= Session["changeLanguage"] + "" %></div>
                                    --%>

                                    <div class="row-fluid">
                                        <div class="span12">
                                            <h3 class="block"><%=Resources.Resource.standard + " " + Resources.Resource.reports %></h3>
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.reports %><span class="required">*</span></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddReports" name="Reports" data-required="1" style="width: 420px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row-fluid" style="display: none;">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.region %><span class="required">*</span></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddRegion" name="Region" style="width: 420px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.region %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddOrg" name="Org" style="width: 420px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.costCenter %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                              <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_REPORT_FILTER_EMPLOYEE_TYPE) == true)
                                               { %>
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.employeeTypes %></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddEmpType" name="ddEmpType" style="width: 420px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employeeType %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <% } %>
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                     <label class="control-label"><%=Resources.Resource.manager %> <span class="required">*</span></label>
                                                     <div class="controls">
                                                          <select id="ddMgr" name="mgr" style="width: 420px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.manage %>">
                                                           <option value=""></option>
                                                            </select>
                                                    </div>
                                                   </div>
                                                </div>
                                            </div>
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.employee %><span class="required">*</span></label>
                                                        <div class="controls chzn-controls">

                                                            <select id="ddEmp" name="Emp" style="width: 420px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employees %>">
                                                                <option value=""></option>
                                                            </select>
                                                            <%-- <asp:DropDownList runat="Server" id="ddEmp" name="employee" ru style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
                                        
                                                                    </asp:DropDownList>--%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                                                        
                                            <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_REPORT_FILTER_EMPLOYEE_GROUP) == true)
                                               { %>
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.group %></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddEmpGroup" name="ddEmpGroup" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.group %>">
                                                                <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% } %>
                                             <div class="row-fluid" id="ddPermType-filter">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.permissionType %></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddPermType" name="ddPermType" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.permissionType %>">
                                                                <option value="-1"> <%=Resources.Resource.all %>  </option>
                                                                <option value="1"> <%=Resources.Resource.official %> </option>
                                                                <option value="0">  <%=Resources.Resource.personal %> </option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                             <div class="row-fluid" id="divYear" style="display:none; ">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.year %></label>
                                                        <div class="controls chzn-controls">
                                                            <select id="ddYear" name="ddYear" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
                                                                 
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/span-->
                                            <div class="row-fluid datecontrol">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.fromDate %><span class="required">*</span></label>
                                                        <div class="controls">
                                                            <input id="txtFromDate" name="fromDate" style="width: 211px;" data-required="1" class="m-wrap m-ctrl-medium date-picker reportcalendar" size="16" type="text" value="" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <div class="row-fluid datecontrol">
                                                <div class="span6 ">
                                                    <div class="control-group">
                                                        <label class="control-label"><%=Resources.Resource.toDate %><span class="required">*</span></label>
                                                        <div class="controls">
                                                            <input id="txtToDate" name="toDate" style="width: 211px;" data-required="1" class="m-wrap m-ctrl-medium date-picker reportcalendar" size="16" type="text" value="" />
                                                            <br />
                                                            <br />
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <div class="row-fluid">
                                                <div class="span6 ">
                                                    <div class="control-group" style="<% CheckInactivePrivilege(); %>">
                                                        <label class="control-label">&nbsp;</label>
                                                        <div class="controls">
                                                            <input id="chkboxIncludeInActive" type="checkbox" name="includeInactive" />
                                                            <%=Resources.Resource.includeInactiveStaff %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <% 
                                                if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_INACTIVE_ORGANIZATION) == true)
                                            {%>
                                                    <div class="row-fluid">
                                                        <div class="span6 ">
                                                            <div class="control-group" >
                                                                <label class="control-label">&nbsp;</label>
                                                                <div class="controls">
                                                                    <input id="chkboxIncludeInactiveOrgs" type="checkbox" name="IncludeInactiveOrgs" />
                                                                 <span>   <%=Resources.Resource.includeInActiveOrganizations %> </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                             
                                                    </div>
                                             <% } %>
                                              

                                        </div>
                                    </div>


                                    <div class="form-actions clearfix">

                                        <a href="javascript:;" class="btn icn-only green" id="btnViewReport">
                                            <%=Resources.Resource.showReport %>
                                            <i class="m-icon-swapright m-icon-white"></i>
                                        </a>

                                        <% 
                                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.REPORT_EXPORT_EXCEL) == true)
                                            {%>
                                        <a href="javascript:;" class="btn blue button-next" id="btnExcelDownload">
                                            <%=Resources.Resource.exportExcel %> <i class="m-icon-swapright m-icon-white"></i>
                                        </a>
                                        <% } %>
                                        <% 
                                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.REPORT_EXPORT_WORD) == true)
                                            {%>
                                        <a href="javascript:;" class="btn blue button-next" id="btnWordDownload">
                                            <%=Resources.Resource.exportWord %> <i class="m-icon-swapright m-icon-white"></i>
                                        </a>
                                        <% } %>
                                        <%
                                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.REPORT_EXPORT_PDF) == true)
                                            {%>
                                        <a href="javascript:;" class="btn blue button-next" id="btnPdfDownload">
                                            <%=Resources.Resource.exporttopdf %> <i class="m-icon-swapright m-icon-white"></i>
                                        </a>
                                        <% } %>
                                        <a href="javascript:;" class="btn blue button-next" id="btnViewReportGraphical">
                                            <%=Resources.Resource.showReportGraphical %> <i class="m-icon-swapright m-icon-white"></i>
                                        </a>
                                        <a href="javascript:;" class="btn button-previous" id="btnCancel" style="display: none;">
                                            <%=Resources.Resource.cancel %> 
                                        </a>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>



                </div>
            </div>

            <table  border='1' bgColor='#ffffff'  borderColor='#000000' cellSpacing='0' cellPadding='0'  style='display:none;font-size:10.0pt; font-family:Calibri; background:white;' class="table table-hover" id="tabletoexcel">
                <thead>

                    <tr>
                        <td>&nbsp</td>
                    </tr>
                </thead>
                <tbody></tbody>
             </table>
            <!-- END PAGE CONTENT-->

            <!-- END PAGE CONTAINER-->
        </div>
        <!-- END PAGE -->
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
    <%-- <script src="../assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>--%>
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
    <%--<script src="../Scripts/jquery.signalR-1.1.0.min.js"></script>--%>
    <%--<!--Reference the autogenerated SignalR hub script. -->
    <script src="../signalr/hubs"></script>

    --%><!-- END PAGE LEVEL PLUGINS -->

    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
    <script src="../assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>
    <script src="../Scripts/jquery.loadmask.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">

        $(document).ready(function () {
            App.init(); // initlayout and core plugins 
            FormComponents.init();
            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liRpt").addClass("active");
            $("#liRpt .arrow").addClass("open");
            $("#liStandardReports").addClass("active");
            $("#liStandardReports").addClass("open");
            $("#liStandardReports").addClass("active");
            $("#ddPermType-filter").hide();
            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
            $("#btnViewReportGraphical").hide();

            $('#ddReports').change(function (e) {

                if ($(this).val().trim() == 7) {
                    $('.datecontrol').hide();
                    $("#divYear").css("display", "none");
                }
                else {
                    $('.datecontrol').show(); 
                }

                if ($("#ddReports option:selected").text().trim() === "Attendance Summary Report") {
                    $("#btnViewReportGraphical").show(); 
                }
                else {
                    $("#btnViewReportGraphical").hide(); 
                }
                
                if ($("#ddReports option:selected").text().trim() == "Employee Year Summary Report" || $("#ddReports option:selected").text().trim() == "تقرير الملخص السنوية الموظف ") {
                    
                    $("#divYear").css("display", "block");
                    $('.datecontrol').hide();
                }
                else {
                    $("#divYear").css("display", "none");
                }

                if ($("#ddReports option:selected").text().trim() === "Permissions Report") {
                    $("#ddPermType-filter").show();
                    $("#divYear").css("display", "none");
                }
                else {
                    $("#ddPermType-filter").hide(); 
                }

            });
            BindReportDropDown(); 
            LoadRegions();
            LoadOrganizations();
            LoadManager();
            LoadEmployees();
            LoadGroups();
            LoadEmployeeTypes();
            LoadYear();

            $("#ddRegion").change(function () {
                LoadOrganizations();
                LoadManager();
                LoadEmployees();

            });
            $("#ddOrg").change(function () {
                LoadManager();
                LoadEmployees();
            });

            $("#ddMgr").change(function () {

                LoadEmployees();
            });
            $("#ddEmpType").change(function () {
                LoadManager();
                LoadEmployees();
            });
            $("#chkboxIncludeInActive").change(function () {
                LoadManager();
                LoadEmployees();
            });
            $("#chkboxIncludeInactiveOrgs").change(function () {
                LoadOrganizations();
                
            });
        });
        function Clear() {
            $('input[name="excelexport"]').prop('checked', false);
            $("#divErrorMsg").hide();
        }
        function CloseForm() {
            Clear();
            $("#divErrorMsg").hide();
            $("#divErrorMsg").hide();
            $('#portlet-config').modal('hide');
        }
        function LoadGroups() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var d = "key=getIdNameListString";
            $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeGroupPage.aspx") %>',
                success: function (html) {
                    $("#form_sample_1").unmask();
                    $("#ddEmpGroup").html(html);
                    $("#ddEmpGroup").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    $("#form_sample_1").unmask();
                }
            });
        }
        $("#btnViewReport").click(function () {
            ShowReport('ViewReport');
        })
        $("#btnViewReportGraphical").click(function () {
            ShowReportGraphical('ViewReport');
        })
        $('#btnExcelDownload').click(function () {
            Clear();
            $('#portlet-config').modal('show');
        });
        function validateRadionSelection() {

            var result = { flag: false, value: -1 };
            var flag = false;
            var format;
            if (document.querySelector('input[name = "excelexport"]:checked')) {
                format = document.querySelector('input[name = "excelexport"]:checked').value;
            }
            else
                result.flag = false;

            if (format) {
                result.flag = true;
                result.value = format;
            }

            return result;
        }
        function exportExcel() {
            var result = validateRadionSelection();
            if (result.flag) {
                CloseForm();
                ShowReport('ExcelDownload', result.value);
            }
            else {
                $('#spnErrorMsg').html('Please select an option first');
                $('#divErrorMsg').show();
                return;
            }
        }
        $('#btnPdfDownload').click(function () {
            ShowReport('PdfDownload');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });
        $('#btnWordDownload').click(function () {
            ShowReport('WordDownload');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });

     
        function ShowReport(action, format) {

            var ReportText = $("#ddReports option:selected").text();
            var ReportVal = $("#ddReports option:selected").val();

            var RegionID = $("#ddRegion option:selected").val();
            var OrgID = $("#ddOrg option:selected").val();
            var EmpID = $("#ddEmp option:selected").val();
            var MgrID = $("#ddMgr option:selected").val();

            var Year = "";
           

            var FromDate = getServerDate($("#txtFromDate"));
            var ToDate = getServerDate($("#txtToDate"));

            var includeInactive = $("#chkboxIncludeInActive").is(":checked");
            ;
            if (ReportText.trim() == 'Employee Year Summary Report' || ReportVal.trim() == '10051') {
                Year = $("#ddYear option:selected").val();
                FromDate = "";
                ToDate = "";
            }
            else
                Year = "";
           

            if (Year != "" ) {
                FromDate = Year + "-01-01";
                ToDate = Year + "-12-31";
            }

            var OrgName = $("#ddOrg option:selected").text();
            var EmpName = $("#ddEmp option:selected").text();


            var d = "key=ShowStandardReport&action=" + action + "&ReportName=" + ReportText.trim() + "&ReportCode=" + ReportVal.trim();
            d += "&Region=" + RegionID.trim() + "&Organization=" + OrgID.trim() + "&Employee=" + EmpID.trim() + "&Manager=" + MgrID.trim();
            d += "&FromDate=" + FromDate.trim() + "&ToDate=" + ToDate.trim() + "&includeInactive=" + includeInactive;
            if ($("#ddEmpGroup").length > 0 && $("#ddEmpGroup").val() != "") {
                d += '&groupID=' + $('#ddEmpGroup').val()
            }
            else {
                d += "&groupID=" + "";
            }
            if ($("#ddEmpType").length > 0 && $("#ddEmpType").val() != "") {
                d += '&EmpTypeID=' + $('#ddEmpType').val()
            }
            else {
                d += "&EmpTypeID=" + "";
            }
            if ($('#ddPermType').length > 0 && $('#ddPermType').val()) {

                d += '&PermCatID=' + $('#ddPermType').val();
            }
            else {
                d += "&PermCatID=" + "";
            }
            
            if (action == 'ViewReport') {
                window.open('ViewStandardRptPage.aspx?' + d, '_blank', 'height=' + screen.height + ',width=' + screen.width + 'toolbar=0,scrollbars=1,location=0,menubar=0,resizable=yes');
            }
            else if (action == 'ExcelDownload') {
                window.open('ViewStandardRptPage.aspx?' + d + "&format=" + format);
               <%-- $.ajax({
                    url: '<%= Page.ResolveClientUrl("/Reports/ViewStandardRptPage.aspx?" ) %>' + d + "&format=" + format,
                    type: 'POST',
                    success: function (data) {
                      alert(data);
                        $("#tabletoexcel tbody").html(data);
                        var wb = XLSX.utils.table_to_book(document.querySelector('table#tabletoexcel'), { sheet: "MovementReport" });
                        var wbout = XLSX.write(wb, { bookType: 'xlsx', bookSST: true, type: 'binary' });

                        function s2ab(s) {
                            var buf = new ArrayBuffer(s.length);
                            var view = new Uint8Array(buf);
                            for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
                            return buf;
                        }

                        var blob = new Blob([s2ab(wbout)], { type: "application/octet-stream" });
                        var url = URL.createObjectURL(blob);

                        var link = document.createElement("a");
                        link.setAttribute("href", url);
                        link.setAttribute("download", "MovementReport.xlsx");
                        link.style.visibility = 'hidden';
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);
                    }
                    //error: function () {
                    //    alert('Error downloading file');
                    //}
                });--%>
                
            }
            else if (action == 'WordDownload') {
                window.location = 'ViewStandardRptPage.aspx?' + d;

            }
            else if (action == 'PdfDownload') {
                window.location = 'ViewStandardRptPage.aspx?' + d;

            }

            return;

            $("#form_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                type: 'POST',
                data: d,
                success: function (html) {
                    //alert(html);
                    $("#form_1").unmask();
                    if (action == 'ViewReport') {
                        window.open('../Reports/ViewStandardReports.aspx?Key=viewreport', '_blank', 'height=' + screen.height + ',width=' + screen.width + 'toolbar=0,scrollbars=1,location=0,menubar=0,resizable=yes');
                    }
                    else if (action == 'ExcelDownload') {
                        window.location.href = '../Reports/ViewStandardReports.aspx?Key=Excel';

                    }
                    else if (action == 'WordDownload') {
                        window.location.href = '../Reports/ViewStandardReports.aspx?Key=Word';

                    }
                    else if (action == 'PdfDownload') {
                        window.location.href = '../Reports/ViewStandardReports.aspx?Key=Pdf';

                    }
                },
                error: function (html) {
                    $("#form_1").unmask();
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");

                }
            });
        }
        function ShowReportGraphical(action) {

            var ReportText = $("#ddReports option:selected").text();
            var ReportVal = $("#ddReports option:selected").val();

            var RegionID = $("#ddRegion option:selected").val();
            var OrgID = $("#ddOrg option:selected").val();
            var EmpID = $("#ddEmp option:selected").val();
            var FromDate = getServerDate($("#txtFromDate"));
            var ToDate = getServerDate($("#txtToDate"));

            var includeInactive = $("#chkboxIncludeInActive").is(":checked");
            var MgrID = $("#ddMgr").val();
            var OrgName = $("#ddOrg option:selected").text();
            var EmpName = $("#ddEmp option:selected").text();

            var d = "key=ShowReportGraphical&action=" + action + "&ReportName=" + ReportText.trim() + "&ReportCode=" + ReportVal.trim();
            d += "&Region=" + RegionID.trim() + "&Organization=" + OrgID.trim() + "&Employee=" + EmpID.trim() + "&Manager=" + MgrID.trim();
            d += "&FromDate=" + FromDate.trim() + "&ToDate=" + ToDate.trim() + "&includeInactive=" + includeInactive;
            if ($("#ddEmpGroup").length > 0 && $("#ddEmpGroup").val() != "") {
                d += '&groupID=' + $('#ddEmpGroup').val()
            }
            else {
                d += "&groupID=" + "";
            }
            if ($("#ddEmpType").length > 0 && $("#ddEmpType").val() != "") {
                d += '&EmpTypeID=' + $('#ddEmpType').val()
            }
            else {
                d += "&EmpTypeID=" + "";
            }
            if (action == 'ViewReport') {
                window.open('ViewStandardRptPageGraphical.aspx?' + d, '_blank', 'toolbar=0,scrollbars=1,location=0,menubar=0,resizable=yes,height=' + screen.height + ',width=' + screen.width);
            }

            return;

        }

        function LoadManager() { 
            $("#spnErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var includeInactive = $("#chkboxIncludeInActive").is(":checked");

            if (includeInactive == true || includeInactive == 'true')
                includeInactive = 1;
            else
                includeInactive = 0;

            var d = "key=getMgrIdNameListString&orgID=" + $("#ddOrg").val() + "&includeInactive=" + includeInactive;
             $.ajax({
                 type: 'POST',
                 data: d,
                 url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                   
                    $("#ddMgr").html(html);
                    $("#ddMgr").trigger("liszt:updated");

                },
                error: function (html) {
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>"); 
                    $("#spnErrorMsg").css("display", "block"); 
                }
            });
            }

        function LoadEmployeeTypes() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
               $.ajax({
                   type: 'POST',
                   data: d,
                   url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeTypePage.aspx") %>',
               success: function (html) {
                   $("#ddEmpType").html(html);
                   $("#ddEmpType").trigger("liszt:updated");
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
        function LoadRegions() {
            var d = "key=getCodeNameListString";
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
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadOrganizations() {

            
            var includeInactive = $("#chkboxIncludeInactiveOrgs").is(":checked");
            var d = "key=getIdNameListStringByRegion&Region=" + $("#ddRegion").val() + "&includeInactive=" + includeInactive;
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    $("#ddOrg").html(html);
                    $("#ddOrg").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function BindReportDropDown() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var d = "key=StandardReport";
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                success: function (html) {
                    $("#ddReports").html(html);
                    $("#ddReports").trigger("liszt:updated");
                    //LoadGrid();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadEmployees() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

          
            var orgVal = $("#ddOrg").val();
            var ParentID = $("#ddOrg").val();
            var includeInactive = $("#chkboxIncludeInActive").is(":checked");
            var ManagerId = $("#ddMgr").val();
            if (ManagerId == 'Undefined' || ManagerId == 'undefined' || ManagerId == undefined)
                ManagerId = '';

            if (includeInactive == true || includeInactive == 'true')
                includeInactive = 1;
            else
                includeInactive = 0;

            var d = "key=getEmpIdNameListByOrgAndGroup&orgID=" + $("#ddOrg").val() + "&managerID=" +ManagerId + "&includeInactive=" + includeInactive;
           // d = "key=getIdNameListByOrgID&ParentID=" + ParentID + "&OrgID=" + orgVal + "&includeInactive=" + includeInactive;
            if ($("#ddEmpType").length > 0 && $("#ddEmpType").val() != "") {
                d += '&EmpTypeID=' + $('#ddEmpType').val()
            }
            else {
                d += "&EmpTypeID=" + "";
            }
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   $("[name='Emp']").html(html)
                   $("[name='Emp']").trigger("liszt:updated");

                   if ("<%= Session["ID"] %>" != "1")
                       $("[name='Emp']").val("<%= Session["ID"] %>");
                       $("[name='Emp']").trigger("liszt:updated");
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //     $("#form_sample_1").unmask();
                }
           });
        }
        function LoadYear() {
            var html = "";
            for (var i = 2015; i <= 2025; i++)
                html += "<option value=\"" + i + "\">" + i + "</option>\n";
            
            $("#ddYear").html(html);
            $('#ddYear option[value=' + <%= DateTime.Now.Year %> + ']').attr('selected', 'selected');
            $("#ddYear").trigger("liszt:updated");
        }
        var FormComponents = function () {

            var handlejQueryUIDatePickers = function () {
                $(".ui-date-picker").datepicker();
                //      alert("I'm here");
            }

            var handleDateTimePickers = function () {

                if (jQuery().datepicker) {
                    $('#txtFromDate').datepicker({ format: '<%= ConfigurationManager.AppSettings["dateFormat_UI"] %>' || 'dd-mm-yyyy' });
                    $('#txtToDate').datepicker({ format: '<%= ConfigurationManager.AppSettings["dateFormat_UI"] %>' || 'dd-mm-yyyy' });
                   
                }

                var firstDayOfMonth = '<%= FirstDayOfMonth.ToString("yyyy-MM-dd") %>';
                var currentDayOfMonth = '<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>'

               

                $("#txtFromDate").datepicker('setDate', new Date(firstDayOfMonth));
                $("#txtToDate").datepicker('setDate', new Date(currentDayOfMonth));
               
                $("#txtFromDate").datepicker("update");
                $("#txtToDate").datepicker("update");

                // commented by wajahat . Reason :  It will only fill the text box but will not mark on the calendar
                <%--$("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("yyyy-MM-dd") %>');--%>

           }

           var handleInputMasks = function () {
               //  alert('p');
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
                   //handleInputMasks();
               }

           };

       }();
       ////////END OF FORM COMPONENTS//////// 
        function getServerDate(obj) {
            var newDate;
            if ($(obj) && $(obj).length > 0) {

                var temp = $(obj).val();
                var arr = temp.split('-')
               
                if (arr && arr.length > 0) {
                    newDate = arr[2] + '-' + arr[1] + '-' + arr[0]
                }
                else
                   newDate =  temp;
               
            }
            return newDate;
        }
    </script>
</asp:Content>
