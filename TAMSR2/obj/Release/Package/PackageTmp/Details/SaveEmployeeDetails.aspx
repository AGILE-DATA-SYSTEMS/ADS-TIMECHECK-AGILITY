<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaveEmployeeDetails.aspx.cs" Inherits="TAMSR2.Details.SaveEmployeeDetails" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.employeeDetails %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>plugins/bootstrap-fileupload/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/compiled/timepicker.css" />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-colorpicker/css/colorpicker.css" />
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
									<%=Resources.Resource.employeeDetails %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a> 
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href='<%= Page.ResolveClientUrl("~/Emp/Employees") %>'><%=Resources.Resource.employee %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href='#' ><%=Resources.Resource.employeeDetails %></a></li>					
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12">
                  
                   
                                   <div id="divErrorMsg" class="alert alert-error hide">
                                      <button class="close" data-dismiss="alert"></button>
                                      <span id="spnErrorMsg"> <%=Resources.Resource.formErrors %></span> 
                                   </div>
                                   <div id="divSuccessMsg" class="alert alert-success hide">
                                      <button class="close" data-dismiss="alert"></button>
                                      <span id="spnSuccessMsg"><%=Resources.Resource.formErrorsRemoved %></span> 
                                   </div>
                   <div style="clear: both; margin-bottom: 10px;">
                       &nbsp;
                   </div>

                  <!-- BEGIN SAMPLE FORM PORTLET-->   
                  <div class="portlet box blue tabbable">
                     <div class="portlet-title">
                        <div class="caption">
                           <i class="icon-reorder"></i>
                           <span class="hidden-480"><%=Resources.Resource.employeeDetails %></span>
                        </div>
                     </div>
                     <div class="portlet-body form">

                        <div class="tabbable portlet-tabs">
                           <ul class="nav nav-tabs">
                              <li id="flags" onclick="return Next(2);"><a href="#portlet_tab4"  data-toggle="tab"> <%=Resources.Resource.flags %></a></li>
                              <li id="business" onclick="return Next(1);"><a href="#portlet_tab3"  data-toggle="tab"> <%=Resources.Resource.business %></a></li>
                              <li id="empPicture" onclick="return Next(0);"><a href="#portlet_tab2"  data-toggle="tab"> <%=Resources.Resource.profilePicture %></a></li>
                              <li class="active" id="pesonal" onclick="return Next(3);"><a href="#portlet_tab1"  data-toggle="tab"> <%=Resources.Resource.personal %></a></li>
                           </ul>
                           <div class="tab-content">
                              <div class="tab-pane active" id="portlet_tab1">
                                <!-- BEGIN FORM-->
                                <form action="#" id="form_sample_1" class="form-horizontal">

                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.organization %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddOrg" style="width: 220px;" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.organization %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.code %> <span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="text" id="txtCode" name="code" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.cardNo %> <span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="text" id="txtCardNo" name="cardNo" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.pin %> </label>
                                                <div class="controls">
                                                    <input type="text" id="txtPIN" name="pin" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.username %> <span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="text" id="txtUsername" name="username" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.password %> <span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="password" id="txtPassword" name="password" value="12345" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid" style="display:none;">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.salutationEn %></label>
                                                <div class="controls">
                                                    <input type="text" id="txtSalutationEn" name="salutationEn" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.salutationAr %></label>
                                                <div class="controls">
                                                    <input type="text" id="txtSalutationAr" name="salutationAr" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.nameEn %> <span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="text" id="txtNameEn" name="nameEn" data-required="1" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.nameAr %> <span class="required">*</span></label>
                                                <div class="controls">
                                                    <input type="text" id="txtNameAr" name="nameAr" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.mobile %> </label>
                                                <div class="controls">
                                                    <input type="text" id="txtMobile" name="pin" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.sex %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddSex" style="width: 220px;" name="sex" class="span6 chosen" data-with-diselect="1" name="org" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.sex %>" tabindex="1">
                                                        <option value="0"><%=Resources.Resource.male %> </option>
                                                        <option value="1"><%=Resources.Resource.female %> </option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.email %> </label>
                                                <div class="controls">
                                                    <input type="text" id="txtEmail" name="email" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.joinDate %> </label>
                                                <div class="controls">
                                                    <input id="txtJoinDate" name="joindate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.remarks %> </label>
                                                <div class="controls">
                                                    <input type="text" id="txtRemarks" name="remarks" style="width: 220px !important;" class="span6 m-wrap" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.inactiveDate %> </label>
                                                <div class="controls">
                                                    <input id="txtInactiveDate" name="inactivedate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                      <div class="row-fluid">
                                        
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.SystemActivationDate %> </label>
                                                <div class="controls">
                                                    <input id="txtSystemActiveDate" name="txtSystemActiveDate" class="m-wrap m-ctrl-medium date-picker" size="16" type="text" value="" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <!-- END FORM-->
                              </div>
                              <div class="tab-pane " id="portlet_tab2">
                                <form action="#" id="form1" class="form-horizontal"> 
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.profilePicture %></label>
                                                <div class="controls">
                                                    <input type="file" name="file_upload" id="fileToUpload" class="default" />
                                                </div>
                                                <div class="controls">
                                                    <div data-provides="fileupload" class="fileupload fileupload-new">
                                                        <input type="hidden">
                                                        <div style="width: 150px; height: 150px;" class="fileupload-new thumbnail">
                                                            <img alt="" src="<%= path %>Handlers/EmployeeProfileImage.ashx?id=<%= empID %>" style="width: 150px; height: 150px;" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div style="margin-top: 60px !important;">
                                    &nbsp;
                                </div>
                             </div>
                              <div class="tab-pane " id="portlet_tab3">
                                <form action="#" id="form2" class="form-horizontal">                                    
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxMgr" type="checkbox" name="managerFlag" />
                                                    <%=Resources.Resource.managerFlag %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.manager %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddMgr" style="width: 220px;" name="mngr" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.manager %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.employeeType %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddEmpType" style="width: 220px;" name="emptype" class="span6 chosen" data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.employeeType %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.grade %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddGrade" style="width: 220px;" name="grade" class="span6 chosen" data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.grade %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.designation %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddDesig" style="width: 220px;" name="desig" class="span6 chosen" data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.designation %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.scheduleType %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddSch" style="width: 220px;" name="sch" class="span6 chosen" data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.schedule %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.region %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddRegion" style="width: 220px;" name="regn" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.region %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.nationality %> <span class="required">*</span></label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddCountry" style="width: 220px;" name="country" class="span6 chosen" data-with-diselect="1"  data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.nationality %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label"><%=Resources.Resource.building %> </label>
                                                <div class="controls chzn-controls">
                                                    <select id="ddBuildginListId" style="width: 220px;" name="ddBuildginList" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.building %>" tabindex="1">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </form>
                                <div style="margin-top: 100px !important;">
                                    &nbsp;
                                </div>
                              </div>
                              <div class="tab-pane " id="portlet_tab4">
                                <form action="#" id="form3" class="form-horizontal">
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxActive1" type="checkbox" name="active" />
                                                    <%=Resources.Resource.active %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxLocal" type="checkbox" name="local" />
                                                    <%=Resources.Resource.local %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxPunch" type="checkbox" name="punch" />
                                                    <%=Resources.Resource.punch %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxShift" type="checkbox" name="shift" />
                                                    <%=Resources.Resource.shift %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxOvertime" type="checkbox" name="overtime" />
                                                    <%=Resources.Resource.overtime %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxOnReport" type="checkbox" name="onreport" />
                                                    <%=Resources.Resource.onReport %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxInPayroll" type="checkbox" name="inpayrol" />
                                                    <%=Resources.Resource.inpayroll %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxshareRoster" type="checkbox" name="shareRoster" />
                                                    <%=Resources.Resource.shareRoster %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxNotifyFalg" type="checkbox" name="notifyFlag" />
                                                    <%=Resources.Resource.emailNotification %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxIncludeNotifications" type="checkbox" name="includeNotifications" />
                                                    <%=Resources.Resource.includeInEmailNotification %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxOpenShift" type="checkbox" name="openShift" />
                                                    <%=Resources.Resource.openShift %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxWebPunch" type="checkbox" name="webpunch" />
                                                    <%=Resources.Resource.webPunch %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="row-fluid">
                                        <div class="span6 ">
                                            <div class="control-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="controls">
                                                    <input id="chkboxMonthlyMissedHours" type="checkbox" name="monthlyMissedHours" />
                                                    <%=Resources.Resource.calculateMonthMissedHours %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                 </form>
                                <div style="margin-top: 70px !important;">
                                    &nbsp;
                                </div>
                              </div>
                               <div class="form-actions" style="margin-top: 65px !important;">
                                   <span id="spnID" style="display: none;">0</span>
                                   <button id="btnBroadCast" type="button" style="display: none;" class="btn purple">broadcast</button>
                                   <span id="spnSaveButton" runat="server">
                                       <button id="btnNext" type="button" onclick="Next(-1)" class="btn purple" ><%=Resources.Resource.next %></button>
                                       <button id="btnSave" type="button" onclick="return Save()" class="btn purple"><%=Resources.Resource.save %></button>
                                   </span>
                                   <button type="button" onclick="CloseForm()" class="btn"><%=Resources.Resource.cancel %></button>
                                   <button type="reset" id="btnCloseForm" style="display: none;" data-dismiss="modal" class="btn"><%=Resources.Resource.close %></button>
                               </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- END SAMPLE FORM PORTLET-->
               </div>
            </div>
            <!-- END PAGE CONTENT-->

        <div id="divHiddenValues" runat="server" style="display: none">
            <span id="spnEmp">0</span>&nbsp;
        </div>
        <button id='btnProfileImage' style="display: none;" onclick='return ajaxFileUpload()' class="submit">Save</button>

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
   <script src="<%= path %>assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script> 
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
   
   <script type="text/javascript" src="<%= path %>Assets/<%= languageStr %>/plugins/bootstrap-fileupload/bootstrap-fileupload.js"></script>
    
   <script type="text/javascript" src="<%= path %>Assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>




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
   <script src="<%= path %>Scripts/ajaxfileupload.js"></script>    
   <!-- START OF PAGE LEVEL SCRIPT-->

   <script type="text/javascript">
       var tempOrg = false;
       var tempLoc = false;
       var tempLoadCount = 0;

       $(document).ready(function () {
           //alert(typeof String.prototype.trim);
           if (typeof String.prototype.trim != 'function') {
               String.prototype.trim = function () {
                   return this.replace(/^\s+|\s+$/g, '');
               }
           }
       });

       $(document).ready(function () {
           $('#btnSave').hide();
           App.init(); // initlayout and core plugins
           FormValidation.init();
           FormComponents.init();
           LoadBuildings(); 
           //TableManaged.init();
         //  $("#btnSave").hide();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liEmp").addClass("active");
           $("#liEmp .arrow").addClass("open");
           $("#liEmpEmployee").addClass("active");

           if ("<%= enableForm %>" == "false" && "<%= addRecord %>" == "false") {
               $("#form_sample_1 input").attr("disabled", "disabled");
               $("#form1 input").attr("disabled", "disabled");
               $("#form2 input").attr("disabled", "disabled");
           }
            
           tempLoadCount = 0;

           LoadOrganizations();

           $("#fileToUpload").val("");


       });

       //START - User confirmation before leaving page
       window.onbeforeunload = Unload_Call;
       function Unload_Call() {
           var Message = "Are you sure to leave this page?";
           if ($("#txtCode").val() != "" || $("#txtUsername").val() != "" || $("#txtNameEn").val() != "" || $("#txtNameAr").val() != "")
               return Message;

       }
       //END - User confirmation before leaving page

              
       var counter = 0;
       function Next(tempCounter) {
           //empPicture
           if (tempCounter != -1)
               counter = tempCounter;
           if (counter == 0) {
               if ($('#form_sample_1').validate().form() == false) {
                   return false;
               }
               else {
                   counter =  1;
                   $('#portlet_tab1').removeClass("active");
                   $('#portlet_tab3').removeClass("active");
                   $('#portlet_tab4').removeClass("active");
                   $('#pesonal').removeAttr("class");
                   $('#business').removeAttr("class");
                   $('#flags').removeAttr("class");
                   $('#empPicture').addClass("active");
                   $('#portlet_tab2').addClass("active");
                   $('#btnSave').hide();
                   $('#btnNext').show();
                   return true;
               }
           }
           else if (counter == 1) {

               if ($('#form_sample_1').validate().form() == false) {
                   return false;
               }
               else {
                   counter = 2;
                   $('#portlet_tab1').removeClass("active");
                   $('#portlet_tab2').removeClass("active");
                   $('#portlet_tab4').removeClass("active");
                   $('#empPicture').removeAttr("class");
                   $('#pesonal').removeAttr("class");
                   $('#flags').removeAttr("class");
                   $('#business').addClass("active");
                   $('#portlet_tab3').addClass("active");
                   $('#btnSave').hide();
                   $('#btnNext').show();
                   return true;
               }
           }
           else if (counter == 2) {
               if ($('#form2').validate().form() == false) {
                   return false;
               }
               else {
                   counter = 3;
                   $('#portlet_tab1').removeClass("active");
                   $('#portlet_tab2').removeClass("active");
                   $('#portlet_tab3').removeClass("active");
                   $('#portlet_tab4').addClass('active');
                   $('#business').removeAttr("class");
                   $('#empPicture').removeAttr("class");
                   $('#pesonal').removeAttr("class");
                   $('#flags').addClass("active");
                   $('#btnSave').show();
                   $('#btnNext').hide();
                   return true;
               }
           }
           else if (counter == 3) {
               if ($('#form2').validate().form() == false) {
                   return false;
               }
               else {
                   counter = 0;
                   $('#portlet_tab2').removeClass("active");
                   $('#portlet_tab3').removeClass("active");
                   $('#portlet_tab4').removeClass("active");
                   $('#portlet_tab1').addClass('active');
                   $('#business').removeAttr("class");
                   $('#empPicture').removeAttr("class");
                   $('#flags').removeAttr("class");
                   $('#personal').addClass("active");
                   $('#btnSave').hide();
                   $('#btnNext').show();
                   return true;
               }
           }

       }

    // Load Buildings list for dropdown

       function LoadBuildings() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/BuildingsPage.aspx") %>',
                success: function (html) {
                    $("#ddBuildginListId").html(html);
                    $("#ddBuildginListId").trigger("liszt:updated");

                    //tempLoadCount++;
                    //var temp = $('#ddZonesList').text();
                    //if (temp != "" && tempLoadCount == 8) {
                    //    Clear();
                    //    //Edit(temp);
                    //}
                },
                error: function (html) {
                    $("#divErrorMsg").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    //$("#form_sample_1").unmask();
                }
            });
       }

       function LoadOrganizations() {

           LoadEmployeeTypes();
           $("#ddOrg").html("<%= orgList %>");
           $("#ddOrg").trigger("liszt:updated");
           tempLoadCount++;
           var temp = $('#spnEmp').text();
           if (temp != "" && tempLoadCount == 8) {
               Clear();
               Edit(temp);
           }
           return;
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   LoadEmployeeTypes();
                   $("#ddOrg").html(html);
                   $("#ddOrg").trigger("liszt:updated");

                   tempLoadCount++;
                   var temp = $('#spnEmp').text();
                   if (temp != "" && tempLoadCount == 8) {
                       Clear();
                       Edit(temp);
                   }
               },
               error: function (html) {
                   LoadEmployeeTypes();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadEmployeeTypes() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeeTypePage.aspx") %>',
               success: function (html) {
                   LoadManagerList();
                   $("#ddEmpType").html(html);
                   $("#ddEmpType").trigger("liszt:updated");

                   tempLoadCount++;
                   var temp = $('#spnEmp').text();
                   if (temp != "" && tempLoadCount == 8) {
                       Clear();
                       Edit(temp);
                   }
               },
               error: function (html) {
                   LoadManagerList();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadManagerList() {
           LoadCountries();
           $("#ddMgr").html("<%= empList %>");
           $("#ddMgr").trigger("liszt:updated");

           tempLoadCount++;
           var temp = $('#spnEmp').text();
           if (temp != "" && tempLoadCount == 8) {
               Clear();
               Edit(temp);
           }
           return;
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   LoadCountries();
                   $("#ddMgr").html(html);
                   $("#ddMgr").trigger("liszt:updated");

                   tempLoadCount++;
                   var temp = $('#spnEmp').text();
                   if (temp != "" && tempLoadCount == 8) {
                       Clear();
                       Edit(temp);
                   }
               },
               error: function (html) {
                   LoadCountries();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadCountries() {
           LoadGrades();
           $("#ddCountry").html("<%= countryList %>");
           $("#ddCountry").trigger("liszt:updated");

           tempLoadCount++;
           var temp = $('#spnEmp').text();
           if (temp != "" && tempLoadCount == 8) {
               Clear();
               Edit(temp);
           }
           return;

           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/CountryPage.aspx") %>',
               success: function (html) {
                   LoadGrades();
                   $("#ddCountry").html(html);
                   $("#ddCountry").trigger("liszt:updated");

                   tempLoadCount++;
                   var temp = $('#spnEmp').text();
                   if (temp != "" && tempLoadCount == 8) {
                       Clear();
                       Edit(temp);
                   }
               },
               error: function (html) {
                   LoadGrades();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadGrades() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/GradePage.aspx") %>',
               success: function (html) {
                   LoadDesignations();
                   $("#ddGrade").html(html);
                   $("#ddGrade").trigger("liszt:updated");

                   tempLoadCount++;
                   var temp = $('#spnEmp').text();
                   if (temp != "" && tempLoadCount == 8) {
                       Clear();
                       Edit(temp);
                   }
               },
               error: function (html) {
                   LoadDesignations();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadDesignations() {
           LoadSchedules();
           $("#ddDesig").html("<%= designationList %>");
           $("#ddDesig").trigger("liszt:updated");
           tempLoadCount++;
           var temp = $('#spnEmp').text();
           if (temp != "" && tempLoadCount == 8) {
               Clear();
               Edit(temp);
           }
           return;
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/DesignationPage.aspx") %>',
               success: function (html) {
                   LoadSchedules();
                   $("#ddDesig").html(html);
                   $("#ddDesig").trigger("liszt:updated");

                   tempLoadCount++;
                   var temp = $('#spnEmp').text();
                   if (temp != "" && tempLoadCount == 8) {
                       Clear();
                       Edit(temp);
                   }
               },
               error: function (html) {
                   LoadSchedules();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }
       
       function LoadSchedules() {
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/ScheduleTypePage.aspx") %>',
               success: function (html) {
                   LoadRegions();
                   $("#ddSch").html(html);
                   $("#ddSch").trigger("liszt:updated");

                   tempLoadCount++;
                   var temp = $('#spnEmp').text();
                   if (temp != "" && tempLoadCount == 8) {
                       Clear();
                       Edit(temp);
                   }
               },
               error: function (html) {
                   LoadRegions();
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

       function LoadRegions() {
           $("#ddRegion").html("<%= regionList %>");
           $("#ddRegion").trigger("liszt:updated");

           tempLoadCount++;
           var temp = $('#spnEmp').text();
           if (temp != "" && tempLoadCount == 8) {
               Clear();
               Edit(temp);
           }
           return;
           var d = "key=getIdNameListString";
           //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/RegionPage.aspx") %>',
               success: function (html) {
                   $("#ddRegion").html(html);
                   $("#ddRegion").trigger("liszt:updated");

                   tempLoadCount++;
                   var temp = $('#spnEmp').text();
                   if (temp != "" && tempLoadCount == 8) {
                       Clear();
                       Edit(temp);
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }

       function Clear() {

           $("#fileToUpload").val("");

           $('#form_sample_1')
               .closest('.control-group').removeClass('error'); // set error class to the control group
           $(':input', '#form_sample_1')
            .not(':button, :submit, :reset, :hidden')
            .val('')
            .removeAttr('checked')
            .removeAttr('selected');

           //$("#spnGridMsg").html("&nbsp;");
           $("#spnID").html("0");
           $("#txtCode").val("");
           $("#txtUsername").val("");
           $("#txtPassword").val("");
           $("#txtSalutationEn").val("");
           $("#txtSalutationAr").val("");
           $("#txtNameEn").val("");
           $("#txtNameAr").val("");
           $("#txtCardNo").val("");
           $("#txtPIN").val("");
           $("#txtEmail").val("");
           $("#txtRemarks").val("");

           //$('#ddSex option[value="0"]').attr('selected', 'selected');
           //$("#ddSex").trigger("liszt:updated");
           //$('#ddOrg option[value=""]').attr('selected', 'selected');
           //$("#ddOrg").trigger("liszt:updated");
           //$('#ddEmpType option[value=""]').attr('selected', 'selected');
           //$("#ddEmpType").trigger("liszt:updated");
           //$('#ddMgr option[value=""]').attr('selected', 'selected');
           //$("#ddMgr").trigger("liszt:updated");
           //$('#ddCountry option[value=""]').attr('selected', 'selected');
           //$("#ddCountry").trigger("liszt:updated");
           //$('#ddGrade option[value=""]').attr('selected', 'selected');
           //$("#ddGrade").trigger("liszt:updated");
           //$('#ddDesig option[value=""]').attr('selected', 'selected');
           //$("#ddDesig").trigger("liszt:updated");
           //$('#ddSch option[value=""]').attr('selected', 'selected');
           //$("#ddSch").trigger("liszt:updated");
           //$('#ddRegion option[value=""]').attr('selected', 'selected');
           //$("#ddRegion").trigger("liszt:updated");

           $("#chkboxMgr").removeAttr("checked");
           $("#uniform-chkboxMgr span").removeClass("checked");
           $("#chkboxActive").removeAttr("checked");
           $("#uniform-chkboxActive span").removeClass("checked");
           $("#chkboxLocal").removeAttr("checked");
           $("#uniform-chkboxLocal span").removeClass("checked");
           $("#chkboxShift").removeAttr("checked");
           $("#uniform-chkboxShift span").removeClass("checked");
           $("#chkboxOpenShift").removeAttr("checked");
           $("#uniform-chkboxOpenShift span").removeClass("checked");
           $("#chkboxOvertime").removeAttr("checked");
           $("#uniform-chkboxOvertime span").removeClass("checked");
           $("#chkboxOnReport").removeAttr("checked");
           $("#uniform-chkboxOnReport span").removeClass("checked");
           $("#chkboxInPayroll").removeAttr("checked");
           $("#uniform-chkboxInPayroll span").removeClass("checked");
           $("#chkboxPunch").removeAttr("checked");
           $("#uniform-chkboxPunch span").removeClass("checked");
           $("#chkboxshareRoster").removeAttr("checked");
           $("#uniform-shareRoster span").removeClass("checked");
           $("#chkboxNotifyFalg").removeAttr("checked");
           $("#uniform-chkboxNotifyFalg span").removeClass("checked");
           $("#chkboxIncludeEmailNotification").removeAttr("checked");
           $("#uniform-chkboxIncludeEmailNotification span").removeClass("checked");
           $("#chkboxWebPunch").removeAttr("checked");
           $("#uniform-chkboxWebPunch span").removeClass("checked");
           $("#chkboxMonthlyMissedHours").removeAttr("checked");
           $("#uniform-chkboxMonthlyMissedHours span").removeClass("checked");


       }

       function Edit(empID) {
           debugger
           //Edit code
           //    txtCode txtSalutationEn txtSalutationAr txtNameEn txtNameAr txtCardNo txtPIN txtEmail txtRemarks
           //      ddSex   ddOrg   ddEmpType   ddMgr  ddCountry  ddGrade  ddDesig  ddSch  ddRegion
           //      chkboxMgr   chkboxActive   chkboxLocal  chkboxShift  chkboxOvertime  chkboxOnReport  chkboxInPayroll
           var v = "key=getByID&id=" + empID;
           //$("#spnGridMsg").html("&nbsp;");
         //  alert(v);
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       $("#spnID").html(j.ID);
                       if (j.ID == "0" || j.ID == "") {
                           $("#spnID").html(j.ID);
                           return;
                       }
                       $("#txtCode").val(j.Code);
                       $("#txtUsername").val(j.Username);
                       $("#txtPassword").val(j.Password);
                       $("#txtSalutationEn").val(j.SalutationEn);
                       $("#txtSalutationAr").val(j.SalutationAr);
                       $("#txtNameEn").val(j.NameEn);
                       $("#txtNameAr").val(j.NameAr);
                       $("#txtCardNo").val(j.CardNo);
                       $("#txtPIN").val(j.ReaderPassword);
                       $("#txtEmail").val(j.Email);
                       $("#txtMobile").val(j.Mobile);
                       $("#txtRemarks").val(j.Remarks);
                       $("#txtJoinDate").val(j.JoinDateStr);
                       $("#txtInactiveDate").val(j.InactiveDateStr);
                       $("#txtSystemActiveDate").val(j.SystemActivationDateStr);

                       
                      
                       if (j.JoinDateStr != '') {
                           $('#txtJoinDate').datepicker({ format: 'yyyy-mm-dd', viewMode: "days" });

                           $("#txtJoinDate").datepicker('update', j.JoinDateStr);
                       }
                       else {
                           $("#txtJoinDate").datepicker({
                               format: " yyyy",
                               viewMode: "years"
                           });
                       }
                       $('#ddSex option[value=' + j.SexFlag + ']').attr('selected', 'selected');
                       $("#ddSex").trigger("liszt:updated");
                       $('#ddOrg option[value=' + j.OrgID + ']').attr('selected', 'selected');
                       $("#ddOrg").trigger("liszt:updated");
                       $('#ddEmpType option[value=' + j.EmpTypeID + ']').attr('selected', 'selected');
                       $("#ddEmpType").trigger("liszt:updated");
                       $('#ddMgr option[value=' + j.ManagerID + ']').attr('selected', 'selected');
                       $("#ddMgr").trigger("liszt:updated");
                       $('#ddCountry option[value=' + j.CountryID + ']').attr('selected', 'selected');
                       $("#ddCountry").trigger("liszt:updated");
                       $('#ddGrade option[value=' + j.GradeID + ']').attr('selected', 'selected');
                       $("#ddGrade").trigger("liszt:updated");
                       $('#ddDesig option[value=' + j.DesignationID + ']').attr('selected', 'selected');
                       $("#ddDesig").trigger("liszt:updated");
                       $('#ddSch option[value=' + j.ScheduleTypeID + ']').attr('selected', 'selected');
                       $("#ddSch").trigger("liszt:updated");
                       $('#ddRegion option[value=' + j.RegionID + ']').attr('selected', 'selected');
                       $("#ddRegion").trigger("liszt:updated");
                       $('#ddBuildginListId option[value=' + j.BuildingID + ']').attr('selected', 'selected');
                       $("#ddBuildginListId").trigger("liszt:updated");

                       if (j.ManagerFlag + "" == "1" || j.ManagerFlag + "" == "true" || j.ManagerFlag + "" == "True") {
                           $("#chkboxMgr").attr("checked", "checked");
                           $("#uniform-chkboxMgr span").addClass("checked");
                       }
                       if (j.PunchFlag + "" == "1") {
                           $("#chkboxPunch").attr("checked", "checked");
                           $("#uniform-chkboxPunch span").addClass("checked");
                       }
                       if (j.StatusFlag + "" == "1") {
                           $("#chkboxActive1").attr("checked", "checked");
                           $("#uniform-chkboxActive1 span").addClass("checked");
                       }
                       if (j.LocalFlag + "" == "1") {
                           $("#chkboxLocal").attr("checked", "checked");
                           $("#uniform-chkboxLocal span").addClass("checked");
                       }
                       if (j.ShiftFlag + "" == "1") {
                           $("#chkboxShift").attr("checked", "checked");
                           $("#uniform-chkboxShift span").addClass("checked");
                       }
                       if (j.OpenShiftFlag + "" == "1") {
                           $("#chkboxOpenShift").attr("checked", "checked");
                           $("#uniform-chkboxOpenShift span").addClass("checked");
                       }
                       if (j.WebPunchFlag + "" == "1") {
                           $("#chkboxWebPunch").attr("checked", "checked");
                           $("#uniform-chkboxWebPunch span").addClass("checked");
                       }
                       if (j.OvertimeFlag + "" == "1") {
                           $("#chkboxOvertime").attr("checked", "checked");
                           $("#uniform-chkboxOvertime span").addClass("checked");
                       }
                       if (j.OnReportFlag + "" == "1") {
                           $("#chkboxOnReport").attr("checked", "checked");
                           $("#uniform-chkboxOnReport span").addClass("checked");
                       }
                       if (j.ShareRoster + "" == "1") {
                           $("#chkboxshareRoster").attr("checked", "checked");
                           $("#uniform-chkboxshareRoster span").addClass("checked");
                       }
                       if (j.Inpayroll + "" == "1" || j.Inpayroll + "" == "true" || j.Inpayroll + "" == "True") {
                           $("#chkboxInPayroll").attr("checked", "checked");
                           $("#uniform-chkboxInPayroll span").addClass("checked");
                       }
                       if (j.NotifyFlag + "" == "1" || j.NotifyFlag + "" == "true" || j.NotifyFlag + "" == "True") {
                           $("#chkboxNotifyFalg").attr("checked", "checked");
                           $("#uniform-chkboxNotifyFalg span").addClass("checked");
                       }
                       if (j.IncludeNotification + "" == "1" || j.IncludeNotification + "" == "true" || j.IncludeNotification + "" == "True") {
                           $("#chkboxIncludeNotifications").attr("checked", "checked");
                           $("#uniform-chkboxIncludeNotifications span").addClass("checked");
                       }
                       if (j.CalculateMonthlyMissedHours + "" == "1") {
                           $("#chkboxMonthlyMissedHours").attr("checked", "checked");
                           $("#uniform-chkboxMonthlyMissedHours span").addClass("checked");
                       }
                   }

                   if ("<%= enableForm %>" == "false") {
                       $("#form_sample_1 input").attr("disabled", "disabled");
                       $("#form_sample_1 select").attr("disabled", "disabled");
                       $("#form1 input").attr("disabled", "disabled");
                       $("#form1 select").attr("disabled", "disabled");
                       $("#form2 input").attr("disabled", "disabled");
                   }
               },
               error: function (html) {

               }

           });
           
       }

       function Save() {
           debugger

           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           //    txtCode txtSalutationEn txtSalutationAr txtNameEn txtNameAr txtCardNo txtPIN txtEmail txtRemarks
           //      ddSex   ddOrg   ddEmpType   ddMgr  ddCountry  ddGrade  ddDesig  ddSch  ddRegion
           //      chkboxMgr   chkboxActive   chkboxLocal  chkboxShift  chkboxOvertime  chkboxOnReport  chkboxInPayroll

           var id = $("#spnID").html(); //$.getQueryString('sch') + "";
           var orgID = $("#ddOrg").val();
           var sex = $("#ddSex").val();
           var code = $("#txtCode").val();
           var salEn = $("#txtSalutationEn").val();
           var salAr = $("#txtSalutationAr").val();
           var nameEn = $("#txtNameEn").val();
           var nameAr = $("#txtNameAr").val();
           var card = $("#txtCardNo").val();
           var pin = $("#txtPIN").val();
           var email = $("#txtEmail").val();
           var join = $("#txtJoinDate").val();
           var inactive = $("#txtInactiveDate").val();
           var systemActivationDate = $("#txtSystemActiveDate").val();

           var remarks = $("#txtRemarks").val();
           var mobile = $("#txtMobile").val();

           var username = $("#txtUsername").val();
           var pswd = $("#txtPassword").val();

           var empType = $("#ddEmpType").val();
           var mgr = $("#ddMgr").val();
           var cnt = $("#ddCountry").val();
           var grd = $("#ddGrade").val();
           var desig = $("#ddDesig").val();
           var sch = $("#ddSch").val();
           var rgn = $("#ddRegion").val();
           var inactive = $("#txtInactiveDate").val();
           var bldng_id = $("#ddBuildginListId").val();
           var ismgr = $("#chkboxMgr").is(":checked");
           var active = $("#chkboxActive1").is(":checked");
           var local = $("#chkboxLocal").is(":checked");
           var punch = $("#chkboxPunch").is(":checked");
           var shift = $("#chkboxShift").is(":checked");
           var openShift = $("#chkboxOpenShift").is(":checked");
           var webpunch = $("#chkboxWebPunch").is(":checked");
           //chkboxWebPunch
           var overtime = $("#chkboxOvertime").is(":checked");
           var onreport = $("#chkboxOnReport").is(":checked");
           var inpayroll = $("#chkboxInPayroll").is(":checked");
           var shareRoster = $("#chkboxshareRoster").is(":checked");
           var notifyFlag = $("#chkboxNotifyFalg").is(":checked");
           var includeNotifications = $("#chkboxIncludeNotifications").is(":checked");
           var monthlyMissedHours = $("#chkboxMonthlyMissedHours").is(":checked");


           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }
           var v = "key=save" + "&id=" + id + "&code=" + code + "&salEn=" + salEn + "&salAr=" + salAr + "&nameEn=" + nameEn + "&username=" + username + "&pswd=" + pswd;
           v += "&nameAr=" + nameAr + "&card=" + card + "&pin=" + pin + "&email=" + email + "&empType=" + empType + "&mgr=" + mgr + "&shareRoster=" + shareRoster;
           v += "&orgID=" + orgID + "&cnt=" + cnt + "&grd=" + grd + "&desig=" + desig + "&sch=" + sch + "&rgn=" + rgn + "&building_id=" + bldng_id  + "&photo=" + "" + "&sex=" + sex;
           v += "&ismgr=" + ismgr + "&active=" + active + "&local=" + local + "&punch=" + punch + "&shift=" + shift + "&overtime=" + overtime;
           v += "&onreport=" + onreport + "&inpayroll=" + inpayroll + "&join=" + join + "&inactive=" + inactive + "&remarks=" + remarks + "&mobile=" + mobile;
           v += "&notifyFlag=" + notifyFlag + "&includeNotifications=" + includeNotifications + "&openShift=" + openShift + "&webpunch=" + webpunch;
           v += "&systemActivationDate=" + systemActivationDate + "&monthlyMissedHours=" + monthlyMissedHours; 
         

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("~/RequestPages/EmployeePage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("Error! Record not saved successfully.");
                   }
                   else if (html == '0') {
                       //exists
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("Error! User already exists in database.");
                   }
                   else {
                       //success
                       ajaxFileUpload(html);
                       //$("#btnProfileImage").click();
                       Clear();
                       $("#divSuccessMsg").css("display", "block");
                       $("#spnSuccessMsg").html("Sucessfully saved in database.");

                       //LoadOrganizations();
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("Error! " + html);
               }

           });

       }

       function CloseForm() {
           window.location = '<%= Page.ResolveClientUrl("~/Emp/Employees") %>';
       }


       function ajaxFileUpload(id) {

           //var id = $("#spnID").html();


           var user = '<%= Session["ID"] %>';

            var v = "key=save" + "&id=" + id + "&user=" + user;

            var url = "<%= path %>Handlers/AjaxUserFileUpload.ashx?" + v;
           var handlerURL = url;


            $("#loading")
           .ajaxStart(function () {
               $(this).show();
               $("#divForm").mask("Saving record....");
           })
           .ajaxComplete(function () {
               $("#divForm").unmask();
               $(this).hide();
           });

            $.ajaxFileUpload({
                url: handlerURL,
                secureuri: false,
                fileElementId: 'fileToUpload',
                dataType: 'json',
                data: { name: 'logan', id: 'id' },
                success: function (data, status) {
                    if (typeof (data.error) != 'undefined') {
                        ////if (data.error != '') {
                        ////    $("#spnMsg").html("<div class='alert warning'>Error! " + data.error + "</div>");
                        ////} else {
                        ////    $("#spnMsg").html(" <div class='alert success'>Record has been saved successfully</div>");

                        ////}
                    }
                    if ($('#spnEmp').text() != "" && $('#spnEmp').text() != "0") {
                        window.location = '<%= Page.ResolveClientUrl("~/Emp/Employees") %>';
                    }
                    Clear();
                },
                error: function (data, status, e) {
                    //alert(e);
                    if ($('#spnEmp').text() != "" && $('#spnEmp').text() != "0") {
                        window.location = '<%= Page.ResolveClientUrl("~/Emp/Employees") %>';
                    }
                    Clear();
                }
            })
            return false;
        } ///////////////////////////////END OF FUNCTION ajaxFileUpload/////////////////////////////////////////


       var FormComponents = function () {

           var handlejQueryUIDatePickers = function () {
               $(".ui-date-picker").datepicker();
              
           }
           
           var handleDateTimePickers = function () {

               if (jQuery().datepicker) {
                   $('#txtJoinDate').datepicker({ format: 'yyyy-mm-dd', viewMode: "years" });
                   $('#txtInactiveDate').datepicker({ format: 'yyyy-mm-dd', viewMode: "years" });
                   $('#txtSystemActiveDate').datepicker({ format: 'yyyy-mm-dd', viewMode: "years" });
                  }
               
               

           }

           var handleInputMasks = function () {
               $.extend($.inputmask.defaults, {
                   'autounmask': true
               });

               $("#txtJoinDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
               $("#txtInactiveDate").inputmask("y-m-d", { autoUnmask: true });  //direct mask        
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
           
            $('#form_sample_1').validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    org: {
                        required: true
                    },
                    code: {
                        required: true,
                        maxlength: 10
                    },
                    cardNo: {
                        required: true,
                        maxlength: 50
                    },
                    nameEn: {
                        required: true,
                        minlength: 2,
                        maxlength: 255
                    },
                    nameAr: {
                        required: true,
                        minlength: 2,
                        maxlength: 255
                    },
                    username: {
                        required: true,
                        minlength: 2,
                        maxlength: 20
                    },
                    password: {
                        required: true,
                        minlength: 5,
                        maxlength: 50
                    },
                    email: {
                        email: true
                    },
                    sex: {
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    org: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    code: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    cardNo: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    nameEn: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    nameAr: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    username: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    password: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    sex: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.attr("name") == "org" || element.attr("name") == "schLocation") { // for uniform checkboxes, insert the after the given container
                        error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavoir
                    }
                },
                invalidHandler: function (event, validator) { //display error alert on form submit              
                    success1.hide();
                    error1.show();
                    //App.scrollTo(error1, -200);
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


            $('#form2').validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    country: { 
                        required: true
                    },
                    regn: {
                        required: true
                    },
                    emptype: {
                        required: true,
                        
                    },
                    grade: {
                       
                        required: true
                    },
                    mngr: {
                        
                        required: true
                    },
                    desig: {
                        required: true,
                       
                    },
                    sch: {
                       
                        required: true
                    },
                    sex: {
                        required: true
                    }
                },

                messages: { // custom messages for radio buttons and checkboxes
                    country: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    regn: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    emptype: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    grade: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    mngr: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    desig: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    },
                    sch: {
                        required: "<%=Resources.Resource.lblRequired %>"
                    }
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.attr("name") == "org" || element.attr("name") == "schLocation") { // for uniform checkboxes, insert the after the given container
                        error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavoir
                    }
                },
                invalidHandler: function (event, validator) { //display error alert on form submit              
                    success1.hide();
                    error1.show();
                    //App.scrollTo(error1, -200);
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
