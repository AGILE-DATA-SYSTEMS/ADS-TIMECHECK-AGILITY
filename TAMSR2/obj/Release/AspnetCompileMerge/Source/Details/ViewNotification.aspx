<%@ Page Title="" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewNotification.aspx.cs" Inherits="TAMSR2.Details.ViewNotification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.notification %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->
    <style>.modal {margin-left: -35% !important;width: 75%;}.modal-body{overflow-y:visible!important}.portlet-tabs .nav-tabs>.active>a{color:#000!important}.portlet-tabs .nav-tabs>li>a{color:#fff!important}.portlet-tabs .nav-tabs>li>a:hover{color:#000!important}</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- END   LIGHT BOX ERROR/MESSAGE -->
    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
    <div id="portlet-config" class="modal hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple tabbable">
                        <div class="portlet-title">
                            <button data-dismiss="modal" class="close" type="button"></button>
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.notification %></h4>
                        </div>

                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <div class=" tabbable portlet-tabs">
                                <ul class="nav nav-tabs">

                                    <li class="active" id="details" style="display: none;"><a href="#portlet_tab1" data-toggle="tab"><%--<%=Resources.Resource.details %>--%></a></li>
                                </ul>
                            </div>

                            <div class="tab-content">

                                <div class="tab-pane active" id="portlet_tab1">
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
                                            <div class="span8 ">
                                                <div class="control-group">
                                                    <label class="control-label">Subject<span class="required">*</span></label>
                                                    <div class="controls">
                                                        <input type="text" disabled id="txtNotificationType" name="code" style="width: 100% !important" data-required="1" class="span6 m-wrap" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row-fluid">
                                            <div class="span11 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.descriptionEn %><span class="required">*</span></label>
                                                    <div class="controls">
                                                        <textarea id="txtDescriptionEn" name="DescriptionEn" style="width: 100% !important; min-height: 100px" data-required="1" class="span6 m-wrap"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row-fluid">
                                            <div class="span11 ">
                                                <div class="control-group">
                                                    <label class="control-label"><%=Resources.Resource.descriptionAr %></label>
                                                    <div class="controls">
                                                        <textarea id="txtDescriptionAr" name="DescriptionAr" style="width: 100% !important; direction: rtl; min-height: 100px" data-required="1" class="span6 m-wrap"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <br />
                                    <span id="spnID" style="display: none;">0</span>
                                    <div class="form-actions">
                                        <span id="Span1" style="display: none;">0</span>
                                        <button id="Button1" type="button" style="display: none;" class="btn purple">broadcast</button>
                                        <button id="btnSave" type="button" onclick="Save()" class="btn purple"><%=Resources.Resource.save %></button>
                                        <button type="button" onclick="return CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
                                    </div>

                                    <br />
                                </div>

                            </div>
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
                    <%=Resources.Resource.notification %> 
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.settings %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.notification %></a></li>

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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.notification %></div>
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
                                    <a id="btnAdd" onclick="return Clear()" href="#portlet-config" data-toggle="modal" class="btn green"><i class="icon-plus">&nbsp; <%=Resources.Resource.add %></i></a>
                                </span>
                                <span id="spnDeleteButton" runat="server">
                                    <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                </span>
                            </div>
                        </div>

                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                                <tr style="background-color: #e8e3e3;">
                                   <%-- <th style="text-align: center;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>--%>
                                    <th style="text-align: center;"><%=Resources.Resource.descriptionEn %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.descriptionAr %></th>
                                    <th style="text-align: center;"><%--<%=Resources.Resource.type %>--%> Subject</th>
                                    <th style="text-align: center;"><%=Resources.Resource.updatedBy %></th>
                                    <th style="text-align: center;"><%=Resources.Resource.updatedOn %></th>
                                    <th style="text-align: center;"></th>
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
            $("#liSettings").addClass("active");
            $("#liNotification .arrow").addClass("open");
            $("#liNotification").addClass("active");

            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
          
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


            LoadGrid();

        });


        $("#ddDeviceTypes").change(function () {
            LoadGrid();
        });
        $("#ddStatus").change(function () {
            LoadGrid();
        });
        function LoadGrid() {

            var url = '<%= Page.ResolveClientUrl("~/RequestPages/NotificationPage.aspx?key=getAll")%>'
          
            var oTable = $('#sample_1').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "bDestroy": true,
                "sPaginationType": "bootstrap",
                "aoColumns": [
                  //{ "bSortable": false, sWidth: "3%" },
                  { "bSortable": true, sWidth: "30%" },
                  { "bSortable": true, sWidth: "30%" },
                  { "bSortable": true, sWidth: "18%" },
                  { "bSortable": true, sWidth: "10%" },
                  { "bSortable": true, sWidth: "10%" },
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
                "aaSorting": [[1, "asc"], [2, "asc"]],
                "sAjaxSource": url
            });

            $('#sample_1').css("width", "100%");
        }

        function ReloadGrid() {
            $('#sample_1').dataTable().fnDraw();
        }

        function ChkValues() {
            alert("check rows will be deleted");
            //var count = $("#spnCount").html();
            var check = "false";
            var v = "key=finallyApprove&";

            var k = 1;
            $("#sample_1 tbody").find("input:checkbox").each(function () {
                if (this.checked == true) {
                    v += "chk" + k + "=" + this.value + "&";
                    k++;
                    //this.checked = chk.checked;
                }
            });
            v += "count=" + k;
            alert(v);
        }

        function CloseForm() {

            Clear();
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
            $("#txtRemarks").val("");

            $("#txtReaderCode").val("");
            $("#txtReaderName").val("");
            $("#chkboxEnabled").removeAttr("checked");
            $("#uniform-chkboxEnabled span").removeClass("checked");
            $("#chkboxWebPunch").removeAttr("checked");
            $("#uniform-chkboxWebPunch span").removeClass("checked");

            $('#ddReaderType option[value=""]').attr('selected', 'selected');
            $("#ddReaderType").trigger("liszt:updated");
            $('#ddConnection option[value=""]').attr('selected', 'selected');
            $("#ddConnection").trigger("liszt:updated");
            $('#ddReaderDirection option[value=""]').attr('selected', 'selected');
            $("#ddReaderDirection").trigger("liszt:updated");
            $('#ddDeviceGroup option[value=""]').attr('selected', 'selected');
            $("#ddDeviceGroup").trigger("liszt:updated");
            $('#ddLocation option[value=""]').attr('selected', 'selected');
            $("#ddLocation").trigger("liszt:updated");
            $('#ddRegion option[value=""]').attr('selected', 'selected');
            $("#ddRegion").trigger("liszt:updated");
        }
        function htmlEncode(value) {
            //create a in-memory div, set it's inner text(which jQuery automatically encodes)
            //then grab the encoded contents back out.  The div never exists on the page.
            return $('<div/>').text(value).html().replace(/&/g, '%26');
        }

        function htmlDecode(value) {
            return $('<div/>').html(value).text();
        }
        function Edit(id) {
            $("#btnAdd").click();
            $("#spnID").html(id);
            $("#spnGridMsg").html("&nbsp;");
            var v = "key=getByID&id=" + id;
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/NotificationPage.aspx") %>',
                success: function (html) {
                    if (html != "") {
                        var j = $.parseJSON(html);
                        $("#spnID").val(j.ID);
                        $("#txtNotificationType").val(j.NotificationType);

                        $("#txtDescriptionEn").val(j.DescriptionEn);
                        $("#txtDescriptionAr").val(j.DescriptionAr);

                        $("#portlet-config").modal('show');
                        $("#portlet_tab1").modal('show');   
                    }
                },
                error: function (html) {

                }
            });
        }

        var encodeHtmlEntity = function (str) {
            var buf = [];
            for (var i = str.length - 1; i >= 0; i--) {
                buf.unshift(['&#', str[i].charCodeAt(), ';'].join(''));
            }
            return buf.join('');
        };
        function strip(html) {
            var tmp = document.createElement("DIV");
            tmp.innerHTML = html;
            return tmp.textContent || tmp.innerText || "";
        }
   function Save() {
       
       $("#divSuccessMsg").css("display", "none");
       $("#divErrorMsg").css("display", "none");
       
       var descriptionEn =htmlEncode($("#txtDescriptionEn").val());
       var descriptionAr = htmlEncode($("#txtDescriptionAr").val() || ' ');
        

       if ($('#form_sample_1').validate().form() == false) {
           return false;
       }

       var id = $("#spnID").html();
       var v = "key=save" + "&id=" + id + "&descriptionEn=" + descriptionEn + "&descriptionAr=" + descriptionAr;
    
       $.ajax({
           type: 'POST',
           data: v,
           url: '<%= Page.ResolveClientUrl("../RequestPages/NotificationPage.aspx") %>',
           //contentType:"application/json; charset=utf-8",
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
                       ReloadGrid();
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
           init: function () {
               var form1 = $('#form_sample_1');
               var error1 = $('.alert-error', form1);
               var success1 = $('.alert-success', form1);
             
               $.validator.addMethod('IP4Checker', function (value) {
                   var ip = /^(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))$/;
                   return value.match(ip);
               }, '<%=Resources.Resource.notification %>');

               form1.validate({
                   errorElement: 'span', //default input error message container
                   errorClass: 'help-inline', // default input error message class
                   focusInvalid: false, // do not focus the last invalid input
                   ignore: "",
                   rules: {

                       DescriptionEn: {
                           minlength: 3,
                           required: true
                       }
                       //,DescriptionAr: {
                       //    minlength: 3,
                       //    required: true
                       //}

                   },
                   message: {
                       DescriptionEn: {
                           required: "<%=Resources.Resource.lblRequired %>"
                       }
                       //,DescriptionAr: {
                         //  required: "<%=Resources.Resource.lblRequired %>"
                       //}
                   },
                   errorPlacement: function (error, element) { // render error placement for each input type
                       if (element.attr("name") == "readerType" || element.attr("name") == "connectionType"
                            || element.attr("name") == "direction" || element.attr("name") == "region") { // for uniform checkboxes, insert the after the given container
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
