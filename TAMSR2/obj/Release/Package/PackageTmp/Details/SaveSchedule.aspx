<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveSchedule.aspx.cs" Inherits="TAMSR2.Details.SaveSchedule" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.schedules %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <!-- END PAGE LEVEL STYLES -->
    <link href="<%= path %>Styles/jquery.loadmask.css" rel="stylesheet" />

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
                    <li><a href='<%= Page.ResolveClientUrl("~/Sch/Schedules") %>'><%=Resources.Resource.schedules %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->

        <div id="divLabel" style="font-weight: bold; padding: 5px 0px;">
            &nbsp;
        </div>

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
                                <label class="control-label"><%=Resources.Resource.fromDate %><span class="required">*</span> </label>
                                <div class="controls">
                                    <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.toDate %> </label>
                                <div class="controls">
                                    <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.schedule %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddSchedule" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="schedule" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.sunday %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddSunday" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="sunday" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
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
                                <label class="control-label"><%=Resources.Resource.monday %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddMonday" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="monday" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.tuesday %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddTuesday" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="tuesday" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
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
                                <label class="control-label"><%=Resources.Resource.wednesday %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddWednesday" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="wednesday" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.thursday %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddThursday" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="thursday" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
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
                                <label class="control-label"><%=Resources.Resource.friday %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddFriday" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="friday" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.saturday %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddSaturday" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="saturday" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
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
    <script src="<%= path %>Scripts/jquery.loadmask.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">
        var tempOrg = false;
        var tempGroup = false;
        var tempEmp = false;

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
            $("#liSchedule").addClass("active");
            $("#liSchedule .arrow").addClass("open");
            $("#liSchedules").addClass("active");

            GetLabel();

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
            
            $("#ddSchedule").change(function () {
                ChangeSchedules();
                var id = $('#spnSch').text() + "";
                if (id != "" && id != "0") {
                    Edit('yes');
                }
            });


            //$("#txtFromDate").change(function () {
            //    LoadScheduleTimeList();
            //    var id = $('#spnSch').text() + "";
            //    if (id != "" && id != "0") {
            //        Edit('yes');
            //    }
            //});
             
            // Declare a proxy to reference the hub. 
            var users = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            users.client.broadcastMessage = function (name, message) {
                if (name == "TAMSR2_Schedules") {
                    
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

            LoadScheduleTimeList();

            var id = $('#spnSch').text() + "";
            if (id != "" && id != "0") {
                Edit();
            }
            if ($('#spnOrg').text() + "" == 1 && $('#spnGroup').text() + "" == "0" && $('#spnEmp').text() + "" == "0") {
                $("#txtToDate").attr("disabled", true);
            }
        });

        function GetLabel() {
            $("#divLabel").html("");
            var d = 'key=getLabel&orgID=' + $('#spnOrg').text() + '&empID=' + $('#spnEmp').text() + '&groupID=' + $('#spnGroup').text();
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/SchedulePage.aspx") %>',
                success: function (html) {
                    $("#divLabel").html(html);
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

        function LoadScheduleTimeList() {
            var dt = $('#txtFromDate').val();
            var res = dt.split("-");
            dt = res[2] + '-' + res[1] + '-' + res[0];
            var d = "key=getIdNameListString&dt=" + dt;
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ScheduleTimePage.aspx") %>',
                success: function (html) { 
                    $("#ddSchedule").html(html);
                    $("#ddSchedule").trigger("liszt:updated");
                    $("#ddSunday").html(html);
                    $("#ddSunday").trigger("liszt:updated");
                    $("#ddMonday").html(html);
                    $("#ddMonday").trigger("liszt:updated");
                    $("#ddTuesday").html(html);
                    $("#ddTuesday").trigger("liszt:updated");
                    $("#ddWednesday").html(html);
                    $("#ddWednesday").trigger("liszt:updated");
                    $("#ddThursday").html(html);
                    $("#ddThursday").trigger("liszt:updated");
                    $("#ddFriday").html(html);
                    $("#ddFriday").trigger("liszt:updated");
                    $("#ddSaturday").html(html);
                    $("#ddSaturday").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");                    
                }
            });
        }

        function ChangeSchedules() {
            var v = "key=getRestDays";
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/AppSettingPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);

                        if (j.Sunday == 0)
                            $('#ddSunday option[value="' + $("#ddSchedule").val() + '"]').attr('selected', 'selected');
                        else
                            $('#ddSunday option[value=""]').attr('selected', 'selected');
                        $("#ddSunday").trigger("liszt:updated");
                        if (j.Monday == 0)
                            $('#ddMonday option[value="' + $("#ddSchedule").val() + '"]').attr('selected', 'selected');
                        else
                            $('#ddMonday option[value=""]').attr('selected', 'selected');
                        $("#ddMonday").trigger("liszt:updated");
                        if (j.Tuesday == 0)
                            $('#ddTuesday option[value="' + $("#ddSchedule").val() + '"]').attr('selected', 'selected');
                        else
                            $('#ddTuesday option[value=""]').attr('selected', 'selected');
                        $("#ddTuesday").trigger("liszt:updated");
                        if (j.Wednesday == 0)
                            $('#ddWednesday option[value="' + $("#ddSchedule").val() + '"]').attr('selected', 'selected');
                        else
                            $('#ddWednesday option[value=""]').attr('selected', 'selected');
                        $("#ddWednesday").trigger("liszt:updated");
                        if (j.Thursday == 0)
                            $('#ddThursday option[value="' + $("#ddSchedule").val() + '"]').attr('selected', 'selected');
                        else
                            $('#ddThursday option[value=""]').attr('selected', 'selected');
                        $("#ddThursday").trigger("liszt:updated");
                        if (j.Friday == 0)
                            $('#ddFriday option[value="' + $("#ddSchedule").val() + '"]').attr('selected', 'selected');
                        else
                            $('#ddFriday option[value=""]').attr('selected', 'selected');
                        $("#ddFriday").trigger("liszt:updated");
                        if (j.Saturday == 0)
                            $('#ddSaturday option[value="' + $("#ddSchedule").val() + '"]').attr('selected', 'selected');
                        else
                            $('#ddSaturday option[value=""]').attr('selected', 'selected');
                        $("#ddSaturday").trigger("liszt:updated");

                    }
                },
                error: function (html) {

                }
            });
        }

        function CloseForm() {
            Clear();
            window.location = '<%= Page.ResolveClientUrl("~/Sch/Schedules") %>';
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

            $("#txtFromDate").val("");
            $("#txtToDate").val("");
            
            $('#ddSchedule option[value=""]').attr('selected', 'selected');
            $("#ddSchedule").trigger("liszt:updated");
            $('#ddSunday option[value=""]').attr('selected', 'selected');
            $("#ddSunday").trigger("liszt:updated");
            $('#ddMonday option[value=""]').attr('selected', 'selected');
            $("#ddMonday").trigger("liszt:updated");
            $('#ddTuesday option[value=""]').attr('selected', 'selected');
            $("#ddTuesday").trigger("liszt:updated");
            $('#ddWednesday option[value=""]').attr('selected', 'selected');
            $("#ddWednesday").trigger("liszt:updated");
            $('#ddThursday option[value=""]').attr('selected', 'selected');
            $("#ddThursday").trigger("liszt:updated");
            $('#ddFriday option[value=""]').attr('selected', 'selected');
            $("#ddFriday").trigger("liszt:updated");
            $('#ddSaturday option[value=""]').attr('selected', 'selected');
            $("#ddSaturday").trigger("liszt:updated");
            //$("#txtCategory").val("");
            //$("#txtService").val("");
        }

        function Edit(reload) {
            var id = $('#spnSch').text() + "";
            var orgID = $("#spnOrg").text() + "";
            var groupID = $("#spnGroup").text() + "";
            var empID = $("#spnEmp").text() + "";
            var v = "key=getByID&id=" + id + "&orgID=" + orgID + "&groupID=" + groupID + "&empID=" + empID;
            $("#spnGridMsg").html("&nbsp;");
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/SchedulePage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);
                        if (j.FromDateStr != '' && reload !='yes') { 

                            $("#txtFromDate").val( j.FromDateStr); 
                        } 
                        if (j.ToDateStr != '' && reload != 'yes') {
                            $("#txtToDate").val(j.ToDateStr); 
                        } 

                        $('#ddSchedule option[value="' + j.Sunday + '"]').attr('selected', 'selected');
                        $("#ddSchedule").trigger("liszt:updated");
                        $('#ddSunday option[value="' + j.Sunday + '"]').attr('selected', 'selected');
                        $("#ddSunday").trigger("liszt:updated");
                        $('#ddMonday option[value="' + j.Monday + '"]').attr('selected', 'selected');
                        $("#ddMonday").trigger("liszt:updated");
                        $('#ddTuesday option[value="' + j.Tuesday + '"]').attr('selected', 'selected');
                        $("#ddTuesday").trigger("liszt:updated");
                        $('#ddWednesday option[value="' + j.Wednesday + '"]').attr('selected', 'selected');
                        $("#ddWednesday").trigger("liszt:updated");
                        $('#ddThursday option[value="' + j.Thursday + '"]').attr('selected', 'selected');
                        $("#ddThursday").trigger("liszt:updated");
                        $('#ddFriday option[value="' + j.Friday + '"]').attr('selected', 'selected');
                        $("#ddFriday").trigger("liszt:updated");
                        $('#ddSaturday option[value="' + j.Saturday + '"]').attr('selected', 'selected');
                        $("#ddSaturday").trigger("liszt:updated");
                    }
                },
                error: function (html) {

                }
            });
        }

        function Save() {

            $("#divSuccessMsg2").css("display", "none");
            $("#divErrorMsg2").css("display", "none");

            var id = $('#spnSch').text() + "";
            var orgID = $("#spnOrg").text() + "";
            var groupID = $("#spnGroup").text() + "";
            var empID = $("#spnEmp").text() + "";
            var sunday = $("#ddSunday").val();
            var monday = $("#ddMonday").val();
            var tuesday = $("#ddTuesday").val();
            var wednesday = $("#ddWednesday").val();
            var thursday = $("#ddThursday").val();
            var friday = $("#ddFriday").val();
            var saturday = $("#ddSaturday").val();

            //var fromDate = $("#txtFromDate").val();
            //var toDate = $("#txtToDate").val();
            
            var str1 = $('#txtFromDate').val();
            var dt1 = "";
            var mon1 = "";
            var yr1 = "";
            var hh1 = "";
            var mm1 = "";
            var fromDate = "";
            if (str1.indexOf('-') > 0) {
                yr1 = str1.substring(6, 10);
                mon1 = str1.substring(3, 5);
                dt1 = str1.substring(0, 2);
            }
            else {
                yr1 = str1.substring(4, 8);
                mon1 = str1.substring(2, 4);
                dt1 = str1.substring(0, 2);
            }
            fromDate = yr1 + "-" + mon1 + "-" + dt1;

            var str2 = $('#txtToDate').val();
            var dt2 = "";
            var mon2 = "";
            var yr2 = "";
            var hh2 = "";
            var mm2 = "";
            var toDate = "";

            if (str2.indexOf('-') > 0) {
                yr2 = str2.substring(6, 10);
                mon2 = str2.substring(4, 5);
                dt2 = str2.substring(0, 2);
            }
            else {
                yr2 = str2.substring(4, 8);
                mon2 = str2.substring(2, 4);
                dt2 = str2.substring(0, 2);
            }
            toDate = yr2 + "-" + mon2 + "-" + dt2; 

            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }

            $("#divErrorMsg").css("display", "none");
            $("#divSuccessMsg").css("display", "none");

            if (new Date(yr1, mon1, dt1) > new Date(yr2, mon2, dt2) && orgID != "1") {
                //failed
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgErrorDateRange %>");
                return;
            }


            var v = "key=save" + "&id=" + id + "&orgID=" + orgID + "&groupID=" + groupID + "&empID=" + empID;
            v += "&fromDate=" + fromDate + "&toDate=" + toDate + "&sunday=" + sunday + "&monday=" + monday;
            v += "&tuesday=" + tuesday + "&wednesday=" + wednesday + "&thursday=" + thursday + "&friday=" + friday;
            v += "&saturday=" + saturday;

            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/SchedulePage.aspx") %>',
                success: function (html) {
                    if (html == '-3') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgFromAndToTimeRequired %>");
                    }
                    else if (html == '-2') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                    }
                    else if (html == '-1') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.errorPayrollDataAlreadyProcessed %>");
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
                       if ($('#spnSch').text() != "" && $('#spnSch').text() != "0") {
                           window.location = '<%= Page.ResolveClientUrl("~/Sch/Schedules") %>';
                       }
                       Clear();
                }
                },
                error: function (html) {
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
                    $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
                }

                $(".date-picker").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
              

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

        $("#txtFrom").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
        $("#txtToDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
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
                    fromDate: {
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    fromDate: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    schedule: {
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
