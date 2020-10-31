# Azure Table Storage
[toc]
## Overview
- A NoSQL key-value store for large semi-structured datasets.
- Supports flexible data schema.
- Performs OData-based queries
- https://azure.microsoft.com/en-us/services/storage/tables
- https://docs.microsoft.com/en-us/azure/storage/tables/table-storage-overview
## Features
- Allows you to store and query huge sets of structured, non-relational data. And as demand grows, your tables will scale-out.
- Scale-up without having to manually shard your dataset.
- The data is replicated three times within a region using geo-redundant storage.
- An **entity** has a limit of 1MB in size.
- Store data sets that do not require complex joins, foreign keys, or stored procedures, and can be denormalized for fast access.
- Table storage is used to store flexible data sets such as user data for web applications, device information, or other types of  metadata the service requires.
- You can store any number of entities in a table, up to the storage account’s capacity limit.
- Every entity stored in a table must have a unique combination of `PartitionKey` and `RowKey`
- The account name, table name, and `PartitionKey` together identify the partition within the storage service where Table storage stores the entity
### Capacity considerations
The following table includes some of the key values to be aware of when you're designing a Table storage solution:
| Total capacity of an Azure storage account   | 500 TB                                                       |
| -------------------------------------------- | ------------------------------------------------------------ |
| Number of tables in an Azure storage account | Limited only by the capacity of the storage account.         |
| Number of partitions in a table              | Limited only by the capacity of the storage account.         |
| Number of entities in a partition            | Limited only by the capacity of the storage account.         |
| Size of an individual entity                 | Up to 1 MB, with a maximum of 255 properties (including the `PartitionKey`, `RowKey`, and `Timestamp`). |
| Size of the `PartitionKey`                   | A string up to 1 KB in size.                                 |
| Size of the `RowKey`                         | A string up to 1 KB in size.                                 |
| Size of an entity group transaction          | A transaction can include at most 100 entities, and the payload must be less than 4 MB in size. An EGT can only update an entity once. |