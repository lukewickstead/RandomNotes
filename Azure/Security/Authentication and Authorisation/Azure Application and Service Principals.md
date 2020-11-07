# Azure Applications & Service Principal



[toc]

## Overview

- An Azure AD application is defined by its one and only application  object, which resides in the Azure AD tenant where the application was  registered (known as the application's "home" tenant)
- An Azure service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources
- Manage Identities are special types of Service Principles
- The application object is the *global* representation of your application for use across all tenants, and the service principal is the *local* representation for use in a specific tenant
- There is no way to directly create a service principal using the Azure  portal.  When you register an application through the Azure portal
- You can create and use them via PowerShell as well as the Azure CLI
- Signing in with a service principal requires the tenant ID which the service principal was created under
- Service Principles have roles



## Sources

- https://docs.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azps-5.0.0
- https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli