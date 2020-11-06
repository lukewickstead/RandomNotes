# Azure Front Door

[toc]

## Overview

- Azure Font Door is an Application Delivery Network (ADN) as a service
- Works at Layer 7 (HTTP/HTTPS layer) using anycast protocol  with split TCP and Microsoft's global network to improve global  connectivity
- Provides near real-time failover
- Dynamic Site Acceleration (DSA)
  - https://en.wikipedia.org/wiki/Dynamic_site_acceleration
- Similar to Application Gateway as it is a layer 7 load balancer but differs as
  -  It is a global service while Application Gateway is a regional service
  - Does not work at a VM/container level
- Can be used in front of an Application Gateway or Azure Load Balancer
- Requests are routed to the fastest and most available backend
- An application backend is any Internet-facing service hosted inside or outside of Azure
- Supports a range of traffic-routing methods and backend health monitoring options for various application needs and automatic failover models.

- With URL-based routing, it routes the traffic to backend pools based on URL paths of the request.
- You can configure more than one website on the same Front Door with multiple-site hosting.
- Use cookie-based session affinity to redirect the user session to the same application backend.
- URL redirect traffic based on protocol, hostname, path, and query string with URL redirect.
- URL rewrite allows you to configure a Custom Forwarding Path that will copy any part of the incoming path that matches a wildcard path to the forwarded path.
  Front Door supports end-to-end IPv6 connectivity and HTTP/2 protocol.
- Supports SSL offloading, namely the handshaking, encryption and decryption to help with performance



## Security

- If you need your domain name to be visible in your Front Door URL, you must have a custom domain. Front Door also supports managed certificates or custom TLS/SSL certificates.
- You can create custom rules to protect your HTTP/HTTPS workload from exploitation using Azure Web Application Firewall.
- Rules engine
  - Enforce HTTPS
  - Implement security headers



## Pricing

- You are charged based on the following:
 - Inbound and outbound data transfers
 - The number of routing rules
- Front Door has a limit of 100 custom domains. You will be charged for additional domains



## Sources

- https://docs.microsoft.com/en-us/azure/frontdoor/front-door-overview
