# Azure Database Migration Service (DMS)
[toc]
## Overview
- Accelerates the migration of your data to Azure.
- Enables seamless migrations from multiple database sources.
- To perform an online migration, you need to create an instance based on the **premium pricing tier**.
## Features
- The Database Migration Assistant assess on-premises SQL Server instance(s) migrating to Azure SQL database(s)
  - Installed onsite
  - Generates reports
- Migrates your database and server objects with minimal downtime
  - Databases remain online
  - Transaction logs are record during migration and imported after migration
- Supports Microsoft SQL Server, MySQL, PostgreSQL, MongoDB, and Oracle migration to Azure from on-premises and other cloud providers
- You can use DMS for both operational database and data warehouse migrations.
- Automate the migration of data with **Azure PowerShell.**
- Use **Azure Migrate** to discover your on-premises data estate and assess migration readiness.
- You can create up to 2 DMS services per subscription.
## Pricing
- **Offline migrations of the DMS Standard tier are free to use.**
- DMS premium tier is billed at an hourly rate based on the provisioned compute capacity.

## Sources
- https://docs.microsoft.com/en-us/azure/dms/dms-overview