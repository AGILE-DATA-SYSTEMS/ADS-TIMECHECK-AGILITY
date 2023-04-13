<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewEmployeeGroups.aspx.cs" Inherits="TAMSR2.Details.ViewEmployeeGroups" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.employeeGroups %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- BEGIN EMPLOYEE GROUP MODAL FORM-->
    <div id="portlet-config" class="modal hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.employeeGroups %></h4>
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
                                    <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="text" id="txtCode" name="code" data-required="1" class="span6 m-wrap" />
                                    </div>
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
                    <!-- END VALIDATION STATES-->
                </div>
            </div>
        </div>
    </div>
    <!-- END EMPLOYEE GROUP MODAL FORM-->

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
                    <%=Resources.Resource.employeeGroups %>	
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
                    <li><a href="#"><%=Resources.Resource.employeeGroups %></a></li>

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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.employeeGroups %></div>
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
                                    <a id="btnAdd" href="<%= Page.ResolveClientUrl("~/Emp/Save-Employee-Group/" + TAMSR2.CustomClasses.Encryption.Encrypt("0")) %>" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                    <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                </span>
                            </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                                <tr style="background-color: #e8e3e3;">
                                    <th style="text-align: center; width: 8px;">
                                        <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                    <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.description %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.schedule %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.fromDate %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.toDate %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.reportingGroup %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.employee %></th>
                                    <th style="text-align: center; text-align: center;">&nbsp;&nbsp;&nbsp;</th>
                                    <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.updated %></th>
                                    <th style="text-align: center; text-align: center;">&nbsp;</th>
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
            FormValidation.init();
            //TableManaged.init();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liEmp").addClass("active");
            $("#liEmp .arrow").addClass("open");
            $("#liGroup").addClass("active");

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
                   { "bSortable": false, sWidth: "5%" },
                   { "bSortable": true, sWidth: "7%" },
                   { "bSortable": true, sWidth: "15%" },
                   { "bSortable": true, sWidth: "5%" },
                   { "bSortable": true, sWidth: "7%" },
                   { "bSortable": true, sWidth: "7%" },
                   { "bSortable": false, sWidth: "5%" },
                   { "bSortable": false, sWidth: "9%" },
                   { "bSortable": false, sWidth: "5%" },
                   { "bSortable": true, sWidth: "10%" },
                   { "bSortable": false, sWidth: "5%" }
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
               "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/EmployeeGroupPage.aspx?key=getAll") %>'
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
                if (name == "TAMSR2_Cmp_EmpType") {
                    ReloadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Cmp_EmpType', '');
                    // Clear text box and reset focus for next comment. 
                });
            });
        });

        function ReloadGrid() {
            $('#sample_1').dataTable().fnDraw();
        }

        function CloseForm() {
            Clear();
            $("#btnCloseForm").click();
            $("#btnCloseAssignUserForm").click();
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

            $("#txtDescriptionEn").val("");
            $("#txtDescriptionAr").val("");
            $("#txtCode").val("");

            //$("#txtCategory").val("");
            //$("#txtService").val("");

        }

        function Delete() {
            var v = "key=deleteByID&";

            $("#divSuccessMsg2").css("display", "none");
            $("#divErrorMsg2").css("display", "none");

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
                $("#divErrorMsg2").css("display", "block");
                $("#spnErrorMsg2").html("<%=Resources.Resource.selectOne %>");
              return;
          }
          if (confirm("<%=Resources.Resource.deleteMessage %>")) {
              $.ajax({
                  type: 'POST',
                  data: v,
                  url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeGroupPage.aspx") %>',
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

        function Edit(id) {
            //Edit code
            var v = "key=getByID&id=" + id;
            $("#btnAdd").click();
            $("#spnID").html(id);
            $("#spnGridMsg").html("&nbsp;");
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeGroupPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);
                        $("#spnID").val(j.ID);
                        $("#txtDescriptionEn").val(j.DescriptionEn);
                        $("#txtDescriptionAr").val(j.DescriptionAr);
                        $("#txtCode").val(j.Code);
                    }
                },
                error: function (html) {

                }
            });
        }

        function Save() {
            var id = $("#spnID").html();
            var descriptionEn = $("#txtDescriptionEn").val();
            var descriptionAr = $("#txtDescriptionAr").val();
            var code = $("#txtCode").val();
            if ($('#form_sample_1').validate().form() == false) {
                return false;
            }
            var v = "key=save" + "&id=" + id + "&code=" + code;
            v += "&descriptionEn=" + descriptionEn + "&descriptionAr=" + descriptionAr;

            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeGroupPage.aspx") %>',
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
                        Clear();
                    }
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("Error! " + html);
                }

            });

        }

        var FormValidation = function () {


            return {
                //main function to initiate the module
                init: function () {

                    // for more info visit the official plugin documentation: 
                    // http://docs.jquery.com/Plugins/Validation

                    var form2 = $('#form_sample_1');
                    var error2 = $('.alert-error', form2);
                    var success2 = $('.alert-success', form2);

                    form2.validate({
                        errorElement: 'span', //default input error message container
                        errorClass: 'help-inline', // default input error message class
                        focusInvalid: false, // do not focus the last invalid input
                        ignore: "",
                        rules: {
                            code: {
                                required: true,
                                maxlength: 10
                            },
                            nameEn: {
                                required: true,
                                maxlength: 50
                            },
                            nameAr: {
                                required: true,
                                maxlength: 50
                            }
                        },

                        messages: { // custom messages for radio buttons and checkboxes
                            code: {
                                required: "<%=Resources.Resource.lblRequired %>"
                           },
                           nameEn: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           nameAr: {
                               required: "<%=Resources.Resource.lblRequired %>"
                            }
                        },

                        errorPlacement: function (error, element) { // render error placement for each input type
                            if (element.attr("name") == "vname") { // for chosen elements, need to insert the error after the chosen container
                                error.insertAfter("#form_2_vname");
                            } else if (element.attr("name") == "membership") { // for uniform radio buttons, insert the after the given container
                                error.addClass("no-left-padding").insertAfter("#form_2_membership_error");
                            } else if (element.attr("name") == "service") { // for uniform checkboxes, insert the after the given container
                                error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                            } else {
                                error.insertAfter(element); // for other inputs, just perform default behavoir
                            }
                        },

                        invalidHandler: function (event, validator) { //display error alert on form submit   
                            success2.hide();
                            error2.show();
                            App.scrollTo(error2, -200);
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
                            if (label.attr("for") == "service" || label.attr("for") == "membership") { // for checkboxes and radip buttons, no need to show OK icon
                                label
                                    .closest('.control-group').removeClass('error').addClass('success');
                                label.remove(); // remove error label here
                            } else { // display success icon for other inputs
                                label
                                    .addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                                    .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                            }
                        },

                        submitHandler: function (form) {
                            success2.show();
                            error2.hide();
                        }

                    });

                    //apply validation on chosen dropdown value change, this only needed for chosen dropdown integration.
                    $('.chosen, .chosen-with-diselect', form2).change(function () {
                        form2.validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
                    });

                }

            };

        }();
    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
