# Azure Content Delivery Network

[toc]

## Overview

- A distributed network of servers that delivers web content closer to users.
- CDNs store cache content on **edge servers** to minimize end-user latency.

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F08%2Fazure-content-delivery-network.png)                            

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

## Sources

-  https://docs.microsoft.com/en-us/azure/cdn/cdn-overview