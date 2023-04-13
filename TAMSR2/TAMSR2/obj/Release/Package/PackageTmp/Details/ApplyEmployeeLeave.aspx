<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApplyEmployeeLeave.aspx.cs" Inherits="TAMSR2.Details.ApplyEmployeeLeave" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.employeeLeaves %> - <%=Resources.Resource.applicationName %></title>
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
                    <%=Resources.Resource.employeeLeaves %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.employee %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href='<%= Page.ResolveClientUrl("~/Leaves/Employee-Leaves") %>'><%=Resources.Resource.employeeLeaves %></a></li>

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
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.employee %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddEmployee" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="emp" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.leave %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddLeave" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="leave" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.leave %>" tabindex="1">  <%--onchange="LoadSubLeaveList(); LoadGetLeaveDetails('leave');"--%>
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <div class="row-fluid">
                         <div class="span6 SubTypeLeaveBox">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.leaveSubType %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddSubTypeLeave" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="leave" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.leave %>" tabindex="1" onchange="LoadGetLeaveDetails('subtypeleave');">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>                         
                        <div class="span6 leaveAttachmentBox">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.attachement %></label>
                                <div class="controls chzn-controls">
                                    <input type="file" id="leaveAttachment" accept="application/pdf,.jpeg,.jpg,.png,.ost,.pst,.eml,.txt,.msg" name="leaveAttachment" />
                                </div>
                            </div>
                        </div>
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
                    <div class="row-fluid">
                        <div class="span6">
                            <div class="control-group">
                                <label class="control-label lblRemarks"><%=Resources.Resource.remarks %></label>
                                <div class="controls">
                                    <input type="text" id="txtRemarks" name="code" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6">
                            <% if (new TAMSR2.ObjectClasses.DBAppSetting().GetAutoLeaveApproval(Session["ID"] + "", TAMSR2.CustomClasses.Connection.GetUserConnectionStrinng()) == false) { 
                                %> 
                            <div id="divApproveReject" class="control-group" style="display: none;">
                                <label class="control-label">&nbsp;</label>
                                <div class="controls">
                                    <input id="chkboxApproveReject" type="checkbox" name="approveReject" checked/>
                                    <%=Resources.Resource.approve %>
                                </div>
                            </div>
                            <%   
                               } %>                            
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
            <span id="spnEmpLv">0</span>&nbsp;
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
       var allowAttachementLeave = false;
       var extension = "";

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
            $("#liEmpLeave").addClass("active");

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
                if (name == "TAMSR2_Emp_Leaves") {
                    //ReloadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Emp_Leaves', '');
                    // Clear text box and reset focus for next comment. 
                });
            });

            LoadEmployeeList();
            LoadLeaveList();

            $('.leaveAttachmentBox').hide();
             $(".SubTypeLeaveBox").hide();


        });
        var leaveAttachment = document.getElementById("leaveAttachment");
         leaveAttachment.onchange = function (e) {
                $('#divErrorMsg').addClass('hide');
                $('#divSuccessMsg').addClass('hide');
                $('#divInfoMsg').addClass('hide');
                e.stopPropagation(); // Stop stuff happening
                e.preventDefault(); // Totally stop stuff happening
                //msgErrorFileSize
                var ext = this.value.match(/\.(.+)$/)[1];
                extension = ext;
                debugger;
                switch (ext.toLowerCase()) {
                    case 'pdf':
                    case 'PDF':
                    case 'jpeg':
                    case 'jpg':
                    case 'png':
                    case 'JPEG':
                    case 'JPG':
                    case 'PNG':
                    case 'PST':
                    case 'pst':
                    case 'OST':
                    case 'ost':
                    case 'EML':
                    case 'eml':
                    case 'TXT':
                    case 'txt':
                    case 'MSG':
                    case 'msg':
                        break;
                    default:
                        $('#spnErrorMsg').html("<%=Resources.Resource.msgWrongFileError %>");
                        $('#divMsgError').removeClass('hide');
                        this.value = '';
                }
            };

        function LoadEmployeeList() {
            var d = "key=getIdNameListWithDept";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
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
                    var empLv = $('#spnEmpLv').text();
                    if (empLv != "" && tempLeave == true) {
                        Edit(empLv);
                    }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadLeaveList() {
            var d = "key=getIdNameParentListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/LeavePage.aspx") %>',
                success: function (html) {
                    $("#ddLeave").html(html);
                    $("#ddLeave").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    tempLeave = true;
                    var empLv = $('#spnEmpLv').text();
                    if (empLv != "" && tempEmp == true) {
                        Edit(empLv);
                    }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadSubLeaveList() {
            var parentId = $("#ddLeave").val();
            if (parseInt(parentId) > 0) {
                var d = "key=getIdNameChildListString&parentID=" + parentId;
                ("<%=Resources.Resource.processing %>" + "....");
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/LeavePage.aspx") %>',
                    success: function (html) {
                        debugger
                        if (html != "") {
                            $(".SubTypeLeaveBox").show();
                            $("#ddSubTypeLeave").html(html);
                            $("#ddSubTypeLeave").trigger("liszt:updated");
                            tempLeave = true;
                            var empLv = $('#spnEmpLv').text();
                            if (empLv != "" && tempEmp == true) {
                                Edit(empLv);
                            }
                        }
                        else {
                            $(".SubTypeLeaveBox").hide();

                        }

                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                        //$("#form_sample_1").unmask();
                    }
                });
            }
            else {
                       $("#ddSubTypeLeave").html("");
                        $("#ddSubTypeLeave").trigger("liszt:updated");
            }
        }

        function LoadGetLeaveDetails(type) {
            var parentId = "0";
            if (type == "leave") {
                parentId = $("#ddLeave").val();
            }
            if (type == "subtypeleave") {
                parentId = $("#ddSubTypeLeave").val();
            }
            if (parseInt(parentId) > 0) {
                var d = "key=getByID&id="+ parentId;
                ("<%=Resources.Resource.processing %>" + "....");
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/LeavePage.aspx") %>',
                    success: function (html) {
                        if (html != "") {
                            var j = $.parseJSON(html);
                            if (j.IsCommentMandatory) {
                                $('#txtRemarks').attr('required', 'required');
                            }

                            if (j.AllowAttachement == "1") {
                                $('#spnInfoMsg').html("<%= Resources.Resource.limitFileUpload %>");
                                $('#divInfoMsg').removeClass('hide');
                                //$('#leaveAttachmentBox').removeClass('hide');
                                $('.leaveAttachmentBox').show();
                                allowAttachementLeave = true;
                            }
                            else {
                                //$('#leaveAttachmentBox').addClass('hide');
                                                          $('.leaveAttachmentBox').hide();
                                allowAttachementLeave = false;
                            }   
                        }
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                        //$("#form_sample_1").unmask();
                    }
                });
            }
        }

        function CloseForm() {
            window.location = '<%= Page.ResolveClientUrl("~/Leaves/Employee-Leaves") %>';
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
            $("#txtDescriptionEn").val("");
            $("#txtDescriptionAr").val("");
            $("#txtFromDate").val("");
            $("#txtToDate").val("");
            $("#txtRemarks").val("");

            $("#chkboxApproveReject").removeAttr("checked");
            $("#uniform-chkboxApproveReject span").removeClass("checked");

            $('#ddEmployee option[value=""]').attr('selected', 'selected');
            $("#ddEmployee").trigger("liszt:updated");

            if ('<%= Session["ID"] + "" %>' == $('#ddEmployee').val() || $('#ddEmployee').val() == "") {
                $('#divApproveReject').css('display', 'none');
            }
            else {
                $('#divApproveReject').css('display', 'inline');
            }
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
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeLeavePage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);
                        $("#spnID").val(j.ID);
                        if (j.ID == "0") {
                            $("#spnID").html(j.ID);
                            return;
                        }
                        $("#txtFromDate").val(j.FromDateStr);
                        $("#txtToDate").val(j.ToDateStr);
                        $("#txtRemarks").val(j.Remarks);
                        $('#ddEmployee option[value=' + j.EmployeeID + ']').attr('selected', 'selected');
                        $("#ddEmployee").trigger("liszt:updated");
                        $('#ddLeave option[value=' + j.LeaveID + ']').attr('selected', 'selected');
                        $("#ddLeave").trigger("liszt:updated"); 
                        $('#ddSubTypeLeave option[value=' + j.SubTypeLeaveId + ']').attr('selected', 'selected');
                        $("#ddSubTypeLeave").trigger("liszt:updated");
                        if (j.ApproveRejectFlag + "" == "1") {
                            $("#chkboxApproveReject").attr("checked", "checked");
                            $("#uniform-chkboxApproveReject span").addClass("checked");
                        }

                    }
                },
                error: function (html) {

                }
            });
        }
        
       
        function Save() {
            
            $("#divSuccessMsg").css("display", "none");
            $("#divErrorMsg").css("display", "none");

            var id = $('#spnEmpLv').text();
            var empID = $("#ddEmployee").val();

            var fromDate = $("#txtFromDate").val();
            var toDate = $("#txtToDate").val();
            var remarks = $("#txtRemarks").val();
            var approve = $("#chkboxApproveReject").is(":checked");
            var leaveID = $('#ddLeave').val();
            //var subLeaveID = $("#ddSubTypeLeave").val();

            //if (parseInt(subLeaveID) > 0) {
            //    leaveID = $("#ddSubTypeLeave").val();
            //}
            //else {
            //    leaveID = $("#ddLeave").val();
            //}

            var data = new FormData();
            if (allowAttachementLeave == true) {
                
                if ($('#leaveAttachment')[0].files.length == 0) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.lblRequired %>" + "." + "<%=Resources.Resource.attachment %>");
                    return;
                }

                var filesObject = $('#leaveAttachment');
                var fileSize = filesObject[0].size;

                var files = filesObject[0].files;
                var sizeInMB = ($('#leaveAttachment')[0].files[0].size / (1024 * 1024));

                if (sizeInMB > 11.0) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%= String.Format(Resources.Resource.msgErrorFileSize,"10 MB.") %>");
                    $('#leaveAttachment').val('');
                    return;
                }
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);
                }
            }


            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }

            var url = '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeLeavePage.aspx") %>';


            var v = "key=save" + "&id=" + id + "&empID=" + empID + "&leaveID=" + leaveID + "&fromDate=" + fromDate + "&toDate=" + toDate;
            v += "&remarks=" + remarks + "&approve=" + approve + "&AllowAttachement=" + allowAttachementLeave + "&extension=" + extension;

            url = url + "?" + v;

            $("#form_sample_1").attr("disabled", "disabled");
            $("#btnSave").attr("disabled", "disabled");
            $.ajax({
                type: 'POST',
                data: data,
                url: url,
                contentType: false,
                processData: false,
                success: function (html) {
                    $("#form_sample_1").removeAttr("disabled");
                    $("#btnSave").removeAttr("disabled");
                    if (html == '-4') {

                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgMonthAlreadyClosed %>");
                    }
                    else if (html == '-1') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                    }
                    else if (html == '-3') {
                        //exists
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgErrorDateRange %>");
                    }
                    else if (html == '0') {
                        //exists
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                    }
                    else {
                        debugger
                        //success
                        $("#divSuccessMsg").css("display", "block");
                        $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                        $('#btnBroadCast').click();
                        if ($('#spnEmpLv').text() + "" != "" && $('#spnEmpLv').text() + "" != "MA==") {
                            window.location = '<%= Page.ResolveClientUrl("~/Leaves/Employee-Leaves") %>';
                    }
                    Clear();
                    LoadEmployeeList();
                }
                },
                error: function (html) {
                    $("#form_sample_1").removeAttr("disabled");
                    $("#btnSave").removeAttr("disabled");
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
            $('.date-picker').datepicker({ format: 'yyyy-mm-dd' });
        }

        if (jQuery().timepicker) {
            $('.timepicker-default').timepicker();
            $('.timepicker-24').timepicker({
                minuteStep: 1,
                showSeconds: true,
                showMeridian: false
            });
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

        $("#txtFrom").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
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
                    leave: {
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
