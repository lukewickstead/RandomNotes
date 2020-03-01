# AWS Relational Databases

## AWS Relational Databases In Depth

- The ability to Scale Components
- Automatic Backups and Patching
- High Availability
- Automatic Failure Detection and Recovery

## Amazon RDS for MySQL

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


## Amazon RDS for Microsoft SQL Server

- Version Support
  - RDS enabled you to run multiple editions of SQL Server (2008 R2, 20012, 2014, 2016 and 2017) including Express, Web, Standard and Enterprise
- Instance Support
  - General Purpose - Latest Generation and current generation like the M series
  - Memory Optimized - the latest and current generation R series instances
  - Burst Support  - latest and current T series instances
- Storage Support
  - General purpose SSD - delivers a consistent baseline of 3 IOPS per GB with the ability to burst up to 3,000 IOPS
  - Provisioned IOPS SSD - With storage from 100GBV to 16TB. You can provision from 1,000 IOPS to 32,000 IOPS for new SQL Server DB Instances


## Amazon RDS for Oracle Database

- Version Support
  - BYOL: Standard Edition Two (SE2), Standard Edition One (SE1), Standard Edition (SE) and Enterprise Edition (EE)
  - Oracle Database  12c (includes but limited to) Oracle Fusion Middleware, and Oracle Enterprise Manager
- Oracle and RDS also Supports
  - SAP Business Suite and Oracle
  - JD Edwards EnterpriseOne
  - Amazon Redshift as a data-source for Oracle Business Intelligence (OBIEE) versions 12.2.1.0 and 12.2.1.1
  

  ## Amazon RDS for MariaDB

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


## Amazon RDS for PostGresSQL

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


## Amazon RDS for Amazon Aurora

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