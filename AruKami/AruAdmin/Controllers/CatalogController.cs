using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Diagnostics;
using System.Linq;
using System.Web.Mvc;
using AruAdmin.Models;

namespace AruAdmin.Controllers
{
    public class CatalogController : Controller
    {
        private AruKamiEntities db = new AruKamiEntities();
        // GET: Catalog/1
        public ActionResult Index(int? id)
        {
            CurrentCatalog model;
            if (id == 1)
            {
                model = QualityModel((int) id);
            }else if (id == 2) {
                model = PriceModel((int)id);
            }else if (id == 3) {
                model = DifficultyModel((int)id);
            }else if (id == 4) {
                model = HikeTypeModel((int)id);
            } else
            {
                return RedirectToAction("Index", "Home");
            }

            return View(model);
        }

        // GET: Catalog/Create/1
        [HttpPost]
        public ActionResult Create(int? id)
        {
            if (id == null)
            {
                return RedirectToAction("Index", "Home");
            }
            if (id == 1)
            {
                db.PR_AddQuality(Request.Form["itemName"]);
            }else if (id == 2)
            {
                db.PR_AddPrice(Request.Form["itemName"]);
            }else if (id == 3)
            {
                db.PR_AddDifficulty(Request.Form["itemName"]);
            }else if (id == 4)
            {
                db.PR_AddHikeType(Request.Form["itemName"]);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }


            return RedirectToAction("Index", "Catalog", new { id = id });
        }

        // GET: Catalog/Create/1
        [HttpPost]
        public ActionResult Edit(int? id, int? item)
        {
            if (id == null)
            {
                return RedirectToAction("Index", "Home");
            }
            if (id == 1 && item != null)
            {
                db.PR_EditQuality(Request.Form["itemNameEdit"], (int) item);
            }
            else if (id == 2 && item != null)
            {
                db.PR_EditPrice(Request.Form["itemNameEdit"], (int)item);
            }
            else if (id == 3 && item != null)
            {
                db.PR_EditDifficulty(Request.Form["itemNameEdit"], (int)item);
            }
            else if (id == 4 && item != null)
            {
                db.PR_EditHikeType(Request.Form["itemNameEdit"], (int)item);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }


            return RedirectToAction("Index", "Catalog", new { id = id });
        }


        // GET: Catalog/Delete/5?item=2
        public ActionResult Delete(int? id, decimal? item)
        {
            if (id == null || item == null)
            {
                return RedirectToAction("Index", "Home");
            }
            if (id == 1)
            {
                db.PR_InactiveQuality((int) item);
            }
            else if (id == 2)
            {
                db.PR_InactivePrice((int)item);
            }
            else if (id == 3)
            {
                db.PR_InactiveDifficulty((int)item);
            }
            else if (id == 4)
            {
                db.PR_InactiveHikeType((int)item);
            }
            else if (id == 6)
            {
                db.PR_InactiveAdmin((decimal)item);
                return RedirectToAction("User", "Home", new {id  = id-5});
            }else if (id == 5)
            {
                db.PR_InactiveHiker((decimal)item);
                return RedirectToAction("User", "Home", new { id = 3 });
            }
            else if (id == 7)
            {
                db.PR_InactiveAdminICT((decimal)item);
                return RedirectToAction("User", "Home", new {id  = id-5});
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }

            return RedirectToAction("Index", "Catalog", new {id = id});
        }

        // GET: Catalog/Activate/5?item=2
        public ActionResult Activate(int? id, decimal? item)
        {
            if (id == null || item == null)
            {
                return RedirectToAction("Index", "Home");
            }
            if (id == 1)
            {
                db.PR_ActiveQuality((int) item);
            }
            else if (id == 2)
            {
                db.PR_ActivePrice((int)item);
            }
            else if (id == 3)
            {
                db.PR_ActiveDifficulty((int)item);
            }
            else if (id == 4)
            {
                db.PR_ActiveHikeType((int)item);
            }
            else if (id == 5)
            {
                db.PR_ActiveHiker((int)item);
                return RedirectToAction("User", "Home", new { id = 3 });
            }
            else if (id == 6)
            {
                db.PR_ActiveAdmin((decimal)item);
                return RedirectToAction("User", "Home", new { id = id - 5 });
            }else if (id == 7)
            {
                db.PR_ActiveAdminICT((decimal)item);
                return RedirectToAction("User", "Home", new { id = id - 5 });
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }

            return RedirectToAction("Index", "Catalog", new {id = id});
        }

        public CurrentCatalog QualityModel(int type)
        {
            CurrentCatalog model = new CurrentCatalog();
            model._type = type;
            model._name = "Quality";
            model._listCatalog = new List<CatalogModel>();
            foreach (View_Quality quality in db.View_Quality.ToList())
            {
                model._listCatalog.Add(new CatalogModel(quality.Id, quality.Name, quality.Inactive));
            }
            return model;
        }

        public CurrentCatalog PriceModel(int type)
        {
            CurrentCatalog model = new CurrentCatalog();
            model._type = type;
            model._name = "Price";
            model._listCatalog = new List<CatalogModel>();
            foreach (View_Price price in db.View_Price.ToList())
            {
                model._listCatalog.Add(new CatalogModel(price.Id, price.Name, price.Inactive));
            }
            return model;
        }

        public CurrentCatalog DifficultyModel(int type)
        {
            CurrentCatalog model = new CurrentCatalog();
            model._type = type;
            model._name = "Difficulty";
            model._listCatalog = new List<CatalogModel>();
            foreach (View_Difficulty difficulty in db.View_Difficulty.ToList())
            {
                model._listCatalog.Add(new CatalogModel(difficulty.Id, difficulty.Name, difficulty.Inactive));
            }
            return model;
        }

        public CurrentCatalog HikeTypeModel(int type)
        {
            CurrentCatalog model = new CurrentCatalog();
            model._type = type;
            model._name = "Hike Types";
            model._listCatalog = new List<CatalogModel>();
            foreach (View_HikeType hikeType in db.View_HikeType.ToList())
            {
                model._listCatalog.Add(new CatalogModel(hikeType.Id, hikeType.Name, hikeType.Inactive));
            }
            return model;
        }

    }
}   