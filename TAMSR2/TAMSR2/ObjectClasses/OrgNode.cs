using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using TAMSR2.CustomClasses;
using TAMSR2Framework;
using TAMSR2Framework.DAL;

namespace TAMSR2.ObjectClasses
{
    public class OrgNode
    {
        public decimal ID { get; set; }
        public decimal ParentID { get; set; }
        public string Code { get; set; }
        public string NameEn { get; set; }
        public string NameAr { get; set; }
        public int Level { get; set; }
        public string LevelNameEn { get; set; }
        public string LevelNameAr { get; set; }
        public bool Visited { get; set; }

        public OrgNode()
        {
            ID = 0;
            ParentID = 0;
            Level = 0;
            Visited = false;
        }

        ////////END OF GETIDNAMELIST////////
        public List<OrgNode> GetIDNameList(string sessionID)
        {
            List<OrgNode> list = new List<OrgNode>();

            TAMSR2Data objDAL = new TAMSR2Data();
            DataView dv = new DataView();
            try
            {
                objDAL.OpenConnection(Connection.GetUserConnectionStrinng());
                Hashtable ht = new Hashtable();
                ht.Add("sessionID", sessionID);
                ht.Add("action", "getAllIdNameList");
                dv = objDAL.Connection.ExecuteProcedure("TAMSR2_OrgOps", ht);

                foreach (DataRowView row in dv)
                {
                    OrgNode obj = new OrgNode();
                    obj.ID = Numerics.GetDecimal(row["organization_id"] + "");
                    obj.ParentID = Numerics.GetDecimal(row["parent_id"] + "");
                    obj.Code = row["code"] + "";
                    obj.NameEn = row["description_eng"] + "";
                    obj.NameAr = row["description_arb"] + "";
                    obj.LevelNameEn = row["level_eng"] + "";
                    obj.LevelNameAr = row["level_arb"] + "";
                    obj.Level = Numerics.GetInt(row["organization_type_id"] + "") - 1;
                    list.Add(obj);
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                objDAL.CloseConnection();
            }

            return list;
        }
        ////////END OF GETIDNAMELIST////////


        ////////END OF GETGRAPHSTRING////////
        public string GetGraphString(string sessionID)
        {
            List<OrgNode> list = GetIDNameList(sessionID);

            List<decimal> parentIDList = new List<decimal>();
            parentIDList.AddRange(list.Where(p => p.ParentID != 0).OrderByDescending(p => p.ParentID).Select(p => p.ParentID).Distinct().ToList());

            string tempHtml = "";
            string graphHtml = "";

            foreach (decimal pid in parentIDList)
            {
                List<OrgNode> tempList = new List<OrgNode>();
                tempList.AddRange(list.Where(p => p.ParentID == pid && Visited == false).ToList());

                OrgNode node = list.FirstOrDefault(p => p.ID == pid && p.ID > 0);
                if (node.ParentID == 0)
                {
                    tempHtml = GetHtml(tempList);
                    if (tempHtml == "")
                        graphHtml = "<ul><li><a href='#'>" + node.NameEn + " <br />" + node.NameAr + "</a> <ul>" + tempHtml + "</ul></li></ul>";
                    else
                    {
                        graphHtml = "<ul><li><a href='#'>" + node.NameEn + " <br />" + node.NameAr + "</a> " + tempHtml + " <ul>" + graphHtml + "</ul></li></ul>";
                    }
                }
                else
                {
                    tempHtml = GetHtml(tempList);
                    if (tempHtml == "")
                        graphHtml = "<li><a href='#'>" + node.NameEn + " <br />" + node.NameAr + "</a> " + tempHtml + "</li>";
                    else
                    {
                        graphHtml = "<li><a href='#'>" + node.NameEn + " <br />" + node.NameAr + "</a> " + tempHtml + "</li>" + graphHtml;
                    }
                }

                list.FirstOrDefault(p => p.ID == pid).Visited = true;
            }
            return graphHtml;
        }
        ////////END OF GETGRAPHSTRING////////


        ////////END OF GETGRAPHSTRING////////
        public string GetHtml(List<OrgNode> list)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<ul>");
            foreach (OrgNode node in list)
            {
                sb.Append("<li>");
                sb.Append("<a href='#'>" + node.NameEn + " <br />" + node.NameAr + "</a>");
                sb.Append("</li>");
            }
            sb.Append("</ul>");
            return sb.ToString();
        }
        ////////END OF GETGRAPHSTRING////////
    }
}