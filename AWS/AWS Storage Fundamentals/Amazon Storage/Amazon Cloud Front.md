# Amazon CloudFront service

- Acts as a Content Delivert Network (CDN)
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
- Definie the distribution settings themselves (which edge locations you want your data to be distributed to)
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
  - Dedicated IP custom SSL

