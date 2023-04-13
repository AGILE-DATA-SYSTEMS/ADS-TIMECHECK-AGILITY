<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SavePermissionTypes.aspx.cs" Inherits="TAMSR2.Details.SavePermissionTypes" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.permissionTypes %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
    <!-- END PAGE LEVEL STYLES -->
<%--<style>
/*.alert-danger, .alert-error {
    color: #b94a48;
    background-color: #f2dede;
    border-color: #eed3d7;
    display: none !important;
}*/

</style>--%>
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
                    <%=Resources.Resource.permissionTypes %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Permission-Types") %>'><%=Resources.Resource.permissionTypes %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href='#'><%=Resources.Resource.permissionTypes %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid">
           <div class="span12">
                  <div class="portlet box blue" id="form_wizard_1">
                     <div class="portlet-title">
                        <div class="caption">
                           <i class="icon-reorder"></i> <%= Resources.Resource.permissionType %>  <%= Resources.Resource.wizard %> - <span class="step-title">Step 1 of 4</span>
                        </div>
                        <div class="tools hidden-phone">
                           <a href="javascript:;" class="collapse"></a>
                           <a href="#portlet-config" data-toggle="modal" class="config"></a>
                           <a href="javascript:;" class="reload"></a>
                           <a href="javascript:;" class="remove"></a>
                        </div>
                     </div>
                     <div class="portlet-body form">
                        <form action="#" class="form-horizontal" id="form_sample_1">
                            
                            <div id="divErrorMsg" class="alert alert-error hide">
                                <button class="close" data-dismiss="alert"></button>
                                <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                            </div>
                            <div id="divSuccessMsg" class="alert alert-success hide">
                                <button class="close" data-dismiss="alert"></button>
                                <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span>
                            </div>

                           <div class="form-wizard">
                              <div class="navbar steps">
                                 <div class="navbar-inner">
                                    <ul class="row-fluid nav nav-pills">
                                       <li class="span3 active">
                                          <a href="#tab1" data-toggle="tab" class="step active">
                                          <span class="number">1</span>
                                          <span class="desc"><i class="icon-ok"></i> <%= Resources.Resource.basic %></span>   
                                          </a>
                                       </li>
                                       <li class="span3">
                                          <a href="#tab2" data-toggle="tab" class="step">
                                          <span class="number">2</span>
                                          <span class="desc"><i class="icon-ok"></i>  <%= Resources.Resource.setup %></span>   
                                          </a>
                                       </li>
                                       <li class="span3">
                                          <a href="#tab3" data-toggle="tab" class="step">
                                          <span class="number">3</span>
                                          <span class="desc"><i class="icon-ok"></i>  <%= Resources.Resource.restrictions %></span>   
                                          </a>
                                       </li>
                                       <li class="span3">
                                          <a href="#tab4" data-toggle="tab" class="step">
                                          <span class="number">4</span>
                                          <span class="desc"><i class="icon-ok"></i>  <%= Resources.Resource.policy %></span>   
                                          </a> 
                                       </li>
                                    </ul>
                                 </div>
                              </div>
                              <div id="bar" class="progress progress-success progress-striped">
                                 <div class="bar" style="width: 25%;"></div>
                              </div>
                              <div class="tab-content">
                                 <div class="tab-pane active" id="tab1">
                                    <div class="row-fluid">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.reason %><span class="required">*</span>  </label>
                                            <div class="controls chzn-controls">
                                                <select id="ddReason" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="reason" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.reason %>" tabindex="1">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.code %> <span class="required">*</span></label>
                                            <div class="controls chzn-controls">
                                                <input type="text" id="txtCode" name="code" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                    <!--/row-->
                                    <div class="row-fluid">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.descriptionEn %> <span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" id="txtDescriptionEn" name="nameEn" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.descriptionAr %> <span class="required">*</span></label>
                                            <div class="controls">
                                                <input type="text" id="txtDescriptionAr" name="nameAr" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                               <!--/row--> 
                                <div class="row-fluid" id="divAttachmentComment"  >
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.permissionCommentsEn %></label>
                                              <div class="controls"> 
                                                 <textarea rows="3" id="txtCommentsEn" name="CommentsEn" data-required="1" class="span6 m-wrap"></textarea>
                                              </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.permissionCommentsAr %></label>
                                              <div class="controls"> 
                                                  <textarea rows="3" id="txtCommentsAr" name="CommentsAr" data-required="1" class="span6 m-wrap"></textarea> 
                                              </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row-->
                                     
                                    <div class="row-fluid">
                                         <div>&nbsp;&nbsp;</div>
                                         <div>&nbsp;&nbsp;</div>
                                     </div> 
                                      
                                 </div>
                                 <div class="tab-pane" id="tab2">
                                    <div class="row-fluid">
                                        <div class="span6">
                                        <div class="control-group" id="divWorkflow">
                                                <label class="control-label"><%=Resources.Resource.workflow %> <span class="required">*</span> </label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddWorkflow" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="Workflow" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.workflow %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.choose %> <%=Resources.Resource.organization %> </label>
                                                <div class="controls">
                                                     <select id="ddOrg" tabindex="2" data-placeholder="<%=Resources.Resource.organization %> " class="span6 chosen" name="org" style="width: 220px;"></select>
                                                </div>
                                           
                                            </div>
                                        </div>
                                    </div>
                                    <!--/row-->
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.group %> </label>
                                            <div class="controls">
                                                <select id="ddGroup" tabindex="2" data-placeholder="<%=Resources.Resource.group %> " class="span6 chosen" name="group" style="width: 220px;"></select>
                                            </div>
                                           
                                        </div>
                                        </div>
                                        <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.employee %> </label>
                                            <div class="controls">
                                                <select id="ddEmp" tabindex="2" data-placeholder="<%=Resources.Resource.employee %> " class="span6 chosen" name="emp" style="width: 220px;"></select>
                                            </div>
                                           
                                        </div>
                                     </div>
                                    <!--/span-->
                                    </div>
                                    <!--/row-->
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.gender %> </label>
                                             <div class="controls">
                                                <select id="ddSex" tabindex="2" data-placeholder="<%=Resources.Resource.gender %> " class="span6 chosen" name="sex" style="width: 220px;">
                                                    <option value=""><%=Resources.Resource.choose %> <%=Resources.Resource.gender %></option>
                                                    <option value="0"><%=Resources.Resource.female %></option>
                                                    <option value="1"><%=Resources.Resource.male %></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                         <!--/span-->
                                         <div class="span6 ">
                                              <div class="control-group"   id ="divNat">
                                              <label class="control-label"><%=Resources.Resource.nationality %></label>
                                              <div class="controls chzn-controls">
                                                 <select id="ddNat" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="nationality" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.nationality %>" tabindex="1">
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
                                            <label class="control-label"><%=Resources.Resource.validFrom %> </label>
                                            <div class="controls">
                                                <input id="txtFromDate" name="fromDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                            </div>
                                        </div>
                                    </div>
                                         <!--/span-->
                                     <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label"><%=Resources.Resource.validTill %> </label>
                                            <div class="controls">
                                                <input id="txtToDate" name="toDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                            </div>
                                        </div>
                                    </div>
                                        <!--/span-->
                                     </div>
                                    <!--/row-->
                                    
                                    <div class="row-fluid">
                                         <div>&nbsp;&nbsp;</div>
                                         <div>&nbsp;&nbsp;</div>
                                     </div> 
                                 </div>
                                 <div class="tab-pane" id="tab3">
                                  
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.maxMinutesPerDay %> <span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="text" id="txtMaxMinutesPerDay" name="maxMinutesPerDay" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span6 ">
                            
                                           <div class="control-group">
                                              <label class="control-label" style="width:180px !important;"><%=Resources.Resource.maxPermissionPerDay %><span class="required">*</span></label>
                                              <div class="controls">
                                                 <input type="text" id="txtMaxPermPerDay" name="maxPermPerDay" data-required="1"  style="width: 220px !important;" class="span6 m-wrap"/>
                                              </div>
                                           </div>
                                        </div>
                                        <!--/span-->
                                    </div>
                                    <!--/row-->
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.maxMinutesPerMonth %> <span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="text" id="txtMaxMinutesPerMonth" name="maxMinutesPerMonth" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span6 ">
                            
                                           <div class="control-group">
                                              <label class="control-label" style="width:180px !important;"><%=Resources.Resource.maxPermissionPerMonth %><span class="required">*</span></label>
                                              <div class="controls">
                                                 <input type="text" id="txtMaxPermPerMonth" name="maxPermPerMonth" data-required="1"  style="width: 220px !important;" class="span6 m-wrap"/>
                                              </div>
                                           </div>
                                        </div>
                                        <!--/span-->
                                    </div>
                                    <!--/row-->
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.minPermissionTime %><span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="text" id="txtMinDurationPerPermission" name="minDurationPerPermission" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span6 "> 
                                           <div class="control-group">
                                              <label class="control-label"><%=Resources.Resource.maxPermissionTime %><span class="required">*</span></label>
                                              <div class="controls">
                                                 <input type="text" id="txtMaxDurationPerPermission" name="maxDurationPerPermission" data-required="1"  style="width: 220px !important;" class="span6 m-wrap"/>
                                              </div>
                                           </div>
                                        </div>
                                        <!--/span-->
                                    </div>
                                       
                                    <div class="row-fluid">
                                     <div>&nbsp;&nbsp;</div>
                                     <div>&nbsp;&nbsp;</div>
                                 </div> 
                               </div>
                                 <div class="tab-pane" id="tab4">
                                     
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                             <label class="control-label">&nbsp;</label>
                                               <div class="controls">
                                                   <input id="chkboxGroupApply" type="checkbox" name="groupApply" /> <%=Resources.Resource.groupApply %>
                                               </div>
                                               <div class="controls">
                                                   <input id="chkboxOfficial" type="checkbox" name="official" /> <%=Resources.Resource.official %>
                                               </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span6 ">
                                             <div class="control-group">
                                               <label class="control-label">&nbsp;</label>
                                                 
                                               <div class="controls" style="display:none;" >
                                                   <input id="chkboxHRonly" type="checkbox" name="hrOnly" /> <%=Resources.Resource.hrOnly %>
                                                   
                                               </div>
                                                 <div class="controls">
                                                     <input id="chkboxRequiredComments" type="checkbox" name="RequiredComments" checked="checked" /> <%=Resources.Resource.commentsRequired %>
                                                 </div>
                                           </div>
                                        </div>
                                        <!--/span-->
                                    </div>
                                    <!--/row-->
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                             <label class="control-label">&nbsp;</label>
                                               <div class="controls">
                                                   <input id="chkboxAllowAttachement" type="checkbox" name="allowAttachement" /> <%=Resources.Resource.mandatoryAttachment %>
                                               </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span6 ">
                                             <div class="control-group">
                                               <label class="control-label">&nbsp;</label>
                                               <div class="controls">
                                                   <input id="ckhboxApplyRamadanRestriction" type="checkbox" name="ApplyRamadanRestriction" /> <%=Resources.Resource.applyRamadanRestriction %>
                                               </div>
                                           </div>
                                        </div>
                                        <!--/span-->
                                    </div>
                                    <!--/row-->
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                             <label class="control-label">&nbsp;</label>
                                               <div class="controls">
                                                   <input id="chkboxMedicalPassAttachment" type="checkbox" name="allowAttachement" /> <%=Resources.Resource.madicalPassAttachment %>
                                               </div>
                                        </div>
                                        <!--/span-->
                                        <div class="span6 ">
                             
                                        </div>
                                        <!--/span-->
                                    </div>
                                    <!--/row--> 
                                <div class="row-fluid"> 
                                <div class="span6 ">
                                    <div class="control-group">
                                      <label class="control-label"></label>
                                        <div class="controls">
                                        <label class="radio">
                                         <div class="radio" id="divHoursPermissions"><span class=""><input type="radio" name="Permission" value="1"  style="opacity: 0;"></span></div>
                                          <%=Resources.Resource.byHoursPermissions %>
                                  </label>
                                  
                                       </div>
                                   </div>
                                </div>
                        <!--/span-->
                            <div class="span6 ">
                               <div class="control-group" id="divPriority" style="display:none;">
                                  <label class="control-label"><%=Resources.Resource.priority %></label>
                                  <div class="controls chzn-controls">
                                     <select id="ddPriority" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="priority" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.priority %>" tabindex="1">
                                  
                                        <option value="1"><%=Resources.Resource.late  %></option>
                                        <option value="2"><%=Resources.Resource.early %></option>
                                        <option value="3"><%=Resources.Resource.missTime %></option>
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
                              <label class="control-label"></label>
                                <div class="controls">
                                  <label class="radio">
                                      <div class="radio" id="divTimePermissions"><span class="checked"><input type="radio" name="Permission" value="0" checked="" style="opacity: 0;"></span></div>
                                                  <%=Resources.Resource.byTimePermissions %>
                                  </label>
                               </div>
                           </div>
                        </div>
                        <div class="span6 ">
                        </div>
                    </div>
                                    <!-- /row -->
                                    <div class="row-fluid">
                        <div class="span6 ">
                            <div class="control-group">
                              <label class="control-label"></label>
                                <div class="controls">
                                  <label class="radio">
                                    <div class="radio" id="divWeekPermssions"><span><input type="radio" name="Permission" value="2" style="opacity: 0;"></span></div>
                                          <%=Resources.Resource.byWeekPermssions %>
                                  </label>   
                               </div>
                           </div>
                        </div>
                        <div class="span6 ">

                        </div>
                    </div>
  
                                    <div class="row-fluid">
                                     <div>&nbsp;&nbsp;</div>
                                     <div>&nbsp;&nbsp;</div>
                                 </div> 

                               </div>
                              <div class="form-actions clearfix">
                                <span id="spnID" style="display: none;">0</span>
                                 <a href="javascript:;" class="btn button-previous" style="display: none;">
                                 <i class="m-icon-swapleft"></i> Back 
                                 </a>
                                 <a href="javascript:;" class="btn blue button-next" style="display: inline-block;">
                                 Continue <i class="m-icon-swapright m-icon-white"></i>
                                 </a>
                                 <a href="javascript:;" id="btnSave"  class="btn green button-submit" style="display: none;">
                                 <%=Resources.Resource.save %> <i class="m-icon-swapright m-icon-white"></i>
                                      
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
        
        <div id="divHiddenValues" runat="server" style="display: none">
            <span id="spnPerm">0</span>&nbsp;
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
    
   <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
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
        var tempEmp = false;
        var tempLeave = false;

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
            FormWizard.init();
            //TableManaged.init();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liGeneral").addClass("active");
            $("#liGeneral .arrow").addClass("open");
            $("#liGeneralPermissionType").addClass("active");
             


            if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

            $('input[type=radio][name=Permission]').change(function () {
                if (this.value == '1' || this.value == '2') {
                    $("#divPriority").css("display", "block");
                }
                else   {
                    $("#divPriority").css("display", "none");
                }
            });
            //$("#ckboxNationality").change(function () {
            //    if ($(this).is(":checked")) {
            //        $("#divNat").css("display", "block");
            //    }
            //    else {
            //        $("#divNat").css("display", "none");
            //    }
            //});
            // Declare a proxy to reference the hub. 
            var users = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            users.client.broadcastMessage = function (name, message) {
                if (name == "TAMSR2_Single_Permission") {
                    //ReloadGrid();
                }
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#btnBroadCast').click(function () {
                    // Call the Send method on the hub. 
                    users.server.send('TAMSR2_Single_Permission', '');
                    // Clear text box and reset focus for next comment. 
                });
            });

            LoadReasons();
            LoadWorkflow();
            LoadCountries();
            LoadOrganizations();


            $("#ddOrg").change(function () {
                LoadManager(); 
            });

            $("#ddMgr").change(function () {
                LoadEmployees(); 
            });
             


        });
         
        function CloseForm() {
            window.location = '<%= Page.ResolveClientUrl("~/Common/Permission-Types") %>';
        }
        
        function LoadCountries() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("~/RequestPages/CountryPage.aspx") %>',
               success: function (html) {
                   $("#ddNat").html(html);
                   $("#ddNat").trigger("liszt:updated");
                   
               },
               error: function (html) { 
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

        function LoadReasons() {
            var d = "key=getIdNameListString";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/ReasonPage.aspx") %>',
               success: function (html) {
                   $("#ddReason").html(html);
                   $("#ddReason").trigger("liszt:updated");
                   //$("#form_sample_1").unmask();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }


        ////----------------------------/////////


        function LoadManager() {
            $("#spnErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");
            var orgID = $("#ddOrg").val() + "";
            if (orgID == null || orgID == 'null')
                orgID = "";
            var d = "key=getMgrIdNameListString&orgID=" + orgID;
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeePage.aspx") %>',
                success: function (html) {

                    $("#ddMgr").html(html);
                    $("#ddMgr").trigger("liszt:updated");

                    var mgrID = $("#spnMgr").text() + "";

                    if (mgrID != undefined && mgrID != "") {
                        $("#ddMgr").val(mgrID);
                        $("#ddMgr").trigger("liszt:updated");
                    }

                },
                error: function (html) {
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    $("#spnErrorMsg").css("display", "block");
                }
            });
            }

            function LoadOrganizations() {



                var d = "key=getIdNameListString";
                $.ajax({
                    type: 'POST',
                    data: d,
                    url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
                        success: function (html) {
                            $("#ddOrg").html(html);
                            $("#ddOrg").trigger("liszt:updated");

                            var orgID = $('#spnOrg').text() + "";

                            if (orgID != undefined && orgID != "") {
                                $("#ddOrg").val(orgID);
                                $("#ddOrg").trigger("liszt:updated");
                            }
                            LoadGroups();
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

                     var ManagerId = $("#ddMgr").val();
                     if (ManagerId == 'Undefined' || ManagerId == 'undefined' || ManagerId == undefined || ManagerId == null || ManagerId == 'null')
                         ManagerId = '';

                     var orgID = $("#ddOrg").val() + "";
                     if (orgID == null || orgID == 'null')
                         orgID = "";

                     var d = "key=getIdNameListByOrgID&orgID=" + orgID + "&managerID=" + ManagerId;

                     $.ajax({
                         type: 'POST',
                         data: d,
                         url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
                    success: function (html) {
                        $("#ddEmp").html(html)
                        $("#ddEmp").trigger("liszt:updated");
                        var id = $("#spnPerm").html();

                        if (id != "" && id != "0") {
                            Edit(id);
                        }
                    },
                    error: function (html) {
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
                });
            }
        function LoadGroups() {
            $("#divErrorMsg").css("display", "none");
            $("#spnSuccessMsg").css("display", "none");

            var d = "key=getIdNameListString"; 
            $.ajax({
                type: 'POST',
                data: d,
                url: '<%= Page.ResolveClientUrl("../RequestPages/EmployeeGroupPage.aspx") %>',
                success: function (html) {
                  //  alert(html);
                   $("#ddGroup").html(html);
                   $("#ddGroup").trigger("liszt:updated");
                   LoadEmployees();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>"); 
                }
           });
        }

            ///

        function Edit(id) {
            //Edit code
            var v = "key=getByID&id=" + id;
            $("#btnAdd").click();
            $("#spnID").html(id);
            $("#spnGridMsg").html("&nbsp;");
            $.ajax({
                type: 'POST',
                data: v,
                url: '<%= Page.ResolveClientUrl("../RequestPages/PermissionTypePage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);


                       ///Tab 1
                       $("#spnID").val(j.ID);
                        
                       $('#ddReason option[value=' + j.ReasonID + ']').attr('selected', 'selected');
                       $("#ddReason").trigger("liszt:updated");

                       $("#txtCode").val(j.Code);
                       $("#txtDescriptionEn").val(j.DescriptionEn);
                       $("#txtDescriptionAr").val(j.DescriptionAr);
                       $("#txtCommentsEn").val(j.CommentsEn);
                       $("#txtCommentsAr").val(j.CommentsAr);


                       //TAB 2

                       
                       $('#ddWorkflow option[value=' + j.WorkflowId + ']').attr('selected', 'selected');
                       $("#ddWorkflow").trigger("liszt:updated");

                       $('#ddOrg option[value=' + j.OrganizationId + ']').attr('selected', 'selected');
                       $("#ddOrg").trigger("liszt:updated");

                       $('#ddGroup option[value=' + j.GroupId + ']').attr('selected', 'selected');
                       $("#ddGroup").trigger("liszt:updated");

                       $('#ddEmp option[value=' + j.EmployeeId + ']').attr('selected', 'selected');
                       $("#ddEmp").trigger("liszt:updated");

                       $('#ddSex option[value=' + j.GenderId + ']').attr('selected', 'selected');
                       $("#ddSex").trigger("liszt:updated");

                       $('#ddNat option[value=' + j.NationalityID + ']').attr('selected', 'selected');
                       $("#ddNat").trigger("liszt:updated");


                       $("#txtFromDate").val(j.ValidFrom);
                       $("#txtToDate").val(j.ValidTo);


                       //TAB 3

                       $("#txtMaxMinutesPerDay").val(j.MaxMinutesPerDay);
                       $("#txtMaxPermPerDay").val(j.MaxPermissionsPerDay);

                       $("#txtMaxMinutesPerMonth").val(j.MaxMinutesMinutesPerMonth);
                       $("#txtMaxPermPerMonth").val(j.MaxPermissionsPerMonth);

                       $("#txtMaxPermissions").val(j.MaxPermissions);
                       $("#txtMaxMinutes").val(j.MaxMinutes);

                       $("#txtMinDurationPerPermission").val(j.MinPermissionTime);
                       $("#txtMaxDurationPerPermission").val(j.MaxPermissionTime);

                       
                       //TAB 4

                       
                       if (j.GroupApplyFlag + "" == "1") {
                           $("#chkboxGroupApply").attr("checked", "checked");
                           $("#uniform-chkboxGroupApply span").addClass("checked");
                       }
                       if (j.OfficialFlag + "" == "Y" || j.OfficialFlag + "" == "y") {
                           $("#chkboxOfficial").attr("checked", "checked");
                           $("#uniform-chkboxOfficial span").addClass("checked");
                       }
                       if (j.HrOnlyFlag + "" == "1") {
                           $("#chkboxHRonly").attr("checked", "checked");
                           $("#uniform-chkboxHRonly span").addClass("checked");
                       }
                       if (j.AllowAttachment + "" == "1") {
                           $("#chkboxAllowAttachement").attr("checked", "checked");
                           $("#uniform-chkboxAllowAttachement span").addClass("checked");
                       } 
                       if (j.CommentsRequired + "" == "1") {
                           $("#chkboxRequiredComments").attr("checked", "checked");
                           $("#uniform-chkboxRequiredComments span").addClass("checked");
                       }
                       else {
                           $("#uniform-chkboxRequiredComments span").removeClass("checked")
                       }

                       if (j.ApplyRamadanRestriction + "" == "1") {
                           $("#ckhboxApplyRamadanRestriction").attr("checked", "checked");
                           $("#uniform-ckhboxApplyRamadanRestriction span").addClass("checked");
                       }

                       if (j.MedicalPassAttachment + "" == "1") {
                           $("#chkboxMedicalPassAttachment").attr("checked", "checked");
                           $("#uniform-chkboxMedicalPassAttachment span").addClass("checked");
                       }
                       
                       
                       $('#ddPriority option[value=' + j.PriorityID + ']').attr('selected', 'selected');
                       $("#ddPriority").trigger("liszt:updated");



                       if (j.PermissionTypeID == "0") {
                           $("#divTimePermissions span").addClass('checked');
                           $("#divHoursPermissions span").removeClass('checked');
                           $("#divWeekPermssions span").removeClass('checked');
                           $("#divPriority").css("display", "none");
                       }
                       else if(j.PermissionTypeID == "1")
                       { 
                           $("#divHoursPermissions span").addClass('checked');
                           $("#divTimePermissions span").removeClass('checked');
                           $("#divWeekPermssions span").removeClass('checked');
                           $("#divPriority").css("display", "block");
                       }
                       else if(j.PermissionTypeID == "2")
                       {
                           $("#divWeekPermssions span").addClass('checked'); 
                           $("#divTimePermissions span").removeClass('checked');
                           $("#divHoursPermissions span").removeClass('checked');
                           $("#divPriority").css("display", "block");
                       }
                       else {
                           $("#divTimePermissions span").addClass('checked');
                           $("#divHoursPermissions span").removeClass('checked');
                           $("#divWeekPermssions span").removeClass('checked');
                           $("#divPriority").css("display", "none");
                       }
                   }
               },
               error: function (html) {

               }
           });
       }

       function Save() {
           
           if ($('#form_sample_1').validate().form() == false) {

               $("#spnErrorMsg").css("display", "block");
               return false;
           }

           var id = $("#spnID").html();
           var descriptionEn = $("#txtDescriptionEn").val();
           var descriptionAr = $("#txtDescriptionAr").val();
           var commentsEn = $("#txtCommentsEn").val();
           var commentsAr = $("#txtCommentsAr").val();

           var code = $("#txtCode").val();
           var reasonID = $("#ddReason").val();
           var groupApply = $("#chkboxGroupApply").is(":checked");
           var official = $("#chkboxOfficial").is(":checked");
           var hrOnly = $("#chkboxHRonly").is(":checked");
           var allowAttachment = $("#chkboxAllowAttachement").is(":checked");
           var CommentsRequired = $("#chkboxRequiredComments").is(":checked");
           var ApplyRamadanRestriction = $("#ckhboxApplyRamadanRestriction").is(":checked");
           var MedicalPassAttachment = $("#chkboxMedicalPassAttachment").is(":checked");
           var NationalityID = $("#ddNat").val();
           var PriorityID = $("#ddPriority").val();

           var maxPermissionsPerDay = $("#txtMaxPermPerDay").val();
           var maxMinutesPerDay = $("#txtMaxMinutesPerDay").val();

           var maxPermissionsPerMonth = $("#txtMaxPermPerMonth").val();
           var maxMinutesPerMonth = $("#txtMaxMinutesPerMonth").val();

           var MinPermissionTime = $("#txtMinDurationPerPermission").val();
           var MaxPermissionTime = $("#txtMaxDurationPerPermission").val();

           var PermissionTypeID = $('input[type=radio][name=Permission]:checked').val();

           var fromDate = "";
           var toDate = "";

           var str1 = $('#txtFromDate').val();
           var str2 = $('#txtToDate').val();

           if (str1 != '' || str2 != '') {
               if (str1.indexOf('-') > 0) {
                   fromDate = str1.substring(6, 10) + "-" + str1.substring(3, 5) + "-" + str1.substring(0, 2);
               }
               else {
                   fromDate = str1.substring(4, 8) + "-" + str1.substring(2, 4) + "-" + str1.substring(0, 2);
               }
               if (str2.indexOf('-') > 0) {
                   toDate = str2.substring(6, 10) + "-" + str2.substring(3, 5) + "-" + str2.substring(0, 2);
               }
               else {
                   toDate = str2.substring(4, 8) + "-" + str2.substring(2, 4) + "-" + str2.substring(0, 2);
               }
           }
           else {
               fromDate = null;
               toDate = null;
           }

           var org = $("#ddOrg").val();
           var group = $("#ddGroup").val();
           var emp = $("#ddEmp").val();
           var workflow = $("#ddWorkflow").val();
           var sex = $("#ddSex").val();

           if (group == 'Undefined' || group == 'undefined' || group == undefined || group == null || group == 'null')
               group = '';

           if (org == null || org == 'null')
               org = "";

           if (emp == null || emp == 'null')
               emp = "";


           if (sex == null || sex == 'null')
               sex = "";



           var v = "key=save" + "&id=" + id + "&code=" + code + "&reasonID=" + reasonID;
           v += "&descriptionEn=" + descriptionEn + "&descriptionAr=" + descriptionAr + "&commentsEn=" + commentsEn + "&commentsAr=" + commentsAr + "&groupApply=" + groupApply;
           v += "&official=" + official +"&hrOnly=" + hrOnly + "&allowAttachment=" + allowAttachment + "&CommentsRequired=" + CommentsRequired;
           v += "&NationalityID=" + NationalityID + "&PriorityID=" + PriorityID + "&PermissionTypeID=" + PermissionTypeID;
           v += "&ApplyRamadanRestriction=" + ApplyRamadanRestriction;
           v += "&maxPermissionsPerDay=" + maxPermissionsPerDay + "&maxMinutesPerDay=" + maxMinutesPerDay;
           v += "&maxPermissionsPerMonth=" + maxPermissionsPerMonth + "&maxMinutesPerMonth=" + maxMinutesPerMonth;
           v += "&MinPermissionTime=" + MinPermissionTime + "&MaxPermissionTime=" + MaxPermissionTime;
           v += "&OrgId=" + org + "&GroupId=" + group + "&EmpId=" + emp + "&FromDate=" + fromDate + "&ToDate=" + toDate
           v += "&WorkflowId=" + workflow + "&Sex=" + sex + "&MedicalPassAttachment=" + MedicalPassAttachment;
           
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/PermissionTypePage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                       $("#spnErrorMsg").css("display", "block");
                   }
                   else if (html == '0') {
                       //exists
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                       $("#spnErrorMsg").css("display", "block");
                   }
                   else {
                       //success
                       $("#divSuccessMsg").css("display", "block");
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                       $("#spnSuccessMsg").css("display", "block");
                       $('#btnBroadCast').click();
                       Clear();
                       window.location.href = '<%= Page.ResolveClientUrl("../Common/Permission-Types") %>';
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("Error! " + html);
               }

           });

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
            $("#txtMaxPermissions").val("");
            $("#txtMaxMinutes").val("");
            $("#txtCode").val("");

            $("#chkboxOfficial").removeAttr("checked");
            $("#uniform-chkboxOfficial span").removeClass("checked");

            $("#chkboxGroupApply").removeAttr("checked");
            $("#uniform-chkboxGroupApply span").removeClass("checked");

            $("#chkboxHRonly").removeAttr("checked");
            $("#uniform-chkboxHRonly span").removeClass("checked");

            $("#chkboxAllowAttachement").removeAttr("checked");
            $("#uniform-chkboxAllowAttachement span").removeClass("checked");

            $("#chkboxRequiredComments").removeAttr("checked");
            $("#uniform-chkboxRequiredComments span").removeClass("checked");


            $("#ckhboxApplyRamadanRestriction").removeAttr("checked");
            $("#uniform-ckhboxApplyRamadanRestriction span").removeClass("checked");

            
            $('#ddReason option[value=""]').attr('selected', 'selected');
            $("#ddReason").trigger("liszt:updated");

            $('#ddNat option[value=""]').attr('selected', 'selected');
            $("#ddNat").trigger("liszt:updated");

            $('#ddPriority option[value=""]').attr('selected', 'selected');
            $("#ddPriority").trigger("liszt:updated");

        }

        var FormComponents = function () {

            var handlejQueryUIDatePickers = function () {
                $(".ui-date-picker").datepicker();
            }

            var handleDateTimePickers = function () {

                if (jQuery().datepicker) {
                    $('.date-picker').datepicker({ format: 'dd-mm-yyyy' });
                }
                // $(".date-picker").val('<%= DateTime.UtcNow.AddHours(4).ToString("dd-MM-yyyy") %>');

               if (jQuery().timepicker) {
                   $('.timepicker-default').timepicker();
                   $('.timepicker-24').timepicker({
                       minuteStep: 1,
                       showSeconds: true,
                       showMeridian: false
                   });
               }
                  
           }

     var handleInputMasks = function () {
         $.extend($.inputmask.defaults, {
             'autounmask': true
         });

         $("#txtFromDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
         $("#txtToDate").inputmask("d-m-y", { autoUnmask: true });  //direct mask        
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
                errorElement: 'div', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    reason: {
                        required: true
                    },
                    code: {
                        required: true
                    },
                    nameEn: {
                        required: true
                    },
                    nameAr: {
                        required: true
                    },
                    Workflow: {
                        required: true
                    },
                    maxMinutesPerDay: {
                        required: true
                    },
                    maxPermPerDay: {
                        required: true
                    },
                    maxMinutesPerMonth: {
                        required: true
                    },
                    maxPermPerMonth: {
                        required: true
                    },
                    minDurationPerPermission: {
                        required: true
                    },
                    maxDurationPerPermission: {
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    reason: {
                      //  required: "<%=Resources.Resource.lblRequired %>"
                    },
                    code: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    nameEn: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    nameAr: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    Workflow: {
                        
                    },
                    maxMinutesPerDay: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    maxPermPerDay: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    maxMinutesPerMonth: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    maxPermPerMonth: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    minDurationPerPermission: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    maxDurationPerPermission: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    } 
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.attr("name") == "Workflow" || element.attr("name") == "reason") { // for uniform checkboxes, insert the after the given container
                        error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavoir
                    }
                    //error.insertAfter(element);
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


        FormWizard = function () {


            return {
                //main function to initiate the module
                init: function () {
                    if (!jQuery().bootstrapWizard) {
                        return;
                    }

                    // default form wizard
                    $('#form_wizard_1').bootstrapWizard({
                        'nextSelector': '.button-next',
                        'previousSelector': '.button-previous',
                        onTabClick: function (tab, navigation, index) {
                            alert('on tab click disabled');
                            return false;
                        },
                        onNext: function (tab, navigation, index) {
                            var total = navigation.find('li').length;
                            var current = index + 1;
                            // set wizard title
                            $('.step-title', $('#form_wizard_1')).text('Step ' + (index + 1) + ' of ' + total);
                            // set done steps
                            jQuery('li', $('#form_wizard_1')).removeClass("done");
                            var li_list = navigation.find('li');
                            for (var i = 0; i < index; i++) {
                                jQuery(li_list[i]).addClass("done");
                            }

                            if (current == 1) {
                                $('#form_wizard_1').find('.button-previous').hide();
                            } 
                            else {
                                $('#form_wizard_1').find('.button-previous').show();
                            }

                            if (current >= total) {
                                $('#form_wizard_1').find('.button-next').hide();
                                $('#form_wizard_1').find('.button-submit').show();
                            } else {
                                $('#form_wizard_1').find('.button-next').show();
                                $('#form_wizard_1').find('.button-submit').hide();
                            }
                            App.scrollTo($('.page-title'));
                        },
                        onPrevious: function (tab, navigation, index) {
                            var total = navigation.find('li').length;
                            var current = index + 1;
                            // set wizard title
                            $('.step-title', $('#form_wizard_1')).text('Step ' + (index + 1) + ' of ' + total);
                            // set done steps
                            jQuery('li', $('#form_wizard_1')).removeClass("done");
                            var li_list = navigation.find('li');
                            for (var i = 0; i < index; i++) {
                                jQuery(li_list[i]).addClass("done");
                            }

                            if (current == 1) {
                                $('#form_wizard_1').find('.button-previous').hide();
                            } else {
                                $('#form_wizard_1').find('.button-previous').show();
                            }

                            if (current >= total) {
                                $('#form_wizard_1').find('.button-next').hide();
                                $('#form_wizard_1').find('.button-submit').show();
                            } else {
                                $('#form_wizard_1').find('.button-next').show();
                                $('#form_wizard_1').find('.button-submit').hide();
                            }

                            App.scrollTo($('.page-title'));
                        },
                        onTabShow: function (tab, navigation, index) {
                            var total = navigation.find('li').length;
                            var current = index + 1;
                            var $percent = (current / total) * 100;
                            $('#form_wizard_1').find('.bar').css({
                                width: $percent + '%'
                            });
                        }
                    });

                    $('#form_wizard_1').find('.button-previous').hide();
                    $('#form_wizard_1 .button-submit').click(function () { 
                        Save();
                    }).hide();
                }

            };

        }();
    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>

