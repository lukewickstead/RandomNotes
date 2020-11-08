# Azure App Service
[toc]
## Overview
- HTTP-based service for hosting web applications, REST APIs, and mobile back end
- A fully managed platform (PaaS) for building, deploying, and scaling your web apps
  - Azure automatically patches and maintains the OS and language frameworks
- Different types of App Services: **Web Apps, Web Apps for Containers,** and **API Apps**
- App Service can scale up or out manually or automatically
- App Service supports the following languages; .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python



## App Service plans

- An **App Service App** always runs in an App Service plan
- An **App Service Plan** defines a set of compute resources for a web app to run; similar to a server farm in conventional web hosting
- One or more apps can run in the same App service Plan
- Each App Service plan consists of a **region, number & size of virtual machines** and **pricing tier**
- The **Pricing tier** determines what features are available and how much you pay 
  - Features available can be found
    - https://azure.microsoft.com/en-gb/pricing/details/app-service/windows/
  - **Shared Compute**
    - Consisting of **Free** and **Shared** tiers
    - Runs an app on the same VM as other app service apps which might be other customers
    - CPU quotas (minutes) are allocated to each app that runs on the shares resources
    - Resources cannot scale out
    - In the **Shared** tier, each app receives a quota of CPU minutes, so *each app* is charged for the CPU quota.
    - In the **Free** tier you are not charged but it is considered a try for free
  - **Dedicated Compute**
    - Consisting of **Basic, Standard, Premium PremiumV2 and PremiumV3** tiers
    - Runs apps on dedicated Azure VMs
    - Only apps in the same App Service Plan share the same compute resource
    - The higher the tier, the more VM instances are available to you for scale-out.
    - The App Service plan defines the number of VM instances the apps are scaled to
    - Each VM charged regardless of usage
  - **Isolated**
    - Dedicated Azure VMs on dedicated Azure Virtual Networks
    - Provides network isolation on top of compute isolation. 
    - Provides the maximum scale-out capabilities.
    - The App service plan
    - The App Service Environment defines the number of isolated workers
    - Each isolated worker is charged
    - A flat fee for running the App Service Environment is also applied
- An App Service plan is the scale unit as all resources run on them and they define the number of VMs to use (except shared)
- An App Service plan can be scaled up and down at any time by changing the pricing tier
- Alternatively you can move an app into its own App Service plan
- Grouping apps into the same App Service plan can save money
- Be careful overloading an App Service as this could cause downtime



|                              | Free                                Try for free | Shared                                Environment for dev/test | Basic                            Dedicated environment for dev/test | Standard                            Run production workloads | Premium                            Enhanced performance and scale | Isolated                            High-performance, security and isolation |
| ---------------------------- | ------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Web, mobile or API apps      | 10                                               | 100                                                          | Unlimited                                                    | Unlimited                                                    | Unlimited                                                    | Unlimited                                                    |
| Disk space                   | 1 GB                                             | 1 GB                                                         | 10 GB                                                        | 50 GB                                                        | 250 GB                                                       | 1 TB                                                         |
| Maximum instances            | –                                                | –                                                            | Up to 3                                                      | Up to 10                                                     | Up to 30*                                                    | Up to 100                                                    |
| Custom domain                | –                                                | Supported                                                    | Supported                                                    | Supported                                                    | Supported                                                    | Supported                                                    |
| Auto Scale                   | –                                                | –                                                            | –                                                            | Supported                                                    | Supported                                                    | Supported                                                    |
| Hybrid connectivity          | –                                                | –                                                            | Supported                                                    | Supported                                                    | Supported                                                    | Supported                                                    |
| Virtual Network connectivity | –                                                | –                                                            | –                                                            | Supported                                                    | Supported                                                    | Supported                                                    |
| Private endpoints            | –                                                | –                                                            | –                                                            | –                                                            | Supported                                                    | Supported                                                    |
| Compute type                 | Shared                                           | Shared                                                       | Dedicated                                                    | Dedicated                                                    | Dedicated                                                    | Isolated                                                     |
| Price                        | Free                                             | £0.010/hour                                                  | £0.056/hour                                                  | £0.075/hour                                                  | £0.150/hour                                                  | £0.299/hour                                                  |

| Instance (Basic)                                             | Cores                        | RAM  | Storage | Prices                |
| ------------------------------------------------------------ | ---------------------------- | ---- | ------- | --------------------- |
| F1                                                                 **Free** | Shared (60 CPU minutes/day)  | 1 GB | 1.00 GB | £0                    |
| D1                                                                 **Shared** | Shared (240 CPU minutes/day) | 1 GB | 1.00 GB | £0.010/hour  per site |

| Instance (Standard) | Cores | RAM     | Storage | Prices      |
| ------------------- | ----- | ------- | ------- | ----------- |
| S1                  | 1     | 1.75 GB | 50 GB   | £0.075/hour |
| S2                  | 2     | 3.50 GB | 50 GB   | £0.150/hour |
| S3                  | 4     | 7 GB    | 50 GB   | £0.299/hour |



| Instance (Premium V2) | Cores | RAM     | Storage | Prices      |
| --------------------- | ----- | ------- | ------- | ----------- |
| P1v2                  | 1     | 3.50 GB | 250 GB  | £0.150/hour |
| P2v2                  | 2     | 7 GB    | 250 GB  | £0.299/hour |
| P3v2                  | 4     | 14 GB   | 250 GB  | £0.597/hour |

| Instance (Premium V3) | Cores | RAM   | Storage | Prices      |
| --------------------- | ----- | ----- | ------- | ----------- |
| P1v3                  | 2     | 8 GB  | 250 GB  | £0.246/hour |
| P2v3                  | 4     | 16 GB | 250 GB  | £0.492/hour |
| P3v3                  | 8     | 32 GB | 250 GB  | £0.984/hour |


| Instance (Isolated) | 1    | 3.50 GB | 1 TB | £0.299/hour |
| ------------------- | ---- | ------- | ---- | ----------- |
| I2                  | 2    | 7 GB    | 1 TB | £0.597/hour |
| I3                  | 4    | 14 GB   | 1 TB | £1.193/hour |



## App Service Environments (ASE)

- Azure App Service Environment is an Azure App Service feature that  provides a fully isolated and dedicated environment for securely running App Service apps at high scale
- App Service environments (ASEs) are appropriate for application workloads that require:
  - Very high scale.
  - Isolation and secure network access.
  - High memory utilization
- Dedicated environment; An ASE is dedicated exclusively to a single subscription and can host 100 App Service Plan instances
- zure [App Service Environment](https://docs.microsoft.com/en-us/azure/app-service/environment/intro) is a deployment of Azure App Service into a subnet in your Azure  virtual network (VNet). There are two deployment types for an App  Service environment (ASE):
  - **External ASE**: Exposes the ASE-hosted apps on an internet-accessible IP address. For more information, see [Create an External ASE](https://docs.microsoft.com/en-us/azure/app-service/environment/create-external-ase).
  - **ILB ASE**: Exposes the ASE-hosted apps on an IP  address inside your VNet. The internal endpoint is an internal load  balancer (ILB), which is why it's called an ILB ASE. For more  information, see [Create and use an ILB ASE](https://docs.microsoft.com/en-us/azure/app-service/environment/create-ilb-ase)



## Operating Systems

- Supports both Windows and Linux based environments
- Linux apps run in their own containers
  - 	No access to the host operating system is allowed
  - 	You do not have root access to the container
  - 	Not supported on shared pricing tier
- You cannot mix Windows and Linux apps in the same resource group
- Apps run their framework in fully trusted mode; they can spawn processes, make network requests, see mounted network drives and the disks of the VM
- Are limited to the permission of the VM; for example you cannot unmounted disks



## OS Functionality

### Local Drives

At its core, App Service is a service running on top of the Azure  PaaS (platform as a service) infrastructure. As a result, the local  drives that are "attached" to a virtual machine are the same drive types available to any worker role running in Azure. This includes:

- An operating system drive (the D:\ drive)
- An application drive that contains Azure Package cspkg files used exclusively by App Service (and inaccessible to customers)
- A "user" drive (the C:\ drive), whose size varies depending on the size of the VM



### Network drives (UNC shares)

- For an App Service all user content is stored on a set of UNC shares
- There is a number of UNC shares created in each data center, all of the file content for a single customer's subscription is always placed on the  same UNC share
- VMs mapping up and down will mount these
- Access is permitted but you should map to the faux absolute path D:\home\site


### Network Access

- Application code can use TCP/IP and UDP-based protocols to make outbound network connections to Internet accessible endpoints that expose  external services
  

### Code execution, processes, and memory

-  Apps run inside of low-privileged worker processes using a random application pool identity
- Application code has access to the memory space associated with the  worker process, as well as any child processes that may be spawned by  CGI processes or other applications but not other apps on the same VM
- App Service doesn't configure any web framework settings to more  restricted modes. For example, ASP.NET apps running on App Service run  in "full" trust as opposed to a more restricted trust mode
- Apps can spawn and run arbitrary code; for example spawning a shell or run a PowerShell script but they are still restricted to the privileges granted to the parent application pool


## Deployment

- Deployment components in App Service:
  - **Deployment Source**  is where the application code is stored; for example Bit Bucket or GitHub
  - **Build Pipeline** reads your code and performs the required state to make artefacts for your app to run
  - **Deployment Mechanism** is the action required to put your built application into the */home/site/wwwroot*  directory
    - Supported mechanisms are Kudo, FTP and WebDeploy
    - Deployment tools such as Azure Pipelines, Jenkins, and editor plugins use one of these deployment mechanisms
- **Deployment Center** lets you choose the location of your  code, as well as build and deploy to the cloud. It also has built-in  continuous delivery for containers
- **Deployment slots** 
  - Allow deploying to an offline environment 
  - Prevents downtime due to releasing
  - Allow validating the new environment and running smoke tests
  - Slots are swapped once you are happy with the new environment
- App Service supports the continuous deployment of code and containers
- You can use **local cache** if your app needs high performance read only content store
  - Content is normally stored on Azure storage
- App Service **diagnostics** will help you in troubleshooting your application.



## Security

- Your app resources are [secured](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox) from the other customers' Azure resources.
- [VM instances and runtime software are regularly updated](https://docs.microsoft.com/en-us/azure/app-service/overview-patch-os-runtime) to address newly discovered vulnerabilities.
- Communication of secrets (such as connection strings) between your app and other Azure resources (such as [SQL Database](https://azure.microsoft.com/services/sql-database/)) stays within Azure and doesn't cross any network boundaries. Secrets are always encrypted when stored.
- All communication over the App Service connectivity features, such as [hybrid connection](https://docs.microsoft.com/en-us/azure/app-service/app-service-hybrid-connections), is encrypted.
- Connections with remote management tools like Azure PowerShell, Azure CLI, Azure SDKs, REST APIs, are all encrypted.
- 24-hour threat management protects the infrastructure and platform  against malware, distributed denial-of-service (DDoS), man-in-the-middle (MITM), and other threats.

  **Service endpoints** allow you to restrict access from a virtual network or subnet and an app
- The first IP restriction rule has an explicit **Deny all** rule with a priority of 2147483647.
- Service-to-service authentication:
  - Service Identity / Managed Identity
  - On-behalf-of (OBO) – allows you to access a remote service using a delegated sign-in.#
- Supports SSL
  - App Service protocols: HTTPS, TLS 1.1/1.2 and FTPS
  - The default domain name is using HTTPs. You can also secure your custom domain using an SSL/TLS certificate.
  - Secure Sockets Layer (SSL) Certificates for custom domains is available on Basic, Standard and Premium service plans
  - Server Name Indication (SNI)
    - Supported by newer browsers
    - Free
  - IP Address SSL Connections
    - Supported by older browsers
    - £30 per month per certificate



## VNet Integration

- It allows your app to access resources in your virtual network.
  - Regional VNet Integration 
    - You need to have a dedicated subnet to the services that you integrate with
    - Block outbound traffic using network security groups
    - Route table allows you to send outbound traffic
  - Gateway-required VNet Integration
    - Allows access to resources in the target virtual network
    - **Sync network** allows you to sync certificates and network information
    - You can also **add routes** for outbound traffic
- Can purchase custom domains and attach them to Web Apps or VMs



## Hybrid Connections (HC)

- Access on-premises data or services
- Available in Azure  as a service as well as inside App Services
- Less features when used as part of Azure App Service
- As a service they are called Azure Relay Hybrid Connections
- Within App Service, Hybrid Connections can be used to access application resources in any network that can make outbound calls to Azure over port 443
- Provides access from your app to a TCP endpoint
- As used in App Service, each Hybrid Connection correlates to a single TCP host and port combination
- Hybrid Connections requires a relay agent to be deployed where it can reach both the desired endpoint as well as to Azure
- When your app makes a DNS request that matches a configured Hybrid  Connection endpoint, the outbound TCP traffic will be redirected through the Hybrid Connection
- The feature does not require an internet-accessible endpoint
- You cannot use UDP, LDAP, AD, dynamic ports such as FTP Passive Mode or Extended Passive Mode
- To create a HC in the Azure portal it is under Networking

![](https://docs.microsoft.com/en-us/azure/app-service/media/app-service-hybrid-connections/hybridconn-connectiondiagram.png)



## Pricing

- **Free** is a try for free plan
- **Shared** tier, each app receives a quota of CPU minutes, so *each app* is charged for the CPU quota.
- **Dedicated** are charged per VM
- **Isolated** are charged by the number of isolated workers and a flat fee for the App Service Environment
- You are charged on a per-second basis in the App Service plan.
- You are charged for the applications while they are in a stopped state.
- You are charged for data egress when using VNet Integration.
- You are charged for each listener in a Hybrid Connection
- You pay for the Azure compute resources you use



## Creating An ASP.NET Core Web App In Azure

- https://docs.microsoft.com/en-us/azure/app-service/quickstart-dotnetcore?pivots=platform-linux



## WebJobs

- Enables you to run a program or script in the same instance as a web  app, API app, or mobile app
- There is a WebJobs menu item under the AppService in the Azure Portal
- There is no additional cost to use WebJobs
- WebJobs is not yet supported for App Service on Linux.
- The Azure WebJobs SDK can be used with WebJobs to simplify many programming tasks
  - Has a declarative syntax similar to Azure Functions for event triggers
  - The SDK is not required to be used
- **Continuous WebJobs** 
  - Start immediately and runs continuously
  - Runs on all instances that the web app runs on though you can optionally restrict the WebJob to a single instance
  - Supports remote debugging
- **Triggered WebJobs**
  - Starts only when triggered or on a schedule
  - Runs on a single instance that Azure selects for load balancing
  - Does  not support remote debugging
  - Scheduled using a cron expression and the time zone is UTC though this can be changed by setting an app setting called WEBSITE_TIME_ZONE
- Supports a number of script or programs
  - cmd, bat, exe, ps1, ssh, php, py, js, jar



## Diagnostics and Logging

- If your app is down or performing slow, you can [collect a profiling trace](https://azure.github.io/AppService/2018/06/06/App-Service-Diagnostics-Profiling-an-ASP.NET-Web-App-on-Azure-App-Service.html) to id can be found in App Service / App Service Environment under
  - Looks like some crappy bot for Q&As and points you to common tit bits of information
  - Provides links through to graphs and charts
- If your app is down or performing slow, you can [collect a profiling trace](https://azure.github.io/AppService/2018/06/06/App-Service-Diagnostics-Profiling-an-ASP.NET-Web-App-on-Azure-App-Service.html)
- **Health checkup** is a good place to look to see overall information if you don't know what is wrong
  - There are four different graphs in the health checkup.
    - **requests and errors:** A graph that shows the number of requests made over the last 24 hours along with HTTP server errors
    - **app performance:** A graph that shows response time over the last 24 hours for various percentile groups
    - **CPU usage:** A graph that shows the overall percent CPU usage per instance over the last 24 hours
    - **memory usage:** A graph that shows the overall percent physical memory usage per instance over the last 24 hours
- **Quotas**
  - Apps that are hosted in App Service are subject to certain limits on the resources they can use. The limits are defined by the App Service plan  that's associated with the app.
  - If an app exceeds the *CPU (short)*, *CPU (Day)*, or *bandwidth* quota, the app is stopped until the quota resets. During this time, all incoming requests result in an HTTP 403 error
- Logs
  - Application logging
  - Web server logging
  - Detailed error messages
  - Failed request tracing
  - Deployment logging



### Log Types



| Type                    | Platform       | Location                                           | Description                                                  |
| ----------------------- | -------------- | -------------------------------------------------- | ------------------------------------------------------------ |
| Application logging     | Windows, Linux | App Service file system and/or Azure Storage blobs | Logs messages generated by your application code. The messages can  be generated by the web framework you choose, or from your application  code directly using the standard logging pattern of your language. Each  message is assigned one of the following categories: **Critical**, **Error**, **Warning**, **Info**, **Debug**, and **Trace**. You can select how verbose you want the logging to be by setting the severity level when you enable application logging. |
| Web server logging      | Windows        | App Service file system or Azure Storage blobs     | Raw HTTP request data in the [W3C extended log file format](https://docs.microsoft.com/en-us/windows/desktop/Http/w3c-logging). Each log message includes data such as the HTTP method, resource URI,  client IP, client port, user agent, response code, and so on. |
| Detailed Error Messages | Windows        | App Service file system                            | Copies of the *.htm* error pages that would have been sent to the client browser. For security reasons, detailed error pages  shouldn't be sent to clients in production, but App Service can save the error page each time an application error occurs that has HTTP code 400 or greater. The page may contain information that can help determine  why the server returns the error code. |
| Failed request tracing  | Windows        | App Service file system                            | Detailed tracing information on failed requests, including a trace  of the IIS components used to process the request and the time taken in  each component. It's useful if you want to improve site performance or  isolate a specific HTTP error. One folder is generated for each failed  request, which contains the XML log file, and the XSL stylesheet to view the log file with. |
| Deployment logging      | Windows, Linux | App Service file system                            | Logs for when you publish content to an app. Deployment logging  happens automatically and there are no configurable settings for  deployment logging. It helps you determine why a deployment failed. For  example, if you use a [custom deployment script](https://github.com/projectkudu/kudu/wiki/Custom-Deployment-Script), you might use deployment logging to determine why the script is failing. |



### Metrics

- Metrics for an app or an App Service plan can be hooked up to alerts

For an app, the available metrics are:

| Metric                                 | Description                                                  |
| -------------------------------------- | ------------------------------------------------------------ |
| **Response Time**                      | The time taken for the app to serve requests, in seconds.    |
| **Average Response Time (deprecated)** | The average time taken for the app to serve requests, in seconds. |
| **Average memory working set**         | The average amount of memory used by the app, in megabytes (MiB). |
| **Connections**                        | The number of bound sockets existing in the sandbox (w3wp.exe and  its child processes).  A bound socket is created by calling  bind()/connect() APIs and remains until said socket is closed with  CloseHandle()/closesocket(). |
| **CPU Time**                           | The amount of CPU consumed by the app, in seconds. For more information about this metric, see [CPU time vs CPU percentage](https://docs.microsoft.com/en-us/azure/app-service/web-sites-monitor#cpu-time-vs-cpu-percentage). |
| **Current Assemblies**                 | The current number of Assemblies loaded across all AppDomains in this application. |
| **Data In**                            | The amount of incoming bandwidth consumed by the app, in MiB. |
| **Data Out**                           | The amount of outgoing bandwidth consumed by the app, in MiB. |
| **File System Usage**                  | Percentage of filesystem quota consumed by the app.          |
| **Gen 0 Garbage Collections**          | The number of times the generation 0 objects are garbage collected  since the start of the app process. Higher generation GCs include all  lower generation GCs. |
| **Gen 1 Garbage Collections**          | The number of times the generation 1 objects are garbage collected  since the start of the app process. Higher generation GCs include all  lower generation GCs. |
| **Gen 2 Garbage Collections**          | The number of times the generation 2 objects are garbage collected since the start of the app process. |
| **Handle Count**                       | The total number of handles currently open by the app process. |
| **Health Check Status**                | The average health status across the application's instances in the App Service Plan. |
| **Http 2xx**                           | The count of requests resulting in an HTTP status code ≥ 200 but < 300. |
| **Http 3xx**                           | The count of requests resulting in an HTTP status code ≥ 300 but < 400. |
| **Http 401**                           | The count of requests resulting in HTTP 401 status code.     |
| **Http 403**                           | The count of requests resulting in HTTP 403 status code.     |
| **Http 404**                           | The count of requests resulting in HTTP 404 status code.     |
| **Http 406**                           | The count of requests resulting in HTTP 406 status code.     |
| **Http 4xx**                           | The count of requests resulting in an HTTP status code ≥ 400 but < 500. |
| **Http Server Errors**                 | The count of requests resulting in an HTTP status code ≥ 500 but < 600. |
| **IO Other Bytes Per Second**          | The rate at which the app process is issuing bytes to I/O operations that don't involve data, such as control operations. |
| **IO Other Operations Per Second**     | The rate at which the app process is issuing I/O operations that aren't read or write operations. |
| **IO Read Bytes Per Second**           | The rate at which the app process is reading bytes from I/O operations. |
| **IO Read Operations Per Second**      | The rate at which the app process is issuing read I/O operations. |
| **IO Write Bytes Per Second**          | The rate at which the app process is writing bytes to I/O operations. |
| **IO Write Operations Per Second**     | The rate at which the app process is issuing write I/O operations. |
| **Memory working set**                 | The current amount of memory used by the app, in MiB.        |
| **Private Bytes**                      | Private Bytes is the current size, in bytes, of memory that the app  process has allocated that can't be shared with other processes. |
| **Requests**                           | The total number of requests regardless of their resulting HTTP status code. |
| **Requests In Application Queue**      | The number of requests in the application request queue.     |
| **Thread Count**                       | The number of threads currently active in the app process.   |
| **Total App Domains**                  | The current number of AppDomains loaded in this application. |
| **Total App Domains Unloaded**         | The total number of AppDomains unloaded since the start of the application. |

- For an App Service plan, the available metrics are:
- Note App Service plan metrics are available only for plans in *Basic*, *Standard*, and *Premium* tiers.

| Metric                | Description                                                  |
| --------------------- | ------------------------------------------------------------ |
| **CPU Percentage**    | The average CPU used across all instances of the plan.       |
| **Memory Percentage** | The average memory used across all instances of the plan.    |
| **Data In**           | The average incoming bandwidth used across all instances of the plan. |
| **Data Out**          | The average outgoing bandwidth used across all instances of the plan. |
| **Disk Queue Length** | The average number of both read and write requests that were queued  on storage. A high disk queue length is an indication of an app that  might be slowing down because of excessive disk I/O. |
| **Http Queue Length** | The average number of HTTP requests that had to sit on the queue  before being fulfilled. A high or increasing HTTP Queue length is a  symptom of a plan under heavy load. |



## Sources
- https://docs.microsoft.com/en-us/azure/app-service/overview
- https://azure.microsoft.com/en-gb/pricing/details/app-service/windows
- https://docs.microsoft.com/en-us/azure/app-service/webjobs-create
- https://docs.microsoft.com/en-us/azure/app-service/overview-diagnostics