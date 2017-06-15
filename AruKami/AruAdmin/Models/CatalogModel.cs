using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AruAdmin.Models
{
    public class CatalogModel
    {

        private int _id;
        private String _name;
        public bool _state;

        public CatalogModel(int id, String name, int? state)
        {
            this._id = id;
            this._name = name;
            this._state = (state == 0 || state == null);
        }

        public int GetId()
        {
            return _id;
        }

        public String GetName()
        {
            return _name;
        }

        public void SetName(String name)
        {
            this._name = name;
        }

        public void SetId(int id)
        {
            this._id = id;
        }

    }

    public class CurrentCatalog
    {
        public int _type;
        public String _name;
        public List<CatalogModel> _listCatalog;
    }

    public class CurrentUser
    {
        public int _type;
        public String _name;
        public List<Catalog_user> _listCatalog;
    }

    public partial class Catalog_user
    {
        public decimal IdCard { get; set; }
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string SecondLastName { get; set; }
        public bool state { get; set; }

        public Catalog_user(decimal IdCard, string Username, string FirstName, string MiddleName, string LastName, string SecondLastName, int? state)
        {
            this.IdCard = IdCard;
            this.Username = Username;
            this.FirstName = FirstName;
            this.MiddleName = MiddleName;
            this.LastName = LastName;
            this.SecondLastName = SecondLastName;
            this.state = (state == 0 || state == null);
        }
    }
}