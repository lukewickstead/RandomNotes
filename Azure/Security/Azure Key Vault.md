# Azure Key Vault

[toc]

## Overview

- Azure Key Vault helps solve the following problems:
  - **Secrets Management** - Azure Key Vault can be used to Securely store and tightly control access to tokens, passwords,  certificates, API keys, and other secrets
  - **Key Management** - Azure Key Vault can also be used  as a Key Management solution. Azure Key Vault makes it easy to create  and control the encryption keys used to encrypt your data
  - **Certificate Management** - Azure Key Vault is also a  service that lets you easily provision, manage, and deploy public and  private Transport Layer Security/Secure Sockets Layer (TLS/SSL)  certificates for use with Azure and your internal connected resources
- Allows centralizing application secrets
- Monitor access and use
- Replicates secrets between regions
- Allows automating certain tasks such as renewal of SSL certificates from Public CAs
- Segregate application secrets so applications only have access to the secrets which concern them
- Integrates with other Azure services
  - [Azure Disk Encryption](https://docs.microsoft.com/en-us/azure/security/fundamentals/encryption-overview)
  - The [always encrypted](https://docs.microsoft.com/en-us/sql/relational-databases/security/encryption/always-encrypted-database-engine) and [Transparent Data Encryption](https://docs.microsoft.com/en-us/sql/relational-databases/security/encryption/transparent-data-encryption?view=sql-server-ver15) functionality in SQL server and Azure SQL Database
  - [Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate).



## Features

- **Soft delete** allows a deleted key vault and its objects to be retrieved during the retention time you designate.
- The retention period of a deleted vault is between 7 to 90 days.
- With soft-delete and **purge protection** enabled, it will not purge a vault or object in the deleted state until the retention period has expired.
- You may connect to a key vault via
  - A public endpoint in all networks
  - A public endpoint in selected networks
  - A private endpoint
- Share access to your applications and resources without revealing your credentials.



## Concepts

- A tenant is a representation of an organization.
  - Azure Active Directory allows you to publish multi-tenant applications.
  - Azure Active Directory (B2C) tenant represents a collection of identities.
- A **vault owner** enables you to create a key vault and set up an auditing log of who has access to secrets and keys.
- A **vault consumer** can only perform actions on the assets inside the key vault if the vault owner grants the consumer access.
- A manageable item in Azure is called **resource**, and **resource groups** are containers that hold related resources.
- **Service principal** gives you control over which resources can be accessed. At the same time, a **managed identity** eliminates the need for you to create and manage service principals directly since it provides Azure services with an automatically managed identity in  Azure AD.
- You can identify an Azure AD instance within your Azure subscription using a **tenant ID**.



## Pricing

- You are charged if the key has been used at least once in the last 30 days (*based on the key’s creation date*)

- You are charged for each historical version of a key

  

## Sources

- https://azure.microsoft.com/en-us/services/key-vault/

