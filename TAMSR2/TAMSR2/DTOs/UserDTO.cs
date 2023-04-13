using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADS_IRIS.DTOs
{
    public class UserDTO
    {
        
        public string UID { get; set; }
        public string FullName { get; set; }
        public string deviceID { get; set; }
        public string CardSerialNo { get; set; }
        public string CardRemark { get; set; }
        public bool FaceMode { get; set; }
        public bool GlassesMode { get; set; }
        public bool BothEyeMode { get; set; }
        public bool EitherEyeMode { get; set; }
        public bool FaceFullResolution { get; set; }
        public bool RecogMode { get; set; }
        public bool OverwriteUIDInfo { get; set; }
    }
}
