# Overview of Cloud Databases



[toc]



## Overview

- Fully managed service offering my different types of databases
- No set up fee
- No hardware required
- Pay only for what we use



## Availability And Durability

- Database snapshots 
- Automatic backups
- Multi-AZ deployments allowing replication, durability and improved performance
- Automatics host replacement during failover
- Scales up or down to meet demand
- Can scale vertically or horizontally without needing to provision more server hardware
- We can easily enable Multi - availability zone support easily without up front investment
- There is no need to buy additional compute resource up front



## AWS Regions

- Each region designed to be isolated from other AWS regions to achieve greatest possible fault tolerance and stability
- You only see the resources tied to the region you have specified
- Billing is not tied to a specific region 



## AWS Shared Responsibility Model

- AWS services are run with a shared security model
- AWS ensures the physical environment and the bare-metal services are secure
- As users, it is our responsibility to maintain the security of the services that we run within the AWS environment
- What we do have to do is maintain the right roles and permissions for accessing those services
- . Now security has two aspects, data at rest and data in transit
  - AWS provides encryption for data in transit in and out of the database services AWS provides.
  - Data at rest, i.e. information that's stored within a database, can be encrypted using a number of services that AWS provides
  - AWS also provides a family of services for encrypting data at rest in the majority of cloud databases



## AWS Compliance

  - AWS has achieved a high number of compliance certifications and certificates which make it easy for you to meet security requirements, which means that your data is likely to be more secure hosted in a cloud-based database than it could be in a database that's managed in your server room



## Overview Of The Database Service

- Managed service which takes care of provisioning of hardware, networking and database software. 
- Manages the patching of the database software and the compute platform as well as backups
- Hosted in multiple regions
- Relational Databases
  - Amazon RDS
    - Aurora
      - Forks of MySQL and PostgreSQL provides significantly faster processing and availability as it has its own cloud native database engine
    - Commercial; Oracle, SQL Server
    - Community; MySQL, PostgreSQL, MariaDB
  - Data Warehouse
    - Amazon Redshift
- Non-Relational Databases
  - Amazon Dynamo DB
    - Key Value and document
  - Amazon ElastiCache
    - In-Memory Data Store supporting both redis and Memcached
  - Amazon Neptune
    - Graph DB



## Non Relational Databases

- No table schema required
- Can support non structured data
- Focus on providing a fast secure data store
- Generally lack a processing engine so are lighter in design



## Relational vs. Non Relational

- With a relational database, we have a persistent connection to the database and then we use the Structured Query Language to work with the data within it
- With a non-relational database, we generally use a RESTful HTTP interface. So before your application can access a database, it must be authenticated to ensure that the application is allowed to use that database and that it needs to be authorized so that the application can only perform actions for which it has those permissions



## Differences / Use Cases

- Relational
  - RDBMS / ACID engine
  - Supports complex relationships between tables
  - Uses the  Structures query language
  - Generally access via a persistent network connection (ODBC)
  - Uses a schema to define tables
  - Generally provides a processing engine within the database to manage processing of select, create, replace, update, delete statements
- Non Relational
  - Simple document or key store
  - Can store many different data types
  - Generally accessed via RESTful HTTP
  - No schema required
  - Every table must have a primary key
  - Scales fast
  - Lighter in design



## Source 

- https://docs.aws.amazon.com/index.html