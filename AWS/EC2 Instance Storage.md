# EC2 Instance Storage

- Hosted on the same device as the EC2 instance
- Instance store volumes provide ephemeral storage (temporary)
- Not recommended for critical valuable data
- If your instance is stopped or terminated your data is lost
- If your instance is rebooted, your data will remain in tact
- Instance store volumes are not available for all instances
- The capacity of instance store volumes increase with the size of the EC2 instance
  - c3.large
  - c3.xlarge
  - c3.2xlarge
- Instance store volumes have the same security mechanisms provided by EC2

## Benefits

- No additional cost for storage, it's included in the price of the instance
- Offer a very high I/O speed
- I3 instance family
  - 3.3 million random read IOPS (Input/output operations per second)
  - 1.4 million write IOPS
- Instance store volumes are ideal as a cache or buffer for rapidly changing data without the need for retention
- Often used within a load balancing group, where data is replicated and pooled between fleet

## Anti-patterns  

- Data that needs to remain persistent
- Data that needs to be accessed and shared by multiple entities