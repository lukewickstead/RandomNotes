# Azure DNS

[toc]

## Overview

Enables you to host your DNS zone and manage your DNS records.

DNS zone allows you to configure a private and public DNS zone.

Alias recordsets:

- A – maps the host to IPv4.
- AAAA – maps the host to IPv6.
- CNAME – create a record to point to another domain.

A limit of 20 alias record sets per resource.

Uses Anycast networking to route users to the closest name servers.

You can monitor your DNS zone metrics using Azure Monitor.

- QueryVolume – query traffic received.
- RecordSetCount – the number of recordsets in your DNS.
- RecordSetCapacityUtilization – percentage of utilization of your recordset capacity.

**Azure Private DNS** allows you to use your custom domain name in your private VNet.

Alias record allows you to point your naked domain or apex to a traffic manager or CDN endpoint.

## Private DNS

- Allows you to manage and resolve domain names in a virtual network.
- Configure a split-horizon DNS to create zones with the same name.
- It also supports all types of DNS records types: A, AAAA, CNAME, MX, PTR, SOA, SRV, and TXT.
- A virtual network can be linked to only one private zone. But you can link multiple virtual networks to a single DNS zone.
- Private IP space in the linked virtual network allows reverse DNS.

## Security

- To prevent accidental zone deletion, you can apply a ‘CanNotDelete’ lock.
- Create a custom role to ensure it doesn’t have a zone delete permission.
- You can deploy a DNS firewall to mitigate DNS-related security issues.

## Pricing

- Billed on the number of hosted DNS zones.
- You are charged based on the number of DNS queries received.

## Sources     

- https://docs.microsoft.com/en-us/azure/dns/dns-overview