## LRS vs ZRS vs GRS

[toc]

## Comparison

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

## Sources

- https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy