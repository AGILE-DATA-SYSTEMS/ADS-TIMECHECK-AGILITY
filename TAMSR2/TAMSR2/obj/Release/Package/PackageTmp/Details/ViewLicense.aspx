<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewLicense.aspx.cs" Inherits="TAMSR2.Details.ViewLicense" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title><%=Resources.Resource.license %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />

    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
    <!-- END PAGE LEVEL STYLES -->
    <style type="text/css">
        #btnSync:hover {
            cursor: pointer;
        }
    </style>

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
                    <%=Resources.Resource.license %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.license %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.license  %></a></li>

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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.license %></div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                            <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                    </div>
                    <div class="portlet-body" id="divLicense">
                        <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
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
                         <div class="container-fluid" id="maindiv">
                            <!-- BEGIN PAGE HEADER-->
                           <div class="row-fluid">
                             <div class="span6">
                                <div class="portlet box blue">
                                    <div class="portlet-title" style="background-color:red !important;">
                                    <div class="caption">  <%=Resources.Resource.primaryLicense %></div>
                                    <div class="tools" style="display:none;">
                                       <a href="javascript:;" class="collapse"></a>
                                       <a href="#portlet-config" data-toggle="modal" class="config"></a>
                                       <a href="javascript:;" class="reload hidden-phone"></a>
                                       <a href="javascript:;" class="remove hidden-phone"></a>
                                    </div>
                                    </div>
                                    <div class="portlet-body" >
                                    <div class="control-group"> 
                                        <div style="clear: both; display: inline;" class="controls chzn-controls">
                                            <div class="controls">
                                           <table class="table table-striped table-bordered table-hover" id="sample_1">
                                            <thead>
                                                <tr style="background-color: #e8e3e3;"> 
                                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.value %></th>  
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><%=Resources.Resource.machineID %></td>
                                                    <td><label id="lblMacID" class="control-label" style="clear: both; width: 160px !important; display: inline; float: left"><%= MachineID %></label></td> 
                                                </tr>
                                                <tr>
                                                <tr>
                                                    <td><%=Resources.Resource.version %></td>
                                                    <td><label id="lblProductName" class="control-label" style="clear: both; width: 160px !important; display: inline; float: left"></label></td> 
                                                </tr>
                                                <tr>
                                                    <td><%=Resources.Resource.licensedTo%></td>
                                                    <td><label id="lblName" class="control-label" style="clear: both; width: 160px !important; display: inline; float: left"></label></td> 
                                                </tr>
                                                <tr>
                                                    <td><%=Resources.Resource.license  + " " +Resources.Resource.type %></td>
                                                    <td><label id="lblType" class="control-label" style="clear: both; width: 160px !important; display: inline; float: left"></label></td> 
                                                </tr>
                                                <tr>
                                                    <td><%=Resources.Resource.buildDate %></td>
                                                    <td><label id="lblBuildDate" class="control-label" style="clear: both; width: 160px !important; display: inline; float: left"></label></td> 
                                                </tr>
                                                <tr>
                                                    <td><%=Resources.Resource.license  + " " +Resources.Resource.fromDate %></td>
                                                    <td><label id="lblFromDate" class="control-label" style="clear: both; width: 160px !important; display: inline; float: left"></label></td> 
                                                </tr>
                                                <tr id="expDate">
                                                    <td><%=Resources.Resource.license  + " " +Resources.Resource.toDate %></td>
                                                    <td><label id="lblToDate" class="control-label" style="clear: both; width: 160px !important; display: inline; float: left"></label></td> 
                                                </tr>
                                                <tr>
                                                    <td><%=Resources.Resource.license  + " " +Resources.Resource.startDate %></td>
                                                    <td><label id="lblStartDate" class="control-label" style="clear: both; width: 160px !important; display: inline; float: left">  </label></td> 
                                                </tr> 
                                            </tbody>
                                        </table>
                                                
                                              </div>      
                                         
                                        </div>
                                    </div> 
                                </div>
                                </div>
                            </div>
                             <div class="span6">
                                <div class="portlet box green">
                                    <div class="portlet-title" style="background-color:green !important;">
                                    <div class="caption"> <%=Resources.Resource.support %> <%=Resources.Resource.license %></div>
                                    <div class="tools" style="display:none;">
                                       <a href="javascript:;" class="collapse"></a>
                                       <a href="#portlet-config" data-toggle="modal" class="config"></a>
                                       <a href="javascript:;" class="reload hidden-phone"></a>
                                       <a href="javascript:;" class="remove hidden-phone"></a>
                                    </div>
                                 </div>
                                 <div class="portlet-body">
                                     <div style="clear: both; display: inline;" class="controls chzn-controls">
                                            <div class="controls">
                                           <table class="table table-striped table-bordered table-hover" id="sample_2">
                                            <thead>
                                                <tr style="background-color: #e8e3e3;"> 
                                                    <th style="text-align: center;"><%=Resources.Resource.no %></th>
                                                    <th style="text-align: center;"><%=Resources.Resource.name %></th>  
                                                    <th style="text-align: center;"><%=Resources.Resource.fromDate %></th>  
                                                    <th style="text-align: center;"><%=Resources.Resource.toDate %></th>  
                                                    <th style="text-align: center;"><%=Resources.Resource.status %></th>  
                                                </tr>
                                            </thead>
                                            <tbody>
                                                
                                            </tbody>
                                        </table>
                                                 <div style="clear: both; display: inline;" class="controls chzn-controls" id="btnPatch">
                                                     <input type="file" id="patchUpload" class="btn" accept=".skyline" />
                                                </div>
                                                 <div class="btn-group pull-<%= pullDirectionStr %>"  >
                                                    <span id="spnAddButton" runat="server">
                                                        <a id="btnAdd"   href="javascript:void(0);" data-toggle="modal" class="btn green">&nbsp; <%=Resources.Resource.apply %></a>
                                                    </span>
                                                    
                                                </div>
                                              </div>      
                                         
                                        </div>
                                 <//div>
                                </div>
                            </div>
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
    </div>
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

        <!--Script references. -->
        <!--Reference the SignalR library. -->
        <script src="<%= path %>Scripts/jquery.signalR-1.1.0.min.js"></script>
        <!--Reference the autogenerated SignalR hub script. -->
        <script src="<%= path %>signalr/hubs"></script>

        <!-- END PAGE LEVEL PLUGINS -->

        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src='<%= path %>Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
        <script src="<%= path %>assets/<%= languageStr %>/scripts/app.js"></script>   
        <script src="../Scripts/jquery.loadmask.js"></script>
        <script src="<%= path %>assets/<%= languageStr %>/scripts/table-managed.js"></script>

        <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
        <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
        <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
         <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
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
                $("#liSettings").addClass("active");
                $("#liSettings .arrow").addClass("open");
                $("liAppLicense").addClass("active");

                if ('<%= Session["sidebar"] + "" %>' != '') {
                    $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
                }

                getSupportLicense();
                getApplicationLicense();

                $("#sample_2_wrapper .row-fluid").css("display", "none");

                setInterval(function () {
                    $("#divErrorMsg").css("display", "none");
                    $("#divSuccessMsg").css("display", "none");
                }, 50000);
              //  GetAll();
            });
                 
            $('#btnAdd').click(function () {
                    var patchUploader = document.getElementById("patchUpload");
          
                    //alert(patchUploader.files.length);
                    if (patchUploader.files.length == 0) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("Please select license file");
                    }
                    var ext = patchUploader.value.match(/\.(.+)$/)[1];

                    switch (ext) {
                        case 'skyline':
                            uploadExcelFile(patchUploader);
                            break;
                        case 'Skyline':
                            uploadExcelFile(patchUploader);
                            break;
                        default:
                            alert('not allowed');
                            this.value = '';
                    }
                });

                function uploadExcelFile(obj) { 
                     $("#divLicense").mask("<%=Resources.Resource.processing %>" + "....");
                    //event.stopPropagation(); // Stop stuff happening
                    //event.preventDefault(); // Totally stop stuff happening
                   // var Cat = $("#ddLicenseCat option:selected").val();// $("#ddLicenseCat").val()
                    var files = obj.files;
            
                     
                    var v = "key=applyLicense&LicenseType=SupportLicense";
                    var url = '<%= Page.ResolveClientUrl("~/Handlers/ApplyLicense.ashx") %>'  //'"/Handlers/ApplyLicense.ashx?" 
                   
                    var handlerURL = url + "?" + v;
           
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
                            if (result == "1") {
                                getSupportLicense();
                                $("#divLicense").unmask();
                                $("#patchUpload").val(""); 
                                $("#divSuccessMsg").css("display", "block");
                                $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");

                            }
                            else if(result == "2")
                            {
                                 $("#divLicense").unmask();
                                $("#patchUpload").val("");
                                $("#divErrorMsg").css("display", "block");
                                $("#spnErrorMsg").html("Invalid licese, Please apply valid license or contact vendor.");
                            }
                            else {
                                 $("#divLicense").unmask();
                                $("#patchUpload").val("");
                                $("#divErrorMsg").css("display", "block");
                                $("#spnErrorMsg").html("Error Occured, Please apply valid license or contact vendor");
                            }
                        },
                        error: function (err) {
                            console.log(err);
                        }
                    });
                }
            
            function getApplicationLicense() {
                var v = "key=getApplicationLicense"; 
                $.ajax({
                    type: 'POST',
                    data: v,
                    url: '<%= Page.ResolveClientUrl("../RequestPages/LicensePage.aspx") %>',
               success: function (html) {

                   if (html != "") {
                       var j = $.parseJSON(html);
                       
                       $("#lblProductName").html(j.ProductVersion);
                       $("#lblName").html(j.CompName);
                       $("#lblType").html(j.Type);
                       $("#lblBuildDate").html(j.LastBuildDate);
                       $("#lblFromDate").html(j.StartDate);
                       if (j.Type == "Standard") {
                           $('#expDate').css('display', 'none');
                       }
                       else {
                           $("#lblToDate").html(j.EndDate);
                           $('#expDate').css('display', 'table-row');
                       }
                       $("#lblStartDate").html(j.ActiveDate);
                   }
               },
               error: function (html) {

               }
           });
            }


            function getSupportLicense() {
                var oTable = $('#sample_2').dataTable({
                    "bProcessing": false,
                    "bServerSide": true,
                    "bDestroy": true,
                    "bLengthChange": false,
                    "bFilter": false,
                    "sPaginationType": "bootstrap",
                    "aoColumns": [
                      { "bSortable": false },
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
                  
                   "sUrl": "",
                   "oPaginate": {
                       "sFirst": "<%=Resources.Resource.first %>",
                       "sPrevious": "<%=Resources.Resource.previous %>",
                       "sNext": "<%=Resources.Resource.next %>",
                       "sLast": "<%=Resources.Resource.last %>"
                   }
               },
                    "aaSorting": [[1, "desc"]],
                    "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/LicensePage.aspx?key=getSupportLicense") %>' 
                });
                $('#sample_2').css("width", "100%");
            }



            var FormComponents = function () {

                var handlejQueryUIDatePickers = function () {
                    $(".ui-date-picker").datepicker();

                }

                var handleDateTimePickers = function () {

                    if (jQuery().datepicker) {
                        $('#txtFromDate').datepicker({ format: 'yyyy-mm-dd' });
                        $('#txtToDate').datepicker({ format: 'yyyy-mm-dd' })
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

