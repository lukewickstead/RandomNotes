# Amazon Dynamo DB

[toc]

## What Is DynamoDB?

- Amazon DynamoDB is a key-value and document database that delivers single-digit millisecond performance at any scale
- It is a fully managed service; the installation of the database engine, backups and patching are all automatic
- You are charged by throughput and storage space
- Throughput is the level of read and write capacity upon the database
- Highly available; your data is automatically replicated across three different availability zones within a geographic region
- Automatic failover to another availability zone
- Designed to be fast; read and writes take just a few milliseconds to complete, and DynamoDB will be fast no matter how large your tables grow
- Highly scalable with very low latency as it uses multiple replicas around the world



## Disadvantages

- Works on eventual consistency; it accepts some people might not have the latest version of the data in return for greater speeds
- Queries aren't as flexible as what you can do with SQL; you will have to do more computation in your application code. This is queries are quick and do not hog resources
- Limited data types; strings, numbers, Boolean and binary data
- Strict limitations 
  - Maximum record size of 400 kilobytes
  - Limit of 10 indexes per table
  - Maximum number of tables in an AWS account



## Using DynamoDB In Your Application

- Interactive via AWS Console
- Programmatic via DynamoDB API
- There are 13 methods in the API and and be grouped by
  - Managing Tables; ListTables, DescribeTables, CreateTable, UpdateTable, DeleteTable
  - Reading Data; GetITem, BatchGetItem, Query, Scan
  - Modifying Data; PutItem, UpdateItem, DeleteItem, BatchWriteItem
- Calls are made via a RESTful http requests but SDKs exist to handle the calls for you. Boto3  is the python SDK



## Core Components of Amazon DynamoDB

- Data is organized into **tables** which hold **items** which are bags of **attributes**
- **Primary Key**
  - Each table requires a **Primary Key** which uniquely identifies each item in a table
  - A **Primary Key** has to have a a **Partition Key** and can optionally contain a **Sort Key**
  - A Composite Primary Key is when a partition key and a sort key exist
- **Partition Key**
  - One attribute that every item in the table will have
  - A hash of the field determines partition to save the item into
- **Sort Key**
  - An additional field which is used to order the items in the partition
  - A Sort Key allows additional queries on that field to be made along with the primary key
- **Secondary Indexes**
  - Allows querying items in a table by an alternative key
  - Multiple secondary indexes can be provided but they are optional
  - Can be either **Global** or **Local**



### Global  Secondary Indexes

- Global secondary indexes have a different partition key and sort key than the primary key
- Behind the scenes, these global secondary indexes are just like DynamoDB tables of their own
- Has its own partition key and also contains other attributes which are needed to match the records to items in the main table
- Global secondary indexes use storage space that's separate from the main table
- You have to configure provision throughput for each global secondary index, just like you do for a table
- When you query the index, DynamoDB retrieves the data that's included in the index
- By default, all of the attributes in the table are projected into the index; this allow retrieval of other attributes when querying
- You can restrict fields being projected to reduce space and throughput used
- Can be created, edited and deleted at any time
- A maximum of 20 per table



### Local Secondary Indexes

- Live within each partition key and help you filter data within that partition
- They're not useful unless you have a compound primary key
- If your queries will work by limiting the results to a single partition key value, then you should use a local secondary index
- If you need to query across all partition key values, then use a global secondary index;
- Can only be created when the table is created; you will need to create a new table and migrate the data to add or edit a local secondary indexes
- Share provisioned throughput with the main table
- Use additional capacity units when querying through the index
- A maximum of 5 per table





## On-Demand vs. Provisioned

- When creating a table in DynamoDB you specify it as being either provisioned or on-demand
- Can be changed when required

- **Provisioned**
  - Allows you to provision set read and writes allowed against your database per second by your application
  - Measured in capacity units
    - Read Capacity Units (RCU)
    - Write Capacity Units (WCU)
  - Depending upon the transactions each action will use 1 or more unit
  - Used generally when you have a predicted and forecasted workload of traffic
  - ProvisionedThroughputExceededException is thrown if throughput is reached
  - Defaulrts
    - Read capacity units 5 per table
    - Write capacity unites 5 per table
- **On-Demand**
  - Does not provision any RCUs or WCUs, instead they are scaled on demand
  - Not as cost effective
  - Generally used if you do not know how much workload you are expected to experience



### Understanding Provisioned Throughput

- When you create a table in DynamoDB, you need to tell Amazon how much capacity you want to reserve for the table
- You don't need to do this for disk space. DynamoDB will automatically allocate more space for your table as it grows
- But you do need to reserve capacity for input and output for reads and writes.
- You are charged for read and writes
- You are allowed to spike over these read and write provisions occasionally  (Burst Capacity)
- Once a partition uses up its RCU and WCU reads and writes stop with a ProvisionThroughputExceededException / Bad Request (400) when reading or writing to that partition
- ProvisionThroughputExceededException should reset every second however it can take a few minutes to reset correctly
- 1 read capacity unit (RCU) will let you retrieve:
  - One item up to 4 KB in size with strong consistency each second
  - Larger records cost 1RCU per KB of data
  - Eventually consistent reads cost half as much
- 1 write capacity unit (WCU) will let you store
  - one item up to 1KB in size each second
  - Larger records cost 1 WCU for every 1 KB of data
- Provisions can be adjusted on the fly as required
- Reads and Writes can be seen under the Metrics tab of the console
- Throughput provisions can be changed on the Capacity tab
- Updating the table will change its status of Updating before going back to active, reads and writes can still occur while these new provisions are occurring



## Reading And Writing Data



### To read an item

```javascript
var AWS = require('aws-sdk');
AWS.config.update({region: 'REGION'});
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

var params = {
  TableName: 'TABLE',
  Key: {
    'KEY_NAME': {N: '001'}
  },
  ProjectionExpression: 'ATTRIBUTE_NAME'
};

ddb.getItem(params, function(err, data) { });
```



### To write an item

```javascript
var AWS = require('aws-sdk');
AWS.config.update({region: 'REGION'});
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

var params = {
  TableName: 'CUSTOMER_LIST',
  Item: {
    'CUSTOMER_ID' : {N: '001'},
    'CUSTOMER_NAME' : {S: 'Richard Roe'}
  }
};

ddb.putItem(params, function(err, data) {});
```



## Queries And Scans

### Understanding Queries and Scans

#### Queries

- A query searches the table for a single partition key
- Results can be limited to a range of sort keys
  - sort key = 25 or sort key = 'Franklin'
  - sort key > 9 or sort key < 36
  - sort key between 10 and 20, or between "Jackson" and "James"
  - sort key begins with "Ross" (for strings only)
- Results can be filtered on any attributes(s)
  - Restricts what is returned based upon this secondary predicates
  - Still required DynamoDB to read all the non filtered records
  - Still takes up more RCU
  - Think about putting in a secondary index
  - Results can be ordered asc or desc by sort key
  - Results can be limited to top x or bottom y record counts
  - Queries can be strongly consistent or eventually consistent
  - Filters should only be used when a query has filtered down the data to a small dataset



#### Scans

- A scan searches the across all partition keys
- Scans can be filtered on any attribute(s)
  - Might require enough read capacity to read the entire table
- Scan cannot be ordered
- Scans are always eventually consistent
- Scans ca be run in parallel from multiple threads or servers



#### Querying Via API

```javascript
var AWS = require('aws-sdk');
AWS.config.update({region: 'REGION'});
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

var params = {
  ExpressionAttributeValues: {
    ':s': {N: '2'},
    ':e' : {N: '09'},
    ':topic' : {S: 'PHRASE'}
  },
  KeyConditionExpression: 'Season = :s and Episode > :e',
  ProjectionExpression: 'Episode, Title, Subtitle',
  FilterExpression: 'contains (Subtitle, :topic)',
  TableName: 'EPISODES_TABLE'
};

ddb.query(params, function(err, data) {
  // data.Items contains the items
});
```



#### Scanning Via API

```javascript
// Load the AWS SDK for Node.js
var AWS = require('aws-sdk');
// Set the region
AWS.config.update({region: 'REGION'});

// Create DynamoDB service object
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

var params = {
  ExpressionAttributeValues: {
    ':s': {N: '2'},
    ':e' : {N: '09'},
    ':topic' : {S: 'PHRASE'}
  },
  ProjectionExpression: 'Episode, Title, Subtitle',
  FilterExpression: 'contains (Subtitle, :topic)',
  TableName: 'EPISODES_TABLE'
};

ddb.scan(params, function(err, data) {
   // data.Items contains items
});
```



## Streams

- Optional feature that captures data modification events
- Endpoints naming convention is streams.dynamodb..amazonaws.com
- Each event is represented by a stream record, and captures the following events:
  - A new item is added to the table: captures an image of the entire item, including all of its attributes
  - An item is updated: captures the "before" and "after" image of any attributes that were modified in the item
  - An item is deleted from the table: captures an image of the entire item before it was deleted
- Each stream record also contains the name of the table, the event timestamp, and other metadata
- Stream records are organized into groups, or shards. Each shard acts as a container for multiple stream records, and contains information required for accessing and iterating through these records
- Stream records have a lifetime of 24 hours; after that, they are automatically removed from the stream



## Data Types

- **Scalar Types**
  - Represents exactly one value
  - The scalar types are number, string, binary, Boolean, and null
  - Primary keys should be scalar types
- **Document Types**
  - A document type can represent a complex structure with nested attributes
  - The document types are list and map
- **Set Types**
  - Represent multiple scalar values
  - The set types are string set, number set, and binary set



## Sources

- https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html
- https://aws.amazon.com/dynamodb/faqs
- https://tutorialsdojo.com/amazon-dynamodb