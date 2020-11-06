# Azure Virtual Network (VNet)
[toc]
## Overview
- You can create a virtual network in the cloud dedicated to your Azure account. It is the fundamental building block where you can  launch Azure resources.
- Azure VNet is the networking layer of Azure VMs.
- A VNet spans all the Availability Zones in the region. After  creating a VNet, you can add one or more subnets in each Availability  Zone.
## Key Concepts
- A virtual network (VNet) allows you to specify an IP address range for the VNet, add subnets, associate network security groups, and configure route tables.
- A subnet is a range of IP addresses in your VNet. You can launch Azure resources into a specified subnet. Use a public subnet for resources that need to connect to the Internet and a private subnet for resources that won’t be connected to the Internet.
- To protect the Azure resources in each subnet, use network security groups.
## Subnets
- When you create a VNet, you must specify a range of IPv4 addresses for the VNet in the form of a CIDR block (*example: 10.0.0.0/16*).
- A CIDR block must not overlap with any existing CIDR block that’s associated with your VNet.
- You can add multiple subnets in each Availability Zone of your VNet’s region.
- Types of subnets:
  - Public subnet
  - Private subnet
  - Gateway subnet
- The CIDR block size of an IPv4 address is between a /16 netmask (65,536 IP addresses) and /29 netmask (8 IP addresses).
- The 5 reserved addresses in each CIDR block is not available for you to use, and cannot be assigned to any virtual machines.
- You can delegate a subnet to be used by a dedicated service.
## Security
- Network Security Groups – controls the inbound and outbound traffic of Azure resources.
- Application Security Group – allows you to define a VMs group network security policy.
- You can use **IP flow verify** of Azure Network Watcher to check which network security rule allows or denies the traffic.
- With VNet service endpoint policy, you can filter the egress VNet traffic to Azure Storage.
## VNet Components
- NAT Gateway 
  - Allows your virtual network resources to have an outbound-only connection.
  - A NAT gateway resource can use up to 16 static IP addresses.
  - You can use multiple subnets in a NAT gateway.
- Route tables are used to determine where network traffic is directed.
  - A subnet can only be associated with one route table.
  - If multiple routes contain the same address prefix, the  selection will be based on the following priority: User-defined route,  BGP route, and System route.
- You can connect VNets to each other using **VNet peering**.
- If you need to connect privately to a service, you can use **Azure Private Endpoint** powered by Azure Private Link.
## Pricing
- You are charged for the public IP address and reserved IP address inside your VNet.
- You are charged for the ingress and egress data of VNet Peering.
- You are charged for the NAT gateway resource hours and data processed (per GB).
## Sources
- https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview