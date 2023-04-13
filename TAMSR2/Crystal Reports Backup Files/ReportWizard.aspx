<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportWizard.aspx.cs" Inherits="TAMSR2.Reports.ReportWizard1" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

  <!-- BEGIN PAGE LEVEL STYLES -->
   <link href="../Assets/<%= languageStr %>/Styles/jquery.loadmask.css" rel="stylesheet" />
   <link href='../Assets/<%= languageStr %>/css/pages/login.css' rel='stylesheet' type='text/css'/>
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
   
    
        <script type="text/javascript">
        
            function GenerateReport() {
                var FilVAl = '';
                var Filters = '';
                var Itrate = true;
                var i = 0;
                while (Itrate == true) {
                    //   alert("INSIDE THE WHILE LOOP  "  + i);
                    var Txtvalue = $('#txt' + i).val();
                    var LblValue = $('#lbl' + i).html();
                    var OpValue = $('#lblOp' + i).html();
                    
                    
                    
                    var OriginalValue = $('#hid' + i).val();
                    var logicalOp = $('#sel' +i + ' option:selected').val();
                    //alert(logicalOp);
                    //    alert(LblValue + "  " + OpValue + "  " + Txtvalue);
                    if (Txtvalue != "" & Txtvalue != undefined & LblValue != "" & LblValue != undefined) {
                        var op = OpValue.replace('&gt;', '>');
                        var op = op.replace('&lt;', '<');
                        //   alert(op.equal('LIKE'));
                        op.trim();
                        if (op == "LIKE") {
                            Filters = Filters + OriginalValue + "  " + op + " % " + Txtvalue + " % " + ",";
                            FilVAl = FilVAl + LblValue + "#" + OpValue + "#" + Txtvalue;
                        }
                        else {
                            if (logicalOp != undefined) {

                                Filters = Filters + OriginalValue + "  " + op + " '" + Txtvalue + "'   " + logicalOp;
                                FilVAl = FilVAl + LblValue + "#" + OpValue + "#" + Txtvalue + "#";
                            }
                            else {

                                Filters = Filters + OriginalValue + "  " + op + " '" + Txtvalue + "'   "
                                FilVAl = FilVAl + LblValue.trim() + "#" + OpValue.trim() + "#" + Txtvalue.trim() + "#";
                            }
                        }
                        i = i + 1;
                    }
                    else {
                        Itrate = false;
                    }
                   // alert(FilVAl);
                    var v = "key=GenrateReport&Filters=" + Filters+"&FilVal=" +FilVAl;
                }
                $.ajax({
                    url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                   type: "POST",
                    data: v,
                    success: function (msg) {
                        window.location.href = '../Reports/ViewRptPage.aspx';
                        $(".tab-pane").css("cursor", "wait");
                        //$(".tab-pane").mask("<%=Resources.Resource.processing %>...");
                        
                    },
                    Error: function (x, e) {
                        // $("#Columns").html("Sorry No Data Found");
                        $(".tab-pane").css("cursor", "pointer");
                        $(".tab-pane").unmask();
                    }
                   
                });
            }

            function LoadTemplates(action) {
                if (action == "FilterValues") {
                    var ID = $('#selTemplate option:selected').val();
                    // alert(ID);
                    var v = "key=GetAll&action=" + action + "&ID=" + ID;
                }
                else if (action == "GenrateReport") {
                    
                    var Filters = '';
                    var Itrate = true;
                    var i = 0;
                    while (Itrate == true) {
                    //   alert("INSIDE THE WHILE LOOP  "  + i);
                        var Txtvalue = $('#txt' + i).val();
                        var LblValue = $('#lbl' + i).html();
                        var OpValue = $('#lblOp' + i).html();
                        var OriginalValue = $('#hid' + i).val();
 //                       alert(OriginalValue);
                       
                   //    alert(LblValue + "  " + OpValue + "  " + Txtvalue);
                        if (Txtvalue != "" & Txtvalue != undefined  & LblValue != "" & LblValue != undefined) {
                            var op = OpValue.replace('&gt;', '>');
                            var op = op.replace('&lt;', '<');
                         //   alert(op.equal('LIKE'));
                            op.trim();
                          //  alert(op);
                            if (op == "LIKE") {
                                 alert("OO");
                                 Filters = Filters + OriginalValue + "  " + op + " % " + Txtvalue + " % " + ",";
                            }
                            else {
                                Filters = Filters + OriginalValue + "  " + op + " '" + Txtvalue + "'" + " ,";
                            }
                            alert(Filters);
                            i = i + 1;
                        }
                        else {
                            Itrate = false;
                        }

                        var v = "key=GetAll&action=" + action + "&Filters=" + Filters;
                    }
                }
                else {
                    var v = "key=GetAll&action=" + action
                }

                var URL;
                if(action == "GenrateReport" )
                {
                    URL = '<%= Page.ResolveClientUrl("../RequestPages/ViewReport.aspx") %>'
                }
                else
                {
                    URL = '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>'
                }
              //  alert(URL);
                $(".tab-pane").css("cursor", "wait");
                //$(".tab-pane").mask("<%=Resources.Resource.processing %>...");
                $.ajax({
                    url: URL,
                    type: "POST",
                    data: v,
                    success: function (msg) {
                       if (action == "getAllTemplate") {
                            $("#divTemp").html(msg);
                            $(".tab-pane").css("cursor", "pointer");
                            //$(".tab-pane").unmask();
                        }
                       else if (action == "FilterValues") {
                         //  alert(msg);
                           $("#FilterValues").html(msg);
                           $(".tab-pane").css("cursor", "pointer");
                           //$(".tab-pane").unmask();
                       }
                       else if (action == "GenrateReport") {
                           if (msg == "1") {
                               //window.location.href = "../Reports/ReportEngine.rpt";
                               $(".tab-pane").css("cursor", "pointer");
                               //$(".tab-pane").unmask();
                           }
                       }
                    },
                    Error: function (x, e) {
                        // $("#Columns").html("Sorry No Data Found");
                        $(".tab-pane").css("cursor", "pointer");
                        //$(".tab-pane").unmask();
                    }

                });
            }
</script>
    <!-- END PAGE LEVEL STYLES -->


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
                  <h3 class="page-title">
                     Report Wizard
                     <small>Create Report</small>
                  </h3>
                  <ul class="breadcrumb">
                     <li>
                        <i class="icon-home"></i>
                        <a href="index.html">Home</a> 
                        <span class="icon-angle-right"></span>
                     </li>
                     <li>
                        <a href="#">Form Stuff</a>
                        <span class="icon-angle-right"></span>
                     </li>
                     <li><a href="#">Form Wizard</a></li>
                  </ul>
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12">
                  <div class="portlet box blue" id="form_wizard_1">
                     <div class="portlet-title">
                        <div class="caption">
                           <i class="icon-reorder"></i> <%= Resources.Resource.ReportWizard %> <span class="step-title" id="step"></span>
                        </div>
                       <%-- <div class="tools hidden-phone">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="#portlet-config" data-toggle="modal" class="config"></a>
                           <a href="javascript:;" class="reload"></a>
                           <a href="javascript:;" class="remove"></a>
                        </div>--%>
                     </div>
                     <div class="portlet-body form">
                        <form action="#" class="form-horizontal">
                           <div class="form-wizard">
                               <%--<div onclick="ChangeLang()" style="display: inline; float: <%= pullDirectionStr%>; cursor: pointer;"> <%= Session["changeLanguage"] + "" %></div>
  --%>
                              
                              <div class="tab-content">
                                 <div class="tab-pane active" id="tab1">
                                    <h3 class="block"><%=Resources.Resource.SelectReportTemplate %></h3>
                                    <div class="control-group">
                                     <div id="divTemp">

                                      </div>
                                 </div>
                                </div>
                                  <div class="tab-pane" id="tab2">
                                      <div class="control-group">
                                   <h3 class="block"><%=Resources.Resource.SelectFilterValues %></h3>
                                     <br />
                                </div>
                                    <div id="FilterValues">

                                    </div> 
                                </div>

                                
                              
                              <div class="form-actions clearfix">
                                 <a href="javascript:;" class="btn button-previous" id="btnBack">
                                 <i class="m-icon-swapleft"></i>  <%=Resources.Resource.back %> 
                                 </a>
                                 <a href="javascript:;" class="btn blue button-next" id="btnNext">
                                <%=Resources.Resource.next %> <i class="m-icon-swapright m-icon-white"></i>
                                 </a>
                                  <a href="javascript:;" class="btn blue button-next" id="btnViewReport">
                                <%=Resources.Resource.ShowReport %> <i class="m-icon-swapright m-icon-white"></i>
                                 </a>
                                   <a href="javascript:;" class="btn button-previous" id="btnCancel">
                                <%=Resources.Resource.cancel %> 
                                 </a>
                                 <a href="javascript:;" class="btn green button-submit" id="btnSave">
                                  <%=Resources.Resource.save %> <i class="icon-ok"></i>
                                 </a>
                              </div>
                           </div>

                               </div>
                        </form>
                     </div>
                  </div>
               </div>
            </div>
            <!-- END PAGE CONTENT-->         
         </div>
         <!-- END PAGE CONTAINER-->
      </div>
      <!-- END PAGE -->  
   </div>
    
  <script src='../Assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js' type='text/javascript'></script>
  <script src="../Assets/<%= languageStr %>/Scripts/jquery.loadmask.js"></script>
  <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
  <script src='../Assets/<%= languageStr %>/scripts/app.js' type='text/javascript'></script>
  
     <!-- BEGIN PAGE LEVEL PLUGINS -->
   <!-- END PAGE LEVEL PLUGINS -->
   <!-- BEGIN PAGE LEVEL SCRIPTS -->
   <script src="../Assets/<%= languageStr %>/scripts/app.js"></script>
   <script src="../Assets/<%= languageStr %>/scripts/form-wizard.js"></script>   
   <script src="../Assets/<%= languageStr %>/scripts/form-components.js"></script>  
    
    <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script> 
    
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>
      
   <script type="text/javascript" src="../Assets/<%= languageStr %>/plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
   <script type="text/javascript" src="../Assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
   <script src="../Assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>  
  <!-- END PAGE LEVEL SCRIPTS --> 
 <script>
            $(document).ready(function () {
                // initiate layout and plugins
                LoadTemplates("getAllTemplate");
                $('#btnBack').hide();
                $('#btnSave').hide();
                $('#btnViewReport').hide();

                $("#page-sidebar li").removeClass("active");
                $("#page-sidebar li ul li").removeClass("active");
                $("#liRpt").addClass("active");
                $("#liRpt .arrow").addClass("open");
                $("#liReportWizard").addClass("active");

                App.init();
                FormWizard.init();
            });
             i = 0;
            $('#btnNext').click(function () {
                if (i == 0) {
                    LoadTemplates("FilterValues")
                    $('#tab1').hide();
                    $('#tab2').show();
                    $('#btnBack').show();
                    $('#btnNext').hide();
                    $('#btnViewReport').show();
                    i = 1;
                }
                else if (i == 1) {
                    alert("PPP");
                    
                   
                    //LoadTemplates("GenrateReport");
                    
                    GenerateReport();
                    $('#tab2').hide();
                    $('#tab3').show();
                    i = 2;
                }
                //else if (i == 2) {

                //    $('#tab2').hide();
                //    $('#tab3').show();
                //}
            });
            $('#btnViewReport').click(function () {
                GenerateReport();
                $('#tab2').hide();
                $('#tab3').show();

            });
            $('#btnBack').click(function () {
                if (i == 1) {
                    $('#tab2').hide();
                    $('#tab1').show();
                    $('#btnBack').hide();
                    $('#btnViewReport').hide();
                    $('#btnNext').show();
                    i = 0;
                }
            });
</script>

</asp:Content>
