using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class PermissionType : BaseClass
    {
        public decimal ReasonID { get; set; } 
        public string CommentsEn { get; set; }
        public string CommentsAr { get; set; } 

        public int GroupApplyFlag { get; set; }
        public string OfficialFlag { get; set; }
        public int HrOnlyFlag { get; set; }
        public int AllowAttachment { get; set; }
        public int CommentsRequired { get; set; }
        public int ApplyRamadanRestriction { get; set; }
        public int MedicalPassAttachment { get; set; }
        public int NationalityID { get; set; }
        public int PriorityID { get; set; }
        public int PermissionTypeID { get; set; }

        public string MaxPermissionsPerDay { get; set; }
        public string MaxMinutesPerDay { get; set; }
        public string MaxPermissionsPerMonth { get; set; }
        public string MaxMinutesMinutesPerMonth { get; set; }
        public string MinPermissionTime { get; set; }
        public string MaxPermissionTime { get; set; }


        public string WorkflowId { get; set; }
        public string OrganizationId { get; set; }
        public string GroupId { get; set; }
        public string ManagerId { get; set; }
        public string EmployeeId { get; set; }
        public string GenderId { get; set; }
        public string ValidFrom { get; set; }
        public string ValidTo { get; set; }

         
    }
}