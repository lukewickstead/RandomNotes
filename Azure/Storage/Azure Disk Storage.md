# Azure Disk Storage
[toc]
## Overview
- **Block-level storage** volumes for Azure Virtual Machines
- They are managed by Azure
- They are like a physical disk in an on-premises server but, virtualized
- With managed disks, all you have to do is specify the disk size, the disk type, and provision the dis
- Disk Storage is a managed disk that is designed for 99.999% availability.
- You can create 50,000 VM disks for each region.



## Features

- Different types of storage options: **Standard HDD, Standard SSD, Premium SSD,** and **Ultra Disk** volumes up to 64 TiB.
- Three main disk roles in Azure: the data disk, the OS disk, and the temporary disk. 
- OS disk has a maximum capacity of 2,048 GiB
- The maximum size of the data disk is 32,767 GiB.
- Managed disks are integrated with the **availability sets** to ensure that the VM disks are separated from each other in an availability set to prevent a single failure point.
- You can assign specific permissions for a managed disk to one or more users using **Azure RBAC**.
- You can use the temporary disk to store data such as page or swap files
- Ephemeral OS disks for stateless applications
- Attach a managed disk to multiple virtual machines (VMs) simultaneously using Azure shared disks.
- With snapshots, you can take a back up of your managed disks at any given point in time.



## Disk Types

- Standard HDD
  - Low cost and suitable for backups.
  - **Write** latencies under **10ms**.
  - **Read** latencies under **20ms**.
- Standard SSD
  - Consistent performance at lower IOPS levels.
  - Higher reliability, scalability, and lower latency over HDD.
- Premium SSD
  - High-performance and low-latency disk for VMs.
  - Consistent IOPS, and throughput.
  - Offers **disk bursting** and can burst their IOPS per disk up to 3,500 and their bandwidth up to 170 Mbps.
  - Peak burst limit of 30 mins
- Ultra Disk
  - High throughput, high IOPS, and consistent low latency disk storage
  - Only supports un-cached reads and un-cached writes
  - Doesn’t support disk snapshots, VM images, availability sets, Azure Dedicated Hosts, or Azure disk encryption.
  - The integration with Azure Backup or Azure Site Recovery is not supported



| **Detail**     | **Standard HDD**                        | **Standard SSD**                                  | **Premium SSD**                                | **Ultra Disk**                                               |
| -------------- | --------------------------------------- | ------------------------------------------------- | ---------------------------------------------- | ------------------------------------------------------------ |
| Disk type      | HDD                                     | SSD                                               | SSD                                            | SSD                                                          |
| Scenario       | Backup, non-critical, infrequent access | Web servers, and light applications of enterprise | Production and performance sensitive workloads | IO-intensive workloads, top tier databases, and other transaction-heavy workloads |
| Max disk size  | 32,767 GiB                              | 32,767 GiB                                        | 32,767 GiB                                     | 65,536 GiB                                                   |
| Max throughput | 500 MB/s                                | 750 MB/s                                          | 900 MB/s                                       | 2,000 MB/s                                                   |
| Max IOPS       | 2,000                                   | 6,000                                             | 20,000                                         | 160,000                                                      |



## Encryption

- **Server-Side Encryption (SSE)** is performed by the storage service.
- **Azure Disk Encryption (ADE)** can be enabled on the OS and data disks.
- Encrypted using 256-bit AES encryption.
- For standard HDDs, standard SSDs, and premium SSDs: disabling  or deleting the key will automatically shut down all the VMs with disks  using that key.
- If you disable or delete a key, any virtual machines with **ultra disks** using the key won’t automatically shut down.
- Once you enable end-to-end encryption, temp disks and ephemeral OS disks are encrypted with platform-managed keys



## Pricing

- Managed disk size is billed on the provisioned size
- Snapshots are charged based on the size used
- Outbound data transfers incur billing for bandwidth usage
- You are charged for the number of transactions that you  perform on a managed disk (the number of read and write data operations  performed)



## Trim

- The TRIM feature is only available to unmanaged disks, not managed disks
- When using unmanaged standard disks, HDD, it is important to enable  the TRIM function. TRIM discards unused blocks on the disks. By enabling TRIM you will only be billed for storage that you are actually using.  This is particularly important when large files are stored on an  unmanaged HDD and then later deleted. To check the TRIM settings, open a command prompt on the Windows virtual machine and enter the first  fsutil command as shown. If the commands returns zero, the TRIM setting  is enabled



## Sources

- https://docs.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview