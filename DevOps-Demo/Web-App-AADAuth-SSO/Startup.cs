﻿using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;

namespace Web_App_AADAuth_SSO
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
