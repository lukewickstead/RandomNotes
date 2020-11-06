# Azure Archive Storage
[toc]
## Overview
- Store rarely accessed data which are held for a period of 180 days
- Snapshots are not applicable to archive storage

  

## Features
- It supports 2 rehydrate priorities: **High** and **Standard**
  - **Standard (Default)** – rehydration request may take up to 15 hours.
  - **High** – rehydration request may finish in under 1 hour for objects under 10 GB in size.
- Long-term backup, secondary backup, and archival datasets
- Lowest storage costs but the highest data rehydrate and access costs
- To read data in archive storage, you need to change the blob tier to hot or cold first.
- Compliance and archival data that must be preserved and are hardly ever accessed.
- Archive storage only supports block blobs
- If a blob is in the archive tier, it can’t be overwritten, unlike in hot or cool tier
- Archive storage cannot be set as a default account access tier
- Archive storage is initially available in selected regions.
- Blob index tags can be read, set, or modified while in the archive.
- You can only copy archive blobs within the same storage account.
- Encrypted data transfer to the cloud using HTTPS, and using 256-bit AES keys to automatically protect the data at rest.



## Use Cases

- It is mainly used in long-term backup retention
- If you need to minimize your cost, use Archive Storage to create a low cost, content archiving solution.
- Archive storage provides secure, globally compliant storage for sensitive data.
- You can also use Archive storage if you have a large amount of data that needs to be preserved.



## Pricing

- Blobs are stored for at least 180 days in the archive  tier. Deleting or rehydrating archived blobs before the minimum number  of days will incur early deletion fees.
- Charges on data access increases as the tier gets cooler. For  data in the cool and archive access tier, you’re charged a per-gigabyte  data access charge for reads.



## Sources

- https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers?tabs=azure-portal
- https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-rehydration?tabs=azure-portal