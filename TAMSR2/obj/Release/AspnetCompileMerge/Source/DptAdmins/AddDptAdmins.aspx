<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddDptAdmins.aspx.cs" Inherits="TAMSR2.DptAdmins.AddDptAdmins" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.addDeptAdmins %> - <%=Resources.Resource.applicationName %></title>
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
                    <%=Resources.Resource.addDeptAdmins %>	
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
                    <li><a href='<%= Page.ResolveClientUrl("~/Emp/Employee-Delegate") %>'><%=Resources.Resource.addDeptAdmins %></a></li>

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
                        <%--<button class="close" data-dismiss="alert"></button>--%>
                        <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                    </div>
                    <div id="divSuccessMsg" class="alert alert-success hide">
                        <%--<button class="close" data-dismiss="alert"></button>--%>
                        <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                    </div>
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.fromDate %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.toDate %> <span class="required">*</span></label>
                                <div class="controls">
                                    <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.organizationFilter %><span class="required">*</span></label>
                                <div class="controls chzn-controls">
                                    <select id="ddOrgFilter" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>" tabindex="1">
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                        <div class="span6 ">
                            <div class="control-group">
                                <label class="control-label">&nbsp;</label>
                                <div class="controls">
                                    <input id="chkboxStatus" type="checkbox" name="status" />
                                    <%=Resources.Resource.status %>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span12 ">
                            <div class="control-group">
                                <div style="padding: 20px;">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="padding: 0px 5px;">
                                                <div class="control-group" style="font-weight: bold; text-align: center !important;"><%=Resources.Resource.allEmployees %></div>
                                            </td>
                                            <td style="padding: 0px 5px;"></td>
                                            <td style="padding: 0px 5px;">
                                                <div class="control-group" style="font-weight: bold; text-align: center !important;"><%=Resources.Resource.selectedEmployees %></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0px 5px;">
                                                <input type="text" id="txtSrchEmp" class="span6 m-wrap" style="min-width: 200px; width:95%" />
                                            </td>
                                            <td style="padding: 0px 5px;"></td>
                                            <td style="padding: 0px 5px;">
                                                 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0px 5px; width: 45%;">
                                                <select id="ddFromEmployee" name="ddFromEmployee" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                </select>
                                            </td>
                                            <td style="padding: 0px 5px; width: 10%;">
                                                <div>
                                                    <input type="button" id="btnAddEmployee" onclick="AddEmployee()" value="  >>  " />
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <input type="button" id="btnRemoveEmployee" onclick="RemoveEmployee()" value="  <<  " />
                                                </div>
                                            </td>
                                            <td style="padding: 0px 5px; width: 45%;">
                                                <select id="ddToEmployee" name="ddToEmployee" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0px 5px;">
                                                <div class="control-group" style="font-weight: bold; text-align: center !important;"><%=Resources.Resource.allOrganizations %></div>
                                            </td>
                                            <td style="padding: 0px 5px;"></td>
                                            <td style="padding: 0px 5px;">
                                                <div class="control-group" style="font-weight: bold; text-align: center !important;"><%=Resources.Resource.selectedOrganizations %></div>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td style="padding: 0px 5px;">
                                                <input type="text" id="txtSrchOrg" class="span6 m-wrap" style="min-width: 200px; width:95%" />
                                            </td>
                                            <td style="padding: 0px 5px;"></td>
                                            <td style="padding: 0px 5px;">
                                                 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 0px 5px; width: 45%;">
                                                <select id="ddFromOrg" name="ddFromOrg" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                </select>
                                            </td>
                                            <td style="padding: 0px 5px; width: 10%;">
                                                <div>
                                                    <input type="button" id="btnAddOrg" onclick="AddOrg()" value="  >>  " />
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <input type="button" id="btnRemoveOrg" onclick="RemoveOrg()" value="  <<  " />
                                                </div>
                                            </td>
                                            <td style="padding: 0px 5px; width: 45%;">
                                                <select id="ddToOrg" name="ddToOrg" style="width: 95%; min-height: 200px !important;" tabindex="1" data-placeholder="Choose a Category" multiple="multiple" class="span6 m-wrap">
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!--/span-->
                    </div>
                    <!--/row-->
                    <div class="row-fluid">
                        <div class="span12 ">
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.remarks %></label>
                                <div class="controls">
                                    <textarea id="txtRemarks" name="remarks" onkeydown="return imposeMaxLength(this, event, 490);" data-required="1" rows="3" class="medium m-wrap" style="width: 86% !important; resize: none;"></textarea>
                                </div>
                            </div>
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
            <span id="spnDlg">0</span>&nbsp;
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
        var tempOrg = false;
        var tempEmp = false;
        var tempFeature = false;

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
            $("#liEmp").addClass("active");
            $("#liEmp .arrow").addClass("open");
            $("#liViewDeptAdmins").addClass("active");


            $("#chkboxStatus").attr("checked", "checked");
            $("#uniform-chkboxStatus span").addClass("checked");

            LoadOrgFilterList();
           // LoadEmployeeDeptAdminList();
            LoadEmployeeNotDeptAdminList();
           // LoadOrgDeptAdminList();
            var dlg = $('#spnDlg').text();
            if (dlg == "" || dlg == "0" || dlg == "MA==") {
                GetFeaturesNotInDelegByDelegID(0);
                
                
            }
            if (dlg != "" || dlg != "0" || dlg != "MA==") {
             //   alert(dlg);
                Edit(dlg);
            }

            $('#ddOrgFilter').change(function () {
                LoadEmployeeNotDeptAdminList();
            });
             
            $('#txtSrchEmp').keypress(function () {
                LoadEmployeeNotDeptAdminList();
            });

            $('#txtSrchOrg').keypress(function () {
                LoadOrgNotDeptAdminList();
            });

           
            
            // Declare a proxy to reference the hub. 
            var users = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            users.client.broadcastMessage = function (name, message) {
                if (name == "TAMSR2_Emp_Leaves") {
                    //ReloadGrid();
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

        //START - User confirmation before leaving page
        window.onbeforeunload = Unload_Call;
        function Unload_Call() {
            var Message = "Are you sure to leave this page?";
            if ($("#txtFromDate").val() != "" || $("#txtToDate").val() != "")
                return Message;

        }
        //END - User confirmation before leaving page


        function LoadOrgNotDeptAdminList() {
            var search = $('#txtSrchOrg').val();

            var d = "key=getIdNameListString" + "&SearchFilter=" + search; 
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    
                    $("#ddFromOrg").html(html);
                    $("#ddFromOrg").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    tempOrg = true;
                    var dlg = $('#spnDlg').text();
                    if (dlg != "" && dlg != "0" && dlg != "MA==" && tempEmp == true && tempOrg == true) {
                        Edit(dlg);
                    }
                },
                error: function (html) {
                    
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadOrgDeptAdminList(ID) {
            var d = "key=GetSelectedDeptList&ID=" + ID;
            
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                success: function (html) {
            //        alert(html);
                    $("#ddToOrg").html(html);
                    $("#ddToOrg").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    tempOrg = true;
                    //var dlg = $('#spnDlg').text();
                    //if (dlg != "" && dlg != "0" && dlg != "MA==" && tempEmp == true && tempOrg == true) {
                    //    Edit(dlg);
                    //}
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadSeletedEmployeeList(ID) {
            var d = "key=GetSelectedEmployeeList&ID=" + ID;

            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                success: function (html) {
                    //        alert(html);
                    $("#ddToEmployee").html(html);
                    $("#ddToEmployee").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    tempOrg = true;
                    //var dlg = $('#spnDlg').text();
                    //if (dlg != "" && dlg != "0" && dlg != "MA==" && tempEmp == true && tempOrg == true) {
                    //    Edit(dlg);
                    //}
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }


        function LoadOrgFilterList() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                success: function (html) {
                    $("#ddOrgFilter").html(html);
                    $("#ddOrgFilter").trigger("liszt:updated");
                    $("#ddFromOrg").html(html);
                    $("#ddFromOrg").trigger("liszt:updated");
                    //$("#form_sample_1").unmask();
                    LoadEmployeeNotDeptAdminList();
                    tempOrg = true;
                    var dlg = $('#spnDlg').text();
                    //if (dlg != "" && dlg != "0" && dlg != "MA==" && tempEmp == true && tempOrg == true) {
                    //    Edit(dlg);
                    //}
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadEmployeeNotDeptAdminList() {

            var search = $('#txtSrchEmp').val();

            var d = "key=getEmployeeNotDeptAdmin&orgID=" + $("#ddOrgFilter").val()+"&SearchFilter=" + search;
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                success: function (html) {
                    $("#ddFromEmployee").html(html);
                    $("#ddFromEmployee").trigger("liszt:updated");
                    $("#ddFromEmployee option[value=<%= Session["ID"] + "" %>]").remove();
                    //$("#form_sample_1").unmask();
                    tempEmp = true;
                    //var dlg = $('#spnDlg').text();
                    //if (dlg != "" && dlg != "0" && dlg != "MA==" && tempEmp == true && tempOrg == true) {
                    //    Edit(dlg);
                    //}
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function LoadEmployeeDeptAdminList() {
            var dlg = $('#spnDlg').text();
            if (!(dlg != "" && dlg != "0" && dlg != "MA=="))
                return;
            var d = "key=getEmployeeDeptAdmin&ID=" + $("#ddOrgFilter").val(); 
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                success: function (html) {
                    $("#ddToEmployee").html(html);
                    $("#ddToEmployee").trigger("liszt:updated");
                    $("#ddToEmployee option[value=<%= Session["ID"] + "" %>]").remove();
                    //$("#form_sample_1").unmask();
                    tempEmp = true;
                    //var dlg = $('#spnDlg').text();
                    //if (dlg != "" && dlg != "0" && dlg != "MA==" && tempEmp == true && tempOrg == true) {
                    //    Edit(dlg);
                    //}
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
        }

        function GetFeaturesNotInDelegByDelegID(dID) {
            $("#ddFromUser").html("<option value=''></option>");
            var d = "key=getFeatureListNotDelegetedByID&rID=" + dID;
            d = "key=getIdNameListByOrgID&orgID=" + $("#ddOrgFilter").val();
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   $("#ddFromEmployee").html(html);
                   $("#ddFromEmployee").trigger("liszt:updated");
                   $("#ddFromEmployee option[value='']").remove();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
               }
           });
       }

        function AddEmployee() {
           var arr = $("#ddFromEmployee").val();
           var txt = $("#ddFromEmployee option:selected").text();
           var chk = false;
           $.each(arr, function (index, val) {
               if (0 == $('#ddToEmployee option[value=' + val + ']').length) {
                   $('#ddToEmployee').append($('<option>', {
                       value: val,
                       text: $("#ddFromEmployee option[value='" + val + "']").text()
                   }));
               }
               $("#ddFromEmployee option[value='" + val + "']").remove();               
           });
       }

        function RemoveEmployee() {
           var arr = $("#ddToEmployee").val();
           var txt = $("#ddToEmployee option:selected").text();

           $.each(arr, function (index, val) {
               if (0 == $('#ddFromEmployee option[value=' + val + ']').length) {
                   $('#ddFromEmployee').append($('<option>', {
                       value: val,
                       text: $("#ddToEmployee option[value='" + val + "']").text()
                   }));
               }
               $("#ddToEmployee option[value='" + val + "']").remove();
           });
        }

        function AddOrg() {
            var arr = $("#ddFromOrg").val();
            var txt = $("#ddFromOrg option:selected").text();

            $.each(arr, function (index, val) {
                if (0 == $('#ddToOrg option[value=' + val + ']').length) {
                    $('#ddToOrg').append($('<option>', {
                        value: val,
                        text: $("#ddFromOrg option[value='" + val + "']").text()
                    }));
                }
                $("#ddFromOrg option[value='" + val + "']").remove();
            });
        }

        function RemoveOrg() {
            var arr = $("#ddToOrg").val();
            var txt = $("#ddToOrg option:selected").text();

            $.each(arr, function (index, val) {
                if (0 == $('#ddFromOrg option[value=' + val + ']').length) {
                    $('#ddFromOrg').append($('<option>', {
                        value: val,
                        text: $("#ddToOrg option[value='" + val + "']").text()
                    }));
                }
                $("#ddToOrg option[value='" + val + "']").remove();
            });
        }

       function GetFeaturesInDelegByDelegID(dID) {
           $("#ddToUser").html("<option value=''></option>");
           var d = "key=getFeatureListDelegetedByID&rID=" + dID;
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/DelegateFeaturePage.aspx") %>',
               success: function (html) {
                   $("#ddToEmployee").html(html);
                   $("#ddToEmployee").trigger("liszt:updated");
                   $("#ddToEmployee option[value='']").remove();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
               }
           });
       }

       function CloseForm() {
           window.location = '<%= Page.ResolveClientUrl("~/Emp/Department-Admins") %>';
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
            $("#txtRemarks").val("");

            $('#ddOrg option[value=""]').attr('selected', 'selected');
            $("#ddOrg").trigger("liszt:updated");
            
            
            $('#ddToOrg').html('');
            $('#ddToEmployee').html('');

            $("#chkboxStatus").attr("checked", "checked");
            $("#uniform-chkboxStatus span").addClass("checked");
            //$("#txtCategory").val("");
            //$("#txtService").val("");
        }

        function Edit(id) {
            //Edit code
            var v = "key=getByID&id=" + id;
           // $("#btnAdd").click();
            $("#spnGridMsg").html("&nbsp;");
           // alert('P');
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                success: function (html) {
                  //  alert(html);
                    if (html != "") {
                        var j = $.parseJSON(html);

                        $("#spnID").val(j.ID);
                        if (j.ID == "0") {
                            $("#spnID").html(j.ID);
                            return;
                        }// alert(j.FromDateStr + j.ToDateStr);
                        if (j.FromDateStr != '') {
                            $('#txtFromDate').datepicker({ format: 'yyyy-mm-dd' });
                            $("#txtFromDate").datepicker('update', j.FromDateStr);
                            //  $('.date-picker').datepicker('setStartDate', j.JoinDateStr);
                        }
                        else {
                           $("#txtFromDate").datepicker({
                                format: " yyyy",
                                viewMode: "days",
                                minViewMode: "years"
                            });
                        }
                        if (j.ToDateStr != '') {
                            $('#txtToDate').datepicker({ format: 'yyyy-mm-dd' });

                            $("#txtToDate").datepicker('update', j.ToDateStr);
                            //  $('.date-picker').datepicker('setStartDate', j.JoinDateStr);
                        }
                        else {
                            $("#txtToDate").datepicker({
                                format: " yyyy",
                                viewMode: "days",
                                minViewMode: "years"
                            });
                        }
                     //   alert(j.remarks);
                        $("#txtRemarks").val(j.remarks);
                        $('#ddEmployee option[value=' + j.EmployeeID + ']').attr('selected', 'selected');
                        $("#ddEmployee").trigger("liszt:updated");
                        //$('#ddOrg option[value=' + j.OrgID + ']').attr('selected', 'selected');
                        //$("#ddOrg").trigger("liszt:updated");

                        if (j.Status.toLowerCase() + "" == "true") {
                            $("#chkboxStatus").attr("checked", "checked");
                            $("#uniform-chkboxStatus span").addClass("checked");
                        }
                        else {
                            $("#chkboxStatus").removeAttr("checked");
                            $("#uniform-chkboxStatus span").removeClass("checked");
                        }
                        LoadOrgDeptAdminList(j.ID);
                        LoadSeletedEmployeeList(j.ID)
                       
                    }
                },
                error: function (html) {

                }
            });
        }

        function imposeMaxLength(Object, evt, MaxLen) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
            return (Object.value.length < MaxLen);
        }

        function Save() {

            $("#divSuccessMsg").css("display", "none");
            $("#divErrorMsg").css("display", "none");

            var id = $('#spnDlg').text();

            var valuesToEmployee = $.map($('#ddToEmployee option'), function (e) { return e.value; });
            var empID = valuesToEmployee.toString();
            var valuesToOrg = $.map($('#ddToOrg option'), function (e) { return e.value; });
            var orgID = valuesToOrg.toString();

            if (empID == "") {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.selectOneEmployee %>");
                return false;
            }
            if (orgID == "") {
                $("#divErrorMsg").css("display", "block");
                $("#spnErrorMsg").html("<%=Resources.Resource.selectOneOrg %>");
                return false;
            }

            var fromDate = $("#txtFromDate").val();
            var toDate = $("#txtToDate").val();
            var remarks = $("#txtRemarks").val();
            var status = $("#chkboxStatus").is(":checked");

            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }
            var v = "key=save" + "&id=" + id + "&empID=" + empID + "&orgID=" + orgID + "&status=" + status;
            v += "&fromDate=" + fromDate + "&toDate=" + toDate + "&remarks=" + remarks;
            if (confirm("<%=Resources.Resource.confirmsave %>")) {
                $.ajax({
                    type: 'POST',
                    data: v,
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/DeptAdminPage.aspx") %>',
                    success: function (html) {
                        if (html == '-1') {
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
                            $('#btnBroadCast').click();
                            if ($('#spnDlg').text() + "" != "" && $('#spnDlg').text() + "" != "MA==") {
                                $('#btnCloseForm').click();
                            }
                            Clear();
                            //LoadOrgFilterList();
                            //LoadEmployeeDeptAdminList();
                            LoadEmployeeNotDeptAdminList();
                        }
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("Error! " + html);
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

            $("#txtFromDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
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
                        },
                        toDate: {
                            required: true
                        }
                    },

                    messages: { // custom messages for radio buttons and checkboxes
                        
                        fromDate: {
                            required: "<%=Resources.Resource.lblRequired %>"
                        },
                        toDate: {
                            required: "<%=Resources.Resource.lblRequired %>"
                        }
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
