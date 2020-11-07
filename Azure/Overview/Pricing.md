# Pricing

[toc]

## Overview

- Azure offers pay-as-you-go and reserved instances for pricing.
- Azure Pricing Factors:
  - Resource size and resource type.
  - Different Azure locations have different prices for services.
  - The bandwidth of your services.
  - Any data transfer between two different billing zones is charged.
    - **Ingress (data in)** = free
    - **Egress (data out)** = charged based on data going out of Azure datacenters
- All resources belong to a subscription
  - An Azure account can have multiple subscriptions.
  - Organize your resources and subscriptions using **Azure management groups**.
- **Azure Cost Management** gives you a detailed view of current and projected costs.
- For new accounts, the **Azure Free Tier** is available.

- Free Tier offers limited usage of Azure products at no charge for 12 months.

  - You also get $200 credit that you can spend during the first 30 days.
  - More details at https://azure.microsoft.com/en-us/free

  - Estimate your expected monthly costs using **Azure Pricing Calculator.**

- Total Cost of Ownership (TCO) Calculator

  - Estimate total savings over a period of time by using Azure.
  - Compares costs and savings against on-premises and co-location environments.

- Azure Support Plans:
  - **Basic** – included for all Azure customers.
  - **Developer** – recommended for non-production environments. Limited access to technical support during business hours by email only.
  - **Standard** – appropriate for production workload environments. Has 24/7 access to Azure’s technical support engineers by phone or email.
  - **Professional Direct** – suitable for business-critical  workloads. Has 24/7 access to Azure’s technical support engineers by  phone or email. Provides access to Operations Support, ProDirect  delivery managers, and Support APIs.



## Service Level Agreement (SLA)

- It is the commitment of Microsoft for the uptime and connectivity of a service.
- You could obtain a service credit if the service level agreement is not met by Microsoft.
- Composite SLAs include several resources (*with different availability levels*) to support an application.
- SLAs for multi-region deployments distribute the application  in more than one region for high availability and use Azure Traffic  Manager for failover if one region fails.



## Service Lifecycle

- **Private Preview is only available to a few customers for early access to new technologies and features.**
- **Public Preview** makes the service in the public phase and can be used by any customers to evaluate the new features but SLA does not apply.
- **General Availability** is the release of service to the general public and is fully supported by SLAs.
- Azure updates allow you to get the latest updates on any Azure products and features.



## Sources

- https://azure.microsoft.com/en-us/pricing
- https://docs.microsoft.com/en-us/azure/cost-management-billing/cost-management-billing-overview
- https://docs.microsoft.com/en-us/azure/architecture/framework/resiliency/business-metrics
- https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms