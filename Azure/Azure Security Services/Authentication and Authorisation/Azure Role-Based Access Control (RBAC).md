# Azure Role-Based Access Control (RBAC)

[toc]

## Overview

- A role-based access control service to manage user’s  access to Azure resources including what they can do with those  resources and what areas they can access.
- It is an authorization system based on **Azure Resource Manager**, which provides fine-grained access management of Azure resources.



## Concepts

- Attaching a role definition to a user, group, service  principal, and managed identity to grant access to a particular scope is called **role assignment**
- You can attach multiple role assignments since RBAC is an additive model
- Azure RBAC supports both allow and deny assignments
- The way you control access to resources using Azure RBAC is to create  role assignments. This is a key concept to understand – it's how  permissions are enforced. A role assignment consists of three elements:  **security principal**, **role definition**, and **scope**.



## Security Principles

- A *security principal* is an object that represents a user,  group, service principal, or managed identity that is requesting access  to Azure resources. You can assign a role to any of these security  principals.



![Security principal for a role assignment](https://docs.microsoft.com/en-us/azure/role-based-access-control/media/shared/rbac-security-principal.png)



## Role Definitions

- A *role definition* is a collection of permissions; typically just called a *role*
- A role definition lists the operations that can be performed, such as  read, write, and delete
- Roles can be high-level, like owner, or  specific, like virtual machine reader
- **Azure Roles** – Azure RBAC has over 70 built-in roles. The following are the four fundamental Azure roles:
  - Owner 
  - Contributor
  - Reader
  - User Access Administrator
- **Azure AD Roles** – Provide access to manage Azure AD resources  in a directory such as create users, assign administrative roles to  others, manage licenses, reset passwords, and manage domains



| **Azure Roles**                                              | **Azure AD Roles**                                           |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Manage access to Azure resources.                            | Manage access to Azure Active Directory (Active AD) resources. |
| It supports custom roles.                                    | It supports custom roles.                                    |
| The scope can be specified at multiple levels (management group, subscription, resource group, resource). | The scope is only at the tenant level.                       |
| Role information can be accessed through Azure Portal, CLI, PowerShell, Resource Manager templates, and REST APIs. | Role information can be accessed through Azure Admin Portal,  Microsoft 365 Admin Center, Microsoft Graph, and Azure AD PowerShell. |



![Role definition for a role assignment](https://docs.microsoft.com/en-us/azure/role-based-access-control/media/shared/rbac-role-definition.png)



## Scope

- *Scope* is the set of resources that the access applies to
- When  you assign a role, you can further limit the actions allowed by defining a scope
- In Azure, you can specify a scope at four levels: [management group](https://docs.microsoft.com/en-us/azure/governance/management-groups/overview), subscription, [resource group](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/overview#resource-groups), or resource
- Scopes are structured in a parent-child relationship
- You can assign roles at any of these levels of scope



![Scope for a role assignment](https://docs.microsoft.com/en-us/azure/role-based-access-control/media/shared/rbac-scope.png)



## Role Assignment

- A *role assignment* is the process of attaching a role definition to a user, group, service principal, or managed identity at a  particular scope for the purpose of granting access
- Access is granted  by creating a role assignment, and access is revoked by removing a role  assignment



![Role assignment to control access](https://docs.microsoft.com/en-us/azure/role-based-access-control/media/overview/rbac-overview.png)



## Multiple Role Assignment

- It is possible and common to have multiple roles assigned
- Azure RBAC is an additive model, so your effective permissions are the sum of your role assignments



## Deny Assignments

- Previously, Azure RBAC was an allow-only model with no deny, but now  Azure RBAC supports deny assignments in a limited way
- Similar to a role assignment, a *deny assignment* attaches a set of deny actions  to a user, group, service principal, or managed identity at a particular scope for the purpose of denying access
- A role assignment defines a  set of actions that are *allowed*, while a deny assignment defines a set of actions that are *not allowed*
-  Deny assignments  take precedence over role assignments



## Best Practices

- Use Azure RBAC to segregate duties within your team and only grant the access your users need.
- Limit the number of subscription owners (*max of 3*) to reduce the potential for breach by a compromised owner.
- You can use Azure AD PIM to protect privileged accounts from malicious cyber-attacks.



## Sources

- https://docs.microsoft.com/en-us/azure/role-based-access-control/