# Amazon CloudFront service

- Acts as a Content Delivery Network (CDN)
- Distributes data requested through web traffics closer to the end user via edge locations
- As the data is cached, durability of your data is not possible
- Origin data can come rom Amazon S3


## Edge Locations

- AWS edge locations are sites deployed in major cities and highly populated areas across the globe
- Edge locations are not used to deploy infrastructure
- Edge locations allow the ability to cache data and reduce latency for end user access with services such as Amazon CloudFront


## Distributions

- Distributions are used to control which source data it needs to redistribute and to where
- Web distribution
  - Used to distribute both static and dynamic content
  - Uses both the HTTP and HTTPS protocol
  - Allows you to add, remove or update objects
  - Ability to provide live stream functionality on your website
  - Uses an origin to define where the source data is coming from
  - Origin can be a web server, EC2 instance or an Amazon S3 bucket 
- RTMP distribution
  - Should be used if your focus is to distribute streaming media using the Adobe Flash media service RTMP protocol
  - Allows users to start viewing the media before the complete file has been downloaded from the edge location
  - The source data can only exist within an S3 bucket


### Distribution Configuration

- You must specify your origin location
- Select specific caching behavioral options
- Define the distribution settings themselves (which edge locations you want your data to be distributed to)
  - US, Canada and Europe
  - US, Canada, Europe and Asia
  - All edge locations (best performance)

## CloudFront & WAF

- Associated to a Web Application Firewall (WAF)
- WAS provides additional security for your web application tier
- Encryption can be applied through SSL certificates


## High Level Process

- Once your distribution has configured, you simply enable the distribution for it to be created
- A user will be directed to their closest edge location in terms of latency
- If the content is missing or expired CloudFront will request the content from the source origin which will be used to maintain a fresh cache for any future request until it again expires.


## Pricing

- Cost for using the CloudFront is primarily based on data transfer costs and HTTP requests
- For detailed information on the pricing for different regions, it's best to visit the following pricing page.
  - https://aws.amazon.com/cloudfront/pricing
  - A pricing matrix for both data transfer and HTTP requests across different locations
- CloudFront also charges for other features 
  - Field-level encryption
  - Invalidation requests
    - 1st 1000 path request are free. $.005 per additional request
    - Invalidates cache before file expiration date, also known as TTL
- SSL
  - Lets you deliver content over HTTPS using your own domain name and your own SSL Certificate
  - There are no upfront or monthly fees for certificate management, outside the normal CloudFront rates for data transfer and HTTPS requests
  - SNI - Server Name Indication, a custom SSL which relies on the TLS protocol and allows multiple domains to serve SSL over the same IP address.
  - Dedicated IP custom SSL SSL $600 per month, for older browsers which do not support SNI
    - Prorated per hours assigned in that month
- Free Tier for New Users
  - 50 GB Data Transfer
  - 2 Million HTTP/HTTPS Requests


Choosing from price classes is an option that can lower the total price by limiting the edge locations

- Price Class All which is all edge locations
- Price Class 200 which is edge locations in the U.S., EU, Asia, and Japan
- Price Class 100 which is edge locations in the U.S. and EU only.

Reserved capacity pricing which requires you to commit to a minimum monthly usage level for at least 12 months. The agreements begin at a minimum of 10 terabytes of data transfer per month from a single region. There are significant discounts available if you will be a heavy user. To find out more about this, you will need to contact AWS.

## Reports

There is a wealth of information in this section that can be used to optimize the content that we deliver, and to understand the behavior of our users

There are five key reports:

- CloudFront Cache Statistics which displays information related to the edge locations for the last 60 days, with data points ranging from every hour to every day
- CloudFront Popular Objects, which lists the 50 most popular objects and statistics about these objects ranging from the number of requests, hits, and misses, and repeat downloads and requests by HTTPS status codes
- CloudFront Top Referrers Report, which lists the top 25 referrers including the number of requests from each referrer
- CloudFront Usage Reports provides information about the number of requests, data transferred by protocol, and by destination
- CloudFront Viewers Report provides information about the type of device users use to access your content, browser, operating system, and location


## Best Practices


### Atatic assets

Objects such as images, CSS, fonts, and even software that doesn't change frequently, and which can be distributed to more than one user

- Use Amazon S3 for static assets, as transferring data between S3 and CloudFront is free. It can decrease the load on your web server
- Control access to content on S3 by using Origin Access Identity, which means that content can only be accessed by CloudFront. This is beneficial as it prevents content leakage as S3 URLs are not being used
- Control access to content on CloudFront to private content, for example, paid subscribers, premium customers. You should use signed URLs or signed cookies
- Edge caching setting high TTLs, and do not forward headers, query strings, or cookies unless absolutely required are the default settings for CloudFront.
- Versioning will result in each object being treated as unique, and allows for easy updates and rollbacks as you use the file name or query string to version

### Dynamic content

Content that changes frequently. This could be unique to every request or unique content that changes frequently, but is not unique to every request, for example, weather updates or content that changes based on the end user request

- Cache everything. CloudFront does support TTL as low as zero seconds, and even no-cache, no-store. But most content can benefit from being cached, even for a few seconds since CloudFront supports If-Modified-Since and If-None-Match when the object in the cache has expired. To help you identify content that is dynamic and could benefit from caching, use the CloudFront Popular Objects Report.
- Use multiple cache behaviors and only forward required headers, avoid forwarding all cookies, and also avoid forwarding the User-Agent header, and instead use Is-Mobile-Viewer, Is-Tablet-Viewer, etc. to differentiate between device types.

### Streaming media

Streaming media is becoming more popular with live and on-demand streaming for video and audio, and with that it typically consists of the manifest file, media files, and the player

- Setting the right TTLs is important. Typically, you would set a low TTL for the manifest file, high TTL for media files and for the media player
- Use HTTP-based streaming protocols and distribute via web distributions to deliver multi-bitrate streaming using fragmented streaming formats, such as Smooth Streaming, which has native support in CloudFront

### Architectural considerations

No discussion on architectural considerations would be complete without talking about availability. The key principle here is design for failure. When we are looking at CloudFront, the key question to ask is, "What if the origin fails or fails to respond to CloudFront?" To help with this, you can take advantage of other AWS services, such as Route 53 which can conduct health checks, and then take the necessary action in the event of a failure being detected. You should also take advantage of CloudWatch for alarms and notifications.

We've mentioned the importance of caching everything before, but more caching equals higher availability, as when the origin server is unavailable CloudFront will automatically serve the stale object if it's in its cache for the duration of the error caching minimum TTL.

From a security perspective, you should enable end to end HTTPS. You can configure HTTP to HTTPS Redirect for each cache behavior. Additionally, you should take advantage of IAM users to control access to CloudFront, and use CloudTrail to record API calls history for security analysis, resource change tracking, and auditing purposes.