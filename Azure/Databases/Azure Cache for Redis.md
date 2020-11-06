# Azure Cache for Redis

[toc]

## Overview 

- Azure Cache for Redis provides an in-memory data store based on the [Redis](https://redis.io/) software
-  Redis improves the performance and scalability of an application that uses on backend data stores heavily
- Keeps frequently accessed data in the server memory that can be written to and read from quickly
- Azure Cache for Redis offers both the Redis open-source and a commercial product from Redis Labs as a managed service.



## Service Tiers

Azure Cache for Redis is available in the following tiers:

| Tier             | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| Basic            | An OSS Redis cache running on a single VM. This tier has no  service-level agreement (SLA) and is ideal for development/test and  non-critical workloads. |
| Standard         | An OSS Redis cache running on two VMs in a replicated configuration. |
| Premium          | High-performance OSS Redis caches. This tier offers higher  throughput, lower latency, better availability, and more features.  Premium caches are deployed on more powerful VMs compared to those for  Basic or Standard caches. |
| Enterprise       | High-performance caches powered by Redis Labs' Redis Enterprise  software. This tier supports Redis modules including RediSearch,  RedisBloom, and RedisTimeSeries. In addition, it offers even higher  availability than the Premium tier. |
| Enterprise Flash | Cost-effective large caches powered by Redis Labs' Redis Enterprise  software. This tier extends Redis data storage to non-volatile memory,  which is cheaper than DRAM, on a VM. It reduces the overall per-GB  memory cost. |



## Feature Comparison



| Feature Description                                          | Basic | Standard | Premium | Enterprise | Enterprise Flash |
| ------------------------------------------------------------ | :---: | :------: | :-----: | :--------: | :--------------: |
| [Service Level Agreement (SLA)](https://azure.microsoft.com/support/legal/sla/cache/v1_0/) |   -   |    ✔     |    ✔    |     ✔      |        ✔         |
| Data encryption                                              |   ✔   |    ✔     |    ✔    |     ✔      |        ✔         |
| [Network isolation](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-vnet) |   ✔   |    ✔     |    ✔    |     ✔      |        ✔         |
| [Scaling](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-scale) |   ✔   |    ✔     |    ✔    |     ✔      |        ✔         |
| [Zone redundancy](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-zone-redundancy) |   -   |    -     |    ✔    |     ✔      |        ✔         |
| [Geo-replication](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-geo-replication) |   -   |    -     |    ✔    |     -      |        -         |
| [Data persistence](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-persistence) |   -   |    -     |    ✔    |     -      |        -         |
| [OSS cluster](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-clustering) |   -   |    -     |    ✔    |     ✔      |        ✔         |
| [Modules](https://redis.io/modules)                          |   -   |    -     |    -    |     ✔      |        -         |
| [Import/Export](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-import-export-data) |   -   |    -     |    ✔    |     ✔      |        ✔         |
| [Scheduled updates](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-administration#schedule-updates) |   ✔   |    ✔     |    ✔    |     -      |        -         |



## High availability for Azure Cache for Redis

- Azure Cache for Redis has built-in high availability
- Implements high availability by using multiple VMs, called *nodes*, for a cache



| Option                                                       | Description                                                  | Availability                                               | Standard | Premium | Enterprise |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------------------------------------------------- | :------: | :-----: | :--------: |
| [Standard replication](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-high-availability#standard-replication) | Dual-node replicated configuration in a single datacenter or availability zone (AZ), with automatic failover | 99.9%                                                      |    ✔     |    ✔    |     -      |
| [Enterprise cluster](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-high-availability#enterprise-cluster) | Linked cache instances in two regions, with automatic failover | 99.9%                                                      |    -     |    -    |     ✔      |
| [Zone redundancy](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-high-availability#zone-redundancy) | Multi-node replicated configuration across AZs, with automatic failover | 99.95% (standard replication), 99.99% (Enterprise cluster) |    -     |    ✔    |     ✔      |
| [Geo-replication](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-high-availability#geo-replication) | Linked cache instances in two regions, with user-controlled failover | 99.9% (for a single region)                                |    -     |    ✔    |     -      |



## Eviction Policies

The exact behavior Redis follows when the `maxmemory` limit is reached is configured using the `maxmemory-policy` configuration directive.

The following policies are available:

- **noeviction**: return errors when the  memory limit was reached and the client is trying to execute commands  that could result in more memory to be used (most write commands, but [DEL](https://redis.io/commands/del) and a few more exceptions).
- **allkeys-lru**: evict keys by trying to remove the less recently used (LRU) keys first, in order to make space for the new data added.
- **volatile-lru**: the default evict keys by trying to remove the less recently used (LRU) keys first, but only among keys that have an **expire set**, in order to make space for the new data added.
- **allkeys-random**: evict keys randomly in order to make space for the new data added.
- **volatile-random**: evict keys randomly in order to make space for the new data added, but only evict keys with an **expire set**.
- **volatile-ttl**: evict keys with an **expire set**, and try to evict keys with a shorter time to live (TTL) first, in order to make space for the new data added.