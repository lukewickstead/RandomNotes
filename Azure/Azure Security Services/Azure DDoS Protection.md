# Azure DDoS Protection

- Allows you to protect your Azure resources from denial of service (DoS) attacks.
- DDoS protection (layers 3 and 4) offers two service tiers: **Basic** and **Standard**.

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F08%2Fazure-ddos-protection.png)                            

## Features
- **Basic**
- - Enabled by default (free).
  - It mitigates common network attacks.
  - Both basic and standard protects IPv4 and IPv6 public IP addresses.
- **Standard**
- It has advanced capabilities to protect you against network attacks such as logging, alerting, and telemetry.
  - Mitigates the following attacks:
    - Volumetric attacks – flood the network layer with attacks.
    - Protocol attacks – exploit a weakness in layers 3 and 4.
    - Resource layer attacks – a layer 7 attack that disrupts the transmission of data between hosts.
  - Enables you to configure alerts at the start and stop of an attack.
  - The metric data is retained for 30 days.
  - Provides autotuned mitigation policies (TCP/TCP SYN/UDP) for each public IP.

## Pricing

- Basic DDoS Protection provides protection at no additional charge.
- Standard DDoS Protection is a paid service. You are charged for the processed data every month (per GB).

## Source:    
- https://azure.microsoft.com/en-us/services/ddos-protection/    
- https://docs.microsoft.com/en-us/azure/virtual-network/ddos-protection-overview    
- https://docs.microsoft.com/en-us/azure/security/fundamentals/ddos-best-practices
- https://www.youtube.com/embed/D0vR6YNRCww