<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewMonthLock.aspx.cs" Inherits="TAMSR2.EmpMonthLock.ViewMonthLock" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.monthLock %> - <%=Resources.Resource.applicationName %></title>

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
     <div id="divVerificationForm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="divVerificationForm" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h3 id="H2"><%=Resources.Resource.alert %></h3>
        </div>
        <div class="modal-body">
            <div id="spnVerification" style="font-size: 12px;"><%=Resources.Resource.intendedZeroValues %></div>
        </div>
        <div class="modal-footer">
            <button onclick="return SetIntendedValueFlag()" class="btn icn-only green"><%=Resources.Resource.yes %></button>
            <button id="btnHideVerificationPopup" data-dismiss="modal" class="btn danger"><%=Resources.Resource.no %></button>
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
                    <%=Resources.Resource.monthLock %> 
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.monthLock %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.monthLock %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN FORM-->
                <form action="#" id="form_1" class="form-horizontal"  >
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
                                <label class="control-label"><%=Resources.Resource.month %></label>
                                <div class="controls chzn-controls">
                                  
                                    <select id="ddMonth" name="month" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.month %>">
                                        <option value=""><%=Resources.Resource.choose %> <%=Resources.Resource.month %></option>
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
                    </div>
                    <!--/row--> 
                </form>
                <!-- END FORM-->
 

                <!-- END FORM-->
                <div style="min-height: 20px; clear: both;">&nbsp;</div>
                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box light-grey">
                    <div class="portlet-title">
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.monthLock %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return LoadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="Span3">&nbsp;</span>
                            </div>
                            <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                <span id="spnAddButton" runat="server">
                                    <a id="btnAdd" onclick="return PreSave('save')" href="javascript:void(0);" data-toggle="modal" class="btn green"><i class="icon-lock">&nbsp; <%=Resources.Resource.btnlock %></i></a>
                                </span>
                                <span id="spnDeleteButton" runat="server">
                                    <a id="btnDelete" onclick="return PreSave('delete')" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                </span>
                            </div>
                        </div>
                        <div style=" overflow-y: hidden; padding: 20px 0px; max-width:100% !important;" >
                            <table class="table table-striped table-bordered table-hover" id="sample_1" style=" max-width:100% !important;">
                                <thead>
                                  <tr style="background-color: #e8e3e3;">
                                     <th style="text-align: center;width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                     <th style="text-align: center;"><%=Resources.Resource.organization %></th>
                                     <th style="text-align: center;"><%=Resources.Resource.year %></th>
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.month %></th>
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.status %></th>
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.details %></th> 
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.updatedBy %></th>
                                     <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.updatedOn %></th> 
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
                <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>

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

        var requestType = "";
        var isIntendedValues = false;
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

            $("#liMonthLockMain").addClass("active");
            $("#liMonthLockMain .arrow").addClass("open");
            $("#liMonthLock").addClass("active");
            $("#liMonthLock .arrow").addClass("open");
            $("#liMonthLock").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }
            
            LoadYears();
            LoadGrid();

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
                if (name == "TAMSR2_MonthLock") {
                    LoadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_MonthLock', '');
                    // Clear text box and reset focus for next comment. 
                });
            });
        });
         
         

        function LoadYears() {
            var curMonth = new Date().getMonth() + 1; 
            var curYear = new Date().getFullYear();
            var k = curYear - 3;
            var val = curYear + 4;
            var temp = "<option value=''><%=Resources.Resource.choose %>  <%=Resources.Resource.year %></option>";
                while (k <= val) {
                    if (k == curYear) {
                        temp += "<option  value='" + k + "'>" + k + "</option>";
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
            var urlStr = '<%= Page.ResolveClientUrl("../RequestPages/MonthLockPage.aspx?key=getAll") %>' + '&Year=' + $("#ddYear").val() + '&Month=' + $("#ddMonth").val();
             
            ////////Get Users and load in grid/////////
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  { "bSortable": false  },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true },
                  { "bSortable": true }, 
                  { "bSortable": false }
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
               "sAjaxSource": urlStr
            }); 
        }

        function FreezeMonth() {

            $("#divErrorMsg").css("display", "none");
            $("#divSuccessMsg").css("display", "none"); 

            var year = $("#ddYear").val();
            var month = $("#ddMonth").val(); 
            if (year == "" || month == "") {
                $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>" +" " +"<%=Resources.Resource.msgSelectYearOrMonth %>");
                $("#divErrorMsg").css("display", "block");
                return false;
            }
            if (!isIntendedValues) {
                return;
            };
            isIntendedValues = false;

            var d = "key=save&Year="+year+"&month="+month; 
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/MonthLockPage.aspx") %>',
                success: function (html) {
                    if (html == 'Success' || html == 'success') {
                        //success
                        $("#divSuccessMsg").css("display", "block");
                        $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                        $('#btnBroadCast').click();
                    }
                    else {
                        //failed
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html(html);
                    } 
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }
         
        function Delete() {
            var v = "key=DeleteByIDs" + '&ID=' ;

            $("#divSuccessMsg").css("display", "none");
            $("#divErrorMsg").css("display", "none");

            var k = 0;
            var id = "";
            $("#sample_1 tbody").find("input:checkbox").each(function () {
                if (this.checked == true) {
                    k++;
                    id += this.value + ",";
                    //this.checked = chk.checked;
                }
            });
            id = id.slice(0, id.length - 1);
            v += id; 
            if (k == 0) {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
               return;
            }
            if (!isIntendedValues) {
                return;
            };

            isIntendedValues = false;
             
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/MonthLockPage.aspx") %>',
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


        function PreSave(type) {

            $("#divSuccessMsg").css("display", "none");
            $("#divErrorMsg").css("display", "none");
            requestType = type; 
            if (type == "delete") {
                $("#spnVerification").html("<%=Resources.Resource.deleteMessage %>");
               $('#divVerificationForm').modal('show');
           }
           else if (type == "save") {
               $("#spnVerification").html("<%=Resources.Resource.msgConfirmSave %>");
                   $('#divVerificationForm').modal('show');
               }
       }
       function SetIntendedValueFlag() {
           isIntendedValues = true;
           $('#divVerificationForm').modal('hide');
       }

       $('#divVerificationForm').on('hidden.bs.modal', function (e) {

           if (requestType != "" && requestType == "delete")
               Delete();
           else if (requestType != "" && requestType == "save")
               FreezeMonth();
       })
    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
