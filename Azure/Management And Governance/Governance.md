# Governance

[toc]

## What are the Azure Management areas?



- Management refers to the tasks and processes required to maintain your business applications and the resources that support them
- The following management areas exist



![Diagram of the disciplines of Management in Azure.](https://docs.microsoft.com/en-gb/azure/monitoring/media/management-overview/management-capabilities.png)





## What are Azure management groups?

- If your organization has many subscriptions, you may need a way to efficiently manage access, policies, and compliance for those subscriptions
- Azure management groups provide a level of scope above subscriptions
- You organize subscriptions into containers called "management groups" and apply your governance conditions to the management groups
- All subscriptions within a management group automatically inherit the conditions applied to the management group
- Management groups give you enterprise-grade management at a large scale no matter what type of subscriptions you might have
- All subscriptions within a single management group must trust the same Azure Active Directory tenant



<img src="https://docs.microsoft.com/en-gb/azure/governance/management-groups/media/tree.png" alt="Diagram of a sample management group hierarchy." style="zoom:50%;" />



- 10,000 management groups can be supported in a single directory
- A management group tree can support up to six levels of depth
  - This limit doesn't include the Root level or the subscription level
- Each management group and subscription can only support one parent
- Each management group can have many children
- All subscriptions and management groups are within a single hierarchy in each directory. See [Important facts about the Root management group](https://docs.microsoft.com/en-gb/azure/governance/management-groups/overview#important-facts-about-the-root-management-group)



## Source

- https://docs.microsoft.com/en-gb/azure/governance/
- https://docs.microsoft.com/en-gb/azure/governance/azure-management
- https://docs.microsoft.com/en-gb/azure/governance/management-groups/overview