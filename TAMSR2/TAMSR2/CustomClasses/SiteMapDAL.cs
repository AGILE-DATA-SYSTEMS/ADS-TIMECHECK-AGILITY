using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace TAMSR2.CustomClasses
{
    public class SiteMapDAL
    {
        string fileName = "\\ExceptionLog.xml";

        public bool Insert(SiteMapClass obj)
        {
            try
            {
                XDocument xmlDoc = XDocument.Load(fileName);
                xmlDoc.Element("urlset").Add(new XElement("url"
                    , new XElement("loc", obj.Location)
                    , new XElement("lastmod", obj.LastModify)
                    , new XElement("changefrequency", obj.ChangeFrequency)
                    , new XElement("priority", obj.Priority)
                    ));
                xmlDoc.Save(fileName);
                return true;

            }
            catch (Exception ex1)
            {

                return false;
            }
        }
        
        public List<SiteMapClass> GetAll()
        {
            List<string> list = new List<string>();
            try
            {
                XDocument xmlDoc = XDocument.Load(fileName);
                return xmlDoc.Descendants("url").Select(p =>
                    new SiteMapClass()
                    {
                        Location = ((p.Element("loc") + "").Replace("<loc>", "")).Replace("</loc>", ""),
                        LastModify = ((p.Element("lastmod") + "").Replace("<lastmod>", "")).Replace("</lastmod>", ""),
                        ChangeFrequency = ((p.Element("changefrequency") + "").Replace("<changefrequency>", "")).Replace("</changefrequency>", ""),
                        Priority = ((p.Element("priority") + "").Replace("<priority>", "")).Replace("</priority>", "")
                    }).ToList().Where(p => p.Location != "").ToList();
            }
            catch (Exception ex)
            {

                return null;
            }
        }

        public List<SiteMapClass> GetByDate(string date)
        {
            try
            {
                XDocument xmlDoc = XDocument.Load(fileName);
                return xmlDoc.Descendants("url").Select(p =>
                    new SiteMapClass()
                    {
                        Location = ((p.Element("loc") + "").Replace("<loc>", "")).Replace("</loc>", ""),
                        LastModify = ((p.Element("lastmod") + "").Replace("<lastmod>", "")).Replace("</lastmod>", ""),
                        ChangeFrequency = ((p.Element("changefrequency") + "").Replace("<changefrequency>", "")).Replace("</changefrequency>", ""),
                        Priority = ((p.Element("priority") + "").Replace("<priority>", "")).Replace("</priority>", "")
                    }).ToList().Where(p => p.Location != "" && p.LastModify == date).ToList();
            }
            catch (Exception ex)
            {
                return null;
            }

        }
        
        public bool RemoveAll()
        {
            try
            {
                XDocument xmlDoc = XDocument.Load(fileName);
                xmlDoc.Descendants("url").Remove();
                xmlDoc.Save(fileName);
                return true;
            }
            catch (Exception ex)
            {

                return false;
            }
        }

        public bool RemoveByDate(string date)
        {
            try
            {
                XDocument xmlDoc = XDocument.Load(fileName);
                xmlDoc.Descendants("url").Select(p =>
                    new SiteMapClass()
                    {
                        Location = ((p.Element("loc") + "").Replace("<loc>", "")).Replace("</loc>", ""),
                        LastModify = ((p.Element("lastmod") + "").Replace("<lastmod>", "")).Replace("</lastmod>", ""),
                        ChangeFrequency = ((p.Element("changefrequency") + "").Replace("<changefrequency>", "")).Replace("</changefrequency>", ""),
                        Priority = ((p.Element("priority") + "").Replace("<priority>", "")).Replace("</priority>", "")
                    }).ToList().RemoveAll(p => p.LastModify == date);
                xmlDoc.Save(fileName);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }

    }
}