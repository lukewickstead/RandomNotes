# Azure Cloud Concepts

[toc]

## Overview

- Terminologies of the cloud: **High Availability, Fault Tolerance, Disaster Recovery, Scalability, Elasticity,** and **Agility**



## Capital Expenditure (CapEx) & Operational Expenditure (OpEx)

- **Capital Expenditure (CapEx)**

  - Upfront cost on physical infrastructure
  - You need to plan your expenses at the start of a project or budget period

- **Operational Expenditure (OpEx)**

  - No upfront cost but you pay for the service/product as you use it
  - OpEx is particularly appealing if the demand fluctuates or is unknown


![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F08%2FCapEx-vs-OpEx.png)                           



## High Availability

- If hardware fails, you can get a new, exact copy of it in very little time
- Use clusters *(a group of virtual machines)* to ensure high availability



## Fault Tolerance

- Fault tolerance is part of the resilience of cloud computing

- **Zero Down-Time** – if one component fails, a backup component takes its place



## Disaster Recovery

- Plan to recover critical business systems:
  - **Recovery Time Objective (RTO)** is the time it takes after a disruption to restore business process to its service level
  - **Recovery Point Objective (RPO)** is the acceptable amount of data loss measured in time before the disaster occurs
- Services for backup and disaster recovery:
  - **Azure Backup – simplify data protection while saving costs**
  - Azure Site Recovery – keep your business running with disaster recovery service
  - Azure Archive Storage – store rarely used data in the cloud



## Scalability

- You may increase or decrease the resources and services used at any given time, depending on the demand or workload.
  - **Vertical Scaling – adding resources to increase the power of an existing server**
  - **Horizontal Scaling** – adding more servers that function together as one unit
- Use **scale sets** for critical scenarios



## Elasticity

- Quickly expand or decrease computing resources
- Automatically **allocates more computing resources** to handle the increased traffic. When the traffic begins to normalize, the cloud automatically **de-allocates the additional resources to minimize cost**



## Agility

- The ability to design, test, and launch software applications quickly that stimulate business growth.
- Cloud agility enables companies to concentrate on other  concerns such as security, monitoring, and analysis, instead of  provisioning and maintaining the resources.



## LRS vs ZRS vs GRS



|                                                              | **Locally-Redundant Storage (LRS)**                          | **Zone Redundant Storage    ** **(ZRS)**                     | **Geo-redundant storage     (GRS)**                          |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Replication                                                  | Replicates your data 3 times within a single physical location synchronously in the primary region. | Replicates your data across 3 Azure Availability Zones synchronously in the primary region | Replicates your data in your storage account to a secondary region |
| Redundancy                                                   | Low                                                          | Moderate                                                     | High                                                         |
| Cost                                                         | Provides the least expensive replication option              | Costs more than LRS but provides higher availability         | Costs more than ZRS but provides availability in the event of regional outages |
| Percent durability of objects over a given year              | At least 99.999999999% (11 9’s)                              | At least 99.9999999999% (12 9’s)                             | At least 99.99999999999999% (16 9’s)                         |
| Availability SLA for read requests                           | At least 99.9% (99% for cool access tier)                    | At least 99.9% (99% for cool access tier)                    | At least 99.9% (99% for cool access tier) for GRS At least 99.99% (99.9% for cool access tier) for RA-GRS |
| Availability SLA for write requests                          | At least 99.9% (99% for cool access tier)                    | At least 99.9% (99% for cool access tier)                    | At least 99.9% (99% for cool access tier)                    |
| Available if a node went down within a data center?          | Yes                                                          | Yes                                                          | Yes                                                          |
| Available if the entire data center (zonal or non-zonal) went down? | No                                                           | Yes                                                          | Yes                                                          |
| Available on region-wide outage in the primary region?       | No                                                           | No                                                           | Yes                                                          |
| Has read access to the secondary region if the primary region is unavailable? |                                                              |                                                              |                                                              |



## Sources

- https://docs.microsoft.com/en-us/azure/storage/common/storage-redundanc
- https://docs.microsoft.com/en-us/learn/modules/principles-cloud-computing/3c-capex-vs-opex