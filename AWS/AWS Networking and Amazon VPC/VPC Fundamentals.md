# VPC Fundamentals

## What Is A VPC?

- VPC resides inside of the AWS Cloud and it's essentially your own isolated segment of the AWS Cloud itself
- By default when you create your VPC, the only person that has access to this is your own AWS account
- Allows you to start deploying resources within your VPC, for example, different compute resources or storage or database and other network infrastructure among others
- You are allowed up to five VPCs per region per AWS account and it's very simple to create a VPC
  - Give it a name
  - Define an IP address range that the VPC in the form of a CIDR
  - CIDR stands for Classless Inter-Domain Routing


## Subnets

- Subnets reside inside your VPC, and they allow you to segment your VPC infrastructure into multiple different networks
  - Create better management for your resources
  - Isolate certain resources from others
  - Create high-availability and resiliency within your infrastructure


## CIDR Block Address

- CIDR block address is a range of IP addresses and this CIDR block range can have a subnet mask between a range of IP addresses from a  /16 all the way through to a /28
- https://www.ipaddressguide.com/cidr
- The number of addresses of a subnet may be calculated as 2address length − prefix length, where address length is 128 for IPv6 and 32 for IPv4. For example, in IPv4, the prefix length /29 gives: 232 − 29 = 23 = 8 addresses.
- All subnets within the VPC need to exist within the CIDR defined during the VPC creation
- When creating a subnet you have to define a CIDR range as well
- If a VPC has a CIDR of  10.0.0.0/16
  - Public subnet is 10.0.1.0/24
  - Private subnet is 10.0.2.0/24
- There's two changes you need to make to your infrastructure to make a subnet public
  - The first is to add an Internet gateway
  - Wwe need to add a route to the public subnet's route tableY
  - You can have the same route table associated to multiple subnets
  - You can not associate more than one route table to a single subnet


## Routing Table

- By default, when your subnet's created, it will have a default route in it, and this is a local route
- Your route table will contain a destination field and also a target field
  - The destination field is the destination address that you're trying to get to
  - The target essentially specifies the route to that destination
- Within every route table that's created, there will be this local route here which enables your subnets within your VPC to communicate to each other without any other config
- Every route table has this local route and can't be deleted
- To allow public access to your IGW from your public subnet you need to add in a route to the IGW
  - Destination: 0.0.0.0/0 Target: igw-121212121


## Architecting For High Availability And Resilience

- When you create a subnet, you have to create it in one of the availability zones that are available within that region- 
- If all your subnets and resources are in the same AZ, and that AZ goes down, everything will gisapear
- Carving up your architecture into multiple subnets accross multiple AZs would be better

## IP Addresses

- Subnet the address of 10.0.1.0/24. Now
- A total of 256 IP addresses but you can only actually use 251 IP addresses
  - 10.0.1.0 is the network address
  - 10.0.1.1 is for AWS routing
  - 10.0.1.2 is for AWS DNS
  - 10.0.1.3 is for future use
  - 10.0.1.255 is for braadcast address
