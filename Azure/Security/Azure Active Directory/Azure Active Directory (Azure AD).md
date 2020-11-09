# Azure Active Directory (Azure AD)

[toc]

## Overview

- Azure Active Directory (Azure AD) is Microsoft’s cloud-based identity and access management service, which helps your employees sign in and  access resources in:
  - External resources, such as Microsoft 365, the Azure portal, and thousands of other SaaS applications.
  - Internal resources, such as apps on your corporate network and  intranet, along with any cloud apps developed by your own organization.  For more information about creating a tenant for your organization



## Azure AD Licenses

- Microsoft Online business services, such as Microsoft 365 or Microsoft  Azure, require Azure AD for sign-in and to help with identity  protection. If you subscribe to any Microsoft Online business service,  you automatically get Azure AD with access to all the free features
- To enhance your Azure AD implementation, you can also add paid  capabilities by upgrading to Azure Active Directory Premium P1 or  Premium P2 licenses. Azure AD paid licenses are built on top of your  existing free directory, providing self-service, enhanced monitoring,  security reporting, and secure access for your mobile users
- **Azure Active Directory Free.** Provides user and  group management, on-premises directory synchronization, basic reports,  self-service password change for cloud users, and single sign-on across  Azure, Microsoft 365, and many popular SaaS apps.
- **Azure Active Directory Premium P1.** In addition  to the Free features, P1 also lets your hybrid users access both  on-premises and cloud resources. It also supports advanced  administration, such as dynamic groups, self-service group management,  Microsoft Identity Manager (an on-premises identity and access  management suite) and cloud write-back capabilities, which allow  self-service password reset for your on-premises users.
- **Azure Active Directory Premium P2.** In addition to the Free and P1 features, P2 also offers [Azure Active Directory Identity Protection](https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/overview-identity-protection) to help provide risk-based Conditional Access to your apps and critical company data and [Privileged Identity Management](https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-getting-started) to help discover, restrict, and monitor administrators and their access to resources and to provide just-in-time access when needed.
- **"Pay as you go" feature licenses.** You can also  get additional feature licenses, such as Azure Active Directory  Business-to-Customer (B2C). B2C can help you provide identity and access management solutions for your customer-facing apps. For more  information, see [Azure Active Directory B2C documentation](https://docs.microsoft.com/en-us/azure/active-directory-b2c/).



## Features

| Category                               | Description                                                  |
| -------------------------------------- | ------------------------------------------------------------ |
| Application management                 | Manage your cloud and on-premises apps using Application Proxy,  single sign-on, the My Apps portal (also known as the Access panel), and Software as a Service (SaaS) apps. For more information, see [How to provide secure remote access to on-premises applications](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/application-proxy) and [Application Management documentation](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/). |
| Authentication                         | Manage Azure Active Directory self-service password reset,  Multi-Factor Authentication, custom banned password list, and smart  lockout. For more information, see [Azure AD Authentication documentation](https://docs.microsoft.com/en-us/azure/active-directory/authentication/). |
| Azure Active Directory for developers  | Build apps that sign in all Microsoft identities, get tokens to call Microsoft Graph, other Microsoft APIs, or custom APIs. For more  information, see [Microsoft identity platform (Azure Active Directory for developers)](https://docs.microsoft.com/en-us/azure/active-directory/develop/). |
| Business-to-Business (B2B)             | Manage your guest users and external partners, while maintaining  control over your own corporate data. For more information, see [Azure Active Directory B2B documentation](https://docs.microsoft.com/en-us/azure/active-directory/external-identities/). |
| Business-to-Customer (B2C)             | Customize and control how users sign up, sign in, and manage their profiles when using your apps. For more information, see [Azure Active Directory B2C documentation](https://docs.microsoft.com/en-us/azure/active-directory-b2c/). |
| Conditional Access                     | Manage access to your cloud apps. For more information, see [Azure AD Conditional Access documentation](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/). |
| Device Management                      | Manage how your cloud or on-premises devices access your corporate data. For more information, see [Azure AD Device Management documentation](https://docs.microsoft.com/en-us/azure/active-directory/devices/). |
| Domain services                        | Join Azure virtual machines to a domain without using domain controllers. For more information, see [Azure AD Domain Services documentation](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/). |
| Enterprise users                       | Manage license assignment, access to apps, and set up delegates using groups and administrator roles. For more information, see [Azure Active Directory user management documentation](https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/). |
| Hybrid identity                        | Use Azure Active Directory Connect and Connect Health to provide a  single user identity for authentication and authorization to all  resources, regardless of location (cloud or on-premises). For more  information, see [Hybrid identity documentation](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/). |
| Identity governance                    | Manage your organization's identity through employee, business  partner, vendor, service, and app access controls. You can also perform  access reviews. For more information, see [Azure AD identity governance documentation](https://docs.microsoft.com/en-us/azure/active-directory/governance/identity-governance-overview) and [Azure AD access reviews](https://docs.microsoft.com/en-us/azure/active-directory/governance/access-reviews-overview). |
| Identity protection                    | Detect potential vulnerabilities affecting your organization's  identities, configure policies to respond to suspicious actions, and  then take appropriate action to resolve them. For more information, see [Azure AD Identity Protection](https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/). |
| Managed identities for Azure resources | Provides your Azure services with an automatically managed identity  in Azure AD that can authenticate any Azure AD-supported authentication  service, including Key Vault. For more information, see [What is managed identities for Azure resources?](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview). |
| Privileged identity management (PIM)   | Manage, control, and monitor access within your organization. This  feature includes access to resources in Azure AD and Azure, and other  Microsoft Online Services, like Microsoft 365 or Intune. For more  information, see [Azure AD Privileged Identity Management](https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/). |
| Reports and monitoring                 | Gain insights into the security and usage patterns in your environment. For more information, see [Azure Active Directory reports and monitoring](https://docs.microsoft.com/en-us/azure/active-directory/reports-monitoring/). |



## Security

### Multi Factor Authentication

- There are multiple ways to enable Azure Multi-Factor Authentication for  your Azure Active Directory (AD) users based on the licenses that your  organization owns
- Turned on based on subscription
  - **Free** by using the security defaults option
  - **Microsoft 365 Business, E3 or E5** are either all on or off for all users for all sign in events
  - Upgrade to Azure AD P1 or P2 and use Conditional Access
  - **Azure AD Premium P1** by using the Azure AD Conditional Access to prompt user for MFA for configured scenarios and events
  - **Azure AD Premium P2** allows the strongest option by adding risk-based Conditional Access

#### MFA Authentication Methods

| Method                                              | Security defaults | All other methods |
| --------------------------------------------------- | ----------------- | ----------------- |
| Notification through mobile app                     | X                 | X                 |
| Verification code from mobile app or hardware token |                   | X                 |
| Text message to phone                               |                   | X                 |
| Call to phone                                       |                   | X                 |



#### Security Defaults

- Managing security can be difficult with common identity-related  attacks like password spray, replay, and phishing becoming more and more popular
- Preconfigured security settings:
  - Requiring all users to register for Azure Multi-Factor Authentication.
  - Requiring administrators to perform multi-factor authentication.
  - Blocking legacy authentication protocols.
  - Requiring users to perform multi-factor authentication when necessary.
  - Protecting privileged activities like access to the Azure portal
- Enabled via properties under Azure AD in the Portal



#### Conditional Access

- You can use Conditional Access to configure policies similar to security defaults, but with more granularity including user exclusions



#### Sign-in risk-based Conditional Access

- Most users have a normal behavior that can be tracked, when they fall  outside of this norm it could be risky to allow them to just sign in
- You may want to block that user or maybe just ask them to perform multi-factor authentication to prove that they are really who they say  they are
- This can be enabled with Conditional Access Policy via the portal
  - Azure Active Directory > Security > Conditional Access
- This can be enabled through Identity Protection via the portal
  - All Services > Azure AD Identity Protection



## Additional Points

- Detect potential vulnerabilities and resolve suspicious actions with **identity protection**

- You use **block legacy authentication** if a user is using a legacy application
- **Identity secure score** helps you verify your configurations if it’s aligned with Microsoft’s best practice for security
- You can lockout intruders that try to guess your users’ passwords or use brute-force methods in Azure AD using **smart lockout**
- Manage, control, and monitor access to significant resources in your organization with **Privileged Identity Management (PIM)**



## Monitoring

- Monitor the security and usage patterns of your environment with **Azure AD reports and monitoring**.
- With **Azure AD Connect Health**, you can view alerts, monitor performance and check usage analytics of your on-premises Active Directory and Azure AD



## Sources   

- https://docs.microsoft.com/en-us/azure/active-directory
- https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-whatis
- https://docs.microsoft.com/en-us/azure/active-directory/develop
- https://www.youtube.com/watch?v=AO-uTWSmU_E&list=PLLasX02E8BPBm1xNMRdvP6GtA6otQUqp0