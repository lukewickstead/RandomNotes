# Azure Security Center vs Azure Sentinel

[toc]

## Overview

| **Azure Security Center**             | **Azure Sentinel**                                           |                                                              |
| ------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Description**                       | Unified infrastructure security management system            | Intelligent security analytics and threat intelligence service. |
| **Category**                          | Cloud Security Posture Management (CSPM) / Cloud Workload Protection Platform (CWPP) | Security Information Event Management (SIEM) / Security Orchestration Automated Response (SOAR) |
| **Function**                          | Provides security alerts, scores, vulnerability assessment, recommendations, and security posture management. | Provides alert detection, threat visibility, proactive hunting, and threat response. |
| **Features**                          | Microsoft Defender ATP Integration Network map Virtual Machine Behavioral Analytics Adaptive network hardening Regulatory Compliance dashboard & reports Missing OS patches assessment Security misconfigurations assessment Endpoint protection assessment Disk encryption assessment Third-party vulnerability assessment Network security assessment | Custom analytics rules Multiple Workspace View Azure Monitor Workbooks Integration Security playbook Investigation Graph Hunting search and query tools |
| **Provides Security Recommendation?** | Yes                                                          |                                                              |
| **Threat Response Management**        | Manual                                                       | Automated                                                    |
| **Integration**                       | You may use the Azure Security Center to provide Azure Sentinel with more information to identify, investigate, and remediate threats. |                                                              |

## Sources

- https://docs.microsoft.com/en-us/azure/security-center/security-center-intro   
- https://docs.microsoft.com/en-us/azure/sentinel/overview