<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewSchedules.aspx.cs" Inherits="TAMSR2.Details.ViewSchedules" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.schedules %> - <%=Resources.Resource.applicationName %></title>

    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
    <!-- END PAGE LEVEL STYLES -->

    <style>
        #sample_1 thead th, #sample_id tbody td
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
                                    <label class="control-label"><%=Resources.Resource.employee %><span class="required">*</span></label>
                                    <div class="controls">
                                        <select id="ddBorrowEmp" name="borrowEmp" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
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
                                    <label class="control-label"><%=Resources.Resource.remarks %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="text" id="txtBorrowRemarks" name="remarks" data-required="1" class="span6 m-wrap" />
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button id="btnSaveBorrow" type="button" onclick="SaveBorrow()" class="btn purple"><%=Resources.Resource.save %></button>
                                    <button type="button" onclick="ClosePopup()" class="btn"><%=Resources.Resource.cancel %></button>
                                    <button type="reset" id="btnCloseForm" style="display: none;" data-dismiss="modal" class="btn"><%=Resources.Resource.close %></button>
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
                    <%=Resources.Resource.schedules %> 
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
                    <li><a href="#"><%=Resources.Resource.schedules %></a></li>

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
                                <label class="control-label"><%=Resources.Resource.group %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddEmpGroup" name="ddgroup" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.group %>">
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
                                <label class="control-label"><%=Resources.Resource.employee %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddEmp" name="employee" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                </form>
                <!-- END FORM-->

        <div id="divLabel" style="font-weight: bold; padding: 5px 0px;">
            &nbsp;
        </div>

                <!-- END FORM-->
                <div style="min-height: 20px; clear: both;">&nbsp;</div>
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.schedules %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return LoadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="Span3">&nbsp;</span>
                            </div>
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="spnAddButton" runat="server">
                                    <a id="btnAdd" onclick="return AddSchedule()" href="javascript:void(0);" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                </span>
                                <span id="spnDeleteButton" runat="server">
                                    <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                </span>
                            </div>
                        </div>
                        <div style="width: 100%; overflow: scroll; overflow-y: hidden; padding: 20px 0px;">
                            <table class="table table-striped table-bordered table-hover" id="sample_1">
                                <thead>
                              <tr style="background-color: #e8e3e3;">
                                 <th style="text-align: center;width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                 <th style="text-align: center;"><%=Resources.Resource.fromDate %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.toDate %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.sunday %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.monday %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.tuesday %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.wednesday %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.thursday %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.friday %></th>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.saturday %></th>
                                 <th style="text-align: center;width: 24px !important;">&nbsp;</th>
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

                <div style="min-height: 20px; clear: both;">&nbsp;</div>

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
                    </div>
                </div>

                <div style="min-height: 20px; clear: both;">&nbsp;</div>
                <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>

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
            
            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liSch").addClass("active");
            $("#liSch .arrow").addClass("open");
            $("#liSchedule").addClass("active");
            $("#liSchedule .arrow").addClass("open");
            $("#liSchedules").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

            LoadOrganizations();

            $("#ddOrg").change(function () {
                LoadEmployees();
                GetLabel();
                LoadGrid();
            });

            $("#ddEmp").change(function () {
                GetLabel();
                LoadGrid();
            });

            $("#ddEmpGroup").change(function () {
                GetLabel();
                LoadEmployees();
                LoadGrid();
            });
            

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
                if (name == "TAMSR2_Schedules") {
                    LoadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Schedules', '');
                    // Clear text box and reset focus for next comment. 
                });
            });
        });

        function LoadOrganizations() {
            var d = "key=getIdNameListString";
            $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   $("#form_sample_1").unmask();
                   $("#ddOrg").html(html);
                   if ('<%= Session["orgID"] %>' == '') {
                       $('#ddOrg option[value=<%= Session["orgID"] %>]').attr('selected', 'selected');
                   }
                   else {
                       $("#ddOrg").val($("#ddOrg option:eq(1)").val());
                   }
                   $("#ddOrg").trigger("liszt:updated");
                   GetLabel();
                   LoadGroups();
                   LoadGrid();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#form_sample_1").unmask();
               }
           });
       }

       function LoadEmployees() {
           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg").css("display", "none");

           var d = "key=getIdNameListWithDept&orgID=" + $("#ddOrg").val() + "&groupID=" + $("#ddEmpGroup").val();
           
           $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   $("#form_sample_1").unmask();
                   $("#ddEmp").html(html);
                   $("#ddEmp").trigger("liszt:updated");
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#form_sample_1").unmask();
               }
           });
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
                    LoadEmployees();
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#form_sample_1").unmask();
               }
            });
        }

        function GetLabel() {
            //$("#divLabel").html("");
            if ($("#ddOrg").val() == "" && $("#ddEmpGroup").val() == "" && $("#ddEmp").val() == "")
                return;
            var d = 'key=getLabel&orgID=' + $('#ddOrg').val() + '&empID=' + $('#ddEmp').val() + '&groupID=' + $('#ddEmpGroup').val();
            $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/SchedulePage.aspx") %>',
                success: function (html) {
                    $("#form_sample_1").unmask();
                    $("#divLabel").html(html);
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    $("#form_sample_1").unmask();
                }
            });
        }

        function LoadGrid() {
            if($("#ddOrg").val() == "" && $("#ddEmpGroup").val() == "" && $("#ddEmp").val() == "")
                return;
            var urlStr = '<%= Page.ResolveClientUrl("../RequestPages/SchedulePage.aspx?key=getAll") %>' + '&orgID=' + $("#ddOrg").val() + '&groupID=' + $("#ddEmpGroup").val() + '&empID=' + $("#ddEmp").val();
            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
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
               "sAjaxSource": urlStr
           });
        }

        function AddSchedule() {

            $("#divErrorMsg").css("display", "none");
            $("#divSuccessMsg").css("display", "none");

            var orgID = $("#ddOrg").val();
            var empID = $("#ddEmp").val();
            var groupID = $("#ddEmpGroup").val();
            var urlStr = '<%= Page.ResolveClientUrl("~/Sch/Save-Schedule") %>';

            if (orgID == "" && groupID == "" && empID == "") {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
                return false;
            }

            if (orgID == "")
                orgID = "-1";
            if (empID == "")
                empID = "0";
            if (groupID == "")
                groupID = "0";

            urlStr += '/' + 0 + '/' + orgID + '/' + empID + '/' + groupID;
            window.location = urlStr;
        }

        function Edit(id) {
            var orgID = $("#ddOrg").val();
            var empID = $("#ddEmp").val();
            var groupID = $("#ddEmpGroup").val();
            var urlStr = '<%= Page.ResolveClientUrl("~/Sch/Save-Schedule") %>';
            if (orgID == "")
                orgID = "-1";
            if (empID == "")
                empID = "0";
            if (groupID == "")
                groupID = "-1";
            urlStr += '/' + id + '/' + orgID + '/' + empID + '/' + groupID;
            window.location = urlStr;
        }

        function Delete() {
            var orgID = $("#ddOrg").val();
            var empID = $("#ddEmp").val();
            var groupID = $("#ddEmpGroup").val();
            var v = "key=deleteByID" + '&orgID=' + orgID + '&empID=' + empID + '&groupID=' + groupID + '&';

            $("#divSuccessMsg").css("display", "none");
            $("#divErrorMsg").css("display", "none");

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
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
               return;
           }
           if (confirm("<%=Resources.Resource.deleteMessage %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/SchedulePage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg").css("display", "block");
                           $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordDelete %>");
                           $('#btnBroadCast').click();
                       }
                       else {
                           $("#divErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotDelete %>");
                       }
                   },
                   error: function (html) {

                   }
               });
           }
           else {
           }
       }
    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
