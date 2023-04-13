﻿var arr = [];
arr.push({col:"employee_id"                        , description : "Employee Id (Timecheck)"});         
arr.push({col:"Transaction_date"                   , description : "Transaction date " });
arr.push({col:"employee_code"                      , description : "Staff number (ERP)" });
arr.push({col:"IsSenior"                           , description : "Flag (set to 1 if employee is member of 'Seniors' group)"});
arr.push({col:"EmployeeID_Name_English"            , description : "Employee Code and Name (english)"});
arr.push({col:"EmployeeID_Name_Arabic"             , description : "Employee Code and Name (arabic)"});
arr.push({col:"EmployeeID_Name_English_Desig"      , description : "Employee Code, Name and Designation(english)"});
arr.push({col:"EmployeeID_Name_Arabic_Desig"       , description : "Employee Code, Name and Designation(arabic)"});
arr.push({col:"Employee_Name_English"              , description : "Employee Name (english)"});
arr.push({col:"Employee_Name_Arabic"               , description : "Employee Name (arabic)"});
arr.push({col:"organization_id"                    , description : "Organization_id (local reference key)"});
arr.push({col:"OrgOpenShift"                       , description : "Flag (set to 1 if organization open shift flag is set to 'true')"});
arr.push({col:"Organization_Code"                  , description : "Organization Code (ERP)"});
arr.push({col:"OrganizationID_Name_English"        , description : "Organization Code and Description (english)"});
arr.push({col:"OrganizationID_Name_Arabic"         , description : "Organization Code and Description (arabic)"});
arr.push({col:"Organization_Name_English"          , description : "Organization Description (english)"});
arr.push({col:"Region_Code"                        , description : "Region Code (ERP)"});
arr.push({col:"Region_Description_Eng"             , description : "Region Decription (english)"});
arr.push({col:"Region_Description_Arb"             , description : "Region Description (arabic)"});
arr.push({col:"Grade_Code"                         , description : "Grade Code (ERP)"});
arr.push({col:"Grade_description_English"          , description : "Grade Description (english)"});
arr.push({col:"Grade_description_Arabic"           , description : "Grade Description (arabic)"});
arr.push({col:"Designation_Code"                   , description : "Designation Code (ERP)"});
arr.push({col:"Designation_Name_English"           , description : "Designation Description (english)"});
arr.push({col:"Designation_Name_Arabic"            , description : "Desgination Description (arabic)"});
arr.push({col:"Nationality_Code"                   , description : "Nationality Code (ERP)"});
arr.push({col:"Nation_Name_English"                , description : "Nationality Description (english)"});
arr.push({col:"Nation_Name_Arabic"                 , description : "Nationality Description (arabic)"});
arr.push({col:"Is_Manager"                         , description : "Flag(if employee is manager then it will be 'Y')"});
arr.push({col: "email"                             , description : "employee email" });
arr.push({col: "Join_Date "                        , description : "employee join date" });
arr.push({col:"inactive_date"                      , description : "employee inactive date"});
arr.push({col:"Schedule_code"                      , description : "Schedule code (employee assigned schedule code)"});
arr.push({col:"Schedule_Type_DESC_English "        , description : "Schedule Type Description (english)"});
arr.push({col:"Schedule_Type_DESC_Arabic"          , description : "Schedule Type Description (arabic)"});
arr.push({col:"Shift_1_Schedule_In"                , description : "First Shift Start Time"});
arr.push({col:"Shift_1_Schedule_Out"               , description : "First Shift End Time"});
arr.push({col:"Shift_2_Schedule_In"                , description : "Second Shift Start Time"});
arr.push({col:"Shift_2_Schedule_Out"               , description : "Second Shift End Time"});
arr.push({col:"Shift_3_Schedule_In"                , description : "Third Shift Start Time"});
arr.push({col:"Shift_3_Schedule_Out"               , description : "Third Shift End Time"});
arr.push({col:"Flexible_minutes"                   , description : "Schedule Flexible time"});
arr.push({col:"Grace_In_minutes"                   , description : "Grace time for entry"});
arr.push({col:"Grace_Out_minutes"                  , description : "Grace time for exit"});
arr.push({col:"Punch_In"                           , description : "Employee Entry Punch"});
arr.push({col:"Punch_Out"                          , description : "Employee Exit Punch"});
arr.push({col:"Punch_In_Type_Code"                 , description : "Entry Punch Reason code"});
arr.push({col:"Punch_In_Type_English"              , description : "Entry Punch Reason description (english)"});
arr.push({col:"Punch_In_Type_Arabic"               , description : "Entry Punch Reason description (arabic)"});
arr.push({col:"Punch_Out_Type_Code"                , description : "Exit Punch Reason code"});
arr.push({col:"Punch_Out_Type_English"             , description : "Exit Punch Reason description (english)"});
arr.push({col:"Punch_Out_Type_Arabic"              , description : "Exit Punch Reason description (arabic)"});
arr.push({col:"Punch_In_Reader_Code"               , description : "Entry Device Code"});
arr.push({col:"Punch_In_Reader_Name_English"       , description : "Entry Device Description (english)"});
arr.push({col:"Punch_In_Reader_Name_Arabic "       , description : "Entry Device Description (arabic)"});
arr.push({col:"Punch_Out_Reader_Code"              , description : "Exit Device Code"});
arr.push({col:"Punch_Out_Reader_Name_English"      , description : "Exit Device Description (english)"});
arr.push({col:"Punch_Out_Reader_Name_Arabic"       , description : "Exit Device Description (arabic)"});
arr.push({col:"Holiday_Status"                     , description : "Flag('Holiday' if its public holiday defined in system)"});
arr.push({col:"RestDay_Status"                     , description : "Flag ('Day Off' if there is no schedule defined for employee)"});
arr.push({col:"Leave_Status"                       , description : "Flag ('Leave' if employee has leave reacord)"});
arr.push({col:"Day_Status"                         , description : "Decription for status whether absent, full day permission, leave or holiday"});
arr.push({col:"Shift1_Status"                      , description : "Not available"});
arr.push({col:"Shift2_Status"                      , description : "Not available"});
arr.push({col:"Shift3_Status"                      , description : "Not available"});
arr.push({col:"Absent_Minutes"                     , description : "Absent minutes based on schedule "});
arr.push({col:"Comment_English"                    , description : "comments (english) based on day status (absent, leave, holiday, permission)"});
arr.push({col:"Comment_Arabic"                     , description : "comments (arabic) based on day status (absent, leave, holiday, permission)"});
arr.push({col:"Remarks_English"                    , description : "remarks (english) based on (leave description, permission description or holiday description)"});
arr.push({col:"Remarks_Arabic"                     , description : "remarks (arabic) based on (leave description, permission description or holiday description)"});
arr.push({col:"Is_Absent_Approved"                 , description : "Flag (if absent is approved it will be 1)"});
arr.push({col:"Absent_Approver_Name_English"       , description : "Employee Name (english) who approved absent"});
arr.push({col:"Absent_Approver_Name_Arabic"        , description : "Employee Name (arabic) who approved absent"});
arr.push({col:"Absent_Approver_Unit_English"       , description : "Employee Organization unit (english) who approved absent"});
arr.push({col:"Absent_Approver_Unit_Arabic"        , description : "Employee Organization unit (arabic) who approved absent"});
arr.push({col:"Late_Minutes"                       , description : "Number of minutes employee came late"});
arr.push({col:"Is_Late_Approved"                   , description : "Flag (if late is approved it will be 1)"});
arr.push({col:"Late_Approver_Name_English"         , description : "Employee Name (english) who approved late"});
arr.push({col:"Late_Approver_Name_Arabic"          , description : "Employee Name (arabic) who approved late"});
arr.push({col:"Late_Approver_Unit_English"         , description : "Employee Organization unit (english) who approved late"});
arr.push({col:"Late_Approver_Unit_Arabic"          , description : "Employee Organization unit (arabic) who approved late"});
arr.push({col:"Early_Minutes"                      , description : "Number of minutes employee left early"});
arr.push({col:"Is_Early_Approved"                  , description : "Flag (if early is approved it will be 1)"});
arr.push({col:"Early_Approver_Name_English"	       , description : "Employee Name (english) who approved early"});
arr.push({col:"Early_Approver_Name_Arabic"         , description : "Employee Name (arabic) who approved early"});
arr.push({col:"Early_Approver_Unit_English"	       , description : "Employee Organization unit (english) who approved early"});
arr.push({col:"Early_Approver_Unit_Arabic"         , description : "Employee Organization unit (arabic) who approved early"});
arr.push({col:"Missing_Time"                       , description : "Missed time schedule"});
arr.push({col:"Missing_Time_HH_MM"                 , description : "Missed time schedule (HH:MM)"});
arr.push({col:"In_Permission_From_Time"            , description : "Permission start time against entry punch"});
arr.push({col:"In_Permission_To_Time"              , description : "Permission end time against entry punch"});
arr.push({col:"Out_Permission_From_Time"           , description : "Permission start time against exit punch"});
arr.push({col:"Out_Permission_To_Time"             , description : "Permission end time against exit punch"});
arr.push({col:"Full_Day_Permission"                , description : "Flag (if permission if for full day then it will be 'YES')"});
arr.push({col:"IN_Permission_Is_Official"          , description : "N/A"});
arr.push({col:"OUT_Permission_Is_Official"         , description : "N/A"});
arr.push({col:"Work_Minutes"                       , description : "Employee actual worked time in minutes"});
arr.push({col:"overtime"                           , description : "Minutes for overtime"});
arr.push({col:"Early_Punch_In_Minutes"             , description : "number of minutes employee punched before schedule start"});
arr.push({col:"Late_Punch_Out_Minutes"             , description : "number of minutes employee punched after schedule ends"});
arr.push({col:"Late_HH_MM"                         , description : "Late violation in hours and minutes format"});
arr.push({col:"Early_HH_MM"                        , description : "Early violation in hours and minutes format"});
arr.push({col:"Work_Time_HH_MM"                    , description : "Employee actual worked time in hour and minutes format"});
arr.push({col:"parent_organization_code"           , description : "Parent organization unit code of employee current organization unit"});
arr.push({col:"parent_org_id"                      , description : "Parent organization unit ID of employee current organization unit"});
arr.push({col:"parent_org_description_eng"         , description : "Parent organization unit description (english) of employee current organization unit"});
arr.push({col:"OT_MGR_STATUS"                      , description : "Flag (whether manager has approved overtme)"});
arr.push({col:"OT_HR_STATUS"                       , description : "Flag (whether HR/ADMIN has approved overtme)"});
arr.push({col:"OT_SYNC_STATUS"                     , description : "Whether OT is pushed to back to staging"});
arr.push({col:"OT_request_date"                    , description : "when OT is applied or approved by manager"});
arr.push({col:"OT_request_status"                  , description : "status of overtime to manager"});
arr.push({col:"OT_request_userid"                  , description : "OT applied by / manager ID who took action "});
arr.push({col:"OT_action_date"                     , description : "when OT action taked by HR/ADMIN "});
arr.push({col:"OT_action_status"                   , description : "status with HR/ADMIN"});
arr.push({col:"OT_action_userid"                   , description : "employee ID who took action (HR/ADMIN)"});
arr.push({col:"OT_processed_date"                  , description : "When OT is pushed back to staging"});
arr.push({col:"OT_processed_status"                , description : "Flag whether OT is pushed back to staging or not"});
arr.push({col:"OT_processed_userid"                , description : "Who initiated OT to synchronize with staging"});
arr.push({col:"absent"                             , description : "whether employee is absent "});
arr.push({col:"restday"                            , description : "whether its rest day"});
arr.push({col:"schedule_id"                        , description : "employee assigned schedule id "});
arr.push({col: "BeforeScheduleMin"                 , description : "Minutes before schedule " });
arr.push({col: "AfterScheduleMin"                  , description : "Minute after schedule" });
arr.push({col:"Out_Minutes"                        , description : "Minutes for employee outside office premesis."});
arr.push({col: "Out_HH_MM"                         , description : "Minutes for employee outside office premesis (HH:MM)."});
 