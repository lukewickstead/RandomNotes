# Azure Virtual Machines
[toc]

## Features
- Server environments called **virtual machines**
- Choose a VM when you need more control over the computing environment than the other choices offer
- An Azure VM gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs it
- Still need to maintain the VM by performing tasks, such as configuring, patching, and installing the software that runs on it
- Linux-based and Windows-based virtual machines
- A package OS and additional installations in a reusable template are called **VM Images**.
- Supports various configurations of CPU, memory, storage, and networking capacity for your virtual machines, known as  virtual machine series
  - A, Bs, D, and DC-Series for general purpose
  - F-Series for compute optimized
  - E and M-Series for memory optimized
  - Ls-Series for storage optimized
  - G-series for memory and storage optimized
  - H-series for high-performance computing
  - N-series for GPU optimized
- VMs are created inside a **resource group**.
- Secure login information for your virtual machines using **key pairs.**
- Persistent storage volumes for your data using **Azure Disk.**
- Multiple physical locations for deploying your resources, such as virtual machines and Azure disk, known as **Regions** and **Availability Zones**. 
- You can replicate your data in Availability Zones or Availability Sets
- Azure VMs have one operating system disk and a temporary disk for short-term storage
- Metadata, known as **tags**, that you can create and assign to your VM resources.
- Virtual networks that you can create are logically isolated  from the rest of the Azure environment and can optionally connect to  your own network, known as **Azure Virtual Network** or **VNet**.
- Add a script that will be run into the virtual machine while it is being provisioned called **custom data**.
- A firewall allows you to specify the protocols, ports, and source IP ranges that can reach your virtual machines using **network security groups**.
## Availability

- For higher availability deploy two or more VMs running your workload inside of an availability set
- An  availability set ensures that your VMs are distributed across multiple fault domains in the Azure data centres as well as deployed onto hosts  with different maintenance windows

## VM Status

- **Start – run your virtual machines. You are continuously billed while your VM is running.**
- **Restart** – some updates do require a reboot.  In such cases, the VMs are shut down while Azure patches the  infrastructure, and then the VMs are restarted.
- **Stop** – is just a normal shutdown. If the VM is in a  deallocated status, you will continue to be charged for the storage  needed for the operating system disk.
- You can also directly delete the virtual machines/resources. Deleting the selected virtual machines is irreversible. 
## Disks
- Select an OS disk type using Standard HDD, Standard SSD, and Premium SSD
- Every virtual machine has one attached operating system disk
- The OS disk has a maximum capacity of 2,048 GiB.
- Every VM contains a temporary disk that provides short-term storage only for page or swap files.
- Data on the temporary disk may be lost during a maintenance event or when you redeploy a VM
- You can enable ultra disk compatibility for high throughput, high IOPS, and consistent low latency disk storage
- A VM with an enabled Ultra Disk capability will result in a reservation charge even without attaching an Ultra Disk
- An Availability zone supports managed disks.
- You get lower read/write latency to the OS disk with Ephemeral OS disk, and faster reimage of VM. You incur no storage cost with  ephemeral OS disks.
## Pricing
- Pay as you go – pay for the instances that you use by the second, with no long-term commitments or upfront payments.
- Reserved – make a low, one-time up-front payment for an instance, reserve it for a one-or three-year term.
- Spot – request unused compute capacity, which can lower your  costs significantly. Spot pricing gives you up to 90 percent compared to pay as you go prices.
## Backup and Recovery
- A snapshot is a full copy of a virtual machine’s OS or  data disk. Snapshots are useful for backup, disaster recovery, and  troubleshooting.
- With the **enabled backup** option, your VM  will be backed up to Recovery Services vault with default backup policy, or your custom backup policy and will be charged as per backup pricing.
- **Azure Site Recovery** allows organizations to meet their  business continuity and disaster recovery (BCDR) requirements by having  your virtual machines’ data replicated to a secondary region and  failover in the event of a downtime.
- You can set up disaster recovery of Azure VMs from a primary region to a secondary region using **Azure Site Recovery**.
## Scale Sets
- Create and manage a group of load-balanced VMs to provide high availability to your applications.
- Automatically scale your application as demand changes.
- Support up to 1,000 VM instances. But if you create and upload your own custom VM images, the limit is 600.
- Use **Azure Monitor** to automate the collection of information from the VMs in your scale set.
- No additional cost to scale sets. You only pay for the  underlying computing services, such as virtual machines, load balancers, or managed disk storage.
| **Scenario**                       | **Manual group of VMs**                                      | **Virtual Machine Scale Set**                                |
| ---------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Add additional VM instances        | To create, configure, and ensure compliance with the manual process. | Create automatically from a central configuration.           |
| Traffic balancing and distribution | Manual process in creating and configuring the Load Balancer or Application Gateway. | Automatically create and integrate the Load Balancer or Application Gateway. |
| High availability and redundancy   | Create Availability Set or distribute and track virtual machines across Availability Zones manually. | Distribute virtual machines across Availability Zones or Availability Sets automatically. |
| Scaling of VMs                     | Manual monitoring and Azure Automation.                      | Autoscale based on metrics, Application Insights, or by schedule. |
## Monitoring
- **Azure Resource Health** helps you diagnose problems that affect your resources
- Capture serial console output and screenshots of the virtual machine with **boot diagnostics**
- Enable OS guest diagnostics to get the metrics every minute
- You can configure your virtual machine to automatically shutdown with **enable auto-shutdown** option
## Network
- You can provision a virtual machine that has a static public IP address.
- Enable accelerated networking for low latency and high throughput on the network interface
- Distribute traffic among virtual machines using Load Balancer
## Security
- By default, access to the VM is restricted to sources in the same virtual network
- You can control ports, inbound and outbound connectivity with security group rules
- With system assigned managed identity, all necessary permissions can be granted via Azure role-based access control
- Encrypt your data at rest with a platform-managed key or customer-managed key
- By default, encryption at-rest uses a platform-managed key
- Encrypt the OS and Data disks with Azure Disk Encryption.
- The temporary disk is not encrypted by server-side encryption unless you enable encryption at the host
## Sources:   
- https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/   
- https://docs.microsoft.com/en-us/azure/virtual-machines/windows/overview
- https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview