# Identity protection



[toc]

## Overview

Identity Protection is a tool that allows organizations to accomplish three key tasks:

- Automate the detection and remediation of identity-based risks
- Investigate risks using data in the portal
- Export risk detection data to third-party utilities for further analysis



## Risk detection and remediation

Identity Protection identifies risks in the following classifications:

| Risk detection type           | Description                                                  |
| ----------------------------- | ------------------------------------------------------------ |
| Atypical travel               | Sign in from an atypical location based on the user's recent sign-ins. |
| Anonymous IP address          | Sign in from an anonymous IP address (for example: Tor browser, anonymizer VPNs). |
| Unfamiliar sign-in properties | Sign in with properties we've not seen recently for the given user. |
| Malware linked IP address     | Sign in from a malware linked IP address.                    |
| Leaked Credentials            | Indicates that the user's valid credentials have been leaked. |
| Password spray                | Indicates that multiple usernames are being attacked using common passwords in a unified, brute-force manner. |
| Azure AD threat intelligence  | Microsoft's internal and external threat intelligence sources have identified a known attack pattern. |



## Risk investigation

Administrators can review detections and take manual action on them  if needed. There are three key reports that administrators use for  investigations in Identity Protection:

- Risky users
- Risky sign-ins
- Risk detections



## Permissions

Identity Protection requires users be a Security Reader, Security  Operator, Security Administrator, Global Reader, or Global Administrator in order to access.

| Role                   | Can do                                                       | Can't do                                                     |
| ---------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Global administrator   | Full access to Identity Protection                           |                                                              |
| Security administrator | Full access to Identity Protection                           | Reset password for a user                                    |
| Security operator      | View all Identity Protection reports and Overview blade    Dismiss user risk, confirm safe sign-in, confirm compromise | Configure or change policies    Reset password for a user    Configure alerts |
| Security reader        | View all Identity Protection reports and Overview blade      | Configure or change policies    Reset password for a user    Configure alerts    Give feedback on detections |



## License requirements

Using this feature requires an Azure AD Premium P2 license. To find the right license for your requirements, see [Comparing generally available features of the Free, Office 365 Apps, and Premium editions](https://azure.microsoft.com/pricing/details/active-directory/).

| Capability       | Details                                                      | Azure AD Free / Microsoft 365 Apps                           | Azure AD Premium P1                                          | Azure AD Premium P2 |
| ---------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------- |
| Risk policies    | User risk policy (via Identity Protection)                   | No                                                           | No                                                           | Yes                 |
| Risk policies    | Sign-in risk policy (via Identity Protection or Conditional Access) | No                                                           | No                                                           | Yes                 |
| Security reports | Overview                                                     | No                                                           | No                                                           | Yes                 |
| Security reports | Risky users                                                  | Limited Information. Only users with medium and high risk are shown. No details drawer or risk history. | Limited Information. Only users with medium and high risk are shown. No details drawer or risk history. | Full access         |
| Security reports | Risky sign-ins                                               | Limited Information. No risk detail or risk level is shown.  | Limited Information. No risk detail or risk level is shown.  | Full access         |
| Security reports | Risk detections                                              | No                                                           | Limited Information. No details drawer.                      | Full access         |
| Notifications    | Users at risk detected alerts                                | No                                                           | No                                                           | Yes                 |
| Notifications    | Weekly digest                                                | No                                                           | No                                                           | Yes                 |
|                  | MFA registration policy                                      | No                                                           | No                                                           | Yes                 |



## Source

- https://docs.microsoft.com/en-us/azure/active-directory/identity-protection
- https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/overview-identity-protection