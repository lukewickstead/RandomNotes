
Important! Bucket names must be globally unique, regardless of the AWS region in which you create the bucket. Buckets must also be DNS-compliant

- Bucket names must be at least 3 and no more than 63 characters long.
- Bucket names can contain lowercase letters, numbers, periods, and/or hyphens. Each label must start and end with a lowercase letter or a number.
- Bucket names must not be formatted as an IP address (for example, 192.168.1.1).


Example S3 Bucket ARN:
>  arn:aws:s3:::calabs-bucket-11212166


The AWS S3 console allows you to create folders for grouping objects. This can be a very helpful organizational tool. However, in Amazon S3, buckets and objects are the primary resources. A folder simply becomes a prefix for object key names that are virtually archived into it. 


url has folder name in the path

https://calabs-bucket-11212166.s3-us-west-2.amazonaws.com/cloudfolder/cloudacademy-logo.png



All uploaded files are private by default and they can only be viewed, edited, or downloaded by you. 


Note: The terms "file" and "object" are often interchanged when discussing S3. Technically, S3 is an object store. S3 is not a block storage device and does not contain a file system like your local host does. 


Each object in Amazon S3 has a set of key/value pairs representing its metadata. There are two types of metadata: "System metadata" (for example, Content-Type and Content-Length) and custom "User metadata". User metadata is stored with the object and returned with it.