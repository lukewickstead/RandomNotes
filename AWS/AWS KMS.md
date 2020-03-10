# How to Use KMS Key Encryption to Protect Your Data

## What Is KMS?

- Data encryption is the mechanism in which information is altered, rendering the plain text data unreadable through the use of mathematical algorithms and encryption keys. When encrypted, the original plain text is now known as cipher text which is unreadable
- To decrypt the data, an encryption key is required to revert the cipher text back into a readable format of plain text
- A key is simply a string of characters used in conjunction with the encryption algorithm and the longer the key the more robust the encryption
- This encryption involving keys can be categorized by either being symmetric cryptography or asymmetric cryptography. 
- AWS KMS only uses symmetric cryptography


### Symmetric encryption

- A single key is used to both encrypt and also decrypt the data
- This key must be sent securely between the two parties and here it exposes a weakness in this method
- If the key is intercepted by anyone during that transmission, then that third party could easily decrypt any data associated with that key. 
- AWS KMS resolves this issue by acting as a central repository, governing and storing the keys required and only issues the decryption keys to those who have sufficient permissions to do so
- Some common symmetric cryptography algorithms that are used
  - AES which is Advanced Encryption Standard
  - DES, Digital Encryption Standard
  - Triple DES
  - Blowfish


### Asymmetric Encryption

- This involves two separate keys
- One is used to encrypt the data and a separate key is used to decrypt the data
- These keys are created both at the same time and are linked through a mathematical algorithm
- One key is considered the private key and should be kept by a single party and should never be shared with anyone else
- The other key is considered the public key and this key can be given and shared with anyone
- Unlike with the symmetric encryption, this public key does not have to be sent over secure transmission
- It doesn't matter who has access to this public key as without the private key, any data encrypted with it cannot be accessed
- Both the private and public key is required to decrypt the data when asymmetric encryption is being used
- The message is encryped usining the public key and decrypted using the private key
- This allows you to send encrypted data to anyone without the risk of exposing your private key
- Asymetric is a lot slower from a performance perspective
- Some common examples of asymmetric cryptography algorithms are
  - RSA
  - Diffie-Hellman
  - Digital Signature Algorithm


### Key Management Service (KMS)

- KMS is a managed service used to store and generate encryption keys that are used by other AWS services and applications
- S3 may use the KMS service to enable S3 to offer and perform server-side encryption using KMS generated keys known as SSE-KMS
- Administrators at AWS do not have access to your keys within KMS and they cannot recover your keys for you should you delete them
- All administrative actions performed by Amazon on the underlying system require dual authentication by two Amazon administrators
- It's our responsibility to adminisiter our own encryption
- KMS service is for encryption at rest
- To encrypt data while in transit, then you would need to use a different method such as SSL
- However, if your data was encrypted at rest using KMS, then when it was sent from one source to another, that data would be a cipher text which could only be converted to plain text with the corresponding key

- Server Side Encryption
  - Encryption is done by the server
  - Back end servers that encrypt the data as it arrives transparent to the end user
  - The overhead of performing the encryption and managing the keys is handled by the server
- Client Side Encryption
  - Encryption is done by the user
  - Requires the user to interact with the data to make the data encrypted
  - The overhead of encryption process is on the client rather than the server


### Compliance and regulations

- KMS works seamlessly with AWS CloudTrail to audit and track how your encryption keys are being used and by whom
- The CloudTrail logs that are stored in S3 record KMS API calls such as Decrypt, Encrypt, GenerateDataKey and GetKeyPolicy among others


### Regions

 - AWS KMS is not a multi-region service like IAM is for example. It is region specific
 - You need to establish a Key Management Service in each region that you want to encrypt data


## Components of KMS

### Customer Master Keys (CMK)

- The main key type wtihin KMS
- This key can encrypt data up to 4KB in size
- It is typically used in relation to your DEKs (Data Encryption Keys)
- The CMK can generate, encrypt and decrypt these DEK which are then used outside of the KMS service by other AWS services to perform encryption against your data
- There are two types of customer master keys
  - AWS managed CMKS
    - These are used by other AWS services that interact with KMS to encrypt data
    - They can only be used by the corresponding AWS service that created them within a particular region (AWS KMS is a regional service)
    - These are created on the first time you implement encryption using that service
  - Customer Managed CMKS
    - These provide the ability to implement greater flexibility
    - You can perform rotation, governing access and key policy configuration
    - You are able to both enable and disable the key when it is no longer required
    - AWS services can also be configured to use your own cuswtomer CMKs
    - Any CMKs created within KMS are protected by FIP 140-2 validated cryptographic modules


### Data Encryption Keys (DEK)

- Data encryption keys, or data keys, are created by the CMK and are used to encrypt your data of any size
- When a request to generate a key is issued, the CMK specified in the request will create a plain text data encryption key and an encrypted version of the same data encryption key
- Both of these keys are then used to complete the encryption process
- As a part of this process, your plain text data is encrypted with the plain text data key using an encryption algorithm
- Once encrypted, the plain text data is deleted from memory and the encrypted data key is stored alongside the encrypted data
- If anyone gains access to the encrypted data, they will not be able to decrypt it, even if they have access to the encrypted key, as this key was encrypted by the CMK, which remains within the KMS service
- This process of having one key encrypted by another key is known as envelope encryption
- The only way you would be able to decrypt the object is if you have the relevant decrypt permission for that CMK that the data keys are associated to


### Key Policies

- The key policy is a security feature within KMS that allows you to define who can use and access a particular key within KMS
  - These policies are tied to the CMKs, making these resource-based policies
  - Different key policies can be created for different CMKs
  - These permissions are defined within this key policy document, which is JSON-based


### Grants

- Grants are another method of controlling access and use of the CMKs held within KMS
- Again, they are a resource-based policy
- They allow you to delegate a subset of your own access to a CMK for principals
- There is less risk of someone altering the access control permissions for that CMK
- If anyone has the KMS put key policy permission, then they could simply replace the key policy with a different one. Using grants eliminates this possibility, as a grant is created and applied to the CMK for each principle requiring access


## Understanding Permisisons & Key Policies

### Permissions & Key Policies

- With many services that you use within AWS, you can control access using IAM policies whether that is against a user, group, role or even a federated user
- The point is access control for most services can be completely controlled and governed by using IAM alone
- To manage access to your CMKs, you must use a key policy associated to your CMK
  - Using Key Policies
  - Using Key Policies With IAM
  - Using Key Policies With Grants

### Using Key Policies

- Key policies are resource based policies which are tied to your CMK
- The key policy document itself is JSON based much like IAM policies ar
- They contain elements such as resource, action, effect, principal and optionally conditions
- KMS will create a default key policy for you to allow principals to use the CMK in question
- A key policy is required for all CMKS!!!!
- KMS will configure the root of the AWS account full access to the CMK, by doing so ensures that the CMK will never become unusable as it's not possible to delete the root account
- If full access of the CMK was given to another user and then that user was deleted from IAM, it would not be possible to manage the CMK unless you contacted AWS support to regain the control required
- When the root account has full access to the key policy, access to the CMK can be given by normal IAM policies for users and roles
  - Without the root account having full access in the key policy, IAM can't be used to manage access for other users
- The resource section shows an asterisk which essentially means this CMK that the key policy is being applied to
- When you create your CMK through the Management Console, then you have the chance to configure different permission sets
  - Define key administrators
  - Principals can only administer the CMK and not use it to perform any encryption function
  - You can also specify if you would like them to be able to delete the key
  - These key administrators have access to update the associated key policy
  - Define the CMK users
  - Which users should be allowed to perform any encryption using this CMK
  - User can also use Grants to delegate a subset of their own permissions to another principal, such as a service intergrated with KMS or another user
  - You may restrict access to CMKs in via the Effect element: Allow/Deny
  - Instead of using the Effect Allow, you can instead restrict and deny a particular user access to a CMK by specifying the Effect as deny


### Using Key Policies with IAM Policies

You We can also use key policies in conjunction with IAM policies, but only if you have the following entry within the key policy allowing the root full KMS access to the CMK, by doing so enables you to centralize your permissions administration from within IAM as you would likely be doing for many other AWS services. This would mean you can configure your IAM policies to allow users, groups and roles to perform the encryption and decryption process, for example using the KMS Encrypt and KMS Decrypt permissions. 

Using the resource component within the policy, you can also specify which CMKs the user, group or role can use to perform the encryption and decryption process. In this example, we can see that the policy will allow the identity associated with the policy to use two different CMKs to encrypt and decrypt data. The first CMK is within the US-East-1 region and the second CMK is within the EU-West-2 region. 


### Using Key Policies With Grants

- They allow you to delegate your permissons to another AWS principal within your AWS account
- Grants are another resource based method of access control to the CMKs
- The grants themselves need to be created using the AWS KMS APIs. It's not possible to create them using the AWS Management Console and these grants are then attached to the CMK
- Within the key policy of the CMK, you will see the Sid which allows the users of the CMK to also perform three grant actions, kms:CreateGrant, kms:ListGrants and kms:RevokeGrant
- Different parameters are also issued such as the CMK identifier, the grantee principal to gain the permissions and the required level of operations
- Also, after the grant has been created, a GrantToken and a GrantID is issued
- When a grant is created, there may be a delay in being able to use the permissions and this is due to the fact that eventual consistency has to take place


## Key Management

### Rotation of CMKS

- The longer the same key is left in place, the more data is encrypted with that key, and if that key is breached then a wider blast area of data is at risk
- Automatic key rotation
  - KMS will rotate your keys ever 365 days
  - The only change is the backing key of the CMK
  - Older backing keys are retained to decrypt data that was encrypted prior to this rotation
  - If a breach of a the CMK occur, raotating they key would not remove the threat of decrypting data encrypted with the breached keys
  - There are some points to bear in mind
    - Automatic key rotation is not possible with imported key material
    - The key rotation happens every 365 days and there is no way to alter that time frame
    - If either of the above two points is an issue then the only solution is to perform a manual key rotation
    - If your CMK is in the state of disabled or is pending deletation, then KMS will not perform a key rotation until the CMK is re-enabled or the deletion is cancelled
    - It is not possible to managed they key roation for any AWs managed CMKS, these are rotatged every 1095 days (3 yeara)
- Manual Key Rotation
  - The process of manual key rotation required a new CMK to be created
  - A ne wCMK-ID is created along with a new backing key
  - You will need to update any applications to reference the new CMK-ID
  - You could use Alias names for your keys and then simply update your alias target to point to the new CMK-ID
  - Keep any CMKs that were used to encrypt data before the rotation

### Importing Key Material

- Key material is essentially the backing key
- When customer managed CMKs are generated and created within the KMS the key material is automatically created for the CMK
- To create a CMK without any key material select External for Key Material Origin when creating a key
- When using your own key material it becomes tied to that CMK and no other key material can be used for that CMK
- https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys-encrypt-key-material.html

1. Create your CMK with no key material generated by KMS (Key Material Origin: External)
2. Dowload a wrapping key (public key) and an import token
   1. AWS KMS provides a means of encrypting it with this public/wrapping key
   2. The import token is used when uploading your encrypted material
   3. Both the wrapping/public key and the import token is onyl active for 24 hours
3. Encrypt your key material
   1. They Key material mus be in a binary format to allow you you use the wrapping key
4. Import your key material that is now encrypted into KMS and then associate it with your currently empty CMK
   1. Select your CMK
   2. Select to import the key material along with the location of the import token
   3. (Optional) Set an expiration of the key material being imported

- There are some considerations of using your own key material
  - The key material created by KMS for customer CMKs have have higher durability and availability
  - You can set an expiration time for your own imported material
  - In a region wide failure, you must have the key material to import back into the CMK


### Deleting CMK

- You may want to dleete your CMK for security best practices and general houstekeeping of your key infrastructure
- KMS enforces a scheuled deletion process, which can range from 7 - 30 days
- The CMK is taken out of action and put into a state of 'Pending deletion'
- Keys in this state can't be used to perform encryption or decryption actions, neither can the backing keys be roated
- To detected when a key was last used
  - You can analyse AWS CloudTrail events logs to look for the last time events on your CMK occured
    - https://docs.aws.amazon.com/kms/latest/developerguide/ct-encrypt.html
  - AWS recommned that you set up a Cloudwatch alarm to identify if anyone tries to use this key to perform an encryption/decryption request
    - https://docs.aws.amazon.com/kms/latest/developerguide/deleting-keys-creating-cloudwatch-alarm.html
- If you are not confident that your CMK is no longer in use or that it sh9uld be deleted then you can simply disable the CMK
- If you are using a CMK which has your own key material imported then you can delete just the key material from the CMK