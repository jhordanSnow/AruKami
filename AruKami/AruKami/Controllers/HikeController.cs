using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using AruKami.Models;

namespace AruKami.Controllers
{
    public class HikeController : ApiController
    {

        private AruKamiEntities db = new AruKamiEntities();

        // POST: api/Hikes/
        [Route("api/Hikes/New")]
        [ResponseType(typeof(HikeModel))]
        public async Task<IHttpActionResult> PostHike(HikeModel hike)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter output = new ObjectParameter("responseMessage", typeof(string));
            db.PR_CreateHike(hike.Name, hike.StartDate, hike.EndDate, hike.Route, hike.Photo, hike.District, hike.QualityLevel, hike.PriceLevel, hike.Difficulty, hike.HikeType, hike.StartPoint, hike.EndPoint, output);
            var r = new LoginResult() { Success = false, Msg = output.Value.ToString() };

            if (output.Value.ToString().Equals("Success"))
            {
                r.Success = true;
            }

            return Ok(r);
        }

        // POST: api/Hikes/
        [Route("api/Hikes/GeoPoint/New")]
        [ResponseType(typeof(GeoPointRequest))]
        public IHttpActionResult PostGeoPoint(GeoPointRequest point)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter output = new ObjectParameter("responseMessage", typeof(string));
            ObjectParameter idPoint = new ObjectParameter("IdPoint", typeof(int));
            db.PR_CreatePoint(point.Latitude, point.Longitude,idPoint,output);
            var r = new GeoPointResponse() { Success = false, Msg = output.Value.ToString(), IdPoint =  (int)idPoint.Value };

            if (output.Value.ToString().Equals("Success"))
            {
                r.Success = true;
            }

            return Ok(r);
        }
    }
}
