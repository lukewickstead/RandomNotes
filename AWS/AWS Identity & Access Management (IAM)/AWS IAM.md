# AWS IAM


## What Is Identify & Access Management

- So essentially IAM can be defined by its ability to manage, control and govern authentication, authorization and access control mechanisms of identities to your resources within your AWS account.


### Identity Management

Identities such as AWS usernames are required to authenticate to your AWS account
Authentication is the process of presenting an identity, in this case, a username, and providing verification of the identity such as entering the correct password associated


### Access Management

- Relates to authorization and access control.
- Authorization determines what an identity can access within your AWS account once it's been authenticated to it


### IAM Components

- AWS IAM service is used to centrally manage and control security permissions for any identity requiring access to your AWS account and its resources
- This is achieved by using different features within IAM consisting of:
  - Users: These are objects within IAM identifying different users
  - Groups: These are objects that contain multiple users
  - Roles: These are objects that different identities can adopt to assume a new set of permissions
  - Policy Permissions: These are JSON policies that define what resources can and can't be accessed
  - Access Control Mechanisms: These are mechanisms that govern how a resource is accessed
- IAM is a global service, meaning that you do not have to create different users or groups within each AWS region that you have resources
- IAM is the first service a user will interact with when using AWS, the reason being the identity needs to be authenticated by IAM before accessing any AWS resource
- The responsibility of implementing secure, robust and tight security within your AWS account using IAM is yours
- The initial dashboard of the IAM console will display information relating to the IAM
  - Sign-in link and this is a URL link that you can send to users who will need to gain access to your AWS management console
  - IAM Resources. This section provides an overview of your IAM resources using a simple count of the number of users, groups, roles, customer manage policies and identity providers you have configured within IAM
  - Security Status. This is populated with five best practices from a security perspective that AWS IAM recommends you configure when using IAM which may include activate MFA on your root account, create individual IAM users, use groups to assign permissions, apply an IAM password policy and rotate your access keys


## Users, Groups & Roles


### Users

- Users are objects created to represent an identity
  - This could be a real person within your organization who requires access to operate and maintain your AWS environment
  - Or it could be an account to be used by an application that may require permissions to access your AWS resources programmatically
- Users are simply objects representing an identity which are used in the authentication process to your AWS account.
- User can be created by:
  -  AWS Management Console
  -  Programmatically via the AWS CLI
     -  Tools for Windows Powershell
     -  IAM HTTP API
- User name, which can be up to 64 characters
- AWS Access Type
  - AWS Management Console Access
    - Requires user name and password
  - Programmatic access
    - Requires an access Key ID and secret access Key ID for the SDK
- Permissions assignment
  - Add user to group
  - Copy permissions from existing user
  - Attach existing policies directly
- After creation you can download the security credentials within a CSV file
  - User name
  - Keys required for programmatic access
  - Console login link
  - Details can also be emailed to the new user, using the send email link


#### Access Keys

- These access keys are comprised of two elements
  - An access key ID
    - Made up of 20 random uppercase alphanumeric characters
  - A secret access key ID
    - Made up of 40 random upper and lowercase alphanumeric and non-alphanumeric characters
    - Will only be displayed once
    - Can not be retrieved
- These access keys must then be applied and associated your application that you are using
- If you are using the AWS CLI to access AWS resources, you would first have to instruct the AWS CLI to use these access keys
- This association ensures that all API requests are signed with this digital signature
- From the user summary page
  - User ARN, which is the Amazon Resource Name, which is a unique identifier of the object
  - Permissions or any attached policies that are associated with the user
  - Any group memberships that the user belongs to
  - Details of the security credentials of the user
    - Manage the current password
    - Manage Multi Factor Authentication
    - Manage any signing certificates
      - Used for secure access to certain AWS product interfaces
    - Create new access keys for programmatic access
      - Good practice to rotate and change your access keys periodically
    - Upload SSH public keys for AWS CodeCommit
    - Generate HTTPS Git credentials for AWS CodeCommit
  - Access advisor
    - List of services that the user has permissions
    - Last access time for those services were
  - Though permissions can be assigned to a user it is best practice to assign permissions to user groups


### Groups

- IAM Groups are objects much like user objects
- They are not used in any authentication process
- They are used to authorize access to AWS resources, through the use of AWS Policies
- IAM Groups contain IAM Users
- Will have IAM Policies associated that will allow or explicitly deny access to AWS resources
- These policies are either
  - AWS managed policies, that can be selected from within IAM
  - Customer managed policies
- Groups are normally created, that relate to a specific requirement or job role
- Any users that are a member of that group inherit the permissions applied to the group
- By applying permissions to the group instead of individual users, it makes it easy to modify permissions for multiple users at once
- From a limitation perspective, your AWS account has a default maximum limit of a hundred groups
- To increase this, you'll need to contact AWS using the appropriate limit increase forms
- A user can only be associated to 10 groups


### IAM Roles

- IAM Roles allow you to adopt a set of temporary IAM permissions
- Assignment can be made during the EC2 instant creation by selecting the role to be associated
- Or once the EC2 instance is up and running, a role could also be applied
- Advantages of roles
  - IAM roles themselves do not have any access keys or credentials associated to them
  - Changes to roles is quicker than managing all ec2 etc instances credentials


## Roles & Users

- There may be circumstances where you'll need to grant temporary access to AWS resources for a particular user
- Allow the user to assume a role, temporarily replacing their existing permissions.
- There are currently four different types of roles that can be created
  - AWS Service Role
    - This role would be used by other services that would assume the role to perform specific functions based on a set of permissions associated with it
    - . Some examples of AWS Service Role would be Amazon EC2, AWS Directory Services, and AWS Lambda
    - Once you have selected your service role, you would then need to attach a policy with the required permissions, and set a role name to complete its creation
  - AWS Service-Linked Role
    - These are very specific roles that are associated to certain AWS services
    - They are pre-defined by AWS, and the permissions can't be altered in any way, as they are set to perform a specific function
    - Examples of these AWS Service-Linked Roles are Amazon Lex-Bots, and Amazon Lex-Channels
    - Once you have selected your service-linked role, you simply need to assign it a name and complete the creation. Remember, these roles do not allow you to modify the permissions assigned.
  - Cross-Account Access
    - This role type offers two options
      - Providing access between AWS accounts that you own
      - Providing access between an account that you own and a third party AWS account
    - This access is managed by policies that establish trusting and trusted accounts that explicitly allow a trusted principal to access specific resources
    - Many services use roles to allow cross-account access to resources
    - At a high level, these roles are configured as follows
      - The trusting account is the account that has the resources that need to be accessed
      - The trusted account contains the users that need to access the resources in the trusting account
        1. A role is created in the trusting account
        2. A trust is then established with the role by entering the AWS account number of the trusted account
        3. Permissions are then applied to the role via policies
        4. The users in the Trusted account then need to have permissions to allow them to assume the role in the trusting account
        5. These group of users would have a policy attached to the group; the resource field would have the trusting account id
  - Identity Provider Access
    - Grant access to web identity providers
      - Creates a trust for users using Amazon Cognito, Amazon, Facebook, Google, or any other open ID connect provider
    - Grant web single sign on to SAML providers
      - Allows access for users coming from a Security Assertion Markup Language (SAML) provider
    - Grant API access to SAML providers
      - Allows access via the AWS CLI, SDKs, or API calls


## IAM Policies

- IAM policies are used to assign permissions to users, groups, and roles
- IAM policies are formatted as JSON documents
  - Version specifies the policy language version (eg: 2012-10-17)
  - Statement is the main element of the policy which includes (Is an Array)
    - Sid
      - Unique identifier within the Statement array
      - As you add more permissions, you will have multiple Sids within the Statement
    - Action
      - This is the action that will either be allowed
      - Effectively API calls for different services
      - Different Actions are used for each service
      - Prefixed with the associated AWS service eg cloudtrail
    - Effect
      - Allow or Deny
      - Denied by default
    - Resource
      - This element specifies the actual resource you wish the "Action" and "Effect" to be applied to
      - AWS uses ARNs to specify resources following the syntax of
        - Partition that the resource is found in. For standard AWS regions, this section would be AWS.
        - Service for example, s3 or ec2.
        - Region that the resource is located
          - Some services do not need the region specified, so this can sometimes be left blank
        - Account-id; your AWS account-id, without hyphens
          - Some services do not need this information, and so it can be left blank
        - Resource specifies the actual resource you wish the Action and Effect to be applied to
          - With an action of "s3:PutObject" this would look like
            - arn:aws:s3:::iam-course-ca
    - Condition is an option element that allows you to control when the permissions will be effective based upon set criteria
      - key-value pair
      - All elements of the condition must be met for the permissions to be effective
      - IpAddress: { aws:SourceId: 10.10.0.0/16 }

## IAM Policy Typre

### Managed Policies
- These managed IAM policies can be associated with a Group, Role, or User 
- AWS Managed Policies
  - Pre-configured by AWS and made available to you to help with some of the most common permissions that you may wish to assign
  - The great thing about these AWS Managed policies is that you are able to edit them and make tweaks and changes before saving it as a new policy
  - This then becomes a Customer Managed policy
- Customer Managed Policies
  - Configured by you
  - Copy an AWS Managed policy and edit as required#
  - The Policy Generator allows you to create a Customer Managed policy by selecting options from a series of dropdown boxes
  - Create your own policy


### Inline Policies

- Whereas a Managed Policy could be attached to multiple users, groups, and roles, Inline Policies cannot
- An Inline Policy is directly embedded into a specific User, Group, or Role, and as a result, it is not available to be used by multiple identities
- To add an Inline policy for within the AWS Management Console, you must select the User, Group, or Role, select the "Permissions" tab, and click on "Click Here" to add an Inline policy
-  You will then be given two options in creating your Inline policy: one, using the Policy Generator, or two, writing your own custom policy
-  When the policy is being created, it is then associated to your IAM object
-  As a result, Inline policies do not show up under the Policies list with IAM, as they are not publicly available for other Users, Groups, or Roles to use with your account like Managed Policies are
-  Inline policies are typically used when you don't want to run the risk of the permissions being used in the policy for any other identity
-  When the User, Group, or Role is deleted, Inline policy is also deleted, as this is the only place where the policy exists


### Conflicting permissions

- By default, all access to a resource is denied
- Access will only be allowed if an explicit "Allow" has been specified
- A single "Deny" will override any previous "Allow" that may exist for the same resource and action


## Multi-Factor Authentication (MFA)

- MFA uses a random six digit number that is only available for a very short period of time before the number changes again
- Is generated by an MFA device
- There is no additional charge for this level of authentication
- You will need your own MFA device, which can be a physical token or a virtual device.
- The MFA device must be configured and associated to the user
- This configuration can be done from within IAM dashboard


## Identity Federation

- Identity federation allows you to access and manage AWS resources even if you don't have an account within IAM
  - Identity provider allow users to access AWS resource securely
  - Other forms of IdP can be any OpenId Connect web providers
  - Benefits of using identity providers
    - It minimizes the amount of administration within IAM
    - It allows for a Single Sign-On (SSO) solution
    - As the vast majority of organizations today are using Microsoft Active Directory, using MS-AD is an effective way of granting access to your AWS resources without going through the additional burden of creating potentially hundreds of IAM user accounts.
- There must be a trust relationship between the identity provider and your AWS account
  - AWS supports two types of identity providers
    - OpenID Connect, also often referred to as web identity federation
      - Allows authentication between AWS resources and any public OpenID Connect provider such as Facebook, Google or Amazon
      - When an access request is made, the user IdP credentials will be used to exchange an authentication token for temporary authentication credentials
    - SAML 2
      - Allows your existing MS-AD users to authenticate to your AWS resources on a SSO approach
      - SAML lets the exchange f security data, including authentication and authorization tokens to take place between IdP and a service provider


### Active Directory Authentication

- A user within an organization requires API access to S3, EC2 and RDS
- STS allows you to gain temporary security credentials for federated users via IAM

1. The user initiates a request to authenticate against the Active Directory Federated Service, ADFS Server, via a web browser using a single sign-on URL.
2. If their authentication is successful by using their Active Directory credentials, SAML will then issue a successful authentication assertion back to the user's client requesting federated access.
3. The SAML assertion is then sent to the AWS Security Token Service to assume a role within IAM using the AssumeRoleWithSAML API
4. STS responds to the user requesting federated access with temporary security credentials with an assumed role and associated permissions
5. The user then has federated access to the necessary AWS services as per the role permissions

### Creating An Identity Provider

- To use federation within IAM, you must first create an identity provider which is a simple process providing you have the correct information from your chosen identity provider first
- For OIDC providers you will need
  - Client ID, also known as an audience, that you receive once you register your application with your identity provider. This ID is usually a unique identifier
  - A thumbprint to verify the certificate of your identity provider
- For SAML providers
  - A SAML Metadata document that you get by using the identity management software from your identity provider
  - This document includes information such as the issuer's name, expiration data and security keys


#### Creating an OIDC IUdentify Provider

1. From within the IAM console select identity providers
2. Next click on create provider
3. Then select OpenID Connect
4. Enter the URL of the identity provider
5. Enter the client ID, known as the audience, of your application that will communicate with AWS discussed earlier
6. Supply the thumbprint for service certificate verification.
7. Then create a role for the identity provider
8. Verify the information 
9. Click create and the OIDC provider will then be created


#### Creating a SAML Identify Provider

1. From within the IAM console select identity providers
2. Click create provider
3. Select SAML
4. Enter a name for the identity provider
5. Point to the SAML metadata document
6. Verify the information
7. Click create


## Features of IAM

### Account Settings

- Account settings contains information related to your IAM password policy and Security Token Service Regions
  - The password policy is used and adopted by your IAM users
  - There are many components that you can change within the password policy to align it to any security controls or standards required
- The second element of your account settings are at the bottom of the screen which relates to Security Token Service Regions
  - This is a list of regions that are either activated or deactivated for the Security Token Service
  - By default all regions are activated
  - However, you can deactivate some if required for increased security
  - To deactivate, simply click on deactivate for the required region


### Credential Report

- Selecting credential report on the menu bar of IAM and click on the download report
  - It will generate a *.csv file containing a list of all your IAM users and credentials
  - Credential report will only be generated once every four hours; subsequent downloads will not regenerate until the 4 hours is up
  - To generate a new report, you have to wait at least four hours from the previous generation
- This credential report can be useful for when you're auditing your security services
- You can use the information within the report to ascertain if specific standards are being met, such as access key rotation or if additional levels of authentication are being used for implementing MFA
- This report could also be sent to external auditors to help secure evidence of compliance.


### Key Management Service (KMS)

- The KMS enabled you to easily manage encryption keys to secure your data
  - You can control how the keys can be used to encrypt your data
  - If you lose or delete your keys, they cannot be recovered!
  - You can manage your KMS Custom Master Keys (CMK) from within the IAM console
- To adminisiter your CMK, select Encruption Keys within the side menu bar
- Viewing the existing CMKs
  - Which Region the key exists in
  - The alias
  - They Key ID
  - Its status
  - The creation date of the CMK

