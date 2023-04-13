using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class TAMSPrivilege
    {
        public static int ASSIGN_ROLE { get{ return Connection.GetId("ASSIGN_ROLE"); } } 
        public static int CONFIGURE_ROLE { get{ return Connection.GetId("CONFIGURE_ROLE"); } } 
        public static int DELETE_ALL_SCHEDULES { get{ return Connection.GetId("DELETE_ALL_SCHEDULES"); } } 
        public static int DELETE_COMPANY_LEAVE { get{ return Connection.GetId("DELETE_COMPANY_LEAVE"); } } 
        public static int DELETE_CONNECTION_TYPE { get{ return Connection.GetId("DELETE_CONNECTION_TYPE"); } } 
        public static int DELETE_COUNTRY { get{ return Connection.GetId("DELETE_COUNTRY"); } } 
        public static int DELETE_DEVICE_CONNECTIONS { get{ return Connection.GetId("DELETE_DEVICE_CONNECTIONS"); } } 
        public static int DELETE_DEVICE_GROUPS { get{ return Connection.GetId("DELETE_DEVICE_GROUPS"); } } 
        public static int DELETE_EMP_LEAVE { get{ return Connection.GetId("DELETE_EMP_LEAVE"); } } 
        public static int DELETE_EMP_MOVEMENT { get{ return Connection.GetId("DELETE_EMP_MOVEMENT"); } } 
        public static int DELETE_EMP_SCHEDULE { get{ return Connection.GetId("DELETE_EMP_SCHEDULE"); } } 
        public static int DELETE_EMP_TYPE { get{ return Connection.GetId("DELETE_EMP_TYPE"); } } 
        public static int DELETE_EMPLOYEE { get{ return Connection.GetId("DELETE_EMPLOYEE"); } } 
        public static int DELETE_GRADE { get{ return Connection.GetId("DELETE_GRADE"); } } 
        public static int DELETE_GROUP { get{ return Connection.GetId("DELETE_GROUP"); } } 
        public static int DELETE_GROUP_MEMBERS { get{ return Connection.GetId("DELETE_GROUP_MEMBERS"); } } 
        public static int DELETE_GROUP_PERMISSION { get{ return Connection.GetId("DELETE_GROUP_PERMISSION"); } } 
        public static int DELETE_GRP_SCHEDULE { get{ return Connection.GetId("DELETE_GRP_SCHEDULE"); } } 
        public static int DELETE_HOLIDAY_LIST { get{ return Connection.GetId("DELETE_HOLIDAY_LIST"); } } 
        public static int DELETE_JOB_LIST { get{ return Connection.GetId("DELETE_JOB_LIST"); } } 
        public static int DELETE_LOCATIONS { get{ return Connection.GetId("DELETE_LOCATIONS"); } } 
        public static int DELETE_ORG_GRACETIME { get{ return Connection.GetId("DELETE_ORG_GRACETIME"); } } 
        public static int DELETE_ORG_SCHEDULE { get{ return Connection.GetId("DELETE_ORG_SCHEDULE"); } } 
        public static int DELETE_ORGANIZATION { get{ return Connection.GetId("DELETE_ORGANIZATION"); } } 
        public static int DELETE_ORGANIZATION_TYPES { get{ return Connection.GetId("DELETE_ORGANIZATION_TYPES"); } } 
        public static int DELETE_PANEL { get{ return Connection.GetId("DELETE_PANEL"); } } 
        public static int DELETE_PERMISSIONTYPES { get{ return Connection.GetId("DELETE_PERMISSIONTYPES"); } } 
        public static int DELETE_PRIVILEGE { get{ return Connection.GetId("DELETE_PRIVILEGE"); } } 
        public static int DELETE_READER_ALARMS { get{ return Connection.GetId("DELETE_READER_ALARMS"); } } 
        public static int DELETE_READERS { get{ return Connection.GetId("DELETE_READERS"); } } 
        public static int DELETE_REASON { get{ return Connection.GetId("DELETE_REASON"); } } 
        public static int DELETE_REGION { get{ return Connection.GetId("DELETE_REGION"); } } 
        public static int DELETE_ROLE { get{ return Connection.GetId("DELETE_ROLE"); } } 
        public static int DELETE_SCHEDULE { get{ return Connection.GetId("DELETE_SCHEDULE"); } } 
        public static int DELETE_SCHEDULE_LOCATION { get{ return Connection.GetId("DELETE_SCHEDULE_LOCATION"); } } 
        public static int DELETE_SCHEDULE_ROSTER { get{ return Connection.GetId("DELETE_SCHEDULE_ROSTER"); } } 
        public static int DELETE_SCHEDULE_TIME { get{ return Connection.GetId("DELETE_SCHEDULE_TIME"); } } 
        public static int DELETE_SCHEDULE_TYPES { get{ return Connection.GetId("DELETE_SCHEDULE_TYPES"); } } 
        public static int DELETE_SINGLE_PERMISSION { get{ return Connection.GetId("DELETE_SINGLE_PERMISSION"); } }

        public static int DELETE_SINGLE_PERMISSION_ALL { get { return Connection.GetId("DELETE_SINGLE_PERMISSION_ALL"); } } 


        public static int DELETE_TA_EVENT { get{ return Connection.GetId("DELETE_TA_EVENT"); } } 
        public static int DELETE_VIEW_READER_TYPE { get{ return Connection.GetId("DELETE_VIEW_READER_TYPE"); } } 
        public static int EDIT_ALL_SCHEDULES { get{ return Connection.GetId("EDIT_ALL_SCHEDULES"); } } 
        
        public static int EDIT_COMPANY_LEAVE { get{ return Connection.GetId("EDIT_COMPANY_LEAVE"); } } 
        public static int EDIT_CONNECTION_TYPE { get{ return Connection.GetId("EDIT_CONNECTION_TYPE"); } } 
        public static int EDIT_COUNTRY { get{ return Connection.GetId("EDIT_COUNTRY"); } } 
        public static int EDIT_DEVICE_CONNECTIONS { get{ return Connection.GetId("EDIT_DEVICE_CONNECTIONS"); } } 
        public static int EDIT_DEVICE_GROUPS { get{ return Connection.GetId("EDIT_DEVICE_GROUPS"); } } 
        public static int EDIT_EMP_LEAVE { get{ return Connection.GetId("EDIT_EMP_LEAVE"); } } 
        public static int EDIT_EMP_SCHEDULE { get{ return Connection.GetId("EDIT_EMP_SCHEDULE"); } } 
        public static int EDIT_EMP_TYPE { get{ return Connection.GetId("EDIT_EMP_TYPE"); } } 
        public static int EDIT_EMPLOYEE { get{ return Connection.GetId("EDIT_EMPLOYEE"); } } 
        public static int EDIT_GRADE { get{ return Connection.GetId("EDIT_GRADE"); } } 
        public static int EDIT_GROUP { get{ return Connection.GetId("EDIT_GROUP"); } } 
        public static int EDIT_GROUP_MEMBERS { get{ return Connection.GetId("EDIT_GROUP_MEMBERS"); } } 
        public static int EDIT_GROUP_PERMISSION { get{ return Connection.GetId("EDIT_GROUP_PERMISSION"); } } 
        public static int EDIT_GRP_SCHEDULE { get{ return Connection.GetId("EDIT_GRP_SCHEDULE"); } } 
        public static int EDIT_HOLIDAY_LIST { get{ return Connection.GetId("EDIT_HOLIDAY_LIST"); } } 
        public static int EDIT_JOB_LIST { get{ return Connection.GetId("EDIT_JOB_LIST"); } } 
        public static int EDIT_LOCATIONS { get{ return Connection.GetId("EDIT_LOCATIONS"); } } 
        public static int EDIT_ORG_GRACETIME { get{ return Connection.GetId("EDIT_ORG_GRACETIME"); } } 
        public static int EDIT_ORG_SCHEDULE { get{ return Connection.GetId("EDIT_ORG_SCHEDULE"); } } 
        public static int EDIT_ORGANIZATION { get{ return Connection.GetId("EDIT_ORGANIZATION"); } } 
        public static int EDIT_ORGANIZATION_TYPES { get{ return Connection.GetId("EDIT_ORGANIZATION_TYPES"); } } 
        public static int EDIT_PANEL { get{ return Connection.GetId("EDIT_PANEL"); } } 
        public static int EDIT_PERMISSIONTYPES { get{ return Connection.GetId("EDIT_PERMISSIONTYPES"); } } 
        public static int EDIT_PRIVILEGE { get{ return Connection.GetId("EDIT_PRIVILEGE"); } } 
        public static int EDIT_READER_ALARMS { get{ return Connection.GetId("EDIT_READER_ALARMS"); } } 
        public static int EDIT_READERS { get{ return Connection.GetId("EDIT_READERS"); } } 
        public static int EDIT_REASON { get{ return Connection.GetId("EDIT_REASON"); } } 
        public static int EDIT_REGION { get{ return Connection.GetId("EDIT_REGION"); } } 
        public static int EDIT_ROLE { get{ return Connection.GetId("EDIT_ROLE"); } } 
        public static int EDIT_SCHEDULE { get{ return Connection.GetId("EDIT_SCHEDULE"); } } 
        public static int EDIT_SCHEDULE_LOCATION { get{ return Connection.GetId("EDIT_SCHEDULE_LOCATION"); } } 
        public static int EDIT_SCHEDULE_ROSTER { get{ return Connection.GetId("EDIT_SCHEDULE_ROSTER"); } } 
        public static int EDIT_SCHEDULE_TIME { get{ return Connection.GetId("EDIT_SCHEDULE_TIME"); } } 
        public static int EDIT_SCHEDULE_TYPES { get{ return Connection.GetId("EDIT_SCHEDULE_TYPES"); } } 
        public static int EDIT_SINGLE_PERMISSION { get{ return Connection.GetId("EDIT_SINGLE_PERMISSION"); } } 
        public static int EDIT_TA_EVENT { get{ return Connection.GetId("EDIT_TA_EVENT"); } } 
        public static int EDIT_VIEW_READER_TYPE { get{ return Connection.GetId("EDIT_VIEW_READER_TYPE"); } } 
        public static int INSERT_ALL_SCHEDULES { get{ return Connection.GetId("INSERT_ALL_SCHEDULES"); } } 
        public static int INSERT_COMPANY_LEAVE { get{ return Connection.GetId("INSERT_COMPANY_LEAVE"); } } 
        public static int INSERT_CONNECTION_TYPE { get{ return Connection.GetId("INSERT_CONNECTION_TYPE"); } } 
        public static int INSERT_COUNTRY { get{ return Connection.GetId("INSERT_COUNTRY"); } } 
        public static int INSERT_DEVICE_CONNECTIONS { get{ return Connection.GetId("INSERT_DEVICE_CONNECTIONS"); } } 
        public static int INSERT_DEVICE_GROUPS { get{ return Connection.GetId("INSERT_DEVICE_GROUPS"); } } 
        public static int INSERT_EMP_LEAVE { get{ return Connection.GetId("INSERT_EMP_LEAVE"); } } 
        public static int INSERT_EMP_MOVEMENT { get{ return Connection.GetId("INSERT_EMP_MOVEMENT"); } } 
        public static int INSERT_EMP_SCHEDULE { get{ return Connection.GetId("INSERT_EMP_SCHEDULE"); } } 
        public static int INSERT_EMP_TYPE { get{ return Connection.GetId("INSERT_EMP_TYPE"); } } 
        public static int INSERT_EMPLOYEE { get{ return Connection.GetId("INSERT_EMPLOYEE"); } } 
        public static int INSERT_GRADE { get{ return Connection.GetId("INSERT_GRADE"); } } 
        public static int INSERT_GROUP { get{ return Connection.GetId("INSERT_GROUP"); } } 
        public static int INSERT_GROUP_MEMBERS { get{ return Connection.GetId("INSERT_GROUP_MEMBERS"); } } 
        public static int INSERT_GROUP_PERMISSION { get{ return Connection.GetId("INSERT_GROUP_PERMISSION"); } } 
        public static int INSERT_GRP_SCHEDULE { get{ return Connection.GetId("INSERT_GRP_SCHEDULE"); } } 
        public static int INSERT_HOLIDAY_LIST { get{ return Connection.GetId("INSERT_HOLIDAY_LIST"); } } 
        public static int INSERT_JOB_LIST { get{ return Connection.GetId("INSERT_JOB_LIST"); } } 
        public static int INSERT_LOCATIONS { get{ return Connection.GetId("INSERT_LOCATIONS"); } } 
        public static int INSERT_ORG_GRACETIME { get{ return Connection.GetId("INSERT_ORG_GRACETIME"); } } 

        public static int INSERT_ORG_SCHEDULE { get{ return Connection.GetId("INSERT_ORG_SCHEDULE"); } } 
        
        public static int INSERT_ORGANIZATION { get{ return Connection.GetId("INSERT_ORGANIZATION"); } } 
        
        public static int INSERT_ORGANIZATION_TYPES { get{ return Connection.GetId("INSERT_ORGANIZATION_TYPES"); } } 
        public static int INSERT_PANEL { get{ return Connection.GetId("INSERT_PANEL"); } } 
        public static int INSERT_PERMISSIONTYPES { get{ return Connection.GetId("INSERT_PERMISSIONTYPES"); } } 
        public static int INSERT_PRIVILEGE { get{ return Connection.GetId("INSERT_PRIVILEGE"); } } 
        public static int INSERT_READER_ALARMS { get{ return Connection.GetId("INSERT_READER_ALARMS"); } } 
        public static int INSERT_READERS { get{ return Connection.GetId("INSERT_READERS"); } } 
        public static int INSERT_REASON { get{ return Connection.GetId("INSERT_REASON"); } } 
        public static int INSERT_REGION { get{ return Connection.GetId("INSERT_REGION"); } } 
        public static int INSERT_ROLE { get{ return Connection.GetId("INSERT_ROLE"); } } 
        public static int INSERT_SCHEDULE { get{ return Connection.GetId("INSERT_SCHEDULE"); } } 
        public static int INSERT_SCHEDULE_LOCATION { get{ return Connection.GetId("INSERT_SCHEDULE_LOCATION"); } } 
        public static int INSERT_SCHEDULE_ROSTER { get{ return Connection.GetId("INSERT_SCHEDULE_ROSTER"); } } 
        public static int INSERT_SCHEDULE_TIME { get{ return Connection.GetId("INSERT_SCHEDULE_TIME"); } } 
        public static int INSERT_SCHEDULE_TYPES { get{ return Connection.GetId("INSERT_SCHEDULE_TYPES"); } } 
        public static int INSERT_SINGLE_PERMISSION { get{ return Connection.GetId("INSERT_SINGLE_PERMISSION"); } } 
        public static int INSERT_TA_EVENT { get{ return Connection.GetId("INSERT_TA_EVENT"); } } 
        public static int INSERT_VIEW_READER_TYPE { get{ return Connection.GetId("INSERT_VIEW_READER_TYPE"); } } 
        public static int MODIFY_READEROPERATIONS { get{ return Connection.GetId("MODIFY_READEROPERATIONS"); } } 
        public static int PERMISSION_APPROVAL { get{ return Connection.GetId("PERMISSION_APPROVAL"); } } 
        public static int PROCESS_VERIFICATION { get{ return Connection.GetId("PROCESS_VERIFICATION"); } } 
        public static int SINGLE_PERMISSION_EMAIL_NOTIFICATION { get{ return Connection.GetId("SINGLE_PERMISSION_EMAIL_NOTIFICATION"); } } 
        public static int SYNCHRONIZE_TAMS { get{ return Connection.GetId("SYNCHRONIZE_TAMS"); } } 
        public static int VERIFY_VIOLATION { get{ return Connection.GetId("VERIFY_VIOLATION"); } } 
        public static int VIEW_ALL_SCHEDULES { get{ return Connection.GetId("VIEW_ALL_SCHEDULES"); } } 
        public static int VIEW_APPLICATION_SETTINGS { get{ return Connection.GetId("VIEW_APPLICATION_SETTINGS"); } } 
        public static int VIEW_COMPANY_LEAVE { get{ return Connection.GetId("VIEW_COMPANY_LEAVE"); } } 
        public static int VIEW_CONNECTION_TYPE { get{ return Connection.GetId("VIEW_CONNECTION_TYPE"); } } 
        public static int VIEW_COUNTRY { get{ return Connection.GetId("VIEW_COUNTRY"); } } 
        public static int VIEW_DEVICE_CONNECTIONS { get{ return Connection.GetId("VIEW_DEVICE_CONNECTIONS"); } } 
        public static int VIEW_DEVICE_GROUPS { get{ return Connection.GetId("VIEW_DEVICE_GROUPS"); } } 
        public static int VIEW_EMP_LEAVE { get{ return Connection.GetId("VIEW_EMP_LEAVE"); } } 
        public static int VIEW_EMP_MOVEMENT { get{ return Connection.GetId("VIEW_EMP_MOVEMENT"); } } 
        public static int VIEW_EMP_SCHEDULE { get{ return Connection.GetId("VIEW_EMP_SCHEDULE"); } } 
        public static int VIEW_EMP_TYPE { get{ return Connection.GetId("VIEW_EMP_TYPE"); } } 
        public static int VIEW_EMPLOYEE { get{ return Connection.GetId("VIEW_EMPLOYEE"); } } 
        public static int VIEW_GRADE { get{ return Connection.GetId("VIEW_GRADE"); } } 

        public static int VIEW_GROUP { get{ return Connection.GetId("VIEW_GROUP"); } } 
        public static int VIEW_GROUP_MEMBERS { get{ return Connection.GetId("VIEW_GROUP_MEMBERS"); } } 
        public static int VIEW_GROUP_PERMISSION { get{ return Connection.GetId("VIEW_GROUP_PERMISSION"); } } 
        public static int VIEW_GRP_SCHEDULE { get{ return Connection.GetId("VIEW_GRP_SCHEDULE"); } } 

        public static int VIEW_HOLIDAY_LIST { get{ return Connection.GetId("VIEW_HOLIDAY_LIST"); } } 
        public static int VIEW_JOB_LIST { get{ return Connection.GetId("VIEW_JOB_LIST"); } } 
        public static int VIEW_LOCATIONS { get{ return Connection.GetId("VIEW_LOCATIONS"); } } 

        public static int VIEW_ORG_GRACETIME { get{ return Connection.GetId("VIEW_ORG_GRACETIME"); } } 
        public static int VIEW_ORG_SCHEDULE { get{ return Connection.GetId("VIEW_ORG_SCHEDULE"); } } 
        public static int VIEW_ORGANIZATION { get{ return Connection.GetId("VIEW_ORGANIZATION"); } } 
        public static int VIEW_ORGANIZATION_TYPES { get{ return Connection.GetId("VIEW_ORGANIZATION_TYPES"); } }

        public static int VIEW_REASON { get{ return Connection.GetId("VIEW_REASON"); } } 
        public static int VIEW_REGION { get{ return Connection.GetId("VIEW_REGION"); } }

        public static int VIEW_REPORTS { get { return Connection.GetId("VIEW_REPORTS"); } }

        public static int VIEW_OVERTIME { get { return Connection.GetId("VIEW_OVERTIME"); } }
        public static int APPLY_OVERTIME { get { return Connection.GetId("APPLY_OVERTIME"); } }
        public static int APPROVE_OVERTIME { get { return Connection.GetId("APPROVE_OVERTIME"); } }
        public static int APPROVED_OVERTIME_PROCESS { get { return Connection.GetId("APPROVED_OVERTIME_PROCESS"); } }


        public static int VIEW_DEPT_ADMIN { get { return Connection.GetId("VIEW_DEPT_ADMIN"); } }
        public static int INSERT_DEPT_ADMIN { get { return Connection.GetId("INSERT_DEPT_ADMIN"); } }
        public static int EDIT_DEPT_ADMIN { get { return Connection.GetId("EDIT_DEPT_ADMIN"); } }
        public static int DELETE_DEPT_ADMIN { get { return Connection.GetId("DELETE_DEPT_ADMIN"); } }


        public static int VIEW_SENIOR_EMPLOYEE { get { return Connection.GetId("VIEW_SENIOR_EMPLOYEE"); } }
        public static int INSERT_SENIOR_EMPLOYEE { get { return Connection.GetId("INSERT_SENIOR_EMPLOYEE"); } }
        public static int DELETE_SENIOR_EMPLOYEE { get { return Connection.GetId("DELETE_SENIOR_EMPLOYEE"); } }


        public static int INCLUDE_INACTIVE_STAFF_IN_REPORTS { get { return Connection.GetId("INCLUDE_INACTIVE_STAFF_IN_REPORTS"); } }

        public static int REPORT_EXPORT_PDF { get { return Connection.GetId("REPORT_EXPORT_PDF"); } }
        public static int REPORT_EXPORT_WORD { get { return Connection.GetId("REPORT_EXPORT_WORD"); } }
        public static int REPORT_EXPORT_EXCEL { get { return Connection.GetId("REPORT_EXPORT_EXCEL"); } }


        public static int VIEW_TEAM_EFFICIENCY { get { return Connection.GetId("VIEW_TEAM_EFFICIENCY"); } }
        public static int VIEW_DATA_PROCESS_ACTIVITY { get { return Connection.GetId("VIEW_DATA_PROCESS_ACTIVITY"); } }


        public static int VIEW_REPORT_FILTER_EMPLOYEE_TYPE { get { return Connection.GetId("VIEW_REPORT_FILTER_EMPLOYEE_TYPE"); } }


        public static int VIEW_REPORT_FILTER_EMPLOYEE_GROUP { get { return Connection.GetId("VIEW_REPORT_FILTER_EMPLOYEE_GROUP"); } }

        public static int VIEW_PI_REPORTS { get { return Connection.GetId("VIEW_PI_REPORTS"); } }

        public static int VIEW_VERIFICATION_WIDGET { get { return Connection.GetId("VIEW_VERIFICATION_WIDGET"); } }

        public static int VIEW_ATTENDANCE_ACTIVITY { get { return Connection.GetId("VIEW_ATTENDANCE_ACTIVITY"); } }
        public static int VIEW_TEAM_STATISTICS { get { return Connection.GetId("VIEW_TEAM_STATISTICS"); } }

        public static int EDIT_FINALIZED_ROSTER { get { return Connection.GetId("EDIT_FINALIZED_ROSTER"); } }
        public static int TREND_VIOLATION_DRILLDOWN_WIDGET { get { return Connection.GetId("TREND_VIOLATION_DRILLDOWN_WIDGET"); } }

        public static int TREND_VIOLATION_WIDGET { get { return Connection.GetId("TREND_VIOLATION_WIDGET"); } }

        public static int VIEW_SYSTEM_SUPPORT { get { return Connection.GetId("VIEW_SYSTEM_SUPPORT"); } }
        public static int BUSINESS_INTELLIGENCE { get { return Connection.GetId("BUSINESS_INTELLIGENCE"); } }
        public static int TIMECHECK_MOBILE { get { return Connection.GetId("TIMECHECK_MOBILE"); } }


        public static int VIEW_INACTIVE_ORGANIZATION { get { return Connection.GetId("VIEW_INACTIVE_ORGANIZATION"); } }

        //public static int LIVE_ACTIVITY_WIDGET { get { return Connection.GetId("LIVE_ACTIVITY_WIDGET"); } }
        public static int VIEW_APPROVAL { get { return Connection.GetId("VIEW_APPROVAL"); } }
        public static int VIEW_PENDING_APPROVAL { get { return Connection.GetId("VIEW_PENDING_APPROVAL"); } }


        public static int VIEW_MONTH_LOCK { get { return Connection.GetId("VIEW_MONTH_LOCK"); } }
        public static int INSERT_MONTH_LOCK { get { return Connection.GetId("INSERT_MONTH_LOCK"); } }
        public static int DELETE_MONTH_LOCK { get { return Connection.GetId("DELETE_MONTH_LOCK"); } }

        public static int VIEW_APP_LICENSE { get { return Connection.GetId("VIEW_APP_LICENSE"); } }
        public static int VIEW_DASHBOARD_FILTERS { get { return Connection.GetId("VIEW_DASHBOARD_FILTERS"); } }

        public static int VIEW_DASHBOARD_MAP { get { return Connection.GetId("VIEW_DASHBOARD_MAP"); } }

        public static int VIEW_ACTIVITY_MONITOR { get { return Connection.GetId("VIEW_ACTIVITY_MONITOR"); } }

        public static int VIEW_MY_PENDING_REQUESTS { get { return Connection.GetId("VIEW_MY_PENDING_REQUESTS"); } }

        public static int VIEW_TEAM_DASHBOARD { get { return Connection.GetId("VIEW_TEAM_DASHBOARD"); } }

        public static int VIEW_HR_ONLY_PERMISSION_TYPES { get { return Connection.GetId("VIEW_HR_ONLY_PERMISSION_TYPES"); } }



        public static int VIEW_WORKFLOWS { get { return Connection.GetId("VIEW_WORKFLOWS"); } }
        public static int ADD_WORKFLOWS { get { return Connection.GetId("ADD_WORKFLOWS"); } }
        public static int EDIT_WORKFLOWS { get { return Connection.GetId("EDIT_WORKFLOWS"); } }
        public static int DELETE_WORKFLOWS { get { return Connection.GetId("DELETE_WORKFLOWS"); } }



        public static int CANCEL_PERMISSION_APPROVAL { get { return Connection.GetId("CANCEL_PERMISSION_APPROVAL"); } } 
         
        
        #region SINGLE / PERSONAL / PERMISSION / LEAVE / APPROVAL Related Privileges
        /// <summary>
        /// In this section you'll find all privileges related to PERMISSION
        /// </summary>


        public static int LEAVE_APPROVAL { get { return Connection.GetId("LEAVE_APPROVAL"); } }

        public static int VERIFICATION_APPROVAL { get { return Connection.GetId("VERIFICATION_APPROVAL"); } }
        public static int CANCEL_APPROVED_VERIFICATION { get { return Connection.GetId("CANCEL_APPROVED_VERIFICATION"); } }

        public static int VIEW_PERMISSIONTYPES { get { return Connection.GetId("VIEW_PERMISSIONTYPES"); } } 
        public static int VIEW_SINGLE_PERMISSION { get { return Connection.GetId("VIEW_SINGLE_PERMISSION"); } } 

        #endregion



        #region Movement / TA / Events Privileges
        /// <summary>
        /// In this section you'll find all privileges related to Schedule
        /// </summary>
        public static int VIEW_TA_EVENT { get { return Connection.GetId("VIEW_TA_EVENT"); } }

        #endregion



        #region Schedule / Roster / Location / Time / Type Privileges
        /// <summary>
        /// In this section you'll find all privileges related to Schedule
        /// </summary>
        public static int VIEW_SCHEDULE { get { return Connection.GetId("VIEW_SCHEDULE"); } }
        public static int VIEW_SCHEDULE_LOCATION { get { return Connection.GetId("VIEW_SCHEDULE_LOCATION"); } }

        public static int VIEW_MY_SCHEDULE_ROSTER { get { return Connection.GetId("VIEW_MY_SCHEDULE_ROSTER"); } }
        public static int VIEW_SCHEDULE_ROSTER { get { return Connection.GetId("VIEW_SCHEDULE_ROSTER"); } }

        public static int APPLY_SCHEDULE_ROSTER { get { return Connection.GetId("APPLY_SCHEDULE_ROSTER"); } }
        public static int APPROVE_SCHEDULE_ROSTER { get { return Connection.GetId("APPROVE_SCHEDULE_ROSTER"); } }


        public static int VIEW_SCHEDULE_TIME { get { return Connection.GetId("VIEW_SCHEDULE_TIME"); } }
        public static int VIEW_SCHEDULE_TYPES { get { return Connection.GetId("VIEW_SCHEDULE_TYPES"); } }

        #endregion


        #region SHARE ROSTER Privileges
        /// <summary>
        /// In this section you'll find all privileges related to SHARE ROSTER 
        /// </summary>
        /// 
        public static int VIEW_SHARE_ROSTER { get { return Connection.GetId("VIEW_SHARE_ROSTER"); } }
        public static int INSERT_SHARE_ROSTER { get { return Connection.GetId("INSERT_SHARE_ROSTER"); } }
        public static int EDIT_SHARE_ROSTER { get { return Connection.GetId("EDIT_SHARE_ROSTER"); } }
        public static int DELETE_SHARE_ROSTER { get { return Connection.GetId("DELETE_SHARE_ROSTER"); } } 

        #endregion

        #region Device Related Privileges
        /// <summary>
        /// In this section you'll find all privileges related to REPORT TEMPLATE
        /// </summary>
        public static int VIEW_PANEL { get { return Connection.GetId("VIEW_PANEL"); } }
        public static int VIEW_READER_ALARMS { get { return Connection.GetId("VIEW_READER_ALARMS"); } }
        public static int VIEW_READER_TYPE { get { return Connection.GetId("VIEW_READER_TYPE"); } }
        public static int VIEW_READERS { get { return Connection.GetId("VIEW_READERS"); } } 
        
        #endregion


        
        #region REPORT TEMPLATE
        /// <summary>
        /// In this section you'll find all privileges related to REPORT TEMPLATE
        /// </summary>
        public static int VIEW_REPORT_TEMPLATE { get { return Connection.GetId("VIEW_REPORT_TEMPLATE"); } }
        public static int INSERT_REPORT_TEMPLATE { get { return Connection.GetId("INSERT_REPORT_TEMPLATE"); } }
        public static int EDIT_REPORT_TEMPLATE { get { return Connection.GetId("EDIT_REPORT_TEMPLATE"); } }
        public static int DELETE_REPORT_TEMPLATE { get { return Connection.GetId("DELETE_REPORT_TEMPLATE"); } }
        
        #endregion



        #region Delegate Privileges
        /// <summary>
        /// In this section you'll find all privileges related to Delegate Privileges
        /// </summary>
        public static int VIEW_DELEGATE { get { return Connection.GetId("VIEW_DELEGATE"); } }
        public static int INSERT_DELEGATE { get { return Connection.GetId("INSERT_DELEGATE"); } }
        public static int EDIT_DELEGATE { get { return Connection.GetId("EDIT_DELEGATE"); } }
        public static int DELETE_DELEGATE { get { return Connection.GetId("DELETE_DELEGATE"); } }

        #endregion



        #region System Related Privileges
        /// <summary>
        /// In this section you'll find all privileges related to REPORT TEMPLATE  
        /// </summary>
        /// 
        public static int EDIT_APPLICATION_SETTINGS { get { return Connection.GetId("EDIT_APPLICATION_SETTINGS"); } } 

        public static int VIEW_ROLE { get { return Connection.GetId("VIEW_ROLE"); } }
        public static int VIEW_LOGIN_LOG { get { return Connection.GetId("VIEW_LOGIN_LOG"); } }
        public static int VIEW_PRIVILEGE { get { return Connection.GetId("VIEW_PRIVILEGE"); } }
        public static int DB_CONSOLE { get { return Connection.GetId("DB_CONSOLE"); } }

        #endregion



        #region Dashboard/Home Screen Privileges
        /// <summary>
        /// In this section you'll find all privileges related to dashboard
        /// </summary>
        public static int DASHBOARD_WIDGET { get { return Connection.GetId("DASHBOARD_WIDGET"); } }
        public static int VIEW_VIOLATION { get { return Connection.GetId("VIEW_VIOLATION"); } }

        #endregion



        #region WEB PUNCH EXCEPTION LIST Privileges
        /// <summary>
        /// In this section you'll find all privileges related to WEB PUNCH EXCEPTION LIST Privileges
        /// </summary>
        public static int VIEW_WEBPUNCH_EXCEPTION_LIST { get { return Connection.GetId("VIEW_WEBPUNCH_EXCEPTION_LIST"); } }
        public static int INSERT_WEBPUNCH_EXCEPTION_LIST { get { return Connection.GetId("INSERT_WEBPUNCH_EXCEPTION_LIST"); } }
        public static int EDIT_WEBPUNCH_EXCEPTION_LIST { get { return Connection.GetId("EDIT_WEBPUNCH_EXCEPTION_LIST"); } }
        public static int DELETE_WEBPUNCH_EXCEPTION_LIST { get { return Connection.GetId("DELETE_WEBPUNCH_EXCEPTION_LIST"); } }

        #endregion



        #region RAMADAN DATE RANGE Privileges
        /// <summary>
        /// In this section you'll find all privileges related to RAMADAN DATE RANGE Privileges
        /// </summary>
        public static int VIEW_RAMADAN_DATE_RANGE { get { return Connection.GetId("VIEW_RAMADAN_DATE_RANGE"); } }
        public static int INSERT_RAMADAN_DATE_RANGE { get { return Connection.GetId("INSERT_RAMADAN_DATE_RANGE"); } }
        public static int EDIT_RAMADAN_DATE_RANGE { get { return Connection.GetId("EDIT_RAMADAN_DATE_RANGE"); } }
        public static int DELETE_RAMADAN_DATE_RANGE { get { return Connection.GetId("DELETE_RAMADAN_DATE_RANGE"); } }

        #endregion



        #region MANUAL TRANSACTIONS Privileges
        /// <summary>
        /// In this section you'll find all privileges related to MANUAL TRANSACTIONS Privileges
        /// </summary>
        public static int VIEW_EMP_MANUAL_MOVEMENT { get { return Connection.GetId("VIEW_EMP_MANUAL_MOVEMENT"); } }
        public static int INSERT_EMP_MANUAL_MOVEMENT { get { return Connection.GetId("INSERT_EMP_MANUAL_MOVEMENT"); } }
        public static int EDIT_EMP_MANUAL_MOVEMENT { get { return Connection.GetId("EDIT_EMP_MANUAL_MOVEMENT"); } }
        public static int DELETE_EMP_MANUAL_MOVEMENT { get { return Connection.GetId("DELETE_EMP_MANUAL_MOVEMENT"); } }
        public static int ALLOW_TRANSACTION_TIME_EMP_MANUAL_MOVEMENT { get { return Connection.GetId("ALLOW_TRANSACTION_TIME_EMP_MANUAL_MOVEMENT"); } }

        
        #endregion
       


        #region  ALLOW REPROCESS ATTENDANCE DATA
        /// <summary>
        /// In this section you'll find all privileges related to ALLOW_REPROCESS_ATTENDANCE_DATA Privileges
        /// </summary>
        public static int ALLOW_REPROCESS_ATTENDANCE_DATA { get { return Connection.GetId("ALLOW_REPROCESS_ATTENDANCE_DATA"); } }
          
        #endregion



        #region  VIEW MANUAL TRANSACTIONS
        /// <summary>
        /// In this section you'll find all privileges related to ALLOW_REPROCESS_ATTENDANCE_DATA Privileges
        /// </summary>
        public static int VIEW_MANUAL_TRANSACTION { get { return Connection.GetId("VIEW_MANUAL_TRANSACTION"); } }

        #endregion
        

        
        #region  ADD MANUAL TRANSACTIONS
        /// <summary>
        /// In this section you'll find all privileges related to ADD_MANUAL_TRANSACTIONS Privileges
        /// </summary>
        public static int ADD_MANUAL_TRANSACTION { get { return Connection.GetId("ADD_MANUAL_TRANSACTIONS"); } }

        #endregion        
        


        #region  DELETE MANUAL TRANSACTIONS
        /// <summary>
        /// In this section you'll find all privileges related to DELETE_MANUAL_TRANSACTIONS Privileges
        /// </summary>
        public static int DELETE_MANUAL_TRANSACTION { get { return Connection.GetId("DELETE_MANUAL_TRANSACTIONS"); } }

        #endregion        
        

        
        #region  APPROVE MANUAL TRANSACTIONS
        /// <summary>
        /// In this section you'll find all privileges related to APPROVE_MANUAL_TRANSACTIONS Privileges
        /// </summary>
        public static int APPROVE_MANUAL_TRANSACTION { get { return Connection.GetId("APPROVE_MANUAL_TRANSACTIONS"); } }

        #endregion     
        
        
        
        #region  APPROVE_MISSING_TRANSACTIONS
        /// <summary>
        /// In this section you'll find all privileges related to APPROVE_MISSING_TRANSACTIONS Privileges
        /// </summary>
        public static int APPROVE_MISSING_TRANSACTIONS { get { return Connection.GetId("APPROVE_MISSING_TRANSACTIONS"); } }
        #endregion
        
        #region  VIEW_MISSING_TRANSACTIONS
        /// <summary>
        /// In this section you'll find all privileges related to APPROVE_MISSING_TRANSACTIONS Privileges
        /// </summary>
        public static int VIEW_MISSING_TRANSACTIONS { get { return Connection.GetId("VIEW_MISSING_TRANSACTIONS"); } }
        #endregion     
        
        
        #region  APPLY/APPROVE EMPLOYEE SCHEDULE WORKFLOW
        /// <summary>
        /// In this section you'll find all privileges related to APPLY/APPROVE EMPLOYEE SCHEDULE WORKFLOW Privileges
        /// </summary>
        public static int APPLY_EMPLOYEE_SCHEDULE { get { return Connection.GetId("APPLY_EMPLOYEE_SCHEDULE"); } }
        public static int APPROVE_EMPLOYEE_SCHEDULE { get { return Connection.GetId("APPROVE_EMPLOYEE_SCHEDULE"); } }

        #endregion     
        

        
        #region  APPLY/APPROVE EMPLOYEE SCHEDULE WORKFLOW
        /// <summary>
        /// In this section you'll find all privileges related to APPLY/APPROVE EMPLOYEE SCHEDULE WORKFLOW Privileges
        /// </summary>
        public static int View_Data_Synchronization { get { return Connection.GetId("View_Data_Synchronization"); } }
        //public static int APPROVE_EMPLOYEE_SCHEDULE { get { return Connection.GetId("APPROVE_EMPLOYEE_SCHEDULE"); } }

        #endregion     



        #region Public Method: IsPrivileged(int nPrivilegeID)
        /// <summary>
        /// Return True if the user has the given privilege
        /// </summary>
        /// <param name="nPrivilegeID">Privilege ID</param>
        /// <returns>True if privileged</returns>
        public bool IsPrivileged(int nPrivilegeID)
        {
            bool privilgeFlag = false;
            int count = 0;
            string strQuery;
            TAMSR2Data objDAL = new TAMSR2Data();
            try
            {
                Hashtable ht;
                ht = new Hashtable();
                ht.Add("action", "getPrivilegeIDByUser");
                ht.Add("privilegeID", nPrivilegeID);
                ht.Add("sessionID", HttpContext.Current.Session["ID"] + "");
                objDAL.OpenConnection(Connection.GetConnectionStrinng(HttpContext.Current.Session["dbType"] + "", HttpContext.Current.Session["dbName"] + "", HttpContext.Current.Session["dbUser"] + "", HttpContext.Current.Session["dbPassword"] + ""));
                count = Numerics.GetInt(objDAL.Connection.GetValueProcedure("TAMSR2_SecUserOps", ht));
            }
            catch (Exception e)
            {
                //throw new NeSTTechLogException("UserState.IsPrivileged() Failed", e);
            }
            finally
            {
                objDAL.CloseConnection();
            }
            if (nPrivilegeID == 31181)
                nPrivilegeID = 31181;

            string temp = HttpContext.Current.Session["privileges"] + "";
            if (temp.Contains(","))
            {
                if (temp.Split(',').FirstOrDefault(p => p == (nPrivilegeID + "")) != null)
                {
                    count = 1;
                }

            }
            privilgeFlag = Convert.ToBoolean(count);

            return privilgeFlag;
        }
        #endregion	



        
    
        

    }
}
