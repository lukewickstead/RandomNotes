# Azure Application Gateway

[toc]

## Overview

- A web traffic load balancer.
- It allows you to distribute incoming traffic based on HTTP request properties such as URL and host headers.
- Application gateway has four tiers: **Standard**, **Standard V2**, **WAF**, and **WAF v2**
- You can use the same application gateway for up to 100+ websites with multi-site hosting.
- Set the minimum and maximum scale units based on your needs.
- Can perform SSL termination



## Features

- Secure your data with end-to-end SSL.
- Route traffic based on URL path or host header-based.
- Protect your applications from common web vulnerabilities using WAF.
- Scales automatically based on your web application traffic load.
- With gateway-managed cookies, you can direct subsequent traffic from a user session to the same server.



## Pricing

- You are charged per instance, per GB, and per gateway-hour.
- You are also charged with capacity units (*computed hourly or partial hourly*).



## Source

- https://docs.microsoft.com/en-us/azure/application-gateway/overview