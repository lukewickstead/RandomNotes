# Shared access signatures (SAS)
- A shared access signature (SAS) provides secure delegated access to  resources in your storage account without compromising the security of  your data
- With a SAS, you have granular control over how a client can  access your data
- You can control what resources the client may access,  what permissions they have on those resources, and how long the SAS is  valid, among other parameters.
## Types of shared access signatures
Azure Storage supports three types of shared access signatures:
- **User delegation SAS.** A user delegation SAS is  secured with Azure Active Directory (Azure AD) credentials and also by  the permissions specified for the SAS. A user delegation SAS applies to  Blob storage only.. Prefer this where possible as it is more secure than Service and Account SAS

- **Service SAS.** A service SAS is secured with the  storage account key. A service SAS delegates access to a resource in  only one of the Azure Storage services: Blob storage, Queue storage,  Table storage, or Azure Files.

- **Account SAS.** An account SAS is secured with the  storage account key. An account SAS delegates access to resources in one or more of the storage services. All of the operations available via a  service or user delegation SAS are also available via an account SAS.  Additionally, with the account SAS, you can delegate access to  operations that apply at the level of the service, such as **Get/Set Service Properties** and **Get Service Stats** operations. You can also delegate access to read, write, and delete  operations on blob containers, tables, queues, and file shares that are  not permitted with a service SAS.
| Type of SAS                             | Type of authorization |
| --------------------------------------- | --------------------- |
| User delegation SAS (Blob storage only) | Azure AD              |
| Service SAS                             | Shared Key            |
| Account SAS                             | Shared Key            |

## Parametrs

- API version is an optional parameter that specifies the storage service  version to use to execute the request
- The other parameters include the  following: Service version, start time, expiry time, permissions, IP,  protocol, signature.