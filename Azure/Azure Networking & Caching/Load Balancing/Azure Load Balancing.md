# Load Balancing

[toc]

## Intro

- Redirects traffic based on criteria to different servers
  - Load distribution
  - Required networking
  - Health probing
- Transport layer (OSI layer 4 - TCP and UDP)  load balancers work on either the source or target IP address and the protocol being used
- Application layer (OSI layer 7)  routes based upon attributes of the HTTP request such as URL or headers; also known as application layer (OSI layer 7) load balancing



## Azure Load Balancing Services

| Service             | Global/regional | Recommended traffic |
| ------------------- | --------------- | ------------------- |
| Azure Front Door    | Global          | HTTP(S)             |
| Traffic Manager     | Global          | non-HTTP(S)         |
| Application Gateway | Regional        | HTTP(S)             |
| Azure Load Balancer | Global          | non-HTTP(S)         |

<img src="Images\load-balancing-decision-tree.png" style="zoom:50%;" />



- Front Door is an application delivery network that provides global load balancing and site acceleration service for web applications. It offers Layer 7 capabilities for your application like SSL offload, path-based routing, fast failover, caching, etc. to improve performance and high-availability of your applications.
- Traffic Manager is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it load balances only at the domain level. For that reason, it can't fail over as quickly as Front Door, because of common challenges around DNS caching and systems not honoring DNS TTLs.
- Application Gateway provides application delivery controller (ADC) as a service, offering various Layer 7 load-balancing capabilities. Use it to optimize web farm productivity by offloading CPU-intensive SSL termination to the gateway.
- Azure Load Balancer is a high-performance, ultra low-latency Layer 4 load-balancing service (inbound and outbound) for all UDP and TCP protocols. It is built to handle millions of requests per second while ensuring your solution is highly available. Azure Load Balancer is zone-redundant, ensuring high availability across Availability Zones



## Azure Load Balancer vs App Gateway vs Traffic Manager



|                       | **Load Balancer**                            | **App Gateway**                                       | **Traffic Manager**                                          |
| --------------------- | -------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------ |
| **Service**           | Network load balancer.                       | Web traffic load balancer.                            | DNS-based traffic load balancer.                             |
| **Network Protocols** | Layer 4 (TCP or UDP)                         | Layer 7 (HTTP/HTTPS)                                  | Layer 7 (DNS)                                                |
| **Features**          | Internal and public load balancer            | SSL/TLS termination and cookie-based session affinity | Traffic-routing methods, Traffic manager profile, endpoint monitoring options |
| **Routing**           | Source/Destination (IP & Port), and Protocol | URI path or Host headers                              | Offers various routing methods such as: Priority, Weighted, Performance, Geographic, Multivalue and Subnet |
| **Security**          | Integrate Azure Firewall with Standard LB.   | Web Application Firewall                              | Use locks to protect your traffic manager profile.           |



## Sources

- https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/load-balancing-overview

