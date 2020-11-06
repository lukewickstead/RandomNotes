# Azure Content Delivery Network

[toc]

## Overview

- A distributed network of servers that delivers web content closer to users.
- CDNs store cache content on **edge servers** to minimize end-user latency.

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F08%2Fazure-content-delivery-network.png)                            

## Azure CDN Products



| **Performance features and optimizations**                   | **Standard Microsoft**                                       | **Standard Akamai**                                          | **Standard Verizon**          | **Premium Verizon**                                          |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ----------------------------- | ------------------------------------------------------------ |
| [Dynamic site acceleration](https://docs.microsoft.com/en-us/azure/cdn/cdn-dynamic-site-acceleration) | Offered via [Azure Front Door Service](https://docs.microsoft.com/en-us/azure/frontdoor/front-door-overview) | **✓**                                                        | **✓**                         | **✓**                                                        |
| [Dynamic site acceleration - adaptive image compression](https://docs.microsoft.com/en-us/azure/cdn/cdn-dynamic-site-acceleration#adaptive-image-compression-azure-cdn-from-akamai-only) |                                                              | **✓**                                                        |                               |                                                              |
| [Dynamic site acceleration - object prefetch](https://docs.microsoft.com/en-us/azure/cdn/cdn-dynamic-site-acceleration#object-prefetch-azure-cdn-from-akamai-only) |                                                              | **✓**                                                        |                               |                                                              |
| [General web delivery optimization](https://docs.microsoft.com/en-us/azure/cdn/cdn-optimization-overview#general-web-delivery) | **✓**                                                        | **✓**, Select this optimization type if your average file size is smaller than 10 MB | **✓**                         | **✓**                                                        |
| [Video streaming optimization](https://docs.microsoft.com/en-us/azure/cdn/cdn-media-streaming-optimization) | via General Web Delivery                                     | **✓**                                                        | via General Web Delivery      | via General Web Delivery                                     |
| [Large file optimization](https://docs.microsoft.com/en-us/azure/cdn/cdn-large-file-optimization) | via General Web Delivery                                     | **✓**, Select this optimization type if your average file size is larger than 10 MB | via General Web Delivery      | via General Web Delivery                                     |
| Change optimization type                                     |                                                              | **✓**                                                        |                               |                                                              |
| Origin Port                                                  | All TCP ports                                                | [Allowed origin ports](https://docs.microsoft.com/en-us/previous-versions/azure/mt757337(v%3Dazure.100)#allowed-origin-ports) | All TCP ports                 | All TCP ports                                                |
| [Global server load balancing (GSLB)](https://docs.microsoft.com/en-us/azure/traffic-manager/traffic-manager-load-balancing-azure) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| [Fast purge](https://docs.microsoft.com/en-us/azure/cdn/cdn-purge-endpoint) | **✓**                                                        | **✓**, Purge all and Wildcard purge are not supported by Azure CDN from Akamai currently | **✓**                         | **✓**                                                        |
| [Asset pre-loading](https://docs.microsoft.com/en-us/azure/cdn/cdn-preload-endpoint) |                                                              |                                                              | **✓**                         | **✓**                                                        |
| Cache/header settings (using [caching rules](https://docs.microsoft.com/en-us/azure/cdn/cdn-caching-rules)) | **✓** using [Standard rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-standard-rules-engine) | **✓**                                                        | **✓**                         |                                                              |
| Customizable, rules based content delivery engine            | **✓** using [Standard rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-standard-rules-engine) |                                                              |                               | **✓** using [rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-verizon-premium-rules-engine) |
| Cache/header settings                                        | **✓** using [Standard rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-standard-rules-engine) |                                                              |                               | **✓** using [Premium rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-verizon-premium-rules-engine) |
| URL redirect/rewrite                                         | **✓** using [Standard rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-standard-rules-engine) |                                                              |                               | **✓** using [Premium rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-verizon-premium-rules-engine) |
| Mobile device rules                                          | **✓** using [Standard rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-standard-rules-engine) |                                                              |                               | **✓** using [Premium rules engine](https://docs.microsoft.com/en-us/azure/cdn/cdn-verizon-premium-rules-engine) |
| [Query string caching](https://docs.microsoft.com/en-us/azure/cdn/cdn-query-string) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| IPv4/IPv6 dual-stack                                         | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| [HTTP/2 support](https://docs.microsoft.com/en-us/azure/cdn/cdn-http2) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
|                                                              |                                                              |                                                              |                               |                                                              |
| **Security**                                                 | **Standard Microsoft**                                       | **Standard Akamai**                                          | **Standard Verizon**          | **Premium Verizon**                                          |
| HTTPS support with CDN endpoint                              | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| [Custom domain HTTPS](https://docs.microsoft.com/en-us/azure/cdn/cdn-custom-ssl) | **✓**                                                        | **✓**, Requires direct CNAME to enable                       | **✓**                         | **✓**                                                        |
| [Custom domain name support](https://docs.microsoft.com/en-us/azure/cdn/cdn-map-content-to-custom-domain) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| [Geo-filtering](https://docs.microsoft.com/en-us/azure/cdn/cdn-restrict-access-by-country) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| [Token authentication](https://docs.microsoft.com/en-us/azure/cdn/cdn-token-auth) |                                                              |                                                              |                               | **✓**                                                        |
| [DDOS protection](https://www.us-cert.gov/ncas/tips/ST04-015) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| [Bring your own certificate](https://docs.microsoft.com/en-us/azure/cdn/cdn-custom-ssl?tabs=option-2-enable-https-with-your-own-certificate#tlsssl-certificates) | **✓**                                                        |                                                              | **✓**                         | **✓**                                                        |
| Supported TLS Versions                                       | TLS 1.2, TLS 1.0/1.1 - [Configurable](https://docs.microsoft.com/en-us/rest/api/cdn/customdomains/enablecustomhttps#usermanagedhttpsparameters) | TLS 1.2                                                      | TLS 1.2                       | TLS 1.2                                                      |
|                                                              |                                                              |                                                              |                               |                                                              |
| **Analytics and reporting**                                  | **Standard Microsoft**                                       | **Standard Akamai**                                          | **Standard Verizon**          | **Premium Verizon**                                          |
| [Azure diagnostic logs](https://docs.microsoft.com/en-us/azure/cdn/cdn-azure-diagnostic-logs) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| [Core reports from Verizon](https://docs.microsoft.com/en-us/azure/cdn/cdn-analyze-usage-patterns) |                                                              |                                                              | **✓**                         | **✓**                                                        |
| [Custom reports from Verizon](https://docs.microsoft.com/en-us/azure/cdn/cdn-verizon-custom-reports) |                                                              |                                                              | **✓**                         | **✓**                                                        |
| [Advanced HTTP reports](https://docs.microsoft.com/en-us/azure/cdn/cdn-advanced-http-reports) |                                                              |                                                              |                               | **✓**                                                        |
| [Real-time stats](https://docs.microsoft.com/en-us/azure/cdn/cdn-real-time-stats) |                                                              |                                                              |                               | **✓**                                                        |
| [Edge node performance](https://docs.microsoft.com/en-us/azure/cdn/cdn-edge-performance) |                                                              |                                                              |                               | **✓**                                                        |
| [Real-time alerts](https://docs.microsoft.com/en-us/azure/cdn/cdn-real-time-alerts) |                                                              |                                                              |                               | **✓**                                                        |
|                                                              |                                                              |                                                              |                               |                                                              |
| **Ease of use**                                              | **Standard Microsoft**                                       | **Standard Akamai**                                          | **Standard Verizon**          | **Premium Verizon**                                          |
| Easy integration with Azure services, such as [Storage](https://docs.microsoft.com/en-us/azure/cdn/cdn-create-a-storage-account-with-cdn), [Web Apps](https://docs.microsoft.com/en-us/azure/cdn/cdn-add-to-web-app), and [Media Services](https://docs.microsoft.com/en-us/azure/media-services/previous/media-services-portal-manage-streaming-endpoints) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| Management via [REST API](https://docs.microsoft.com/en-us/rest/api/cdn/), [.NET](https://docs.microsoft.com/en-us/azure/cdn/cdn-app-dev-net), [Node.js](https://docs.microsoft.com/en-us/azure/cdn/cdn-app-dev-node), or [PowerShell](https://docs.microsoft.com/en-us/azure/cdn/cdn-manage-powershell) | **✓**                                                        | **✓**                                                        | **✓**                         | **✓**                                                        |
| [Compression MIME types](https://docs.microsoft.com/en-us/azure/cdn/cdn-improve-performance) | Default only                                                 | Configurable                                                 | Configurable                  | Configurable                                                 |
| Compression encodings                                        | gzip, brotli                                                 | gzip                                                         | gzip, deflate, bzip2, brotili | gzip, deflate, bzip2, brotili                                |





## Features

- Improves the performance of dynamic web pages using dynamic site acceleration.
- You can set two types of caching rules in Azure CDN:
  - Global caching rule – overrides any HTTP cache-directive headers.
  - Custom caching rule – you can set a rule to match specific paths and file extensions.
- Types of origin:
  - Storage
  - Storage Static website
  - Cloud service
  - Web App
  - Custom Origin
- Enable HTTPS to mitigate security threats on the content distribution network.
- Export basic usage metrics from your CDN by using diagnostic logs
- With geo-filtering, you can set rules for different paths to allow or block content in selected countries/regions.
- CDN endpoint: <*tutorialsdojo*>.azureedge.net



## How Caching Works

- Access the data quickly by storing the data in an origin server.
- If the file on the origin server has been updated, the cache must update its resource version.
- Azure CDN HTTP cache-directive headers:
  - Cache-Control – caching behavior of a browser.
  - Expires – a date based expiration time.
- Azure CDN HTTP cache validators:
  - ETag – a string that is unique to every file.
  - Last-Modified – the origin server compares the date with the last-modified resource header. 
    - Status code 200 = Modified
    - Status code 304 = Not Modified
- Default caching behavior:
  - Honor origin – honor the HTTP response cache-directive headers, if they exist.
  - CDN cache duration – how long a resource is cached on the Azure CDN.



## Pricing

- You are charged based on the number of rules.
- You are charged for outbound data transfers.



## Limits

- The limit for the following resources is 25:
  - CDN profiles
  - CDN endpoints per profile
  - Custom domains per endpoint



## Purging

- Purging clears the cached content on the CDN edge  servers
- Any downstream caches, such as proxy servers and local browser caches, may still hold a cached copy of the file
- Purging can be for an entire CDN distribution or by a content path which allows pattern matching



## Sources

-  https://docs.microsoft.com/en-us/azure/cdn/cdn-overview