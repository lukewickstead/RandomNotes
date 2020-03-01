# AWS NoSQL Databases

## Amazon DynamoDB

- A cloud native database for managing volumes of records and transactions without the need for provisioning capacity upfront
- A full managed service
- Supports both document and key stor object


## Amazon Elasticache

- A managed data cache service built from the open source Redis and Memcached database engines
- Provides a front line cache to response to read requests made to an application or database
- The purpose of a cache is generally to act as a fast access copy of data that is begin read a lot
- Redis
  - Use for features
  - You need complex data types, such as string, hashes, lists, sets, sorted sets, bitmaps
  - You need persistence of your store
  - You need to encrypt your cache data ( eg to maintain compliance)
  - You need to replicate your cached data
- Memcached
  - For simplicity and speed
  - You need the simplest model possible
  - You need to rnu large nodes with multiple cores or threads
  - You need the ability to scale out/in, adding and removing nodes as demand on your system increases and decreases
- For comparison of features
  - https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/SelectEngine.html


## Amazon Neptune

- Native graph database engine optimized for storing data relationships and querying a graph quickly and efficiently
- Suits use cases such as knowledge graphs, recommendation engines and network security
- Supports graph models
  - Property Graph
  - W3C RDF
- Supports Languages
  - Apache
  - TinkerPop
  - Gremlin
  - SPARQL 