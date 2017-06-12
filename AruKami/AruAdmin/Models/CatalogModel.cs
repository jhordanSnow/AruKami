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
}