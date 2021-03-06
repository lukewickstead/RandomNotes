# Azure Firewall

[toc]

## Overview 

- A service that uses a static public IP address to protect your VNet resources.
- Azure Firewall is PCI, SOC, ISO, ICSA Labs, and HITRUST compliant.

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F08%2Fazure-firewall.png)                            

## Features

- A stateful firewall service.
- You can enable **forced tunneling** to route Internet-bound traffic to an additional firewall or virtual network appliance.
- Limit outbound traffic to a given FQDN list, including wild cards.

  - Filter any TCP/UDP protocol outbound traffic.
- To use FQDNs in your rules, you must enable DNS proxy.
- Deny the traffic of a malicious IP address with threat intelligence-based filtering

  - It has the highest priority rules and will always be processed first.
- Threat intelligence modes: Off, Alert only, Alert and deny
- With a DNS proxy, a firewall listens to port 53 and forwards the DNS requests to a DNS server.
- You can minimize the complexity of creating a security rule using a **service tag**.
- Associate up to 250 public IP addresses in your firewall.
- It supports SNAT and DNAT translation.

  - SNAT – Source NAT for outbound VNet traffic.
  - DNAT – Destination NAT for inbound network traffic.
- Azure Firewall diagnostic logs (JSON format):

  - Application rule log
  - Network rule log
- You can store all your logs in a storage account, event hubs, and Azure monitor logs.
- Azure Firewall metrics:

  - Application/Network rules hit count
  - Data processed
  - Throughput
  - Firewall health state
  - SNAT port utilization
- To manage multiple firewalls, you can use **Azure Firewall Manager**.
- Protect your VDI deployments using Azure firewall DNAT rules and threat Intelligence filtering.



## Rule Types

Azure Firewall supports rules and rule collections. A rule collection is a set of rules that share the same order and priority. Rule  collections are executed in order of their priority. Network rule  collections are higher priority than application rule collections, and  all rules are terminating.

There are three types of rule collections:

- Application rules: Configure fully qualified domain names (FQDNs) that can be accessed from a subnet.
- Network rules: Configure rules that contain source addresses, protocols, destination ports, and destination addresses.
- NAT rules: Configure DNAT rules to allow incoming connections.



## Pricing

- You are charged for each firewall deployment
- You are charged for any data processed by your firewall



## Sources

- https://docs.microsoft.com/en-us/azure/firewall/overview