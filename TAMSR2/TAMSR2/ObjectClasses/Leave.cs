using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.ObjectClasses
{
    public class Leave : BaseClass
    {
        public string Code { get; set; }
        public int ApproveNeedFlag { get; set; }
        public string OfficialFlag { get; set; }

        public int AllowAttachement { get; set; }
        public int WorkflowId { get; set; }
        public bool IsCommentMandatory { get; set; }
        public bool IsParentType { get; set; }
        public int ParentId { get; set; }
    }
}