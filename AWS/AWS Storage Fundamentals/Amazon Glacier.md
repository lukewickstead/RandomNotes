# Amazon Glacier

- A very low cost, long term durable solution (cold storage) suited for long term backup and archival requirements
- It does not provide instant access to your data
- Attains 99.999999999% of durability by replacing data across multiple availability zones within a single region
- Storage costs are considerably lower than Amazon S3
- Retrieval of your data can take up to several hours
- The data structure within Glacier is centered around vaults and archives

## Vaults and Archives

- Vaults
  - Acts as a container for Glacier Archives
  - Vaults are regional, selected during creation
  - Within each vault you can store data as Archives
- Archives
  - Archives can be any object similarly to S30
  - You can have unlimited archives within your Glacier Vaults

## Glacier Dashboard
- The Glacier Dashboard within AWS management console, only allows you to create your vaults
- Any operational process to upload and retrieve data has to be done using code:
  - The Glacier web app service API
    - https://docs.aws.amazon.com/amazonglacier/latest/dev/amazon-glacier-api.html
  - AWS SDKs
    - Simplifies the process of authentication
    - https://docs.aws.amazon.com/amazonglacier/latest/dev/using-aws-sdk.html

## Moving Data In Glacier

1. Create your vaults as a container for your archives using the Glacier console
2. Move your data into the Glacier vault using the API or SDKs
3. Or from S3 using a Lifecycle rule

## Data Retrieval

- Expedited
   - Use for urgent access to a subset of an archive
   - Less than 250mb
   - Data available within 1-5 minutes
   -  CostL: $0.03 per GB $0.001 per request
- Standard
  - Used to retrieve any of your archives no matter their size
  - Data will be available in three to five hours
  - Cost $0.01 per GB $0.05 per 1,000 requests
- Bulk
  - Used to retrieve petabytes of data at a time
  - Data available within five and twelve hours
  - The cheapest option for data retrieval
  - Costs $0.0025 per GB $0.025 per 1,000 requests

# Security 

- Data is encrypted by default using AES-256 algorithm
  - It looks after and manages your keys
- Vault Access Policies
  - Resource based policies
  - Applied to a specific vault
  - Each vault can only contain 1 vault access policy
  - Policy is in a JSON format
  - Policy contains a principal component
  - https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html
- Vault Lock Policies
  - Once set they cannot be changed
  - Use to help maintain specific governance & compliance controls

You would Vault Access Policies to govern access control features that may change over time and you would use Vault Lock Policies to help you maintain compliance using access controls that must not be changed. 

## Pricing

- Glacier offers a single storage regardless of how much storage is being used
- Price varies from region to region
- London Region: $0.0045 per GB
- Data transfer into Glacier is FREE
- Data transfer to another region is $0.002 per GB
- Retrieval requests
  - Expedited: $10.50 per 1,000 requests
  - Standard: $0.05 per 1,000 requests
  - Bulk: $0.00265 per 1,000 requests
