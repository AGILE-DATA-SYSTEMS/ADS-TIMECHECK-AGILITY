/* **************************************************************
 * File Name        : JQueryResponse.cs
 * Description      : JQuery/JSON Class to parse object collection in reponse of JQuery/JSON request.
 * 
 * Author		    : Muhammad Aqeel Abbas @linktoaqeel
 * Created		    : May 22, 2013
 * Dependency	    : 
 * 
 * Revision History :
 * 
 * 
 * *************************************************************/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAMSR2.CustomClasses
{
    public class JQueryResponse
    {
        public int sEcho { get; set; }
        public int iTotalRecords { get; set; }
        public int iTotalDisplayRecords { get; set; }
        public List<List<string>> aaData { get; set; }

        public List<object> rawData { get; set; }

        public JQueryResponse()
        {
            aaData = new List<List<string>>();
        }
    }
}