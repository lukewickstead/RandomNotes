# Azure Container Instances (ACI) vs Azure Kubernetes Service (AKS)

[toc]

## Comparison

|                                   | **ACI**                                                      | **AKS**                                                      |
| --------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Description**                   | Run containers without managing servers.                     | Orchestrate and manage multiple container images and applications. |
| **Deployment**                    | For event-driven applications, quickly deploy from your container development pipelines, run data processing, and build jobs. | Uses clusters and pods to scale and deploy applications.     |
| **Web Apps (Monolithic)**         | Yes                                                          | Yes                                                          |
| **N-Tier Apps (Services)**        | Yes                                                          | Yes                                                          |
| **Cloud-Native (Microservices)**  | Yes                                                          | Yes, recommended for Linux containers                        |
| **Batch/Jobs (Background tasks)** | Yes                                                          | Yes                                                          |
| **Use cases**                     | Dev/Test scenarios Task automation CI/CD agents Small/scale batch processing Simple web apps | Containers and application configuration portability Enables you to select the number of hosts, size, and orchestrator tools Transfer container workloads to the cloud without changing your current management practices. |
| **Major Difference**              | You should use AKS if you need full container orchestration,  such as service discovery across multiple containers, automatic scaling, and coordinated application upgrades. |                                                              |

## Sources

- https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview  
- https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes  
- https://docs.microsoft.com/en-us/dotnet/architecture/modernize-with-azure-containers/