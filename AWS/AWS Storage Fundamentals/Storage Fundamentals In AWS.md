# Storage Fundamentals for AWS

- Block Storage
  - Data is stored in chunks known as blocks
  - Blocks are stored on a volume and attached to a single instance
  - Provide avery low latency data access
  - Comparable to DAS storage used in premises
- File Storage
  - Data is stored as separate files with a series of directories
  - Data is stored within a file system
  - Shared access is provided for multiple users
  - Comparable to NAS storage used on premises
- Object Storage
  - Objects are stored across a flat address space
  - Objects are referenced by a unique key
  - Each object can also have associated metadata to help categorize and identify the object


## Amazon Simple Storage Service (S3)

- A fully managed object based storage service
- Highly available
- Highly durable
- Very cost effective
- Widely and easily accessible
- Unlimited storage capacity
- Highly scalable
- Smallest file size supported = 0 bytes
- Largest file size supported = 5 terabytes

### Regional Base

 - Specify region
 - Data copied to multiple AZs in that region for durability

### Durability & Availability

- Objects stored in S3 have a durability of 99.999999999%
- S3 stored numerous copies of the same data in different AZs
- The availability of S3 data objects is 99.99%
- Availability assured by Amazon of Amazon S3 is 99.99% of the time
- Durability is the probability of maintaining your data without being lost

### S3 Buckets

- Objects are stored in S3 buckets
- The bucket name must be globally unique
- Data can be uploaded into the bucket or folders within the bucket
- Limitation of 100 buckets per AWS account but can be increased is required if requested through AWS
- Objects have a unique object key identifying that object

### Storage Classes

- Standard
- Standard - IA (Infrequent Access)
- Intelligent Tiering
- One Zone - IA (Infrequent Access)
- Reduced Redundancy Storage (RRS)

> https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html
> https://aws.amazon.com/s3/pricing/

| Storage Class | Designed for | Durability (designed for) | Availability (designed for) | Availability Zones | 	Min storage duration 	| Min billable object size | 	Other Considerations |
| - | - | - | - | - | -	| - | - |
|STANDARD|Frequently accessed data|99.999999999%|99.99%|>= 3|None|None|None|
|STANDARD_IA|Long-lived, infrequently accessed data|99.999999999%|99.9%|>= 3|30 days|128 KB|Per GB retrieval fees apply|
|INTELLIGENT_TIERING|Long-lived data with changing or unknown access patterns|99.999999999%|99.9%|>= 3|30 days|None|Monitoring and automation fees per object apply. No retrieval fees.|
|ONEZONE_IA|Long-lived, infrequently accessed, non-critical data|99.999999999%|99.5%|1|30 days|128 KB|Per GB retrieval fees apply. Not resilient to the loss of the Availability Zone.|
|S3 Glacier|Long-term data archiving with retrieval times ranging from minutes to hours|99.999999999%|99.99% (after you restore objects)|>= 3|90 days|40 KB|Per GB retrieval fees apply. You must first restore archived objects before you can access them. For more information, see Restoring Archived Objects|
|S3 Glacier Deep Archive|Archiving rarely accessed data with a default retrieval time of 12 hours|99.999999999%|99.99% (after you restore objects)|>= 3|180 days|40 KB|Per GB retrieval fees apply. You must first restore archived objects before you can access them. For more information, see Restoring Archived Objects.|
|RRS (Not recommended)|Frequently accessed, non-critical data|99.99%|99.99%|>= 3|None|None|None|

- Frequently Access
  - STANDARD and Reduced Redundancy Storage (RRS)
  - STANDARD is the default storage class
  - RRS is no longer recommended by AWS
- Infrequently Access
  - STANDARD-IA and ONE ZONE-IA
    - Offer the same access speed to that of STANDARD
    - Additional cost to retrieve data
    - ONE ZONE-IA does not replicate data across multiple availability zones
    - ONE ZONE-IA is more cost effective than STANDARD-IA
- Intelligent Tiering
  - Used for unpredictable access patterns
  - Consists of 2 tiers; Frequent and Infrequently accessed
  - Automatically moves data into appropriate tier based on access pattern
  
  Questions you need to ask before selecting a storage class
  1. How often is the data likely to be 
  2. How critical is my data?
  3. How reproducible is the data?
  4. Can it easily be created again if need be?
  5. Do I know the access patterns of my data?


## Security

- Bucket Policies
  - Impose set access controls within specific bucket
  - Constructed as JSON policies
  - Only control access to data in the associated bucket
  - Permissions can be very specific using policy conditions
  - Provide added granularity to bucket access
- Access Control Lists
  - ACLs only control access for users outside of your own AWS account, such as public access
  - ACLs are not as granular as bucket policies
  - The permissions are broad in access, for example 'List objects' and 'Write objects'
- Data Encryption
  - Server-side and client-side encryption methods
  - SSE-S3 (S3 managed keys)
  - SSE-KMS (KMS managed keys)
  - SSE-C (Customer managed keys)
  - CSE-KMS (KMS managed keys)
  - CSE-C (Customer managed keys)
  - SSL is supported
  - Client vs Server encryption notes where encryption takes place.

## Data Management

- Versioning
  - Allows for multiple versions of the same object to exist
  - Useful to recover from accidental deletion, or malicious activity
  - Only the latest version of the objects is displayed by default
  - Versioning is not enabled by default
  - You can't disable versioning, only suspend it
  - Adds a cost for storing multiple versions of the same object
- Lifecycle Rules
  - Provides an automatic method of managing the lifecycle of your data stored
  - Ability to configure specific criteria to automatically move data between storage classes, including Glacier or even delete the data completely
  - The time frame is configurable allowing you to set for your own requirements

## Data Backup

- Some people use S3 for back ups
- AWS can manage transfer of your data to S3 in addition to your own on on site backup

## Static Content & Websites

- S3 is perfect for storing static content
- Any object can be made public and referenced via a URL
- Amazon CloudFront interacts closely with Amazon S3
- Entire static website can be hosted on Amazon S3


## Examples Of Service Integration

- Elastics Back Store
  - EBS volumes perform snapshot backups which are then stored on S3
-  AWS CloudTrail
   -  CloudTrail log files are automatically sent and stored within preconfigured S3 buckets
-  Amazon CloudFront
   - S3 buckets can be used as a CloudFront origin within a distribution

## Pricing

- Reduced Redundancy Storage is more expensive, it was less expensive than standard but is no longer applicable
- Infrequent access is cheaper but not as accessible

## Additional Costs

- Requests
  - PUT, COPY, POST and GET and charged on 10K requests basis
- Data Transfer
  - Data transferred into S3 is free
  - Data transfer to another region is charged

## S3 Anti-patterns

- Data archiving for long term use
- Dynamic and fast changing
- File system requirements
- Structure data with queries

