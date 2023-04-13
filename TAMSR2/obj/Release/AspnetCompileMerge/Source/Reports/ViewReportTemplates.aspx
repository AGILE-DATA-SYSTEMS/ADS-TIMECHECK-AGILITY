<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewReportTemplates.aspx.cs" Inherits="TAMSR2.Reports.ViewReportTemplates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.reportTemplates %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <!-- END PAGE LEVEL STYLES -->

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
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.reportTemplates %></h4>
                        </div>
                        <div class="portlet-body form">
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
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.descriptionEn %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="text" id="txtDescriptionEn" name="nameEn" data-required="1" class="span6 m-wrap" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.descriptionAr %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="text" id="txtDescriptionAr" name="nameAr" data-required="1" class="span6 m-wrap" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.joinDate %> </label>
                                    <div class="controls">
                                        <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.joinDate %> </label>
                                    <div class="controls">
                                        <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"><%=Resources.Resource.remarks %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="text" id="txtRemarks" name="code" data-required="1" class="span6 m-wrap" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="controls">
                                        <input id="chkboxRecurring" type="checkbox" name="recurring" />
                                        <%=Resources.Resource.recurring %>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <span id="spnID" style="display: none;">0</span>
                                    <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                                    <button id="btnSave" type="button" onclick="Save()" class="btn purple"><%=Resources.Resource.save %></button>
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
                    <%=Resources.Resource.reportTemplates %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.report %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.reportTemplates%></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.reportTemplates%></div>
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
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="spnAddButton" runat="server">
                                    <a id="btnAdd" onclick="return Clear()" href='<%= Page.ResolveClientUrl("~/Reports/Template-Wizard") %>' class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                </span>
                                
                            </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                              <tr style="background-color: #e8e3e3;">
                                  <th style="text-align: center;width: 8px;">
                                        <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.description %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.reportCategory %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.createdBy %></th>
                                    <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.updatedOn %></th>
                                    <th style="text-align: center;width: 24px !important;">&nbsp;</th>
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
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>

    <!--Script references. -->
    <!--Reference the SignalR library. -->
    <script src="../Scripts/jquery.signalR-1.1.0-beta1.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="../signalr/hubs"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
    <script src="../assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>
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
            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liRpt").addClass("active");
            $("#liRpt .arrow").addClass("open");
            $("#liDyn").addClass("active");
            $("#liDyn .arrow").addClass("open");
            $("#liReportTemplates").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false, sWidth: '5%' },
                  { "bSortable": true, sWidth: '25%' },
                  { "bSortable": true, sWidth: '30%' },
                  { "bSortable": true, sWidth: '15%' },
                  { "bSortable": true, sWidth: '10%' },
                  { "bSortable": true, sWidth: '10%' },
                  { "bSortable": false, sWidth: '5%' }
                ],
                "aoColumns": [
                  { "bVisible": false, sWidth: '5%' },
                  { "bVisible": true, sWidth: '25%' },
                  { "bVisible": true, sWidth: '30%' },
                  { "bVisible": true, sWidth: '15%' },
                  { "bVisible": true, sWidth: '10%' },
                  { "bVisible": true, sWidth: '10%' },
                  { "bVisible": true, sWidth: '5%' }
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
                "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/ReportTemplatePage.aspx?key=getAll") %>'
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
                if (name == "TAMSR2_Cmp_Holiday") {
                    ReloadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Cmp_Holiday', '');
                    // Clear text box and reset focus for next comment. 
                });
            });

            });


            function ReloadGrid() {
                $('#sample_1').dataTable().fnDraw();
            }

            function Clear() {

                $("#divSuccessMsg2").css("display", "none");
                $("#divErrorMsg2").css("display", "none");
            }

            function Delete(ID) {
                var v = "key=deleteByID&ID=" + ID;
               
               $("#divSuccessMsg2").css("display", "none");
                $("#divErrorMsg2").css("display", "none");
                
           if (confirm("<%=Resources.Resource.deleteMessage %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/ReportTemplatePage.aspx?key=deleteByID") %>',
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

    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>