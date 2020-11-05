# Azure File Storage
[toc]
- Offers fully managed cloud-based file storage that can be  accessed through the industry-standard server message block (SMB)  protocol



## Features

- Mount your Azure File share from Windows, Linux, or macOS.
- **Azure File Sync** enables you to access your data from SMB, REST, or even on-premises.
- Encrypt data at rest and in transit using SMB 3.0 and HTTPS.
- Lift and shift applications to the cloud, where the  application data is moved to Azure Files, and the application continues  to run on-premises.
- Store configuration files in a centralized location where they can be accessed from many application instances.
- Azure Files provides the capability of taking **share snapshots** of file shares.



## Storage Tiers

- Premium file shares (SSD)
  - High performance & low latency, within single-digit milliseconds for most IO operations.
  - For IO-intensive workloads.
- Standard file shares (HDD)
  - Reliable performance for IO workloads which are less latency-sensitive.
- If you created either a premium or a standard file share, you cannot automatically convert it to the other tier



| **Detail**                 | **Premium**                                                  | **Standard**                                                 |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Billing model              | Provisioned Billing Model, pay for how much storage you provision rather than how much storage you actually ask for. | Pay-As-You-Go Model, the bill will increase if you use (read/write/mount) the Azure file share more. |
| Redundancy options         | It is available for locally redundant (LRS) and zone redundant (ZRS) storage. | It is available for locally redundant, zone redundant, geo-redundant (GRS), and geo-zone redundant (GZRS) storage. |
| Maximum size of file share | Provisioned for up to 100 TiB.                               | 5 TiB by default, 100 TiB for locally redundant or zone redundant storage accounts. |
| Regional availability      | File shares are not available in each region, but zone redundant support is available in a smaller subset of regions. | Available in every Azure region.                             |



## Supported devices

- To use an Azure file share outside of the Azure region the OS must support SMB 3.0
- To mount an Azure file sharing on Windows, you must have access to port 445.
- Linux clients can also access the file storage through the SMB protocol.



## Encryption

- By default, encrypted with Microsoft-managed keys and responsible for rotating them on a regular basis.
- Using Microsoft-managed keys, you can also choose to manage your own keys, which gives you control over the rotation process.
- With customer-managed keys, Azure file storage is authorized  to access your keys to fulfill read and write requests from your  clients.



## Networking

- SMB uses port 445.
- Accessible from anywhere, via the public endpoint of the storage account.
- Azure file shares over an ExpressRoute or VPN connection:
  - Tunneling into a virtual network, even if port 445 is blocked.
  - Private endpoints give you a dedicated IP address from within the address space of the virtual network.
  - Allows you to configure DNS forwarding.



## Azure File Sync

- Transform an on-premises (or cloud) Windows Server into a quick cache of your Azure file share.
- Only NTFS volumes are supported; ReFS, FAT, FAT32, and other file systems are not supported.
- The service supports interop with DFS Namespaces (DFS-N) and DFS Replication (DFS-R).



## StorSimple

- Prefer Azure File Sync as this is being deprecated in Dec 2020
- Cluster aware updating, so cluster loads on the StorSimple device are not affected by updates to the system.
- Compression facilities when the data is stored so as to increase storage utiization
- StorSimple uses the Internet Small Computer Systems Interface (iSCSI) protocol to link data storage.
- Allows hybrid on premise and off premise solution for storing files and disks



## Sources

- https://azure.microsoft.com/en-us/services/storage/files/    
- https://docs.microsoft.com/en-us/azure/storage/files/storage-files-introduction    
- https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-windows    
- https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-linux