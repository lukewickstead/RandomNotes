# When to use RDS Multi-AZ & Read Replicas

[toc]

## RDS Multi AZ



### Multi-AZ means Multi Availability Zone

- It is a feature that is used to help with resilience and business continuity 
- Multi-AZ configures a secondary RDS instance (replica) within a different availability zone in the same Region as the primary instance
- The only purpose of Multi-AZ is to provide a failover option for a primary RDS instance
- The replication of data happens synchronously
- RDS uses a Failover mechanism on Oracle, MySQL, MariaDB and PostgreSQL instances
- The RDS failover process happens automatically and is managed by AWS
  - RDS updates the DNS record to point to the secondary instance within 60-120 seconds
  - The Failover process will happen in the following scenarios on the primary instance
    - Patching maintenance
    - Host failure
    - Availability zone failure
    - Instance rebooted with Failover
    - DB instance class is modified
- How can you be made aware of when this event occurs?
  - The RDS Failover triggers an event which is recorded as RDS-EVENT-0025 when the failover process is complete
  - These events are also recorded within the RDS Console



### SQL Server Mirroring

- SQL Server Multi-AZ is achieved though the use of SQL Server Mirroring
  - Multi-AZ is available (currently) on only SQL Server 2008 R2, 2012, 2014, 2016 and 2017 on both Standard and Enterprise Editions
  - SQL Mirroring provisions a secondary RDS instance in a separate AZ than that of the primary RDS instance to help with resilience and fault tolerance
  - Both primary and secondary instances in SQL Server mirroring use the same Endpoint
- You need to ensure you have your environment configured correctly
  - A DB subnet group must be configured with a minimum of 2 different AZ's within it
  - You can specify which availability zone standby mirrored instance will reside in
  - To check which AZ the standby instance is in you can use the AWS CLI command 'describe-db-instances'



### Amazon Aurora DB

- Amazon Aurora is different to the previous DB engines when it comes to resiliency across more than a single AZ
  - Aurora DB clusters are fault tolerant by default
  - This is achieved within the cluster by replicating the data across different instances in different AZs
  - Aurora can automatically provision and launch a new primary instance in the even of failure, which can take up to 10 minutes
  - Multi-AZ on Aurora cluster allows RDS to provision a replica within a different AZ automatically
  - Should a failure occur, the replica instance is promoted to the new primary instance without having to wait 10 minutes
  - This creates a highly available and resilient database solution
  - It is possible to create up to 15 replicas if required, each with a different priority



## Read Replicas

- Read Replicas are NOT used for resiliency or as a secondary instance in the event of a failover
- Read Replicas are used to serve read-only access to your database data via a separate instance
- A snapshot is taken from your database
  - If using Multi AZ this will be taken from the secondary DB
- Once the snapshot is completed a read replica instance is created
- The read replica maintains a secure asynchronous link between itself and the primary database
- At this point, read-only traffic can be directed to the Read Replica
- Read replicas are only available for MySQL, MariaDB and PostgreSQL DB engine
- It is possible to deploy more than one read replica for a primary DB
- Adding more replicas allows you to scale your read performance to a wider range of applications
- You are able to deploy read replicas in different regions
- It is possible to promote an existing read replica to the primary DB in the even of an incident
- During any maintenance of the primary instance, read traffics can be served via your read replicas
  



### My SQL

- Read replicas are only supported where the source DB is running MYSQL 5.6 or later
- The retention value of the automatic backups of the primary DB needs to set to a value of 1 or more
- Replication is also only possible when using an InnoDB storage engine, which is transactional
- It is also possible to have newsted read replica chains
  - A read replica replicates from your source DB and can then act as a source DB for another read replica
  - This chain can only be a maximum of 4 layers deep
  - The same prerequisites must also apply to the source read replica
  - You can have up to a maximum of 5 read replicas per each source DB
    - A source db can be another replica
- If an outage occurs with the primary instance, RDS automatically redirects the read replica source to the secondary DB
- Amazon CloudWatch can monitor the synchronization between the source DB and the read replica through a metric known as ReplicaLag
  - The closer to zero the better



### MariaDB

- Mostly the same as MySQL
- You still need to have the backup retention period greater than 0, and you can only have 5 read replicas per source DB
- The same read replicas nesting rules apply and you also have the same monitoring metric for CloudWatch
- You can be running ANY version of MariaDB for read replicas



### PostgreSQL

- The automatic backup retention value needs to be greater than 0 and the limitation of read replicas is 5 per source DB
- When using PostgreSQL, you need to run version 9.3.5 or later for read replicas
- The native PostgreSQL streaming replication is used to handle the replication and creation of the read replica
- The connection between the master and the read replica instance replicates data asynchronously between the 2 instances
- A role is used to manage replication when using PostgreSQL
  - Only has the ability to handle replication and nothing else
- PostgreSQL allows you to create a Multi-AZ read replica instance
  - Even if the source db is not Multi-AZ
  - PostgreSQL does not allow nested read replicas


