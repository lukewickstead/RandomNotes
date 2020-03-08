
Create and list a buckets

``` batch
aws s3 mb s3://cloud-academy-lab-bucket
aws s3 ls
```

Get and copy the files Up to the bucket

```batch
wget https://github.com/cloudacademy/static-website-example/archive/master.zip
aws s3 cp index.html s3://cloud-academy-lab-bucket
```

The copy command is basically

> aws s3 cp <source> <destination>

To copy and list recursively

```batch
aws s3 cp . s3://cloud-academy-lab-bucket --recursive
aws s3 ls s3://cloud-academy-lab-bucket
aws s3 ls s3://cloud-academy-lab-bucket/assets/ --recursive
```

Set the permissions

``` batch
aws s3 website s3://cloud-academy-lab-bucket --index-document index.html --error-document error/index.html
```

You can navigate to the following

> http://cloud-academy-lab-bucket.s3-website-us-west-2.amazonaws.com

However the files are not permissioned for read. Upload the files again, overwriting the current copies, and set the access control list (ACL) to be public-read:

```batch
aws s3 cp . s3://cloud-academy-lab-bucket --recursive --acl public-read
```