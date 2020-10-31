# Azure Kubernetes Service (AKS)
[toc]
## Overview
- An open-source tool for orchestrating and managing many container images and applications.
- Lets you deploy a managed Kubernetes cluster in Azure.
## Features
- Uses clusters and pods to scale and deploy applications.
- Kubernetes can deploy more images of containers as needed.
- It supports horizontal scaling, self-healing, load balancing, and secret management.
- Automatic monitoring of application load to determine when to scale the number of containers used.
- Allows you to replicate container architectures.
- Use Kubernetes with supported Azure regions and on-premises installations using **Azure Stack.**
- The images used by AKS come from Azure Container Registry.
- Use **Azure Advisor** to optimize your Kubernetes deployments with real-time, personalized recommendations.
## Components
- Kubernetes runs an application in your instance using **pods**.
- A **node** is made up of several pods, and **node pools** are a group of nodes with the same configuration.
- Use a **node selector** to control where a pod should be placed.
- You can run at least 2 nodes in the default node pool to ensure your cluster operates reliably.
- Multi-container pods are placed on the same node and allow containers to share the related resources.
- You can specify maximum resource limits that prevent a given  pod from consuming too much compute resources from the underlying node.
- A **deployment** determines the number of replicas (pods) to be created, but you must define a manifest file in YAML format first.
- With **StatefulSets**, you can maintain the application’s state within a single pod life cycle.
- The resources are logically grouped into a **namespace**, and a user may only interact with resources within their assigned namespaces.
## Storage
- Persistent volumes are provided by Azure disk and file storage.
- Create a Kubernetes DataDisk resource using Azure Disk.
- Mount an SMB 3.0 share backed by an Azure Storage account to pods with Azure Files.
- Volumes that are defined and created as part of the pod lifecycle only exist until the pod is deleted.
- AKS has four initial storage classes:
  - default – uses Azure StandardSSD storage to create a Managed Disk.
  - managed-premium – uses Azure Premium storage to create Managed Disk.
  - azurefile – uses Azure Standard storage to create an Azure File Share.
  - azurefile-premium – uses Azure Premium storage to create an Azure File Share.
- If no StorageClass is specified for a persistent volume, the default StorageClass is used.
## Security
- With Kubernetes RBAC, you can create roles to define permissions and then assign those roles to users with role bindings.
- You can limit network traffic between pods in your cluster with Kubernetes network policies.
- Dynamic rules enforcement across multiple clusters with Azure Policy.
- Azure AD-integrated AKS clusters can grant users or groups  access to Kubernetes resources within a namespace or across the cluster.
- Secure communication paths between namespaces and nodes with Azure Private Link.
## Pricing
- You only pay for virtual machines, associated storage, and networking resources.
- There is no charge for cluster management.
## Versions
- Uses semantic versioning: [major].[minor].
- A user has 30 days from the version removal to upgrade into a supported patch and continue receiving support.
- Azure updates the cluster automatically if it has been out of support for more than 3 minor versions.
- Downgrading a version is not supported.
## Sources
- https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes   
- https://azure.microsoft.com/en-us/services/kubernetes-service