<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveRotationalSchedule.aspx.cs" Inherits="TAMSR2.Details.SaveRotationalSchedule" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.rotationalSchedule %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <!-- END PAGE LEVEL STYLES -->
    <link href="<%= path %>Styles/jquery.loadmask.css" rel="stylesheet" />

    <script id="ddDaysTemplate" type="text/template">

        <div class="control-group" style="float: left;">
            <label class="control-label">{0}</label>
            <div class="controls chzn-controls">
                <select id={1} style="width: 220px;" class="span6 chosen dddays" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                    {2}
                </select>
            </div>
        </div>

    </script>
    <script>
        String.format = function () {
            var s = arguments[0];
            for (var i = 0; i < arguments.length - 1; i++) {
                var reg = new RegExp("\\{" + i + "\\}", "gm");
                s = s.replace(reg, arguments[i + 1]);
            }

            return s;
        }

    </script>
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
                    <%=Resources.Resource.rotationalSchedule %>	
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
                    <li><a href='<%= Page.ResolveClientUrl("~/Sch/Schedules") %>'><%=Resources.Resource.rotationalSchedule %></a></li>

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
                        <div class="span6 ">
                            <div class="control-group success">
                                <label class="control-label">No of schedule<span class="required">*</span> </label>
                                <div class="controls">
                                    <input id="txtdays" name="txtdays" class="m-wrap m-ctrl-medium" type="number"><span for="txtdays" class="help-inline ok valid"></span>
                                    <button id="btnPopulate" type="button" class="btn green">Populate</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div id="ddlDaysDropDownlist" class="span12"></div>
                        <!--/span-->
                    </div>
                    <!--/row-->

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
            <span id="spnSchFromDate">0</span>&nbsp;
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
        var schedulesList;

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
            $("#liRotationalSchedules").addClass("active");

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
            });

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

            if ($('#spnSch').text().trim() && $('#spnSch').text().trim() != 0) {

                Edit($('#spnSch').text())
            }
            $('#btnPopulate').click(function () {
                generateDaysDropdowns($(this));
            });
        });
        var rotationalScheduleList = {};
        function generateDaysDropdowns(obj, isEdit,data) {
            rotationalScheduleList = {};
            $('#ddlDaysDropDownlist').html('');
            LoadScheduleTimeList();
            var numberOfDays = parseInt($('#txtdays').val());
            setTimeout(function () {
                if (numberOfDays > 0) {
                    var html = '';
                    var modal_template_html = '';
                    for (var i = 1; i <= numberOfDays; i++) {
                        modal_template_html = $('#ddDaysTemplate').html();
                        
                        html += String.format(modal_template_html, "Day " + i, "'" + i + "'", schedulesList);
                        rotationalScheduleList[i] = "";
                    }
                    $('#ddlDaysDropDownlist').html(html);

                    if (isEdit && data) {
                        for (var i = 0; i < data.length; i++) {
                            $('#' + data[i].Day).val(data[i].ScheduleId);
                        }
                        $('.dddays').trigger('change');
                        $('.dddays').chosen()
                    }
                }


            }, 1000);

        }

        $('.dddays').live('change', function () {
            rotationalScheduleList[$(this).attr("id")] = $(this).val();
            console.log(rotationalScheduleList);
        });

        function LoadScheduleTimeList() {

            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ScheduleTimePage.aspx") %>',
                success: function (html) {
                    schedulesList = html;
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
        }

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
        function CloseForm() {
            Clear();
            window.location = '<%= Page.ResolveClientUrl("~/Sch/rotational-Schedules") %>';
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
            $('#txtdays').val('');
            $('#ddlDaysDropDownlist').html('');


        }

        function Edit(id) {

            $('#txtFromDate').val($('#spnSchFromDate').text());

            $('#txtFromDate').attr("disabled", true);
            $('#txtdays').attr("disabled", true);
            $('#btnPopulate').hide();

            var orgID = $('#spnOrg').text();
            var empID = $('#spnEmp').text();
            var groupID = $('#spnGroup').text() == "-1" ? "0" : $('#spnGroup').text();

            var scheduleRotationalId = id;
            if (orgID && orgID < 0 && empID && empID < 0 && groupID && groupID < 0)
                return;

            var urlStr = '<%= Page.ResolveClientUrl("../RequestPages/RotationalSchedulePage.aspx?key=getRotationalScheduleDetailById") %>'
                + '&orgID=' + orgID
                + '&groupID=' + groupID
                + '&empID=' + empID
                + '&ScheduleRotationalId=' + scheduleRotationalId

            $.ajax({
                type: 'POST',
                url: urlStr,
                success: function (html) {
                    var result = JSON.parse(html)
                    $('#txtdays').val(result.iTotalRecords);
                    generateDaysDropdowns(null, true, result.rawData);
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
                yr1 = str1.substring(0, 4);
                mon1 = str1.substring(5, 7);
                dt1 = str1.substring(8, 10);
            }
            else {
                yr1 = str1.substring(0, 4);
                mon1 = str1.substring(4, 6);
                dt1 = str1.substring(6, 8);
            }
            fromDate = yr1 + "-" + mon1 + "-" + dt1;

            //var str2 = $('#txtToDate').val();
            //var dt2 = "";
            //var mon2 = "";
            //var yr2 = "";
            //var hh2 = "";
            //var mm2 = "";
            //var toDate = "";
            //if (str2.indexOf('-') > 0) {
            //    yr2 = str2.substring(0, 4);
            //    mon2 = str2.substring(5, 7);
            //    dt2 = str2.substring(8, 10);
            //}
            //else {
            //    yr2 = str2.substring(0, 4);
            //    mon2 = str2.substring(4, 6);
            //    dt2 = str2.substring(6, 8);
            //}
            toDate = "2050-01-01";


            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }

            $("#divErrorMsg").css("display", "none");
            $("#divSuccessMsg").css("display", "none");

            if (new Date(yr1, mon1, dt1) > new Date('2050', '01', '01') && orgID != "1") {
                //failed
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.msgErrorDateRange %>");
                return;
            }
            if (!rotationalScheduleList && rotationalScheduleList.length <= 0) {
                return;
            }

            var v = "key=save" + "&id=" + id + "&orgID=" + orgID + "&groupID=" + groupID + "&empID=" + empID;
            v += "&fromDate=" + fromDate + "&toDate=" + toDate + "&rotationalList=" + JSON.stringify(rotationalScheduleList);

            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/RotationalSchedulePage.aspx") %>',
                success: function (html) {
                    if (html == '-2') {
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
                      <%-- $('#btnBroadCast').click();
                       if ($('#spnSch').text() != "" && $('#spnSch').text() != "0") {
                           window.location = '<%= Page.ResolveClientUrl("~/Sch/rotational-Schedules") %>';
                       }--%>
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
                    error.insertAfter(element);
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
