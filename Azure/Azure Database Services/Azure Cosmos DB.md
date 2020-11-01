# Azure Cosmos DB
[toc]
## Overview

- Globally distributed database that supports NoSQL
- A fully-managed database service with **turnkey global distribution** and transparent **multi-master replication**
## Features
- Cosmos DB offers encryption at rest.
- It replicates every partition across all the regions.
- CosmosDB offers single-digit millisecond reads and writes in all regions.
- Supports automatic failover during a regional outage.
- Consistency Levels: **Strong, Bounded Staleness, Session, Consistent Prefix,** and **Eventual**
- You can set either standard (manual) or **autoscale** provisioned throughput on your databases and containers
- Monitor both the provisioned autoscale max RU/s and the current throughput (RU/s) of the system with **Azure Monitor** metrics.
## Consistency Levels
- **Strong – reads are guaranteed to return the most recent committed version of an item.**
- **Bounded Staleness** – is for low write latencies but requires a total global order guarantee.
- **Session – reads are guaranteed to honor the  consistent-prefix, monotonic reads, monotonic writes, read-your-writes,  and write-follows-reads guarantees.**
- **Consistent Prefix** – updates that are returned will contain some prefix of all the updates.
- **Eventual** – has no ordering guarantee for reads.
## Security
- Encryption at rest is applied automatically.
- Uses AES-256 encryption in all regions.
- You can use the keys that are managed by Microsoft or customer-managed keys.
- Two types of keys to authenticate users:
  - Master Keys for administrative resources.
  - Resources Tokens for application resources.
- Detect suspicious activities which indicate unusual and potentially harmful attempts to access or exploit databases with **Advanced Threat Protection**.
## Pricing
- Elastically scale the provisioned throughput and storage  for your databases according to your needs and only pay for the  throughput and storage needed.
- Cosmos DB throughput per second and request unit consumption varies by operation and JSON document.
- Additional backup copies will be billed as total GBs of data stored *(first two copies are free)*.
- You provision the number of RUs for your application on a  per-second basis in increments of 100 RUs per second. You are billed on  an hourly basis.
- With autoscale for containers, you pay per hour for the highest RU/s that the system scaled up to within the hour
## Sources
- https://docs.microsoft.com/en-us/azure/cosmos-db/introduction