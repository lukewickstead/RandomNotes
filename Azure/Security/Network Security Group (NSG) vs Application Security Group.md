# Network Security Group (NSG) vs Application Security Group

[toc]

## Overview

| **Network Security Group** | **Application Security Group**                               |                                                              |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Description**            | A network security group is used to enforce and control network traffic. | An application security group is an object reference within an NSG. |
| **Features**               | Controls the inbound and outbound traffic at the subnet level. | Controls the inbound and outbound traffic at the network interface level. |
| **Rules**                  | Rules are applied to all resources in the associated subnet. | Rules are applied to all ASGs in the same virtual network.   |
| **Direction**              | Has separate rules for inbound and outbound traffic.         | Has separate rules for inbound and outbound traffic.         |
| **Limits**                 | NSG has a limit of 1000 rules.                               | ASGs that can be specified within all security rules of an NSG have a limit of 100 rules. |
| **Action**                 | Supports ALLOW and DENY rules.                               | Supports ALLOW and DENY rules.                               |
| **Constraints**            | You are not allowed to specify multiple IP addresses and IP address ranges in the NSG created by the classic deployment model. | You are not allowed to specify multiple ASGs in the source or destination. |

## Sources

- https://docs.microsoft.com/en-us/azure/virtual-network/security-overview   
- https://docs.microsoft.com/en-us/azure/virtual-network/application-security-groups