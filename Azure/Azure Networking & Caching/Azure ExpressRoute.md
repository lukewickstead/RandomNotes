# Azure ExpressRoute

[toc]

## Overview

- Enables you to establish a private connection between your on-premises data center or corporate network to your Azure cloud  infrastructure.
- More secure, reliable, and faster than conventional VPN connections.
- Supports dynamic routing between your network and Microsoft  via Border Gateway Protocol (BGP). The connection is redundant in every  peering location for higher reliability.

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F09%2Fazure-expressroute.png)                            

## Features

- ExpressRoute connections enable access to Microsoft Azure  services and Microsoft Office 365 services from your on-premises  network.

- Provides connectivity to all regions within a **geopolitical region**.

- To extend connectivity across geopolitical boundaries, you can enable **ExpressRoute Premium**.

- **ExpressRoute Global Reach** allows you to exchange data across your on-premises environments by connecting it to your ExpressRoute circuits.

- **ExpressRoute Direct** provides dual 100Gbps connectivity that supports Active/Active scale connectivity.

- Supported bandwidth options up to 10 Gbps.

- ExpressRoute premium add-on (for ExpressRoute circuit) provides the following capabilities:

  - Increased route limits from 4,000 routes to 10,000 routes for Azure public and private peering.
- Global access to services across any other region.
  - Increase the number of VNet links (*from 10 to a larger limit*) on every ExpressRoute circuit.

## Use Cases

- Transferring large data sets.
- Developing and using applications that use real-time data feeds.
- Building hybrid environments that satisfy regulatory requirements mandating the use of private connectivity.

## Pricing

- Billing Models:
  - Unlimited data – all inbound and outbound data transfer is free.
  - Metered data – all inbound data transfer is free but outbound  data transfer is billed per GB. The rate of data transfer varies by  region.
- ExpressRoute billing begins when a service key is issued to the customer.
- If the service is active for the **entire month**, you will be billed for the monthly fee regardless of your usage. However, if you cancelled the service **during the month**, then you are charged for the hours used.

## Sources   

- https://docs.microsoft.com/en-us/azure/expressroute/expressroute-introduction