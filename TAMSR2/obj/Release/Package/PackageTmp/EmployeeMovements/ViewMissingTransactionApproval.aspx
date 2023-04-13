<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewMissingTransactionApproval.aspx.cs" Inherits="TAMSR2.Details.ViewMissingTransactionApproval" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title><%=Resources.Resource.approve + " " + Resources.Resource.missingMovements %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/css/bootstrap-tree.css" />

    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link href="<%= path %>Styles/jquery.loadmask.css" rel="stylesheet" />

    <!-- END PAGE LEVEL STYLES -->

    <style>
        #sample_1 thead th, #sample_id tbody td {
            padding: 3px !important;
            line-height: 15px !important;
        }

        .lnk {
            color: blue !important;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="divVerificationForm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="divVerificationForm" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h3 id="H2"><%=Resources.Resource.rejectConfirm %></h3>
        </div>
        <div class="modal-body">
            <h4 id="spnVerification">&nbsp;</h4>
            <span id="spnVrfNID" style="display: none;">0</span>
            <span id="spnVrfTab" style="display: none;">&nbsp;</span>
            <div class="span6">
                <div class="control-group">
                    <label class="control-label" style="clear: both; width: 100px !important; display: inline;"><%=Resources.Resource.remarks %> <span class="required">*</span></label>
                    <div style="clear: both; display: inline;" class="controls chzn-controls">
                        <textarea id="txtRemarks" name="remarks" onkeydown="return imposeMaxLength(this, event, 480);" data-required="1" rows="3" class="medium m-wrap" style="width: 98% !important; resize: none;"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button onclick="return Reject()" class="btn icn-only green"><%=Resources.Resource.action %></button>
            <button id="btnHideVerificationPopup" data-dismiss="modal" class="btn danger"><%=Resources.Resource.close %></button>
        </div>
    </div>

    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="portlet-config" class="modal hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.organizationTypes %></h4>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <form action="#" id="form_sample_1" class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.organization %><span class="required">*</span></label>
                                    <div class="controls chzn-controls">
                                        <select id="ddOrg" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.group %></label>
                                    <div class="controls chzn-controls">
                                        <select id="ddEmpGroup" name="ddgroup" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.group %>">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.employee %><span class="required">*</span></label>
                                    <div class="controls chzn-controls">
                                        <select id="ddEmp" name="employee" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.status %></label>
                                    <div class="controls chzn-controls">
                                        <select id="ddStatus" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="orgParent" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.status %>" tabindex="1">
                                            <option value=""><%=Resources.Resource.choose %> <%=Resources.Resource.status %></option>
                                            <option value="<%=Resources.Resource.applied %>"><%=Resources.Resource.applied %></option>
                                            <option value="<%=Resources.Resource.approved %>"><%=Resources.Resource.approved %></option>
                                            <option value="<%=Resources.Resource.rejected %>"><%=Resources.Resource.rejected %></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <span id="spnID" style="display: none;">0</span>
                                    <a id="btnSearch" class="label label-info label-mini"><%=Resources.Resource.search %></a>
                                    <a id="btnSearchClear" onclick="return Clear(true)" class="label label-inverse label-mini"><%=Resources.Resource.clear %></a>
                                    <a id="btnClosePopup" data-dismiss="modal" class="label label-mini"><%=Resources.Resource.close %></a>
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
                    <%=Resources.Resource.approve + " " + Resources.Resource.missingMovements%>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.movements %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.approvemanualtransaction %></a></li>
                 <%--   <a class="lnk" id="btnAdvanceFilters" style="float: <%= pullDirectionStr %>" onclick="return LoadListsOnlyOneTime()" href="#portlet-config" data-toggle="modal"><%=Resources.Resource.advanceSearch %></a>--%>

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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.approvemanualtransaction %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return ReLoadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div id="divSuccessMsg" class="alert alert-success hide">
                            <span id="spnSuccessMsg"><%=Resources.Resource.formErrors %></span>
                        </div>
                        <div id="divErrorMsg" class="alert alert-error hide">
                            <span id="spnErrorMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                        </div>
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="spnGridMsg">&nbsp;</span>
                            </div>
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="spnApproveButton" runat="server">
                                    <a id="btnApprove" onclick="return Approve()" class="btn green">&nbsp; <%=Resources.Resource.approve %></i></a>
                                </span>
                                <span id="spnRejectButton" runat="server">
                                    <a data-toggle="modal" onclick ="return validateToOpen()" id="btnReject" style='margin: 0px 10px;' class="btn btn-dange red" role="button"><%=Resources.Resource.reject %></a>
                                </span>
                            </div>
                        </div>

                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                                <tr style="background-color: #e8e3e3;">
                                    <th style="text-align: center;">
                                        <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                    <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.employee %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.transactionDate %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.transactionTime %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.reason %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.remarks %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.status %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.actionBy %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.actionDate %></th>
                                    <th style="text-align: center;"> </th>
                                    <th style="text-align: center; "> </th>

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
    <script src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/js/bootstrap-tree.js"></script>

    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/clockface/js/clockface.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>

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

        var loadLists = false;

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
            $("#liApproveMissingTrans").addClass("active");


          //  $("#txtFromDate").val('<%= DateTime.UtcNow.AddHours(-172).ToString("dd-MM-yyyy") %>');
          // $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');


            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }


            LoadGrid(true);


            $("#ddOrg").change(function () {
                LoadEmployees();
            });

            $("#ddEmp").change(function () {
            });

            $("#ddStatus").change(function () {
            });

            $("#ddEmpGroup").change(function () {
                LoadEmployees();
            });


            $("#btnSearch").click(function () {
                LoadGrid(true);
            });


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
                if (name == "TAMSR2_Manual_Transactions") {
                    ReLoadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Manual_Transactions', '');
                    // Clear text box and reset focus for next comment. 
                });
            });
        });

        function DateRangeChange(param) {

            var fromDate = new Date();
            var toDate = new Date();
            var str1 = $('#txtFromDate').val();
            var str2 = $('#txtToDate').val();

            if (str1 == "" || str2 == "")
                return;
            
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


    function ReLoadGrid() {
        $('#sample_1').dataTable().fnDraw();
    }


    function LoadListsOnlyOneTime() {

        if (loadLists == false) {
            LoadGroups();
            LoadOrganizations();
            loadLists = true;
        }
    }


    function Delete() {
        var v = "key=deleteByID&";

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
                   url: '<%= Page.ResolveClientUrl("~/RequestPages/SinglePermissionPage.aspx") %>',
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
                           nameEn: {
                               minlength: 3,
                               required: true
                           },
                           nameAr: {
                               minlength: 3,
                               required: true
                           },
                           code: {
                               minlength: 2,
                               required: true
                           },
                           orgType: {
                               required: true
                           }
                       },
                       message: {
                           nameEn: {
                               required: "<%=Resources.Resource.lblRequired %>"
                          },
                          nameAr: {
                              required: "<%=Resources.Resource.lblRequired %>"
                           },
                          code: {
                              required: "<%=Resources.Resource.lblRequired %>"
                           },
                          orgType: {
                              required: "<%=Resources.Resource.lblRequired %>"
                           }
                      },


                      errorPlacement: function (error, element) { // render error placement for each input type
                          if (element.attr("name") == "orgType") { // for uniform checkboxes, insert the after the given container
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
       ////////////END OF VALIDATIONS/////////////


       var FormComponents = function () {

           var handlejQueryUIDatePickers = function () {
               $(".ui-date-picker").datepicker();
           }

           var handleDateTimePickers = function () {

               if (jQuery().datepicker) {
                   $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
               }
              // $(".date-picker").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');

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
                   format: 'dd-mm-yyyy',
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
                   handleInputMasks();
               }

           };

       }();
       ////////END OF FORM COMPONENTS////////

       function LoadOrganizations() {
           var d = "key=getIdNameListString";
           //  $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   //alert(html);
                   //         $("#form_sample_1").unmask();
                   $("#ddOrg").html(html);

                   $("#ddOrg").trigger("liszt:updated");
                   GetLabel();
                   LoadEmployees();
                   LoadGrid(false);
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
               //       $("#form_sample_1").unmask();
           }
           });
   }

   function LoadEmployees() {
       $("#divErrorMsg").css("display", "none");
       $("#spnSuccessMsg").css("display", "none");
       var d = "";
       if ($("#ddEmpGroup").val() != "" && $("#ddEmpGroup").val() != "-1")
           d = "key=getIdNameListStringByGroupID&groupID=" + $("#ddEmpGroup").val();
       else
           d = "key=getIdNameListByOrgID&orgID=" + $("#ddOrg").val();

       //    $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                success: function (html) {

                    $("#ddEmp").html(html);
                    $("#ddEmp").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //      $("#form_sample_1").unmask();
                }
            });
        }

        function LoadGroups() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeGroupPage.aspx") %>',
               success: function (html) {
                   //  alert(html);
                   //    $("#form_sample_1").unmask();
                   $("#ddEmpGroup").html(html);
                   //if ($.getQueryString('groupID') != "" && $.getQueryString('groupID') != "undefined") {
                   //    $('#ddEmpGroup option[value="' + $.getQueryString('groupID') + '"]').attr('selected', 'selected');
                   //    LoadGrid(false);
                   //}
                   $("#ddEmpGroup").trigger("liszt:updated");
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //     $("#form_sample_1").unmask();
               }
           });
       }

       function GetLabel() {
           $("#divLabel").html("");
           var d = 'key=getLabel&orgID=' + $('#ddOrg').val() + '&empID=' + $('#ddEmp').val() + '&groupID=' + $('#ddEmpGroup').val();
           //  $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            //alert(d);
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/TAEventPage.aspx") %>',
               success: function (html) {
                   //$("#form_sample_1").unmask();
                   $("#divLabel").html(html);
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //            $("#form_sample_1").unmask();
                }
           });
        }



        function LoadGrid(filter) {
            var fromDate = "";
            var toDate = "";
            var str1 = $('#txtFromDate').val();
            var str2 = $('#txtToDate').val();
            if (str1 != "" || str2 != "") {
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
            }
            else
            {
                fromDate = null;
                toDate = null;
            }
            //if (fromDate == "" || toDate == "")
            //    return;
            var status = $("#ddStatus").val();
            if (status == '')
                status = "Applied";

           var ApproveFlag = 'Y'

           var urlStr = '<%= Page.ResolveClientUrl("../RequestPages/TAEventPage.aspx?key=GetAllManualPunch") %>' + '&orgID=' + $("#ddOrg").val() + '&groupID=' + $("#ddEmpGroup").val() + '&empID=' + $("#ddEmp").val() + '&fromDate=' + fromDate + '&toDate=' + toDate + '&status=' + status + '&ApproveFlag=' + ApproveFlag

            var filterValue = "";
            if (filter == true) {
                filterValue = $("#txt_sample_1_filter").val();
                $("#sample_1_filter label input").val(filterValue);
            }
            urlStr += "&sSearchFilter=" + filterValue;

            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false, sWidth: "3%" },
                  { "bSortable": true, sWidth: "7%" },
                  { "bSortable": true, sWidth: "15%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "7%" },
                  { "bSortable": true, sWidth: "7%" },
                  { "bSortable": true, sWidth: "15%" },
                  { "bSortable": true, sWidth: "7%" },
                  { "bSortable": true, sWidth: "13%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "3%" },
                  { "bSortable": true, sWidth: "3%" }
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
                "aaSorting": [[3, "desc"]],
                "sAjaxSource": urlStr
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




        function Approve() {
            var v = "key=ApproveRejectMissingPunch&";
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
            v += "&status=" + "Approved";
           if (k == 0) {
               $("#divErrorMsg").css("display", "block");
               $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
                return;
            }
            if (confirm("<%=Resources.Resource.approveConfirm %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/TAEventPage.aspx") %>',
                    success: function (html) {
                        if (html == "1") {
                            LoadGrid(true);
                            $("#divSuccessMsg").css("display", "block");
                            $("#spnSuccessMsg").html("<%=Resources.Resource.approvedSuccessfully %>");
                           $('#btnBroadCast').click();
                       }
                       else if (html == "-1") {
                           $("#divErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html("<%=Resources.Resource.errorPayrollDataAlreadyProcessed %>");
                       }
                       else {
                           $("#divErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html("<%=Resources.Resource.error %>");
                       }
                   },
                    error: function (html) {

                    }
                });
       }
       else {
       }
   }
   function validateToOpen() {
       var k = 0;
       $("#sample_1 tbody").find("input:checkbox").each(function () {
           if (this.checked == true) {
               k++;
           }
       });
       if (k == 0) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
           $('#divVerificationForm').modal('hide');
           return;
       }
       $('#txtRemarks').val('');
       $('#divVerificationForm').modal('show');
   };
   function Reject() {
       var v = "key=ApproveRejectMissingPunch&";
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

       if (!$('#txtRemarks').val()) {
           alert("<%=Resources.Resource.remarksRequired %>")
           return;
       }
           

       v += "count=" + k;
       v += "&status=" + "Rejected";
       v += "&lineComments=" + $('#txtRemarks').val().trim();


       if (k == 0) {
           $("#divErrorMsg").css("display", "block");
           $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
           return;
       }
       
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/TAEventPage.aspx?key=ApproveRejectMissingPunch") %>',
               success: function (html) {
                   if (html == "1") {
                       LoadGrid(true);
                       $("#divSuccessMsg").css("display", "block");
                       $("#btnHideVerificationPopup").click();
                      
                       $("#spnSuccessMsg").html("<%=Resources.Resource.rejectedSuccessfully %>");
                           $('#btnBroadCast').click();
                       }
                       else if (html == "-1") {
                           $("#divErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html("<%=Resources.Resource.errorPayrollDataAlreadyProcessed %>");
                       }
                       else {
                           $("#divErrorMsg").css("display", "block");
                           $("#spnErrorMsg").html("<%=Resources.Resource.error %>");
                       }
                   },
               error: function (html) {

               }
           });
   }


   function CloseForm() {
       Clear(false);
       $("#btnCloseForm").click();
       $("#divSuccessMsg").hide();

   }

   function Clear(reset) {

       var fromDate = $("#txtFromDate").val();
       var toDate = $("#txtToDate").val();

       $(':input', '#form_1')
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
       //$("#txtVname").val("");
       //$("#txtValue").val("");
       //$("#txtTabNo").val("");
       //$("#txtdescr").val("");
       //$("#txtService").val("");

       $("#txtFromDate").val(fromDate);
       $("#txtToDate").val(toDate);

       if (reset == true) {
           $("#ddOrg").val("");
           $("#ddOrg").trigger("liszt:updated");
           $("#ddEmp").val("");
           $("#ddEmp").trigger("liszt:updated");
           $("#ddEmpGroup").val("");
           $("#ddEmpGroup").trigger("liszt:updated");
           $("#ddStatus").val("");
           $("#ddStatus").trigger("liszt:updated");
           LoadGrid(true);
       }

   }
   function imposeMaxLength(Object, evt, MaxLen) {
       var charCode = (evt.which) ? evt.which : evt.keyCode;
       if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
       return (Object.value.length < MaxLen);
   }



    </script>



    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
