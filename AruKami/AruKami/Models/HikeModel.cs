using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AruKami.Models
{
    public class HikeModel
    {
        public string Name { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Route { get; set; }
        public byte[] Photo { get; set; }
        public int District { get; set; }
        public int QualityLevel { get; set; }
        public int PriceLevel { get; set; }
        public int Difficulty { get; set; }
        public int HikeType { get; set; }
        public int StartPoint { get; set; }
        public int EndPoint { get; set; }

    }
}