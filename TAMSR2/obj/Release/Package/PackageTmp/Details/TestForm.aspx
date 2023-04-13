<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestForm.aspx.cs" Inherits="TAMSR2.Details.TestForm" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.scheduleTypes %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <!-- END PAGE LEVEL STYLES -->

    <script src="../DragDrop/themes/base/jquery.ui.all.css"></script>
    <script src="../DragDrop/jquery-1.9.1.js"></script>
    <script src="../DragDrop/ui/jquery.ui.position.js"></script>
    <script src="../DragDrop/ui/jquery.ui.core.js"></script>
    <script src="../DragDrop/ui/jquery.ui.widget.js"></script>
    <script src="../DragDrop/ui/jquery.ui.mouse.js"></script>
    <script src="../DragDrop/ui/jquery.ui.draggable.js"></script>
    <script src="../DragDrop/ui/jquery.ui.droppable.js"></script>
    <link rel="stylesheet" href="../demos.css">
    <style>
        .ui-draggable, .ui-droppable {
            background-position: top;
        }

        .draggable {
            cursor: move;
            padding: 5px;
            margin: 10px;
            float: left;
        }

        .droppable {
            text-align: center !important;
            font-weight: bold;
            font-size: 12px;
            color: white;
            cursor: pointer;
        }

        #sample_1 th, #sample_id td {
            padding: 5px !important;
        }
    </style>
    <script>
        $(function () {
            $(".droppable").droppable({
                drop: function (event, ui) {
                    alert("");
                    $(this).css("background-color", ui.draggable.attr("color"));
                    $(this).attr("schId", ui.draggable.attr("schId"));
                    $(this).attr("code", ui.draggable.attr("code"));
                    $(this).html("X");
                    $(this).click(function () {
                        $(this).css("background-color", "White");
                        $(this).html("");
                    });
                }
            });
        });
	</script>

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
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.applicationName %> <%=Resources.Resource.scheduleTypes %></h4>
                        </div>
                        <div class="portlet-body form">
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
                <div class="color-panel hidden-phone">
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
                    <%=Resources.Resource.scheduleTypes %> 
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
                    <li><a href="#"><%=Resources.Resource.scheduleTypes %></a></li>

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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.scheduleTypes %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">


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
                                        <label class="control-label"><%=Resources.Resource.year %><span class="required">*</span></label>
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
                                        <label class="control-label"><%=Resources.Resource.month %><span class="required">*</span></label>
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
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                        </form>
                        <!-- END FORM-->


                        <div id="divSchedules" style="padding: 20px;">
                            &nbsp;
                        </div>

                        <div style="width: 100%; overflow: scroll; overflow-y: hidden; padding: 20px 0px;">
                            <table class="table table-striped table-bordered table-hover" id="sample_1">
                                <thead>
                                    <tr>
                                        <th style="width: 24px !important;">
                                            <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                        <th><%=Resources.Resource.name %></th>
                                        <th><%=Resources.Resource.code %></th>
                                        <th style="width: 24px !important;">1</th>
                                        <th style="width: 24px !important;">2</th>
                                        <th style="width: 24px !important;">3</th>
                                        <th style="width: 24px !important;">4</th>
                                        <th style="width: 24px !important;">5</th>
                                        <th style="width: 24px !important;">6</th>
                                        <th style="width: 24px !important;">7</th>
                                        <th style="width: 24px !important;">8</th>
                                        <th style="width: 24px !important;">9</th>
                                        <th style="width: 24px !important;">10</th>
                                        <th style="width: 24px !important;">11</th>
                                        <th style="width: 24px !important;">12</th>
                                        <th style="width: 24px !important;">13</th>
                                        <th style="width: 24px !important;">14</th>
                                        <th style="width: 24px !important;">15</th>
                                        <th style="width: 24px !important;">16</th>
                                        <th style="width: 24px !important;">17</th>
                                        <th style="width: 24px !important;">18</th>
                                        <th style="width: 24px !important;">19</th>
                                        <th style="width: 24px !important;">20</th>
                                        <th style="width: 24px !important;">21</th>
                                        <th style="width: 24px !important;">22</th>
                                        <th style="width: 24px !important;">23</th>
                                        <th style="width: 24px !important;">24</th>
                                        <th style="width: 24px !important;">25</th>
                                        <th style="width: 24px !important;">26</th>
                                        <th style="width: 24px !important;">27</th>
                                        <th style="width: 24px !important;">28</th>
                                        <th style="width: 24px !important;">29</th>
                                        <th style="width: 24px !important;">30</th>
                                        <th style="width: 24px !important;">31</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Aqeel</td>
                                        <td>aqeel</td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>TEST USER</td>
                                        <td>test</td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                        <td class="droppable"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <br />

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
                                    <a id="btnSave" onclick="return Save()" style='margin: 0px 5px;' class="btn blue"><i class="icon-plus">&nbsp; <%=Resources.Resource.save %></i></a>
                                    <a id="btnFinlaize" onclick="return Finalize()" style='margin: 0px 5px;' class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.finalize %></i></a>
                                    <a id="btnClear" onclick="return ClearRoster()" style='margin: 0px 5px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.clear %></i></a>
                                </span>
                            </div>
                        </div>

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
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>

    <!--Script references. -->
    <!--Reference the SignalR library. -->
    <script src="../Scripts/jquery.signalR-1.1.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="../signalr/hubs"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
    <script src="../assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">

        $(document).ready(function () {
            App.init(); // initlayout and core plugins

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liSch").addClass("active");
            $("#liSch .arrow").addClass("open");
            $("#liSchRoster").addClass("active");

            LoadOrganizations();
            LoadYears();
            LoadSchedules();

            $("#spnSchedule9").draggable({ revert: true });


            $("#ddOrg").change(function () {
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

            // Declare a proxy to reference the hub. 
            var users = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            users.client.broadcastMessage = function (name, message) {
                if (name == "TAMSR2_Cmp_SchTypes") {
                    //ReloadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Cmp_SchTypes', '');
                    // Clear text box and reset focus for next comment. 
                });
            });
        });

        function ReloadGrid() {
            $('#sample_1').dataTable().fnDraw();
        }

        function LoadOrganizations() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   $("#ddOrg").html(html);
                   $('#ddOrg option[value=<%= Session["orgID"] %>]').attr('selected', 'selected');
                   $("#ddOrg").trigger("liszt:updated");
                   LoadGrid();
                   //$("#form_sample_1").unmask();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
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

       function LoadSchedules() {
           var d = "key=getAllTags";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ScheduleTimePage.aspx") %>',
               success: function (html) {
                   $("#divSchedules").html(html);
                   $(".draggable").draggable({ helper: "clone", revert: true });
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

       function LoadGrid() {
           //var curYear = new Date().getFullYear();
           //var curMonth = new Date().getMonth() + 1;
           var d = "&orgID=" + $("#ddOrg").val() + "&year=" + $("#ddYear").val() + "&month=" + $("#ddMonth").val();

           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumnDefs": [
                 { "sClass": "", "aTargets": [0] },
                 { "sClass": "", "aTargets": [1] },
                 { "sClass": "", "aTargets": [2] },
                 { "sClass": "droppable", "aTargets": [3] },
                 { "sClass": "droppable", "aTargets": [4] },
                 { "sClass": "droppable", "aTargets": [5] },
                 { "sClass": "droppable", "aTargets": [6] },
                 { "sClass": "droppable", "aTargets": [7] },
                 { "sClass": "droppable", "aTargets": [8] },
                 { "sClass": "droppable", "aTargets": [9] },
                 { "sClass": "droppable", "aTargets": [10] },
                 { "sClass": "droppable", "aTargets": [11] },
                 { "sClass": "droppable", "aTargets": [12] },
                 { "sClass": "droppable", "aTargets": [13] },
                 { "sClass": "droppable", "aTargets": [14] },
                 { "sClass": "droppable", "aTargets": [15] },
                 { "sClass": "droppable", "aTargets": [16] },
                 { "sClass": "droppable", "aTargets": [17] },
                 { "sClass": "droppable", "aTargets": [18] },
                 { "sClass": "droppable", "aTargets": [19] },
                 { "sClass": "droppable", "aTargets": [20] }
               ],
               "aoColumns": [
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false },
                 { "bSortable": false }
               ],
               "oLanguage": {
                   "sLengthMenu": "_MENU_ records per page"
               },
               "fnInitComplete": function () {
                   $("#sample_1 th").removeClass("sorting_disabled droppable ui-droppable");
                   $(".droppable").droppable({
                       drop: function (event, ui) {
                           $(this).css("background-color", ui.draggable.attr("color"));
                           $(this).attr("schId", ui.draggable.attr("schId"));
                           $(this).attr("code", ui.draggable.attr("code"));
                           $(this).html("X");
                           $(this).click(function () {
                               $(this).css("background-color", "White");
                               $(this).html("");
                           });
                       }
                   });

               },
               "aaSorting": [[1, "desc"]],
               "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/ScheduleRosterPage.aspx?key=getAll") %>' + d
           });
           $("#sample_1 th").removeClass("sorting_disabled droppable ui-droppable");
           $(".droppable").droppable({
               drop: function (event, ui) {
                   $(this).css("background-color", ui.draggable.attr("color"));
                   $(this).attr("schId", ui.draggable.attr("schId"));
                   $(this).attr("code", ui.draggable.attr("code"));
                   $(this).html("X");
                   $(this).click(function () {
                       $(this).css("background-color", "White");
                       $(this).html("");
                   });
               }
           });
       }

       function Save() {
           //save the current schedule roster for all employee for select month untill manager make any change
           //but its not finalize
       }

       function Finalize() {
           //finalize the current version of roster for next months untill manager will agin update.
       }

       function ClearRoster() {
           //remove schedules for all employee
           $("#sample_1 td").attr("backgrround-color", "");
           $("#sample_1 td").html("");
       }

    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
