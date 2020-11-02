# Load Balancing

[toc]

## Intro

- Redirects traffic based on criteria to different servers
  - Load distribution
  - Required networking
  - Health probing
- Transport layer (OSI layer 4 - TCP and UDP)  load balancers work on either the source or target IP address and the protocol being used
- Application layer (OSI layer 7)  routes based upon attributes of the HTTP request such as URL or headers; also known as application layer (OSI layer 7) load balancing



## Azure

- https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/load-balancing-overview

| Service             | Global/regional | Recommended traffic |
| ------------------- | --------------- | ------------------- |
| Azure Front Door    | Global          | HTTP(S)             |
| Traffic Manager     | Global          | non-HTTP(S)         |
| Application Gateway | Regional        | HTTP(S)             |
| Azure Load Balancer | Global          | non-HTTP(S)         |



A really good decision tree image of which service to use: 

- https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/images/load-balancing-decision-tree.png



<img src="C:\Users\luke.wickstead\OneDrive - Redington Limited\Desktop\Cloud Notes\Images\load-balancing-decision-tree.png" style="zoom:50%;" />



- Front Door is an application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application like SSL offload, path-based routing, fast failover, caching, etc. to improve performance and high-availability of your applications.
- Traffic Manager is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it load balances only at the domain level. For that reason, it can't fail over as quickly as Front Door, because of common challenges around DNS caching and systems not honoring DNS TTLs.
- Application Gateway provides application delivery controller (ADC) as a service, offering various Layer 7 load-balancing capabilities. Use it to optimize web farm productivity by offloading CPU-intensive SSL termination to the gateway.
- Azure Load Balancer is a high-performance, ultra low-latency Layer 4 load-balancing service (inbound and outbound) for all UDP and TCP protocols. It is built to handle millions of requests per second while ensuring your solution is highly available. Azure Load Balancer is zone-redundant, ensuring high availability across Availability Zones



### Azure Load Balancer vs App Gateway vs Traffic Manager



| **Load Balancer**     | **App Gateway**                              | **Traffic Manager**                                   |                                                              |
| --------------------- | -------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------ |
| **Service**           | Network load balancer.                       | Web traffic load balancer.                            | DNS-based traffic load balancer.                             |
| **Network Protocols** | Layer 4 (TCP or UDP)                         | Layer 7 (HTTP/HTTPS)                                  | Layer 7 (DNS)                                                |
| **Features**          | Internal and public load balancer            | SSL/TLS termination and cookie-based session affinity | Traffic-routing methods, Traffic manager profile, endpoint monitoring options |
| **Routing**           | Source/Destination (IP & Port), and Protocol | URI path or Host headers                              | Offers various routing methods such as: Priority, Weighted, Performance, Geographic, Multivalue and Subnet |
| **Security**          | Integrate Azure Firewall with Standard LB.   | Web Application Firewall                              | Use locks to protect your traffic manager profile.           |


### Azure Load Balancer

Links:

- https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-overview




- Transport layer load balancer working on OSI layer 4

- Scales up automatically as network traffic increases

- A **[public load balancer](https://docs.microsoft.com/en-us/azure/load-balancer/components#frontend-ip-configurations)** can provide outbound connections for virtual machines (VMs) inside your virtual network. These connections are accomplished by translating  their private IP addresses to public IP addresses. Public Load Balancers are used to load balance internet traffic to your VMs.

- An **[internal (or private) load balancer](https://docs.microsoft.com/en-us/azure/load-balancer/components#frontend-ip-configurations)** is used where private IPs are needed at the frontend only. Internal  load balancers are used to load balance traffic inside a virtual  network. A load balancer frontend can be accessed from an on-premises  network in a hybrid scenario.

- Supports IPv6

- Load balancer tiers: Basic and Standard or SKUs

  - SKUs  are not mutable, you can not modify them once set

- If the application is stateful you need to turn on source IP affinity mode; all requests from the same IP address will always go to the same VM

  

|                                                              | Standard Load Balancer                                       | Basic Load Balancer                                          |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Backend pool size](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#load-balancer) | Supports up to 1000 instances.                               | Supports up to 300 instances.                                |
| Backend pool endpoints                                       | Any virtual machines or virtual machine scale sets in a single virtual network. | Virtual machines in a single availability set or virtual machine scale set. |
| [Health probes](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-custom-probe-overview#types) | TCP, HTTP, HTTPS                                             | TCP, HTTP                                                    |
| [Health probe down behavior](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-custom-probe-overview#probedown) | TCP connections stay alive on an instance probe down **and** on all probes down. | TCP connections stay alive on an instance probe down. All TCP connections end when all probes are down. |
| Availability Zones                                           | Zone-redundant and zonal frontends for inbound and outbound traffic. | Not available                                                |
| Diagnostics                                                  | [Azure Monitor multi-dimensional metrics](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-standard-diagnostics) | [Azure Monitor logs](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-monitor-log) |
| HA Ports                                                     | [Available for Internal Load Balancer](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-ha-ports-overview) | Not available                                                |
| Secure by default                                            | Closed to inbound flows unless allowed by a network security group.  Internal traffic from the virtual network to the internal load balancer  is allowed. | Open by default. Network security group optional.            |
| Outbound Rules                                               | [Declarative outbound NAT configuration](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-outbound-rules-overview) | Not available                                                |
| TCP Reset on Idle                                            | [Available on any rule](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-tcp-reset) | Not available                                                |
| [Multiple front ends](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-multivip-overview) | Inbound and [outbound](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-outbound-connections) | Inbound only                                                 |
| Management Operations                                        | Most operations < 30 seconds                                 | 60-90+ seconds typical                                       |
| SLA                                                          | [99.99%](https://azure.microsoft.com/support/legal/sla/load-balancer/v1_0/) | Not available                                                |




### Azure Application Gateway

- https://docs.microsoft.com/en-us/azure/application-gateway/overview



- A web traffic load balancer.

- It allows you to distribute incoming traffic based on HTTP request properties such as URL and host headers.

- Application gateway has four tiers: **Standard**, **Standard V2**, **WAF**, and **WAF v2**

- You can use the same application gateway for up to 100+ websites with multi-site hosting.

- Set the minimum and maximum scale units based on your needs.

- Can perform SSL termination



Features

- Secure your data with end-to-end SSL.
- Route traffic based on URL path or host header-based.
- Protect your applications from common web vulnerabilities using WAF.
- Scales automatically based on your web application traffic load.
- With gateway-managed cookies, you can direct subsequent traffic from a user session to the same server.

Pricing

- You are charged per instance, per GB, and per gateway-hour.
- You are also charged with capacity units (*computed hourly or partial hourly*).



### Azure Traffic Manager

Links:

- https://docs.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview 



- A DNS-based traffic load balancer.

- Improves the responsiveness of your applications by sending the request to the closest endpoint.

- It offers a range of **traffic-routing methods** and **endpoint monitoring options**.

Features

- It is resilient to failure.

- You can obtain actionable insights about your users using a **traffic view.**

- Improve the availability of your applications by using traffic manager health checks.

- Offers automatic failover when an endpoint goes down

- Traffic Manager endpoints: **Azure**, **External**, and **Nested**

  Combine multiple traffic-routing methods using **nested traffic manager profiles**.

Routing Methods

- Priority – allows you to set a primary endpoint for all traffic.
- Weighted – distribute traffic according to weights.
- Performance – routes users to the closest endpoint.
- Geographic – direct users to a specific endpoint.
- Multivalue – endpoints for IPv4/IPv6 addresses.
- Subnet – map a group of end-user IP address range to a specific endpoint.

Pricing

- You are charged based on the number of DNS queries received.
- You are also charged for each monitored endpoint.
- You can reduce your DNS query charges by configuring a larger TTL.
- You are charged for the number of data points used in the traffic view.


### Azure Front Door

- https://docs.microsoft.com/en-us/azure/frontdoor/front-door-overview



- A service that uses Microsoft’s global network to improve the availability and performance of your applications to your local and global users.
- It works at the HTTP/HTTPS layer and uses a split TCP-based anycast protocol to ensure your users connect to the nearest Front Door point of presence.
- Supports a range of traffic-routing methods and backend health monitoring options for various application needs and automatic failover models.
- With URL-based routing, it routes the traffic to backend pools based on URL paths of the request.
- You can configure more than one website on the same Front Door with multiple-site hosting.
- Use cookie-based session affinity to redirect the user session to the same application backend.
- Redirect traffic based on protocol, hostname, path, and query string with URL redirect.
- URL rewrite allows you to configure a Custom Forwarding Path that will copy any part of the incoming path that matches a wildcard path to the forwarded path.
Front Door supports end-to-end IPv6 connectivity and HTTP/2 protocol.



Security

- If you need your domain name to be visible in your Front Door URL, you must have a custom domain. Front Door also supports managed certificates or custom TLS/SSL certificates.
- You can create custom rules to protect your HTTP/HTTPS workload from exploitation using Azure Web Application Firewall.



Pricing

- You are charged based on the following:
 - Inbound and outbound data transfers
 - The number of routing rules
- Front Door has a limit of 100 custom domains. You will be charged for additional domains

