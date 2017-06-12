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
            }else
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
            else
            {
                return RedirectToAction("Index", "Home");
            }


            return RedirectToAction("Index", "Catalog", new { id = id });
        }


        // GET: Catalog/Delete/5?item=2
        public ActionResult Delete(int? id, int? item)
        {
            if (id == null || item == null)
            {
                return RedirectToAction("Index", "Home");
            }
            if (id == 1)
            {
                db.PR_InactiveQuality((int) item);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }


            return RedirectToAction("Index", "Catalog", new {id = id});
        }

        // GET: Catalog/Activate/5?item=2
        public ActionResult Activate(int? id, int? item)
        {
            if (id == null || item == null)
            {
                return RedirectToAction("Index", "Home");
            }
            if (id == 1)
            {
                db.PR_ActiveQuality((int) item);
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

    }
}   