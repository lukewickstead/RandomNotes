# AWS Storage Gateway

Storage Gateway allows you to provide a gateway between your own data center's storage systems, such as your SAN, NAS, or DAS, and Amazon S3 in Glacier on AWS. 

- The software appliance can be downloaded from AWS as a virtual machine and  on your VMware or Microsoft hypervisors
- Three Types
  - File  Gateway
  - Volume Gateway
    - Stored Volume Gateway
    - Cache Volume Gateway
  - Tape Gateway
- Can be used to help with DR abd data backup solutions


## File Gateways

- Allow you to securely store your files as objects within S3.
- Using it as a type of file share which allows you to mount or map drives to an S3 Bucket as if the share was held locally on your own corporate network
- When storing files using the file gateway, they are sent to S3 over HTTPS, and are also encrypted with S3's own server-side encryption, SSE-S3
- In addition, a local on-premise cache is also provisioned for accessing your most recently accessed files to optimize latency, which also helps to reduce egress traffic costs
- When your file gateway is first configured, you must associate it with your S3 Bucket which the gateway will then present as an NFS v3 or v41 file system to your internal applications
- This allows you to view the Bucket as a normal NFS file system, making it easier to mount as a drive in Linux or map a drive to it in Microsoft
- Any files that are then written to these NFS file systems are stored in S3 as individual objects as a one to one mapping of files to objects. 


## Volume Gateways

### Stored volume gateways

- Often used as a way to backup your local storage volumes to Amazon S3 whilst ensuring your entire data library also remains locally on premise for very low latency data access
- Volumes created and configured within the storage gateway are backed by Amazon S3, and are mounted as iSCSI devices that your applications can then communicate with
- During the volume creation, these are mapped to your on premise storage devices, which can either hold existent data or be a new disk
- As data is written to these iSCSI devices, the data is actually written to your local storage services such as your own NAS, SAN, or DAS storage solution. However, the storage gateway then asynchronously copies this data to Amazon S3 as EBS snapshots
- Having your entire data set remain locally ensures you have the lowest latency possible to access your data, which may be required for specific applications, or security compliance and governance controls whilst at the same time, providing a backup solution which is governed by the same controls and security that S3 offers
- Volumes created can be between one gig and 16 terabytes
- And for each storage gateway, up to 32 stored volumes can be created, which can give you a maximum total of 512 terabytes of storage per gateway
- Storage volume gateways also provide a buffer which uses your existing storage disks
- This buffer is used as a staging point for data that is waiting to be written to S3
- During the outline process, the data is sent over an encrypted SSL channel and stored in an encrypted format within S3
- To access the management and backup of your data, storage gateway makes it easy to take snapshots of your storage volumes at any point, which are then stored as EBS snapshots in S3
- It's worth pointing out that these snapshots are incremental ensuring that only the data that's changed since the last backup is copied, helping to minimize storage costs in S3
- As you can see, gateway stored volumes makes recovering from a disaster very simple
  - For example, let's consider the scenario that you lost your local application and storage layers on premise. Providing you had prevision for such a situation, you may have AMI templates that mimic your application tier which you could prevision as EC2 instances within AWS. You could then attach EBS volumes to these instances which could be created from your storage gateway volume snapshots, which would be stored on S3, giving you access to your production data required. Your application storage infrastructure could be potentially up and running again in a matter of minutes within a VPC with connectivity from your on-premise data center. 


### Cached Volume Gateways

- Cached volume gateways are different to stored volume gateways, in that the primary data storage is actually Amazon S3 rather than your own local storage solution
- However, cached volume gateways do utilize your local data storage as a buffer and a cache for recently accessed data to help maintain low latency, hence the name cached volumes
- Again, during the creation of these volumes, they are presented as iSCSI volumes which can be mounted by your application servers
- The volumes themselves are backed by the Amazon S3 infrastructure as opposed to your local disks as seen in the stored volume gateway deployment
- As a part of this volume creation, you must also select some local disks on-premise to act as your local cache and a buffer for data waiting to be uploaded to S3
- Again, this buffer is used as a staging point for data that is waiting to be written to S3 and during the upload process the data is encrypted using an SSL channel, where the data is then encrypted within SSE-S3
- The limitations is slightly different with cached volume gateways, in that each volume created can be up to 32 terabytes in size. With support for up to 32 volumes, meaning a total storage capacity of 1024 terabytes per cache volume gateway
- Although all of your primary data used by your applications is stored in S3 across volumes, it is still possible to take incremental backups with these volumes as EBS snapshots.
- In a DR scenario, this enables quick deployment of the data sets which can be attached to EC2 instances as EBS volumes containing all of your data as required. 


### Tape Gateway

- Also known as gateway VTL, virtual tape library
- This allows you to again backup your data to S3 from your own corporate data center, but also leverage Amazon Glacier for data archiving
- Virtual tape library is essentially a cloud based tape backup solution, replacing physical components with virtual ones
- This functionality allows you to use your existing tape backup application infrastructure within AWS, providing a more robust and secure backup and archiving solution
- The solution itself is comprised of the following elements
  - Storage gateway
    - The gateway itself is configured as a tape gateway
    - Has a capacity to hold 1500 virtual tapes.
  - Virtual tapes
    - Virtual equivalent to a physical backup tape cartridge 
    - Anything from 100 gig to 2.5 terabytes in size
    - Any data stored on the virtual tapes are backed by AWS S3 and appear in the virtual tape library
  - Virtual tape library
    - VTL these are a virtual equivalent to a tape library that contain virtual tapes
  - Tape drives
    - Every VTL comes with 10 virtual tape drives
    - Each virtual tape drive is presented to your backup applications as iSCSI devices
  - Media changer
    - This is a virtual device that manages tapes to and from the tape drive to your VTL
    - It is presented as an iSCSI device to your backup applications
  - Archive
    - This is equivalent to an off-site tape backup storage facility where you can archive tapes from your virtual tape library to Amazon Glacier
    - If retrieval of the tapes are required, storage gateway uses the standard retrieval option which can take between three to five hours to retrieve your data

### Gateway-Virtual Tape Library

- Once your storage gateway has been configured as a tape gateway, your applications and backup software can mount the tape drives along with the media changer as iSCSI devices to make the connection
- You can then create the required virtual tapes as you need them for backup and your backup software can use these to backup the required data which is stored on S3. 
- For a list of the supported third party backup applications
    - https://docs.aws.amazon.com/storagegateway/latest/userguide/Requirements.html#requirements-backup-sw-for-vtl
- When you want to archive virtual tapes for maybe cost optimization or compliance and governance or even DR, then the data is simply moved from Amazon S3 to Amazon Glacier


### Pricing

- AWS storage gateway costs are defined by three different cost points
- Cost is affected by the region and the type of storage
- Storage
  - Depends on the region
  - With AWS storage gateway, it also depends on the type of gateway used
- Requests
  - With requests pricing you are charged one cent per gigabyte for data written to your storage gateway
  - With a maximum cost of 125 dollars per gateway per month
  - You are also charged one cent per gigabyte of virtual tape retrieval 
- Data transfer
  - Inbound data transfer is free
  - Outbound data to another gateway in a different region
  - Amount of data transferred back to your on-premises gateway