<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HotFix.aspx.cs" Inherits="TAMSR2.Support.HotFix" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.dataSynchronizaton %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
    <!-- END PAGE LEVEL STYLES -->
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
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
                    <%=Resources.Resource.Patch %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.support %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.Patch %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div id="page-content" class="row-fluid">
            <div class="span12">
                <!-- BEGIN FORM-->
                <%--  <form action="#" id="form_1" class="form-horizontal">
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
                </form>--%>
                <!-- END FORM-->
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.Patch %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
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
                            <div class="span9">
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label" style="clear: both; width: 100px !important; display: inline; float: left"><%=Resources.Resource.ticketNumber %> <span class="required">*</span></label>
                                        <div style="clear: both; display: inline;" class="controls chzn-controls">
                                            <input id="txtTicketNumber" name="ticketNumber" class="span8 m-wrap" size="16" type="text" value="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="span6 ">
                                    <div class="control-group">
                                        <label class="control-label" style="clear: both; width: 100px !important; display: inline; float: left"><%=Resources.Resource.Patch %> <span class="required">*</span></label>
                                        <div style="clear: both; display: inline;" class="controls chzn-controls" id="btnPatch">
                                            <input type="file" id="patchUpload" class="btn" accept=".skyline" />
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>



                          <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                                <tr style="background-color: #e8e3e3;">
                                    <th style="text-align: center;"><%=Resources.Resource.ticketNumber %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.createdBy %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.createdOn %></th>
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
    <!-- IMPORTANT! jquery.slimscroll.min.js depends on jquery-ui-1.10.1.custom.min.js -->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/breakpoints/breakpoints.js" type="text/javascript"></script>
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

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src='<%= path %>Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
    <script src="<%= path %>assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="<%= path %>assets/<%= languageStr %>/scripts/table-managed.js"></script>

    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
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
            //TableManaged.init();
            //  FormValidation.init();

            FormComponents.init();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liPatch").addClass("active");
            $("#liPatch .arrow").addClass("open");
            $("#liPatch").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
            $("#txtFromDate").val('<%= DateTime.UtcNow.AddHours(-716).ToString("dd-MM-yyyy") %>');
            $("#txtToDate").val('<%= DateTime.UtcNow.AddHours(244).ToString("dd-MM-yyyy") %>');


            $("#txtFromDate").change(function () {
                DateRangeChange("fromDate");
                LoadGrid(true);
            });

            $("#txtToDate").change(function () {
                DateRangeChange("toDate");
                LoadGrid(true);
            });
            //  LoadGrid(false);
            $('#btnExportExcel').click(function () {
                ExportGridToExcel(true);
            });
            // Declare a proxy to reference the hub.

            LoadGrid(false);

            var patchUploader = document.getElementById("patchUpload");
            patchUpload.onchange = function (e) {
                e.stopPropagation(); // Stop stuff happening
                e.preventDefault(); // Totally stop stuff happening

                var ext = this.value.match(/\.(.+)$/)[1];
                switch (ext) {
                    case 'skyline':
                        uploadExcelFile(this);
                        break;
                    default:
                        alert('not allowed');
                        this.value = '';
                }

            };


        });


        function uploadExcelFile(obj) {
            $("#divSuccessMsg2").css("display", "none");
            $("#divErrorMsg2").css("display", "none");
            $("#page-content").mask("<%=Resources.Resource.processing %>" + "....");
           
            var files = obj.files;
            var ticketNumber = $('#txtTicketNumber').val();


            if (!ticketNumber) {
                alert("Ticket Number Required");
                obj.value = '';
                $("#page-content").unmask();
                return;
            
            }

            var id = '<%=Session["ID"].ToString() %>';
            var user = '<%=Session["userID"].ToString() %>';
            var v = "key=applyPatch" + "&id=" + id + "&user=" + user +"&ticketnumber=" + ticketNumber
            var url = "/Handlers/PatchHandler.ashx?" + v;
            var handlerURL = url;
            // START A LOADING SPINNER HERE

            // Create a formdata object and add the files
            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            $.ajax({
                url: handlerURL,
                type: "POST",
                data: data,
                contentType: false,
                processData: false,
                success: function (result) {
                    obj.value = '';
                    $('#txtTicketNumber').val('');


                    $("#page-content").unmask();
                    $('#formSuccess').removeClass('hide');
                    LoadGrid(false);
                },
                error: function (err) {
                    console.log(err);
                }
            });
        };

        function LoadGrid(filter) {


            //var fromDate = "";
            //var toDate = "";
            //var str1 = $('#txtFromDate').val();
            //var str2 = $('#txtToDate').val();

            //if (str1.indexOf('-') > 0) {
            //    fromDate = str1.substring(6, 10) + "-" + str1.substring(3, 5) + "-" + str1.substring(0, 2);
            //}
            //else {
            //    fromDate = str1.substring(4, 8) + "-" + str1.substring(2, 4) + "-" + str1.substring(0, 2);
            //}
            //if (str2.indexOf('-') > 0) {
            //    toDate = str2.substring(6, 10) + "-" + str2.substring(3, 5) + "-" + str2.substring(0, 2);
            //}
            //else {
            //    toDate = str2.substring(4, 8) + "-" + str2.substring(2, 4) + "-" + str2.substring(0, 2);
            //}

            // var urlStr = '<%= Page.ResolveClientUrl("../RequestPages/EmailLogsPage.aspx?key=getAll") %>' + '&fromDate=' + fromDate + '&toDate=' + toDate


        var urlStr = '<%= Page.ResolveClientUrl("../RequestPages/SystemPatchLog.aspx?key=getAll") %>'

        var filterValue = "";
        if (filter == true) {
            filterValue = $("#txt_sample_1_filter").val() || '';
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
                 { "bSortable": true},
                 { "bSortable": true },
                 { "bSortable": true }
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

            };

            function imposeMaxLength(Object, evt, MaxLen) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
                return (Object.value.length < MaxLen);
            };
            function ReLoadGrid() {
                $('#sample_1').dataTable().fnDraw();
            };
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
        };


        var FormComponents = function () {

            var handlejQueryUIDatePickers = function () {
                $(".ui-date-picker").datepicker();

            }

            var handleDateTimePickers = function () {


                if (jQuery().datepicker) {
                    $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
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
                    //  handleInputMasks();
                }

            };

        }();
        ////////END OF FORM COMPONENTS////////


    </script>
    <!-- END JAVASCRIPTS -->
</asp:Content>

