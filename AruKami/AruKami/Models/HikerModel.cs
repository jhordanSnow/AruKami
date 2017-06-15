using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AruKami.Models
{
    public class HikerModel
    {
        public decimal IdCard { get; set; }
        public decimal AccountNumber { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Gender { get; set; }
        public DateTime BirthDate { get; set; }
        public int Nationality { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string SecondLastName { get; set; }
        public String Photo { get; set; }
    }

}