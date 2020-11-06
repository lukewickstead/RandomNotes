# Azure Virtual Machines
[toc]

## Features
- Server environments called **virtual machines**
- Choose a VM when you need more control over the computing environment than the other choices offer
- An Azure VM gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs it
- Still need to maintain the VM by performing tasks, such as configuring, patching, and installing the software that runs on it
- Linux-based and Windows-based virtual machines
- VMs are created inside a **resource group**.
- Metadata, known as **tags**, that you can create and assign to your VM resources.
- Virtual networks that you can create are logically isolated  from the rest of the Azure environment and can optionally connect to  your own network, known as **Azure Virtual Network** or **VNet**.
- Add a script that will be run into the virtual machine while it is being provisioned called **custom data**.

  

## Images

- An image is a copy of either a full VM (including any attached data disks) or just the OS disk, depending on how it is created
- When you create a VM  from the image, a copy of the VHDs in the image are used to create the disks for the new VM
- Considered as a template of how to create a VM
- Shared Image Gallery is a service that helps you build structure and organization around your images
  - Global replication of images
  - Versioning and grouping of images
  - High availability with ZRS



## Availability

- A **fault domain** is a logical group of underlying hardware that share a  common power source and network switch, similar to a rack within an  on-premises datacenter
- An **update domain** is a logical group of underlying hardware that can undergo maintenance or be rebooted at the same time.
  - Placing VMs in different update domains ensures your application is available even during platform maintenance

### Scale Sets

- Azure virtual machine scale sets let you create and manage a group of load balanced VMs

- Provide high availability

- Automatically scale your application as demand changes

- Allow you to centrally manage, configure, and update many VMs

- Support up to 1,000 VM instances. But if you create and upload your own custom VM images, the limit is 600

- Virtual machines in a scale set can be deployed across multiple update  domains and fault domains to maximize availability and resilience to  outages due to data center outages, and planned or unplanned maintenance events

- Use **Azure Monitor** to automate the collection of information from the VMs in your scale set

- No additional cost to scale sets. You only pay for the  underlying computing services, such as virtual machines, load balancers, or managed disk storage

  

| **Scenario**                       | **Manual group of VMs**                                      | **Virtual Machine Scale Set**                                |
| ---------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Add additional VM instances        | To create, configure, and ensure compliance with the manual process. | Create automatically from a central configuration.           |
| Traffic balancing and distribution | Manual process in creating and configuring the Load Balancer or Application Gateway. | Automatically create and integrate the Load Balancer or Application Gateway. |
| High availability and redundancy   | Create Availability Set or distribute and track virtual machines across Availability Zones manually. | Distribute virtual machines across Availability Zones or Availability Sets automatically. |
| Scaling of VMs                     | Manual monitoring and Azure Automation.                      | Autoscale based on metrics, Application Insights, or by schedule. |



### Availability Sets

- An availability set is a logical grouping of VMs within a datacenter  that allows Azure to understand how your application is built to provide for redundancy and availability
- There is no cost for the Availability Set itself, you only pay for each VM instance that you create
- In an availability set, VMs are automatically distributed across these fault domains
- Only VMs with managed disks can be created in a managed availability set



### Proximity placement groups

- A proximity placement group is a logical grouping used to make sure that Azure compute resources are physically located close to each other; closer than being in the same region
- Useful for workloads where low latency is a requirement.



### Network Performance

- Enable Accelerated Networking if the Windows VM supports it otherwise use Receive Side Scaling (RSS) or for all Linux VMs
- Ubuntu Azure kernel is the most network optimized Linux VM Kernel



## VM Types & Sizes



| Type                                                         | Sizes                                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [General purpose](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-general) | B, Dsv3, Dv3, Dasv4, Dav4, DSv2, Dv2, Av2, DC, DCv2, Dv4, Dsv4, Ddv4, Ddsv4 | Balanced CPU-to-memory ratio. Ideal for testing and development,  small to medium databases, and low to medium traffic web servers. |
| [Compute optimized](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-compute) | F, Fs, Fsv2                                                  | High CPU-to-memory ratio. Good for medium traffic web servers, network appliances, batch processes, and application servers. |
| [Memory optimized](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-memory) | Esv3, Ev3, Easv4, Eav4, Ev4, Esv4, Edv4, Edsv4, Mv2, M, DSv2, Dv2 | High memory-to-CPU ratio. Great for relational database servers, medium to large caches, and in-memory analytics. |
| [Storage optimized](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-storage) | Lsv2                                                         | High disk throughput and IO ideal for Big Data, SQL, NoSQL databases, data warehousing and large transactional databases. |
| [GPU](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-gpu) | NC, NCv2, NCv3, NCasT4_v3 (Preview), ND, NDv2 (Preview), NV, NVv3, NVv4 | Specialized virtual machines targeted for heavy graphic rendering  and video editing, as well as model training and inferencing (ND) with  deep learning. Available with single or multiple GPUs. |
| [High performance compute](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-hpc) | HB, HBv2, HC,  H                                             | Our fastest and most powerful CPU virtual machines with optional high-throughput network interfaces ( |







### Spot VMs

- Using Spot VMs allows you to take advantage of our unused capacity at a significant cost savings
- At any point in time when Azure needs the capacity back, the Azure infrastructure will evict Spot VMs
- Spot VMs are great for workloads that can handle interruptions like  batch processing jobs, dev/test environments, large compute workloads,  and more
- Offers no high availability guarantees



## Disk Storage

- Managed disks are block-level storage volumes that are managed by Azure and used by Azure VMs
-  Like a physical disk in an on-premises server but, virtualized
- Available types of disks are ultra disks, premium solid-state drives (SSD), standard SSDs, and standard hard disk drives (HDD)
- They are highly durable, available and scale and integrate with Availability Zones
- Every virtual machine has one attached operating system disk. That **OS disk** has a pre-installed OS, which was selected when the VM was  created. This disk contains the boot volume. This disk has a maximum capacity of 4,095 GiB.
- Every VM contains a **temporary disk** that provides short-term storage only for page or swap files. Data on the temporary disk may be lost during a maintenance event or when you redeploy a VM
- An Availability zone supports managed disks.
- You get lower read/write latency to the OS disk with Ephemeral OS disk, and faster reimage of VM. You incur no storage cost with  ephemeral OS disks. These disks are not saved to the remote Azure Storage 



### Disk Comparison



| Detail         | Ultra disk                                                   | Premium SSD                                    | Standard SSD                                                 | Standard HDD                            |
| -------------- | ------------------------------------------------------------ | ---------------------------------------------- | ------------------------------------------------------------ | --------------------------------------- |
| Disk type      | SSD                                                          | SSD                                            | SSD                                                          | HDD                                     |
| Scenario       | IO-intensive workloads such as [SAP HANA](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/hana-vm-operations-storage), top tier databases (for example, SQL, Oracle), and other transaction-heavy workloads. | Production and performance sensitive workloads | Web servers, lightly used enterprise applications and dev/test | Backup, non-critical, infrequent access |
| Max disk size  | 65,536 gibibyte (GiB)                                        | 32,767 GiB                                     | 32,767 GiB                                                   | 32,767 GiB                              |
| Max throughput | 2,000 MB/s                                                   | 900 MB/s                                       | 750 MB/s                                                     | 500 MB/s                                |
| Max IOPS       | 160,000                                                      | 20,000                                         | 6,000                                                        | 2,000                                   |



### Ultra Disk

- Azure ultra disks deliver high throughput, high IOPS, and consistent low latency disk storage for Azure IaaS VMs
- Ability to dynamically change the performance of the disk, along with your workloads, without the need to restart a VM
- Ultra disks are suited for data-intensive  workloads such as SAP HANA, top tier databases, and transaction-heavy  workloads
- Ultra disks can only be used as data disks
- Azure recommend  using premium SSDs as OS disks
- The only infrastructure redundancy options currently available to ultra  disks are availability zones. VMs using any other redundancy options  cannot attach an ultra disk
- Charged a reservation fee if your VM has ultra disk enabled regardless if it has an attached ultra disk



### Premium SSD

- Azure premium SSDs deliver high-performance and low-latency disk support for virtual machines (VMs) with input/output (IO)-intensive workloads
- Suitable for mission-critical production applications
- Premium SSDs can only be used with VM series that are premium storage-compatible



### Encryption

- Server-side encryption (SSE) automatically encrypts your data stored on Azure managed disks (OS and  data disks) at rest by default when persisting it to the cloud
- Data in Azure managed disks is encrypted transparently using 256-bit [AES encryption](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
- Server-side encryption does not impact the performance of managed disks and there is no additional cost
- Temporary disks are not managed disks and are not encrypted by SSE, unless you enable encryption at host
- Keys are managed by default as Platform-managed keys though you can chose to use Customer-managed keys
- [Azure Disk Encryption](https://docs.microsoft.com/en-us/azure/security/fundamentals/azure-disk-encryption-vms-vmss) leverages either the [DM-Crypt](https://en.wikipedia.org/wiki/Dm-crypt) feature of Linux or the [BitLocker](https://docs.microsoft.com/en-us/windows/security/information-protection/bitlocker/bitlocker-overview) feature of Windows to encrypt managed disks with customer-managed keys within the guest VM. Server-side encryption with customer-managed keys improves on ADE by  enabling you to use any OS types and images for your VMs by encrypting  data in the Storage service.



## Pricing

- Pay as you go – pay for the instances that you use by the second, with no long-term commitments or upfront payments.
- Reserved – make a low, one-time up-front payment for an instance, reserve it for a one-or three-year term.
- Spot – request unused compute capacity, which can lower your  costs significantly. Spot pricing gives you up to 90 percent compared to pay as you go prices.



## Backup and Recovery

- A **managed disk snapshot** is a full copy of a virtual machine’s OS or  data disk. Snapshots are useful for backup, disaster recovery, and  troubleshooting. Billed based on used size. It is of only one disk. If the VM has only one disk you can create a VM for it
- Managed disks support creating a **managed custom image** which can be used for creating VMs. The VM is required to be deallocated. The image includes all images attached to the VM
- With the **enabled backup** option, your VM  will be backed up by **Azure Backup** to **Recovery Services vault** with default backup policy, or your custom backup policy and will be charged as per backup pricing.
- **Azure Site Recovery** allows organizations to meet their  business continuity and disaster recovery (BCDR) requirements by having  your virtual machines’ data replicated to a secondary region and  failover in the event of a downtime.
- You can set up disaster recovery of Azure VMs from a primary region to a secondary region using **Azure Site Recovery**.



## Monitoring

- **Azure Resource Health** helps you diagnose problems that affect your resources
- Capture serial console output and screenshots of the virtual machine with **boot diagnostics**
- Enable OS guest diagnostics to get the metrics every minute
- You can configure your virtual machine to automatically shutdown with **enable auto-shutdown** option



## Security

- By default, access to the VM is restricted to sources in the same virtual network
- A firewall allows you to specify the protocols, ports, and source IP ranges that can reach your virtual machines using **network security groups**.
- Secure login information for your virtual machines using **key pairs**
- With system assigned managed identity, all necessary permissions can be granted via Azure role-based access control

## Power States



![VM power state diagram](https://docs.microsoft.com/en-us/azure/virtual-machines/media/virtual-machines-common-states-lifecycle/vm-power-states.png)



## Provisioning States

A provisioning state is the status of a user-initiated, control-plane operation on the VM. These states are separate from the power state of a VM.

- **Create** – VM creation.
- **Update** – updates the model for an existing VM. Some non-model changes to VM such as Start/Restart also fall under update.
- **Delete** – VM deletion.
- **Deallocate** – is where a VM is stopped and  removed from the host. Deallocating a VM is considered an update, so it  will display provisioning states related to updating



## Sources:   

- https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/   
- https://docs.microsoft.com/en-us/azure/virtual-machines/windows/overview
- https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview