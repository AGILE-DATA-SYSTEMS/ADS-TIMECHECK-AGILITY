<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveMissingTransaction.aspx.cs" Inherits="TAMSR2.EmployeeMovements.SaveMissingTransaction" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title><%=Resources.Resource.applymovements %> - <%=Resources.Resource.applicationName %></title>
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
                    <%=Resources.Resource.applymovements %>	
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
                    <li><a href='<%= Page.ResolveClientUrl("~/Events/View-Manual-Transaction") %>'><%=Resources.Resource.applymovements %></a></li>

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
                                <label class="control-label"><%=Resources.Resource.employee %> <span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddEmployee" style="width: 220px;" disabled="disabled" class="span6 chosen" data-with-diselect="1" name="emp" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employee %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.reasonMode %> <span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddReasonType" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="permType" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>" tabindex="1">
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
                                <label class="control-label"><%=Resources.Resource.transactionDate %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input id="txtTransDate" name="fromDate" disabled="disabled" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                       <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.transactionTime %> <span class="required">*</span></label>
                                <div class="controls">
                                    <div class="input-append bootstrap-timepicker-component">
                                        <input type="text" id="txtTransTime" name="fromTime" class="m-wrap m-ctrl-small timepicker-24" value="00:00">
                                        <span class="add-on"><i class="icon-time"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.justification %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input type="text" id="txtRemarks" name="remarks" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <!--/span-->
                        <div class="span6 "> 
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.attachement %> <!--<span class="required">*</span>--></label>
                                <div class="controls chzn-controls">
                                    <div id="movementAttachmentBox" style=" cursor: pointer;">
                                        <img src="<%= Page.ResolveClientUrl("/images/attachement.png") %>" alt="click here to upload" />
                                        <span><%=Resources.Resource.msgAttachment %></span>
                                    </div>
                                    <input type="file" id="movementAttachment" accept="image/jpeg" name="movementAttachment" style="display: none;" />
                                
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 " style="display: none;">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.readers %> <span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddReaders" style="display: none;width: 220px;" class="span6 chosen" data-with-diselect="1" name="readers" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>" tabindex="1">
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
            <span id="spnTrans">0</span>&nbsp;
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
        var tempReader = false;
        var tempReason = false;

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
            $("#liEvents").addClass("active");
            $("#liEvents .arrow").addClass("open");
            $("#liViewMissingMovment").addClass("active");

            $("#ddEmployee").attr("disabled", "disabled");
            $("#txtTransDate").attr("disabled", "disabled");
            $("#ddEmployee_chzn").css("opacity", "1");
            $("#ddEmployee_chzn").removeClass("chzn-disabled");


            $("#txtTransTime").val("00:00");
            $("#txtTransTime").change(function () {
                if ($("#txtTransTime").val() == '')
                    $("#txtTransTime").val("00:00");
            });

            if ("<%= transDate %>" != "" && "<%= transDate %>" != "0" && "<%= transDate %>" != "MA==") {
                $("#txtTransDate").val("<%= transDate %>");
            }


            $('#movementAttachmentBox').click(function () {
                $('#movementAttachment').click();
            });
            
            var movementAttachment = document.getElementById("movementAttachment");
            movementAttachment.onchange = function (e) {
                $('#divErrorMsg').addClass('hide');
                $('#divSuccessMsg').addClass('hide');
                $('#divInfoMsg').addClass('hide');
                e.stopPropagation(); // Stop stuff happening
                e.preventDefault(); // Totally stop stuff happening
                //msgErrorFileSize
                var ext = this.value.match(/\.(.+)$/)[1]; 
                switch (ext) {
                    case 'jpg'|| 'JPG' :
                        break;
                    case 'jpeg' || 'JPEG' :
                        break;
                    default:
                        $('#spnErrorMsg').html("<%=Resources.Resource.msgWrongFileError %>");
                        $('#divErrorMsg').removeClass('hide');
                        this.value = '';
                        
                }
            };
         

            // Declare a proxy to reference the hub. 
            var users = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            users.client.broadcastMessage = function (name, message) {
                if (name == "TAMSR2_Manual_Punch") {
                    //ReloadGrid()
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Manual_Punch', '');
                    // Clear text box and reset focus for next comment. 
                });
            });

            LoadEmployeeList();
            LoadReasonTypeList();
            LoadReaders();
        });

        function LoadEmployeeList() {
            var d = "key=getIdNameListWithDept";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                success: function (html) {
                    $("#ddEmployee").html(html);
                    //$("#form_sample_1").unmask();
                    tempEmp = true;
                    if ("<%= emp %>" != "" && "<%= emp %>" != "0" && "<%= emp %>" != "MA==") {
                        $("#ddEmployee").val("<%= emp %>");
                    }
                    $("#ddEmployee").trigger("liszt:updated");
                    var spnTrans = $('#spnTrans').text();
                    if (spnTrans != "" && spnTrans != "0" && spnTrans != "MA==" && tempReader == true && tempReason == true) {
                        Edit(spnTrans);
                    }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadReasonTypeList() {
            var d = "key=getByModeIdNameListString&mode=<%= mode %>";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ReasonPage.aspx") %>',
                success: function (html) {
                    $("#ddReasonType").html(html);
                    $("#ddReasonType").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    tempReason = true;
                    var spnTrans = $('#spnTrans').text();
                    if (spnTrans != "" && spnTrans != "0" && spnTrans != "MA==" && tempEmp == true && tempReader == true) {
                        Edit(spnTrans);
                    }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadReaders() {
            if ($("#ddReaders").css("display") + "" == "none") {
                tempReader = true;
                return;
            }
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/ReaderPage.aspx") %>',
                 success: function (html) {
                     $("#ddReaders").html(html);
                     $("#ddReaders").trigger("liszt:updated");
                     //$("#form_sample_1").unmask();
                     tempReader = true;
                     var spnTrans = $('#spnTrans').text();
                     if (spnTrans != "" && spnTrans != "0" && spnTrans != "MA==" && tempEmp == true && tempReason == true) {
                         Edit(spnTrans);
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
            window.location = '<%= Page.ResolveClientUrl("~/Events/Employee-Missing-Transaction") %>';
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
            //$("#txtTransDate").val("");
            //$("#txtToDate").val("");
            $("#txtRemarks").val("");

            //$('#ddEmployee option[value=""]').attr('selected', 'selected');
            //$("#ddEmployee").trigger("liszt:updated");
            //$("#txtCategory").val("");
            //$("#txtService").val("");
        }

        function Edit(id) {
            //Edit code
            if (id < 1)
                return;
            var v = "key=getManualPunchByID&id=" + id;
            $("#btnAdd").click();
            $("#spnGridMsg").html("&nbsp;");
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/TAEventPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);
                        $("#spnID").val(j.ID);
                        if (j.ID == "0") {
                            $("#spnID").html(j.ID);
                            return;
                        }
                        $("#txtTransTime").val(j.TransactionTimeStr);
                        $("#txtRemarks").val(j.Remarks);
                        $('#ddReasonType option[value=' + j.ReasonID + ']').attr('selected', 'selected');
                        $("#ddReasonType").trigger("liszt:updated");
                        $('#ddReaders option[value=' + j.ReaderID + ']').attr('selected', 'selected');
                        $("#ddReaders").trigger("liszt:updated");
                    }
                },
                error: function (html) {

                }
            });
        }

        function Save() {

            $("#divSuccessMsg2").css("display", "none");
            $("#divErrorMsg2").css("display", "none");

            //var id = $('#spnTrans').text();
            var empID = $("#ddEmployee").val();
            var reasonTypeID = $("#ddReasonType").val();
            var transDate = $("#txtTransDate").val();
            var transTime = $("#txtTransTime").val();
            var remarks = $("#txtRemarks").val();
            //var readerId = $("#ddReaders").val();

            //if ($('#movementAttachment')[0].files.length == 0) {
              //  $("#divErrorMsg").css("display", "block");
                //$("#spnErrorMsg").html("<%=Resources.Resource.lblRequired %>" + "." + "<%=Resources.Resource.attachment %>");
                  //  return;
                //}

            var data = new FormData();
            var filesObject = $('#movementAttachment');
                var fileSize = filesObject[0].size;

                var files = filesObject[0].files;
                if (files.length > 1) {
                    var sizeInMB = ($('#movementAttachment')[0].files[0].size / (1024 * 1024));

                    if (sizeInMB > 2.0) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%= String.Format(Resources.Resource.msgErrorFileSize,"2 MB.") %>");
                        $('#movementAttachment').val('');
                        return;
                    }
                }
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);

                }

            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }


            var url = '<%= Page.ResolveClientUrl("~/RequestPages/TAEventPage.aspx") %>';
            // alert(readerId);
            var v = "key=saveManualPunch&id=<%= transID %>" + "&empID=" + empID + "&reasonTypeID=" + reasonTypeID;
            v += "&transDate=" + transDate + "&transTime=" + transTime;
            v += "&remarks=" + remarks + "&status=" + status; // + '&readerID=' + readerId;
            url = url + "?" + v;
            $.ajax({
                type: 'POST',
                data: data,
                url: url,
                contentType: false,
                processData: false, 
                success: function (html) {
                    if (html == '-3') {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgMonthAlreadyClosed %>");
                    }
                    else if (html == '-2') {
                        //failed because of transactiontime validation
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgTransactionTimeValidationFailed %>");
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
                        window.location = '<%= Page.ResolveClientUrl("~/Events/Employee-Missing-Transaction") %>';
                        Clear();
                        //LoadEmployeeList();
                        //LoadReasonTypeList();
                        //LoadReaders();
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
                showSeconds: false,
                showMeridian: false,
                templates: 'modal'
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

                    fromDate: {
                        required: true
                    },

                    fromTime: {
                        required: true
                    },

                    remarks: {
                        required: true
                    },
                    //readers: {
                    //    required: true
                    //},
                   /* movementAttachment: {
                        required: true
                    }*/
                },

                messages: { // custom messages for radio buttons and checkboxes
                    emp: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    movementAttachment: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    fromDate: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    readers: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    fromTime: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    toTime: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    }/*,
                    remarks: {
                        required: ""
                    //}*/
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


