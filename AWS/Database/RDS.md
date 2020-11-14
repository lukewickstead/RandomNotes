# AWS Relational Databases Service (RDS)



[toc]

## Overview

- Relational database service
- Allows simple means to provision, create and scale databases
- Fully Managed
  - Automatic backups and patching
- High Availability
- Automatic Failure Detection and Recovery
- A number of RDS servers are available
  - MySQL, MaraDB, PostgreSQL, Amazon Aurora, Oracle, SQL Server



## DB Instance Type

- Offers different performance and architectures based upon your requirement
  - Standard/Generalpurpose classes (T3), Memmory Optimized (R5, X1, Z1), Burstable and also previous generations
- Not all instance types are available for all database engines
  - https://aws.amazon.com/ec2/instance-types



<img src="resources\RDSInstanceTypes.png" alt="RDSInstanceTypes" style="zoom:50%;" />



<img src="resources\RDSInstanceTypesSpecs.png" alt="RDSInstanceTypesSpecs" style="zoom:50%;" />



## AWS Availability Zones

- Each region includes distinct facilities located in different areas within the region called AVAILABILITY ZONES (AZs)
- AZ's are distinct geographical locations that are engineered to be insulated from failures in any other AZs
- Located on separate electrical grids, flood plains, risk profiles
- By having Amazon instances in more than one AZ a database can be protected from failure at a single location



## Auto Scaling

### Storage Auto Scaling

- EBS allows enabling storage auto scaling
- When enabled allows the storage to expand passed the defined allocated storage  up to the maximum storage threshold automatically
- Charges  are as normal for storage space
- Maximum storage threshold can be between 101Gib and 65536 GiB
- Amazon Aurora does no use EBS but uses shared cluster storage, it is a managed service and automatically scales as required



### Compute Scaling

- Vertical increases the performance of an instance
  - Change storage type
- Horizontal
  - Read replicas can be used to reduce reads on a primary RDS instance
  - Create via snapshots
  - An asynchronous link is made between the primary RDS instance and the read replica
  - Traffic for reads are diverted to the read replica



## Back Up

- All new dbs have automatica backups turned on though this can be turned off
- A retention period between 0 and 35 can be selected, the default is 7
- Encryption cab be enabled using KMS
- Manual backups can be created and are called snapshots
- Snapshots are not subject retention period and persist even if the database is deleted
- Restore can be done to a point in time but requires restoring to a new RDS instance / cluster
- Aurora allows backtrack which allows a rewind to a point in time without having to create a new RDS insgtance / cluster
  - You can only go back in time up to the configured backtrack window which has a maximum value of 72 



## DB Parameter Groups and Option Groups

- DB parameter groupss act as a container for engine configuration values that are applied to one or more DB instances
- Changing a dynamic parmeter the change is applied immediately refardless of the Apply Immediately setting
- Changing a static parameter takes effect afer you manually reboot the DB instance



## Option Groups

- An option group specifies a group of db options or features which will be turned on for a db instance
- Ease creation and maintenance of RDS instances
- There are two types; permanant and persistent
- RDS instances and DB snapshots can be associated with an option group



## Automatic Updates

- You can select to install minior version updates automatically and during a time range of your chosing



## MySQL

- Version Support
  - Amazon RDS for MySQL currently supports MySQL Community Editions versions 5.5, 5.6, 5.7
- Instance Support
  - Micro instances - often associated with free tier so useful for non-production or pilot projects
  - General Purpose - Latest Generation and current generation like the M series
  - Memory Optimized - the latest and current generation R series instances
  - Burst Support  - latest and current T series instances
- Storage Support
  - General Purpose storage provides cost-effective storage for small or medium-sized workloads
  - Provisioned IOPS will deliver consistent performance of up to 40,000 IOPS per second



## Microsoft SQL Server

- Version Support
  - RDS enabled you to run multiple editions of SQL Server (2008 R2, 20012, 2014, 2016 and 2017) including Express, Web, Standard and Enterprise
- Instance Support
  - General Purpose - Latest Generation and current generation like the M series
  - Memory Optimized - the latest and current generation R series instances
  - Burst Support  - latest and current T series instances
- Storage Support
  - General purpose SSD - delivers a consistent baseline of 3 IOPS per GB with the ability to burst up to 3,000 IOPS
  - Provisioned IOPS SSD - With storage from 100GBV to 16TB. You can provision from 1,000 IOPS to 32,000 IOPS for new SQL Server DB Instances



## Oracle

- Version Support
  - BYOL: Standard Edition Two (SE2), Standard Edition One (SE1), Standard Edition (SE) and Enterprise Edition (EE)
  - Oracle Database  12c (includes but limited to) Oracle Fusion Middleware, and Oracle Enterprise Manager
- Oracle and RDS also Supports
  - SAP Business Suite and Oracle
  - JD Edwards EnterpriseOne
  - Amazon Redshift as a data-source for Oracle Business Intelligence (OBIEE) versions 12.2.1.0 and 12.2.1.1
  



## MariaDB

  - Version Support
    - Amazon RDS for MariaDB supports version 10.1 to 10.2.11
  - Instance Support
    - Micro instances - often associate with free tier so useful for non-production or pilot projects
    - General Purpose - Latest Generation and current generation like the M series
    - Memory Optimized - the latest and current generation R series instances
    - Burst Support - latest and current T series instances
  - Storage Support
    - InnaDB is the default storage engine in for Version 10.1 and above
    - You can create read replicas for MariaDB



## PostGresSQL

- Provides
  - Multi-AZ support
  - Read replicas
  - Automatics back ups
  - Integrated with the AQS Database Migration Service
  - Well suited for meeting HIPAA/PHI/FedRAMP compliance
- Version Support
  - Supports PostgreSQL .3, 9.4, 9.5 and 9.6
- Instance Supports
  - Micro instances
  - Standard - Latest + Previous Generation
  - Memory Optimized - Current Generation
- Storage Support
  - General Purpose (SSD) - delivers a consistent baseline of 3 IOPS per provisioned GB and provides th ability to burst up to 3,000 IOPS
  - Provisioned IOPS (SSD) - up to 16 TB storage and 40,000 IOPS per database instance



## Aurora

- The cloud native database from Amazon
- Amazon's own fork of MySQL which provides significantly faster processing availability as a native MySQL and Postgres compatible relational database service
- Amazon Aurora was designed and built from the ground up to be cloud native
- A high-performance database service
- Amazon Aurora replicates data across three availability zones by default and also deploys a cloud native database cluster, and the Aurora instances will use this database cluster as the underlying data store
- The database cluster spans two or more availability zones by default, with each availability zone having a copy of the database cluster data
- Each cluster has one primary instance which performs all of the data modifications to the cluster volume and supports read and write operations
- Each cluster also has at least one Aurora replica which supports only read operations
- So each Aurora DB cluster can have up to 15 Aurora replicas of the primary instance
- This makes the response and recovery time for Amazon Aurora significantly faster and durable on most RDS services
- And the multiple Aurora replicas distribute the read workload
- And by locating Aurora replicas in separate availability zones, you can increase your database availability while increasing read replica performance



## Sources 

- https://docs.aws.amazon.com/rds
- https://docs.aws.amazon.com/rds/?id=docs_gateway