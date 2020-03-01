# VPC Security and Control

## NetWork Access Control Lists (NACLs)

- Essentially virtual network-level firewalls that are associated to each and every subnet
- Help to control both ingress and egress traffic moving in and out of your VPC and between your subnets
- Whenever you create a new subnet, it will also associate a network access control list
- By default, this NACL will allow all traffic, both inbound and outbound; it's not very secure
- Inbound network access control list that could be associated to this subnet
  - Rule number
    - Specify what order the rules will appear inside the NACL
  - Type
  - Protocol
  - Port range
  - Source
  - Allow / Deny
- As soon as traffic hits one of these rules where it matches all of the type, protocol, port range, and source, et cetera, it will carry out the action at the end, whether that is allow or deny
- Best to have a deny all for traffic at the end
- Outbound, we restrict traffic against its destination and not source
- NACLs are stateless, and this means that any response traffic generated from a request will have to be explicitly allowed and configured in either the inbound or the outbound ruleset, depending on where the response is coming 
- You can have the same NACL applied to a number of subnets
- Only a single NACL can be associated to one subnet
- Network access control lists are a great way to control traffic that comes into and out of a particular subnet


## Security Groups

- Similar to network access controllers where they filter traffic both inbound and outbound but whereas NACLs worked at the subnet level, security groups work at the instance level
- Have the following fields
  - Type
  - Protocol
  - Port Range
  - Source
- There is no allow/deny, everything contained is allow, everything else is automatically denied
- Unlike NACLs which are stateless by design, security groups are stateful which means you don't have to configure specific rules to allow return traffic from requests like you have to do with NACLs

## NAT Gateway

- If we have the responsibility of maintaining the operating systems of our EC2 instances, then we need to be able to download updates
- How can we download updates on an instance that sits wihtin a private subnet? Via a NAT Gateway
- NAT gateway sits within the public subnet
- Because it sits within the public subnet, it has to have a public IP address in the form of an EIP which is an Elastic IP address, and this is assigned to the instance itself
- The route table of the private subnet needs access to the nat gateway
  - Destination: 0.0.0.0/0 Target: nat-34o987u9789879797
- This NAT gateway will then take the request, go via the Internet gateway, and download the appropriate software that's required, and send it back to the EC2 instance requesting it
- Now the important thing with a NAT gateway, is that it will not accept any inbound communication initiated from the Internet
- It will only accept outbound communications originating from within your VPC. So it will deny all inbound traffic that's been initiated from the Internet
- NAT gateway itself is managed by AWS, so you don't have to provision the instance itself
- Create the NAT gateway, specify what subnet it should reside in, and associate an Elastic IP address, and AWS will manage all other configuration
- AWS will set up multiple NAT gateways for resiliency, but you'll only see the one NAT gateway within your account with the associated ID
- If you have multiple public subnets in different Availability Zones, you will need to set up another NAT gateway within that subnet as well. AWS will not automatically deploy a NAT gateway within each of your public subnets


## Bastion Host

- Allow access to an EC2 instnace hosted on a private subnet, probably to allow maintenances
- It's not possible to initiate an outside request to connect through to the internet down through to the internet gateway of our VPC and then across to our private subnet
- A bastion host sits within the public subnet and this is just another EC2 instance
- It needs to be hardened and very robust, but effectively, it needs to be tightened down to remove any kind of vulnerabilities and loose access controls
- SSH agent forwarding
  - Allows us you to store the private keys for the instances within the private subnet on your local client, so that when you connect through to the bastion host, you can then SSH, but using the private key to the EC2 instances that is stored on your client rather than storing it on the bastion host
  - https://aws.amazon.com/blogs/security/securely-connect-to-linux-instances-running-in-a-private-amazon-vpc/
- The source of the private security group is set to be the security group of the bastion host
