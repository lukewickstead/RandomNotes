# Managed Identities



[toc]



## Overview

![](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/media/overview/azure-managed-identities-examples.png)

- A managed identity from Azure Active Directory (Azure AD) allows your  app to easily access other Azure AD-protected resources such as Azure  Key Vault
- The identity is managed by the Azure platform and does not  require you to provision or rotate any secrets- You don't need to manage credentials. Credentials are not even accessible to you.
- You can use managed identities to authenticate to any Azure service  that supports Azure AD authentication including Azure Key Vault
- Managed identities can be used without any additional cost
- Internally, managed identities are service principals of a special type, which can only be used with Azure resources
- When the managed identity is deleted, the corresponding service principal is automatically removed
- When a User-Assigned or System-Assigned Identity is created, the Managed Identity Resource Provider (MSRP) issues a certificate internally to  that identity
- For Azure Functions and App Services you simply access the resource and it authenticates itself
- For VMs, your code can use a managed identity to request access tokens for  services that support Azure AD authentication. Azure takes care of  rolling the credentials that are used by the service instance.



## Types

- Your application can be granted two types of identities:
  - A **system-assigned identity** is tied to your application and is deleted if your app is deleted. An app can only have one system-assigned identity
    - Created via App Services > Identity > System Assigned
  - A **user-assigned identity** is a standalone Azure resource that can be assigned to your app. An app can have multiple user-assigned identities
    - Created via App Services > Identity > User Assigned



## System Assigned Identity vs. User Assigned Identify



| roperty                        | System-assigned managed identity                             | User-assigned managed identity                               |
| ------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Creation                       | Created as part of an Azure resource (for example, an Azure virtual machine or Azure App Service) | Created as a stand-alone Azure resource                      |
| Life cycle                     | Shared life cycle with the Azure resource that the managed identity is created with.   When the parent resource is deleted, the managed identity is deleted as well. | Independent life cycle.   Must be explicitly deleted.        |
| Sharing across Azure resources | Cannot be shared.   It can only be associated with a single Azure resource. | Can be shared   The same user-assigned managed identity can be associated with more than one Azure resource. |
| Common use cases               | Workloads that are contained within a single Azure resource   Workloads for which you need independent identities.   For example, an application that runs on a single virtual machine | Workloads that run on multiple resources and which can share a single identity.   Workloads that need pre-authorization to a secure resource as part of a provisioning flow.   Workloads where resources are recycled frequently, but permissions should stay consistent.   For example, a workload where multiple virtual machines need to access the same resource |

## Limitations

- Managed identities for App Service and Azure Functions won't behave as  expected if your app is migrated across subscriptions/tenants. The app  needs to obtain a new identity, which is done by disabling and  re-enabling the feature

