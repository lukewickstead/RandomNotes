# Azure Scale Set vs Availability Set

[toc]

## Comparison



|                    | **Availability Set**                                         | **Scale Set**                                                |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Description**    | A group of discrete virtual machines spread across fault domains. | A group of identically configured virtual machines spread across fault domains. |
| **Workloads**      | Use Availability Set for predictable workloads.              | Use Scale Set for unpredictable workloads (autoscale).       |
| **Domain default** | Has 3 fault domains and 5 update domains by default          | Has 5 fault domains and 5 update domains by default          |
| **Configuration**  | Virtual machines are created from different images and configurations. | Virtual machines are created from the same image and configuration. |
| **Distribution**   | Virtual machines are automatically distributed within a data center. | Virtual machine scale sets can be distributed within a single datacenter or across multiple data centers. |
| **Number of VMs**  | You can only add a virtual machine to the availability set when it is created. | Scale sets can increase the number of virtual machines based on demand. |
| **Pricing**        | Availability set has no additional charge. You only pay for the computing resources. | Scale sets have no additional charge. You only pay for the computing resources. |



## Sources

- https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview   
- https://docs.microsoft.com/en-us/azure/virtual-machines/availability   
- https://docs.microsoft.com/en-us/azure/virtual-machines/windows/manage-availability