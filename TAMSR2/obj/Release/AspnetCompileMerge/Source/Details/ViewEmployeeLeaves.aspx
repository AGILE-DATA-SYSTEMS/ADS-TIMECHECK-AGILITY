﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewEmployeeLeaves.aspx.cs" Inherits="TAMSR2.Details.ViewEmployeeLeaves" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.employeeLeaves %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <link href="<%= path %>Styles/jquery.loadmask.css" rel="stylesheet" />
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
                        <a href="#"><%=Resources.Resource.leaves %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.employeeLeaves %></a></li>

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
                                <label class="control-label"><%=Resources.Resource.fromDate %> </label>
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
                </form>
                <!-- END FORM-->
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.employeeLeaves %></div>
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
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="spnAddButton" runat="server">
                                    <a id="btnAdd" href='<%= Page.ResolveClientUrl("~/Leaves/Save-Employee-Leave/" + TAMSR2.CustomClasses.Encryption.Encrypt("0")) %>' class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                </span>
                                <span id="spnDeleteButton" runat="server">
                                    <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                </span>
                            </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                              <tr style="background-color: #e8e3e3;">
                                    <th style="text-align: center; ">
                                        <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                    <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                    <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.leaveType %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.fromDate %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.toDate %></th>
                                    <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.approve %></th>
                                    <th style="text-align: center; ">&nbsp;</th>
                                    <th style="text-align: center; ">&nbsp;</th>
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
            FormComponents.init();
            //TableManaged.init();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liLeaveGroup").addClass("active");
            $("#liLeaveGroup .arrow").addClass("open");
            $("#liEmpLeave").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

            $("#txtFromDate").val('<%= DateTime.UtcNow.AddHours(-172).ToString("dd-MM-yyyy") %>');
            $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
           
            LoadGrid(false);

            $("#txtFromDate").change(function () {
                DateRangeChange("fromDate");
                LoadGrid(true);
           });

            $("#txtToDate").change(function () {
                DateRangeChange("toDate");
                LoadGrid(true);
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
                if (name == "TAMSR2_Emp_Leaves") {
                    LoadGrid(true);
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

        });

        function DateRangeChange(param) {

            var fromDate = new Date();
            var toDate = new Date();
            var str1 = $('#txtFromDate').val();
            var str2 = $('#txtToDate').val();

            if (str1.indexOf('-') > 0) {
                fromDate = new Date(str1.substring(6, 10), str1.substring(3, 5), str1.substring(0, 2));
            }
            else {
                fromDate = new Date(str1.substring(4, 8), str1.substring(2, 4), str1.substring(0, 2));
            }
            if (str2.indexOf('-') > 0) {
                toDate = new Date(str2.substring(6, 10), str2.substring(3, 5), str2.substring(0, 2));
            }
            else {
                toDate = new Date(str2.substring(4, 8), str2.substring(2, 4), str2.substring(0, 2));
            }

            if (param == "fromDate") {
                if ($("#txtFromDate").val() == "") {
                    $("#txtFromDate").val('<%= DateTime.UtcNow.AddHours(-172).ToString("dd-MM-yyyy") %>');
                    $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                }

                if (fromDate > toDate) {
                    $("#txtToDate").val($("#txtFromDate").val());
                }
            }
            else if (param == "toDate") {
                if ($("#txtToDate").val() == "") {
                    $("#txtFromDate").val('<%= DateTime.UtcNow.AddHours(-172).ToString("dd-MM-yyyy") %>');
                    $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');
                }

                if (fromDate > toDate) {
                    $("#txtFromDate").val($("#txtToDate").val());
                }
            }
    }

        function LoadGrid(filter) {
            var fromDate = "";
            var toDate = "";
            var str1 = $('#txtFromDate').val();
            var str2 = $('#txtToDate').val();

            if (str1.indexOf('-') > 0) {
                fromDate = str1.substring(6, 10) + "-" + str1.substring(3, 5) + "-" + str1.substring(0, 2);
            }
            else {
                fromDate = str1.substring(4, 8) + "-" + str1.substring(2, 4) + "-" + str1.substring(0, 2);
            }
            if (str2.indexOf('-') > 0) {
                toDate = str2.substring(6, 10) + "-" + str2.substring(3, 5) + "-" + str2.substring(0, 2);
            }
            else {
                toDate = str2.substring(4, 8) + "-" + str2.substring(2, 4) + "-" + str2.substring(0, 2);
            }
            
            var url = '<%= Page.ResolveClientUrl("../RequestPages/EmployeeLeavePage.aspx?key=getAll") %>' + '&fromDate=' + fromDate + '&toDate=' + toDate;
           

            var filterValue = "";
            if (filter == true) {
                filterValue = $("#txt_sample_1_filter").val();
                $("#sample_1_filter label input").val(filterValue);
            }
            url += "&sSearchFilter=" + filterValue;

            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false, sWidth: "5%" },
                  { "bSortable": true, sWidth: "7%" },
                  { "bSortable": true, sWidth: "20%" },
                  { "bSortable": true, sWidth: "15%" },
                  { "bSortable": true, sWidth: "15%" },
                  { "bSortable": true, sWidth: "15%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": false, sWidth: "5%" },
                  { "bSortable": false, sWidth: "5%" }
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

            $("#sample_1_filter input").css("display", "none");
            $("txt_sample_1_filter").css("display", "");
            $("#sample_1_filter label").append("<input id='txt_sample_1_filter' value='' style='display: inline-block; margin-bottom: 0; border-color: rgba(82, 168, 236, 0.8); box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(82, 168, 236, 0.6); outline: 0 none;' />");
            if (filter == true) {
                $("#txt_sample_1_filter").val(filterValue);
                $("#sample_1_filter label input").val(filterValue);
            }
            $("#txt_sample_1_filter").keyup(function (e) {
                //alert(e.keyCode);
                if (e.keyCode == 13) {
                    //alert($("#txt_sample_1_filter").val());
                    //alert($("#sample_1_filter label input").val());
                    filterValue = $("#txt_sample_1_filter").val();
                    $("#sample_1_filter label input").val(filterValue);
                    $("#txt_sample_1_filter").val(filterValue);
                    LoadGrid(true);//$('#sample_1').dataTable().fnDraw();
                    //alert($("#sample_1_filter label input").val());
                }
            });

        }

        function ReloadGrid() {
            $('#sample_1').dataTable().fnDraw();
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
                   url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeLeavePage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg2").css("display", "block");
                           $("#spnSuccessMsg2").html("<%=Resources.Resource.msgRecordDelete %>");
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

        var FormComponents = function () {

            var handlejQueryUIDatePickers = function () {
                $(".ui-date-picker").datepicker();
            }

            var handleDateTimePickers = function () {

                if (jQuery().datepicker) {
                    $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
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
                        format: 'dd-mm-yyyy',
                        separator: ' to ',
                        startDate: Date.today().add({
                            days: -29
                        }),
                        endDate: Date.today(),
                        minDate: '01-01-2000',
                        maxDate: '31-12-2999',
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

                $("#txtFromDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
                $("#txtToDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
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

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>