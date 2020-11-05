# Azure Traffic Manager

[toc]

## Overview

- A DNS-based traffic load balancer.
- Improves the responsiveness of your applications by sending the request to the closest endpoint.
- It offers a range of **traffic-routing methods** and **endpoint monitoring options**.



## Features

- It is resilient to failure.
- You can obtain actionable insights about your users using a **traffic view.**
- Improve the availability of your applications by using traffic manager health checks.
- Offers automatic failover when an endpoint goes down
- Traffic Manager endpoints: **Azure**, **External**, and **Nested**
-   Combine multiple traffic-routing methods using **nested traffic manager profiles**.



## Routing Methods

- Priority – allows you to set a primary endpoint for all traffic.
- Weighted – distribute traffic according to weights.
- Performance – routes users to the closest endpoint.
- Geographic – direct users to a specific endpoint.
- Multivalue – endpoints for IPv4/IPv6 addresses.
- Subnet – map a group of end-user IP address range to a specific endpoint.



## Pricing

- You are charged based on the number of DNS queries received.
- You are also charged for each monitored endpoint.
- You can reduce your DNS query charges by configuring a larger TTL.
- You are charged for the number of data points used in the traffic view.

## Sources

- https://docs.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview 
