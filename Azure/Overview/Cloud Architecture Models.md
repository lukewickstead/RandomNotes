# Azure Cloud Architecture Models

[toc]

## Overview

- Three deployment methods of cloud computing: **Public vs Private vs Hybrid.**
- The model you choose for cloud deployment depends on your budget, security, scalability, and maintenance needs.



### Public Cloud

- Focus on maintaining your applications without having to  worry about purchasing, managing, or maintaining the hardware on which  it runs.
- You can use multiple public cloud providers of varying scale.

| **Advantages**                                               | **Disadvantages**                                            |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| High scalability/agility                                     | Specific security requirements                               |
| Pay-as-you-go pricing                                        | Government policies, industry standards, or legal requirements |
| You are not responsible for the updates and maintenance of the hardware. | You don’t own the hardware or services and you also can’t manage them as you may want to. |
| The required technical knowledge is minimal.                 | Maintaining a legacy application might be hard to meet       |



### Private Cloud

- A dedicated on-premises datacenter configured to be a  cloud environment that provides users in your organization with  self-service access to compute resources.
- You are responsible for the purchase and maintenance of the hardware and software services.
- You can use a private cloud when an organization has data that cannot be put in the public cloud, perhaps for legal reasons.

| **Advantages**                                               | **Disadvantages**                                            |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Any scenario or legacy application configuration is supported. | CapEx involved – principal cost is the procurement of the equipment. |
| You have control (and responsibility) over security          | To scale, you must buy, install, and set up new hardware     |
| Compliance, or security requirements in your organization    | Private clouds require IT skills and expertise               |



### Hybrid Cloud

- Data and applications can move between **private** and **public clouds**.
- When there is a spike in demand in your private cloud, you can “burst through” to the public cloud for additional computing resources.

| **Advantages**                                               | **Disadvantages**                                            |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Maintain a private infrastructure for sensitive assets.      | More expensive than selecting one deployment model since it involves some CapEx cost upfront |
| Take advantage of the resources in the public cloud when needed. | It can be more complicated to set up and manage              |
| With the ability to scale to the public cloud, you pay for extra computing power only when needed. |                                                              |
| Allows you to use your own equipment to meet the security and compliance requirements in your organization. |                                                              |



## Sources

- https://azure.microsoft.com/en-us/overview/what-are-private-public-hybrid-clouds
- https://docs.microsoft.com/en-us/learn/modules/principles-cloud-computing/4-cloud-deployment-models