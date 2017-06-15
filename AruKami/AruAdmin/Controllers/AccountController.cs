using System;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using AruAdmin.Models;

namespace AruAdmin.Controllers
{
    
    public class AccountController : Controller
    {

        private AruKamiEntities db = new AruKamiEntities();

        IAuthenticationManager Authentication
        {
            get { return HttpContext.GetOwinContext().Authentication; }
        }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View(new LoginViewModel());
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            bool isValidUser = Membership.ValidateUser(model.Username, model.Password);
            if (isValidUser)
            {
                View_User user = null;
                using (AruKamiEntities dc = new AruKamiEntities())
                {
                    dc.Configuration.ProxyCreationEnabled = false;
                    user = dc.View_User.FirstOrDefault(a => a.Username.Equals(model.Username));

                }
                if (user != null)
                {
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    string data = js.Serialize(user);
                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, user.Username, DateTime.Now,
                        DateTime.Now.AddMinutes(30), model.RememberMe, data);
                    string encToken = FormsAuthentication.Encrypt(ticket);
                    HttpCookie authoCookies = new HttpCookie(FormsAuthentication.FormsCookieName, encToken);
                    Response.Cookies.Add(authoCookies);
                    return RedirectToAction("Index", "Home"); 
                }
            }
            ModelState.AddModelError("", "Invalid login attempt.");
            return View(model);

        }

        //
        // POST: /Account/LogOff
        [HttpPost]
        public ActionResult LogOff()
        {
            Authentication.SignOut();
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Account");
        }

        public ActionResult UserProfile()
        {
            bool error = false;
            var identity = (System.Web.HttpContext.Current.User as MyIdentity.MyPrincipal).Identity as MyIdentity;

            View_User loggedUser = db.View_User.FirstOrDefault(m => m.IdCard == identity.User.IdCard);
            ProfileEditViewModel model = new ProfileEditViewModel();

            model.profileData = new ProfileViewModel();
            model.profileData.IdCard = loggedUser.IdCard;
            model.profileData.FirstName = loggedUser.FirstName;
            model.profileData.LastName = loggedUser.LastName;
            model.profileData.Username = loggedUser.Username;
            model.profileData.MiddleName = loggedUser.MiddleName;
            model.profileData.SecondLastName = loggedUser.SecondLastName;
            return View(model);
        }

        [HttpPost]
        public ActionResult UserProfile(ProfileEditViewModel model)
        {
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

                return View("UserProfile", model);
            }
            return View("UserProfile", model);
        }

        public ActionResult ChangePassword(ProfileEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                ObjectParameter output = new ObjectParameter("responseMessage", typeof(string));
                db.PR_ChangePassword(model.profileData.IdCard, model.changePass.OldPassword, model.changePass.NewPassword, output);
                ModelState.AddModelError("", output.Value.ToString());
                return View("UserProfile", model);
            }
            return View("UserProfile", model);
        }

    }
}