# Understanding S3 encryption mechanisms to secure your data

- https://cloudacademy.com/course/aws-big-data-security-encryption/introduction-43/?context_resource=lp&context_id=36
- https://cloudacademy.com/course/amazon-web-services-key-management-service-kms/kms-encryption-introduction/?context_id=41&context_resource=lp


## Overview 

 - Server-side encryption with S3 managed keys, SSE-S3. This option requires minimal configuration and all management of encryption keys used are managed by AWS. All you need to do is to upload your data and S3 will handle all other aspects
- Server-side encryption with KMS managed keys, SSE-KMS. This method allows S3 to use the key management service to generate your data encryption keys. KMS gives you a far greater flexibility of how your keys are managed. For example, you are able to disable, rotate, and apply access controls to the CMK, and order to against their usage using AWS Cloud Trail. 
- Server-side encryption with customer provided keys, SSE-C. This option gives you the opportunity to provide your own master key that you may already be using outside of AWS. Your customer-provided key would then be sent with your data to S3, where S3 would then perform the encryption for you. 
- Client-side encryption with KMS, CSE-KMS. Similarly to SSE-KMS, this also uses the key management service to generate your data encryption keys. However, this time KMS is called upon via the client not S3. The encryption then takes place client-side and the encrypted data is then sent to S3 to be stored. 
- Client-side encryption with customer provided keys, CSE-C. Using this mechanism, you are able to utilize your own provided keys and use an AWS-SDK client to encrypt your data before sending it to S3 for storage. 


## Server-Side Encryption with S3 Managed Keys (SSE-S3)

The encryption process is as follows. Firstly, a client uploads Object Data to S3. S3 then takes this Object Data and encrypts it with an S3 Plaintext Data Key. This creates an encrypted version of the Object Data, which is then saved and stored on S3. Next, the S3 Plaintext Data Key is encrypted with an S3 Master Key. Which creates an encrypted S3 Data Key. This encrypted Data Key is then also stored on S3 and the Plaintext Data Key is removed from memory. 

The decryption process is as follows. A request is made by the client to S3 to retrieve the Object Data. S3 takes the associated encrypted S3 Data Key off the Object Data and decrypts it with the S3 Master Key. The S3 Plaintext Data Key is then used to decrypt the object data. This object data is then sent back to the client.


## Server-Side Encryption with KMS Managed Keys (SSE-KMS)

The encryption process is as follows. Firstly, a client uploads object data to S3. S3 then requests data keys from a KMS-CMK. Using the specified CMK, KMS generates two data keys, a plain text data key and an encrypted version of the same data key. These two keys are then sent back to S3. S3 then combines the object data and the plain text data key to perform the encryption. This creates an encrypted version of the object data which is then stored on S3 along with the encrypted data key. The plain text data key is then removed from memory.

The decryption process is as follows. A request is made by the client to S3 to retrieve the object data. S3 sends the associated encrypted data key of the object data to KMS. KMS then uses the correct CMK with the encrypted data key to decrypt it and create a plain text data key. This plain text data key is then sent back to S3. The plain text data key is then combined with the encrypted object data to decrypt it. This decrypted object data is then sent back to the client.


## Server-Side Encryption with Customer Provided Keys (SSE-C)

The encryption process is as follows. Firstly, a client uploads Object Data and the Customer-provided Key to S3 for a HTTPS. It will only work with the HTTPS connection. Otherwise, S3 will reject it. S3 will then use the Customer-provided Key to encrypt the Object Data. S3 will also create a sorted HMAC value of the Customer-provided Key for future validation requests. The encrypted Object Data, along with the HMAC value of the Customer Key is then saved and stored on S3. The Customer-provided Key is then removed from memory.

The decryption process is as follows. A request is made by the client via HTTPS connection to S3 to retrieve the Object Data. At the same time, the Customer-provided Key is also sent with the request. S3 uses the HMAC value of the same key to confirm it's validity of the requested object. The Customer-provided Key is then used to decrypt the encrypted Object Data. The Object Data is then sent back to the client.


## Client-Side Encryption with KMS Managed Keys (CSE-KMS)

The encryption process is as follows. Using an AWS SDK, such as the Java client, a request is made to KMS for Data Keys that are generated from a specific CMK. This CMK is defined by providing the CMK-ID in the request. KMS will then generate two Data Keys from the specified CMK. One key will be a Plaintext Data Key. The second will be a Cipher blob of the same Data Key. Both keys are then sent back to the client. The client will then combine the Object Data with the Plaintext Data Key to create an encrypted version of the Object Data. The client then uploads both the encrypted Object Data and the Cipher blob version of the Data Key to S3. S3 will then store the encrypted Object Data and associate the Cipher blob Data Key as Metadata of the encrypted Object Data.

The decryption process is as follows. A request is made by the client to S3 to retrieve the Object Data. S3 sends both the encrypted Object Data and the Cipher blob back to the client. Using an AWS SDK, such as the Java client, the Cipher blob Data Key is sent to KMS. KMS combines the Cipher blob Data Key with the corresponding CMK to produce the Plaintext Data Key. This Plaintext Data Key is then sent back to the client and the Plaintext Data Key is then used to decrypt the encrypted Object Data.


## Client-Side Encryption with Customer Provided Keys (CSE-C)

he encryption process is as follows. Using an AWS SDK, such as the Java client, it will randomly generate a plain text data key which is used to encrypt the object data. The customer provided CMK is then used to encrypt this client-generated data key. The encrypted object data and encrypted data key are then sent to S3. S3 will then store the encrypted object data and associate the encrypted data key as metadata of the encrypted object data. The decryption process is as follows. A request is made by the client to S3 to retrieve the object data. S3 sends both the encrypted object data and the encrypted data key back to the client. The customer-provided CMK is then used to decrypt the encrypted data key. The plain text data key is then used to decrypt the object data. You should now have a deeper understanding of the process of encryption and decryption for each of the encryption methods that S3 offers. 

It is a simple process to apply encryption, but understanding what's happening behind the scenes, is essential from a security standpoint. Especially when you are responsible for maintaining the integrity of the data stored in S3. Many of us have seen and heard the news whereby large, international organizations have failed to apply either correct level of permissions, or, indeed, an encryption mechanism to customer data which has been accidentally exposed. Causing a detrimental effect to all organizations involved. 