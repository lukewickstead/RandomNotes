# Cost Management

[toc]

## Overview

- Azure Cost Management + Billing is a suite of tools provided by  Microsoft that help you analyze, manage, and optimize the costs of your  workloads
- Conduct billing administrative tasks such as paying your bill
- Manage billing access to costs
- Download cost and usage data that was used to generate your monthly invoice
- Proactively apply data analysis to your costs
- Set spending thresholds
- Identify opportunities for workload changes that can optimize your spending



# Billing accounts

The Azure portal currently supports the following types of billing accounts:

- **Microsoft Online Services Program**: An individual billing account for a Microsoft Online Services Program is created when you sign up for Azure through the Azure website. For example, when you  sign up for an Azure Free Account, account with pay-as-you-go rates or  as a Visual studio subscriber.
- **Enterprise Agreement**: A billing account for an  Enterprise Agreement is created when your organization signs an  Enterprise Agreement (EA) to use Azure.
- **Microsoft Customer Agreement**: A billing account  for a Microsoft Customer Agreement is created when your organization  works with a Microsoft representative to sign a Microsoft Customer  Agreement. Some customers in select regions, who sign up through the  Azure website for an account with pay-as-you-go rates or upgrade their  Azure Free Account may have a billing account for a Microsoft Customer  Agreement as well.



### Scopes for billing accounts

A scope is a node in a billing account that you use to view and  manage billing. It's where you manage billing data, payments, invoices,  and conduct general account management.

#### Microsoft Online Services Program

| Scope           | Definition                                                   |
| --------------- | ------------------------------------------------------------ |
| Billing account | Represents a single owner (Account administrator) for one or more  Azure subscriptions. An Account Administrator is authorized to do  various billing tasks like create subscriptions, view invoices or change the billing for subscriptions. |
| Subscription    | Represents a grouping of Azure resources. An invoice is generated at the subscription scope. It has its own payment methods that are used to pay its invoice. |

#### Enterprise Agreement

| Scope              | Definition                                                   |
| ------------------ | ------------------------------------------------------------ |
| Billing account    | Represents an Enterprise Agreement enrollment. Invoice is generated  at the billing account scope. It's structured using departments and  enrollment accounts. |
| Department         | Optional grouping of enrollment accounts.                    |
| Enrollment account | Represents a single account owner. Azure subscriptions are created under the enrollment account scope. |

#### Microsoft Customer Agreement

| Scope           | Tasks                                                        |
| --------------- | ------------------------------------------------------------ |
| Billing account | Represents a customer agreement for multiple Microsoft products and  services. The billing account is structured using billing profiles and  invoice sections. |
| Billing profile | Represents an invoice and its payment methods. Invoice is generated  at this scope. The billing profile can have multiple invoice sections. |
| Invoice section | Represents a group of costs in an invoice. Subscriptions and other purchases are associated to the invoice section scope. |



### Additional Azure tools

Azure has other tools that aren't a part of the Azure Cost Management + Billing feature set. However, they play an important role in the cost management process. To learn more about these tools, see the following  links.

- [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) - Use this tool to estimate your up-front cloud costs.
- [Azure Migrate](https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview) - Assess your current datacenter workload for insights about what's needed from an Azure replacement solution.
- [Azure Advisor](https://docs.microsoft.com/en-gb/azure/advisor/advisor-overview) - Identify unused VMs and receive recommendations about Azure reserved instance purchases.
- [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/) - Use your current on-premises Windows Server or SQL Server licenses for VMs in Azure to save.



## Sources

- https://docs.microsoft.com/en-gb/azure/cost-management-billing/cost-management-billing-overview