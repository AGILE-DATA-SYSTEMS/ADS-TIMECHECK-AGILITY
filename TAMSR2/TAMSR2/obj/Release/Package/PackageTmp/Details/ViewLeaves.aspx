<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewLeaves.aspx.cs" Inherits="TAMSR2.Details.ViewLeaves" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.leaveTypes %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->

    <style>
        #divddParentLeave,
        #divWorkflow,
        #divchkboxIsParentType,
        #divchkboxNeedApproval,
        #divchkboxAllowAttachement,
        #divchkboxCommentsMandatory{
            display:none !important;
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
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.leaveTypes %></h4>
                     </div>
                     <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <form action="#" id="form_sample_1" class="form-horizontal">
                           <div id="divErrorMsg" class="alert alert-error hide">
                              <button class="close" data-dismiss="alert"></button>
                              <span id="spnErrorMsg"> <%=Resources.Resource.formErrors %></span> 
                           </div>
                           <div id="divSuccessMsg" class="alert alert-success hide">
                              <button class="close" data-dismiss="alert"></button>
                              <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span> 
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.code %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="text" id="txtCode" name="code" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.descriptionEn %></label>
                              <div class="controls">
                                 <input type="text" id="txtDescriptionEn" name="nameEn" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.descriptionAr %></label>
                              <div class="controls">
                                 <input type="text" id="txtDescriptionAr" name="nameAr" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group divParentLeave" id="divddParentLeave">
                              <label class="control-label"><%=Resources.Resource.parentLeave %> <span class="required">*</span> </label>
                              <div class="controls chzn-controls">
                                  <select id="ddParentLeave" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="ParentLeave" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.parentLeave %>" tabindex="1">
                                      <option value=""></option>
                                  </select>
                              </div>
                           </div>
                           <div class="control-group" id="divWorkflow">
                              <label class="control-label"><%=Resources.Resource.workflow %> <span class="required">*</span> </label>
                              <div class="controls chzn-controls">
                                  <select id="ddWorkflow" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="Workflow" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                      <option value=""></option>
                                  </select>
                              </div>
                           </div>
                           <div class="control-group" id="divchkboxIsParentType">
                               <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxIsParentType" type="checkbox" name="isParentType" /> <%=Resources.Resource.isParentType %>
                               </div>
                           </div>
                           <div class="control-group" id="divchkboxNeedApproval">
                               <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxNeedApproval" type="checkbox" name="needApproval" /> <%=Resources.Resource.needApproval %>
                               </div>
                           </div>
                           <div class="control-group">
                               <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxOfficial" type="checkbox" name="official" /> <%=Resources.Resource.official %> ( <%=Resources.Resource.ForNonDofEmployees %> )
                               </div>
                           </div>
                           <div class="control-group" id="divchkboxAllowAttachement">
                               <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxAllowAttachement" type="checkbox" name="allowAttachement" /> <%=Resources.Resource.allowAttachement %>
                               </div>
                           </div>
                           <div class="control-group" id="divchkboxCommentsMandatory">
                               <label class="control-label">&nbsp;</label>
                               <div class="controls">
                                   <input id="chkboxCommentsMandatory" type="checkbox" name="commentsMandatory" /> <%=Resources.Resource.commentsMandatory %>
                               </div>
                           </div>


                           <div class="form-actions">
                               <span id="spnID" style="display: none;">0</span>
                              <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                              <button id="btnSave" type="button" onclick="Save()" class="btn purple"><%=Resources.Resource.save %></button>
                              <button type="button" onclick="return CloseForm()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
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
                  <div class="color-panel hidden-phone">
                     <div style="display: none;" class="color-mode-icons icon-color"></div>
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
									<%=Resources.Resource.leaves %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a>
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.generalInfo %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.leaveTypes %></a></li>					
						
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
                        <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.leaveTypes %></div>
                        <div class="tools">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                        </div>
                     </div>
                     <div class="portlet-body">
                           <div id="divSuccessMsg2" class="alert alert-success hide">
                              <span id="spnSuccessMsg2"> <%=Resources.Resource.formErrors %></span> 
                           </div>
                           <div id="divErrorMsg2" class="alert alert-error hide">
                              <span id="spnErrorMsg2"><%=Resources.Resource.formErrorsRemoved %></span> 
                           </div>
                        <div class="clearfix">
                            <div class="btn-group">
                                <span id="spnGridMsg">&nbsp;</span>
                            </div>
                           <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                              <span id="spnAddButton" runat="server" >
                                  <a id="btnAdd" onclick="return Clear()" href="#portlet-config" data-toggle="modal" class="btn green"><i class="icon-plus"> &nbsp; <%=Resources.Resource.add %></i></a> 
                                  <a id="btnDelete" onclick="return Delete()" style='margin: 0px 10px;' class="btn red"><i class="icon-trash"> &nbsp; <%=Resources.Resource.delete %></i></a>                                   
                              </span>
                           </div>
                        </div>
                        <table class="table table-striped table-bordered table-hover" id="sample_1">
                           <thead>
                              <tr style="background-color: #e8e3e3;">
                                 <th style="text-align: center;width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                 <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                 <th style="text-align: center;"><%=Resources.Resource.description %></th>
                                 <%--<th style="text-align: center;"><%=Resources.Resource.needApproval %></th>--%>
                                 <th style="text-align: center;"><%=Resources.Resource.official %> ( <%=Resources.Resource.ForNonDofEmployees %> )</th>
                                 <%--<th style="text-align: center;" class="hidden-480"><%=Resources.Resource.allowAttachement %></th>--%>
                                 <%--<th style="text-align: center;" class="hidden-480"><%=Resources.Resource.lblComments %></th>--%>
                                 <%--<th style="text-align: center;" class="hidden-480"><%=Resources.Resource.parentLeave %></th>--%>
                                 <%--<th style="text-align: center;" class="hidden-480"><%=Resources.Resource.workflow %></th>--%>
                                 <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.updated %></th>
                                 <th style="text-align: center;width: 24px !important;">&nbsp;</th>
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
   <script src="../assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script> 
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
           LoadWorkflow();
           LoadParentLeaves();
           //TableManaged.init();
           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liGeneral").addClass("active");
           $("#liGeneral .arrow").addClass("open");
           $("#liGeneralLeave").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }
           //Hit not goes here because it does not exists in network also
           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false, sWidth: '3%' },
                 { "bSortable": true, sWidth: '10%' },
                 { "bSortable": true, sWidth: '25%' },
                 { "bSortable": true, sWidth: '25%' },
                 { "bSortable": true, sWidth: '25%' },
                 //{ "bSortable": true, sWidth: '5%' },
                 //{ "bSortable": true, sWidth: '5%' },
                 //{ "bSortable": true, sWidth: '10%' },
                 //{ "bSortable": true, sWidth: '15%' },
                 //{ "bSortable": true, sWidth: '10%'     },
                 //{ "bSortable": false, sWidth: '5%' },
                 //{ "bSortable": true, sWidth: '10%' },
                 //{ "bSortable": false, sWidth: '7%' },

                 { "bSortable": false, sWidth: '5%' }
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
               "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/LeavePage.aspx?key=getAll") %>'
           });

           $("#chkboxIsParentType").change(function() {
               if (this.checked) {
                   $("#ddParentLeave").val('0');
                   $(".divParentLeave").hide();
               }
               else {
                   LoadParentLeaves();
                   $(".divParentLeave").show();

               }
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
               if (name == "TAMSR2_Cmp_Leave") {
                   ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_Cmp_Leave', '');
                   // Clear text box and reset focus for next comment. 
               });
           });

       });
       
       function ReloadGrid() {
           $('#sample_1').dataTable().fnDraw();
       }

       function CloseForm() {
           Clear();
           $("#divSuccessMsg").hide();

       }

       
        function LoadWorkflow() {

            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/WorkflowPage.aspx") %>',
                success: function (html) {
                     
                    $("#ddWorkflow").html(html);
                    $("#ddWorkflow").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
       }

       function LoadParentLeaves()
       {
            var d = "key=getIdNameParentListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/LeavePage.aspx") %>',
                success: function (html) {
                     
                    $("#ddParentLeave").html(html);
                    $("#ddParentLeave").trigger("liszt:updated");
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                }
            });
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
           
           $("#chkboxNeedApproval").removeAttr("checked");
           $("#uniform-chkboxNeedApproval span").removeClass("checked");

           $("#chkboxOfficial").removeAttr("checked");
           $("#uniform-chkboxOfficial span").removeClass("checked");

           $("#chkboxIsParentType").removeAttr("checked");
           $("#uniform-chkboxIsParentType span").removeClass("checked");

           $(".divParentLeave").show();

           $("#chkboxCommentsMandatory").removeAttr("checked");
           $("#uniform-chkboxCommentsMandatory span").removeClass("checked");

           $("#chkboxAllowAttachement").removeAttr("checked");
           $("#uniform-chkboxAllowAttachement span").removeClass("checked");
           LoadParentLeaves();
                      
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
                   url: '<%= Page.ResolveClientUrl("../RequestPages/LeavePage.aspx") %>',
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
               url: '<%= Page.ResolveClientUrl("../RequestPages/LeavePage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       $("#spnID").val(j.ID);
                       $("#txtDescriptionEn").val(j.DescriptionEn);
                       $("#txtDescriptionAr").val(j.DescriptionAr);
                       $("#txtCode").val(j.Code);
                       if (j.ApproveNeedFlag + "" == "1") {
                           $("#chkboxNeedApproval").attr("checked", "checked");
                           $("#uniform-chkboxNeedApproval span").addClass("checked");
                       }
                       if (j.OfficialFlag + "" == "Y" || j.OfficialFlag + "" == "y") {
                           $("#chkboxOfficial").attr("checked", "checked");
                           $("#uniform-chkboxOfficial span").addClass("checked");
                       }


                       if (j.AllowAttachement + "" == "1") {
                           $("#chkboxAllowAttachement").attr("checked", "checked");
                           $("#uniform-chkboxAllowAttachement span").addClass("checked");
                       }
                       if (j.IsCommentMandatory + "" == "1") {
                           $("#chkboxCommentsMandatory").attr("checked", "checked");
                           $("#uniform-chkboxCommentsMandatory span").addClass("checked");
                       }
                       if (j.IsParentType + "" == "1") {
                           $("#chkboxIsParentType").attr("checked", "checked");
                           $("#uniform-chkboxIsParentType span").addClass("checked");
                       }
                       $('#ddWorkflow option[value=' + j.WorkflowID + ']').attr('selected', 'selected');
                       $("#ddWorkflow").trigger("liszt:updated");
                       $('#ddParentLeave option[value=' + j.ParentId + ']').attr('selected', 'selected');
                       $("#ddParentLeave").trigger("liszt:updated");
                   }
               },
               error: function (html) {

               }
           });
       }

       function Save() {
           debugger;
           var id = $("#spnID").html();
           var descriptionEn = $("#txtDescriptionEn").val();
           var descriptionAr = $("#txtDescriptionAr").val();
           
           var code = $("#txtCode").val();
           var needApproval = $("#chkboxNeedApproval").is(":checked");
           var official = $("#chkboxOfficial").is(":checked");
           var allowAttachement = $('#chkboxAllowAttachement').is(":checked");
           var isParentLeave = $("#chkboxIsParentType").is(":checked");
           var commentsMandatory = $("#chkboxCommentsMandatory").is(":checked");
           var workflowID = $("#ddWorkflow").val();

           if (isParentLeave != "true") {
               var parentID = $("#ddParentLeave").val();
           }




           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }
           var v = "key=save" + "&id=" + id + "&code=" + code + "&needApproval=" + needApproval;
           v += "&descriptionEn=" + descriptionEn + "&descriptionAr=" + descriptionAr + "&official=" + official + "&allowAttachement=" + allowAttachement + "&isParentLeave=" + isParentLeave + "&commentsMandatory=" + commentsMandatory + "&workflowID=" + workflowID + "&parentID=" + parentID;

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/LeavePage.aspx") %>',
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

                   var form1 = $('#form_sample_1');
                   var error1 = $('.alert-error', form1);
                   var success1 = $('.alert-success', form1);

                   form1.validate({
                       errorElement: 'span', //default input error message container
                       errorClass: 'help-inline', // default input error message class
                       focusInvalid: false, // do not focus the last invalid input
                       ignore: "",
                       rules: {
                           code: {
                               minlength: 2,
                               required: true,
                               maxlength: 20
                           },
                           nameEn: {
                               maxlength: 50
                           },
                           nameAr: {
                               maxlength: 50
                           }
                       },
                       message: {
                           code: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                       },
                       
                       errorPlacement: function (error, element) { // render error placement for each input type
                         //  alert(element);

                           if (element.attr("name") == "orgType") { // for uniform checkboxes, insert the after the given container
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
