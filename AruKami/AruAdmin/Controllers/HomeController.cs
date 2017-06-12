using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AruAdmin.Filter;

namespace AruAdmin.Controllers
{
    public class HomeController : Controller
    {
        [UserAuth]
        public ActionResult Index()
        {
            return View();
        }
    }
}