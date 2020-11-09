# AWS Snowball 

- Used to securely transfer large amounts of data in and out of AWS (Petabyte scale)
-  Either from your on-premise data center to Amazon S3 or from Amazon S3 back to your data center using a physical appliance, known as a snowball
- The snowball appliance comes as either a 50 terabyte or 80 terabyte storage device, depending on your region
  - Currently the 50 terabyte version is only available within the US regions
- The appliance is dust, water, and tamper resistant and can even withstand an eight and a half G jolt from within its own external shipping container
- The snowball appliance has been designed to allow for high-speed data
  - The following I/O 10 gigabit interfaces are available
    - RJ45 using CAT6
    - SFP Copper
    - SFP Optical


## Encryption And Tracking

- By default, all data transferred to a snowball appliance is automatically encrypted using 256-bit encryption keys generated from KMS, the Key Management Service
- Features end to end tracking using an E-Ink shipping label; ensures it is sent to the right AWS facility
- Can also be tracked using the AWS Simple Notification Service with text messages or via the AWS Management Console
- HIPAA compliant allowing you to transfer protected health information in and out of S3
- Data removal from the appliance is the responsability of AWS, conformin to NIST (National Institute of Standard and Technology)


## Data Aggregation

- When sending or retrieving data, snowball appliances can be aggregated together
- For example, if you needed to retrieve 400 terabytes of data from S3 then your data will be sent by five 80 terabyte snowball appliances
- As a general rule, if your data retrieval will take longer than a week using your existing connection method, then you should consider using AWS Snowball
- Your global location will effect specific shipping times
  - https://docs.aws.amazon.com/snowball/latest/ug/mailing-storage.html


## AWS Snowball Process

- Create an export job from within the AWS Management Console
  - Within this job you can dictate shipping details, the S3 bucket, and the data to exported security mechanisms such as the KMS key for data encryption and also notifications
- You will then receive delivery of your snowball appliance.
- You can now connect the appliance to your local corporate network
  - Firstly, use the ports to connect the appliance to your network whilst it's powered off.
  - Next power on the device 
  - The E Ink display will let you know that it's ready
- You can then configure the network settings of the device, such as the IP address, to enable communications.
- From here you are now ready to start transferring the data.
- To do this you must first gain specific access credential via a manifest file through the management console, which has to be downloaded
- You must then install the snowball Client software and you can now begin transferring data using the client software once authenticated with the manifest file
- When the data transfer is complete, you can disconnect the snowball appliance
- The appliance must then be returned to AWS using specified shipping carriers
- It's important to note that all snowball appliances are the property of AWS and the E Ink label will display the return address


## Pricing

- Data transferred into AWS does not incur a data transfer charge
- However, you are charged for the normal Amazon S3 data charges
- For each data transfer job, there is a charge in additional to shipping costs associated to the job
- For the 50 terabyte snowball, there is a $200 charge
- Dor the 80 terabyte, it's $250 unless it's in the Singapore region which will then be $320
- You are allowed the snowball for 10 days in total; any delays requiring additional days incur further charges between $15 to $20, depending on the region
- The data transfer charges out of Amazon S3 to different regions is priced differently as follows
- The shipping will vary depending on your chosen carrier
- https://aws.amazon.com/snowball/pricing
