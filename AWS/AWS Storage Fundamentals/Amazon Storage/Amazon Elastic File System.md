# Elastic File System

- EFS provides a file level storage service
  - Whereas the likes of EBS provided block level storage and Amazon S3, object level storage
- EFS is a fully managed
- Highly available and durable service
- Ability to create shared file systems, can  be accessed by multiple EC2s etc
- Highly scalable; no need to allocate size up front
- Concurrent access by 1000's of instances
- Limitless capacity
- Regional; applications across multiple AZs can access it
- Not all regions support EFS
  - https://docs.aws.amazon.com/general/latest/gr/rande.html#elasticfilesystem-region
- Designed to maintain a high level of throughput, in addition to low latency access response


## Creation

- Can be managed from within the AWS management console
- Select which VPC
- Will automatically create mount targets for you, across the availability zones where you have EC2 instances
. These mount targets allow you to connect to the EFS file system, form your EC2 instances, using a configured mount target IP address. 
- Only compatible with NFS version 4, and 4.1. With this in mind, EFS does not currently support the Windows operating system
- You must insure that your Linus EC2 instance has the NFS client installed for the mounting process, and the NFS client version 4.1 is recommended for this procedure
- For each mount point, you are able to select which subnet the mount point exists in, as well as defining your security group to control access from what instance level
- Definine your tags
- Performance mode
  - General purpose
    - Used for most cases
    - Provides the lowest latency
    - Maximum of up to 7,000 file system operations per second
    - CloudWatch metric, PercentIOLimit, which allows you to view your operations per second as a percentage of the top 7,000 limit
  - Max I/O
    - Used for huge scale architectures
    - Concurrent access of 1000's instances
    - Can exceed 7,000 operations file system operations per second
    - Virtually unlimited amount of throughput and IOPS
- Encryption
  - Simple checkbox, and selecting your desired CMK
  - Uses the services offered by the key management service, to provide encryption of crucial storage
  - Encryption is only offered at rest, and not in transit
- Connection
  - Presented with your mount target points, allowing you to connect your EC2 instances as required
  - You can use these mount points on your on-premise service, as long as you connect via direct connect, or 3rd party VPN. 


## Moving Data Into EFS

- EFS File Sync allows you to securely manage the transfer of files between an existing storage location, and your EFS file system via a file sync agent
- To sync source files from your on-premises environment download the file sync agent as a VMware ESXi host
- Syncing source files from within AWS, then it will provide a community-based AMI, to be used with an EC2 instance
- The agent is then configured with your source destination amount target of your EFS file system details, and logically sits in between them. From within the EFS dashboard, you can then start the file sync, and monitor it's progress with Amazon CloudWatch. 

> Please note that the File Sync feature has now evolved into a new AWS Service known as AWS DataSync.  More information on this service can be found here:

 - https://aws.amazon.com/datasync/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc


## Pricing

- There are no charges for data transfer
- There are no charge for requests, like we have in Amazon S3 in Glacier
- Charged for the data you consume in per gigabyte-months (GB-months)
  - Fluctuations throughout the month are taken into account
  - https://aws.amazon.com/efs/pricing/


## Anti-patterns

- Data archiving; use Amazon Glacier
- Relational databasel use EBS
- Temporary storage; use EC2 instance store volumes
