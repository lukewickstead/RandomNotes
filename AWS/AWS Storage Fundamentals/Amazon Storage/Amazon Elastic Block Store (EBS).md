# Elastic Block Store

- EBS also provides block level storage to your EC2 instances
- Offers persistent and durable data storage
- Greater flexibility than that of instance store volumes
- EBS volumes can be attached to EC2 instances for rapidly changing data
- Use to retain valuable data due to it's persistent qualities
- Operates as a separate service to EC2
- EBS volumes act as a network attached storage devices
- Each volume can only be attached to one EC2 instance
- Multiple EBS volumes can be attached to a single EC2 instance
- Data is retained if the EC2 instance is stopped restarted or terminated


# EBS Snapshots

- Snapshot of a point in time
- Scheduled snapshots
- Can be done programmativally
- They are incremental
- Can create a new volume from that snapshot
- You can copy snapshots between regions


## High Availability

- Each write to your EBS is replicated multiple times to the same AZ of your region
- EBS is only available to one AZ
- Snapshots are available between regions
- Should your availability zone fail, you will lose access to your EBS volume. Should this occur, you can simply recreate the volume from your previous snapshot, which is accessible from all availability zones within that region, and attach it to another instance in another availability zone


## EBS Volume Types

- SSD (Solid State Drive)
  - Suited for work with smaller blocks
  - Databases using transactional workloads
  - Often used for boot volumes on EC2 instances
  - Types:
    - General Purpose SSD (GP2)
    - Provisioned IOPS (IO1)
- HDD ( Hard Disk Drive)
  - Designed for workloads requiring a high rate of throughput (MB/s)
  - Big Data processing & logging information
  - Larger blocks of data
  - Types:
    - Cold HDD (SC1)
    - Throughput Optimized HDD (ST1)
- General Purpose SSD (GP2)
  - Provides single digit millisecond latency
  - Can burst up to 3,000 IOPS
  - A baseline performance of 3 IOPS up to 10,000 IOPS
  - Throughput of 128 MB/seconds for volumes up to 170GB
  - Throughput increases to 768 KB/second per GB up to the maximum of 160 MB/second (+214 GB volumes)
- Provisioned IOPS (IO1)
  - Delivers predictable performance for I/O intensive workloads
  - Specify IOPS rate during the creation of new EBS volume
  - Volumes attached to EBS-optimized instances, will; deliver the IOPS defined within 10%, 99.9% of the time
  - Volumes range from 4-16TB
  - The maximum IOPS possible is set to 20,000
- Cold HDD (SC1)
  - Offers the lowest cost compared to other volume types
  - Designed for large workloads accessed infrequently
  - High throughput capabilities (MB/s) per TB
  - Maximum burst is 260 MB/s
  - Delivers 99% of expected throughput
  - Can't use a boot volume for instances
- Throughout Optimized HDD (ST1)
  - Designed for frequently accessed data
  - Suited to work with large data sets requiring throughput-intensive workloads
  - Availability to burst up to 250MB/s
  - Maximum burst 500 MB/s per volume
  - Delivers 99% of expected throughout
  - Not possible to use these as a bot volumes for your EC2 instances


## Encryption

- EBS offers encryption at rest and in transit
- Encryption is managed by the EBS service itself if you select this option
- It can be enabled with a checkbox
  - AES-256 -> AWS KMS ? CMK/DEK
- https://cloudacademy.com/blog/how-to-encrypt-an-ebs-volume-the-new-amazon-ebs-encryption


## Creating EBS Volume

 - There are 2 ways of creating a new EBS volume within the Management Console
  1. During the creation of a new EC2 instance
   - Can create a new volume or from a snapshot
   - Can delete during termination of EC2 instance
   - Can encrypt
  2. As a stand alone EBS volume
   - Many options are the same as to when an EBS created within an EC2 instance
   - You must specify which AZ that the volume will exit in
   - EBS volumes can only be attached to EC2 instances that exist within the same AZ


## Changing The Size Of An EBS Volume

- EBS volumes are elastically scalable
- Increase the volume size via the AWS Management Console of AWS CLI
- After the increase you must extend the filesystem on the EC2 instance to utilize the additional storage
- It's possible to resize a volume by creating a new volume from a snapshot


## Pricing

- Amazon EBS charged for the allocation and not what you actually use
- A different cost per type
  - GP2 - $0.116 per GB-month of provisioned storage
  - IO1 - $0.145 per GB-month of provisioned storage, $0.0076 per provisioned storage
  - ST1 - $0.053 per GB-month of provisioned storage 
  - SC1 - $0.029 per GB-month of provisioned storage
- EBS Volumes are billed on a per-second basis
- Remember that EBS snapshots are stored on Amazon S3 which will incur standard S3 storage costs


## Anti Patterns

- EBS is not well suited for all storage requirements
  - Temporary storage
  - Multi-instance storage access
  - Very high durability and availability
  

## Create SBS and Mount and Unmount

To change the permission on a pem file:

```
chmod 400 1242323234423.pem
```

To list all disks:

```
lsblk
```

To fomat an attached disks:

```
sudo mkfs -t ext4 /dev/NAME_OF_YOUR_DEVICE
sudo mkdir /mnt/ebs-store
sudo mount /dev/NAME_OF_YOUR_DEVICE /mnt/ebs-store
sudo nano /etc/fstab
```

Add into the file:

```
/dev/NAME_OF_YOUR_DEVICE /mnt/ebs-store ext4 defaults,noatime 1 2
```

Ctrl-O to save

Even though snapshots are saved incrementally, the snapshot deletion process is designed so that you need to retain only the most recent snapshot in order to restore the volume.

You can take a snapshot of an attached volume that is in use. However, snapshots only capture data that has been written to your Amazon EBS volume at the time the snapshot command is issued. This might exclude any data that has been cached by any applications or the operating system. If you can pause any file writes to the volume long enough to take a snapshot, your snapshot should be complete. However, if you can't pause all file writes to the volume, you should unmount the volume from within the instance, issue the snapshot command, and then remount the volume to ensure a consistent and complete snapshot. You can remount and use your volume while the snapshot status is "pending".

To unmount 

```
sudo umount -d /mnt/ebs-store/
```