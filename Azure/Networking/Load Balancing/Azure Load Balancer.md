# Azure Load Balancer

[toc]

## Overview


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



## Sources

- https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-overview

