# Azure VPN Gateway

[toc]

## Overview

- A secured hybrid cloud architecture.
- It is composed of gateway subnet, tunnel, and on-premises gateway.
- Protocols: Internet Protocol Security (IPsec) and Internet Key Exchange (IKE)
- VPN gateway connections: **VNet-to-VNet**, **Site-to-Site**, and **Point-to-Site**
- Create a secure connection from your on-premises network to an Azure virtual network with a site-to-site VPN.
- VNet-to-VNet connection automatically routes to the updated address space, if you updated the address space on the other VNet.
- If you need to establish a connection to your virtual network from a remote location, you can use a point-to-site (P2S) VPN.
- You can also have one VPN gateway with more than one on-premises network using a Multi-Site connection.

## Pricing

- You are billed hourly for the compute costs of the VNet gateway.
- You are charged for the egress data transfer from the virtual network gateway.
- You are only charged by the VPN Gateway when you transfer data between two different regions, except with Point-to-Site VPN.

## Sources
- https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways