using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Hosting;
using System.Web.Http;
using System.Web.Http.Description;
using AruKami.Models;
using Microsoft.Ajax.Utilities;

namespace AruKami.Controllers
{
    public class AccountController : ApiController
    {
        private AruKamiEntities db = new AruKamiEntities();

        // POST: api/Users
        [Route("api/Register/User")]
        [ResponseType(typeof(HikerModel))]
        public async Task<IHttpActionResult> PostUser(HikerModel user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            String relativePath = null;
            if (user.Photo != null)
            {
                relativePath = "~/Images/Users/Profile Pictures/" + user.IdCard + ".jpg";
            }
            ObjectParameter output = new ObjectParameter("responseMessage", typeof(string));
            db.PR_CreateHiker(user.IdCard, user.Username, user.Password, user.FirstName, user.MiddleName, user.LastName,
                user.SecondLastName, user.Gender, user.BirthDate, user.Nationality, relativePath, user.AccountNumber, output);
            JsonResponse response = new JsonResponse(){Response = output.Value.ToString()};
            if (response.Response == "Success" && relativePath != null)
            {  
                savePhoto(user.Photo, relativePath);
            }
            return Ok(response);
        }

        public void savePhoto(String Photo, String path)
        {
            byte[] bytes = Convert.FromBase64String(Photo);
            using (MemoryStream ms = new MemoryStream(bytes))
            {
                Image image = Image.FromStream(ms);
                String filePath = HostingEnvironment.MapPath(path);
                image.Save(filePath);
            }
        }

        // POST: api/Login
        [Route("api/Login/Authenticate")]
        [ResponseType(typeof(LoginModel))]
        public IHttpActionResult PostLoginModel(LoginModel loginModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter Output = new ObjectParameter("responseMessage", typeof(string));
            ObjectParameter idCard = new ObjectParameter("idCard", typeof(int));
            db.PR_HikerLogin(loginModel.Username, loginModel.Password,Output, idCard);
            var r = new LoginResult() { Success = false, Msg = Output.Value.ToString()};
            if (! (idCard.Value is DBNull))
            {
                r.IdCard = Convert.ToInt32(idCard.Value);
            }

            if (Output.Value.ToString().Equals("User successfully logged in"))
            {
                r.Success = true;
            }

            return Ok(r);
        }


        // POST: api/User/5
        [Route("api/User/{id}")]
        [ResponseType(typeof(PR_GetUser_Result))]
        public IHttpActionResult GetUser(int id)
        {
            var loginModel = db.PR_GetUser(id).FirstOrDefault();
            if (loginModel == null)
            {
                return NotFound();
            }

            return Ok(loginModel);
        }

        // POST: api/User/5
        [System.Web.Http.HttpGet]
        [Route("api/User/{id}/Photo")]
        public HttpResponseMessage GetUserPhoto(int id)
        {
            var loginModel = db.PR_GetUser(id).FirstOrDefault();
            if (loginModel == null || loginModel.PhotoURL.IsNullOrWhiteSpace())
            {
                return new HttpResponseMessage(HttpStatusCode.NotFound);
            }
            var result = new HttpResponseMessage(HttpStatusCode.OK);
            String filePath = HostingEnvironment.MapPath(loginModel.PhotoURL);
            FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read);
            Image image = Image.FromStream(fileStream);
            MemoryStream memoryStream = new MemoryStream();
            image.Save(memoryStream, ImageFormat.Jpeg);
            result.Content = new ByteArrayContent(memoryStream.ToArray());
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("image/jpeg");

            return result;
        }


        public void DeletePhoto(int id)
        {
            String filePath = HostingEnvironment.MapPath("~/Images/Users/Profile Pictures/" + id+".jpg");
            File.Delete(filePath);
        }
    }
}
