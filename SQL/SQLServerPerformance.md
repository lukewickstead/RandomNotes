# Analysing SQL Performance #

Hit display estimated execution plan

## Understanding The Execution Plan ##

Operations are 'completed' right to left in general but SQL Server will do items in parallisations. The cost is a % which defines how expensive a step is in relation to the total cost of execution.

Highlighting a step can show

- The type of action
- The query part which is used for this step
- Estimated number of rows; using the kept and maintained statistics based upon rows in table and the type of data used.
- *Cost values define how relatively expensive against other steps
	- CPU and IO cost is used to define the operator cost
	- We can also see the estimated substree cost where applicable

## What to look out for ##

Look out for Scans, hash match, high cost/ cost % and logical reads.


## Step Types ##

A Scan operation is when SQL Server is ready an entire table or index.

A Seek operation uses the B tree of an index.

It is often better to use a scan over a seek. Though sometimes SQL Server will not use an index when the index is not selective enough as it might result in more logical reads.


### Clustered index scan ###

Clustered index scan is when an index cannot be used and the clustered index is used to scan the entire table. If the clustered index can be used as an index then it would not say scan. Scanning is using the data pages to literally look through the entire book.

For small tables it is more efficent to do this rather than hit an index.

### Nested Loops Join ###

Used to join two rows; two looks used to join two sets. This is when the two sets of data are not in the same order.

### Merge Joins ###

Join which is used when two data sets are in the same sorted order. Sometimes you see a sort on one side of the join. SQL Server will do this if it thinks the merge join + the sort order is the most efficent action to take when joining.

### Hash Match Join ###

A hashtable of the smaller data set is created, then SQL Server loops through the larger data set probing the hashtable for matching values. This is used when two large datasets must be joined.

Tnis is expensive in CPU and memmory.

### Index Seek  ###

This is when an index is being hit, you often see a Key Lookup on the other side of the action which indicates the index'es row pointers are being used against the clustered index to retrieve the required data

### TOP ###

Gets the top x elements

## Set Statistics ##

Set statistics can be used to get stats on a running query or command

Run these commands before executing your command but don't forget to turn them off once you are done.

``sql
SET STATISTICS IO ON
SET STATISTICS TIME ON
```

Look out for logical reads; when a data page has to be read from memmory or disk. A high number indicates a potential issue.

When a elapsed time is smaller than a CPU time this is due to parallisation


## Before & After ##

Good to record the following to identify the performance change

- Data Access Operation
- Statement Cost
- Logical Reads
- CPU Time
- Elapsed Time



# Index Concepts #

Data in a table is stored in 4K pages. The data pages are ordered by the clustered index.

The clustered index defaults toto the primary key if no clustered index is specifically defined.

A table scan is where all data pages are read for the entire table as an index cannot be used. If the table is large then this is slow.

Additional indexs have the data pages replaced by row pointers which indicate which data page the record belongs to.

Indexes slow down the write actions upon the table as there is an overhead for maintaining


## Create Highly-Selective Indexes ##

Indexes with a greater selectivity perform better; ratio of total rows to result set rows. (This is the uniqueness of the values contained within the data)

You can use the following stored procedures to query the selectivity

- sp_show_statistics
- show_statistics_steps
- show_statistics_columns

```sql
 sp_show_statistics_steps 'MyTable' 'MyColumn'
```

Where the selectivity of an index is not very high then SQL Server might chose to ignore the index and do a table scan. An index with a low selectivity can cause many logical reads.

## Multiple-Column Indexes ##

Multiple column indexes can be partially used. However you can only drop the latter columns of the index

If we create an index on LastName and FirstName:

```sql
CREATE INDEX Idx_Accounts_Name ON Employees ("LastName" ASC, "FirstName" ASC)
```

We can hit the index if we predicate upon

- WHERE LastName = 'Smith'
- WHERE LastName = 'Smith' AND FirstName = 'John'
- WHERE FirstName = 'John' AND "Last Name" = 'Smith'

We don't hit the index if we search upon FirstName

## Avoid Indexing Small Tables ##

Indexing small tables is less efficent than doing an actual table scan. There is an overhead of loading and processing index pages.

## Choose What to Index ##

- Primary keys
	- The clustered index will default to the PK.
- Foreignkeys
	- Indexs are added to FK's where a constraint is implemented.
	- Keep Fks as small as possible; searching/joining on an int performs better than a string
- Frequently searched upon fields.
	- Use a SARG as these allow a direct hit to the index.
		- =, >, <, >=, <=, IN, BETWEEN, and sometimes LIKE (fixed prefix only)
- Sorted and Grouped Columns
	- Partial indexes can be hit
	- When an index can be hit only the index can be used otherwise a temp table is used which is expensive.
- Distinct Columns
	- Cannot user partial indexes

## INCLUDE COLUMNS ##

We can include additional columns on an index. They are not used for the index but can remove the requirement to get additiional data from the data pages.

Covering Index is a term used when all data required can be returned from the index.

When you only need one or two columns consider adding an include column. If you are adding 3 or more then this is not a good idea. The larger the index the more costly it is to maintain.

## How Many Indexes? ##

Only those which are used; they have a high maintaince cost and also increase the write cost.

SQL Server is aggresive on sugesting indexes; consider them seriously.

Dynamic Management Views can help us identify unused indexes.

```sql
SELECT object_name(i.object_id) AS TableName, i.name AS [Unused Index]
FROM sys.indexes i
LEFT JOIN sys.dm_db_index_usage_stats s ON s.object_id = i.object_id
      AND i.index_id = s.index_id
      AND s.database_id = db_id()
WHERE objectproperty(i.object_id, 'IsIndexable') = 1
AND objectproperty(i.object_id, 'IsIndexed') = 1
AND s.index_id is null
OR (s.user_updates > 0 and s.user_seeks = 0 and s.user_scans = 0 and s.user_lookups = 0)
ORDER BY object_name(i.object_id) ASC
```

# Query Tips #

## Distinct ##

Only use distinct when your query does not return a distinct row

## UNION vs UNION ALL ##

UNION works like a set; a distinct set of rows. When simply appending is required use UNION ALL

## Favour JOINs to Sub Queries ##

In most situations it is better to join to a table in favour of a sub query.

## EXISTS and NOT EXISTS ##

In some situations it is better to use a EXISTS and NOY EXISTS when all you want to know is if there are any matching.

Think about  getting courses which have no students enrolled. Here the minute we find one we can leave our operation. Just like exiting a loop when we know we don't have to continue!

## Functions ##

Functions on left side of clause/column cause will not be able to use an index. Consider using a computed column with an index or changing the query.

## OUTTER vs INNER JOINS ##

OUTTER Joins are not optimised; prefer inner joins.

# Table Design #

- Joins are relatively expensive; don't overly normalise.
- Favour small data types for join fields, fk fields and primary keys
- Create smaller row lengths

# Finding Performance Bottlenecks in SQL Server #

To use DMVs you required VIEW SERVER STATE privilege.

http://buildingbettersoftware.blogspot.co.uk/2016/04/exposing-sql-server-dmv-data-to.html

sys.dm_exec_sessions can be used to get a list of all clients connected. This can be used to find clients who are hammering the server. The  program_name of .NET SQLCLient data prvider is a default. IN the connection string we can provide an Application Name. Useful to identify sessions.

sys.dm_exec_sessions and sys.dm_exec_requests can be used to find out queries which are running right now.

sys.dm_exec_sql_text  contains the text of the request
sys.dm_exec_query_plan contains the execution plan. It contains a link which you can click on it and view the execuution plan in the normal execution plan window

sys.dm_exec_requests contains the column blocking_sessions_id which can be used to find out who is blocking this query.

Don't for get to limit it to your required database.

## finding the Worst Performing Statements ##

Time is in milliseconds; move 5 dps to the right to get seconds!


```sql

-- Worst performing CPU bound queries
SELECT TOP 5
	st.text,
	qp.query_plan,
	qs.*
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY total_worker_time DESC
GO
```

```sql
-- Worst performing I/O bound queries
SELECT TOP 5
	st.text,
	qp.query_plan,
	qs.*
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY total_logical_reads DESC
GO
```

## Missing Indexes ##

```sql
-- Missing Index Script
-- Original Author: Pinal Dave 
SELECT TOP 25
dm_mid.database_id AS DatabaseID,
dm_migs.avg_user_impact*(dm_migs.user_seeks+dm_migs.user_scans) Avg_Estimated_Impact,
dm_migs.last_user_seek AS Last_User_Seek,
OBJECT_NAME(dm_mid.OBJECT_ID,dm_mid.database_id) AS [TableName],
'CREATE INDEX [IX_' + OBJECT_NAME(dm_mid.OBJECT_ID,dm_mid.database_id) + '_'
+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.equality_columns,''),', ','_'),'[',''),']','') 
+ CASE
WHEN dm_mid.equality_columns IS NOT NULL
AND dm_mid.inequality_columns IS NOT NULL THEN '_'
ELSE ''
END
+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.inequality_columns,''),', ','_'),'[',''),']','')
+ ']'
+ ' ON ' + dm_mid.statement
+ ' (' + ISNULL (dm_mid.equality_columns,'')
+ CASE WHEN dm_mid.equality_columns IS NOT NULL AND dm_mid.inequality_columns 
IS NOT NULL THEN ',' ELSE
'' END
+ ISNULL (dm_mid.inequality_columns, '')
+ ')'
+ ISNULL (' INCLUDE (' + dm_mid.included_columns + ')', '') AS Create_Statement
FROM sys.dm_db_missing_index_groups dm_mig
INNER JOIN sys.dm_db_missing_index_group_stats dm_migs
ON dm_migs.group_handle = dm_mig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details dm_mid
ON dm_mig.index_handle = dm_mid.index_handle
WHERE dm_mid.database_ID = DB_ID()
ORDER BY Avg_Estimated_Impact DESC
GO

```



## TO SORT ##

SQL Server will cache result to redoing a query can be quicker the next time.



We can force SQL Server to use an index ( via a hint )

From XXX With (Index(IX_XXX))
