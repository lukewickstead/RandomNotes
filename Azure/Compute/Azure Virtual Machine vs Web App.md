# Azure Virtual Machine vs Web App

[toc]

## Comparison



|                          | **Azure Virtual Machine**                                    | **Azure Web App**                                            |
| ------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Description**          | Infrastructure as a service, if you need to have full control over your computing environment. | Platform as a service, it allows you to integrate the app without managing the underlying infrastructure. |
| **Deploy**               | Uses an OS image.                                            | Uses a runtime stack.                                        |
| **State Management**     | Stateful or stateless                                        | Stateless                                                    |
| **Autoscaling**          | You need to use VM scale sets to support autoscaling in virtual machines. | Autoscaling is a built-in service in App Service.            |
| **Scale Limit**          | 1000 nodes per scale set for platform image and 600 nodes per scale set for custom image | 20 instances and 100 with App Service Environment            |
| **Traffic Distribution** | Distribute the incoming network traffic using Azure load balancer. | Load balancing is integrated into App Service.               |
| **Architecture Styles**  | The supported architecture styles are N-Tier and Web-Queue-Worker. | The supported architecture styles are N-Tier and Big compute (HPC). |



## Sources

- https://docs.microsoft.com/en-us/azure/app-service/overview
- https://docs.microsoft.com/en-us/azure/virtual-machines/windows/overview
- https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-decision-tree