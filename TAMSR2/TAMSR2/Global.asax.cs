using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using TAMSR2Framework.DAL;

namespace TAMSR2
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            // Register the default hubs route: ~/signalr
            RouteTable.Routes.MapHubs();
            try
            {
                RegisterRoutes(RouteTable.Routes);
                AppSetting.errorLogPath = Server.MapPath("~/ErrorLog");
            }
            catch (Exception ex)
            {
            }
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

        //Public Sub RegisterRoutes(ByVal routes As RouteCollection)

        public void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("login", "Login/{code}", "~/Login.aspx", true, new RouteValueDictionary(new { code = "" }));
            routes.MapPageRoute("logout", "Logout", "~/Logout.aspx");
          //  routes.MapPageRoute("home", "Common/Home/{uid}", "~/Common/Default.aspx", true, new RouteValueDictionary(new { uid = "0" }));

            //Dashboard
            // routes.MapPageRoute("dashboard", "Dashboard/Home/{uid}", "~/Dashboard/MainDashboard.aspx", true, new RouteValueDictionary(new { uid = "0" }));
            routes.MapPageRoute("home", "Common/Home/{uid}", "~/Dashboard/MainDashboard.aspx", true, new RouteValueDictionary(new { uid = "0" }));
            routes.MapPageRoute("teamstats", "Dashboard/Team-Stats", "~/Dashboard/TeamStats.aspx");
            routes.MapPageRoute("activitymonitor", "Dashboard/Activity-Monitor", "~/Dashboard/ActivityMonitor.aspx");
            routes.MapPageRoute("teamefficiency", "Dashboard/Team-Efficiency", "~/Dashboard/TeamEfficiency.aspx"); 
            routes.MapPageRoute("geotracking", "Dashboard/Geo-Tracking", "~/Dashboard/GeoTracking.aspx");




            //General Info Tab
            routes.MapPageRoute("generalInfo", "Common/General-Information", "~/Details/ViewGeneralInfo.aspx");
            routes.MapPageRoute("region", "Common/Regions", "~/Details/ViewRegions.aspx");
            routes.MapPageRoute("nationality", "Common/Nationalities", "~/Details/ViewNationalities.aspx");
            //routes.MapPageRoute("nationality", "Common/Nationalities", "~/Details/ViewCounteries.aspx");
            routes.MapPageRoute("reason", "Common/Reasons", "~/Details/ViewReasons.aspx");
            routes.MapPageRoute("grade", "Common/Grades", "~/Details/ViewGrades.aspx");
            routes.MapPageRoute("designation", "Common/Designations", "~/Details/ViewDesignations.aspx");
            routes.MapPageRoute("employeeType", "Common/Employee-Types", "~/Details/ViewEmployeeTypes.aspx");
            routes.MapPageRoute("permissionType", "Common/Permission-Types", "~/Details/ViewPermissionTypes.aspx");
            routes.MapPageRoute("savepermissionType", "Common/Save-Permission-Types/{perm}", "~/Details/SavePermissionTypes.aspx", true, new RouteValueDictionary(new { perm = "" }));
            routes.MapPageRoute("leave", "Common/Leave-Types", "~/Details/ViewLeaves.aspx");
            routes.MapPageRoute("holiday", "Common/Holidays", "~/Details/ViewHolidays.aspx");
            routes.MapPageRoute("saveHoliday", "Common/Save-Holiday/{hdy}", "~/Details/SaveHoliday.aspx", true, new RouteValueDictionary(new { hdy = "0" }));
            routes.MapPageRoute("workflow", "Common/Workflows", "~/Workflows/ViewWorkflows.aspx");
            routes.MapPageRoute("saveworkflow", "Workflows/Save-Workflow/{Workflow}", "~/Workflows/SaveWorkflows.aspx", true, new RouteValueDictionary(new { Workflow = "0" }));
          





            //Organization Tab
            routes.MapPageRoute("organizationStructure", "Common/OrganizationStructure", "~/Details/ViewOrganizationSummary.aspx");
            routes.MapPageRoute("organization", "Common/Organizations", "~/Details/ViewOrganizations.aspx");
            routes.MapPageRoute("organizationType", "Common/Organization-Types", "~/Details/ViewOrganizationTypes.aspx");






            //Employee Tab
            routes.MapPageRoute("employee", "Emp/Employees", "~/Details/ViewEmployees.aspx");
            routes.MapPageRoute("saveEmployee", "Emp/Save-Employee-Details/{emp}", "~/Details/SaveEmployeeDetails.aspx", true, new RouteValueDictionary(new { emp = "0" }));

            routes.MapPageRoute("employeeSeniorsList", "Emp/Employee-Seniors-List", "~/Details/ViewSeniorsList.aspx");
            routes.MapPageRoute("viewDeptAdmins", "Emp/Department-Admins", "~/DptAdmins/ViewDptAdmins.aspx");
            routes.MapPageRoute("saveDeptAdmins", "Emp/Save-Department-Admins/{dlg}", "~/DptAdmins/AddDptAdmins.aspx", true, new RouteValueDictionary(new { dlg = "0" }));

            routes.MapPageRoute("employeeGroup", "Emp/Employee-Groups", "~/Details/ViewEmployeeGroups.aspx");
            routes.MapPageRoute("saveEmployeeGroup", "Emp/Save-Employee-Group/{gid}", "~/Details/SaveEmployeeGroup.aspx", true, new RouteValueDictionary(new { gid = "0" }));
            routes.MapPageRoute("assignEmployeeToGroup", "Emp/Assign-Employees-To-Groups/{gid}/{name}", "~/Details/AssignGroupEmployees.aspx", true, new RouteValueDictionary(new { gid = "0", name = "" }));
            routes.MapPageRoute("employeeDelegate", "Emp/Employee-Delegate", "~/Details/ViewDelegations.aspx");

            routes.MapPageRoute("saveEmployeeDelegate", "Emp/Save-Employee-Delegate/{dlg}", "~/Details/SaveDelegation.aspx", true, new RouteValueDictionary(new { dlg = "0" }));
            routes.MapPageRoute("employeeWebpunchExclude", "Emp/Employee-Webpunch-Exception", "~/Details/ViewWebpunchExcludeList.aspx");
            routes.MapPageRoute("saveemployeeWebpunchExclude", "Emp/Employee-Webpunch-Exception/{webpunch}", "~/Details/SaveWebpunchExcludeList.aspx", true, new RouteValueDictionary(new { webpunch = "0" }));
            routes.MapPageRoute("empOvertime", "Emp/Employee-Overtime", "~/Details/ViewOverTime.aspx");
            routes.MapPageRoute("employeeApproveOvertime", "Emp/Employee-Approve-Overtime", "~/Details/ViewOvertimeApproval.aspx");
            routes.MapPageRoute("employeeApproveOvertimeProcess", "Emp/Employee-Approve-Overtime-Process", "~/EmpOvertime/ViewApprovedOvertimeProcess.aspx");





            //Schedule Tab
            routes.MapPageRoute("schType", "Sch/Schedule-Types", "~/Details/ViewScheduleTypes.aspx");
            routes.MapPageRoute("schLocation", "Sch/Schedule-Locations", "~/Details/ViewScheduleLocations.aspx");
            routes.MapPageRoute("schTime", "Sch/Schedule-Times", "~/Details/ViewScheduleTime.aspx");
            routes.MapPageRoute("saveSchTime", "Sch/Save-Schedule-Time/{sch}", "~/Details/SaveScheduleTime.aspx", true, new RouteValueDictionary(new { sch = "0" }));

            routes.MapPageRoute("schSchedule", "Sch/Schedules", "~/Details/ViewSchedules.aspx");
            routes.MapPageRoute("saveSchSchedule", "Sch/Save-Schedule/{sch}/{org}/{emp}/{group}", "~/Details/SaveSchedule.aspx", true, new RouteValueDictionary(new { sch = "0", org = "1", emp = "", group = "" }));
            routes.MapPageRoute("schViewApplyEmployeeSchedule", "Sch/View-Applied-Employee-Schedules", "~/EmployeeScheduleWorkFlow/ViewAppliedEmployeeSchedules.aspx");
            routes.MapPageRoute("schApplyEmployeeSchedule", "Sch/Apply-Employee-Schedules/{sch}", "~/EmployeeScheduleWorkFlow/ApplyEmployeeSchedule.aspx", true, new RouteValueDictionary(new { sch = "0" }));
            routes.MapPageRoute("schApproveEmployeeSchedule", "Sch/Approve-Employee-Schedules", "~/EmployeeScheduleWorkFlow/ApproveEmployeeSchedule.aspx");

            routes.MapPageRoute("schMonthlyRoster", "Sch/Monthly-Roster", "~/Details/ViewScheduleRoster.aspx");
            routes.MapPageRoute("applySchMonthlyRoster", "Sch/Apply-Schedule-Roster", "~/ScheduleMonthlyRoster/ApplyScheduleRoster.aspx");
            routes.MapPageRoute("approveSchMonthlyRoster", "Sch/Approve-Schedule-Roster", "~/ScheduleMonthlyRoster/ApproveScheduleRoster.aspx");

            routes.MapPageRoute("schMyRoster", "Sch/My-Schedule-Roster-View", "~/Details/ViewMyMonthlyRoster.aspx");
            routes.MapPageRoute("schShareRoster", "Sch/Share-Schedule-Roster-View", "~/Details/ViewShareRosters.aspx");
            routes.MapPageRoute("saveSchShareRoster", "Sch/Save-Share-Schedule-Roster/{sch}", "~/Details/SaveShareRoster.aspx", true, new RouteValueDictionary(new { sch = "0" }));
            routes.MapPageRoute("schViewRamadanDateRange", "Sch/Ramadan-Date-Range-View", "~/Details/ViewRamadanDateRange.aspx");
            routes.MapPageRoute("schSaveRamadanDateRange", "Sch/Save-Ramadan-Date-Range/{sch}", "~/Details/SaveRamadanDateRange.aspx", true, new RouteValueDictionary(new { sch = "0" }));
            routes.MapPageRoute("schRotationalSchedule", "Sch/rotational-Schedules", "~/Details/ViewRotationalSchedules.aspx");
            routes.MapPageRoute("saveSchrotationalSchedule", "Sch/Save-Rotational-Schedule/{sch}/{org}/{emp}/{group}/{FromDate}", "~/Details/SaveRotationalSchedule.aspx", true, new RouteValueDictionary(new { sch = "0", org = "1", emp = "", group = "", fromDate = "" }));



            //Leaves Tab
            routes.MapPageRoute("verifications", "Leaves/Approve-Verifications", "~/Details/ViewVerifications.aspx");
            routes.MapPageRoute("shortPermission", "Leaves/Short-Permission", "~/Details/ViewShortPermission.aspx");
            routes.MapPageRoute("approvePermission", "Leaves/Approve-Permissions", "~/Details/ViewPermissionApproval.aspx");
            routes.MapPageRoute("approveCancelPermission", "Leaves/Approve-Cancel-Permissions", "~/Details/ViewPermissionCancellationApproval.aspx");

            routes.MapPageRoute("saveShortPermission", "Leaves/Save-Short-Permission/{perm}", "~/Details/SaveShortPermission.aspx", true, new RouteValueDictionary(new { perm = "" }));
            routes.MapPageRoute("employeeLeave", "Leaves/Employee-Leaves", "~/Details/ViewEmployeeLeaves.aspx");
            routes.MapPageRoute("employeeLeaveApproval", "Leaves/Approve-Employee-Leaves", "~/Details/ViewLeaveApproval.aspx");
            routes.MapPageRoute("saveEmployeeLeave", "Leaves/Save-Employee-Leave/{empLv}", "~/Details/ApplyEmployeeLeave.aspx", true, new RouteValueDictionary(new { empLv = "" }));


            routes.MapPageRoute("pendingApproval", "Approval/Pending-Approval/{org}/{mgr}/{emp}/{typ}", "~/Details/ViewAllApproval.aspx", true, new RouteValueDictionary(new { org = "0", mgr = "0", emp = "0", typ = "" }));



            //Events Tab
            routes.MapPageRoute("taEvents", "Events/Employee-Movement/{org}/{emp}/{group}/{fromDate}/{toDate}", "~/Details/ViewTAEvents.aspx", true, new RouteValueDictionary(new { org = "", emp = "", group = "", fromDate = "", toDate = "" }));
            routes.MapPageRoute("viewManualMovement", "Events/View-Manual-Movement", "~/Details/ViewManualTransactions.aspx");
            routes.MapPageRoute("saveManualMovemen", "Events/Save-Manual-Movement/{tid}", "~/Details/SaveManualTransactions.aspx", true, new RouteValueDictionary(new { tid = "" }));
            routes.MapPageRoute("viewManualMovements", "Events/View-Manual-Transaction", "~/Details/ViewManualTransaction.aspx", true, new RouteValueDictionary(new { tid = "" }));
            routes.MapPageRoute("saveManualPunch", "Events/Save-Manual-Punch/{tid}", "~/Details/savemanualpunch.aspx", true, new RouteValueDictionary(new { tid = "" }));
            routes.MapPageRoute("approveManualMovement", "Events/Approve-Manual-Transaction", "~/Details/ViewManualTransactionApproval.aspx");

            routes.MapPageRoute("approveMissingMovement", "Events/Approve-Missing-Transaction", "~/EmployeeMovements/ViewMissingTransactionApproval.aspx");
            routes.MapPageRoute("missingMovement", "Events/Employee-Missing-Transaction", "~/EmployeeMovements/ViewMissingMovements.aspx");
            routes.MapPageRoute("saveMissingPunch", "Events/Save-Missing-Transaction/{tid}/{emp}/{mode}/{transDate}", "~/EmployeeMovements/SaveMissingTransaction.aspx", true, new RouteValueDictionary(new { tid = "", emp = "", mode = "", transDate = "" }));





            //Report Tab
            routes.MapPageRoute("reportWizard", "Reports/Generate-Report", "~/Reports/ReportWizard.aspx");
            routes.MapPageRoute("viewreporttemplates", "Reports/View-Report-Templates", "~/Reports/ViewReportTemplates.aspx");
            routes.MapPageRoute("templateWizard", "Reports/Template-Wizard", "~/Reports/TemplateWizard.aspx");
            routes.MapPageRoute("viewReport", "Reports/Report-View", "~/Reports/ViewRptPage.aspx");

            routes.MapPageRoute("generateRosterReport", "Reports/Generate-Roster-Report", "~/Reports/ViewRosterReport.aspx");
            routes.MapPageRoute("rosterReport", "Reports/Roster-Report", "~/Reports/RosterReport.aspx");
            routes.MapPageRoute("generateRosterView", "Reports/Generate-Roster-View", "~/Reports/ViewMonthlyRosterView.aspx");
            routes.MapPageRoute("rosterView", "Reports/Roster-View", "~/Reports/ViewRptRosterView.aspx");
            routes.MapPageRoute("standardReports", "Reports/Standard-Reports", "~/Reports/StandardReports.aspx");
            routes.MapPageRoute("saphcm", "Reports/SAP-HCM-Extract", "~/Reports/ViewSAPHCM.aspx");
            routes.MapPageRoute("transactionReport", "Reports/Transaction-Report", "~/Reports/TransactionReport.aspx");





            //Devices Tab
            routes.MapPageRoute("viewReaders", "Devices/View-Devices", "~/Devices/ViewReaders.aspx");
            routes.MapPageRoute("viewZones", "Devices/View-Zones", "~/Devices/viewZones.aspx");
            routes.MapPageRoute("viewBuilding", "Devices/View-Building", "~/Devices/viewBuilding.aspx");

            //routes.MapPageRoute("employee", "Emp/Employees", "~/Details/ViewEmployees.aspx");
            //routes.MapPageRoute("saveEmployee", "Emp/Save-Employee-Details/{emp}", "~/Details/SaveEmployeeDetails.aspx", true, new RouteValueDictionary(new { emp = "0" }));


            //Notification Tab



            //Settings Tab
            routes.MapPageRoute("viewAppSettings", "Security/Application-Settings", "~/Details/ViewAppSettings.aspx");
            routes.MapPageRoute("viewNotifications", "Notification/View-Notifications", "~/Details/ViewNotification.aspx");
            routes.MapPageRoute("viewLicense", "License/View-License", "~/Details/ViewLicense.aspx"); 

            //month lock Tab
            routes.MapPageRoute("viewMonthLock", "Freeze/Month-Lock", "~/EmpMonthLock/ViewMonthLock.aspx");
            routes.MapPageRoute("viewMonthLockDetails", "Freeze/Month-Lock-Details/{id}", "~/EmpMonthLock/ViewMonthLockDetails.aspx", true, new RouteValueDictionary(new { id = "" }));


            //Synchronization Tab
            routes.MapPageRoute("viewSync", "Synchronization/Data-Synchronization", "~/SyncData/ViewSynchronization.aspx");





            //Security Tab
            routes.MapPageRoute("viewUserLoginLog", "security/view-login-log", "~/Details/ViewUserLoginLog.aspx");
            routes.MapPageRoute("viewPrivileges", "Security/Privileges", "~/Details/ViewPrivileges.aspx");
            routes.MapPageRoute("viewRoles", "Security/Roles", "~/Details/ViewRoles.aspx");
            routes.MapPageRoute("assignUserToGroup", "Security/Assign-Employees-To-Roles/{roleID}/{roleName}", "~/Details/AssignUserRoles.aspx", true, new RouteValueDictionary(new { roleID = "0", roleName = "" }));
            routes.MapPageRoute("reprocessdata", "Security/Reprocess-Data", "~/Details/ReProcessData.aspx");
            routes.MapPageRoute("dbConsole", "Security/Console", "~/Details/ViewDBConsole.aspx");

            routes.MapPageRoute("viewEmaillogs", "Synchronization/email-logs", "~/SyncData/EmailLogs.aspx");

            routes.MapPageRoute("viewQRCode", "support/qr-code", "~/support/qrcode.aspx");
            routes.MapPageRoute("viewPatch", "support/ta-patch", "~/support/hotfix.aspx");
            routes.MapPageRoute("applyLicense", "License/ApplyLicense", "~/ApplyLicense.aspx");

        } 
    }
}