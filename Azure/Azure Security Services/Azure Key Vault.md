# Azure Key Vault

[toc]

## Overview

- A service that allows you to store tokens, passwords, certificates, and other secrets.
- You can also create and manage the keys used to encrypt your data.

Features

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

- You are charged if the key has been used at least once in the last 30 days (*based on the key’s creation date*).
- You are charged for each historical version of a key.

Want to learn more about Azure? Watch the official Microsoft Azure YouTube channel’s video series called [**Azure Tips and Tricks**](https://www.youtube.com/watch?v=k9eQ8p2BoYU&list=PLLasX02E8BPCNCK8Thcxu-Y-XcBUbhFWC).

## Sources

- https://docs.microsoft.com/en-us/azure/key-vault/general/overview   
- https://azure.microsoft.com/en-us/services/key-vault/

