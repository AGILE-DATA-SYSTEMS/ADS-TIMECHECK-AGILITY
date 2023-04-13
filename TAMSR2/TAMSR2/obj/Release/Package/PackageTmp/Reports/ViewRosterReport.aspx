<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewRosterReport.aspx.cs" Inherits="TAMSR2.Reports.ViewRosterReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.monthlyRoster %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="../Assets/<%= languageStr %>/Styles/jquery.loadmask.css" rel="stylesheet" />
    <link href='../Assets/<%= languageStr %>/css/pages/login.css' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../Assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.css" />

    <script type="text/javascript" src="../Assets/<%= languageStr %>plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>

    <script type="text/javascript" src="../Assets/<%= languageStr %>/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
    <!-- END PAGE LEVEL STYLES -->


    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-fileupload/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/select2/select2_metro.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/clockface/css/clockface.css" />

    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />

    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-toggle-buttons/static/stylesheets/bootstrap-toggle-buttons.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/daterangepicker.css" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <div class="page-container row-fluid">

        <!-- BEGIN PAGE -->
        <div class="page">
            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

            <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
            <!-- BEGIN PAGE CONTAINER-->
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <h3 class="page-title"><%= Resources.Resource.monthlyRoster %>
                        </h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
					            <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="#"><%= Resources.Resource.report %></a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li><a href="#"><%= Resources.Resource.reportWizard %></a></li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT0-->
                <div class="row-fluid">
                    <div class="span12">
                        <div class="portlet box blue" id="form_wizard_1">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="icon-reorder"></i><%= Resources.Resource.reportWizard %> <span class="step-title" id="step"></span>
                                </div>
                                <%-- <div class="tools hidden-phone">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="#portlet-config" data-toggle="modal" class="config"></a>
                           <a href="javascript:;" class="reload"></a>
                           <a href="javascript:;" class="remove"></a>
                        </div>--%>
                            </div>
                            <div class="portlet-body form">
                                 <form action="#" id="form_1" class="form-horizontal">
                                        <%--<div onclick="ChangeLang()" style="display: inline; float: <%= pullDirectionStr%>; cursor: pointer;"> <%= Session["changeLanguage"] + "" %></div>
                                        --%>

                                         <div class="row-fluid">
                                            <div class="span12">
                                                <h3 class="block"><%=Resources.Resource.monthlyRoster %></h3>
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
                                                            <label class="control-label"><%=Resources.Resource.manager %><span class="required">*</span></label>
                                                            <div class="controls chzn-controls">
                                                                <select id="ddManager" name="Group" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.manager %>">
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
                                <label class="control-label"><%=Resources.Resource.year %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                     <select id="ddYear" name="year" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
                                               <option value=""></option>
                                      </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.employee %><span class="required">*</span></label>
                                <div class="controls chzn-controls">

                                    <select id="ddEmp" name="org" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>">
                                     <option value=""></option>
                                     </select>
                                   <%-- <asp:DropDownList runat="Server" id="ddEmp" name="employee" ru style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.year %>">
                                        
                                    </asp:DropDownList>--%>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>

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
                    </div>
                                              
                                            </div>
                                             </div>


                                            <div class="form-actions clearfix">
                                               <%-- <asp:Button runat="Server" ID="ViewReport" CssClass="btn blue" Text="" />
                                               --%>      <%--<i class="m-icon-swapright m-icon-white"></i>
                                               --%>
                                               <%-- <asp:LinkButton runat="Server"  href="javascript:;" class="btn blue button-next" id="btnViewReport">
                                                    <i class="m-icon-swapright m-icon-white"></i>
                                                </asp:LinkButton>--%>
                                                <a href="javascript:;" class="btn green button-next" id="btnViewReport">
                                                    <%=Resources.Resource.showReport %> 
                                                    <i class="m-icon-swapright m-icon-white"></i>
                                                </a>
                                               <a href="javascript:;" class="btn blue button-next" id="btnExcelDownload">
                                                    <%=Resources.Resource.exportExcel %> <i class="m-icon-swapright m-icon-white"></i>
                                                </a>
                                               
                                                <a href="javascript:;" class="btn blue button-next" id="btnWordDownload">
                                                    <%=Resources.Resource.exportWord %> <i class="m-icon-swapright m-icon-white"></i>
                                                </a>
                                                <a href="javascript:;" class="btn blue button-next" id="btnPdfDownload" style="display:none;"    >                                                <%=Resources.Resource.exporttopdf %> <i class="m-icon-swapright m-icon-white"></i>
                                                </a>
                                                <a href="javascript:;" class="btn button-previous" id="btnCancel" style="display:none;"  >
                                                    <%=Resources.Resource.cancel %> 
                                                </a>
                                            </div>
                                       
                                </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                 
                    <!-- END PAGE CONTENT-->
            
            <!-- END PAGE CONTAINER-->
        </div>
        <!-- END PAGE -->
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
    <%--<script src="../Scripts/jquery.signalR-1.1.0.min.js"></script>--%>
    <%--<!--Reference the autogenerated SignalR hub script. -->
    <script src="../signalr/hubs"></script>

    --%><!-- END PAGE LEVEL PLUGINS -->

    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
    <script src="../assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>
    <script src="../Scripts/jquery.loadmask.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
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
            $("#liRpt").addClass("active");
            $("#liRpt .arrow").addClass("open");
            $("#liStd").addClass("active");
            $("#liStd .arrow").addClass("open");
            $("#liRosterReport").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

            LoadOrganizations();
            LoadYears();
            $("#ddOrg").change(function () {
                LoadManager();
                LoadEmployees();
            });

            $("#ddManager").change(function () {
                     LoadEmployees();
            });
        });
        $("#btnViewReport").click(function () {
            
            ShowReport('viewreport');
        })
        $('#btnExcelDownload').click(function () {
            ShowReport('ExcelDownload');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });
        $('#btnPdfDownload').click(function () {
            ShowReport('PdfDownload');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });
        $('#btnWordDownload').click(function () {
            ShowReport('WordDownload');
            // $('#tab2').hide();
            //   $('#tab3').show();

        });
            function ShowReport(action)
            { 
                var EmpID = $("#ddEmp option:selected").val();
                var Year = $("#ddYear option:selected").val();
                var Month = $("#ddMonth option:selected").val();
                var Org = $("#ddOrg option:selected").val();
                var MgrId = $("#ddManager option:selected").val();

                var OrgName = $("#ddOrg option:selected").text();
                var EmpName = $("#ddEmp option:selected").text();
              
                var d = "key=ShowRosterReport&Org=" + Org + "&Year=" + Year + "&Month=" + Month + "&EmpID=" + EmpID + "&MgrId=" + MgrId + "&EmpName=" + EmpName + "&OrgName=" + OrgName;
                $("#form_1").mask("<%=Resources.Resource.processing %>" + "....");
                $.ajax({
                    url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                    type: 'POST',
                    data: d,
                    success: function (html) {
                        $("#form_1").unmask();
                        if (action == 'viewreport') {
                            window.open('../Reports/RosterReport.aspx?key=viewreport', '_blank', 'toolbar=0,scrollbars=1,location=0,menubar=0,resizable=yes');
                        }
                        else if (action == 'ExcelDownload') {
                            window.location.href = ('../Reports/RosterReport.aspx?key=excel')
                        }
                        else if (action == 'WordDownload') {
                            window.location.href = ('../Reports/RosterReport.aspx?key=word');
                        }
                        else if (action == 'PdfDownload') {
                            window.location.href = ('../Reports/RosterReport.aspx?key=pdf');
                        }
                    },
                    error: function (html) {
                        $("#form_1").unmask();
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                        
                    }
                });
            }

            function LoadOrganizations() {
                var d = "key=getIdNameListString";

                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
                    success: function (html) {
                        $("#ddOrg").html(html);
                        $('#ddOrg option[value=<%= Session["orgID"] %>]').attr('selected', 'selected');
                        $("#ddOrg").trigger("liszt:updated");
                        LoadManager();
                        LoadEmployees();
                       // LoadGrid();
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
                });
            }

            function LoadEmployees() {
                $("#divErrorMsg").css("display", "none");
                $("#spnSuccessMsg").css("display", "none");

                var d = "key=getIdNameListByOrgID&orgID=" + $("#ddOrg").val() + "&managerID=" + $("#ddManager").val();
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                    success: function (html) {
                        $("#ddEmp").html(html);
                        $("#ddEmp").trigger("liszt:updated");
                        //LoadGrid();
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
                });
            }
        function LoadManager() {
            $("#page-content").mask("<%=Resources.Resource.processing %>" + "....");
             $("#spnErrorMsg").css("display", "none");
             $("#spnSuccessMsg").css("display", "none");

             var d = "key=getMgrIdNameListString&orgID=" + $("#ddOrg").val();
             $("#page-content").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                success: function (html) {

                    $("#page-content").unmask();
                    $("#ddManager").html(html);
                    $("#ddManager").trigger("liszt:updated");

                },
                error: function (html) {
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    $("#page-content").unmask();
                    $("#spnErrorMsg").css("display", "block");
                    $("#btnAlertError").click();
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
    </script>
</asp:Content>
