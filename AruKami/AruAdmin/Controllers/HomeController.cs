using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AruAdmin.Filter;
using AruAdmin.Models;

namespace AruAdmin.Controllers
{
    public class HomeController : Controller
    {
        private AruKamiEntities db = new AruKamiEntities();

        public ActionResult Index()
        {
            return View(db.EventLog.ToList().OrderByDescending(m => m.Date));
        }

        public ActionResult User(int? id)
        {
            CurrentUser model;
            if (id == 1)
            {
                model = AdminModel((int)id+5);
            }else if (id == 2)
            {
                model = AdminIctModel((int)id+5);
            }else if (id == 3)
            {
                return View("Hiker", db.View_Hiker.ToList());
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }

            return View(model);
        }

        public ActionResult Create(int? id)
        {
            if (id != null)
            {
                ProfileEditViewModel model = new ProfileEditViewModel();
                model.profileData = new ProfileViewModel();
                model.changePass = new ChangePasswordViewModel();
                model.type = (int) id+5;
                return View(model);
            }
            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public ActionResult Create(ProfileEditViewModel model)
        {

            if (ModelState.IsValid)
            {
                ObjectParameter output = new ObjectParameter("responseMessage", typeof(string));
                if (model.type == 6)
                {
                    db.PR_CreateAdmin(model.profileData.IdCard, model.profileData.Username, model.changePass.NewPassword,
                        model.profileData.FirstName,
                        model.profileData.MiddleName, model.profileData.LastName, model.profileData.SecondLastName,
                        output);
                }
                else
                {
                    db.PR_CreateAdminICT(model.profileData.IdCard, model.profileData.Username, model.changePass.NewPassword,
                        model.profileData.FirstName,
                        model.profileData.MiddleName, model.profileData.LastName, model.profileData.SecondLastName,
                        output);
                }

                if (output.Value.Equals("Success"))
                {
                    TempData["Success"] = "Good.";
                }
                else
                {
                    ModelState.AddModelError("", output.Value.ToString());
                }

                return View(model);
            }
            return View(model);
        }

        public ActionResult Edit(int? id, decimal? item)
        {
            if (id != null && item != null)
            {
                ProfileEditViewModel model = new ProfileEditViewModel();
                model.profileData = loadInfo((decimal)item);
                model.changePass = new ChangePasswordViewModel();
                model.pass = false;
                model.type = (int) id+5;
                return View("Create", model);
            }
            return RedirectToAction("Index", "Home");
        }


        [HttpPost]
        public ActionResult Edit(ProfileEditViewModel model)
        {
            model.pass = false;
            if (ModelState.IsValid)
            {
                ObjectParameter output = new ObjectParameter("responseMessage", typeof(string));
                db.PR_UpdateUser(model.profileData.IdCard, model.profileData.Username, model.profileData.FirstName,
                    model.profileData.MiddleName, model.profileData.LastName, model.profileData.SecondLastName, output);

                if (output.Value.Equals("Success"))
                {
                    TempData["Success"] = "Good.";
                }
                else
                {
                    ModelState.AddModelError("", output.Value.ToString());
                }

                return View("Create", model);
            }
            return View("Create", model);
        }


        public ProfileViewModel loadInfo(decimal idCard)
        {
            ProfileViewModel model = new ProfileViewModel();
            View_User user = db.View_User.FirstOrDefault(m => m.IdCard == idCard);
            model.IdCard = idCard;
            model.Username = user.Username;
            model.FirstName = user.FirstName;
            model.MiddleName = user.MiddleName;
            model.LastName = user.LastName;
            model.SecondLastName = user.SecondLastName;

            return model;
        }

        

        public CurrentUser AdminModel(int type)
        {
            CurrentUser model = new CurrentUser();
            model._type = type;
            model._name = "Admin";
            model._listCatalog = new List<Catalog_user>();
            foreach (View_Admin user in db.View_Admin.ToList())
            {
                model._listCatalog.Add(new Catalog_user(user.IdCard,user.Username,user.FirstName,user.MiddleName,user.SecondLastName,user.SecondLastName,user.Inactive));
            }
            return model;
        }

        public CurrentUser AdminIctModel(int type)
        {
            CurrentUser model = new CurrentUser();
            model._type = type;
            model._name = "AdminICT";
            model._listCatalog = new List<Catalog_user>();
            foreach (View_AdminICT user in db.View_AdminICT.ToList())
            {
                model._listCatalog.Add(new Catalog_user(user.IdCard,user.Username,user.FirstName,user.MiddleName,user.LastName,user.SecondLastName,user.Inactive));
            }
            return model;
        }

    }
}