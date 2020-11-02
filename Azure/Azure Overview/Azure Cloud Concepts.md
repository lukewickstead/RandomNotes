# Azure Cloud Concepts

[toc]

## Overview

- Terminologies of the cloud: **High Availability, Fault Tolerance, Disaster Recovery, Scalability, Elasticity,** and **Agility**

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

## Sources

- https://azure.microsoft.com/en-us/solutions/backup-and-disaster-recovery
- https://azure.microsoft.com/en-us/solutions/backup-and-disaster-recovery/#related-products