# VPC Connecttivity

## VPN & Direct Connect

- VPN or Virtual Private Network is essentially a secure way of connecting two remote networks across the internet
- For example from a AWS private subnet and resources which are held on premis
  - VG or Virtual Gatewat on VPC
  - CG or Customer Gateway on premis
    - Can be hardware
    - Can be software
- Now during the creation of our virtual private gateway, we'll need to supply some additional information that's going to be used in our customer gateway such as the customer gateway's IP address and the type of routing to be used whether it's dynamic or static
- Then what we can do is initiate a tunnel between the two endpoints. Now, this VPN tunnel can only be initiated from your customer gateway
- It can't be initiated from your virtual gateway
- Now if there was some idle activity across this link for a period of 10 seconds or more, then this VPN tunnel connection would drop
- To prevent that from dropping, you can set up network monitoring to set up continuous network pings from the customer gateway side to the virtual gateway to ensure that connection remains up and running
- We need to change the route table associated to this private subnet, so our EC2 instances know how to connect to the 192.168 network (Off premis)
- In the local route table of the private subnet we would have a target of the VGW to the off premise ipaddress cidr
- You can also enable route propagation within your route table as well
  - Any routes that are represented across your VPN connection will be automatically added to your route table
  - So you might have other networks within your data center other than the 192.168 that are configured to use that VPN tunnel
  - Any traffic from another network received by your virtual gateway will allow these routes to be automatically propagated to the route tables that you've enabled route propagation on.
  - Now depending on what sort of customer gateway you installed, will depend if it supports the BGP Protocol, which is the Border Gateway Protocol and if it does, then this supports dynamic routing, so this will populate all the routes for the VPN connection for you which means you won't have to implement any static routing
  - Now it is recommended that if you can install a customer gateway that does support BGP, then it's probably best to do so. 
- Private subnet would need to have it's security group to have the correct rules
  - This would reference the correct type, protocol and portange along with the ip address CIDR block of the private off premis network which required connecting

### Direct Connect

- Another site-to-site connection called Direct Connect but this does not use the internet
- This is totally isolated infrastructure
- Another method of connecting your remote location such as your data center or remote office to your AWS environment
- Whereas your VPN connection used the internet to get to your VPC, a Direct Connect connection doesn't traverse the internet
- It uses private infrastructure and connects directly to your VPC
- Now with a Direct Connection, there's a middle entity before you get to AWS infrastructure, now this is usually an AWS partner or an AWS customer that holds Direct

1. Customer Data center with a route
2. Direct Connect Location
  - Sits between off premis and an AWS Region
  - Customer partner router
  - AWS router
3. AWS Region

We cna have private and public connection or interface

A private virtual interface connects from your on-premise router to the customer side of the Direct Connect location and from here there'll be a cross connect from the customer router to the AWS router within the same Direct Connect location. And then from here, this virtual private interface will then connect to your virtual gateway. Then this will allow connectivity through to your resources within your VPC. 

A public virtual interface, comes from your on-premise router into the customer side of the Direct Connect location, then there a cross connect across to the AWS router and from here it connects to inside of your AWS region and from here you can access your public AWS resources such as Amazon S3 et cetera.

Now to be able to use Direct Connect, the only path that you need to establish is from your on-premise data center to a Direct Connect location to enable you to establish a connection to this customer router here. So, as long as you have a dedicated network route to a co-location that provides a Direct Connect connection, then you can establish this dedicated network that we can see here.

Now the great thing when working with Direct Connect is that it's private connection and also you get speeds from 1 through to 10 gigabits per second


## VPC Peering

- Allows you to do is connect two VPCs together. 
- Now these VPCs might be in the same region to they might be in different regions
- Run on AWS and resilliant 
- Now you might have multiple VPCs for organization or management and there will be times when you want resources in one VPC to communicate with another
- A quick and simple solution is to implement VPC peering
- Peering connection is a one-to-one connection only; you can not daisy chain between VPs
- There can be not ip address overlap between VPCs; this simply would not work
- You can have VPC peering configured between the same region or between different regions
- Connections talk about requester and acceptor between VPC
- If the VPC accepter is happy with that peering connection, then an acknowledgement and acceptance of that request is sent back to the requester and that's the second stage and this creates the peering connection between the two
- At this stage, each VPC needs to update their routing tables to allow the traffic from VPC-1 to get to the destination of VPC-2
- The local routing table will map the desintayion of the vpcs o the peering connection pcx-xxxx
- The Security groups will need to be mapped also


## Transit Gateway

- AWS Transit Gateway allows you to do is to connect all of this infrastructure, so all of your VPCs, all of your remote locations, whether it's over Direct Connect or VPN via a central hub
- We have the AWS Transit Gateway in the middle
- Each VPC or remote location that we want to allow to talk to each other, then all we need to do is to create a single connection to the Transit Gateway
- Off premis would need to use a VPN to map to the transit gateway
- AWS Transit Gateway simplifies your whole network connectivity
- It allows all of your VPCs to easily communicate with one another and also communicate with your remote locations as well
- All the routing is managed centrally within that hub and when any new remote locations or VPCs are created, for example, you might have another two VPCs created, all you'd need to do is to connect it to the AWS Transit Gateway and each of these new VPCs can then communicate with the entire rest of your infrastructure. 
- Now because the Transit Gateway goes through this central hub, it allows you to centralize all your monitoring as well for your network traffic and connectivity all through the one dashboard which is great
