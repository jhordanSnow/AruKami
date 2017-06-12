﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AruAdmin.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class AruKamiEntities : DbContext
    {
        public AruKamiEntities()
            : base("name=AruKamiEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<View_User> View_User { get; set; }
    
        public virtual int PR_AdminLogin(string username, string password, ObjectParameter responseMessage)
        {
            var usernameParameter = username != null ?
                new ObjectParameter("Username", username) :
                new ObjectParameter("Username", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("Password", password) :
                new ObjectParameter("Password", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PR_AdminLogin", usernameParameter, passwordParameter, responseMessage);
        }
    
        public virtual int PR_CreateAdmin(Nullable<decimal> idCard, string username, string password, string firstName, string middleName, string lastName, string secondLastName, ObjectParameter responseMessage)
        {
            var idCardParameter = idCard.HasValue ?
                new ObjectParameter("IdCard", idCard) :
                new ObjectParameter("IdCard", typeof(decimal));
    
            var usernameParameter = username != null ?
                new ObjectParameter("Username", username) :
                new ObjectParameter("Username", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("Password", password) :
                new ObjectParameter("Password", typeof(string));
    
            var firstNameParameter = firstName != null ?
                new ObjectParameter("FirstName", firstName) :
                new ObjectParameter("FirstName", typeof(string));
    
            var middleNameParameter = middleName != null ?
                new ObjectParameter("MiddleName", middleName) :
                new ObjectParameter("MiddleName", typeof(string));
    
            var lastNameParameter = lastName != null ?
                new ObjectParameter("LastName", lastName) :
                new ObjectParameter("LastName", typeof(string));
    
            var secondLastNameParameter = secondLastName != null ?
                new ObjectParameter("SecondLastName", secondLastName) :
                new ObjectParameter("SecondLastName", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("PR_CreateAdmin", idCardParameter, usernameParameter, passwordParameter, firstNameParameter, middleNameParameter, lastNameParameter, secondLastNameParameter, responseMessage);
        }
    }
}