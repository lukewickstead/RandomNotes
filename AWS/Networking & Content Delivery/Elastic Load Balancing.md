# Using Elastic Load Balancing & EC2 Auto Scaling to Support AWS Workloads

- https://cloudacademy.com/blog/aws-global-infrastructure

## What Is An AWS Elastics Loan Balancer (ELB)?

- Manage and control the flow of inbound requests destined to a group of targets by distributing these requests evenly across the targeted resource group
- Targets can be a fleet of EC2 instanced, Lambda functions, a range of IP addresses or even Containers
- Targets defined within the ELB could be situated across different Availability Zones, or all placed within a single AZ
- The ELB is highly available as this is a managed service provided by AWS (it has many instances)
- If any EC2 instance fails, ELB will automatically detect this and route all traffic to the working EC2 instances
- Managed by AWS and by definition is elastics; it will scale as required


## Load Balancer Types

### Application Load Balancer

- Flexible feature set for your web applications running the HTTP or HTTPS protocols
- Operates at the request level
- Advanced routing, TLS termination and visibility features targeted at application architectures


### Network Load Balancer

- Ultra-high performance while maintaining very low latencies
- Operates at the connection level, routing traffics to targets within your VPC
- Handles millions of requests per second


### Classics Load Balancer

- Used for applications that were build in the existing EC2 Classic environment
- Operates at both the connection and request level


## ELB Components

### Listeners, Target Groups and Rules

- Listeners
  - For every load balancer, you must configure at least one listener
  - The listener defines how your inbound connections are routed to your target groups based on ports and protocols set as conditions
- Target Groups
  - A target group is a group of your resources that you want your ELB to route requests t
  - You can configure your ELB with a number of different target groups, each associated with a different listener configuration and associated rules
- Rules
  - Rules are associated to each listener that you have configured within your ELB
  - They help to define how an incoming request gets routed to which target group

Your ELB can contain 1 or more listeners, each listener can contain 1 or more rules and each rule can contain more than 1 condition, and all conditions in the rule equal a single action.

> ELB --> Listener --> Rules --> Condition(s) --> Action 

**IF** a source ip is xxx and http method is put **THEN** forward to group 1.

- The IF statement resembles the conditions
- The THEN statement acts as the action if all the conditions are met


### Healthy Checks

- A health check that is performed against the resources defined within the target group
- These health checks allow the ELB to contact each target using a specific protocol to receive a response


### Internet-Facing ELB

- The nodes of the ELB are accessible via the internet and so have a public DNS name that can be resolved to its public IP address, in addition to an internal IP address
- This allows the ELB to serve incoming requests from the internet before distributing and routing the traffics to your target groups


### Internal ELB

- An internal ELB only has an internal IP address, this means that it can only serve requests that originate from within your VPC itself


### ELB Nodes

- For each AZ selected an ELB node will be placed within that AZ
- You need to ensure that you have an ELB node associated to any AZs for which you want to route traffics to
- The nodes are used by the ELB to distribute traffic to your target groups


### Cross-Zone Load Balancing

- Depending on which ELB option you selected you may have the option of enabling and implementing Cross-Zone loan balancing within your environment
- If disabled, each ELB in its associated AZ will distribute its traffic with the targets within that /AZ only
- If enabled, the ELBs will distribute all incoming traffics evenly between all targets. This means every target no matter which AZ will have an equal share of the processing


## SSL Server Certificates

- Application Load Balancer provides a flexible feature set for your web applications running the HTTP or HTTPS protocols
- ALB listener options available during creation are either the HTTP or HTTPS protocol on port 80 and 443 respectively


### Using HTTPS As A Listener

- HTTPS is an encrypted version of the HTTP protocol and this allows an encrypted communication channel to be set up between clients initiating the request and your Application Load Balancer
- To allow your ALB to receive encrypted traffic over HTTPS it will need a server certificate and an associated security policy
- SSL or Secure Sockets Layer, to give it its full name, is a cryptographic protocol, much like TLS, Transport Layer Security. Both SSL and TLS are used interchangeably when discussing certificates for your Application Load Balancer
- The server certificates used by the ALB is an X.509 certificate, which is a digital ID that has been provisioned by a Certificate Authority and this Certificate Authority could be the AWS Certificate Manager service also known as ACM
- This certificate is simply used to terminate the encrypted connection received from the remote client, and as a part of this termination process the request is then decrypted and forwarded to the resources in the ELB target group
- When you select HTTPS as your listener, you will be asked to select a certificate using one of four different options available
  - Choose a certificate from ACM
  - Upload a certificate to ACM
  - Choose a certificate from IAM
  - Upload a certificate to IAM
- An ACM is the AWS Certificate Manager and this service allows you to create and provision SSL/TLS server certificates to be used within your AWS environment across different services
  - Simplifies the configuration process of implementing a new certificate for your elastic load balancer
  - It's the preferred option. 
- IAM is used as your certificate manager when deploying your ALB's in regions that are not supported by ACM
  - https://docs.aws.amazon.com/general/latest/gr/rande.html#acm_region
- For detailed information on how to upload, retrieve, and list server certificates via IAM
  - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html
- The configuration of ACM is out of scope for this course
  - https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html


## Application Load Balancers

- ALBs operate at ayer 7 of the OSI model
- The application layer serves as the interface for users and application processes to access network services
- Examples of the application process or services it offers are http, ftp, smtp and nfs
- AWS suggests you use the application load balancer if you need to provide a flexible feature set including advanced routing and visibility features aimed purely for application architectures such as microservices and containers when used in HTTP or HTTP


### Target Groups

- Before configuring your ALB, it's good practice to set up your target groups
- A target group is simply a group of resources that you want your ALB to route requests to
- You might want to configure different target groups depending on the nature of your requests
- You could configure two different target groups and then route traffic, depending on the request, to different targets through the use of listeners and rules


### Configure Target Groups

> Computer > EC2 > Load Balancing > Target Groups

- Target Name
- Target type can be instance, IP or lambda function
- Protocol
- Port
- VPC
- Health check settings
  - Protocol
  - Path
  - Advanced
    - Healthy/Unhealthy Threshold, hit count before switching status
    - Timeout
    - Interval
    - Success Codes
- Hit create


### Configure Targets

> Computer > EC2 > Load Balancing > Target Groups > Targets > Edit

- You can select which EC2 instance to add as a target
- Save


## Configure Application Load Balancers

> Computer > EC2 > Load Balancing > Load Balancers > Create Load Balancer

- Options for ALB NLB and CLB
- Create ALB
  - Name
  - Scheme: internet facing or internal
  - IP Address type; ipv4, ipv6
- Listeners
  - Protocol
  - Port
  - Add listener
- Availability Zones
  - VPC
  - Availability Zones
    - Subnet
- Configure Security Settings
  - Will warn is not on https but this will require setting up server certificates
- Configure Security Group
  - Can create a new one or select a new one
  - Type: http, https
  - Protocol: TCP etc
  - Port Range
  - Source; ip address range
- Configure Routing
  - Select/Create Target Group
- Register Targets
  - The targets configured above are displayed for review
- Review
  - Review of all settings
- Create
  - This might take a while to provision

You can add additional listener rules:
-Listeners
  - View Edit Rules
    - Create additional
      - Condition: Host Header, Path, Http header, Http request method, Query string, Source IP
    - Add Action
      - Forward to
      - Redirect to
      - Return fixed response


## Configure Network Load Balancer

- The principles between the ALB and NLB are the same as to how the overall process works
  - ALB works at the application level analyzing the HTTP header to direct the traffic
  - NLB operates at layer 4 of the OSI model (Transport) enabling you to balance requests purely upon the TCP protocol
- Listeners supported include
  - TCP
  - TLS
  - UDP
- Can process millions of requests per seconds
- If your application logic requires a static IP address, then NLB will need t be your choice of elastic load balancer
- Cross-zone load balancing can be enabled or disabled
- Uses an algorithm which uses details based on the TCP sequence, the protocol, source port, source IP, destination port and destination IP to select the target in that zone to process the request
- When a TCP connection is established with a target host then that connection will remain open with that target for the duration of the request

### Configure NLB

> Computer > EC2 > Load Balancing > Load Balancers > Create Load Balancer > Network Load Balancer

- Similar as before
- Name
- Scheme: internet-facing, internal
- Listeners
  - Load Balancer Protocol: tcp, tls, udp, tcp_udp
  - Load Balancer Port
- Availability Zones
  - VPC
  - Availability Zones
    - AZ
    - Subnet
- Configure Rooting (AS ALB)
- Register Targets (AS ALB)
- Review
- Create


## Classic Load Balancer

- Supports; TCP, SSL/ TLS, HTTP and HTTPS protocols
- Similar functionality as ALB but does not support all features
- Features which ALB does not support
  - Support for EC2-Classic
  - Support for TCP and SSL listeners
  - Support for sticky sessions using application-generated cookies
- Considered best practice to use ALB over classic unless you have an existing application running in the EC2-classic network
- EC2-Classic
  - No longer supported for new EC2 applications


### Create CLB

> EC2 > Load Balancing > Load Balancers > Create Load Balancer > Classic Load Balancer


## ALB vs NLB vs CLB

> https://aws.amazon.com/elasticloadbalancing/features/#compare
> 