using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAMSR2.CustomClasses;
using TAMSR2.ObjectClasses;
using TAMSR2Framework.DAL;

namespace TAMSR2.CustomControls
{
    public partial class SideBar : System.Web.UI.UserControl
    {
        public static string url = "";
        public static string languageStr = "en";
        public static string pullDirectionStr = "right";
        public static string pendingPermissionCount = "";
        public static string pendingMissingMovementCount = "";
        public static string pendingManualMovementCount = "";
        public static string pendingTotalCount = "";
        /// <summary>
        /// Set page culture values according to user selection
        /// </summary>
        #region
        public void SetCultureValues()
        {
            HttpCookie cookie = Request.Cookies["tamsCulture"];
            try
            {
                if (cookie == null)
                {
                    cookie = new HttpCookie("tamsCulture");
                    cookie.Values.Add("pullDirection", AppSetting.defaultPullDirection + "");
                    cookie.Values.Add("language", AppSetting.defaultLanguage + "");
                    cookie.Values.Add("culture", AppSetting.defaultCulture + "");
                    cookie.Values.Add("timeZone", AppSetting.defaultTimeZone + "");
                    cookie.Values.Add("dateFormat", AppSetting.dateFormat + "");
                    cookie.Values.Add("dateTimeFormat", AppSetting.dateTimeFormat + "");
                    DateTime dt = DateTime.UtcNow.AddHours(AppSetting.defaultTimeZone).AddDays(7);
                    cookie.Expires = dt;
                    Response.Cookies.Add(cookie);
                }
                pullDirectionStr = cookie.Values["pullDirection"] + "";
                languageStr = cookie.Values["language"] + "";
                Page.UICulture = cookie.Values["culture"] + "";
                Page.Culture = cookie.Values["culture"] + "";
            }
            catch (Exception ex)
            {
                pullDirectionStr = AppSetting.defaultPullDirection + "";
                languageStr = AppSetting.defaultLanguage + "";
                Page.UICulture = AppSetting.defaultCulture + "";
                Page.Culture = AppSetting.defaultCulture + "";
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            SetCultureValues();
            //LoadMenu();
            PendingCount obj = new PendingCount().GetAllPendingCounts(Session["ID"] + "");
            pendingManualMovementCount = obj.ManualMovementCount;
            pendingMissingMovementCount = obj.MissingMovementCount;
            pendingPermissionCount = obj.ShortPermissionCount;
            pendingTotalCount = obj.TotalPendingCount;
        }

        public static string GetPrivilegeOrgDisplay()
        {
            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_ROLE) == true)
            {
                return " block";
            }
            else
            {
                return " none;";
            }
        }

        public void LoadMenu()
        {
            StringBuilder sb = new StringBuilder();

            //(String)GetGlobalResourceObject("Resource", "choose")

            sb.Append("<div class='page-sidebar nav-collapse collapse'>");
            sb.Append("<ul><li><div class='sidebar-toggler hidden-phone'></div></li>");
            sb.Append("<li><form class='sidebar-search'><div class='input-box'>");
            sb.Append("<a href='javascript:;' class='remove'></a>");
            sb.Append("<input type='text' placeholder='" + (String)GetGlobalResourceObject("Resource", "search") + "...' />");
            sb.Append("<input type='button' class='submit' value=' ' /></div></form></li>");
            
            sb.Append("<li id='liHome' class='start '>");
            sb.Append("<a href='" +  Page.ResolveClientUrl("~/Common/Home") + "'>");
            sb.Append("<i class='icon-home'></i><span class='title'>" + (String)GetGlobalResourceObject("Resource", "home") + " </span>");
            sb.Append("<span class='selected'></span></a></li>");

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_COUNTRY) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_REASON) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_PERMISSIONTYPES) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_COMPANY_LEAVE) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_HOLIDAY_LIST) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_EMP_TYPE) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_REGION) == true
                )
            {
                sb.Append("<li id='liGeneral' class=''>");
                sb.Append("<a href='javascript:;'><i class='icon-th-list'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "generalInfo") + " </span>");
                sb.Append("<span class='selected'></span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu'>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_COUNTRY) == true)
                    sb.Append("<li id='liGeneralNationality'><a href='" + Page.ResolveClientUrl("~/Common/Nationalities") + "'>" + (String)GetGlobalResourceObject("Resource", "nationalities") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_REASON) == true)
                    sb.Append("<li id='liGeneralReason'><a href='" + Page.ResolveClientUrl("~/Common/Reasons") + "'>" + (String)GetGlobalResourceObject("Resource", "reasons") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_PERMISSIONTYPES) == true)
                    sb.Append("<li id='liGeneralPermissionType'><a href='" + Page.ResolveClientUrl("~/Common/Permission-Types") + "'>" + (String)GetGlobalResourceObject("Resource", "permissionTypes") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_COMPANY_LEAVE) == true)
                    sb.Append("<li id='liGeneralLeave'><a href='" + Page.ResolveClientUrl("~/Common/Leave-Types") + "'>" + (String)GetGlobalResourceObject("Resource", "leaves") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_HOLIDAY_LIST) == true)
                    sb.Append("<li id='liGeneralHolidays'><a href='" + Page.ResolveClientUrl("~/Common/Holidays") + "'>" + (String)GetGlobalResourceObject("Resource", "holidays") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_EMP_TYPE) == true)
                    sb.Append("<li id='liGeneralEmpType'><a href='" + Page.ResolveClientUrl("~/Common/Employee-Types") + "'>" + (String)GetGlobalResourceObject("Resource", "employeeTypes") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_REGION) == true)
                    sb.Append("<li id='liGeneralRegion'><a href='" + Page.ResolveClientUrl("~/Common/Regions") + "'>" + (String)GetGlobalResourceObject("Resource", "regions") + " </a></li>");
                sb.Append("</ul></li>");

            }


            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_ORGANIZATION) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_ORGANIZATION_TYPES) == true
                )
            {
                sb.Append("<li id='liOrg' class=''><a href='javascript:;'><i class='icon-sitemap'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "organization") + " </span>");
                sb.Append("<span class='selected'></span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu'>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_ORGANIZATION_TYPES) == true)
                    sb.Append("<li id='liOrgType'><a href='" + Page.ResolveClientUrl("~/Details/ViewOrganizationTypes.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "organizationTypes") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_ORGANIZATION) == true)
                    sb.Append("<li id='liOrgOrganization' ><a href='" + Page.ResolveClientUrl("~/Details/ViewOrganizations.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "organizations") + " </a></li>");
                sb.Append("</ul></li>");
            }

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_TYPES) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_LOCATION) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_TIME) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_ROSTER) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_ROSTER) == true 
                )
            {
                sb.Append("<li id='liSch' class=''><a href='javascript:;'><i class='icon-calendar'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "schedule") + " </span>");
                sb.Append("<span class='selected'></span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu'>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_TYPES) == true)
                    sb.Append("<li id='liSchType'><a href='" + Page.ResolveClientUrl("~/Sch/Schedule-Types") + "'>" + (String)GetGlobalResourceObject("Resource", "scheduleTypes") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_LOCATION) == true)
                    sb.Append("<li id='liSchLocation'><a href='" + Page.ResolveClientUrl("~/Sch/Schedule-Locations") + "'>" + (String)GetGlobalResourceObject("Resource", "scheduleLocations") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_TIME) == true)
                    sb.Append("<li id='liSchTime'><a href='" + Page.ResolveClientUrl("~/Sch/Schedule-Time") + "'>" + (String)GetGlobalResourceObject("Resource", "scheduleTimes") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE) == true)
                    sb.Append("<li id='liSchedules'><a href='" + Page.ResolveClientUrl("~/Sch/Schedules") + "'>" + (String)GetGlobalResourceObject("Resource", "schedules") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_ROSTER) == true)
                    sb.Append("<li id='liSchRoster'><a href='" + Page.ResolveClientUrl("~/Sch/Monthly-Roster") + "'>" + (String)GetGlobalResourceObject("Resource", "monthlyRoster") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_SCHEDULE_ROSTER) == true)
                    sb.Append("<li id='liSchViewMyRoster'><a href='" + Page.ResolveClientUrl("~/Sch/My-Schedule-Roster-View") + "'>" + (String)GetGlobalResourceObject("Resource", "sectionMonthlyRoster") + " </a></li>");
                sb.Append("</ul></li>");
            }

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_GROUP) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_GRADE) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_JOB_LIST) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_EMPLOYEE) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_EMP_LEAVE) == true 
                )
            {
                sb.Append("<li id='liEmp' class=''><a href='javascript:;'><i class='icon-group'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "employee") + " </span>");
                sb.Append("<span class='selected'></span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu'>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_GROUP) == true)
                    sb.Append("<li id='liGroup'><a href='" + Page.ResolveClientUrl("~/Emp/Employee-Groups") + "'>" + (String)GetGlobalResourceObject("Resource", "employeeGroups") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_GRADE) == true)
                    sb.Append("<li id='liEmpGrade'><a href='" + Page.ResolveClientUrl("~/Common/Grades") + "'>" + (String)GetGlobalResourceObject("Resource", "grades") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_JOB_LIST) == true)
                    sb.Append("<li id='liEmpDesignation'><a href='" + Page.ResolveClientUrl("~/Common/Designations") + "'>" + (String)GetGlobalResourceObject("Resource", "designations") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_EMPLOYEE) == true)
                    sb.Append("<li id='liEmpEmployee'><a href='" + Page.ResolveClientUrl("~/Emp/Employees") + "'>" + (String)GetGlobalResourceObject("Resource", "employees") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_EMP_LEAVE) == true)
                    sb.Append("<li id='liEmpLeave'><a href='" + Page.ResolveClientUrl("~/Leaves/Employee-Leaves") + "'>" + (String)GetGlobalResourceObject("Resource", "employeeLeaves") + " </a></li>");
                sb.Append("</ul></li>");
            }

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_TA_EVENT) == true 
                )
            {
                sb.Append("<li id='liEvents' class=''><a href='javascript:;'><i class='icon-signal'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "events") + " </span>");
                sb.Append("<span class='selected'></span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu'>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_TA_EVENT) == true)
                    sb.Append("<li id='liEventsTAEvents'><a href='" + Page.ResolveClientUrl("~/Details/ViewTAEvents.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "taEvents") + " </a></li>");
                sb.Append("</ul></li>");
            }

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_READERS) == true 
                )
            {
                sb.Append("<li id='liDevices' class=''><a href='javascript:;'><i class='icon-th-list'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "devices") + " </span>");
                sb.Append("<span class='selected'></span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu'>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_READERS) == true)
                    sb.Append("<li id='liReaderDetails'><a href='" + Page.ResolveClientUrl("~/Details/ViewReaders.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "reader") + " </a></li>");
                sb.Append("</ul></li>");
            }


            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_REPORTS) == true 
                )
            {
                sb.Append("<li id='liRpt' class=''><a href='javascript:;'><i class='icon-bar-chart'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "report") + " </span>");
                sb.Append("<span class='selected'></span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu'>");
                sb.Append("<li id='liTemplateWizard'><a href='" + Page.ResolveClientUrl("~/Reports/TemplateWizard.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "templateWizard") + " </a></li>");
                sb.Append("<li id='liReportWizard'><a href='" + Page.ResolveClientUrl("~/Reports/ReportWizard.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "generateReport") + " </a></li>");
                sb.Append("<li id='liRosterReport'><a href='" + Page.ResolveClientUrl("~/Reports/ViewRosterReport.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "monthlyRoster") + " </a></li>");
                sb.Append("</ul></li>");
            }

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_ROLE) == true ||
                new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_PRIVILEGE) == true
                )
            {
                sb.Append("<li id='liSecurity' class=''><a href='javascript:;'><i class='icon-key'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "security") + " </span>");
                sb.Append("<span class='selected'></span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu'>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_ROLE) == true)
                    sb.Append("<li id='liRoles'><a href='" + Page.ResolveClientUrl("~/Details/ViewRoles.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "roles") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_PRIVILEGE) == true)
                    sb.Append("<li id='liPrivileges'><a href='" + Page.ResolveClientUrl("~/Details/ViewPrivileges.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "privileges") + " </a></li>");
                if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.ALLOW_REPROCESS_ATTENDANCE_DATA) == true)
                    sb.Append("<li id='liPrivileges'><a href='" + Page.ResolveClientUrl("~/Details/ReProcessData.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "privileges") + " </a></li>");

                sb.Append("</ul></li>");
            }

            if (new TAMSPrivilege().IsPrivileged(TAMSPrivilege.VIEW_READERS) == true 
                )
            {
                sb.Append("<li id='liSettings'><a class='active' href='javascript:;'><i class='icon-cogs'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "settings") + " </span><span class='arrow '></span></a>");
                sb.Append("<ul class='sub-menu' style='display: none;'>");
                sb.Append("<li id='liReaders'><a href='javascript:;'>" + (String)GetGlobalResourceObject("Resource", "readers") + " <span class='arrow'></span></a></li>");
                sb.Append("<li id='liConnectionType'><a href='" + Page.ResolveClientUrl("~/Details/ViewConnectionTypes.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "connectionType") + " </a></li>");
                sb.Append("<li id='liDeviceGroup'><a href='" + Page.ResolveClientUrl("~/Details/ViewDeviceGroups.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "deviceGroup") + " </a></li>");
                sb.Append("<li id='liDeviceConnection'><a href='" + Page.ResolveClientUrl("~/Details/ViewDeviceConnections.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "deviceConnection") + " </a></li>");
                sb.Append("<li id='liPanels'><a href='" + Page.ResolveClientUrl("~/Details/ViewPanels.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "panel") + " </a></li>");
                sb.Append("<li id='liReaderType'><a href='" + Page.ResolveClientUrl("~/Details/ViewReaderTypes.aspx") + "'>" + (String)GetGlobalResourceObject("Resource", "readerType") + " </a></li>");
                sb.Append("</ul></li>");
            }

            if ((Session["rootUser"] + "").ToLower() == "true")
            {
                sb.Append("<li id='liCompany' class=''><a href='" +  Page.ResolveClientUrl("~/Admin/ViewCompanies.aspx") + "'><i class='icon-bar-chart'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "companies") + "</span>");
                sb.Append("<span class='selected'></span></a></li>");
                sb.Append("<li id='liUser' class=''><a href='" +  Page.ResolveClientUrl("~/Admin/ViewUsers.aspx") + "'><i class='icon-user'></i>");
                sb.Append("<span class='title'>" + (String)GetGlobalResourceObject("Resource", "users") + "</span>");
                sb.Append("<span class='selected'></span></a></li>");
            }
            sb.Append("</ul></div>");

            spnLeftBar.InnerHtml = sb.ToString() + "";
        }
    }
}