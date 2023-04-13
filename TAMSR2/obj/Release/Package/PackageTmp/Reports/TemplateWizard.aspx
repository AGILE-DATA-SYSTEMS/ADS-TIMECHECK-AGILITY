<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TemplateWizard.aspx.cs" Inherits="TAMSR2.Reports.TemplateWizard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.templateWizard %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="../Assets/<%= languageStr %>/Styles/jquery.loadmask.css" rel="stylesheet" />
    <link href='../Assets/<%= languageStr %>/css/pages/login.css' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
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
    <!-- END PAGE LEVEL STYLES -->


    <script src="../assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        var TableName = "";
        var columndescrArray = [];
        columndescrArray.push({ col: "employee_id", description: "Employee Id (Timecheck)" });
        columndescrArray.push({ col: "Transaction_date", description: "Transaction date " });
        columndescrArray.push({ col: "employee_code", description: "Staff number (ERP)" });
        columndescrArray.push({ col: "IsSenior", description: "Flag (set to 1 if employee is member of 'Seniors' group)" });
        columndescrArray.push({ col: "EmployeeID_Name_English", description: "Employee Code and Name (english)" });
        columndescrArray.push({ col: "EmployeeID_Name_Arabic", description: "Employee Code and Name (arabic)" });
        columndescrArray.push({ col: "EmployeeID_Name_English_Desig", description: "Employee Code, Name and Designation(english)" });
        columndescrArray.push({ col: "EmployeeID_Name_Arabic_Desig", description: "Employee Code, Name and Designation(arabic)" });
        columndescrArray.push({ col: "Employee_Name_English", description: "Employee Name (english)" });
        columndescrArray.push({ col: "Employee_Name_Arabic", description: "Employee Name (arabic)" });
        columndescrArray.push({ col: "organization_id", description: "Organization_id (local reference key)" });
        columndescrArray.push({ col: "OrgOpenShift", description: "Flag (set to 1 if organization open shift flag is set to 'true')" });
        columndescrArray.push({ col: "Organization_Code", description: "Organization Code (ERP)" });
        columndescrArray.push({ col: "OrganizationID_Name_English", description: "Organization Code and Description (english)" });
        columndescrArray.push({ col: "OrganizationID_Name_Arabic", description: "Organization Code and Description (arabic)" });
        columndescrArray.push({ col: "Organization_Name_English", description: "Organization Description (english)" });
        columndescrArray.push({ col: "Region_Code", description: "Region Code (ERP)" });
        columndescrArray.push({ col: "Region_Description_Eng", description: "Region Decription (english)" });
        columndescrArray.push({ col: "Region_Description_Arb", description: "Region Description (arabic)" });
        columndescrArray.push({ col: "Grade_Code", description: "Grade Code (ERP)" });
        columndescrArray.push({ col: "Grade_description_English", description: "Grade Description (english)" });
        columndescrArray.push({ col: "Grade_description_Arabic", description: "Grade Description (arabic)" });
        columndescrArray.push({ col: "Designation_Code", description: "Designation Code (ERP)" });
        columndescrArray.push({ col: "Designation_Name_English", description: "Designation Description (english)" });
        columndescrArray.push({ col: "Designation_Name_Arabic", description: "Desgination Description (arabic)" });
        columndescrArray.push({ col: "Nationality_Code", description: "Nationality Code (ERP)" });
        columndescrArray.push({ col: "Nation_Name_English", description: "Nationality Description (english)" });
        columndescrArray.push({ col: "Nation_Name_Arabic", description: "Nationality Description (arabic)" });
        columndescrArray.push({ col: "Is_Manager", description: "Flag(if employee is manager then it will be 'Y')" });
        columndescrArray.push({ col: "email", description: "employee email" });
        columndescrArray.push({ col: "Join_Date ", description: "employee join date" });
        columndescrArray.push({ col: "inactive_date", description: "employee inactive date" });
        columndescrArray.push({ col: "Schedule_code", description: "Schedule code (employee assigned schedule code)" });
        columndescrArray.push({ col: "Schedule_Type_DESC_English ", description: "Schedule Type Description (english)" });
        columndescrArray.push({ col: "Schedule_Type_DESC_Arabic", description: "Schedule Type Description (arabic)" });
        columndescrArray.push({ col: "Shift_1_Schedule_In", description: "First Shift Start Time" });
        columndescrArray.push({ col: "Shift_1_Schedule_Out", description: "First Shift End Time" });
        columndescrArray.push({ col: "Shift_2_Schedule_In", description: "Second Shift Start Time" });
        columndescrArray.push({ col: "Shift_2_Schedule_Out", description: "Second Shift End Time" });
        columndescrArray.push({ col: "Shift_3_Schedule_In", description: "Third Shift Start Time" });
        columndescrArray.push({ col: "Shift_3_Schedule_Out", description: "Third Shift End Time" });
        columndescrArray.push({ col: "Flexible_minutes", description: "Schedule Flexible time" });
        columndescrArray.push({ col: "Grace_In_minutes", description: "Grace time for entry" });
        columndescrArray.push({ col: "Grace_Out_minutes", description: "Grace time for exit" });
        columndescrArray.push({ col: "Punch_In", description: "Employee Entry Punch" });
        columndescrArray.push({ col: "Punch_Out", description: "Employee Exit Punch" });
        columndescrArray.push({ col: "Punch_In_Type_Code", description: "Entry Punch Reason code" });
        columndescrArray.push({ col: "Punch_In_Type_English", description: "Entry Punch Reason description (english)" });
        columndescrArray.push({ col: "Punch_In_Type_Arabic", description: "Entry Punch Reason description (arabic)" });
        columndescrArray.push({ col: "Punch_Out_Type_Code", description: "Exit Punch Reason code" });
        columndescrArray.push({ col: "Punch_Out_Type_English", description: "Exit Punch Reason description (english)" });
        columndescrArray.push({ col: "Punch_Out_Type_Arabic", description: "Exit Punch Reason description (arabic)" });
        columndescrArray.push({ col: "Punch_In_Reader_Code", description: "Entry Device Code" });
        columndescrArray.push({ col: "Punch_In_Reader_Name_English", description: "Entry Device Description (english)" });
        columndescrArray.push({ col: "Punch_In_Reader_Name_Arabic ", description: "Entry Device Description (arabic)" });
        columndescrArray.push({ col: "Punch_Out_Reader_Code", description: "Exit Device Code" });
        columndescrArray.push({ col: "Punch_Out_Reader_Name_English", description: "Exit Device Description (english)" });
        columndescrArray.push({ col: "Punch_Out_Reader_Name_Arabic", description: "Exit Device Description (arabic)" });
        columndescrArray.push({ col: "Holiday_Status", description: "Flag('Holiday' if its public holiday defined in system)" });
        columndescrArray.push({ col: "RestDay_Status", description: "Flag ('Day Off' if there is no schedule defined for employee)" });
        columndescrArray.push({ col: "Leave_Status", description: "Flag ('Leave' if employee has leave reacord)" });
        columndescrArray.push({ col: "Day_Status", description: "Decription for status whether absent, full day permission, leave or holiday" });
        columndescrArray.push({ col: "Shift1_Status", description: "Not available" });
        columndescrArray.push({ col: "Shift2_Status", description: "Not available" });
        columndescrArray.push({ col: "Shift3_Status", description: "Not available" });
        columndescrArray.push({ col: "Absent_Minutes", description: "Absent minutes based on schedule " });
        columndescrArray.push({ col: "Comment_English", description: "comments (english) based on day status (absent, leave, holiday, permission)" });
        columndescrArray.push({ col: "Comment_Arabic", description: "comments (arabic) based on day status (absent, leave, holiday, permission)" });
        columndescrArray.push({ col: "Remarks_English", description: "remarks (english) based on (leave description, permission description or holiday description)" });
        columndescrArray.push({ col: "Remarks_Arabic", description: "remarks (arabic) based on (leave description, permission description or holiday description)" });
        columndescrArray.push({ col: "Is_Absent_Approved", description: "Flag (if absent is approved it will be 1)" });
        columndescrArray.push({ col: "Absent_Approver_Name_English", description: "Employee Name (english) who approved absent" });
        columndescrArray.push({ col: "Absent_Approver_Name_Arabic", description: "Employee Name (arabic) who approved absent" });
        columndescrArray.push({ col: "Absent_Approver_Unit_English", description: "Employee Organization unit (english) who approved absent" });
        columndescrArray.push({ col: "Absent_Approver_Unit_Arabic", description: "Employee Organization unit (arabic) who approved absent" });
        columndescrArray.push({ col: "Late_Minutes", description: "Number of minutes employee came late" });
        columndescrArray.push({ col: "Is_Late_Approved", description: "Flag (if late is approved it will be 1)" });
        columndescrArray.push({ col: "Late_Approver_Name_English", description: "Employee Name (english) who approved late" });
        columndescrArray.push({ col: "Late_Approver_Name_Arabic", description: "Employee Name (arabic) who approved late" });
        columndescrArray.push({ col: "Late_Approver_Unit_English", description: "Employee Organization unit (english) who approved late" });
        columndescrArray.push({ col: "Late_Approver_Unit_Arabic", description: "Employee Organization unit (arabic) who approved late" });
        columndescrArray.push({ col: "Early_Minutes", description: "Number of minutes employee left early" });
        columndescrArray.push({ col: "Is_Early_Approved", description: "Flag (if early is approved it will be 1)" });
        columndescrArray.push({ col: "Early_Approver_Name_English", description: "Employee Name (english) who approved early" });
        columndescrArray.push({ col: "Early_Approver_Name_Arabic", description: "Employee Name (arabic) who approved early" });
        columndescrArray.push({ col: "Early_Approver_Unit_English", description: "Employee Organization unit (english) who approved early" });
        columndescrArray.push({ col: "Early_Approver_Unit_Arabic", description: "Employee Organization unit (arabic) who approved early" });
        columndescrArray.push({ col: "Missing_Time", description: "Missed time schedule" });
        columndescrArray.push({ col: "Missing_Time_HH_MM", description: "Missed time schedule (HH:MM)" });
        columndescrArray.push({ col: "In_Permission_From_Time", description: "Permission start time against entry punch" });
        columndescrArray.push({ col: "In_Permission_To_Time", description: "Permission end time against entry punch" });
        columndescrArray.push({ col: "Out_Permission_From_Time", description: "Permission start time against exit punch" });
        columndescrArray.push({ col: "Out_Permission_To_Time", description: "Permission end time against exit punch" });
        columndescrArray.push({ col: "Full_Day_Permission", description: "Flag (if permission if for full day then it will be 'YES')" });
        columndescrArray.push({ col: "IN_Permission_Is_Official", description: "N/A" });
        columndescrArray.push({ col: "OUT_Permission_Is_Official", description: "N/A" });
        columndescrArray.push({ col: "Work_Minutes", description: "Employee actual worked time in minutes" });
        columndescrArray.push({ col: "overtime", description: "Minutes for overtime" });
        columndescrArray.push({ col: "Early_Punch_In_Minutes", description: "number of minutes employee punched before schedule start" });
        columndescrArray.push({ col: "Late_Punch_Out_Minutes", description: "number of minutes employee punched after schedule ends" });
        columndescrArray.push({ col: "Late_HH_MM", description: "Late violation in hours and minutes format" });
        columndescrArray.push({ col: "Early_HH_MM", description: "Early violation in hours and minutes format" });
        columndescrArray.push({ col: "Work_Time_HH_MM", description: "Employee actual worked time in hour and minutes format" });
        columndescrArray.push({ col: "parent_organization_code", description: "Parent organization unit code of employee current organization unit" });
        columndescrArray.push({ col: "parent_org_id", description: "Parent organization unit ID of employee current organization unit" });
        columndescrArray.push({ col: "parent_org_description_eng", description: "Parent organization unit description (english) of employee current organization unit" });
        columndescrArray.push({ col: "OT_MGR_STATUS", description: "Flag (whether manager has approved overtme)" });
        columndescrArray.push({ col: "OT_HR_STATUS", description: "Flag (whether HR/ADMIN has approved overtme)" });
        columndescrArray.push({ col: "OT_SYNC_STATUS", description: "Whether OT is pushed to back to staging" });
        columndescrArray.push({ col: "OT_request_date", description: "when OT is applied or approved by manager" });
        columndescrArray.push({ col: "OT_request_status", description: "status of overtime to manager" });
        columndescrArray.push({ col: "OT_request_userid", description: "OT applied by / manager ID who took action " });
        columndescrArray.push({ col: "OT_action_date", description: "when OT action taked by HR/ADMIN " });
        columndescrArray.push({ col: "OT_action_status", description: "status with HR/ADMIN" });
        columndescrArray.push({ col: "OT_action_userid", description: "employee ID who took action (HR/ADMIN)" });
        columndescrArray.push({ col: "OT_processed_date", description: "When OT is pushed back to staging" });
        columndescrArray.push({ col: "OT_processed_status", description: "Flag whether OT is pushed back to staging or not" });
        columndescrArray.push({ col: "OT_processed_userid", description: "Who initiated OT to synchronize with staging" });
        columndescrArray.push({ col: "absent", description: "whether employee is absent " });
        columndescrArray.push({ col: "restday", description: "whether its rest day" });
        columndescrArray.push({ col: "schedule_id", description: "employee assigned schedule id " });
        columndescrArray.push({ col: "BeforeScheduleMin", description: "Minutes before schedule " });
        columndescrArray.push({ col: "AfterScheduleMin", description: "Minute after schedule" });
        columndescrArray.push({ col: "Out_Minutes", description: "Minutes for employee outside office premesis." });
        columndescrArray.push({ col: "Out_HH_MM", description: "Minutes for employee outside office premesis (HH:MM)." });


        $(document).ready(function () {
            //alert(typeof String.prototype.trim);
            if (typeof String.prototype.trim != 'function') {
                String.prototype.trim = function () {
                    return this.replace(/^\s+|\s+$/g, '');
                }
            }
        });
        function firstToUpperCase(str) {
            return str.substr(0, 1).toUpperCase() + str.substr(1);
        }
        function LoadColumns(action) {

            TableName = $("#selCat option:selected").val();
            //if (Cat == "Time Attendance") {
            //    TableName = "EmployeeTransDetails";
            //}
            //else if (Cat == "Employee Details") {
            //    TableName = "View_Employee_Details";
            //}
            //else if (Cat == "Employee Overtime") {
            //    TableName = "Employee_Overtime_TransDetails";
            //}
            //else {
            //    TableName = "EmployeeTransDetails";
            //}


            var v = "key=LoadColumns&action=" + action + "&TableName=" + TableName;
            $(".tab-pane").css("cursor", "wait");
            //$(".tab-content").mask("<%=Resources.Resource.processing %>...");
            $.ajax({
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                type: "POST",
                data: v,
                success: function (msg) {
                    //$("tab-content").unmask();
                    if (action == "Columns") {
                        $("#Columns").html(msg);
                        $("#Columns select").chosen();
                        $("#Columns #select2_sample3").trigger('change');
                        $(".tab-pane").css("cursor", "pointer");
                    }
                    else if (action == "SortBy") {
                        $("#SortBy").html(msg);
                        $("#SortBy select").chosen();
                        $("#SortBy select").trigger('change');
                        $(".tab-pane").css("cursor", "pointer");
                    }
                    else if (action == "Filters") {
                        $("#Filters").html(msg);
                        $("#Filters select").chosen();
                        $("#Filters select").trigger('change');
                        $(".tab-pane").css("cursor", "pointer");
                    }
                    else if (action == "GroupBy") {
                        $("#GrpBY").html(msg);
                        $("#GrpBY select").chosen();
                        $("#GrpBY select").trigger('change');
                        $(".tab-pane").css("cursor", "pointer");
                    }
                },
                Error: function (x, e) {
                    //$("tab-content").unmask();
                    // $("#Columns").html("Sorry No Data Found");
                    $(".tab-pane").css("cursor", "pointer");
                }
            });
        }


        function SaveReportTemplate() {
            // alert(":OPPOPO");
            //alert(SelectedCols + SortBy + SortCols + FilterCols + GroupCols);
            var NameEn = $("#txtReportNameEn").val();
            var NameAr = $("#txtReportNameAr").val();
            //alert(NameEn  + NameAr);

            var DescEn = $("#txtDescriptionEn").val();
            var DescAr = $("#txtDescriptionAr").val();

            var Cat = $("#selCat option:selected").text();
            // alert(Cat);
            //  alert(TableName);
            //  
            if ($("#radPotrait").attr("checked") == "checked") {
                reportLayout = $('#radPotrait').val();
            }
            else if ($("#radLandscape").attr("checked") == "checked") {

                reportLayout = $('#radLandscape').val();
            }



            if ($("#AscRadio").attr("checked") == "checked") {
                sortOrder = $('#AscRadio').val();
            }
            else if ($("#DescRadio").attr("checked") == "checked") {

                sortOrder = $('#DescRadio').val();
            }

            var ApplyGroup
            if ($("#chkApplyGroup").attr("checked") == "checked") {
                ApplyGroup = 1
            }
            else {
                ApplyGroup = 0
            }
            //   alert(ApplyGroup);

            //   alert(sortOrder);
            FilterCols = filterTable.fnGetData();
            var SelectedCols = colTable.fnGetData();
            var SortByCols = sortTablr.fnGetData();
            var GroupByCols = grpTable.fnGetData();
            // var remember = $("#chkboxRemember").is(":checked");

            //  alert(FilterCols);
            var d = "key=save&nameEn=" + NameEn + "&nameAr=" + NameAr + "&DescriptionEn=" + DescEn + "&DescriptionAr=" + DescAr + "&Category=" + Cat + "&Layout=" + reportLayout + "&SlectedCols=" + SelectedCols + "&SortCols=" + SortByCols + "&SortBy=" + sortOrder + "&Filters=" + FilterCols + "&GroupBy=" + GroupByCols + "&SortOrder=" + sortOrder + "&TableName=" + TableName + "&ApplyGroup=" + ApplyGroup;
            //if ($('.login-form').validate().form() == false) {
            //  return false;
            //}
            //alert(d);
            $(".content").css("cursor", "wait");
            //$(".content").mask("<%=Resources.Resource.processing %>...");
            $.ajax({
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                data: d,
                type: 'POST',
                success: function (chk) {
                    //$(".content").unmask();
                    if (chk == "1") {
                        //alert("SAVED");
                        window.location = '../Reports/ReportWizard.aspx';
                        $(".content").css("cursor", "wait");

                        $("#lblErrorMsg").removeClass("alert-error");
                        $("#lblErrorMsg").addClass("alert-success");
                        $("#lblErrorMsg").removeClass("hide");
                        $("#lblErrorMsg").html("Success: Template Has Been Successfully Saved");
                        $(".content").css("cursor", "pointer");

                    }
                    else if (chk == '0') {
                        $(".content").css("cursor", "pointer");
                        $("#divErrorMsg").css("display", "block");
                        $("#divErrorMsg").html("<%=Resources.Resource.usernameOrPasswordNotMatched %>");
                    }
                    else {
                        $(".content").css("cursor", "pointer");
                        $("#divErrorMsg").css("display", "block");
                        $("#divErrorMsg").html("<%=Resources.Resource.userNotActive %>");
                    }
                },
                error: function () {
                    //$(".content").unmask();
                    $(".content").css("cursor", "pointer");
                    $("#divErrorMsg").css("display", "block");
                    $("#divErrorMsg").html("<%=Resources.Resource.couldNotConnectToServer %>");
                }

            });
        }
    </script>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- BEGIN PAGE CONTAINER-->
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <h3 class="page-title"><%=Resources.Resource.templateWizard %>
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>
                        <span class="icon-angle-right"></span>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.report %></a>
                        <span class="icon-angle-right"></span>
                    </li>
                    <li><a href="#"><%=Resources.Resource.reportWizard %></a></li>
                </ul>
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">
                <div class="portlet box blue" id="form_wizard_1">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-reorder"></i><%=Resources.Resource.reportWizard %> <span class="step-title" id="step"></span>
                        </div>
                        <%-- <div class="tools hidden-phone">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="#portlet-config" data-toggle="modal" class="config"></a>
                           <a href="javascript:;" class="reload"></a>
                           <a href="javascript:;" class="remove"></a>
                        </div>--%>
                    </div>
                    <div class="portlet-body form">
                        <div id="divErrorMsg" class="alert alert-error hide">
                            <span id="spnErrorMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                        </div>
                        <form action="#" class="form-horizontal" id="form_sample_1">
                            <div class="form-wizard">
                                <%--<div onclick="ChangeLang()" style="display: inline; float: <%= pullDirectionStr%>; cursor: pointer;"> <%= Session["changeLanguage"] + "" %></div>
                                --%>

                                <div class="tab-content">
                                    <div class="tab-pane active" id="tab1">

                                        <h3 class="block"><%=Resources.Resource.reportNameAndDesc %></h3>
                                        <label id="lblErrorMsg" class="alert alert-error hide">Please Enter Report Name. * These fields are required</label>
                                        <div class="control-group">

                                            <label class="control-label"><%=Resources.Resource.reportName %></label>
                                            <div class="controls">

                                                <input type="Text" class="span6 m-wrap" id="txtReportNameEn" />

                                                <span class="help-inline">*</span>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.reportNameAr %></label>
                                            <div class="controls">
                                                <input type="Text" class="span6 m-wrap" id="txtReportNameAr" />
                                                <span class="help-inline">*</span>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.reportDescription %></label>
                                            <div class="controls">
                                                <textarea id="txtDescriptionEn" class="span6 m-wrap" rows="3"></textarea>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.reportDescriptionAr %></label>
                                            <div class="controls">
                                                <textarea id="txtDescriptionAr" class="span6 m-wrap" rows="3"></textarea>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="tab-pane" id="tab6">
                                        <div class="control-group">
                                            <h3 class="block"><%=Resources.Resource.reportCategory %></h3>
                                            <br />
                                            <div class="control">
                                                <label class="control-label" style="text-align: left; padding-top: 0px;"><%=Resources.Resource.selectCategory %></label>
                                                <select class="span6 m-wrap" id="selCat" style="margin-right: 20px;">
                                                    <%--<optgroup label="Choose Report Category">
                                                        <option>Time Attendance</option>
                                                        <option>Employee Overtime</option>
                                                        <option>Employee Details</option>
                                                        <option>Security</option>
                                                        <option>Audit</option>
                                                    </optgroup>--%>
                                                </select>
                                            </div>
                                            <br />
                                            <div class="controls" style="margin-left: 0px; margin-right: 0px;">
                                                <label class="control-label" style="text-align: left; padding-top: 0px;"><%=Resources.Resource.selectReportLayout %></label>
                                                <label class="radio" style="margin-left: 25px !important; margin-right: 40px !important;">
                                                    <input type="radio" style="margin-left: -16px;" id="radPotrait" name="radLayout" value="Portrait" checked="checked" /><%=Resources.Resource.potrait %>
                                                </label>
                                                <label class="radio" style="margin-left: 25px !important; margin-right: 25px !important;">
                                                    <input type="radio" style="margin-left: -16px;" id="radLandscape" name="radLayout" value="Landscape" /><%=Resources.Resource.landscape %>
                                                </label>
                                            </div>
                                        </div>




                                    </div>

                                    <div class="tab-pane" id="tab2">
                                        <span style="font-style: italic;"><span style="color: red;">*</span> Employee code and transaction date are mandatory columns for generating the report.</span>
                                        <h3 class="block"><%=Resources.Resource.reportColumns %></h3>
                                        <div style="font-style: italic;">
                                            <span style="font-style: italic; font-weight: bold; text-decoration: underline;">Column Description :</span>
                                            <span class="columnDescription"></span>
                                        </div>
                                        <br />


                                        <div id="Columns">
                                        </div>
                                        <div class="control-group">

                                            <label class="control-label"><%=Resources.Resource.columnName %></label>
                                            <div class="controls">

                                                <input type="Text" class="span6 m-wrap" id="txtColumnName" />


                                            </div>
                                        </div>


                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.columnNameAr %></label>
                                            <div class="controls">
                                                <input type="Text" class="span6 m-wrap" id="txtColumnNameAr" />

                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.IsVisible %></label>
                                            <div class="controls" style="margin-left: 0px;">

                                                <label class="radio" style="margin-left: 40px !important;">
                                                    <input type="radio" style="margin-left: -16px;" id="radYes" name="radIsVisible" value="Yes" checked="checked" /><%=Resources.Resource.yes %>
                                                </label>
                                                <label class="radio" style="margin-left: 25px !important;">
                                                    <input type="radio" style="margin-left: -16px;" id="radNo" name="radIsVisible" value="No" /><%=Resources.Resource.no %>
                                                </label>
                                            </div>

                                        </div>

                                        <div class="control">
                                            <label id="ColsError" class="alert alert-error hide" style="margin-top: 30px; margin-bottom: -40px;">This Column Already Exists! Plese Select Another</label>
                                            <label id="lengthError" class="alert alert-error hide" style="margin-top: 30px; margin-bottom: -40px;"></label>
                                            <button type="button" title="Add" style="margin-left: 0px; margin-bottom: 0px; margin-top: 63px;" id="btnDelCols" class="btn button-submit">Delete</button>
                                            <a href="javascript:;" style="margin-left: 0px; margin-top: 63px;" class="btn green button-submit" id="btnAddCol">
                                                <%=Resources.Resource.add %> <i class="icon-ok"></i>
                                            </a>
                                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tblCols">

                                                <thead>
                                                    <tr>

                                                        <th>Column NameEn</th>
                                                        <th>Column NameAr</th>
                                                        <th>OrignalColumn Name</th>
                                                        <th>Is Visible</th>
                                                        <th>Column Type</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>



                                    </div>

                                    <div class="tab-pane" id="tab3">
                                        <h3 class="block"><%=Resources.Resource.reportWizardSortHeading %></h3>
                                        <div style="font-style: italic;">
                                            <span style="font-style: italic; font-weight: bold; text-decoration: underline;">Column Description :</span>
                                            <span class="columnDescription"></span>
                                        </div>
                                        <div class="control-group">

                                            <div id="SortBy">
                                            </div>

                                            <div class="controls" style="margin-left: 10px; margin-right: 0px;">
                                                <label class="control-label" style="text-align: left; padding-top: 0px;"><%=Resources.Resource.selectReportOrder %></label>

                                                <label class="radio" style="margin-left: 25px !important; margin-right: 40px !important;">
                                                    <input type="radio" style="margin-left: -16px;" id="AscRadio" name="radSort" value="Ascending" checked="checked" /><%=Resources.Resource.ascending %>
                                                </label>
                                                <label class="radio" style="margin-left: 25px !important;">
                                                    <input type="radio" style="margin-left: -16px;" id="DescRadio" name="radSort" value="Descending" /><%=Resources.Resource.descending %>
                                                </label>
                                                <br />
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <div class="control">
                                                <label id="SortError" class="alert alert-error hide" style="margin-top: 30px; margin-bottom: -40px;">This Column Already Exists! Plese Select Another</label>
                                                <button type="button" title="Add" style="margin-left: 0px; margin-bottom: 0px; margin-top: 63px;" id="btnDelSort" class="btn button-submit">Delete</button>
                                                <a href="javascript:;" style="margin-top: 63px;" class="btn green button-submit" id="btnAddSortBy">
                                                    <%=Resources.Resource.add %> <i class="icon-ok"></i>
                                                </a>
                                                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tblSort">

                                                    <thead>
                                                        <tr>

                                                            <th>Column Name</th>
                                                            <th>Column Type</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>


                                        </div>

                                    </div>

                                    <div class="tab-pane" id="tab4">
                                        <span style="font-style: italic;"><span style="color: red;">*</span>For any dropdownlist and group apply select column ”*_code””.</span>
                                        <h3 class="block"><%=Resources.Resource.reportWizardFilterHeading %></h3>
                                        <div style="font-style: italic;">
                                            <span style="font-style: italic; font-weight: bold; text-decoration: underline;">Column Description :</span>
                                            <span class="columnDescription"></span>
                                        </div>
                                        <div id="Filters">
                                        </div>

                                        <div class='control-group'>
                                            <label class='control-label'>Select The Operator</label>
                                            <div class='controls'>
                                                <select id='Operator' class='chosen span6 ' style="width: 100px;" data-placehoder='Select The Operator'>
                                                    <optgroup label='Select the operator'>
                                                        <option>=</option>
                                                        <option><</option>
                                                        <option>></option>
                                                        <option>!=</option>
                                                        <option><=</option>
                                                        <option>>=</option>
                                                        <option>LIKE</option>
                                                        <%-- <option>IS</option>
                                                        <option>IS NOT</option>--%>
                                                    </optgroup>
                                                </select>

                                            </div>


                                        </div>
                                        <div class="control-group">

                                            <label class="control-label"><%=Resources.Resource.columnName %></label>
                                            <div class="controls">

                                                <input type="Text" class="span6 m-wrap" id="FilterName" />


                                            </div>
                                        </div>


                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.columnNameAr %></label>
                                            <div class="controls">
                                                <input type="Text" class="span6 m-wrap" id="FilterNameAr" />

                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.IsVisible %></label>
                                            <div class="controls" style="margin-left: 0px;">

                                                <label class="radio" style="margin-left: 40px !important;">
                                                    <input type="radio" style="margin-left: -16px;" id="radYesFil" checked="checked" name="radIsVisibleDefault" value="Yes" /><%=Resources.Resource.yes %>
                                                </label>
                                                <label class="radio" style="margin-left: 25px !important;">
                                                    <input type="radio" style="margin-left: -16px;" id="radNoFil" name="radIsVisibleDefault" value="No" /><%=Resources.Resource.no %>
                                                </label>
                                            </div>

                                        </div>
                                        <div class="control-group" id="defaultval">
                                            <label class="control-label"><%=Resources.Resource.defaultValues %></label>
                                            <div class="controls">
                                                <input type="Text" class="span6 m-wrap" id="txtDefaultValue" />

                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.groupApply %></label>
                                            <div class="controls" style="margin-left: 0px;">

                                                <label class="checkbox" style="margin-left: 40px !important;">
                                                    <input type="checkbox" style="margin-left: -16px;" id="chkApplyGroup" name="chkApplyGroup" />
                                                </label>
                                            </div>

                                        </div>

                                        <div class='control-group'>
                                            <div class="control">
                                                <%-- <label id="lblError" class="alert alert-error hide" style=" margin-bottom:-40px;" > This Column Already Exists! Plese Select Another</label>
                                          <button type="button" title="DELETE" style=" margin-top:63px;" id="btnDelete" class="btn button-submit">Delete</button>
                                                --%>
                                                <label id="lblError" class="alert alert-error hide" style="margin-top: 30px; margin-bottom: -40px;">This Column Already Exists! Plese Select Another</label>
                                                <button type="button" title="Delete" style="margin-left: 0px; margin-bottom: 0px; margin-top: 63px;" id="btnDelete" class="btn button-submit">Delete</button>
                                                <a href="javascript:;" style="margin-left: 0px; margin-top: 63px" class="btn green button-submit" id="btnAddFilters">
                                                    <%=Resources.Resource.add %> <i class="icon-ok"></i>
                                                </a>
                                                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example">

                                                    <thead>
                                                        <tr>
                                                            <th>Column Name</th>
                                                            <th>Column NameAr</th>
                                                            <th>Column Original Name</th>
                                                            <th>Column Operator</th>
                                                            <th>Is Visible</th>
                                                            <th>Default Value</th>
                                                            <th>Column Type</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane" id="tab5">
                                        <h3 class="block"><%=Resources.Resource.reportWizardGroupHeading %></h3>
                                        <div style="font-style: italic;">
                                            <span style="font-style: italic; font-weight: bold; text-decoration: underline;">Column Description :</span>
                                            <span class="columnDescription"></span>
                                        </div>
                                        <div id="GrpBY">
                                        </div>
                                        <div class="control">
                                            <label id="GroupError" class="alert alert-error hide" style="margin-bottom: -40px;">This Column Already Exists! Plese Select Another</label>
                                            <button type="button" title="Delete" style="margin-left: 0px; margin-bottom: 0px; margin-top: 63px;" id="btnDelGrpBy" class="btn button-submit">Delete</button>
                                            <a href="javascript:;" style="margin-left: 0px; margin-top: 63px" class="btn green button-submit" id="btnAddGroupBy">
                                                <%=Resources.Resource.add %> <i class="icon-ok"></i>
                                            </a>
                                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tblGroupBy">

                                                <thead>
                                                    <tr>

                                                        <th>Column Name</th>

                                                        <th>Column Type</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="form-actions clearfix">
                                        <a href="javascript:;" class="btn button-previous" id="btnBack">
                                            <i class="m-icon-swapleft"></i><%=Resources.Resource.back %> 
                                        </a>
                                        <a href="javascript:;" class="btn blue button-next" id="btnNext">
                                            <%=Resources.Resource.next %> <i class="m-icon-swapright m-icon-white"></i>
                                        </a>
                                        <a href="javascript:;" class="btn button-previous" id="btnCancel">
                                            <%=Resources.Resource.cancel %> 
                                        </a>
                                        <a href="javascript:;" class="btn green button-submit" id="btnSave">
                                            <%=Resources.Resource.save %> <i class="icon-ok"></i>
                                        </a>
                                    </div>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- END PAGE CONTENT-->
    </div>
    <!-- END PAGE CONTAINER-->

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
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

    <script src="../Assets/<%= languageStr %>/Scripts/jquery.loadmask.js"></script>

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="../Assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="../Assets/<%= languageStr %>/scripts/form-wizard.js"></script>

    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>

    <script type="text/javascript" src="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL SCRIPTS -->
    <style type="text/css">
        .dataTables_filter {
            display: none;
        }

        .dataTables_length {
            display: none !important;
        }

        .row_selected {
            background: #0094ff;
        }

            .row_selected td {
                background: #0094ff !important;
            }
    </style>
    <script>
        $(document).ready(function () {
            // initiate layout and plugins
            $('#lblError').addClass('hide');
            $('#btnBack').hide();
            $('#btnSave').hide();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#liRpt").addClass("active");
            $("#liRpt .arrow").addClass("open");
            $("#liDyn").addClass("active");
            $("#liDyn .arrow").addClass("open");
            $("#liTemplateWizard").addClass("active");

            App.init();

            FormWizard.init();
            // $('#step').text("Step 1 of 6 ");


            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

        });

        var z = 0;
        var b = 0;
        var columnsValues = [];
        var sortbyValues = [];
        var filterValues = [];
        var GroupValues = [];
        var sortOrder = "";
        var filterTable;
        var colTable;
        var sortTablr;
        var grpTable;
        var reportLayout = "";
        var category = "";

        /* Init the table */
        filterTable = $('#example').dataTable(
            {
                "bFilter": false,
                //  "bInfo": false,
                "bPaginate": false,
                "bSort": false,

                //'iDisplayLength': 100
            });

        colTable = $('#tblCols').dataTable(
            {
                "bFilter": false,
                //  "bInfo": false,
                "bPaginate": false,
                "bSort": false,

                //'iDisplayLength': 100
            });

        sortTablr = $('#tblSort').dataTable(
            {
                "bFilter": false,
                //  "bInfo": false,
                "bPaginate": false,
                "bSort": false,

                //'iDisplayLength': 100
            });

        grpTable = $('#tblGroupBy').dataTable(
            {
                "bFilter": false,
                //  "bInfo": false,
                "bPaginate": false,
                "bSort": false,

                //'iDisplayLength': 100
            });


        //------------DELETE ROW-----------------

        /* Add a click handler for the delete row */

        $('#btnDelete').click(function () {
            var anSelected = fnGetSelected(filterTable);
            if (anSelected.length !== 0) {
                filterTable.fnDeleteRow(anSelected[0]);
            }
        });


        $('#btnDelCols').click(function () {
            var anSelected = fnGetSelected(colTable);
            if (anSelected.length !== 0) {
                colTable.fnDeleteRow(anSelected[0]);
            }
        });

        $('#btnDelGrpBy').click(function () {
            var anSelected = fnGetSelected(grpTable);
            if (anSelected.length !== 0) {
                grpTable.fnDeleteRow(anSelected[0]);
            }
        });

        $('#btnDelSort').click(function () {
            var anSelected = fnGetSelected(sortTablr);
            if (anSelected.length !== 0) {
                sortTablr.fnDeleteRow(anSelected[0]);
            }
        });


        /* Get the rows which are currently selected */
        function fnGetSelected(oTableLocal) {;
            return oTableLocal.$('tr.row_selected');
        }
        $('#btnBack').click(function () {
            if (z == 1) {
                //alert('v')

                $("#divErrorMsg").css("display", "none");
                $('#tab6').hide();
                $('#tab1').show();
                $('#btnBack').hide();
                z = 0;
            }
            if (z == 2) {

                $('#tab2').hide();
                $('#tab6').show();
                z = 1;

            }
            if (z == 3) {

                $('#tab3').hide();
                $('#tab2').show();
                z = 2;

            }
            if (z == 4) {
                $('#tab4').hide();
                $('#tab3').show();
                z = 3;
            }
            if (z == 5) {
                $('#tab5').hide();
                $('#tab4').show();
                $('#btnSave').hide();
                $('#btnNext').show();
                z = 4;
            }
            if (z == 6) {
                z = 5;
            }
        });
        $('#btnSave').click(function () {

            SaveReportTemplate();
        });

        $('#btnCancel').click(function () {

            window.location.href = '../Reports/TemplateWizard.aspx';

        });
        // -------------- Add Columns in to the Grid --------------


        //-------------ADD FILTERS-----------------


        $('input:radio[name="radIsVisibleDefault"]').change(
          function () {

              if ($(this).val() == 'No') {


                  $('#defaultval').hide();


              }
              else {
                  $('#defaultval').show();
              }

          });

        $('#btnAddFilters').click(function () {
            var ColName = $("#selFilters option:selected").text();  //$('#select2_sample3').selected.val();
            var result = false;
            var ColOps = $("#Operator option:selected").text(); //$('#Operator').val();
            var bData = filterTable.fnGetData();
            var ColNameEn = $("#FilterName").val();
            var ColNameAr = $("#FilterNameAr").val();
            var IsVisiable = 'Yes';
          
            var DefaultValue = $('#txtDefaultValue').val();
            if (DefaultValue == "")
                DefaultValue = 'null';
            if (ColNameAr != '' && ColNameEn != '') {
                if (bData != '') {
                    for (row = 0 ; row < bData.length; row++) {
                        if (bData[row].indexOf(ColName) != -1 && bData[row].indexOf(ColNameEn) != -1) {
                            result = true;
                        }
                    }
                }
                if (result == false) {
                    $('#example').dataTable().fnAddData([
                ColNameEn,
                ColNameAr,
                ColName,
                ColOps,
                IsVisiable,
                DefaultValue,
                 "Filter"
                    ]);
                    $('#FilterName').val("");
                    $('#FilterNameAr').val("");
                    $('#txtDefaultValue').val("");
                    IsVisiable = '';
                    // b++;
                }
                else {

                    $('#lblError').removeClass('hide');

                }
            }
        });
        function getColumnDescription(obj) {
            if ($(obj).val()) {
                value = $(obj).val().trim();
                for (var i = 0; i < columndescrArray.length; i++) {
                    if (columndescrArray[i].col === value) {
                        $(obj).parents('.tab-pane').find('.columnDescription').html(firstToUpperCase(columndescrArray[i].description));
                        break;
                    }
                }
            }
        }
        //--------- ADD COLUMNS --------------------
        $('#btnAddCol').click(function () {
            $('#lengthError').addClass('hide');
            var OrignalColName = $("#select2_sample3 option:selected").text();  //$('#select2_sample3').selected.val();

            var ColNameEn = $('#txtColumnName').val();
            var ColNameAr = $('#txtColumnNameAr').val();
            var IsVisible;
            if (($("#radYes").attr("checked") == "checked")) {
                IsVisible = $('#radYes').val();
            }
            else if (($("#radNo").attr("checked") == "checked")) {
                IsVisible = $('#radNo').val();
            }
           
            var result = false;
            if (ColNameEn != '' && ColNameAr != '') {

                var bData = colTable.fnGetData();
                if (bData.length >= 8 && $("#radPotrait").attr("checked") == "checked") {
                    $('#lengthError').text("Potrait orientation can not have more than 8 columns !");
                    $('#lengthError').removeClass('hide');
                    return;
                }
                else if (bData.length >= 10 && $("#radLandscape").attr("checked") == "checked") {
                    $('#lengthError').text("Landscape orientation can not have more than 10 columns !");
                    $('#lengthError').removeClass('hide');
                    return;
                }

                if (bData != '') {
                    for (row = 0 ; row < bData.length; row++) {
                        if (bData[row].indexOf(OrignalColName) != -1 || bData[row].indexOf(ColNameEn) != -1 || bData[row].indexOf(ColNameAr) != -1) {
                            result = true;
                        }
                    }
                }
                if (result == false) {
                    $('#tblCols').dataTable().fnAddData([

                ColNameEn,
               ColNameAr,
               OrignalColName,
               IsVisible,
                 "Report Column"
                    ]);
                    $('#txtColumnName').val("");
                    $('#txtColumnNameAr').val("");
                    //b++;
                }
                else {

                    $('#ColsError').removeClass('hide');

                }
            }
        });

        //--------END--------

        //-------------ADD GROUP BY COLUMNS ---------

        $('#btnAddGroupBy').click(function () {
            // alert("P");
            var ColName = $("#selGroupBy option:selected").text();  //$('#select2_sample3').selected.val();
            var result = false;
            // var ColOps = $("#Operator option:selected").text(); //$('#Operator').val();
            var bData = grpTable.fnGetData();
            if (bData != '') {
                for (row = 0 ; row < bData.length; row++) {
                    if (bData[row].indexOf(ColName) != -1) {
                        result = true;
                    }
                }
            }
            if (result == false) {
                $('#tblGroupBy').dataTable().fnAddData([

            ColName,

             "Group By"
                ]);
                b++;
            }
            else {

                $('#GroupError').removeClass('hide');

            }
        });

        //------- END

        //--------ADD SORT BY COLUMNS---------

        $('#btnAddSortBy').click(function () {
            var ColName = $("#selSortBy option:selected").text();  //$('#select2_sample3').selected.val();
            var result = false;
            //  var ColOps = $("#Operator option:selected").text(); //$('#Operator').val();
            var bData = sortTablr.fnGetData();
            if (bData != '') {
                for (row = 0 ; row < bData.length; row++) {
                    if (bData[row].indexOf(ColName) != -1) {
                        result = true;
                    }
                }
            }
            if (result == false) {
                $('#tblSort').dataTable().fnAddData([

            ColName,
            "Sort By"
                ]);
                b++;
            }
            else {

                $('#SortError').removeClass('hide');

            }
        });
        // --------------------END OF ADD --------------


        //----------- Hide Error ----------------

        $('#selFilters').live("change", function () {
            $('#lblError').addClass('hide');
            getColumnDescription($(this));
        });

        $('#select2_sample3').live("change", function () {
            $('#ColsError').addClass('hide');
            getColumnDescription($(this));
        });
      
        $('#selGroupBy').live("change", function () {
            getColumnDescription($(this));

            $('#GroupError').addClass('hide');
        });

        $('#selSortBy').live("change", function () {
            getColumnDescription($(this));

            $('#SortError').addClass('hide');
        });
        $('#txtReportNameEn').live("focus", function () {
            $('#lblErrorMsg').addClass('hide');
        });
        $('#txtReportNameAr').live("focus", function () {
            $('#lblErrorMsg').addClass('hide');
        });
        //----------END---------------

        //--------- GET THE SELECTED ROWS ------------

        $('#example tbody tr').live("click", function () {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
            }
            else {
                filterTable.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }
        });

        $('#tblCols tbody tr').live("click", function () {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
            }
            else {
                colTable.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }
        });
        $('#tblSort tbody tr').live("click", function () {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
            }
            else {
                sortTablr.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }
        });
        $('#tblGroupBy tbody tr').live("click", function () {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
            }
            else {
                grpTable.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }
        });

        //------------------END ---------------------------

        //---------------NEXT BUTTON CLICK EVENTS ---------------
        $('#btnNext').click(function () {


            if (z == 0) {

                if ($('#txtReportNameEn').val() != '' && $('#txtReportNameAr').val() != '') {
                    $('#tab1').hide();
                    $('#tab6').show();
                    $('#btnBack').show();
                    LoadTableName();
                    z = 1;
                }
                else {

                    $('#lblErrorMsg').removeClass('hide');
                }
            }
            else if (z == 1) {


                TableName = $("#selCat option:selected").val();
                // alert(TableName);

                if (TableName == "") {
                    //  alert('Im in');
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.selectCategory %>");
                    return;
                }
                else {

                    $("#divErrorMsg").css("display", "none");
                    $('#tab6').hide();
                    $('#tab2').show();
                    $('#btnBack').show();
                    var action = "Columns";

                    LoadColumns(action);
                    z = 2;
                }

            }
            else if (z == 2) {
                if (colTable.fnGetData() != "") {
                    $('#tab2').hide();
                    $('#tab3').show();

                    var action = "SortBy";
                    LoadColumns(action);
                    z = 3;
                }
                else {
                    $('#ColsError').html("Select Atleast One Column For Report");
                    $('#ColsError').removeClass('hide');

                }
            }
            else if (z == 3) {

                $('#tab3').hide();
                $('#tab4').show();
                var action = "Filters";
                LoadColumns(action);
                z = 4;
            }
            else if (z == 4) {

                $('#tab4').hide();
                $('#tab5').show();
                var action = "GroupBy";
                LoadColumns(action);
                $("#btnSave").show();
                $("#btnNext").hide();
                z = 5;
            }
            //else if (z ==  5) {

            //    $('#selGroupBy :selected').each(function () {
            //        GroupValues.push($(this).val());
            //    });
            //    jQuery("#btnSave").show();
            //    i = 6;
            //}
        });


    function LoadTableName() {
        var d = "key=getTableNameListString";
        //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
        $.ajax({
            type: 'POST',
            data: d,
            url: '<%= Page.ResolveClientUrl("~/RequestPages/ReportTemplatePage.aspx") %>',
            success: function (html) {
                $("#selCat").html(html);
                $("#selCat").trigger("liszt:updated");
                //$("#form_sample_1").unmask();
            },
            error: function (html) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
        });
    }

    </script>
</asp:Content>
