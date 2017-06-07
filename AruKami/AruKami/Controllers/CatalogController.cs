using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using AruKami.Models;

namespace AruKami.Controllers
{
    public class CatalogController : ApiController
    {
        private AruKamiEntities db = new AruKamiEntities();

        // GET: api/Nationalities
        [Route("api/Catalog/Nationalities")]
        public IQueryable<Nationalities> GetNationalities()
        {
            return db.Nationalities.OrderBy(m => m.Name);
        }

        // GET: api/Catalog/Difficulties
        [Route("api/Catalog/Difficulties")]
        public IQueryable<Hike_Difficulty> GetDifficulties()
        {
            return db.Hike_Difficulty.OrderBy(m => m.Name);
        }

        // GET: api/Catalog/Qualities
        [Route("api/Catalog/Qualities")]
        public IQueryable<Hike_Quality> GetQualities()
        {
            return db.Hike_Quality.OrderBy(m => m.Name);
        }

        // GET: api/Catalog/Prices
        [Route("api/Catalog/Prices")]
        public IQueryable<Hike_Price> GetPrices()
        {
            return db.Hike_Price.OrderBy(m => m.Name);
        }

        // GET: api/Catalog/Types
        [Route("api/Catalog/Types")]
        public IQueryable<Hike_Type> GetTypes()
        {
            return db.Hike_Type.OrderBy(m => m.Name);
        }
    }
}