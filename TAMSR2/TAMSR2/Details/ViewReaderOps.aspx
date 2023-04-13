<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewReaderOps.aspx.cs" Inherits="TAMSR2.Details.ViewReaderOps" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.readerOperations %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/css/bootstrap-tree.css" />
    <!-- END PAGE LEVEL STYLES -->
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
         <!-- BEGIN SET PASSWORD PORTLET CONFIGURATION MODAL FORM-->
         <div id="portlet-config" class="modal hide">
            <div class="modal-body">
               <div class="row-fluid">
               <div class="span12">
                  <!-- BEGIN VALIDATION STATES-->
                  <div class="portlet box purple">
                     <div class="portlet-title">
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.resetDevicePassword %></h4>
                     </div>
                     <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <form action="#" id="form_sample_1" class="form-horizontal">
                           <div id="divErrorMsg3" class="alert alert-error hide">
                              <button class="close" data-dismiss="alert"></button>
                              <span id="spnErrorMsg3"> <%=Resources.Resource.formErrors %></span> 
                           </div>
                           <div id="divSuccessMsg3" class="alert alert-success hide">
                              <button class="close" data-dismiss="alert"></button>
                              <span id="spnSuccessMsg3"><%=Resources.Resource.formErrorsRemoved %></span> 
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.password %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="password" id="txtPassword" size="4" name="txtPassword" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="control-group">
                              <label class="control-label"><%=Resources.Resource.retypePassword %><span class="required">*</span></label>
                              <div class="controls">
                                 <input type="password" id="txtConfirmPassword" size="4" name="txtConfirmPassword" data-required="1" class="span6 m-wrap"/>
                              </div>
                           </div>
                           <div class="form-actions">
                               <span id="spnID" style="display: none;">0</span>
                              <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                              <button id="btnSave" type="button" onclick="return ResetDevicePassword('RESET_PWD');" class="btn purple"><%=Resources.Resource.save %></button>
                              <button type="button" onclick="return Clear()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
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
         <!-- END SET PASSWORD PORTLET CONFIGURATION MODAL FORM-->


         <!-- BEGIN Download FileSET PASSWORD PORTLET CONFIGURATION MODAL FORM-->
         <div id="portlet-config-Download-File" class="modal hide">
            <div class="modal-body">
               <div class="row-fluid">
               <div class="span12">
                  <!-- BEGIN VALIDATION STATES-->
                  <div class="portlet box purple">
                     <div class="portlet-title">
                        <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.downloadFile %></h4>
                     </div>
                     <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <form action="#" id="form3" class="form-horizontal">
                           <div id="divErrorMsg4" class="alert alert-error hide">
                              <button class="close" data-dismiss="alert"></button>
                              <span id="spanErrorMsg4"> <%=Resources.Resource.formErrors %></span> 
                           </div>
                           <div id="divSuccessMsg4" class="alert alert-success hide">
                              <button class="close" data-dismiss="alert"></button>
                              <span id="spanSuccessMsg4"><%=Resources.Resource.formErrorsRemoved %></span> 
                           </div>
                           <div id="divGetDownloadedFiles">
                               <select id='ddDownloadedFile' size='15' style="width:100%"> <option value=''><%=Resources.Resource.noRecordFound %></option> </select>
                           </div>
                           <div class="form-actions">
                              <button id="btnSaveDownload" type="button" onclick="return DownloadFile('DOWNLOAD_FILE');" class="btn purple"><%=Resources.Resource.downloadFile %></button>
                              <button type="button" onclick="return Clear()" data-dismiss="modal" class="btn"><%=Resources.Resource.cancel %></button>
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
         <!-- END Download File PORTLET CONFIGURATION MODAL FORM-->



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
									<%=Resources.Resource.readerOperations %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a>
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.employee %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.readerOperations %></a></li>					
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
             <div class="row-fluid">
                 <div class="span12">
                     <div class="span6">
                         <div class="control-group">
                             <label style="clear: both; width: 100px !important; display: inline; float: <%= floatStr %>" class="control-label"><%=Resources.Resource.priority %> <span class="required">*</span></label>
                             <div class="controls chzn-controls" style="clear: both; display: inline;">
                                 <select id="ddPriority" style="display: inline; width: 220px;" name="sex" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.priority %>" tabindex="1">
                                     <option value="0"><%=Resources.Resource.normal %> </option>
                                     <option value="1"><%=Resources.Resource.medium %> </option>
                                     <option value="2"><%=Resources.Resource.high %> </option>
                                 </select>
                             </div>
                             <br />
                             <br />
                         </div>
                         </div>
                     <div class="span6">
                         <div class="control-group">
                             <label style="clear: both; width: 100px !important; display: inline; float: <%= floatStr %>" class="control-label"><%=Resources.Resource.action %> <span class="required">*</span></label>
                             <div class="controls chzn-controls" style="clear: both; display: inline;">
                                 <select id="ddBulkOperation" style="display: inline; width: 220px;" name="sex" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.action %>" tabindex="1">
                                     <option value="">---Select Bulk Operations---</option>
                                     <option value="settime"><%=Resources.Resource.setTime %> </option>
                                     <option value="unlock"><%=Resources.Resource.unlockReader %> </option>
                                     <option value="DELETE_ALL_FP"><%=Resources.Resource.deleteAllTemplates %> </option>
                                 </select>
                             </div>
                             <br />
                             <br />
                         </div>
                     </div>
                     <div class="span12 pull-<%= floatStr %>" style="margin: 0px;">
                         <span id="spnAddButton" runat="server">
                             <a id="btnShowFileWindow" href="#portlet-config-Download-File" data-toggle="modal" style="display:none;">Show downloaded file window</a>
                             <a id="btnShowPwdWindow" href="#portlet-config" data-toggle="modal" style="display:none;">Show password window</a>
                             <table style="width:100%; text-align: left;">
                                 <tr>
                                     <td style="width: 7%;">
                                         <a id="btnUnlock" onclick="return LockUnlockReader('unlock');" style="cursor: pointer; font-weight: bold; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <i style="font-size: 30px; margin-left: -4px;" class="icon-unlock"></i>
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnLock" onclick="return LockUnlockReader('lock');" style="cursor: pointer; font-weight: bold; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <i style="font-size: 30px;" class="icon-lock"></i>
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnSetTime" onclick="return LockUnlockReader('settime');" style="cursor: pointer; font-weight: bold; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <i style="font-size: 30px; margin-left: -4px;" class="icon-time"></i>
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnResetDevicePassword" onclick="return  CheckReaderSelection('pwd');" style="cursor: pointer; font-weight: bold; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <img src="../Images/settings-icon.png" style="width: 30px; height: 30px; margin-left: -6px; margin-top: -8px;" />
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnDownloadFile" onclick="return GetDownloadFileList('file');" style="cursor: pointer; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <i style="font-size: 30px; margin-left: -6px;" class="icon-download-alt"></i>
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnLoadCardDevice" onclick="return ReaderEmployeeOperations('LOAD_CARD_DEVICE');" style="cursor: pointer; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <img src="../Images/load-card.png" style="width: 30px; height: 30px; margin-left: -6px; margin-top: -8px;" />
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnDeleteCardDevice" onclick="return ReaderEmployeeOperations('DELETE_CARD_DEVICE');" style="cursor: pointer; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <img src="../Images/delete-card.png" style="width: 30px; height: 30px; margin-left: -6px; margin-top: -8px;" />
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 8%;">
                                         <a id="btnUpload" onclick="return ReaderEmployeeOperations('UPLOAD_TEMPLATE_DEVICE');" style="cursor: pointer; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <img src="../Images/template-upload-device.png" style="width: 30px; height: 30px; margin-left: -6px; margin-top: -8px;" />
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnDownload" onclick="return ReaderEmployeeOperations('DOWNLOAD_FP_DATABASE');" style="cursor: pointer; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <img src="../Images/db-download.png" style="width: 30px; height: 30px; margin-left: -6px; margin-top: -8px;" />
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnDeleteTemplateDevice" onclick="return ReaderEmployeeOperations('DELETE_FP_DEVICE');" style="cursor: pointer; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <img src="../Images/template-delete-device.png" style="width: 30px; height: 30px; margin-left: -6px; margin-top: -8px;" />
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnDeleteAllTemplatesDevice" onclick="return LockUnlockReader('DELETE_ALL_FP');" style="cursor: pointer; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <img src="../Images/delete-all-device.png" style="width: 30px; height: 30px; margin-left: -6px; margin-top: -8px;" />
                                             </span> 
                                         </a>
                                     </td>
                                     <td style="width: 7%;">
                                         <a id="btnDeleteTemplateDatabase" onclick="return ReaderEmployeeOperations('DELETE_FP_DATABASE');" style="cursor: pointer; color: black; text-decoration: none;">
                                             <span class="big" style="background-image: url(&quot;../Images/btn-bg.png&quot;); background-color: transparent; background-repeat: no-repeat; font-size: 26px;">
                                                 <img src="../Images/delete-template-db.png" style="width: 30px; height: 30px; margin-left: -6px; margin-top: -8px;" />
                                             </span> 
                                         </a>
                                     </td>
                                 </tr>
                                 <tr>                                     
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.unlockReader %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.lockReader %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.setTime %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.resetDevicePassword %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.downloadFile %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.loadCardToDevice %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.eraseCardFromDevice  %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.uploadTemplateToDevice %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.downloadTemplateToDatabase %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.deleteTemplateFromDevice %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.eraseAllTemplatesFromDevice %>
                                     </th>                          
                                     <th style="width: 7%;">
                                         <%=Resources.Resource.deleteTemplateFromDatabase %>
                                     </th>
                                 </tr>
                             </table>
                             
                         </span>
                         <span id="spnDeleteButton" runat="server"></span>
                         <span id="Span1" runat="server"></span>
                     </div>
                     <div class="clearfix"></div>
                             <div id="divSuccessMsg" class="alert alert-success hide">
                                 <span id="spnSuccessMsg"><%=Resources.Resource.formErrors %></span>
                             </div>
                             <div id="divErrorMsg" class="alert alert-error hide">
                                 <span id="spnErrorMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                             </div>
                     <div class="clearfix"></div>
                     
                     <!-- BEGIN BUFFER TABLE PORTLET-->
                     <div class="portlet box light-grey">
                         <div class="portlet-title">
                             <div class="caption"><i class="icon-globe"></i><%=Resources.Resource.buffer %></div>
                             <div class="tools">
                                 <a href="javascript:;" class="collapse"></a>
                                 <a href="javascript:void(0);" onclick="return ReloadGrid()" class="reload"></a>
                             </div>
                         </div>
                         <div class="portlet-body">
                             <div class="clearfix">
                                 <div class="btn-group">
                                     <span id="Span2">&nbsp;</span>
                                 </div>
                                 <div class="btn-group pull-<%= pullDirectionStr %>" style="">
                                     <span id="spnBufferBtns" runat="server">
                                         <a id="btnBuuferCancel" onclick="return CancelBuffer();" style='margin: 0px 10px;' class="btn"><i class="icon-trash">&nbsp; <%=Resources.Resource.cancel %></i></a>
                                         <a id="btnBufferRetry" onclick="return RetryBuffer();" style='margin: 0px 10px;' class="btn blue"><i class="icon-trash">&nbsp; <%=Resources.Resource.retry %></i></a>
                                         <a id="btnBufferDelete" onclick="return DeleteBuffer();" style='margin: 0px 10px;' class="btn red"><i class="icon-trash">&nbsp; <%=Resources.Resource.delete %></i></a>
                                     </span>
                                 </div>
                             </div>
                             <table class="table table-striped table-bordered table-hover" id="sample_Buffer">
                                 <thead>
                                     <tr style="background-color: #e8e3e3;">
                                         <th style="text-align: center; width: 8px;">
                                             <input type="checkbox" class="group-checkable" data-set="#sample_Buffer .checkboxes" /></th>
                                         <th style="text-align: center;"><%=Resources.Resource.reader %></th>
                                         <th style="text-align: center;"><%=Resources.Resource.operation %></th>
                                         <th style="text-align: center;"><%=Resources.Resource.value %></th>
                                         <th style="text-align: center;"><%=Resources.Resource.priority %></th>
                                         <th style="text-align: center;"><%=Resources.Resource.status %></th>
                                         <th style="text-align: center;"><%=Resources.Resource.remarks %></th>
                                     </tr>
                                 </thead>
                                 <tbody>
                                 </tbody>
                             </table>
                         </div>
                     </div>
                     <!-- END BUFFER TABLE PORTLET-->
                     <div class="clearfix"></div>
                     <!-- BEGIN SAMPLE FORM PORTLET-->
                     <div class="portlet box blue tabbable">
                         <div class="portlet-title">
                             <div class="caption">
                                 <i class="icon-reorder"></i>
                                 <span class="hidden-480"><%=Resources.Resource.readerOperations %></span>
                             </div>
                         </div>
                         <div class="portlet-body form">

                             <div class="tabbable portlet-tabs">
                                 <ul class="nav nav-tabs">
                                     <li id="liTabEmployees"><a href="#portlet_tab2" data-toggle="tab"><%=Resources.Resource.employees %></a></li>
                                     <li class="active" id="liTabReaders"><a href="#portlet_tab1" data-toggle="tab"><%=Resources.Resource.readers %></a></li>
                                 </ul>

                                 <div class="tab-content">
                                     <div class="clearfix">
                                         <div class="btn-group">
                                             <span id="spnGridMsg">&nbsp;</span>
                                         </div>
                                     </div>
                                     <div class="tab-pane active" id="portlet_tab1">
                                         <!-- BEGIN FORM-->
                                         <form action="#" id="form1" class="form-horizontal">

                                             <table class="table table-striped table-bordered table-hover" id="sample_1">
                                                 <thead>
                                                     <tr style="background-color: #e8e3e3;">
                                                         <th style="text-align: center;">
                                                             <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.code %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.deviceGroup %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.location %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.connection %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.address %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.active %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.pollingType %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.enable %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.deleteable %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.punch %></th>
                                                     </tr>
                                                 </thead>
                                                 <tbody>
                                                 </tbody>
                                             </table>

                                         </form>
                                         <!-- END FORM-->
                                     </div>
                                     <div class="tab-pane" id="portlet_tab2">
                                         <!-- BEGIN FORM-->
                                         <form action="#" id="form2" class="form-horizontal">

                                             <div class="row-fluid">
                                                 <!--/span-->
                                                 <div  style="float: <%= pullDirectionStr %>">
                                                     <div class="control-group" style='display: inline; float: left;'>
                                                         <div class="">
                                                             <input id="chkboxStatus" type="checkbox" name="status" />
                                                             <%=Resources.Resource.active %>
                                                         </div>
                                                     </div>
                                                     <div class="control-group" style='display: inline; float: left;'>
                                                         <div class="">
                                                             <input id="chkboxOnReport" type="checkbox" name="status" />
                                                             <%=Resources.Resource.onReport %>
                                                         </div>
                                                     </div>
                                                 </div>
                                                 <!--/span-->
                                             </div>
                                             <table class="table table-striped table-bordered table-hover" id="sample_2">
                                                 <thead>
                                                     <tr style="background-color: #e8e3e3;">
                                                         <th style="text-align: center;">
                                                             <input type="checkbox" class="group-checkable" data-set="#sample_2 .checkboxes" /></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.number %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.name %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.joinDate %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.manager %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.punch %></th>
                                                         <th style="text-align: center;"><%=Resources.Resource.active %></th>
                                                         <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.designation %></th>
                                                         <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.organization %></th>
                                                         <th style="text-align: center;" class="hidden-480"><%=Resources.Resource.managerName %></th>

                                                     </tr>
                                                 </thead>
                                                 <tbody>
                                                 </tbody>
                                             </table>
                                         </form>
                                         <!-- END FORM-->

                                     </div>

                                 </div>
                             </div>
                         </div>
                     </div>
                     <!-- END SAMPLE FORM PORTLET-->

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
   <script src="../assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/js/bootstrap-tree.js"></script>
   
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
           $("#liDevices").addClass("active");
           $("#liDevices .arrow").addClass("open");
           $("#liCMI").addClass("active");
           $("#liCMI").addClass("open");
           $("#liCMI_ReaderOps").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

           $("#chkboxStatus").attr("checked", "checked");
           $("#uniform-chkboxStatus span").addClass("checked");

           $("#chkboxOnReport").attr("checked", "checked");
           $("#uniform-chkboxOnReport span").addClass("checked");

           $("#chkboxStatus").change(function () {
               LoadEmployeeGrid(false);
           });
           $("#chkboxOnReport").change(function () {
               LoadEmployeeGrid(false);
           });

           LoadReaderGrid();
           LoadEmployeeGrid(false);
           LoadBufferGrid();

           setInterval(LoadBufferGrid, 30000);

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

           $('#sample_2 .group-checkable').change(function () {
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

           $('#sample_Buffer .group-checkable').change(function () {
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
           
           $("#ddBulkOperation").change(function () {
               var operation = $("#ddBulkOperation").val();
               if (operation != "") {
                   var priority = $("#ddPriority").val();
                   var v = "key=bulkOperation&operation=" + operation + "&priority=" + priority + "&";
                   var confirmMsg = "<%=Resources.Resource.confirmUnlockReader %>";
                   if (operation == 'unlock')
                       confirmMsg = "<%=Resources.Resource.confirmUnlockReader %>";
                   if (operation == 'settime')
                       confirmMsg = "<%=Resources.Resource.confirmSetReaderTime %>";
                   if (operation == 'DELETE_ALL_FP')
                       confirmMsg = "<%=Resources.Resource.confirmDeleteAllTemplatesFromdevice %>";
                   
                   $("#divSuccessMsg").css("display", "none");
                   $("#divErrorMsg").css("display", "none");

                   if (confirm(confirmMsg)) {
                       confirmMsg = "<%=Resources.Resource.confirm %>" + "!!!! " + "<%=Resources.Resource.confirmDeleteAllTemplatesFromdevice %>";
                       if (operation == "DELETE_ALL_FP") {
                           if (!confirm(confirmMsg))
                               return;
                       }
                       $.ajax({
                           type: 'POST',
                           data: v,
                           url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
                           success: function (html) {
                               if (html == "1") {
                                   $("#divSuccessMsg").css("display", "block");
                                   $("#spnSuccessMsg").html("<%=Resources.Resource.operationAddedinQueue %>");

                                   $('#sample_Buffer').dataTable().fnDraw();
                                   $('#sample_Buffer').css("width", "100%");

                                   //$('#btnBroadCast').click();
                               }
                               else if (html == "-1") {
                                   $("#divErrorMsg").css("display", "block");
                                   $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                               }
                               else {
                                   $("#divErrorMsg").css("display", "block");
                                   $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                               }
                           },
                           error: function (html) {

                           }
                       });
                   }
                   else {
                   }
               }
           });

           // Declare a proxy to reference the hub. 
           var users = $.connection.chatHub;
           // Create a function that the hub can call to broadcast messages.
           users.client.broadcastMessage = function (name, message) {
               if (name == "TAMSR2_Reader_Ops") {
                   ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_Reader_Ops', '');
                   // Clear text box and reset focus for next comment. 
               });
           });
       });

       function LoadReaderGrid() {
           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false, sWidth: "5%" },
                 { "bSortable": true, sWidth: "7%" },
                 { "bSortable": true, sWidth: "20%" },
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "10%" },
                 { "bSortable": true, sWidth: "5%" },
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
               "sAjaxSource": '<%= Page.ResolveClientUrl("~/RequestPages/ReaderOpsPage.aspx?key=getAllByType") %>' + '&type=CMIReader'
           });
           $('#sample_1').css("width", "100%");
       }

       function LoadEmployeeGrid(filter) {

           ////////Get Users and load in grid/////////
           var url = '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx?key=getAll&v=reader") %>';
           url = url + '&activeStatus=' + $("#chkboxStatus").is(":checked") + '&onReport=' + $("#chkboxOnReport").is(":checked");

           var filterValue = "";
           if (filter == true) {
               filterValue = $("#txt_sample_2_filter").val();
               $("#sample_2_filter label input").val(filterValue);
           }
           url += "&sSearchFilter=" + filterValue;

           var oTable = $('#sample_2').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false, sWidth: "3%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "20%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "5%" },
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": true, sWidth: "15%" }
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
               "sAjaxSource": url
           });
           $('#sample_2').css("width", "100%");

           $("#sample_2_filter input").css("display", "none");
           $("txt_sample_2_filter").css("display", "");
           $("#sample_2_filter label").append("<input id='txt_sample_2_filter' value='' style='display: inline-block; margin-bottom: 0; border-color: rgba(82, 168, 236, 0.8); box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(82, 168, 236, 0.6); outline: 0 none;' />");
           if (filter == true) {
               $("#txt_sample_2_filter").val(filterValue);
               $("#sample_2_filter label input").val(filterValue);
           }
           $("#txt_sample_2_filter").keyup(function (e) {
               //alert(e.keyCode);
               if (e.keyCode == 13) {
                   //alert($("#txt_sample_2_filter").val());
                   //alert($("#sample_2_filter label input").val());
                   filterValue = $("#txt_sample_2_filter").val();
                   $("#sample_2_filter label input").val(filterValue);
                   $("#txt_sample_2_filter").val(filterValue);
                   LoadEmployeeGrid(true);//$('#sample_1').dataTable().fnDraw();
                   //alert($("#sample_2_filter label input").val());
               }
           });

       }

       function LoadBufferGrid() {
           ////////Get Users and load in grid/////////
           var oTable = $('#sample_Buffer').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false, sWidth: "5%" },
                 { "bSortable": true, sWidth: "20%" },
                 { "bSortable": true, sWidth: "15%" },
                 { "bSortable": false, sWidth: "10%" },
                 { "bSortable": false, sWidth: "10%" },
                 { "bSortable": false, sWidth: "10%" },
                 { "bSortable": false, sWidth: "30%" }
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
               "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx?key=getAllBuffer") %>'
           });
           $('#sample_Buffer').css("width", "100%");
       }

      function ReloadGrid() {
          $('#sample_1').dataTable().fnDraw();
          $('#sample_1').css("width", "100%");
          $('#sample_2').dataTable().fnDraw();
          $('#sample_2').css("width", "100%");
          $('#sample_Buffer').dataTable().fnDraw();
          $('#sample_Buffer').css("width", "100%");
      }
       
      function Clear() {
          $("#divSuccessMsg").css("display", "none");
          $("#divErrorMsg").css("display", "none");
          $("#divSuccessMsg2").css("display", "none");
          $("#divErrorMsg2").css("display", "none");
          $("#divSuccessMsg3").css("display", "none");
          $("#divErrorMsg3").css("display", "none");
          $("#divSuccessMsg4").css("display", "none");
          $("#divErrorMsg4").css("display", "none");

          $("#txtPassword").val("");
          $("#txtConfirmPassword").val("");

          $('.help-inline').hide();
          $('.control-group').removeClass('error');
          $('.control-group').removeClass('success');
          $('.help-inline ok valid').hide();


      }

      function LockUnlockReader(operation) {
          var priority = $("#ddPriority").val();
          var v = "key=lock&operation=" + operation + "&priority=" + priority + "&";
          var confirmMsg = "<%=Resources.Resource.confirmLockReader %>";
          if (operation == 'unlock')
              confirmMsg = "<%=Resources.Resource.confirmUnlockReader %>";
          if (operation == 'settime')
              confirmMsg = "<%=Resources.Resource.confirmSetReaderTime %>";
          if (operation == 'DELETE_ALL_FP')
              confirmMsg = "<%=Resources.Resource.confirmDeleteAllTemplatesFromdevice %>"; 
          $("#divSuccessMsg").css("display", "none");
          $("#divErrorMsg").css("display", "none");

          var k = 0;
          $("#sample_1 tbody").find("input:checkbox").each(function () {
              if (this.checked == true) {
                  k++;
                  v += "chk" + k + "=" + this.value + "&";
                  //this.checked = chk.checked;
              }
          });
          v += "count=" + k;
          v += "&pwd=";

          if (k == 0) {
              $("#divErrorMsg").css("display", "block");
              $("#spnErrorMsg").html("<%=Resources.Resource.selectOneReader %>");
              return;
          }
          if (confirm(confirmMsg)) {
              confirmMsg = "<%=Resources.Resource.confirm %>" + "!!!! " + "<%=Resources.Resource.confirmDeleteAllTemplatesFromdevice %>";
              if (operation == "DELETE_ALL_FP") {
                  if (!confirm(confirmMsg))
                      return;
              }
              $.ajax({
                  type: 'POST',
                  data: v,
                  url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
                  success: function (html) {
                      if (html == "1") {
                          $("#divSuccessMsg").css("display", "block");
                          $("#spnSuccessMsg").html("<%=Resources.Resource.operationAddedinQueue %>");

                          $('#sample_Buffer').dataTable().fnDraw();
                          $('#sample_Buffer').css("width", "100%");

                          //$('#btnBroadCast').click();
                      }
                      else if (html == "-1") {
                          $("#divErrorMsg").css("display", "block");
                          $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                      }
                      else {
                          $("#divErrorMsg").css("display", "block");
                          $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                      }
                  },
                  error: function (html) {

                  }
              });
          }
          else {
          }
      }
       function CheckReaderSelection(operation) {
           Clear();
           var k = 0;
           $("#sample_1 tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   k++;
               }
           });
           if (k == 0) {
               $("#divErrorMsg").css("display", "block");
               $("#spnErrorMsg").html("<%=Resources.Resource.selectOneReader %>");
               return false;
           }
           else {
               if (operation == 'pwd')
                   $("#btnShowPwdWindow").click();
               return true;
           }
       }

       function GetDownloadFileList() {
           if (!CheckReaderSelection(""))
               return false;

           $("#btnShowFileWindow").click();

           var v = "key=getDownloadFileList";
           $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
               success: function (html) {
                   $("#divGetDownloadedFiles").html(html);
               },
               error: function (html) {
                   $("#divGetDownloadedFiles").html("<select id='ddDownloadedFile' size='15' style='width:100%'> <option value=''><%=Resources.Resource.noRecordFound %></option> </select>");
               }
           });

       }

       function DownloadFile(operation) {
           var priority = $("#ddPriority").val();
           var v = "key=lock&operation=" + operation + "&priority=" + priority + "&";
           var confirmMsg = "<%=Resources.Resource.confirmDownloadFile %>";

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");
           $("#divSuccessMsg3").css("display", "none");
           $("#divErrorMsg3").css("display", "none");
           $("#divSuccessMsg4").css("display", "none");
           $("#divErrorMsg4").css("display", "none");

           
           var k = 0;
           $("#sample_1 tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   k++;
                   v += "chk" + k + "=" + this.value + "&";
                   //this.checked = chk.checked;
               }
           });
           v += "count=" + k;

           v += "&pwd=" + $("#ddDownloadedFile").val();
           if ($("#ddDownloadedFile").val() == "") {
               $("#divErrorMsg4").css("display", "block");
               $("#spnErrorMsg4").html("<%=Resources.Resource.selectOneFile %>");
              return;
           }

           

           if (confirm(confirmMsg)) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg4").css("display", "block");
                           $("#spnSuccessMsg4").html("<%=Resources.Resource.operationAddedinQueue %>");

                           $('#sample_Buffer').dataTable().fnDraw();
                           $('#sample_Buffer').css("width", "100%");

                           //$('#btnBroadCast').click();
                       }
                       else if (html == "-1") {
                           $("#divErrorMsg4").css("display", "block");
                           $("#spnErrorMsg4").html("<%=Resources.Resource.msgRecordExists %>");
                       }
                       else {
                           $("#divErrorMsg4").css("display", "block");
                           $("#spnErrorMsg4").html("<%=Resources.Resource.msgRecordNotSaved %>");
                       }
                   },
                   error: function (html) {

                   }
               });
       }
       else {
       }
   }

       function ResetDevicePassword(operation) {
           var priority = $("#ddPriority").val();
           var v = "key=lock&operation=" + operation + "&priority=" + priority + "&";
           var confirmMsg = "<%=Resources.Resource.confirmResetDevicePassword %>";

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");
           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");
           $("#divSuccessMsg3").css("display", "none");
           $("#divErrorMsg3").css("display", "none");

           if ($("#txtPassword").val() != $("#txtConfirmPassword").val()) {
               $("#divErrorMsg3").css("display", "block");
               $("#spnErrorMsg3").html("<%=Resources.Resource.msgpasswordNotMatch %>");
               return;
           }

           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }
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
               $("#divErrorMsg3").css("display", "block");
               $("#spnErrorMsg3").html("<%=Resources.Resource.selectOneReader %>");
              return;
           }

           v += "&pwd=" + $("#txtPassword").val();

           if (confirm(confirmMsg)) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
                   success: function (html) {
                       if (html == "1") {
                           $("#divSuccessMsg3").css("display", "block");
                           $("#spnSuccessMsg3").html("<%=Resources.Resource.operationAddedinQueue %>");

                           $('#sample_Buffer').dataTable().fnDraw();
                           $('#sample_Buffer').css("width", "100%");

                           //$('#btnBroadCast').click();
                       }
                       else if (html == "-1") {
                           $("#divErrorMsg3").css("display", "block");
                           $("#spnErrorMsg3").html("<%=Resources.Resource.msgRecordExists %>");
                       }
                       else {
                           $("#divErrorMsg3").css("display", "block");
                           $("#spnErrorMsg3").html("<%=Resources.Resource.msgRecordNotSaved %>");
                       }
                   },
                   error: function (html) {

                   }
               });
           }
           else {
           }
       }

       function ReaderEmployeeOperations(operation) {
           var priority = $("#ddPriority").val();
           var v = "key=readerEmployee&operation=" + operation + "&priority=" + priority + "&";
           var confirmMsg = "";
           if (operation == 'UPLOAD_TEMPLATE_DEVICE')
               confirmMsg = "<%=Resources.Resource.confirmUploadTemplateToDevice %>";
           else if (operation == 'DOWNLOAD_FP_DATABASE')
               confirmMsg = "<%=Resources.Resource.confirmDownloadTemplateFromDb %>";
           else if (operation == 'DELETE_FP_DEVICE')
               confirmMsg = "<%=Resources.Resource.confirmDeleteTemplateFromDevice %>";
           else if (operation == 'DELETE_FP_DATABASE')
               confirmMsg = "<%=Resources.Resource.confirmDeleteTemplateFromDb %>";
           else if (operation == 'LOAD_CARD_DEVICE')
               confirmMsg = "<%=Resources.Resource.confirmLoadCardToDevice %>";
           else if (operation == 'DELETE_CARD_DEVICE')
               confirmMsg = "<%=Resources.Resource.confirmDeleteCardFromDevice %>";
           else if (operation == 'DELETE_ALL_FP')
               confirmMsg = "<%=Resources.Resource.confirmDeleteAllTemplatesFromdevice %>";
           else
               return;

               $("#divSuccessMsg").css("display", "none");
               $("#divErrorMsg").css("display", "none");

               var k = 0;
               k = 0;
               $("#sample_1 tbody").find("input:checkbox").each(function () {
                   if (this.checked == true) {
                       k++;
                       v += "rdr" + k + "=" + this.value + "&";
                       //this.checked = chk.checked;
                   }
               });

               if (k == 0 && operation != 'DELETE_FP_DATABASE') {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.selectOneReader %>");
                   return;
               }

               v += "rdrCount=" + k;
               k = 0;
               $("#sample_2 tbody").find("input:checkbox").each(function () {
                   if (this.checked == true) {
                       k++;
                       v += "&emp" + k + "=" + this.value + "&";
                       //this.checked = chk.checked;
                   }
               });
               if (k == 0) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.selectOneEmployee %>");
                   return;
               }

               v += "empCount=" + k;

               if (confirm(confirmMsg)) {
                   confirmMsg =  "<%=Resources.Resource.confirm %>" + "!!!! " + "<%=Resources.Resource.confirmDeleteAllTemplatesFromdevice %>";
                   if (operation == "DELETE_ALL_FP") {
                       if (!confirm(confirmMsg))
                           return;
                   }
                   $.ajax({
                       type: 'POST',
                       data: v,
                       url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
                       success: function (html) {
                           if (html == "1") {
                               $("#divSuccessMsg").css("display", "block");
                               $("#spnSuccessMsg").html("<%=Resources.Resource.operationAddedinQueue %>");

                               $('#sample_Buffer').dataTable().fnDraw();
                               $('#sample_Buffer').css("width", "100%");

                               //$('#btnBroadCast').click();
                           }
                           else if (html == "-2") {
                               $("#divErrorMsg").css("display", "block");
                               $("#spnErrorMsg").html("<%=Resources.Resource.noRecordFound %>");
                           }
                           else if (html == "-1") {
                               $("#divErrorMsg").css("display", "block");
                               $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                           }
                           else {
                               $("#divErrorMsg").css("display", "block");
                               $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                           }
                       },
                       error: function (html) {

                       }
                   });
               }
               else {
               }
       }

       function CancelBuffer() {
           var v = "key=cancelBufferByID&";

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");

           var k = 0;
           $("#sample_Buffer_wrapper tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   k++;
                   v += "chk" + k + "=" + this.value + "&";
                   //this.checked = chk.checked;
               }
           });
           v += "count=" + k;

           if (k == 0) {
               $("#divErrorMsg").css("display", "block");
               $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
                   return;
               }
               if (confirm("<%=Resources.Resource.confirmCancel %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
                       success: function (html) {
                           if (html == "1") {
                               $("#divSuccessMsg").css("display", "block");
                               $("#spnSuccessMsg").html("<%=Resources.Resource.msgCancelSuccess %>");
                               $('#btnBroadCast').click();
                           }
                           else {
                               $("#divErrorMsg").css("display", "block");
                               $("#spnErrorMsg").html("<%=Resources.Resource.msgCancelFailed %>");
                           }
                       },
                   error: function (html) {

                   }
               });
               }
               else {
               }
           }

       function RetryBuffer() {
           var v = "key=retryBufferByID&";

           $("#divSuccessMsg").css("display", "none");
           $("#divErrorMsg").css("display", "none");

           var k = 0;
           $("#sample_Buffer_wrapper tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   k++;
                   v += "chk" + k + "=" + this.value + "&";
                   //this.checked = chk.checked;
               }
           });
           v += "count=" + k;

           if (k == 0) {
               $("#divErrorMsg").css("display", "block");
               $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
                   return;
               }
               if (confirm("<%=Resources.Resource.confirmRetry %>")) {
               $.ajax({
                   type: 'POST',
                   data: v,
                   url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
                       success: function (html) {
                           if (html == "1") {
                               $("#divSuccessMsg").css("display", "block");
                               $("#spnSuccessMsg").html("<%=Resources.Resource.operationAddedinQueue %>");
                               $('#btnBroadCast').click();
                           }
                           else {
                               $("#divErrorMsg").css("display", "block");
                               $("#spnErrorMsg").html("<%=Resources.Resource.msgRetryFailed %>");
                           }
                       },
                       error: function (html) {

                       }
                   });
               }
               else {
               }
           }

       function DeleteBuffer() {
               var v = "key=deleteBufferByID&";

               $("#divSuccessMsg").css("display", "none");
               $("#divErrorMsg").css("display", "none");

               var k = 0;
               $("#sample_Buffer_wrapper tbody").find("input:checkbox").each(function () {
                   if (this.checked == true) {
                       k++;
                       v += "chk" + k + "=" + this.value + "&";
                       //this.checked = chk.checked;
                   }
               });
               v += "count=" + k;

               if (k == 0) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.selectOne %>");
                   return;
               }
               if (confirm("<%=Resources.Resource.deleteMessage %>")) {
                   $.ajax({
                       type: 'POST',
                       data: v,
                       url: '<%= Page.ResolveClientUrl("../RequestPages/ReaderOpsPage.aspx") %>',
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
               else {
               }
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
                               txtPassword: {
                                   minlength: 4,
                                   maxlength: 4,
                                   required: true
                               },
                               txtConfirmPassword: {
                                   minlength: 4,
                                   maxlength: 4,
                                   required: true
                               }
                           },
                           message: {
                               txtPassword: {
                                   required: "<%=Resources.Resource.lblRequired %>"
                               },
                               txtConfirmPassword: {
                                   required: "<%=Resources.Resource.lblRequired %>"
                               }
                           },


                           errorPlacement: function (error, element) { // render error placement for each input type
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
           ////////////END OF VALIDATIONS/////////////

   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>


