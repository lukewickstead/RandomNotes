# Azure Storage Accounts
[toc]
## Overview 
- https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
- An Azure storage account can contain blob, files, queries, tables and disks
- Provides a unique namespace allowing the data to be accessed from anywhere in the world va HTTP or HTTPS
## Storage Account Types
- **General-purpose v2 accounts**: Basic storage account type for blobs, files, queues, and tables. Recommended for most scenarios using Azure Storage.
- **General-purpose v1 accounts**: Legacy account type for blobs, files, queues, and tables. Use general-purpose v2 accounts instead when possible.
- **BlockBlobStorage accounts**: Storage accounts with  premium performance characteristics for block blobs and append blobs.  Recommended for scenarios with high transactions rates, or scenarios  that use smaller objects or require consistently low storage latency.
- **FileStorage accounts**: Files-only storage accounts  with premium performance characteristics. Recommended for enterprise or  high performance scale applications.
- **BlobStorage accounts**: Legacy Blob-only storage accounts. Use general-purpose v2 accounts instead when possible.
## Access Tiers
- https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers?tabs=azure-portal
- Only hot and cool can be set at the account level
- All tiers can be set at the blob level during of after upload
- Hot
  - Frequently accessed data
  - New storage accounts are defaulted to this tier
  - Highest storage cost with lowest access cost
- Cool
  - Optimised for large amounts of data that is infrequently used and stored for at least 30 days
  - More cost effective than hot but access costs are more expensive
- Archive
  - Lowest storage costs but with the highest access costs
  - Only available for individual blocks
  - Can take many hours for retrieval
  - Extra costs if the data is removed within 180 days
## Performance Tiers
- https://docs.microsoft.com/en-us/azure/storage/common/scalability-targets-standard-account
- https://docs.microsoft.com/en-us/azure/storage/blobs/scalability-targets-premium-page-blobs
- Depending upon the account type a performance tier of standard and premium can be selected
- **Standard performance tier** for storing blobs, files, tables, queues, and Azure virtual machine disks.
- **Premium performance tier** for storing unmanaged virtual machine  disks. Microsoft recommends using managed disks with Azure virtual  machines  instead of unmanaged disks. 
## Redundancy 
- https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
- **Locally redundant storage (LRS)**: A simple, low-cost redundancy  strategy. Data is copied synchronously three times within the primary  region.
- **Zone-redundant storage (ZRS)**: Redundancy for scenarios requiring  high availability. Data is copied synchronously across three Azure  availability zones in the primary region.
- **Geo-redundant storage (GRS)**: Cross-regional redundancy to protect  against regional outages. Data is copied synchronously three times in  the primary region, then copied asynchronously to the secondary region.  For read access to data in the secondary region, enable **read-access  geo-redundant storage (RA-GRS).**
- **Geo-zone-redundant storage (GZRS)** (preview): Redundancy for  scenarios requiring both high availability and maximum durability. Data  is copied synchronously across three Azure availability zones in the  primary region, then copied asynchronously to the secondary region. For  read access to data in the secondary region, enable read-access  geo-zone-redundant storage (RA-GZRS).
##  Storage accounts and their capabilities
| Storage account type | Supported services                                  | Supported performance tiers | Supported access tiers | Replication options                                       | Deployment model1         | Encryption2 |
| -------------------- | --------------------------------------------------- | --------------------------- | ---------------------- | --------------------------------------------------------- | ------------------------- | ----------- |
| General-purpose V2   | Blob, File, Queue, Table, Disk, and Data Lake Gen26 | Standard, Premium5          | Hot, Cool, Archive3    | LRS, GRS, RA-GRS, ZRS, GZRS (preview), RA-GZRS (preview)4 | Resource Manager          | Encrypted   |
| General-purpose V1   | Blob, File, Queue, Table, and Disk                  | Standard, Premium5          | N/A                    | LRS, GRS, RA-GRS                                          | Resource Manager, Classic | Encrypted   |
| BlockBlobStorage     | Blob (block blobs and append blobs only)            | Premium                     | N/A                    | LRS, ZRS4                                                 | Resource Manager          | Encrypted   |
| FileStorage          | File only                                           | Premium                     | N/A                    | LRS, ZRS4                                                 | Resource Manager          | Encrypted   |
| BlobStorage          | Blob (block blobs and append blobs only)            | Standard                    | Hot, Cool, Archive3    | LRS, GRS, RA-GRS                                          |                           |             |
## Locally Redundant Storage (LRS) vs Zone-Redundant Storage (ZRS) vs Geo-Redundant Storage (GRS)
|                                                              | **Locally-Redundant Storage (LRS)**                          | **Zone Redundant Storage    ** **(ZRS)**                     | **Geo-redundant storage     (GRS)**                          |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Replication                                                  | Replicates your data 3 times within a single physical location synchronously in the primary region. | Replicates your data across 3 Azure Availability Zones synchronously in the primary region | Replicates your data in your storage account to a secondary region |
| Redundancy                                                   | Low                                                          | Moderate                                                     | High                                                         |
| Cost                                                         | Provides the least expensive replication option              | Costs more than LRS but provides higher availability         | Costs more than ZRS but provides availability in the event of regional outages |
| Percent durability of objects over a given year              | At least 99.999999999% (11 9’s)                              | At least 99.9999999999% (12 9’s)                             | At least 99.99999999999999% (16 9’s)                         |
| Availability SLA for read requests                           | At least 99.9% (99% for cool access tier)                    | At least 99.9% (99% for cool access tier)                    | At least 99.9% (99% for cool access tier) for GRS At least 99.99% (99.9% for cool access tier) for RA-GRS |
| Availability SLA for write requests                          | At least 99.9% (99% for cool access tier)                    | At least 99.9% (99% for cool access tier)                    | At least 99.9% (99% for cool access tier)                    |
| Available if a node went down within a data center?          | Yes                                                          | Yes                                                          | Yes                                                          |
| Available if the entire data center (zonal or non-zonal) went down? |                                                              | Yes                                                          | Yes                                                          |
| Available on region-wide outage in the primary region?       |                                                              |                                                              | Yes                                                          |
| Has read access to the secondary region if the primary region is unavailable? |                                                              |                                                              |                                                              |
## Billing 
- Billed based on storage account usage
- https://azure.microsoft.com/en-gb/pricing/details/storage/
- Storage costs are calculated according to the following factors:
  - **Region** refers to the geographical region in which your account is based.
  - **Account type** refers to the type of storage account you're using.
  - **Access tier** refers to the data usage pattern you've specified for your general-purpose v2 or Blob storage account.
  - Storage **Capacity** refers to how much of your storage account allotment you're using to store data.
  - **Replication** determines how many copies of your data are maintained at one time, and in what locations.
  - **Transactions** refer to all read and write operations to Azure Storage.
  - **Data egress** refers to any data transferred out of  an Azure region. When the data in your storage account is accessed by an application that isn't running in the same region, you're charged for  data egress.
## Security
- All storage accounts are encrypted using Storage Service Encryption (SSE) for data at res
- Access can be granted by Azure AD, Share Key authorisation and Shared access signature (SAS Key)
## Copying Data In
- Data can be copied into or between storage accounts with the following tools
	- AzCopy is a windows command line tool
	  - Cannot delete or move files
	- Azure Storage data movement library for .NET
	- REST API or client library
	  - 	Client libraries for multiple languages and platforms like .NET, Java, C++, Node.JS, PHP, Ruby, and Python.

## Access Limits

- When your application reaches the limit of what a partition can handle  for your workload, Azure Storage will begin to return error code 503  (Server Busy) or error code 500 (Operation Timeout) responses. When this occurs, the application should use an exponential backoff policy for  retries. The exponential backoff allows the load on the partition to  decrease, and to ease out spikes in traffic to that partition.