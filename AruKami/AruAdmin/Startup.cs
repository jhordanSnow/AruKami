using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(AruAdmin.Startup))]
namespace AruAdmin
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
