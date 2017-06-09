using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AruKami.Models
{
    public class GeoPointRequest
    {
        public string Latitude { get; set; }
        public string Longitude { get; set; }
    }

    public class GeoPointResponse
    {
        public bool Success { get; set; }
        public string Msg { get; set; }
        public int IdPoint { get; set; }
    }
}