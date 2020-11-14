# ElastiCache

[toc]

## Overview

- Amazon ElastiCache is a service that makes it easy to  deploy, operate, and scale open-source, in-memory data stores in the  cloud
- This service improves the performance through caching, allowing you to retrieve information from fast managed in-memory data stores instead of relying entirely on slower disk-based solutions
- ElastiCache supports both **Memcached** and the **Redis** engines, so existing applications can be easily moved to ElastiCache



## Memcached

- Amazon ElastiCache for Memcached is a high-performance sub-millisecond latency Memcached-compatible in-memory key store service that can either be used as a cache in addition to a data store
- Use for caching and Session Store
- For simplicity and speed
- You need the simplest model possible
- You need to run large nodes with multiple cores or threads
- You need the ability to scale out/in, adding and removing nodes as demand on your system increases and decreases



## Redis

- Amazon ElastiCache for Redis is purely an in-memory data store designed for high performance and again  providing sub-millisecond latency on a huge scale to real-time  applications

- Used for caching, session store,  chat and messaging,  gaming leaderboards,  geospatial, machine learning, media streaming, queues, real-time analytics

- Offers a more robust set of features

- Use for features

- You need complex data types, such as string, hashes, lists, sets, sorted sets, bitmaps

- You need persistence of your store

- You need to encrypt your cache data ( eg to maintain compliance)

- You need to replicate your cached data

- Supports cluster mode
  - When cluster mode is disabled, each cluster will have just a single shard
  - When cluster mode enabled, each cluster can have up to  90 shards

- Features

  - Automatic detection and recovery from cache node failures
  - Multi-AZ with automatic failover of a failed primary cluster to a read replica in Redis clusters that support replication
  - Redis (cluster mode enabled) supports partitioning your data across up to 250 shards
  - Redis supports in-transit and at-rest encryption with authentication so you can build HIPAA-compliant applications
  - Flexible Availability Zone placement of nodes and clusters for increased fault tolerance
  - Data is persistent
  - Can be used as a datastore
  - Not multi-threaded
  - Amazon ElastiCache for Redis supports self-service updates, which allows you to apply service updates at the time of your choosing and track the progress in real-time

  

## Nodes

- A cache node is a fixed sized chunk of secure network attached RAM
- Cache nodes themselves can be launched using a variety of different  instance types
- A node can exist in isolation from or in some relationship to other nodes
- Every node within a cluster is the same instance type and runs the same cache engine
- Each cache node has its own Domain Name Service (DNS) name and port



## Clusters & Shards

#### Redis Clusters & Shards

- A Redis shard, also known as a node group when working with the API and CLI, is a group of up to 60  ElastiCache nodes
- A Redis cluster contains between one  and 90 Redis shards, depending on if cluster mode is enabled or disabled
- Data is then partitioned across all of the shards in that  cluster



####  Memcached Clusters

- Clusters are a collection of one  or more cache nodes
- Once you've provisioned a cluster, Amazon  ElastiCache automatically detects and replaces failed nodes, which helps reduce the risk of overloaded database, and therefore reduces the  website and application load times.



## Use Cases

- Online gaming industry where it's vital that statistical information like a scoreboard is presented  as quickly and as consistently as possible to all the players in the  game
- Social networking sites, where they need a  way to store temporary session information in session management
- Real-time analytics is also a great use for ElastiCache, as it can be used in conjunction with other services such as Amazon Kinesis to  ingest, process, and analyze data at scale
- Should **not** be used when persistence is required



## Sources

- https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/SelectEngine.html
- https://docs.aws.amazon.com/elasticache/?id=docs_gateway
- https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug
- https://aws.amazon.com/elasticache/redis-details
- https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug
- https://aws.amazon.com/elasticache/redis-vs-memcached
- https://aws.amazon.com/elasticache/features
- https://aws.amazon.com/elasticache/pricing