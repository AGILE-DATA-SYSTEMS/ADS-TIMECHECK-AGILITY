<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TemplateWizard.aspx.cs" Inherits="TAMSR2.Reports.TemplateWizard" %>


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
   <!-- END PAGE LEVEL STYLES -->

	
    <script type="text/javascript">
        var TableName = "";

        function LoadColumns(action) {

            var Cat = $("#selCat option:selected").text();
            if (Cat == "Time Attendance") {
                TableName = "daily_EmployeeAttendanceDetails";
            }
            else if (Cat == "Employee Details") {
                TableName = "TAMSR2_Users";
            }
            else {
                TableName = "daily_EmployeeAttendanceDetails";
            }
            var v = "key=LoadColumns&action=" + action + "&TableName=" + TableName;
            $(".tab-pane").css("cursor", "wait");
            //$(".tab-pane").mask("<%=Resources.Resource.processing %>...");
            $.ajax({
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                type: "POST",
                data: v,
                success: function (msg) {
                    if (action == "Columns") {
                        $("#Columns").html(msg);
                        $(".tab-pane").css("cursor", "pointer");
                        //$(".tab-pane").unmask();
                    }
                    else if (action == "SortBy") {
                        $("#SortBy").html(msg);
                        $(".tab-pane").css("cursor", "pointer");
                        //$(".tab-pane").unmask();
                    }
                    else if (action == "Filters") {
                        $("#Filters").html(msg);
                        $(".tab-pane").css("cursor", "pointer");
                        //$(".tab-pane").unmask();
                    }
                    else if (action == "GroupBy") {
                        $("#GrpBY").html(msg);
                        $(".tab-pane").css("cursor", "pointer");
                        //$(".tab-pane").unmask();
                    }
                },
                Error: function (x, e) {
                    // $("#Columns").html("Sorry No Data Found");
                    $(".tab-pane").css("cursor", "pointer");
                    //$(".tab-pane").unmask();
                }
            });
        }


        function SaveReportTemplate() {
            // alert(":OPPOPO");
            //alert(SelectedCols + SortBy + SortCols + FilterCols + GroupCols);
            var NameEn = $("#txtReportNameEn").val();
            var NameAr = $("#txtReportNameAr").val();
            //alert(NameEn  + NameAr);

            var DescEn = $("#txtDescriptionEn").val();
            var DescAr = $("#txtDescriptionAr").val();

            var Cat = $("#selCat option:selected").text();
            // alert(Cat);
            //  alert(TableName);
            //  
            if ($("#radPotrait").attr("checked") == "checked") {
                reportLayout = $('#radPotrait').val();
            }
            else if ($("#radLandscape").attr("checked") == "checked") {

                reportLayout = $('#radLandscape').val();
            }

            if ($("#AscRadio").attr("checked") == "checked") {
                sortOrder = $('#AscRadio').val();
            }
            else if ($("#DescRadio").attr("checked") == "checked") {

                sortOrder = $('#DescRadio').val();
            }
            //   alert(sortOrder);
            FilterCols = filterTable.fnGetData();
            var SelectedCols = colTable.fnGetData();
            var SortByCols = sortTablr.fnGetData();
            var GroupByCols = grpTable.fnGetData();
            // var remember = $("#chkboxRemember").is(":checked");


            var d = "key=save&nameEn=" + NameEn + "&nameAr=" + NameAr + "&DescriptionEn=" + DescEn + "&DescriptionAr=" + DescAr + "&Category=" + Cat + "&Layout=" + reportLayout + "&SlectedCols=" + SelectedCols + "&SortCols=" + SortByCols + "&SortBy=" + sortOrder + "&Filters=" + FilterCols + "&GroupBy=" + GroupByCols + "&SortOrder=" + sortOrder + "&TableName=" + TableName;
            //if ($('.login-form').validate().form() == false) {
            //  return false;
            //}
            //  alert(d);
            $(".content").css("cursor", "wait");
            //$(".content").mask("<%=Resources.Resource.processing %>...");
            $.ajax({
                url: '<%= Page.ResolveClientUrl("../RequestPages/ReportRequest.aspx") %>',
                data: d,
                type: 'POST',
                success: function (chk) {
                    if (chk == "1") {
                        //alert("SAVED");
                        window.location = '../Reports/ReportWizard.aspx';
                        $(".content").css("cursor", "wait");
                        //$(".content").mask("<%=Resources.Resource.processing %>...");

                        $("#lblErrorMsg").removeClass("alert-error");
                        $("#lblErrorMsg").addClass("alert-success");
                        $("#lblErrorMsg").removeClass("hide");
                        $("#lblErrorMsg").html("Success: Template Has Been Successfully Saved");
                        $(".content").css("cursor", "pointer");

                        //$(".content").unmask();
                    }
                    else if (chk == '0') {
                        $(".content").css("cursor", "pointer");
                        $("#divErrorMsg").css("display", "block");
                        $("#divErrorMsg").html("<%=Resources.Resource.usernameOrPasswordNotMatched %>");
                    }
                    else {
                        $(".content").css("cursor", "pointer");
                        $("#divErrorMsg").css("display", "block");
                        $("#divErrorMsg").html("<%=Resources.Resource.userNotActive %>");
                    }
                    //$(".content").unmask();
                },
                error: function () {
                    $(".content").css("cursor", "pointer");
                    $("#divErrorMsg").css("display", "block");
                    $("#divErrorMsg").html("<%=Resources.Resource.couldNotConnectToServer %>");
                    //$(".content").unmask();
                }

            });
        }
        </script>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- BEGIN PAGE CONTAINER-->
         <div class="container-fluid">
            <!-- BEGIN PAGE HEADER-->   
            <div class="row-fluid">
               <div class="span12">                  
                  <h3 class="page-title">
                     Report Template Wizard
                     <small>Create a template</small>
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
                           <i class="icon-reorder"></i> Form Wizard <span class="step-title" id="step"></span>
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
                                    <h3 class="block"><%=Resources.Resource.ReportNameAndDesc %></h3>
                                     <label id="lblErrorMsg" class="alert alert-error hide" > Please Enter Report Name. * These fields are required</label>
                                    <div class="control-group">
                                        
                                          <label class="control-label"><%=Resources.Resource.ReportName %></label>
                                       <div class="controls">
                                          
                                           <input type="Text" class="span6 m-wrap" id="txtReportNameEn" />
                                           
                                           <span class="help-inline">*</span>
                                       </div>
                                     </div>

                                     <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.ReportNameAr %></label>
                                       <div class="controls">
                                          <input type="Text" class="span6 m-wrap" id="txtReportNameAr" />
                                           <span class="help-inline">*</span>
                                       </div>
                                    </div>
                                   
                                    <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.ReportDescription %></label>
                                       <div class="controls">
                                           <textarea id="txtDescriptionEn" class="span6 m-wrap" rows="3"></textarea>
                                          </div> 
                                    </div>

                                     <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.ReportDescriptionAr %></label>
                                       <div class="controls">
                                          <textarea id="txtDescriptionAr" class="span6 m-wrap" rows="3"></textarea>
                                       </div> 
                                    </div>

                                 </div>

                                  <div class="tab-pane" id="tab6">
                                      <div class="control-group">
                                   <h3 class="block"><%=Resources.Resource.ReportCategory %></h3>
                                     <br />
                                <div class="control">
                                     <label class="control-label" style="text-align:left; padding-top:0px;"> <%=Resources.Resource.SelectCategory %></label>
                                    <select class="span6 m-wrap" id="selCat" style="margin-right:20px;">
                                        <optgroup label="Choose Report Category">
                                            <option>Time Attendance</option>
                                            <option>Employee Details</option>
                                            <option>Security</option>
                                            <option>Audit</option>
                                        </optgroup>
                                    </select>
                                </div>
                                     <br />
                                  <div class="controls" style="margin-left:0px; margin-right:0px;">
                                      <label class="control-label" style="text-align:left; padding-top:0px;"> <%=Resources.Resource.SelectReportLayout %></label>
                                             <label class="radio" style="margin-left:25px !important; margin-right:40px !important;">
                                                <input type="radio" style="margin-left:-16px;" id="radPotrait" name="radLayout" value="Portrait" checked="checked" /><%=Resources.Resource.Potrait %>
                                             </label>
                                             <label class="radio" style="margin-left:25px !important; margin-right:25px !important;">
                                             <input type="radio" style="margin-left:-16px;" id="radLandscape" name="radLayout" value="Landscape"  /><%=Resources.Resource.Landscape %>
                                             </label>  
                                   </div>
                                </div>
                                    
                                     
                                    
                                     
                                </div>

                                 <div class="tab-pane" id="tab2">
                                   <h3 class="block"><%=Resources.Resource.ReportColumns %></h3>
                                     <br />

                                     
                                         <div id="Columns">

                                         </div>
                                     <div class="control-group">
                                        
                                          <label class="control-label"><%=Resources.Resource.ColumnName %></label>
                                       <div class="controls">
                                          
                                           <input type="Text" class="span6 m-wrap" id="txtColumnName" />
                                           
                                           
                                       </div>
                                     </div>


                                     <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.ColumnNameAr %></label>
                                       <div class="controls">
                                          <input type="Text" class="span6 m-wrap" id="txtColumnNameAr" />
                                         
                                       </div>
                                    </div>
                                   <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.IsVisible %></label>
                                       <div class="controls" style="margin-left:0px;">
                                     
                                             <label class="radio" style="margin-left:40px !important;">
                                                <input type="radio" style="margin-left:-16px;" id="radYes" name="radIsVisible" value="Yes" checked="checked"  /><%=Resources.Resource.Yes %>
                                             </label>
                                             <label class="radio" style="margin-left:25px !important;">
                                             <input type="radio" style="margin-left:-16px;" id="radNo" name="radIsVisible" value="No"  /><%=Resources.Resource.No %>
                                             </label>  
                                   </div>
                                
                                    </div>
                                   
                                     <div class="control">
                                        <label id="ColsError" class="alert alert-error hide" style="margin-top:30px; margin-bottom:-40px;" > This Column Already Exists! Plese Select Another</label>
                                          <button type="button" title="Add" style="margin-left:0px; margin-bottom:0px; margin-top:63px;" id="btnDelCols" class="btn button-submit">Delete</button>
                                           <a href="javascript:;" style="margin-left:0px; margin-top:63px;" class="btn green button-submit" id="btnAddCol">
                                            <%=Resources.Resource.add %> <i class="icon-ok"></i>
                                                 </a>  
                                              <table  cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tblCols">
	                                    
                                        <thead>
		                                    <tr>
			                                    
			                                    <th>Column NameEn</th>
			                                   <th>Column NameAr</th>
                                                <th>OrignalColumn Name</th>
                                                <th>Is Visible</th>
                                                <th>Column Type</th>
			                                    
		                                    </tr>
	                                    </thead>
	                                    <tbody>
		                                    
	                                    </tbody>
                                    </table>
                                </div>
                                     
                                    
                                     
                                </div>

                                 <div class="tab-pane" id="tab3">
                                    <h3 class="block"><%=Resources.Resource.ReportWizardSortHeading %></h3>
                                    <div class="control-group">
                                                                               
                                            <div id="SortBy">

                                            </div> 
                                       
                                       <div class="controls" style="margin-left:10px; margin-right:0px;">
                                           <label class="control-label" style="text-align:left; padding-top:0px;"> <%=Resources.Resource.SelectReportOrder %></label>

                                             <label class="radio" style="margin-left:25px !important; margin-right:40px !important;">
                                                <input type="radio" style="margin-left:-16px;" id="AscRadio" name="radSort" value="Ascending" checked="checked" /><%=Resources.Resource.Ascending %>
                                             </label>
                                             <label class="radio" style="margin-left:25px !important;">
                                             <input type="radio" style="margin-left:-16px;" id="DescRadio" name="radSort" value="Descending"  /><%=Resources.Resource.Descending %>
                                             </label>  <br />
                                         </div>
                                        </div>
                                            <div class="control-group"> 
                                         <div class="control">
                                        <label id="SortError" class="alert alert-error hide" style="margin-top:30px; margin-bottom:-40px; " > This Column Already Exists! Plese Select Another</label>
                                          <button type="button" title="Add" style=" margin-left:0px; margin-bottom:0px; margin-top:63px;" id="btnDelSort" class="btn button-submit">Delete</button>
                                           <a href="javascript:;" style=" margin-top:63px;" class="btn green button-submit" id="btnAddSortBy">
                                            <%=Resources.Resource.add %> <i class="icon-ok"></i>
                                                 </a>                              
                                              <table  cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tblSort">
	                                    
                                        <thead>
		                                    <tr>
			                                    
			                                    <th>Column Name</th>
			                                    <th>Column Type</th>
			                                    
		                                    </tr>
	                                    </thead>
	                                    <tbody>
		                                    
	                                    </tbody>
                                    </table>
                                </div>
                                              

                                    </div>
                                    
                                 </div>

                                 <div class="tab-pane" id="tab4">
                                    <h3 class="block"><%=Resources.Resource.ReportWizardFilterHeading %></h3>
                                    <div id="Filters">
                                       
                                    </div>

                                     <div class='control-group'>
                                    <label class='control-label'>Select The Operator</label>
                                        <div class='controls'>
                                         <select id='Operator'  class='chosen span6' data-placehoder='Select The Operator'>
                                            <optgroup label='Select the operator'>
                                            <option>=</option>
                                            <option><</option>
                                            <option>></option>
                                            <option>!=</option>
                                            <option><=</option>
                                            <option>>=</option>
                                            <option>LIKE</option>
                                            <option>ANY</option>
                                            </optgroup>
                                        </select>
                                           
                                         </div>
                                         

                                    </div>
                                       <div class="control-group">
                                        
                                          <label class="control-label"><%=Resources.Resource.ColumnName %></label>
                                       <div class="controls">
                                          
                                           <input type="Text" class="span6 m-wrap" id="FilterName" />
                                           
                                           
                                       </div>
                                     </div>


                                     <div class="control-group">
                                       <label class="control-label"><%=Resources.Resource.ColumnNameAr %></label>
                                       <div class="controls">
                                          <input type="Text" class="span6 m-wrap" id="FilterNameAr" />
                                         
                                       </div>
                                    </div>
                                     <div class='control-group'>
                                          <div class="control">
                                       <%-- <label id="lblError" class="alert alert-error hide" style=" margin-bottom:-40px;" > This Column Already Exists! Plese Select Another</label>
                                          <button type="button" title="DELETE" style=" margin-top:63px;" id="btnDelete" class="btn button-submit">Delete</button>
                                             --%> 
                                               <label id="lblError" class="alert alert-error hide" style=" margin-top:30px; margin-bottom:-40px;" > This Column Already Exists! Plese Select Another</label>
                                          <button type="button" title="Delete" style=" margin-left:0px; margin-bottom:0px; margin-top:63px;" id="btnDelete" class="btn button-submit">Delete</button>
                                                 <a href="javascript:;" style="margin-left:0px; margin-top:63px" class="btn green button-submit" id="btnAddFilters">
                                  <%=Resources.Resource.add %> <i class="icon-ok"></i>
                                 </a>                         
                                              <table  cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example">
	                                    
                                        <thead>
		                                    <tr>
			                                    <th>Column Name</th>
			                                    <th>Column NameAr</th>
			                                    <th>Column Original Name</th>
			                                    <th>Column Operator</th>
                                                <th>Column Type</th>
		                                    </tr>
	                                    </thead>
	                                    <tbody>
		                                    
	                                    </tbody>
                                    </table>
                                </div>
                                    </div>
                                     </div>

                                 <div class="tab-pane" id="tab5">
                                    <h3 class="block"><%=Resources.Resource.ReportWizardGroupHeading %></h3>
                                    <div id="GrpBY">
                                        
                                    </div>
                                      <div class="control">
                                        <label id="GroupError" class="alert alert-error hide" style=" margin-bottom:-40px;" > This Column Already Exists! Plese Select Another</label>
                                          <button type="button" title="Delete" style="margin-left:0px; margin-bottom:0px; margin-top:63px;" id="btnDelGrpBy" class="btn button-submit">Delete</button>
                                             <a href="javascript:;" style="margin-left:0px; margin-top:63px" class="btn green button-submit" id="btnAddGroupBy">
                                  <%=Resources.Resource.add %> <i class="icon-ok"></i>
                                 </a>                               
                                              <table  cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tblGroupBy">
	                                    
                                        <thead>
		                                    <tr>
			                                    
			                                    <th>Column Name</th>
			                                    
                                                <th>Column Type</th>
			                                    
		                                    </tr>
	                                    </thead>
	                                    <tbody>
		                                    
	                                    </tbody>
                                    </table>
                                </div>
                                 </div>
                              
                              <div class="form-actions clearfix">
                                 <a href="javascript:;" class="btn button-previous" id="btnBack">
                                 <i class="m-icon-swapleft"></i>  <%=Resources.Resource.back %> 
                                 </a>
                                 <a href="javascript:;" class="btn blue button-next" id="btnNext">
                                <%=Resources.Resource.next %> <i class="m-icon-swapright m-icon-white"></i>
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
 <style type="text/css">
.dataTables_filter {
display: none; 
}
.dataTables_length {
    display: none !important; 
     }
     .row_selected {
         background:#0094ff;
     }
</style>
    <script>
        $(document).ready(function () {
            // initiate layout and plugins
            $('#lblError').addClass('hide');
            $('#btnBack').hide();
            $('#btnSave').hide();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#liRpt").addClass("active");
            $("#liRpt .arrow").addClass("open");
            $("#liTemplateWizard").addClass("active");

            App.init();

            FormWizard.init();
            FormComponents.init();
            // $('#step').text("Step 1 of 6 ");

        });

        var i = 0;
        var b = 0;
        var columnsValues = [];
        var sortbyValues = [];
        var filterValues = [];
        var GroupValues = [];
        var sortOrder = "";
        var filterTable;
        var colTable;
        var sortTablr;
        var grpTable;
        var reportLayout = "";
        var category = "";

        /* Init the table */
        filterTable = jQuery('#example').dataTable(
            {
                "bFilter": false,
                //  "bInfo": false,
                "bPaginate": false,
                "bSort": false,

                //'iDisplayLength': 100
            });

        colTable = jQuery('#tblCols').dataTable(
            {
                "bFilter": false,
                //  "bInfo": false,
                "bPaginate": false,
                "bSort": false,

                //'iDisplayLength': 100
            });

        sortTablr = jQuery('#tblSort').dataTable(
            {
                "bFilter": false,
                //  "bInfo": false,
                "bPaginate": false,
                "bSort": false,

                //'iDisplayLength': 100
            });

        grpTable = jQuery('#tblGroupBy').dataTable(
            {
                "bFilter": false,
                //  "bInfo": false,
                "bPaginate": false,
                "bSort": false,

                //'iDisplayLength': 100
            });


        //------------DELETE ROW-----------------

        /* Add a click handler for the delete row */

        jQuery('#btnDelete').click(function () {
            var anSelected = fnGetSelected(filterTable);
            if (anSelected.length !== 0) {
                filterTable.fnDeleteRow(anSelected[0]);
            }
        });


        jQuery('#btnDelCols').click(function () {
            var anSelected = fnGetSelected(colTable);
            if (anSelected.length !== 0) {
                colTable.fnDeleteRow(anSelected[0]);
            }
        });

        jQuery('#btnDelGrpBy').click(function () {
            var anSelected = fnGetSelected(grpTable);
            if (anSelected.length !== 0) {
                grpTable.fnDeleteRow(anSelected[0]);
            }
        });

        jQuery('#btnDelSort').click(function () {
            var anSelected = fnGetSelected(sortTablr);
            if (anSelected.length !== 0) {
                sortTablr.fnDeleteRow(anSelected[0]);
            }
        });


        /* Get the rows which are currently selected */
        function fnGetSelected(oTableLocal) {;
            return oTableLocal.$('tr.row_selected');
        }
        jQuery('#btnBack').click(function () {
            if (i == 1) {

                jQuery('#tab6').hide();
                jQuery('#tab1').show();
                jQuery('#btnBack').hide();
                i = 0;
            }
            if (i == 2) {

                jQuery('#tab2').hide();
                jQuery('#tab6').show();
                i = 1;

            }
            if (i == 3) {

                jQuery('#tab3').hide();
                jQuery('#tab2').show();
                i = 2;

            }
            if (i == 4) {
                jQuery('#tab4').hide();
                jQuery('#tab3').show();
                i = 3;
            }
            if (i == 5) {
                jQuery('#tab5').hide();
                jQuery('#tab4').show();
                jQuery('#btnSave').hide();
                jQuery('#btnNext').show();
                i = 4;
            }
            if (i == 6) {


                i = 5;
            }
        });
        jQuery('#btnSave').click(function () {

            SaveReportTemplate();
        });

        jQuery('#btnCancel').click(function () {

            window.location.href = '../Reports/TemplateWizard.aspx';

        });
        // -------------- Add Columns in to the Grid --------------


        //-------------ADD FILTERS-----------------

        jQuery('#btnAddFilters').click(function () {
            var ColName = $("#selFilters option:selected").text();  //$('#select2_sample3').selected.val();
            var result = false;
            var ColOps = $("#Operator option:selected").text(); //$('#Operator').val();
            var bData = filterTable.fnGetData();
            var ColNameEn = $("#FilterName").val();
            var ColNameAr = $("#FilterNameAr").val();
            if (ColNameAr != '' && ColNameEn != '') {
                if (bData != '') {
                    for (row = 0 ; row < bData.length; row++) {
                        if (bData[row].indexOf(ColName) != -1 && bData[row].indexOf(ColNameEn) != -1) {
                            result = true;
                        }
                    }
                }
                if (result == false) {
                    $('#example').dataTable().fnAddData([
                ColNameEn,
                ColNameAr,
                ColName,
                ColOps,
                 "Filter"
                    ]);
                    $('#FilterName').val("");
                    $('#FilterNameAr').val("");
                    // b++;
                }
                else {

                    $('#lblError').removeClass('hide');

                }
            }
        });

        //--------- ADD COLUMNS --------------------
        jQuery('#btnAddCol').click(function () {
            var OrignalColName = $("#select2_sample3 option:selected").text();  //$('#select2_sample3').selected.val();
            var ColNameEn = $('#txtColumnName').val();
            var ColNameAr = $('#txtColumnNameAr').val();
            var IsVisible;
            if (($("#radYes").attr("checked") == "checked")) {
                IsVisible = $('#radYes').val();
                //alert(IsVisible);
            }
            else if (($("#radNo").attr("checked") == "checked")) {

                IsVisible = $('#radNo').val();
            }

            // alert(IsVisible);
            var result = false;
            //  var ColOps = $("#Operator option:selected").text(); //$('#Operator').val();
            if (ColNameEn != '' & ColNameAr != '') {
                var bData = colTable.fnGetData();
                if (bData != '') {
                    for (row = 0 ; row < bData.length; row++) {
                        if (bData[row].indexOf(OrignalColName) != -1 || bData[row].indexOf(ColNameEn) != -1 || bData[row].indexOf(ColNameAr) != -1) {
                            result = true;
                        }
                    }
                }
                if (result == false) {
                    $('#tblCols').dataTable().fnAddData([

                ColNameEn,
               ColNameAr,
               OrignalColName,
               IsVisible,
                 "Report Column"
                    ]);
                    $('#txtColumnName').val("");
                    $('#txtColumnNameAr').val("");
                    //b++;
                }
                else {

                    $('#ColsError').removeClass('hide');

                }
            }
        });

        //--------END--------

        //-------------ADD GROUP BY COLUMNS ---------

        jQuery('#btnAddGroupBy').click(function () {
            // alert("P");
            var ColName = $("#selGroupBy option:selected").text();  //$('#select2_sample3').selected.val();
            var result = false;
            // var ColOps = $("#Operator option:selected").text(); //$('#Operator').val();
            var bData = grpTable.fnGetData();
            if (bData != '') {
                for (row = 0 ; row < bData.length; row++) {
                    if (bData[row].indexOf(ColName) != -1) {
                        result = true;
                    }
                }
            }
            if (result == false) {
                $('#tblGroupBy').dataTable().fnAddData([

            ColName,

             "Group By"
                ]);
                b++;
            }
            else {

                $('#GroupError').removeClass('hide');

            }
        });

        //------- END

        //--------ADD SORT BY COLUMNS---------

        jQuery('#btnAddSortBy').click(function () {
            var ColName = $("#selSortBy option:selected").text();  //$('#select2_sample3').selected.val();
            var result = false;
            //  var ColOps = $("#Operator option:selected").text(); //$('#Operator').val();
            var bData = sortTablr.fnGetData();
            if (bData != '') {
                for (row = 0 ; row < bData.length; row++) {
                    if (bData[row].indexOf(ColName) != -1) {
                        result = true;
                    }
                }
            }
            if (result == false) {
                $('#tblSort').dataTable().fnAddData([

            ColName,
            "Sort By"
                ]);
                b++;
            }
            else {

                $('#SortError').removeClass('hide');

            }
        });
        // --------------------END OF ADD --------------


        //----------- Hide Error ----------------

        $('#selFilters').live("change", function () {
            $('#lblError').addClass('hide');
        });

        $('#select2_sample3').live("change", function () {
            $('#ColsError').addClass('hide');
        });

        $('#selGroupBy').live("change", function () {
            $('#GroupError').addClass('hide');
        });

        $('#selSortBy').live("change", function () {
            $('#SortError').addClass('hide');
        });
        $('#txtReportNameEn').live("focus", function () {
            $('#lblErrorMsg').addClass('hide');
        });
        $('#txtReportNameAr').live("focus", function () {
            $('#lblErrorMsg').addClass('hide');
        });
        //----------END---------------

        //--------- GET THE SELECTED ROWS ------------

        $('#example tbody tr').live("click", function () {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
            }
            else {
                filterTable.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }
        });

        $('#tblCols tbody tr').live("click", function () {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
            }
            else {
                colTable.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }
        });
        $('#tblSort tbody tr').live("click", function () {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
            }
            else {
                sortTablr.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }
        });
        $('#tblGroupBy tbody tr').live("click", function () {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
            }
            else {
                grpTable.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }
        });

        //------------------END ---------------------------

        //---------------NEXT BUTTON CLICK EVENTS ---------------
        jQuery('#btnNext').click(function () {
            if (i == 0) {

                if ($('#txtReportNameEn').val() != '' && $('#txtReportNameAr').val() != '') {
                    jQuery('#tab1').hide();
                    jQuery('#tab6').show();
                    jQuery('#btnBack').show();
                    i = 1;
                }
                else {

                    $('#lblErrorMsg').removeClass('hide');
                }
            }
            else if (i == 1) {



                jQuery('#tab6').hide();
                jQuery('#tab2').show();
                jQuery('#btnBack').show();
                var action = "Columns";

                LoadColumns(action);
                i = 2;

            }
            else if (i == 2) {
                if (colTable.fnGetData() != "") {
                    jQuery('#tab2').hide();
                    jQuery('#tab3').show();

                    var action = "SortBy";
                    LoadColumns(action);
                    i = 3;
                }
                else {
                    $('#ColsError').html("Select Atleast One Column For Report");
                    $('#ColsError').removeClass('hide');

                }
            }
            else if (i == 3) {

                jQuery('#tab3').hide();
                jQuery('#tab4').show();
                var action = "Filters";
                LoadColumns(action);
                i = 4;
            }
            else if (i == 4) {

                jQuery('#tab4').hide();
                jQuery('#tab5').show();
                var action = "GroupBy";
                LoadColumns(action);
                jQuery("#btnSave").show();
                jQuery("#btnNext").hide();
                i = 5;
            }
            //else if (i == 5) {

            //    $('#selGroupBy :selected').each(function () {
            //        GroupValues.push($(this).val());
            //    });
            //    jQuery("#btnSave").show();
            //    i = 6;
            //}
        });


   </script>
</asp:Content>
