# Azure Role-Based Access Control (RBAC)

[toc]

## Overview

- A role-based access control service to manage user’s  access to Azure resources including what they can do with those  resources and what areas they can access.
- It is an authorization system based on **Azure Resource Manager**, which provides fine-grained access management of Azure resources.

## Concepts

- Attaching a role definition to a user, group, service  principal, and managed identity to grant access to a particular scope is called **role assignment**.
- You can attach multiple role assignments since RBAC is an additive model.
- Azure RBAC supports both allow and deny assignments.

## Roles

- Azure Roles – Azure RBAC has over 70 built-in roles. The following are the four fundamental Azure roles:
  - Owner 
  - Contributor
  - Reader
  - User Access Administrator
- Azure AD Roles – Provide access to manage Azure AD resources  in a directory such as create users, assign administrative roles to  others, manage licenses, reset passwords, and manage domains.

| **Azure Roles**                                              | **Azure AD Roles**                                           |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Manage access to Azure resources.                            | Manage access to Azure Active Directory (Active AD) resources. |
| It supports custom roles.                                    | It supports custom roles.                                    |
| The scope can be specified at multiple levels (management group, subscription, resource group, resource). | The scope is only at the tenant level.                       |
| Role information can be accessed through Azure Portal, CLI, PowerShell, Resource Manager templates, and REST APIs. | Role information can be accessed through Azure Admin Portal,  Microsoft 365 Admin Center, Microsoft Graph, and Azure AD PowerShell. |

## Best Practices

- Use Azure RBAC to segregate duties within your team and only grant the access your users need.
- Limit the number of subscription owners (*max of 3*) to reduce the potential for breach by a compromised owner.
- You can use Azure AD PIM to protect privileged accounts from malicious cyber-attacks.

## Sources

- https://docs.microsoft.com/en-us/azure/role-based-access-control/overview