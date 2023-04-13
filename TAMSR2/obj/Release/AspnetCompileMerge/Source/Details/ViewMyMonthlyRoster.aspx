<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewMyMonthlyRoster.aspx.cs" Inherits="TAMSR2.Details.ViewMyMonthlyRoster" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.monthlyRoster %> - <%=Resources.Resource.applicationName %></title>

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
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.applicationName %> <%=Resources.Resource.borrowEmployee %></h4>
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
                    <%=Resources.Resource.sectionMonthlyRoster %> 
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
                    <li><a href="#"><%=Resources.Resource.sectionMonthlyRoster %></a></li>

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
                                <label class="control-label"><%=Resources.Resource.year %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddYear" name="year" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
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
                                <label class="control-label"><%=Resources.Resource.month %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddMonth" name="month" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.month %>">
                                        <option value=""></option>
                                        <option value="1"><%=Resources.Resource.january %></option>
                                        <option value="2"><%=Resources.Resource.february %></option>
                                        <option value="3"><%=Resources.Resource.march %></option>
                                        <option value="4"><%=Resources.Resource.april %></option>
                                        <option value="5"><%=Resources.Resource.may %></option>
                                        <option value="6"><%=Resources.Resource.june %></option>
                                        <option value="7"><%=Resources.Resource.july %></option>
                                        <option value="8"><%=Resources.Resource.august %></option>
                                        <option value="9"><%=Resources.Resource.september %></option>
                                        <option value="10"><%=Resources.Resource.october %></option>
                                        <option value="11"><%=Resources.Resource.november %></option>
                                        <option value="12"><%=Resources.Resource.december %></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
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
                    </div>
                    <!--/row-->
                </form>
                <!-- END FORM-->

                <!-- BEGIN -->
                <div id="divSchedules" style="padding: 20px;">
                    &nbsp;
                </div>
                <!-- END FORM-->
                <div style="min-height: 20px; clear: both;">&nbsp;</div>
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.sectionMonthlyRoster %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return LoadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">

                        <div style="width: 100%; overflow: scroll; overflow-y: hidden; padding: 20px 0px;">
                            <table class="table table-striped table-bordered table-hover" id="sample_1">
                                <thead>
                              <tr style="background-color: #e8e3e3;">
                                        <th style="text-align: center; width: 24px !important;"><%=Resources.Resource.number %></th>
                                        <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                        <th style="text-align: center; width: 12px !important;">1</th>
                                        <th style="text-align: center; width: 12px !important;">2</th>
                                        <th style="text-align: center; width: 12px !important;">3</th>
                                        <th style="text-align: center; width: 12px !important;">4</th>
                                        <th style="text-align: center; width: 12px !important;">5</th>
                                        <th style="text-align: center; width: 12px !important;">6</th>
                                        <th style="text-align: center; width: 12px !important;">7</th>
                                        <th style="text-align: center; width: 12px !important;">8</th>
                                        <th style="text-align: center; width: 12px !important;">9</th>
                                        <th style="text-align: center; width: 12px !important;">10</th>
                                        <th style="text-align: center; width: 12px !important;">11</th>
                                        <th style="text-align: center; width: 12px !important;">12</th>
                                        <th style="text-align: center; width: 12px !important;">13</th>
                                        <th style="text-align: center; width: 12px !important;">14</th>
                                        <th style="text-align: center; width: 12px !important;">15</th>
                                        <th style="text-align: center; width: 12px !important;">16</th>
                                        <th style="text-align: center; width: 12px !important;">17</th>
                                        <th style="text-align: center; width: 12px !important;">18</th>
                                        <th style="text-align: center; width: 12px !important;">19</th>
                                        <th style="text-align: center; width: 12px !important;">20</th>
                                        <th style="text-align: center; width: 12px !important;">21</th>
                                        <th style="text-align: center; width: 12px !important;">22</th>
                                        <th style="text-align: center; width: 12px !important;">23</th>
                                        <th style="text-align: center; width: 12px !important;">24</th>
                                        <th style="text-align: center; width: 12px !important;">25</th>
                                        <th style="text-align: center; width: 12px !important;">26</th>
                                        <th style="text-align: center; width: 12px !important;">27</th>
                                        <th style="text-align: center; width: 12px !important;">28</th>
                                        <th style="text-align: center; width: 12px !important;">29</th>
                                        <th style="text-align: center; width: 12px !important;">30</th>
                                        <th style="text-align: center; width: 12px !important;">31</th>
                                        <th style="text-align: center; width: 24px !important; padding: 5px;"><%=Resources.Resource.workHours %></th>
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
            $("#liRosterSubList").addClass("active");
            $("#liRosterSubList .arrow").addClass("open");
            $("#liSchViewMyRoster").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

            LoadOrganizations();
            LoadYears();

            $("#ddOrg").change(function () {
                LoadEmployees();
                LoadGrid();
            });

            $("#ddEmp").change(function () {
                LoadGrid();
            });

            $("#ddYear").change(function () {
                LoadGrid();
            });

            $("#ddMonth").change(function () {
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

        });

        function LoadOrganizations() {
            var d = "key=getIdNameListStringForRoster";
            $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   $("#form_sample_1").unmask();
                   $("#ddOrg").html(html);
                   $('#ddOrg option[value=<%= Session["orgID"] %>]').attr('selected', 'selected');
                   $("#ddOrg").trigger("liszt:updated");
                   LoadEmployees();
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
            $("#spnSuccessMsg").css("display", "none");

            var d = "key=getIdNameListByOrgID&orgID=" + $("#ddOrg").val();
            $("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   $("#form_sample_1").unmask();
                   $("#ddEmp").html(html);
                   $("#ddEmp").trigger("liszt:updated");
                   //LoadGrid();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#form_sample_1").unmask();
               }
           });
       }

       function LoadYears() {
           var curMonth = new Date().getMonth() + 1;
           $('#ddMonth option[value=' + curMonth + ']').attr('selected', 'selected');
           $("#ddMonth").trigger("liszt:updated");
           var curYear = new Date().getFullYear();
           var k = curYear - 2;
           var val = curYear + 5;
           var temp = "<option value=''><%=Resources.Resource.choose %> &nbsp; <%=Resources.Resource.year %></option>";
           while (k <= val) {
               if (k == curYear) {
                   temp += "<option selected='selected' value='" + k + "'>" + k + "</option>";
               }
               else {
                   temp += "<option value='" + k + "'>" + k + "</option>";
               }
               k++;
           }
           $("#ddYear").html(temp);
           $("#ddYear").trigger("liszt:updated");
       }

       function LoadGrid() {
           var d = "key=getMyMonthlyRecords&orgID=" + $("#ddOrg").val() + "&empID=" + $("#ddEmp").val();
           d += "&year=" + $("#ddYear").val() + "&month=" + $("#ddMonth").val() + "&iDisplayLength=100";

           $("#sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRosterPage.aspx") %>',
               success: function (html) {
                   $("#sample_1 tbody").html(html);
                   $("#sample_1").unmask();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $("#sample_1").unmask();
               }
           });
       }

    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
