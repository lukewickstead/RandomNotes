# Azure Blob Storage
[toc]
## Overview
- Binary Large Object (BLOB)
- Blob storage is optimized for storing massive amounts of unstructured  data
- Unstructured data is data that doesn't adhere to a particular data model or definition, such as text or binary data.
- Blobs are seperated into containers which are assigned to an Azure storage account
- A storage account can contain an unlimited amount of containers
- A container can contain an unlimited amount of blobs
- Soft delete for blobs protects your data from being accidentally or erroneously modified or deleted
## Root Container
- A root container serves as a default container for your storage account
- A storage account may have one root container
- The root container must  be explicitly created and must be named `$root`
- A blob in the root container cannot include a forward slash (/) in its  name.
- Specifically, you should avoid blob names that end with a dot (.), a forward slash (/), or a sequence or combination of the two as the  blob name may be mistaken for a container name. 
## Blob Types
- Block blobs store text and binary data. Block blobs are made up of blocks of data that can be managed individually. Block blobs store up to about 4.75 TiB of data. Larger block blobs are available in preview, up to about 190.7 TiB
- Append blobs are made up of blocks like block blobs, but are optimized for append operations. Append blobs are ideal for scenarios such as logging data from virtual machines
  - To perform a partial update to the content of a block blob, use the Put  Block List operation. In contrast, using the Put Blob operation creates a new block, or updates the content of an existing block blob by  overwriting existing block blob metadata.
- Page blobs store random access files up to 8 TB in size. Page blobs store virtual hard drive (VHD) files and serve as disks for Azure virtual machines. For more information about page blobs
## Moving Data Into Blob storage
- AzCopy
- Azure Storage Data Movement library
- Azure Data Factory
- Blobfuse is a virtual file system driver for Azure Blob storage. You can use blobfuse to access your existing block blob data in your Storage account through the Linux file system. 
- Azure Data Box service is available to transfer on-premises data to Blob storage when large datasets or network constraints make uploading data over the wire unrealistic. Microsoft send a physical box for your to copy your data onto
- The Azure Import/Export service provides a way to import or export large amounts of data to and from your storage account using hard drives that you provide
## Lifecycle Management Policy
- Allows moving blobs between tiers (hot, cold archive) based upon their last usage in days
- Blobs can be Deleted at the end of their lifecycle

## Immutable Blobs

- Immutable storage for Azure Blob storage enables users to store  business-critical data objects in a WORM (Write Once, Read Many) state
- This state makes the data non-erasable and non-modifiable for a  user-specified interval
- For the duration of the retention interval,  blobs can be created and read, but cannot be modified or deleted.
- **Time-based retention policy support:** Users can set policies to store  data for a specified interval. When a time-based retention policy is  set, blobs can be created and read, but not modified or deleted. After  the retention period has expired, blobs can be deleted but not  overwritten.
- **Legal hold policy support**: If the retention interval is not known,  users can set legal holds to store immutable data until the legal hold  is cleared. When a legal hold policy is set, blobs can be created and  read, but not modified or deleted. Each legal hold is associated with a  user-defined alphanumeric tag (such as a case ID, event name, etc.) that is used as an identifier string.

## Versioning

- You can enable Blob storage versioning to automatically maintain previous versions of an object.
- Can restore to a previous version even if the  blob is deleted
- Enabled on the container and applies to all blobs
- Prefer versioning over snapshots as their maintenance is automatic
## Blob Snapshots
- A snapshot is a read-only version of a blob that's taken at a point in time.
- Requires yor application to create and maintain them
- They persist even after the blob was deleted
 A snapshot of a blob is identical to its base blob, except that the blob URI has a DateTime value appended to the blob URI to indicate the time at which the snapshot was taken
 Properties and meta data are also copied unless overridden
 Leases to blobs are not applied to a snapshot
 Leases can not be made to snapshots
 - You can read, copy, or delete it, but you cannot modify it.
 - VHDs uses this service to allow going back to an point in time
## Object Replication For Block Blobs
- Object replication asynchronously copies block blobs between a source storage account and a destination account
- Minimizing latency. Object replication can reduce latency for read requests by enabling clients to consume data from a region that is in closer physical proximity.
- Increase efficiency for compute workloads. With object replication, compute workloads can process the same sets of block blobs in different regions.
- Optimizing data distribution. You can process or analyze data in a single location and then replicate just the results to additional regions.
- Optimizing costs. After your data has been replicated, you can reduce costs by moving it to the archive tier using life cycle management policies.
## Deleting A Blob

- Upon successful deletion of a blob using the Delete Blob operation, status code 202 (Accepted) appears. The blob is immediately removed from the storage account's index and is no longer accessible to clients. However, the data will remain until garbage collection is performed to reclaim objects that are no longer being used.

## Static Website Hosting

- Static websites can be hosted i blob storage
- Azure Content Delivery Network can be used to cache the static resources
- Add headers and append (or overwrite) header values. See Standard rules engine reference for Azure CDN
## Security
- Encryption can be one of 
- Microsoft managed keys
  - Uses 256bit AES encryption
  - MS store and rotate keys
  - For all storage types
- Customer managed
  - 		Blob storage and Azure files
  - 		Key stored in Azure key vault
  - 		Rotate and manage the keys yourself
- Customer provided key
  - 	For blob storage only
  - 	Store the key yourself
  - 	Rotate and manage the keys yourself