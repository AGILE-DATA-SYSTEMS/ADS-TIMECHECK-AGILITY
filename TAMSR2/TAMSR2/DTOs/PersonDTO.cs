using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADS_IRIS.DTOs
{
    public class EnrolPersonDTO
    {
        public string type { get; set; }
        public string person_code { get; set; }
        public string person_id { get; set; }
        public bool isDeleted { get; set; }
        public string person_first_name { get; set; }
        public string person_last_name { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string expiry_date { get; set; }
        public string finger_print1 { get; set; }
        public string finger_print2 { get; set; }
        public string card { get; set; }
        public string deviceId { get; set; }

        public int RecordVersion { get; set; }
        public int WiegandFacility { get; set; }
        public int WiegandSite { get; set; }
        public int WiegandCode { get; set; }
        public string WiegandCustom { get; set; }

        public bool AccessAllowed { get; set; }
        public string MatchUntil { get; set; }


        public byte[] LeftEyeTemplate { get; set; }
        public byte[] RightEyeTemplate { get; set; }
        public string LeftEyeTemplateAsBase64 { get; set; }
        public string RightEyeTemplateAsBase64 { get; set; }

        public int FaceEyeWidth { get; set; }
        public long FaceFeatureSize { get; set; }
        public float FaceFrontalScore { get; set; }
        public int FaceLeftEyeX { get; set; }
        public int FaceRightEyeX { get; set; }
        public float FaceRoll { get; set; }
        public float FaceScore { get; set; }
        public int FaceLEDState { get; set; }

        public byte[] FaceFeature1 { get; set; }
        public byte[] FaceFeature2 { get; set; }
        public byte[] FaceFeature3 { get; set; }
        public byte[] FaceFeature4 { get; set; }

        public int CardSubID { get; set; }
        public string CardSerialNo { get; set; }
        public string Remark { get; set; }
    }
}
