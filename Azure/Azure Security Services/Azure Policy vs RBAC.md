# Azure Policy vs Azure Role-Based Access Control (RBAC)

[toc]

## Overview

| **Azure Policy**   | **Role-based Access Control (RBAC)**                         |                                                              |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Description**    | Ensure resources are compliant with a set of rules.          | Authorization system to provide fine-grained access controls. |
| **Focus**          | Policy is focused on the properties of resources.            | RBAC focuses on what resources the users can access.         |
| **Implementation** | You specify a set of rules to prevent over-provisioning of resources. | You grant permission on what users can create.               |
| **Default access** | By default, rules are set to Allow.                          | By default, all access is denied.                            |
| **Scope**          | Policy within the resource group or subscription.            | Grant access to users or groups within a subscription.       |
| **Integration**    | Both services work hand-in-hand to provide governance around your environment. |                                                              |

## Sources 

- https://docs.microsoft.com/en-us/azure/governance/policy/overview   
- https://docs.microsoft.com/en-us/azure/role-based-access-control/overview