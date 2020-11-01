# Azure SQL

[toc]

## Overview

- A fully managed database built upon the SQL Server engine
- SLA durability up to 99.995%
- SQL Databases Resource type:
  - Single Database – offers serverless and hyperscale storage (up to 100TB).
  - Elastic Pool – a collection of databases with a shared set of resources.
  - Database Server – manage groups of single databases and elastic pools.
- **SQL Managed Instances** are for migrations “lift-and-shift” to the cloud.
- **SQL Virtual Machines** are used for applications requiring OS-level access.
- Endpoint: <*server_name*>.database.windows.net
- vCore-based service tiers:
  - General Purpose is for common workloads.
  - Hyperscale is appropriate for online transaction processing (OLTP) and hybrid transactional analytical workloads (HTAP).
  - Business Critical is best for OLTP applications with high transaction rates and low IO latency.
- **Azure Hybrid Benefit for SQL Server** enables you to use your SQL Server licenses to pay a reduced rate on Azure SQL.
- **Azure Data Studio** is a modern cross-platform database  tool with customizable code snippets, lightning-fast IntelliSense,  useful peek definitions, and an integrated terminal to run other SQL  tools.

## Monitoring

- You can use **Intelligent Insights** to continuously monitor your Azure SQL usage and detect disruptive events that may lead to poor database performance.
- **Azure SQL Analytics** can be used to monitor your  databases across multiple subscriptions. It can collect and visualize  key performance metrics of your databases and enables you to create  custom monitoring rules and alerts.
- **Automatic tuning in Azure SQL continuously monitors queries executed on your database, and automatically improves the performance  using artificial intelligence.** 

## Networking

- Private endpoint connections provide access to all databases in the server.
- Allow communications from all resources inside the Azure boundary with firewall rules.

## Security

- You can use **Advanced Data Security (ADS)** for data classification, vulnerability assessment, and advanced threat protection.

## Pricing

- The resources are billed hourly at a fixed rate based on the service tier and compute size you choose.
- You are billed for outgoing Internet traffic.

## Sources       
- https://docs.microsoft.com/en-us/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview