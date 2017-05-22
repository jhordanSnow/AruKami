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

            ObjectParameter output = new ObjectParameter("responseMessage", typeof(string));
            db.PR_CreateHiker(user.IdCard, user.Username, user.Password, user.FirstName, user.MiddleName, user.LastName,
                user.SecondLastName, user.Gender, user.BirthDate, user.Nationality,user.AccountNumber, output);
            JsonResponse response = new JsonResponse(){Response = output.Value.ToString()};
            return Ok(response);
        }

        // POST: api/Login
        [Route("api/Login/Authenticate")]
        [ResponseType(typeof(LoginModel))]
        public async Task<IHttpActionResult> PostLoginModel(LoginModel loginModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter Output = new ObjectParameter("responseMessage", typeof(string));
            db.PR_HikerLogin(loginModel.Username, loginModel.Password, Output);
            var r = new LoginResult() { Success = false, Msg = Output.Value.ToString() };

            if (Output.Value.ToString().Equals("User successfully logged in"))
            {
                r.Success = true;
            }

            return Ok(r);
        }
    }
}
