<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SideBar.ascx.cs" Inherits="TAMSR2.CustomControls.SideBar" %>


<!-- BEGIN SIDEBAR -->
<div class="page-sidebar nav-collapse collapse">
    <!-- BEGIN SIDEBAR MENU -->
    <ul>
        <li>
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
            <div class="sidebar-toggler hidden-phone"></div>
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
        </li>
        <li>
            <!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
            <form class="sidebar-search">
                <div class="input-box">
                    <a href="javascript:;" class="remove"></a>
                    <input type="text" placeholder="<%=Resources.Resource.search %>..." />
                    <input type="button" class="submit" value=" " />
                </div>
            </form>
            <!-- END RESPONSIVE QUICK SEARCH FORM -->
        </li>


        <li id="liHome" class="start ">
            <a href='<%= Page.ResolveClientUrl("~/Common/Default.aspx") %>'>
                <i class="icon-home"></i>
                <span class="title"> <%=Resources.Resource.home %> </span>

                <span class="selected"></span>

            </a>

        </li>

        <li id="liOrg" class="">
            <a href="javascript:;">
                <i class="icon-bookmark-empty"></i>
                <span class="title"> <%=Resources.Resource.organization %> </span>
                <span class="selected"></span>
                <span class="arrow "></span>
            </a>
            <ul class="sub-menu">
                <li id="liOrgType">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewOrganizationTypes.aspx") %>'> <%=Resources.Resource.organizationTypes %> </a>
                </li>
                <li id="liOrgOrganization">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewOrganizations.aspx") %>'> <%=Resources.Resource.organizations %> </a>
                </li>
            </ul>
            
        </li>
        
        <li id="liSch" class="">
            <a href="javascript:;">
                <i class="icon-cogs"></i>
                <span class="title"> <%=Resources.Resource.schedule %> </span>
                <span class="selected"></span>
                <span class="arrow "></span>
            </a>
            <ul class="sub-menu">
                <li id="liSchType">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewScheduleTypes.aspx") %>'> <%=Resources.Resource.scheduleTypes %> </a>
                </li>
                <li id="liSchLocation">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewScheduleLocations.aspx") %>'> <%=Resources.Resource.scheduleLocations %> </a>
                </li>
                <li id="liSchTime">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewScheduleTime.aspx") %>'> <%=Resources.Resource.scheduleTimes %> </a>
                </li>
                <li id="liSchRoster">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewScheduleRoster.aspx") %>'> <%=Resources.Resource.monthlyRoster %> </a>
                </li>
                <%--<li id="liSchSchedule">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewSchedules.aspx") %>'> <%=Resources.Resource.schedules %> </a>
                </li>--%>
            </ul>
            
        </li>

        <li id="liEmp" class="">
            <a href="javascript:;">
                <i class="icon-group"></i>
                <span class="title"> <%=Resources.Resource.employee %> </span>
                <span class="selected"></span>
                <span class="arrow "></span>
            </a>
            <ul class="sub-menu">
                <li id="liEmpType">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewEmployeeTypes.aspx") %>'> <%=Resources.Resource.employeeTypes %> </a>
                </li>
                <li id="liEmpEmployee">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewEmployees.aspx") %>'> <%=Resources.Resource.employees %> </a>
                </li>
                <li id="liEmpGrade">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewGrades.aspx") %>'> <%=Resources.Resource.grades %> </a>
                </li>
                <li id="liEmpLeave">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewLeaves.aspx") %>'> <%=Resources.Resource.leaves %> </a>
                </li>
                <li id="liEmpDesignation">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewDesignations.aspx") %>'> <%=Resources.Resource.designations %> </a>
                </li>
                <li id="liEmpReason">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewReasons.aspx") %>'> <%=Resources.Resource.reasons %> </a>
                </li>
                <li id="liEmpPermissionType">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewPermissionTypes.aspx") %>'> <%=Resources.Resource.permissionTypes %> </a>
                </li>
            </ul>
            
        </li>

        <li id="liRpt" class="">
            <a href="javascript:;">
                <i class="icon-gift"></i>
                <span class="title"> <%=Resources.Resource.Report %> </span>
                <span class="selected"></span>
                <span class="arrow "></span>
            </a>
            <ul class="sub-menu">
                <li id="liTemplateWizard">
                    <a href='<%= Page.ResolveClientUrl("~/Reports/TemplateWizard.aspx") %>'> <%=Resources.Resource.reportTemplateWizard %> </a>
                </li>
                <li id="liReportWizard">
                    <a href='<%= Page.ResolveClientUrl("~/Reports/ReportWizard.aspx") %>'> <%=Resources.Resource.ReportWizard %> </a>
                </li>
            </ul>
            
        </li>

        <li id="liOther" class="">
            <a href="javascript:;">
                <i class="icon-gift"></i>
                <span class="title"> <%=Resources.Resource.others %> </span>
                <span class="selected"></span>
                <span class="arrow "></span>
            </a>
            <ul class="sub-menu">
                <li id="liOtherNationality">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewCounteries.aspx") %>'> <%=Resources.Resource.nationalities %> </a>
                </li>
                <li id="liOtherRegion">
                    <a href='<%= Page.ResolveClientUrl("~/Details/ViewRegions.aspx") %>'> <%=Resources.Resource.regions %> </a>
                </li>
            </ul>
            
        </li>


        <li class="" style="display: none;">
            <a href="javascript:;">
                <i class="icon-bookmark-empty"></i>
                <span class="title">UI Features</span>


                <span class="arrow "></span>
            </a>

            <ul class="sub-menu">
                <li>
                    <a href="ui_general.html"><%=Resources.Resource.general %>	</a>
                </li>
                <li>
                    <a href="ui_buttons.html">Buttons							</a>
                </li>
                <li>
                    <a href="ui_tabs_accordions.html">Tabs & Accordions							</a>
                </li>
                <li>
                    <a href="ui_jqueryui.html">jQuery UI Components							</a>
                </li>
                <li>
                    <a href="ui_sliders.html">Sliders							</a>
                </li>
                <li>
                    <a href="ui_tiles.html">Tiles							</a>
                </li>
                <li>
                    <a href="ui_typography.html">Typography							</a>
                </li>
                <li>
                    <a href="ui_tree.html">Tree View							</a>
                </li>
                <li>
                    <a href="ui_nestable.html">Nestable List							</a>
                </li>
            </ul>
        </li>



        <li class="" style="display: none;">
            <a href="javascript:;">
                <i class="icon-table"></i>
                <span class="title">Form Stuff</span>


                <span class="arrow "></span>
            </a>

            <ul class="sub-menu">
                <li>
                    <a href="form_layout.html">Form Layouts							</a>
                </li>
                <li>
                    <a href="form_samples.html">Advance Form Samples							</a>
                </li>
                <li>
                    <a href="form_component.html">Form Components							</a>
                </li>
                <li>
                    <a href="form_wizard.html">Form Wizard							</a>
                </li>
                <li>
                    <a href="form_validation.html">Form Validation							</a>
                </li>
                <li>
                    <a href="form_fileupload.html">Multiple File Upload							</a>
                </li>
                <li>
                    <a href="form_dropzone.html">Dropzone File Upload							</a>
                </li>
            </ul>
        </li>



        <li class="" style="display: none;">
            <a href="javascript:;">
                <i class="icon-briefcase"></i>
                <span class="title">Pages</span>


                <span class="arrow "></span>
            </a>

            <ul class="sub-menu">
                <li>
                    <a href="page_blog.html">
                        <i class="icon-comments"></i>
                        Blog							</a>
                </li>
                <li>
                    <a href="page_news.html">
                        <i class="icon-coffee"></i>
                        <%=Resources.Resource.news %>					</a>
                </li>
                <li>
                    <a href="page_about.html">
                        <i class="icon-group"></i>
                        <%=Resources.Resource.aboutUs %>							</a>
                </li>
                <li>
                    <a href="page_contact.html">
                        <i class="icon-envelope-alt"></i>
                        <%=Resources.Resource.contactUs %>							</a>
                </li>
                <li>
                    <a href="page_calendar.html">
                        <i class="icon-calendar"></i>
                        <%=Resources.Resource.calendar %>							</a>
                </li>
            </ul>
        </li>



        <li class="" style="display: none;">
            <a href="javascript:;">
                <i class="icon-gift"></i>
                <span class="title">Extra</span>


                <span class="arrow "></span>
            </a>

            <ul class="sub-menu">
                <li>
                    <a href="inbox.html">User Inbox							</a>
                </li>
                <li>
                    <a href="extra_profile.html">User Profile							</a>
                </li>
                <li>
                    <a href="extra_faq.html"><%=Resources.Resource.faq %>							</a>
                </li>
                <li>
                    <a href="extra_search.html">Search Results							</a>
                </li>
                <li>
                    <a href="extra_invoice.html">Invoice							</a>
                </li>
                <li>
                    <a href="extra_pricing_table.html">Pricing Tables							</a>
                </li>
                <li>
                    <a href="extra_image_manager.html">Image Manager							</a>
                </li>
                <li>
                    <a href="extra_404.html">404 Page							</a>
                </li>
                <li>
                    <a href="extra_500.html">500 Page							</a>
                </li>
            </ul>
        </li>

        <li style="display: none;">
            <a class="active" href="javascript:;">
                <i class="icon-briefcase"></i>
                <span class="title">3 Level Menu</span>
                <span class="arrow "></span>
            </a>
            <ul class="sub-menu">
                <li>
                    <a href="javascript:;">Item 1
								<span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="#">Sample Link 1</a></li>
                        <li><a href="#">Sample Link 2</a></li>
                        <li><a href="#">Sample Link 3</a></li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;">Item 1
								<span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="#">Sample Link 1</a></li>
                        <li><a href="#">Sample Link 1</a></li>
                        <li><a href="#">Sample Link 1</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">Item 3
                    </a>
                </li>
            </ul>
        </li>
        <li style="display: none;">
            <a href="javascript:;">
                <i class="icon-folder-open"></i>
                <span class="title">4 Level Menu</span>
                <span class="arrow "></span>
            </a>
            <ul class="sub-menu">
                <li>
                    <a href="javascript:;">
                        <i class="icon-cogs"></i>
                        Item 1
								<span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li>
                            <a href="javascript:;">
                                <i class="icon-user"></i>
                                Sample Link 1
										<span class="arrow"></span>
                            </a>
                            <ul class="sub-menu">
                                <li><a href="#"><i class="icon-remove"></i>Sample Link 1</a></li>
                                <li><a href="#"><i class="icon-pencil"></i>Sample Link 1</a></li>
                                <li><a href="#"><i class="icon-edit"></i>Sample Link 1</a></li>
                            </ul>
                        </li>
                        <li><a href="#"><i class="icon-user"></i>Sample Link 1</a></li>
                        <li><a href="#"><i class="icon-external-link"></i>Sample Link 2</a></li>
                        <li><a href="#"><i class="icon-bell"></i>Sample Link 3</a></li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;">
                        <i class="icon-globe"></i>
                        Item 2
								<span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li><a href="#"><i class="icon-user"></i>Sample Link 1</a></li>
                        <li><a href="#"><i class="icon-external-link"></i>Sample Link 1</a></li>
                        <li><a href="#"><i class="icon-bell"></i>Sample Link 1</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="icon-folder-open"></i>
                        Item 3
                    </a>
                </li>
            </ul>
        </li>


        <li class="" style="display: none;">
            <a href="javascript:;">
                <i class="icon-th-list"></i>
                <span class="title">Data Tables</span>


                <span class="arrow "></span>
            </a>

            <ul class="sub-menu">
                <li>
                    <a href="table_basic.html">Basic Tables							</a>
                </li>
                <li>
                    <a href="table_responsive.html">Responsive Tables							</a>
                </li>
                <li>
                    <a href="table_managed.html">Managed Tables							</a>
                </li>
                <li>
                    <a href="table_editable.html">Editable Tables							</a>
                </li>
            </ul>
        </li>



        <li class="" style="display: none;">
            <a href="javascript:;">
                <i class="icon-th-list"></i>
                <span class="title">Portlets</span>


                <span class="arrow "></span>
            </a>

            <ul class="sub-menu">
                <li>
                    <a href="portlet_general.html">General Portlets							</a>
                </li>
                <li>
                    <a href="portlet_draggable.html">Draggable Portlets							</a>
                </li>
            </ul>
        </li>



        <li class="" style="display: none;">
            <a href="javascript:;">
                <i class="icon-map-marker"></i>
                <span class="title"><%=Resources.Resource.maps %></span>
                <span class="selected"></span>


                <span class="arrow "></span>
            </a>

            <ul class="sub-menu">
                <li>
                    <a href="maps_google.html">Google Maps							</a>
                </li>
                <li>
                    <a href="maps_vector.html">Vector Maps							</a>
                </li>
            </ul>
        </li>


        <% if((Session["rootUser"] + "").ToLower() == "true"){ %>
        <li id="liCompany" class="">
            <a href='<%= Page.ResolveClientUrl("~/Admin/ViewCompanies.aspx") %>'>
                <i class="icon-bar-chart"></i>
                <span class="title"><%=Resources.Resource.companies %></span>
                <span class="selected"></span>


            </a>

        </li>



        <li id="liUser" class="">
            <a href='<%= Page.ResolveClientUrl("~/Admin/ViewUsers.aspx") %>'>
                <i class="icon-user"></i>
                <span class="title"><%=Resources.Resource.users %></span>
                <span class="selected"></span>


            </a>

        </li>
        <% } %>

    </ul>
    <!-- END SIDEBAR MENU -->
</div>
<!-- END SIDEBAR -->
