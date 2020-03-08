# Amazon Dynamo DB

## What Is DynamoDB?

- Amazon DynamoDB is a fully managed NoSQL database service. By "fully managed," we mean that the DynamoDB service is run entirely by the team at Amazon Web Services
- All you have to do is set up your tables and configure the level of provisioned throughput that each table should have
- Provisioned throughput refers to the level of read and write capacity that you want AWS to reserve for your table
- You are charged for the total amount of throughput that you configure for your tables, plus the total amount of storage space used by your data
- DynamoDB is a NoSQL database, which means that it doesn't use the common structured query language, or SQL
- It's not a relational database. Instead, it falls into a category of databases known as key value stores
- A key value store is a collection of items or records
- You can look up data by the primary key for each item, or through the use of indexes.
- If you want to add a new column to your table, you don't need to alter the table. Just start including the new field as an attribute when you insert new records
- You never need to adjust the data type for a column. DynamoDB generally doesn't care about data types for individual attributes.
- Highly available; your data is automatically replicated across three different availability zones within a geographic region. In the case of an outage or an incident affecting an entire hosting facility, DynamoDB transparently routes around the affected availability zone.
- Designed to be fast; read and writes take just a few milliseconds to complete, and DynamoDB will be fast no matter how large your tables grow. 


### Disadvantages

- Data is only eventually consistent; replication should normally take  milliseconds, but sometimes it can take longer. This is known as eventual consistency. This happens transparently and many operations will make sure that they're always working on the latest copy of your data. But there are certain kinds of queries and table scans that may return older versions of data before the most recent copy. 
- DynamoDB's queries aren't as flexible as what you can do with SQL. If you're used to writing advanced queries with joins and groupings, and summaries, you won't be able to do that with DynamoDB. You'll have to do more of the computation in your application code. This is done for performance reasons, to ensure that every query finishes quickly and that complicated queries can't hog the resources on a database server.
- Limited data types; dynamoDB doesn't offer the wide range of data types that many relational databases do. DynamoDB only has a few native data types, strings or text, numbers, Boolean values "True" and "False", and binary data. If you work with other data types like dates, you'll need to represent those as strings or numbers in order to store them in DynamoDB
- DynamoDB also has some strict limitations in the way you're allowed to work with it. Two important limitations are the 
  - Maximum record size of 400 kilobytes
  - Limit of 10 indexes per table
  - There are other limitations that can be adjusted by contacting AWS Customer Support, like the maximum number of tables in an AWS account
- Finally, although DynamoDB performance can scale up as your needs grow, your performance is limited to the amount of read and write throughput that you've provisioned for each table. If you expect a spike in database use, you will need to provision more throughput in advance or database requests will fail with a ProvisionedThroughputExceededException


## Comparing DynamoDB To Other Databases

### DynamoDB vs. Relational Databases

- Amazon DynamoDB
  - Queries via API calls
  - Flexible column Schema
  - Infinitely scalable
  - Eventually consistent
  - Always hosted by AWS
- Relational Databases
  - Queries written in SQL
  - Fixed schema for each table
  - Difficult to scale beyond 1 server
  - ACID compliant
  - On-premises or in the cloud
  

### DynamoDB vs. No Sql Databases

- Amazon DynamoDB
  - Document store
  - Eventually consistent
  - Transparently scalable
  - Managed by Amazon Web Services
- MongoDB, Cassandra, Couchbase
  - Key-value store, document store, column store
  - Eventually consistent, Immediately consistent
  - Ass servers to scale cluster
  - Self managed and self hosted

### AWS Database Hosting Options

- Amazon DynamoDB
  - Use AmazonDB if you want a fully-managed database that can scale easily and you don't mind learning new concepts
- Amazon Relational Databases Service
  - Use Amazon RDS if you want a managed database instance using a standard relational database that you already know
- Hosting Your Own Database
  - Host your own database if you're concerned about giving control of your data to a hosting provider, or if you need the data to live on premises


## Using DynamoDB In Your Application

- Interactive via AWS Console
- Programmatic via DynamoDB API
- There are 13 methods in the API
  - Managing Tables
    - ListTables
    - DescribeTables
    - CreateTable
    - UpdateTable
    - DeleteTable
  - Reading Data
    - GetITem
    - BatchGetItem
    - Query
    - Scan
  - Modifying Data
    - PutItem
    - UpdateItem
    - DeleteItem
    - BatchWriteItem
  - Calls are made via a RESTful http requests
  - Libraries to handle the calls
  - Boto3 is the latest AWS SDK


## Creating DynamoDB Tables

### Creating Your First Table

- AWS Console > Databases > DynamoDB
- You can create tables and databases from the console
  - Specify a primary key which is required
    - Partition and Sort keys are both supported
    - You only have to have a partition key
- Specify Throughput
  - Defaults to
    - Read capacity units 5 per table
    - Write capacity unites 5 per table
    - This provides an estimate which vary slightly by region
- You can create a table with two attributes as the unique identifier
  - Partition key
  - Sort key or range key 
- An example could be a log for a user action and with a time stamp. Partition would be a user id and the sort would be the time stamp


### Understanding Provisioned Throughput

- When you create a table in DynamoDB, you need to tell Amazon how much capacity you want to reserve for the table
- You don't need to do this for disk space. DynamoDB will automatically allocate more space for your table as it grows
- But you do need to reserve capacity for input and output for reads and writes.
- You are charged for read and writes
- You are allowed to spike over these read and write provisions occasionally
- Continuously going above the defined limits will cause you to be throttled with the error: ProvisionedThroughputExceededException
- 1 read capacity unit (RCU) will let you retrieve:
  - one item
  - up to 4 KB in size
  - with strong consistency
  - each second
  - Larger records cost 1RCU per KB of data
  - Eventually consistent reads cost half as much
- 1 write capacity unit (WCU) will let you store
  - one item
  - up to 1KB in size
  - each second
  - Larger records cost 1 WCU for every 1 KB of data
- Provisions can be adjusted on the fly as required
- Reads and Writes can be seen under the Metrics tab of the console
- Throughput provisions can be changed on the Capacity tab
- Updating the table will change its status of Updating before going back to active, reads and writes can still occur while these new provisions are occurring


## Reading And Writing Data

### Using The AWS Console To Read And Write

- Click on table and then the Items tab
- The data is not ordered by the partition key
- DynamoDB stores the data in partitions which are returned in parallel and so the order is not consistent
- You can edit by highlighting a property and then clicking the pencil button
- Click on the primary key
  - Edit multiple properties,
  - Remove property
  - Add property
- Click on create item to add a new record
- To delete, check rows and then actions and delete


### Using The API To Read And Write

- https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/dynamodb-examples.html


To read an item

```javascript
// Load the AWS SDK for Node.js
var AWS = require('aws-sdk');
// Set the region 
AWS.config.update({region: 'REGION'});

// Create the DynamoDB service object
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

var params = {
  TableName: 'TABLE',
  Key: {
    'KEY_NAME': {N: '001'}
  },
  ProjectionExpression: 'ATTRIBUTE_NAME'
};

// Call DynamoDB to read the item from the table
ddb.getItem(params, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    console.log("Success", data.Item);
  }
});
```

To write an item

```javascript
// Load the AWS SDK for Node.js
var AWS = require('aws-sdk');
// Set the region 
AWS.config.update({region: 'REGION'});

// Create the DynamoDB service object
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

var params = {
  TableName: 'CUSTOMER_LIST',
  Item: {
    'CUSTOMER_ID' : {N: '001'},
    'CUSTOMER_NAME' : {S: 'Richard Roe'}
  }
};

// Call DynamoDB to add the item to the table
ddb.putItem(params, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    console.log("Success", data);
  }
});
```

To update call updateItem which looks a bit like a patch. I cannot see anything on the API page though

Deleting an item

``` javascript
// Load the AWS SDK for Node.js
var AWS = require('aws-sdk');
// Set the region 
AWS.config.update({region: 'REGION'});

// Create the DynamoDB service object
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

var params = {
  TableName: 'TABLE',
  Key: {
    'KEY_NAME': {N: 'VALUE'}
  }
};

// Call DynamoDB to delete the item from the table
ddb.deleteItem(params, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    console.log("Success", data);
  }
});
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

### Queries And SCans In the AWS Console

- Under the items table
- Drop down of query ans scan
- Predicate is selectable from a drop down
- We can add a filter
- For a query you need to specify the index field value


### Queries And Scans With The API

Querying a Table

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
  KeyConditionExpression: 'Season = :s and Episode > :e',
  ProjectionExpression: 'Episode, Title, Subtitle',
  FilterExpression: 'contains (Subtitle, :topic)',
  TableName: 'EPISODES_TABLE'
};

ddb.query(params, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    //console.log("Success", data.Items);
    data.Items.forEach(function(element, index, array) {
      console.log(element.Title.S + " (" + element.Subtitle.S + ")");
    });
  }
});
```

Scanning a Table

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
  if (err) {
    console.log("Error", err);
  } else {
    //console.log("Success", data.Items);
    data.Items.forEach(function(element, index, array) {
      console.log(element.Title.S + " (" + element.Subtitle.S + ")");
    });
  }
});
```

## Secondary Indexes

### Understanding Secondary Indexes

- If you want to filter data by a non key value, this is the best way to go to prevent huge RCU
- You can create multiple indexes
- A query can only hit one index
- Specify which index to use when writing your query
- Two types of secondary indexes
  - Global Secondary Indexes let you query across the entire table
  - Local Secondary Indexes let you query within a single partition key

### Global 

- Behind the scenes, these global secondary indexes are just like DynamoDB tables of their own
- A global secondary index has its own partition key and also contains other attributes like the order ID, which is needed to match the records to items in the main table
- Global secondary indexes use storage space that's separate from the main table
- You have to configure provision throughput for each global secondary index, just like you do for a table
- When you query the index, DynamoDB retrieves the data that's included in the index. So if you queried this secondary index for orders from customer 40343, DynamoDB would return three order IDs
- But you probably want your query to return all the attributes from the main table. You can include those attributes in the index. This is called projecting attributes into the index.
- By default, all of the attributes in the table are projected into the index
- But this uses more space and more throughput than an index that only includes its own keys and the keys of the table
- So you have the option to choose what to project into the index. You can project everything, you can project nothing except for the keys, or you can specify exactly which attributes should be projected into the index


### Local

- Local secondary indexes live within each partition key and help you filter data within that partition
- This means that they're not useful unless you have a compound primary key
- Another way to think about local secondary indexes is that they're similar to global indexes, except that the indexes partition key must be the same as the table's partition key
- If your queries will work by limiting the results to a single partition key value, then you should use a local secondary index
- If you need to query across all partition key values, then use a global secondary index.
- Both types of indexes can be created at the same time the table is created, but only global secondary indexes can be added or changed or removed later
- If you want to add a local secondary index to an existing table, or remove a local secondary index, you would need to delete the table and start over
- When you create a global secondary index, you have to revision separate throughput capacity for the index while local secondary indexes share their provision throughput with the main table
- Although you don't have to provision any extra throughput for the local secondary indexes separately, remember that you are using additional capacity units in order to update indexes or every time you query the index
- There's also a limit to the number of indexes on each table. You can only create five global secondary indexes and five local secondary indexes for each table

### Creating Secondary Indexes

- If possible to be a local the option will un-gray in the console

### Querying Secondary Indexes

- Just pass in the required index as a parameter


## Working With Large Tables

### Introduction To Partitioning

- Partitions are added automatically when the table grows in size
- Larger than 10GBs or when a RCU or WCU grows
- Items with the same partition will be stored in the same partition
- Each partition will contain about half the partition keys 


### Balancing Partitions In Large Tables

- Each partition will get an equal share of the RCU and WCU. 100/200 will give 50/100 if 2 partitions are used
- A bad partition key is one which is not evenly distributed
- Once a partition uses up its RCU and WCU reads and writes stop with ProvisionThroughputExceededException when reading or writing to that partition
- This error should reset every second however it can take a few minutes to reset correctly
- You do get some ability to go above the RCU and WCU for small intermitted periods (Burst Capacity)