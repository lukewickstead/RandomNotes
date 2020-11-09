

# Azure Resource Manager

[toc]

## Overview

- Azure Resource Manager is the deployment and management service for Azure
- It provides a management layer that enables you to create, update, and delete resources in your Azure account
- You use management features, like access control, locks, and tags, to secure and organize your resources after deployment.



## Consistent management layer

- When a user sends a request from any of the Azure tools, APIs, or SDKs,  Resource Manager receives the request
- It authenticates and authorizes  the request. Resource Manager sends the request to the Azure service, which takes the requested action
- Because all requests are handled  through the same API, you see consistent results and capabilities in all the different tools



![Resource Manager request model](C:\src\RandomNotes\Azure\Management And Governance\consistent-management-layer.png)



## Terminology

- **resource** - A manageable item that is available  through Azure. Virtual machines, storage accounts, web apps, databases,  and virtual networks are examples of resources. Resource groups,  subscriptions, management groups, and tags are also examples of  resources.
- **resource group** - A container that holds related  resources for an Azure solution. The resource group includes those  resources that you want to manage as a group. You decide which resources belong in a resource group based on what makes the most sense for your  organization. See [Resource groups](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/overview#resource-groups).
- **resource provider** - A service that supplies Azure  resources. For example, a common resource provider is Microsoft.Compute, which supplies the virtual machine resource. Microsoft.Storage is  another common resource provider. See [Resource providers and types](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/resource-providers-and-types).
- **Resource Manager template** - A JavaScript Object  Notation (JSON) file that defines one or more resources to deploy to a  resource group, subscription, management group, or tenant. The template  can be used to deploy the resources consistently and repeatedly. See [Template deployment overview](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/overview).
- **declarative syntax** - Syntax that lets you state  "Here is what I intend to create" without having to write the sequence  of programming commands to create it. The Resource Manager template is  an example of declarative syntax. In the file, you define the properties for the infrastructure to deploy to Azure.  See [Template deployment overview](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/overview).



## The benefits of using Resource Manager

- Manage your infrastructure through declarative templates rather than scripts
- Deploy, manage, and monitor all the resources for your solution as a group, rather than handling these resources individually
- Redeploy your solution throughout the development lifecycle and  have confidence your resources are deployed in a consistent state
- Define the dependencies between resources so they're deployed in the correct order
- Apply access control to all services because Azure role-based  access control (Azure RBAC) is natively integrated into the management  platform
- Apply tags to resources to logically organize all the resources in your subscription
- Clarify your organization's billing by viewing costs for a group of resources sharing the same tag



## Scope

- Azure provides four hierachical levels of scope

  1. Management Groups
  2. Subscriptions
  3. Resource Groups
  4. Resources
- You apply management settings at any of these levels of scope. The  level you select determines how widely the setting is applied
- Lower  levels inherit settings from higher levels




![Management levels](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/media/overview/scope-levels.png)



## Resource groups

There are some important factors to consider when defining your resource group:

- All the resources in your resource group should share the same  lifecycle. You deploy, update, and delete them together. If one  resource, such as a server, needs to exist on a different deployment  cycle it should be in another resource group.

- Each resource can exist in only one resource group.

- You can add or remove a resource to a resource group at any time.

- You can move a resource from one resource group to another group. For more information, see [Move resources to new resource group or subscription](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/move-resource-group-and-subscription).

- The resources in a resource group can be located in different regions than the resource group.

- When creating a resource group, you need to provide a location  for that resource group. You may be wondering, "Why does a resource  group need a location? And, if the resources can have different  locations than the resource group, why does the resource group location  matter at all?" The resource group stores metadata about the resources.  When you specify a location for the resource group, you're specifying  where that metadata is stored. For compliance reasons, you may need to  ensure that your data is stored in a particular region.

  If the resource group's region is temporarily unavailable, you can't  update resources in the resource group because the metadata is  unavailable. The resources in other regions will still function as  expected, but you can't update them. For more information about building reliable applications, see [Designing reliable Azure applications](https://docs.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service).

- A resource group can be used to scope access control for administrative actions. To manage a resource group, you can assign [Azure Policies](https://docs.microsoft.com/en-gb/azure/governance/policy/overview), [Azure roles](https://docs.microsoft.com/en-gb/azure/role-based-access-control/role-assignments-portal), or [resource locks](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/lock-resources).

- You can [apply tags](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/tag-resources) to a resource group. The resources in the resource group don't inherit those tags.

- A resource can connect to resources in other resource groups.  This scenario is common when the two resources are related but don't  share the same lifecycle. For example, you can have a web app that  connects to a database in a different resource group.

- When you delete a resource group, all resources in the resource  group are also deleted. For information about how Azure Resource Manager orchestrates those deletions, see [Azure Resource Manager resource group and resource deletion](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/delete-resource-group).

- You can deploy up to 800 instances of a resource type in each resource group. Some resource types are [exempt from the 800 instance limit](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/resources-without-resource-group-limit).

- Some resources can exist outside of a resource group. These resources are deployed to the [subscription](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/deploy-to-subscription), [management group](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/deploy-to-management-group), or [tenant](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/deploy-to-tenant). Only specific resource types are supported at these scopes.

- To create a resource group, you can use the [portal](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups), [PowerShell](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/manage-resource-groups-powershell#create-resource-groups), [Azure CLI](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/management/manage-resource-groups-cli#create-resource-groups), or an [Azure Resource Manager (ARM) template](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/deploy-to-subscription#resource-groups).



## Locks

- As an administrator, you may need to lock a subscription, resource  group, or resource to prevent other users in your organization from  accidentally deleting or modifying critical resources. You can set the  lock level to **CanNotDelete** or **ReadOnly**. In the portal, the locks are called **Delete** and **Read-only** respectively.

  - **CanNotDelete** means authorized users can still read and modify a resource, but they can't delete the resource.
  - **ReadOnly** means authorized users can read a  resource, but they can't delete or update the resource. Applying this  lock is similar to restricting all authorized users to the permissions  granted by the **Reader** role

- Resource Manager locks apply only to operations that happen in the management plane, which consists of operations sent to `https://management.azure.com`. The locks don't restrict how resources perform their own functions.  Resource changes are restricted, but resource operations aren't  restricted

  

## Sources 

- https://docs.microsoft.com/en-gb/azure/azure-resource-manager/