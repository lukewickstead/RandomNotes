# Azure SQL

[toc]

## Overview

- Azure SQL is a family of managed, secure, and intelligent products that use the SQL Server database engine in the Azure cloud.
  - **Azure SQL Database**: Support modern cloud applications on an intelligent, managed database service, that includes serverless compute.
  - **Azure SQL Managed Instance**: Modernize your existing SQL Server applications at scale with an intelligent fully managed  instance as a service, with almost 100% feature parity with the SQL  Server database engine. Best for most migrations to the cloud. Are for migrations “lift-and-shift” to the cloud
  - **SQL Server on Azure VMs**: Lift-and-shift your SQL  Server workloads with ease and maintain 100% SQL Server compatibility  and operating system-level access.


![](https://docs.microsoft.com/en-us/azure/azure-sql/media/azure-sql-iaas-vs-paas-what-is-overview/sqliaas_sql_server_cloud_continuum.png)



## Azure SQL Database



- Relational database-as-a-service (DBaaS) hosted in Azure that falls into the industry category of *Platform-as-a-Service (PaaS)*.
- Additional features that are not available in SQL Server, such as built-in high availability, intelligence, and management
- Supports the following deployment options
  - **Single Database** – offers serverless and hyperscale storage (up to 100TB).
  - **Elastic Pool** – a collection of databases with a shared set of resources



## Azure SQL Managed Instance

- *Platform-as-a-Service (PaaS)*, and is best for most migrations to the cloud.
- Collection of system and user databases with a shared set of resources that is lift-and-shift ready.



## SQL Server on Azure VM

- *Infrastructure-as-a-Service (IaaS)* and allows you to run SQL Server inside a fully managed virtual machine (VM) in Azure.



| Azure SQL Database                                           | Azure SQL Managed Instance                                   | SQL Server on Azure VM                                       |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Supports most on-premises database-level capabilities. The most commonly used SQL Server features are available. 99.995% availability guaranteed. Built-in backups, patching, recovery. Latest stable Database Engine version. Ability to assign necessary resources (CPU/storage) to individual databases. Built-in advanced intelligence and security. Online change of resources (CPU/storage). | Supports almost all on-premises instance-level and database-level capabilities. High compatibility with SQL Server. 99.99% availability guaranteed. Built-in backups, patching, recovery. Latest stable Database Engine version. Easy migration from SQL Server. Private IP address within Azure Virtual Network. Built-in advanced intelligence and security. Online change of resources (CPU/storage). | You have full control over the SQL Server engine. Supports all on-premises capabilities. Up to 99.99% availability. Full parity with the matching version of on-premises SQL Server. Fixed, well-known Database Engine version. Easy migration from SQL Server. Private IP address within Azure Virtual Network. You have the ability to deploy application or services on the host where SQL Server is placed. |
| Migration from SQL Server might be challenging. Some SQL Server features are not available. No guaranteed exact maintenance time (but nearly transparent). Compatibility with the SQL Server version can be achieved only using database compatibility levels. Private IP address support with [Azure Private Link](https://docs.microsoft.com/en-us/azure/azure-sql/database/private-endpoint-overview). | There is still some minimal number of SQL Server features that are not available. No guaranteed exact maintenance time (but nearly transparent). Compatibility with the SQL Server version can be achieved only using database compatibility levels. | You need to manage your backups and patches. You need to implement your own High-Availability solution. There is a downtime while changing the resources(CPU/storage) |
| Databases of up to 100 TB.                                   | Up to 8 TB.                                                  | SQL Server instances with up to 256 TB of storage. The instance can support as many databases as needed. |
| On-premises application can access data in Azure SQL Database. | [Native virtual network implementation](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/vnet-existing-add-subnet) and connectivity to your on-premises environment using Azure Express Route or VPN Gateway. | With SQL virtual machines, you can have  applications that run partly in the cloud and partly on-premises. For  example, you can extend your on-premises network and Active Directory  Domain to the cloud via [Azure Virtual Network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview). For more information on hybrid cloud solutions, see [Extending on-premises data solutions to the cloud](https://docs.microsoft.com/en-us/azure/architecture/data-guide/scenarios/hybrid-on-premises-and-cloud). |

## Purchasing Models



Azure SQL Database and Azure SQL Managed Instance allow the following purchasing models



| **Purchasing model** | **Description**                                              | **Best for**                                               |
| -------------------- | ------------------------------------------------------------ | ---------------------------------------------------------- |
| DTU-based            | This model is based on a bundled measure of compute, storage, and  I/O resources. Compute sizes are expressed in DTUs for single databases  and in elastic database transaction units (eDTUs) for elastic pools. For more information about DTUs and eDTUs, see [What are DTUs and eDTUs?](https://docs.microsoft.com/en-us/azure/azure-sql/database/purchasing-models#dtu-based-purchasing-model). | Customers who want simple, preconfigured resource options  |
| vCore-based          | This model allows you to independently choose compute and storage  resources. The vCore-based purchasing model also allows you to use [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/) for SQL Server to save costs. | Customers who value flexibility, control, and transparency |



![](![Pricing model comparison](https://docs.microsoft.com/en-us/azure/azure-sql/database/media/purchasing-models/pricing-model.png)



- vCore-based service tiers:
  - General Purpose is for common workloads
  - Hyperscale is appropriate for online transaction processing (OLTP) and hybrid transactional analytical workloads (HTAP)
  - Business Critical is best for OLTP applications with high transaction rates and low IO latency



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
- **Azure Hybrid Benefit for SQL Server** enables you to use your SQL Server licenses to pay a reduced rate on Azure SQL.



## Sources       

- https://docs.microsoft.com/en-us/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview