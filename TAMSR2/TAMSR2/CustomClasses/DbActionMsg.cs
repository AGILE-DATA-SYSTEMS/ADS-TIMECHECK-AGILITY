using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.CustomClasses
{
    public class DbActionMsg
    {

        public string ActionType { get; set; }
        public string ActionResult { get; set; }
        public string ActionMessage { get; set; }
        public string ActionWarning { get; set; }

    }
}