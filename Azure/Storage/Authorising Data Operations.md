# Authorizing Data Operations

[toc]

## Overview



| Azure artifact     | Shared Key (storage account key)                             | Shared access signature (SAS)                                | Azure Active Directory (Azure AD)                            | On-premises Active Directory Domain Services (preview)       | Anonymous public read access                                 |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Azure Blobs        | [Supported](https://docs.microsoft.com/en-us/rest/api/storageservices/authorize-with-shared-key/) | [Supported](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview) | [Supported](https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad) | Not supported                                                | [Supported](https://docs.microsoft.com/en-us/azure/storage/blobs/anonymous-read-access-configure) |
| Azure Files (SMB)  | [Supported](https://docs.microsoft.com/en-us/rest/api/storageservices/authorize-with-shared-key/) | Not supported                                                | [Supported, only with AAD Domain Services](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-active-directory-overview) | [Supported, credentials must be synced to Azure AD](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-active-directory-overview) | Not supported                                                |
| Azure Files (REST) | [Supported](https://docs.microsoft.com/en-us/rest/api/storageservices/authorize-with-shared-key/) | [Supported](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview) | Not supported                                                | Not supported                                                | Not supported                                                |
| Azure Queues       | [Supported](https://docs.microsoft.com/en-us/rest/api/storageservices/authorize-with-shared-key/) | [Supported](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview) | [Supported](https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad) | Not Supported                                                | Not supported                                                |
| Azure Tables       | [Supported](https://docs.microsoft.com/en-us/rest/api/storageservices/authorize-with-shared-key/) | [Supported](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview) | Not supported                                                | Not supported                                                | Not supported                                                |



- **Azure Active Directory (Azure AD) integration**  for blobs, and queues. Azure provides Azure role-based access control  (Azure RBAC) for control over a client's access to resources in a  storage account. For more information regarding Azure AD integration for blobs and queues, see [Authorize access to Azure blobs and queues using Azure Active Directory](https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad).
- **Azure Active Directory Domain Services (Azure AD DS) authentication** for Azure Files. Azure Files supports identity-based authorization over Server Message Block (SMB) through Azure AD DS. You can use Azure RBAC  for fine-grained control over a client's access to Azure Files resources in a storage account. For more information regarding Azure Files  authentication using domain services, refer to the [overview](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-active-directory-overview).
- **On-premises Active Directory Domain Services (AD DS, or on-premises AD DS) authentication (preview)** for Azure Files. Azure Files supports identity-based authorization over SMB through AD DS. Your AD DS environment can be hosted in on-premises  machines or in Azure VMs. SMB access to Files is supported using AD DS  credentials from domain joined machines, either on-premises or in Azure. You can use a combination of Azure RBAC for share level access control  and NTFS DACLs for directory/file level permission enforcement. For more information regarding Azure Files authentication using domain services, refer to the [overview](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-active-directory-overview).
- **Shared Key authorization** for blobs, files,  queues, and tables. A client using Shared Key passes a header with every request that is signed using the storage account access key. For more  information, see [Authorize with Shared Key](https://docs.microsoft.com/en-us/rest/api/storageservices/authorize-with-shared-key/).
- **Shared access signatures** for blobs, files,  queues, and tables. Shared access signatures (SAS) provide limited  delegated access to resources in a storage account. Adding constraints  on the time interval for which the signature is valid or on permissions  it grants provides flexibility in managing access. For more information, see [Using shared access signatures (SAS)](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview).
- **Anonymous public read access** for containers and blobs. Authorization is not required. For more information, see [Manage anonymous read access to containers and blobs](https://docs.microsoft.com/en-us/azure/storage/blobs/anonymous-read-access-configure)



## Shared Access Signatures (SAS)

- A shared access signature (SAS) provides secure delegated access to  resources in your storage account without compromising the security of  your data
- With a SAS, you have granular control over how a client can  access your data
- You can control what resources the client may access,  what permissions they have on those resources, and how long the SAS is  valid, among other parameters.
- Use a SAS when you want to provide secure access to resources in your  storage account to any client who does not otherwise have permissions to those resources



### Types of shared access signatures

Azure Storage supports three types of shared access signatures:
- **User delegation SAS.** A user delegation SAS is  secured with Azure Active Directory (Azure AD) credentials and also by  the permissions specified for the SAS. A user delegation SAS applies to  Blob storage only.. Prefer this where possible as it is more secure than Service and Account SAS
- **Service SAS.** A service SAS is secured with the  storage account key. A service SAS delegates access to a resource in  only one of the Azure Storage services: Blob storage, Queue storage,  Table storage, or Azure Files.
- **Account SAS.** An account SAS is secured with the  storage account key. An account SAS delegates access to resources in one or more of the storage services. All of the operations available via a  service or user delegation SAS are also available via an account SAS.  Additionally, with the account SAS, you can delegate access to  operations that apply at the level of the service, such as **Get/Set Service Properties** and **Get Service Stats** operations. You can also delegate access to read, write, and delete  operations on blob containers, tables, queues, and file shares that are  not permitted with a service SAS



A shared access signature can take one of two forms:



- **Ad hoc SAS:** When you create an ad hoc SAS, the  start time, expiry time, and permissions for the SAS are all specified  in the SAS URI (or implied, if start time is omitted). Any type of SAS  can be an ad hoc SAS.
- **Service SAS with stored access policy:** A stored  access policy is defined on a resource container, which can be a blob  container, table, queue, or file share. The stored access policy can be  used to manage constraints for one or more service shared access  signatures. When you associate a service SAS with a stored access  policy, the SAS inherits the constraints—the start time, expiry time,  and permissions—defined for the stored access policy.




| Type of SAS                             | Type of authorization |
| --------------------------------------- | --------------------- |
| User delegation SAS (Blob storage only) | Azure AD              |
| Service SAS                             | Shared Key            |
| Account SAS                             | Shared Key            |



### SAS Token

- The SAS token is a string that you generate on the client side, for  example by using one of the Azure Storage client libraries
- The SAS  token is not tracked by Azure Storage in any way
- You can create an  unlimited number of SAS tokens on the client side
- After you create a  SAS, you can distribute it to client applications that require access to resources in your storage account.

![Components of a service SAS URI](https://docs.microsoft.com/en-us/azure/storage/common/media/storage-sas-overview/sas-storage-uri.png)



## Sources

- https://docs.microsoft.com/en-us/rest/api/storageservices/authorize-with-shared-key
- https://docs.microsoft.com/en-us/rest/api/storageservices/delegate-access-with-shared-access-signature