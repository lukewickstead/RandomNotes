# Azure Cosmos DB
[toc]
## Overview

- Fully managed platform-as-a-service (PaaS) NoSQL database
- Single-digit millisecond response times
- Automatic and instant scalability
- Turnkey multi-master data distribution anywhere in the world
- Automatic management, updates and patching
- Capacity management with cost-effective serverless and automatic scaling options that respond to application needs to match capacity with demand
- Choose from multiple database APIs including the native Core (SQL) API,  API for MongoDB, Cassandra API, Gremlin API, and Table API for
  - Database engine is for read only; for example in SQL you query the data through SQL but can not insert/edit the data or perform DDL



## Azure Cosmos DB Resource Model

- A database can contain multiple containers, a container is similar to a table in SQL.

- You can virtually have an unlimited provisioned throughput (RU/s) and storage on a container

- A container is automatically horizontally partitioned  using a user defined logical partition key and then replicated across multiple regions

- A container is a schema-agnostic container of items; each item is a simple JSON document and can have different fields

- All items are automatically  indexed 

- Indexing cab be customised by configuring a indexing policy on a container

- You can set Time to Live (TTL) on selected items in a container or for the entire container to gracefully purge those items from the system

- Change feed provides the log of all the updates performed on the container, along with the before and after images of the items. Can be configured for retention period.

- You can register stored procedures, triggers, user defined functions and merge procedures on a container

  

![https://docs.microsoft.com/en-us/azure/cosmos-db/media/account-databases-containers-items/cosmos-entities.png](https://docs.microsoft.com/en-us/azure/cosmos-db/media/account-databases-containers-items/cosmos-entities.png)



| Azure Cosmos entity   | SQL API  | Cassandra API | Azure Cosmos DB API for MongoDB | Gremlin API | Table API |
| --------------------- | -------- | ------------- | ------------------------------- | ----------- | --------- |
| Azure Cosmos database | Database | Keyspace      | Database                        | Database    | NA        |



| Azure Cosmos entity    | SQL API   | Cassandra API | Azure Cosmos DB API for MongoDB | Gremlin API | Table API |
| ---------------------- | --------- | ------------- | ------------------------------- | ----------- | --------- |
| Azure Cosmos container | Container | Table         | Collection                      | Graph       | Table     |



| Cosmos entity     | SQL API | Cassandra API | Azure Cosmos DB API for MongoDB | Gremlin API  | Table API |
| ----------------- | ------- | ------------- | ------------------------------- | ------------ | --------- |
| Azure Cosmos item | Item    | Row           | Document                        | Node or edge | Item      |



## Throughput

- Configure throughput in one of the following modes:
  - **Provisioned throughput mode**
    - Provision the number of RUs for your application on a per-second basis  in increments of 100 RUs per second
    - Can increase or decrease the number of RUs at any time
    - You can set on a container level or a database level. The latter is shared between all containers in the database which have not had the throughput specifically set upon them
  - **Serverless mode**:
    - No provision of throughput
    - Billed for the  amount of Request Units that has been consumed
  - **Autoscale mode**
    - Automatically and instantly scale the throughput (RU/s) of your database or container based on it's usage, without impacting the availability,  latency, throughput, or performance of the workload
    - This mode is well  suited for mission-critical workloads that have variable or unpredictable traffic patterns, and require SLAs on high performance and scale
- 
  - **Dedicated provisioned throughput mode**
    - Throughput is exclusively reserved for that  container and backed by the SLAs
  - **Shared provisioned throughput mode**
    - Containers share the provisioned throughput with the other containers in the same database  (excluding dedicated containers)
- Throughput mode cannot be edited after the container is created



## Global Distribution

- Cosmos DB transparently replicates the data to all the regions associated with your Cosmos account
- Can edit associated regions to an account at any time
- Enable regions closer to users to reduce latency
- Cosmos DB offers single-digit millisecond reads and writes in all regions.



## Consistency 

- Default consistency is set against an Azure Cosmos account and applies to all databases and containers underneath
- Consistency can be relaxed on a request basis via the API call
- Consistency levels are region-agnostic and are guaranteed for all  operations regardless of the region from which the reads and writes are  served
- The following consistency levels are supported from strongest to weekest
  - **Strong**  all readers read the latest values immediately after a write
  - **Bounded Staleness** all readers are guaranteed to see data no older than T time or K versions
    - For a single region account, the minimum value of *K* and *T* is 10 write operations or 5 seconds. For multi-region accounts the minimum value of *K* and *T* is 100,000 write operations or 300 seconds.
  - **Session** reads are strong for a read after a write in that session, other readers as as per bounded staleness
  - **Consistent Prefix**  has ordering guarantee for reads. The reader will never see data which is older than they have already seen. ABC and never BAC
  - **Eventual** has no ordering guarantee for reads. A reader might see value which are older than what they have seen before. ABC or BAC are both possible
- The stronger the greater the write latency



## High Availability

- Data is replicated across regions configured
- Data is replicated 4 times within a region, and they are distributed across as many as 10-20 fault domains
- During an outage of write region
  - If multi region is supported and enable automatic failover is enabled at the Azure Cosmo account level, Azure will automatically promote a secondary region to be the new primary write region
  - Once the effected region comes back online, conflicting writes which were not committed are available the conflicts feeds
  - The effected region can be made the primary write region but it will not happen automatically
- During an outage of a read region
  - The region is marked as off line and calls will be automatically touted to the next available region or the write region if none are available
  - Subsequent reads will automatically go to the region once it is back online
- **Availability Zone support**, Azure Cosmos DB will ensure replicas are  placed across multiple zones within a given region to provide high  availability and resiliency during zonal failures
  - Free opt in when configuring multi region writes



## Conflicts and Resolution Policies

- Conflicts and conflict resolution policies are applicable if your Azure  Cosmos DB account is configured with multiple write regions.
- The following policies are configured
  - **Last Write Wins (LWW)**: This resolution policy, by default, uses a system-defined timestamp property
  - **Custom**: This resolution policy is designed for  application-defined semantics for reconciliation of conflicts. When you  set this policy on your Azure Cosmos container, you also need to  register a *merge stored procedure*



## Security

- All user data stored in Azure Cosmos DB is encrypted at rest and in transport
- Uses AES-256 encryption in all regions for data at rest
  - By default the keys are managed by Microsoft but you can provide your own via customer manage keys
- Azure Cosmos DB provides built-in role-based access control (RBAC) for common management scenarios in Azure Cosmos DB (control plane)
- Azure Cosmos DB uses two types of keys to authenticate users and provide access to its data and resources (data plane)
  - Master Keys are used for administrative resources: database accounts, databases, users, and permissions
  - Resources Tokens are used for application resources: containers, documents, attachments, stored procedures, triggers, and UDFs
- Detect suspicious activities which indicate unusual and potentially harmful attempts to access or exploit databases with **Advanced Threat Protection**



## Pricing

- Can try for free without an Azure account
-  Azure Cosmos DB free tier has the first 400 RU/s and 5 GB of storage free
- *Request Units* (or RUs, for short) is a performance currency abstracting the system resources such as CPU, IOPS
  - Reading a 1 KB item is 1 Request Unit
- Elastically scale the provisioned throughput and storage  for your databases according to your needs and only pay for the  throughput and storage needed.
- Cosmos DB throughput per second and request unit consumption varies by operation and JSON document.
- Additional backup copies will be billed as total GBs of data stored *(first two copies are free)*.
- You provision the number of RUs for your application on a  per-second basis in increments of 100 RUs per second. You are billed on  an hourly basis.
- With autoscale for containers, you pay per hour for the highest RU/s that the system scaled up to within the hour
- Currently, you can create a maximum of 50 Azure Cosmos accounts under an Azure subscription (this is a soft limit that can be increased via  support request)



## Sources

- https://docs.microsoft.com/en-us/azure/cosmos-db/introduction