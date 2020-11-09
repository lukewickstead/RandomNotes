# AWS Global Infrastructure: Availability Zones, Regions, Edge Locations, Regional Edge Caches

The components are:
  Availability Zones (AZs)
  Regions
  Edge Locations
  Regional Edge Caches

Relevant links:
  - https://cloudacademy.com/library/amazon-web-services/
  - https://aws.amazon.com/message/4372T8/
  - https://aws.amazon.com/answers/networking/aws-multiple-region-multi-vpc-connectivity/
  - https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/
  - https://aws.amazon.com/govcloud-us/
  - https://cloudacademy.com/aws-ec2-instance-types-explained/
  - https://cloudacademy.com/amazon-web-services/cloudfront-course/
  - https://cloudacademy.com/amazon-web-services/labs/serve-your-files-using-cloudfront-cdn-15/
  - https://cloudacademy.com/amazon-web-services/labs/configuring-static-website-s3-and-cloudfront-65/
  - https://cloudacademy.com/lambda-edge-network-latency/


## AWS Global Infrastructure: Availability Zones

- Availability Zones and Regions are closely related
- AZs are essentially the physical data centers of AWS.
- Multiple data centers located close together form a single availability zone
- Each AZ will always have at least one other AZ that is geographically located within the same area, usually a city, 
linked by highly resilient and very low latency private fiber optic connections
- However, each AZ will be isolated from the others using separate power and network connectivity that minimizes impact to other AZs should a single AZ fail
- These low latency links between AZs are used by many AWS services to replicate data for high availability and 
resilience purposes
- When RDS (Relational Database Service) is configured for ‘Multi-AZ’ deployments, AWS will use synchronous replication between its primary and secondary database and asynchronous replication for any read replicas that have been created
- Often, there are three, four, or even five AZs linked together via these low latency connections
- This localized geographical grouping of multiple AZs, which would include multiple data centers, is defined as an AWS Region
- Multiple AZs within a region allows you to create highly available and resilient applications and services


## AWS Global Infrastructure: Regions

- A Region is a collection of availability zones that are geographically located close to one other
- AWS has deployed them across the globe to allow its worldwide 
- Every Region will act independently of the others, and  each will contain at least two Availability Zones
- Having global regions also allows for compliance with regulations, laws, and governance relating to data storage (at 
rest and in transit) 
- You may choose to architect your AWS environment to support your applications and services across multiple regions, should an entire region become unavailable, perhaps due to a natural disaster
- You may want to use multiple regions if you are a global organization serving customers in different countries that 
have specific laws and governance about the use of data
- Not all AWS services are available in every region. This is a consideration that must be taken into 
account when architecting your infrastructure
- Some services are classed as global services, such as AWS Identity & Access Management (IAM) or Amazon CloudFront, which means that these services are not tied to a specific region
The AWS GovCloud is an isolated region in the U.S. that is only available to U.S. government agencies and organizations in government regulated industries


## Region and Availability Zone Naming Conventions

- AWS has a specific naming convention for both Regions and Availability Zones.
- It can be represented as two different names for the same Region
- Regions have both a friendly name, indicating a location and a Code Name that is used when referencing regions programmatically
- AZs are always named by their code name
  - AZs Region Code Name
  - A letter
  - Eg: within eu_est_1 is eu-west-1a
- AWS maps these AZ letter identifiers to different physical AZs for different AWS accounts. This ensures that there is a more even distribution of resources across all AZs within a Region
- If you have multiple AWS accounts and you try to coordinate resources within the same AZ by selecting the same AZ 
Code Name, this may not necessarily mean that those resources are physically located within the same AZ


## AWS Global Infrastructure: Edge Locations

- Edge Locations are AWS sites deployed in major cities and highly populated areas across the globe
- They far outnumber the number of availability zones available
- While Edge Locations are not used to deploy your main infrastructures they are used by AWS services such as
Amazon CloudFront and AWS Lambda@Edge to cache data and reduce latency for end user access by using the Edge Locations as a global Content Delivery Network  (CDN)
- Edge Locations are primarily used by end users who are accessing and using your services


## AWS Global Infrastructure: Regional Edge Cache

- In November 2016, AWS announced a new type of Edge Location, called a Regional Edge Cache
- These sit between your CloudFront Origin servers and the Edge Locations. 
- A Regional Edge Cache has a larger cache width than each of the individual Edge Locations, and because data expires from the cache at the Edge Locations, the data is retained at the Regional Edge Caches
- Therefore, when data is requested at the Edge Location that is no longer available, the Edge Location can retrieve the cached data from the Regional Edge Cache instead of the Origin servers, which would have a higher latency
