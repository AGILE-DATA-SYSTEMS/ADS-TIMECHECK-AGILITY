<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SideBar.ascx.cs" Inherits="TAMSR2.CustomControls.SideBar" %>

<div id="spnLeftBar" runat="server">
</div>


<div class='page-sidebar nav-collapse collapse'>
    <ul>
        <li>
            <div id="sidebarToggler" class='sidebar-toggler hidden-phone'></div>
        </li>
        <li style="display: none;">
            <form class='sidebar-search'>
                <div class='input-box'>
                    <a href='javascript:;' class='remove'></a>
                    <input type='text' placeholder='<%=Resources.Resource.search %>...' />
                    <input type='button' class='submit' value=' ' />
                </div>
            </form>
        </li>
        <li id='liDashboard' class='start '>
            <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'>
                <i class='icon-home'></i><span class='title'><%=Resources.Resource.dashboard %> </span>
                <span class='selected'></span></a>
            <ul class='sub-menu'>
                <li id='liHome'><a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.selfStatistic %> </a></li>

                <%   if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_TEAM_DASHBOARD) == true)
                    { %>
                <li id='liTeamStats'><a href='<%= Page.ResolveClientUrl("~/Dashboard/Team-Stats") %>'><%=Resources.Resource.reportingEmployeeStats %> </a></li>
                <% } %>
                <%   if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ACTIVITY_MONITOR) == true)
                    { %>
                <li id='liActivityMonitor'><a href='<%= Page.ResolveClientUrl("~/Dashboard/Activity-Monitor") %>'><%=Resources.Resource.activityMonitor %> </a></li>
                <% } %>
                <%   if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_TEAM_EFFICIENCY) == true)
                    { %>
                <li id='liTeamEfficiency'><a href='<%= Page.ResolveClientUrl("~/Dashboard/Team-Efficiency") %>'><%=Resources.Resource.teamEfficiency %> </a></li>
                <% } %>
                <%   if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_MAP) == true)
                    { %>
                <li id='liGeoTracking'><a href='<%= Page.ResolveClientUrl("~/Dashboard/Geo-Tracking") %>'><%=Resources.Resource.geoTracking %> </a></li>
                <% } %>
            </ul>
        </li>
        <% 
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_REGION) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_COUNTRY) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_REASON) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_GRADE) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_JOB_LIST) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_EMP_TYPE) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_PERMISSIONTYPES) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_COMPANY_LEAVE) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_HOLIDAY_LIST) == true
                )
            {%>
        <li id='liGeneral' class=''>
            <a href='javascript:;'><i class='icon-th-list'></i>
                <span class='title'><%=Resources.Resource.generalInfo %> </span>
                <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <%   if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_REGION) == true)
                    { %>
                <li id='liGeneralRegion'><a href='<%= Page.ResolveClientUrl("~/Common/Regions") %>'><%=Resources.Resource.regions %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_COUNTRY) == true)
                    { %>
                <li id='liGeneralNationality'><a href='<%= Page.ResolveClientUrl("~/Common/Nationalities") %>'><%=Resources.Resource.nationalities %> </a></li>

                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_REASON) == true)
                    { %>
                <li id='liGeneralReason'><a href='<%= Page.ResolveClientUrl("~/Common/Reasons") %>'><%=Resources.Resource.reasons %> </a></li>

                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_GRADE) == true)
                    { %>
                <li id='liEmpGrade'><a href='<%= Page.ResolveClientUrl("~/Common/Grades") %>'><%= Resources.Resource.grades %> </a></li>

                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_JOB_LIST) == true)
                    { %>
                <li id='liEmpDesignation'><a href='<%= Page.ResolveClientUrl("~/Common/Designations") %>'><%= Resources.Resource.designations %> </a></li>

                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_EMP_TYPE) == true)
                    { %>
                <li id='liGeneralEmpType'><a href='<%= Page.ResolveClientUrl("~/Common/Employee-Types") %>'><%=Resources.Resource.employeeTypes %> </a></li>

                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_PERMISSIONTYPES) == true)
                    { %>
                <li id='liGeneralPermissionType'><a href='<%= Page.ResolveClientUrl("~/Common/Permission-Types") %>'><%=Resources.Resource.permissionTypes %> </a></li>

                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_COMPANY_LEAVE) == true)
                    { %>
                <li id='liGeneralLeave'><a href='<%= Page.ResolveClientUrl("~/Common/Leave-Types") %>'><%=Resources.Resource.leaveType %> </a></li>

                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_HOLIDAY_LIST) == true)
                    { %>
                <li id='liGeneralHolidays'><a href='<%= Page.ResolveClientUrl("~/Common/Holidays") %>'><%=Resources.Resource.holidays %> </a></li>

                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_WORKFLOWS) == true)
                    { %>
                <li id='liWorkflows'><a href='<%= Page.ResolveClientUrl("~/Common/Workflows") %>'><%=Resources.Resource.workflow %> </a></li>

                <% } %>
            </ul>
        </li>

        <% } %>

        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ORGANIZATION) == true ||
                    new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ORGANIZATION_TYPES) == true
                    )
            { %>
        <li id='liOrg' class=''><a href='javascript:;'><i class='icon-sitemap'></i>
            <span class='title'><%=Resources.Resource.organization %> </span>
            <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ORGANIZATION_TYPES) == true)
                    { %>
                <li id='liOrgType'><a href='<%= Page.ResolveClientUrl("~/Common/Organization-Types") %>'><%=Resources.Resource.organizationTypes %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ORGANIZATION) == true)
                    { %>
                <li id='liOrgOrganizationStructure'><a href='<%= Page.ResolveClientUrl("~/Common/OrganizationStructure") %>'><%=Resources.Resource.orgStructure %> </a></li>
                <li id='liOrgOrganization'><a href='<%= Page.ResolveClientUrl("~/Common/Organizations") %>'><%=Resources.Resource.organizations %> </a></li>
                <% } %>
            </ul>
        </li>
        <% }%>


        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_TYPES) == true ||
                    new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_LOCATION) == true ||
                    new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_TIME) == true ||
                    new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE) == true ||
                    new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_ROSTER) == true ||
                    new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_RAMADAN_DATE_RANGE) == true ||
                    new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_MY_SCHEDULE_ROSTER) == true
                    )
            { %>
        <li id='liSch' class=''><a href='javascript:;'><i class='icon-calendar'></i>
            <span class='title'><%=Resources.Resource.schedule %></span>
            <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_TYPES) == true)
                    { %>
                <li id='liSchType' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Sch/Schedule-Types")  %>'><%=Resources.Resource.scheduleTypes %></a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_LOCATION) == true)
                    {  %>
                <li id='liSchLocation' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Sch/Schedule-Locations")  %>'><%=Resources.Resource.scheduleLocations %></a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_TIME) == true)
                    { %>
                <li id='liSchTime'><a href='<%= Page.ResolveClientUrl("~/Sch/Schedule-Times")  %>'><%=Resources.Resource.scheduleTimes %></a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE) == true ||
                        new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPLY_EMPLOYEE_SCHEDULE) == true ||
                        new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPROVE_EMPLOYEE_SCHEDULE) == true)
                    { %>

                <li id="liSchedule">
                    <a href="javascript:;">
                        <%= Resources.Resource.schedule %>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE) == true)
                            { %>
                        <li id='liSchedules'><a href='<%= Page.ResolveClientUrl("~/Sch/Schedules")  %>'><%=Resources.Resource.weeklySchedule %></a></li>
                        <li id='liRotationalSchedules' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Sch/rotational-Schedules")  %>'><%=Resources.Resource.rotationalSchedule %></a></li>
                        <% }
                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPLY_EMPLOYEE_SCHEDULE) == true)
                            { %>
                        <li id='liApplyEmpSch' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Sch/View-Applied-Employee-Schedules")  %>'><%=Resources.Resource.appliedSchedules %></a></li>
                        <% }
                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_ROSTER) == true)
                            { %>
                        <li id='liSchRoster' style=""><a href='<%= Page.ResolveClientUrl("~/Sch/Monthly-Roster")  %>'><%=Resources.Resource.monthlyRoster %></a></li>
                        <% }
                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPROVE_EMPLOYEE_SCHEDULE) == true)
                            { %>
                        <li id='liApproveEmpSch' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Sch/Approve-Employee-Schedules")  %>'><%=Resources.Resource.approveSchedule %></a></li>

                        <% } %>
                    </ul>

                </li>
                <% } %>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_RAMADAN_DATE_RANGE) == true)
                    { %>
                <li id='liSchRamadanDateRange'><a href='<%= Page.ResolveClientUrl("~/Sch/Ramadan-Date-Range-View")  %>'><%=Resources.Resource.ramadanDateRanges %></a></li>
                <% } %>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_ROSTER) == true)
                    { %>
                <li id="liRosterSubList" style="display: none;">
                    <a href="javascript:;">
                        <%= Resources.Resource.roster %>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <%  if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPLY_SCHEDULE_ROSTER) == true)
                            { %>
                        <li id='liApplySchRoster' style=""><a href='<%= Page.ResolveClientUrl("~/Sch/Apply-Schedule-Roster")  %>'><%=Resources.Resource.applyScheduleRoster %></a></li>
                        <% }
                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPROVE_SCHEDULE_ROSTER) == true)
                            { %>
                        <li id='liApproveSchRoster' style=""><a href='<%= Page.ResolveClientUrl("~/Sch/Approve-Schedule-Roster")  %>'><%=Resources.Resource.approveScheduleRoster %></a></li>
                        <% }
                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SCHEDULE_ROSTER) == true)
                            {  %>
                        <li id='liSchRosterx' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Sch/Monthly-Roster")  %>'><%=Resources.Resource.monthlyRoster %></a></li>
                        <% }
                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_MY_SCHEDULE_ROSTER) == true)
                            { %>
                        <li id='liSchViewMyRoster' style=""><a href='<%= Page.ResolveClientUrl("~/Sch/My-Schedule-Roster-View")  %>'><%=Resources.Resource.sectionMonthlyRoster %></a></li>
                        <% }
                            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SHARE_ROSTER) == true)
                            { %>
                        <li id='liSchShareRoster' style=""><a href='<%= Page.ResolveClientUrl("~/Sch/Share-Schedule-Roster-View")  %>'><%=Resources.Resource.shareRoster %></a></li>
                        <% } %>
                    </ul>
                </li>
                <% } %>
            </ul>
        </li>
        <% }  %>

        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_EMPLOYEE) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_GROUP) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DELEGATE) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_WEBPUNCH_EXCEPTION_LIST) == true
                )
            { %>
        <li id='liEmp' class=''><a href='javascript:;'><i class='icon-group'></i>
            <span class='title'><%= Resources.Resource.employee %> </span>
            <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <%   if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_EMPLOYEE) == true)
                    { %>
                <li id='liEmpEmployee'><a href='<%= Page.ResolveClientUrl("~/Emp/Employees") %>'><%= Resources.Resource.employees %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SENIOR_EMPLOYEE) == true)
                    { %>
                <li id='liEmpSeniorsList' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Emp/Employee-Seniors-List") %>'><%=Resources.Resource.seniorEmployeeList %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DEPT_ADMIN) == true)
                    { %>
                <li id='liViewDeptAdmins'><a href='<%= Page.ResolveClientUrl("~/Emp/Department-Admins") %>'><%=Resources.Resource.DeptAdmins %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_GROUP) == true)
                    { %>
                <li id='liGroup'><a href='<%= Page.ResolveClientUrl("~/Emp/Employee-Groups") %>'><%= Resources.Resource.employeeGroups %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DELEGATE) == true)
                    { %>
                <li id='liEmpDelegation'><a href='<%= Page.ResolveClientUrl("~/Emp/Employee-Delegate") %>'><%= Resources.Resource.delegation %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_WEBPUNCH_EXCEPTION_LIST) == true)
                    { %>
                <li id='liEmpWebpunch' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Emp/Employee-Webpunch-Exception") %>'><%= Resources.Resource.webPunchExceptions %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_OVERTIME) == true)
                    { %>
                <li id='liOvertime'><a href='<%= Page.ResolveClientUrl("~/Emp/Employee-Overtime") %>'><%= Resources.Resource.overtime %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPROVE_OVERTIME) == true)
                    { %>
                <li id='liOvertimeApproval'><a href='<%= Page.ResolveClientUrl("~/Emp/Employee-Approve-Overtime") %>'><%= Resources.Resource.approveovertime %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPROVED_OVERTIME_PROCESS) == true)
                    { %>
                <li id='liOvertimeProcess'><a href='<%= Page.ResolveClientUrl("~/Emp/Employee-Approve-Overtime-Process") %>'><%= Resources.Resource.processOvertime %> </a></li>
                <% }  %>
            </ul>
        </li>
        <% } %>
        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SINGLE_PERMISSION) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_EMP_LEAVE) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.PERMISSION_APPROVAL) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.CANCEL_PERMISSION_APPROVAL) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.LEAVE_APPROVAL) == true
                )
            { %>
        <li id='liLeaveGroup' class=''><a href='javascript:;'><i class='icon-edit'></i>
            <span class='title'><%= Resources.Resource.leavesAndPermission %> </span>
            <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <%   if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SINGLE_PERMISSION) == true)
                    { %>
                <li id='liShortPermission'><a href='<%= Page.ResolveClientUrl("~/Leaves/Short-Permission") %>'><%= Resources.Resource.shortPermission %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_EMP_LEAVE) == true)
                    { %>
                <li id='liEmpLeave'><a href='<%= Page.ResolveClientUrl("~/Leaves/Employee-Leaves") %>'><%= Resources.Resource.employeeLeaves %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.PERMISSION_APPROVAL) == true)
                    { %>
                <li id='liPermissionApproval'><a href='<%= Page.ResolveClientUrl("~/Leaves/Approve-Permissions") %>'><%= Resources.Resource.permissionApproval %> 
                </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.CANCEL_PERMISSION_APPROVAL) == true)
                    { %>
                <li id='liCancelPermissionApproval' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Leaves/Approve-Cancel-Permissions") %>'><%= Resources.Resource.cancelPermissionApproval %> 
                </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.LEAVE_APPROVAL) == true)
                    { %>
                <li id='liLeaveApproval'><a href='<%= Page.ResolveClientUrl("~/Leaves/Approve-Employee-Leaves") %>'><%= Resources.Resource.leaveApproval %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VERIFICATION_APPROVAL) == true)
                    { %>
                <li id='liVerificationApproval'><a href='<%= Page.ResolveClientUrl("~/Leaves/Approve-Verifications") %>'><%= Resources.Resource.verificationApproval %> </a></li>
                <% }  %>
            </ul>
        </li>
        <% } %>

        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_APPROVAL) == true)
            { %>
        <li id='liApproval' class=''><a href='javascript:;'><i class='icon-bullhorn'></i>
            <span class='title'><%= Resources.Resource.approvals %> </span>
            <span class='selected'></span><span class='arrow '></span><span class="badge badge-important" id="spnTotalPendingApprovals"><%= pendingTotalCount %></span></a>

            <ul class='sub-menu'>
                <%  if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_PENDING_APPROVAL) == true)
                    { %>
                <li id='liPendingApproval'><a href='<%= Page.ResolveClientUrl("~/Approval/Pending-Approval/0/0/0/") %>'><%= Resources.Resource.pendingApproval %>
                    <span class="badge badge-important" id="spnPendingApprovals"><%= pendingTotalCount %></span></a></li>
                <% } %>
            </ul>
        </li>
        <% } %>

        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_MONTH_LOCK) == true)
            { %>
        <li id='liMonthLockMain' class=''><a href='javascript:;'><i class='icon-lock'></i>
            <span class='title'><%= Resources.Resource.monthLock %> </span>
            <span class='selected'></span><span class='arrow '></span></a>

            <ul class='sub-menu'>
                <%  if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_MONTH_LOCK) == true)
                    { %>
                <li id='liMonthLock'><a href='<%= Page.ResolveClientUrl("~/Freeze/Month-Lock") %>'><%= Resources.Resource.monthLock %>  
                </a></li>
                <% } %>
            </ul>
        </li>
        <% } %>
        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_TA_EVENT) == true
                || new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_EMP_MANUAL_MOVEMENT) == true)
            { %>
        <li id='liEvents' class=''><a href='javascript:;'><i class='icon-signal'></i>
            <span class='title'><%= Resources.Resource.movements %> </span>
            <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_TA_EVENT) == true)
                    { %>
                <li id='liEventsTAEvents'><a href='<%= Page.ResolveClientUrl("~/Details/ViewTAEvents.aspx?orgID=&empID=&groupID=&fromDate=&toDate=") %>'><%= Resources.Resource.employeeMovements %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_EMP_MANUAL_MOVEMENT) == true)
                    { %>
                <li id='liManualMovement'><a href='<%= Page.ResolveClientUrl("~/Events/View-Manual-Movement") %>'><%= Resources.Resource.manualMovements %> </a></li>
                <% } %>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPROVE_MANUAL_TRANSACTION) == true)
                    { %>
                <li id='liApproveManualTrans'><a href='<%= Page.ResolveClientUrl("~/Events/Approve-Manual-Transaction") %>'>
                    <%=Resources.Resource.approve + " " + Resources.Resource.manualMovements %> </a></li>
                <% } %>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_MANUAL_TRANSACTION) == true)
                    { %>
                <li id='liViewMissingMovment'><a href='<%= Page.ResolveClientUrl("~/Events/Employee-Missing-Transaction") %>'><%= Resources.Resource.missingMovements %> </a></li>
                <% } %>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_MANUAL_TRANSACTION) == true)
                    { %>
                <li id='liViewManulMovment'><a href='<%= Page.ResolveClientUrl("~/Events/View-Manual-Transaction") %>'><%= Resources.Resource.appliedMovements %> </a></li>
                <% } %>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.APPROVE_MISSING_TRANSACTIONS) == true)
                    { %>
                <li id='liApproveMissingTrans'><a href='<%= Page.ResolveClientUrl("~/Events/Approve-Missing-Transaction") %>'>
                    <%= Resources.Resource.approve + " " + Resources.Resource.missingMovements %> </a></li>
                <% } %>
            </ul>
        </li>
        <% } %>

        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_READERS) == true)
            { %>
        <li id='liDevices' class=''><a href='javascript:;'><i class='icon-th-list'></i>
            <span class='title'><%= Resources.Resource.devices %> </span>
            <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <li id='li_Readers'><a href='<%= Page.ResolveClientUrl("~/Devices/View-Devices") %>'><%= Resources.Resource.readers %> </a></li>
                <li id='li_DevicesZones'><a href='<%= Page.ResolveClientUrl("~/Devices/View-Zones") %>'><%= Resources.Resource.zones %> </a></li>
                <li id='li_DevicesBuilding'><a href='<%= Page.ResolveClientUrl("~/Devices/View-Building") %>'><%= Resources.Resource.building %> </a></li>
            </ul>
        </li>
        <% } %>

        <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.BUSINESS_INTELLIGENCE) == true)
            { %>
        <li id='liBusinessInt'><a class='active' href='javascript:;'><i class=' icon-briefcase'></i>
            <span class='title'><%= Resources.Resource.businessIntelligence %> </span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <li id='liSapHcm'><a href='<%= Page.ResolveClientUrl("~/reports/sap-hcm-extract") %>'><%= Resources.Resource.saphcm %> </a></li>
            </ul>
        </li>
        <% } %>

        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_REPORTS) == true)
            { %>
        <li id='liRpt' class=''><a href='javascript:;'><i class='icon-bar-chart'></i>
            <span class='title'><%= Resources.Resource.report %> </span>
            <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <li id='liStandardReports'><a href='<%= Page.ResolveClientUrl("~/Reports/Standard-Reports") %>'><%= Resources.Resource.reports %> </a></li>
                <li id="liStd">
                    <a href="javascript:;">
                        <%= Resources.Resource.rosterReports %>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu" style="display: none;">
                        <!--<li id='liRosterView'><a href='<%= Page.ResolveClientUrl("~/Reports/Generate-Roster-View") %>'><%= Resources.Resource.rosterView %> </a></li>-->
                        <li id='liRosterReport'><a href='<%= Page.ResolveClientUrl("~/Reports/Generate-Roster-Report") %>'><%= Resources.Resource.monthlyRoster %> </a></li>
                    </ul>
                </li>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_REPORT_TEMPLATE) == true)
                    { %>
                <li id="liDyn">
                    <a href="javascript:;">
                        <%= Resources.Resource.dynamic %>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li id='liReportTemplates'><a href='<%= Page.ResolveClientUrl("~/Reports/View-Report-Templates") %>'><%= Resources.Resource.templates %> </a></li>
                        <li id='liTemplateWizard'><a href='<%= Page.ResolveClientUrl("~/Reports/Template-Wizard") %>'><%= Resources.Resource.templateWizard %> </a></li>
                        <li id='liReportWizard'><a href='<%= Page.ResolveClientUrl("~/Reports/Generate-Report") %>'><%= Resources.Resource.generateReport %> </a></li>
                    </ul>
                </li>
                <%  if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.ALLOW_REPROCESS_ATTENDANCE_DATA) == true)
                    {  %>
                <li id='liReprocessData'><a href='<%= Page.ResolveClientUrl("~/Security/Reprocess-Data") %>'><%= Resources.Resource.reprocessData %> </a></li>
                <%  } %>
                 <li id='liTransactionRpt'><a href='<%= Page.ResolveClientUrl("~/Reports/Transaction-Report") %>'><%= Resources.Resource.transactionReport %> </a></li>

                <% } %>
            </ul>
        </li>
        <% } %>
        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ROLE) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_PRIVILEGE) == true ||
                new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.DB_CONSOLE) == true
                )
            { %>
        <li id='liSecurity' class=''><a href='javascript:;'><i class='icon-key'></i>
            <span class='title'><%= Resources.Resource.security %> </span>
            <span class='selected'></span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_ROLE) == true)
                    { %>
                <li id='liRoles'><a href='<%= Page.ResolveClientUrl("~/Security/Roles") %>'><%= Resources.Resource.roles %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_PRIVILEGE) == true)
                    {  %>
                <li id='liPrivileges'><a href='<%= Page.ResolveClientUrl("~/Security/Privileges") %>'><%= Resources.Resource.privileges %> </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.DB_CONSOLE) == true)
                    {  %>
                <li id='li1' style="display: none;"><a target="_blank" href='<%= Page.ResolveClientUrl("~/Security/Console") %>'>Console </a></li>
                <% }
                    if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_LOGIN_LOG) == true)
                    { %>
                <li id='liLoginLog'><a href='<%= Page.ResolveClientUrl("~/security/view-login-log") %>'><%= Resources.Resource.viewUserLoginLog %> </a></li>
                <% }

                %>
            </ul>
        </li>
        <% } %>
        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.EDIT_APPLICATION_SETTINGS) == true)
            { %>
        <li id='liSettings'><a class='active' href='javascript:;'><i class='icon-cogs'></i>
            <span class='title'><%= Resources.Resource.settings %> </span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <li id='liAppSetting'><a href='<%= Page.ResolveClientUrl("~/Security/Application-Settings") %>'><%= Resources.Resource.appSetting %> </a></li>
                <li id='liNotification'><a href='<%= Page.ResolveClientUrl("~/Notification/View-Notifications") %>'><%= Resources.Resource.notification %> </a></li>
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_APP_LICENSE) == true)
                    { %>
                <li id='liAppLicense'><a href='<%= Page.ResolveClientUrl("~/details/viewlicense.aspx") %>'><%= Resources.Resource.license %> </a></li>
                <% } %>
                <li id='liReaders' style="display: none;"><a href='javascript:;'><%= Resources.Resource.readers %> <span class='arrow'></span></a></li>
                <li id='liConnectionType' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Details/ViewConnectionTypes.aspx") %>'><%= Resources.Resource.connectionType %> </a></li>
                <li id='liDeviceGroup' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Details/ViewDeviceGroups.aspx") %>'><%= Resources.Resource.deviceGroup %> </a></li>
                <li id='liDeviceConnection' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Details/ViewDeviceConnections.aspx") %>'><%= Resources.Resource.deviceConnection %> </a></li>
                <li id='liPanels' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Details/ViewPanels.aspx") %>'><%= Resources.Resource.panel %> </a></li>
                <li id='liReaderType' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Details/ViewReaderTypes.aspx") %>'><%= Resources.Resource.readerType %> </a></li>
            </ul>
        </li>
        <% } %>

        <%
            if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.View_Data_Synchronization) == true)
            { %>
        <li id='liSynchronization'><a class='active' href='javascript:;'><i class=' icon-random'></i>
            <span class='title'><%= Resources.Resource.alerts %> </span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <li id='liDataSynchronization' style="display: none;"><a href='<%= Page.ResolveClientUrl("~/Synchronization/Data-Synchronization") %>'><%= Resources.Resource.dataSynchronizaton %> </a></li>
                <li id='liEmaillogs'><a href='<%= Page.ResolveClientUrl("~/Synchronization/email-logs") %>'><%= Resources.Resource.email %> </a></li>
            </ul>
        </li>
        <% } %>
        <%
            if ((Session["rootUser"] + "").ToLower() == "true")
            { %>
        <li id='liCompany' class=''><a href='<%= Page.ResolveClientUrl("~/Admin/ViewCompanies.aspx") %>'><i class='icon-bar-chart'></i>
            <span class='title'><%= Resources.Resource.companies %></span>
            <span class='selected'></span></a></li>
        <li id='liUser' class=''><a href='<%= Page.ResolveClientUrl("~/Admin/ViewUsers.aspx") %>'><i class='icon-user'></i>
            <span class='title'><%= Resources.Resource.users %></span>
            <span class='selected'></span></a></li>
        <% } %>


        <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_SYSTEM_SUPPORT) == true)
            { %>
        <li id='liSupport'><a class='active' href='javascript:;'><i class=' icon-cog'></i>
            <span class='title'><%= Resources.Resource.support %> </span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <li id='liPatch'><a href='<%= Page.ResolveClientUrl("~/support/ta-patch") %>'><%= Resources.Resource.Patch %> </a></li>
            </ul>

        </li>
        <% } %>

        <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.TIMECHECK_MOBILE) == true)
            { %>
        <li id='liTimeCheckMobile'><a class='active' href='javascript:;'><i class=' icon-qrcode'></i>
            <span class='title'><%= Resources.Resource.timeCheckMobile %> </span><span class='arrow '></span></a>
            <ul class='sub-menu'>
                <li id='liQrScan'><a href='<%= Page.ResolveClientUrl("~/support/qr-code") %>'><%= Resources.Resource.mobileRegistration %> </a></li>
            </ul>
        </li>
        <% } %>
    </ul>
</div>






