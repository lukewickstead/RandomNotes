# API Management

[toc]

## Overview

- API Management (APIM) is a way to create consistent and modern API gateways for existing back-end services
- API Management helps organizations publish APIs to external, partner,  and internal developers to unlock the potential of their data and  services



## Features



| Feature                                                      | Consumption | Developer | Basic | Standard | Premium |
| ------------------------------------------------------------ | ----------- | --------- | ----- | -------- | ------- |
| Azure AD integration1                                        | No          | Yes       | No    | Yes      | Yes     |
| Virtual Network (VNet) support                               | No          | Yes       | No    | No       | Yes     |
| Multi-region deployment                                      | No          | No        | No    | No       | Yes     |
| Multiple custom domain names                                 | No          | Yes       | No    | No       | Yes     |
| Developer portal2                                            | No          | Yes       | Yes   | Yes      | Yes     |
| Built-in cache                                               | No          | Yes       | Yes   | Yes      | Yes     |
| Built-in analytics                                           | No          | Yes       | Yes   | Yes      | Yes     |
| [Self-hosted gateway](https://docs.microsoft.com/en-us/azure/api-management/self-hosted-gateway-overview)3 | No          | Yes       | No    | No       | Yes     |
| [TLS settings](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-manage-protocols-ciphers) | Yes         | Yes       | Yes   | Yes      | Yes     |
| [External cache](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-cache-external) | Yes         | Yes       | Yes   | Yes      | Yes     |
| [Client certificate authentication](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-mutual-certificates-for-clients) | Yes         | Yes       | Yes   | Yes      | Yes     |
| [Backup and restore](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-disaster-recovery-backup-restore) | No          | Yes       | Yes   | Yes      | Yes     |
| [Management over Git](https://docs.microsoft.com/en-us/azure/api-management/api-management-configuration-repository-git) | No          | Yes       | Yes   | Yes      | Yes     |
| Direct management API                                        | No          | Yes       | Yes   | Yes      | Yes     |
| Azure Monitor logs and metrics                               | Yes         | Yes       | Yes   | Yes      | Yes     |
| Static IP                                                    | No          | Yes       | Yes   | Yes      | Yes     |



## Policies

- In Azure API Management (APIM), policies are a powerful capability of  the system that allow the publisher to change the behavior of the API  through configuration#
- Policies are a collection of Statements that are  executed sequentially on the request or response of an API
- Popular  Statements include format conversion from XML to JSON and call rate  limiting to restrict the amount of incoming calls from a developer
- Many more policies are available out of the box
- Policies are applied inside the gateway which sits between the API  consumer and the managed API
- The gateway receives all requests and  usually forwards them unaltered to the underlying API
- However a policy  can apply changes to both the inbound request and outbound response.



## Source

- https://docs.microsoft.com/en-us/azure/api-management/