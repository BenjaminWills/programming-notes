# Dynamo DB

- [Dynamo DB](#dynamo-db)
  - [Introduction](#introduction)
  - [Comparison of SQL to NOSQL](#comparison-of-sql-to-nosql)
  - [Tables](#tables)
  - [Data types in DynamoDB](#data-types-in-dynamodb)
  - [Dynamo DB consistency](#dynamo-db-consistency)
  - [Dynamo DB pricing model](#dynamo-db-pricing-model)
    - [Throughput](#throughput)
    - [Use cases of provision vs on demand](#use-cases-of-provision-vs-on-demand)
  - [Indexing](#indexing)
    - [Local secondary index (LSI)](#local-secondary-index-lsi)
    - [Global secondary indexes (GSI)](#global-secondary-indexes-gsi)
    - [When do we use these](#when-do-we-use-these)
  - [Design patterns](#design-patterns)
  - [Partitions](#partitions)
  - [Scaling](#scaling)
    - [Autoscaling](#autoscaling)
  - [Storage](#storage)
  - [Operations](#operations)
  - [DynamoDB accelarator (DAX)](#dynamodb-accelarator-dax)
    - [Architecture](#architecture)
    - [DAX Operations](#dax-operations)
  - [Backups](#backups)
    - [What gets restored](#what-gets-restored)
    - [What does not get restored](#what-does-not-get-restored)
    - [Continuous backups](#continuous-backups)
  - [Best practices](#best-practices)

## Introduction

`AWS's` non relational NOSQL key value store database. It is serverless, fast, flexible, cost effective, fault tolerant and secure. Single digit millisecond performance at any scale.

Supports `CRUD` through APIS, with transactional support.

No direct analytical queries.

Data is stored internally as `JSON` files

## Comparison of SQL to NOSQL

| SQL  | DynamoDB  |
|---|---|
|  Tables |  Tables |
|  Rows |  Items |
|  Columns | Attributes  |
|  Primary Keys - multicolumn and optional | Primary keys - manditory, minmum of one attribute and maximum two attributes  |
| Indexes  | Local secondary indexes  |
| Views  | Global secondary indexes  |

## Tables

- Tables are top level entities (like schemas in SQL)
- No string inter table relationships
- Control performance at table level
- Table items stored as JSON
- Primary keys can be simple or composite
  - Simple key has single attribute (partiton key or hash key)
  - Composite key has two attributes (partition/hash key + sort/range key)
  - Non key attributes are optional
  - Key structure

  ```JSON
  \\ Simple key table structure
  {
    "partition_key":"",
    "attribute_1":""
  }
  \\ Complex key table structure
  {
    "partition_key":"",
    "sort_key":"",
    "attribute_1":""
  }
  ```
  
## Data types in DynamoDB

- Scalar types:
  - Exactly one value
  - E.g string, number, binary, Boolean and null
  - Keys or index attributes only suport strings, numbers and binary
- Set types:
  - One Key with multiple scalar values
  - E.g string set, number set, binary set
- Document types:
  - Complex JSON structure with nested attributes
  - E.g list and map

## Dynamo DB consistency

- Read consistency consists of:
  - Strong consistency:
    - The most up to date data
    - Must be requested explicitly
  - Eventual consistency:
    - May or may not reflect latest copy of data
    - Default consistency for all read operations
    - 50% cheaper than strong consistency
  - Transactional consistency:
    - For ACID support across one or more tables with single AWS account
    - 2x cost of strong consistent reads
- Write consistency consists of:
  - Standard Consistency
  - Transactional Consistency
    - For ACID support across one or more tables with single AWS account
    - 2x cost of strong consistent reads
  
## Dynamo DB pricing model

- Provisioned capacity:
  - You pay for the capacity that you provision
  - You can use autoscaling to adjust the provisioned capacity
  - Uses `capacity units`: Read capacity units and Write capacity units. (RCU, WCU)
  - Consumption beyond provisioned capacity may result in throttling
  - Use reserved capacity for discounts over 1 or 3 year term (one time fee then an hourly fee for every 100 RCU+WCU)
- On-demand capacity:
  - Pay per request (number of read and writes)
  - No need to provision capacity units
  - Instantly accomodates workloads as they ramp up or down
  - Uses read request units, and write request units (RRU, WRU)
  - Cannot use reserved capacity with on demand nodes.
- storage, backup, replication, streams, caching, data transfer out charged additionally

### Throughput

- Provisioned capacity:
  - Capacity units:
    - 1 capacity unit = 1 request/sec
  - RCUs:
    - In blocks of 4KB, last block always rounded up
    - 1 strongly consistent table read/sec = 1 RCU
    - 2 eventually consistent table reads/sec = 1 RCU
    - 1 transactional read/sec = 2 RCU
  - WCUs
    - In blocks of 1KB, last block rounded up
    - 1 table write/sec = 1 WCU
    - 1 transactional write/sec = 2 WCU
- On demand capacity:
  - Uses Request units
    - Same as Capacity units for calculations
  - RRUs:
    - In blocks of 4KB, last block always rounded up
    - 1 strongly consistent table read/sec = 1 RRU
    - 2 eventually consistent table reads/sec = 1 RRU
    - 1 transactional read/sec = 2 RRU
  - WRUs:
    - In blocks of 1KB, last block rounded up
    - 1 table write/sec = 1 WRU
    - 1 transactional write/sec = 2 WRU

### Use cases of provision vs on demand

| Provisioned  |  On-Demand |
|---|---|
|  Typically used in production environment | Typically used in dev/test environment, or for small applications   |
| Use this when we have predictable traffic  | Use this when you have variable and unpredictable traffic  |
| Can result in throttling when consumption exceeds provision  |  Throttling can occur if you exceed 2x the precious peak within 30 minutes  |
| Tends to be cost effective  | Recommended to space traffic growth over at least 30 minutes before driving 2x  |

## Indexing

Indexes in DynamoDB are different from their relational counterparts. When you create a secondary index, you must specify its key attributes—a partition key and a sort key. After you create the secondary index, you can Query it or Scan it just as you would with a table. DynamoDB does not have a query optimizer, so a secondary index is only used when you Query it or Scan it.

### Local secondary index (LSI)

- Can define up to 5 LSIs
- Has same partition/hash key attribute as the primary index of the table
- Has different sort/range key than the primary index of the table
- Must have sort/range key
- Indexed items $\leq10$ GB
- Can only be created and destroyed upon table creation
- Can only query a single partition
- Supports all consistency models
- LSIs consume provision throughput of base table
- Can query any table attributes

### Global secondary indexes (GSI)

- Can define up to 20 GSIs
- Can have same or different partiton hash key than tables primary index
- Can have same or different sort/range key than tables primary index
- Can omit sort/range key
- No size restriction for indexed items
- Can be created or removed at any time
- Can query across partitions
- GSIs only support eventual consistency
- Have own provisioned throughput
- Can only query projected attributes

### When do we use these

| LSI  | GSI  |
|---|---|
|  When the application needs the same partition key as the table | When the application requires a different partition key than the table  |
|  When you need to avoid additional costs|  When the application requires finer throughput control |
| When the application needs strongly consistent index reads  | When the application only requires eventually consistent reads  |
| Same WCU and RCU as main table  | Has own WCU and RCU provisions  |
|  No throttling conditinos |  If writes are throttled then main table is throttled |

## Design patterns

- Can define different entitiy relationships such as one to one, many to one and many to many
- Examples:
  - Store players' game states:
    - One to one modelling or one to many
    - user_id as PK and game_id as SK
  - Players gaming history:
    - One to many modelling
    - user_id as PK, game_timestamp as SK
  - Gaming leaderboard
    - Many to one modelling
    - Global secondary index with game_id as PK and score as SK

## Partitions

- Partitions store DynamoDB table data
- Each partition stores 10 GB of SSD volume
- Not to be confused with partition/hash key
- One partition can store items with multiple partition keys
- A table can have multiple partitions
- Number of partitions depend on table size and provisioned capacity
- Managed internally by DynamoDB
- Provisioned capacity is distributed across table partitions
- Once allocated, cannot be deallocated
- Calculating number of partitions:
  - $P_T = ceil(\frac{\text{RCU}+3\text{WCU}}{3000})$
  - $P_S = ceil(\frac{\text{storage required}}{10\text{GB}})$
  - Number of partitions: $P = \max(P_T,P_s)$

## Scaling

- You can manually scale up and down provisioned capacity as needed
- You can scale down up to 4 times a day
- You gain one scale down for every 4 hours without a scale down, thus you can have a 9 scale down hard limit
- Any increase in partitions on a scale up will not resilt in decrease on scale down

### Autoscaling

- No additional costs, uses AWS application autoscaling service
- Set desired target utilisation, minimum and maximum provisioned capacity

## Storage

- DynamoDB supports item sizes up to 400 KB each
- This includes attribute name and attribute value (JSON doc)
- Options for storing larger items:
  - Compress large attribute values
  - Store large attribtue values in S3

## Operations

- Table cleanup:
  - Options:
    1. Scan + delete => very slow and expensive
    2. Drop table + recreate table => fast, cheap and efficient
- Copying a DynamoDB table:
  - Options:
    1. Use AWS data pipeline (uses EMR)
    2. Create a backup of source table and restore into a new table (can take some time)
    3. Scan + write => write own code (can be expensive)

## DynamoDB accelarator (DAX)

- In memory Caching, microsecond latency by default.
- Sits between DynamoDB and Client application
- SAves costs due to reduced read load on DynamoDB
- Helps prevent hot partitions
- Minimal code changes required to add DAX to your existing dynamoDB app
- Only supports eventual consistency
- Not made for write heavy applications, only for read heavy
- Run inside VPC
- Supports multi AZ
- Secute (encryption at rest with KMS, VPC, IAM, Cloudtrail...)

### Architecture

- DAX has 2 types of caches:
  - Item cache
    - Stores result of index reads
    - Default TTL of 5 mins
    - When cache becomes full, older and less popular items are removed
  - Query cache
    - Stores results of query and scan operations
    - Default TTL of 5 mins

### DAX Operations

- Only for item level operations
- Table level operations must be sent directly to DynamoDB
- Write operations use write-through approach
- Data is first written to DynamoDB adn then to DAX, only considered successful if both write
- You can use write around approach to bypass DAX e.g for writing lots of data - this causes a sync drift
- For reads if DAX has the data (a cache hit) it is simply returned without going through DynamoDB and visa versa for a cache miss
- Strongly consistent reads bypass DAX

## Backups

- Automatically:
  - Encrypted
  - Cataloged
- Easily disvoverable
- Highly scalable
- Backup operations complete in seconds
- Backups are consistent within seconds across thousands of partitions
- No provisioned capacity consumption
- Does not effect table performance or availability
- Backups are preserved regardless of table deletion
- Integrated with AWS backup service
- Periodic backups can be schedulled using Lambda and cloudwatch triggers
- Cannot overwrite an existing table during restore, restores only done to new tables
- To retain original table name delete old table before running the restore
- Use IAM policies for access

### What gets restored

- Table data
- Encryption settitngs (you can change)
- Provisioned RCU/WCU at timestamp that backup is created
- Billing mode

### What does not get restored

- Autoscaling policies
- IAM policies
- CloudWatch metrics and alarms
- Stream and TTL settings
- Tags

### Continuous backups

- Uses PITR
- Restore to any second within the last 35 days
- Prices per GB based on the table size
- 35 day clock is reset on disabling and re enabling PITR
- Restored tables that were a part of global tables will be restored as an independent (non global) table
- Always restores data to a new table
- What cannot be restored:
  - Stream settings
  - TTL options
  - Autoscaling config
  - PITR settings
  - Alarms and tags


## Best practices

- Efficient key design:
  - Partition key should have many unique values
  - Distribute reads and writes uniformly across paritions
  - Store hot and cold data in separate tables
  - Consider all possible query patterns to eliminate use of scans and filters
  - Choose sort key depending on applications needs
  - Use indexes based on applications query patterns (use indexes wisely)
  - Use primary key or LSIs when strong consistency is desired
  - Use GSIs for finer control of throughput or when the application needs to query using a different partition key
  - Use shorter attribute names
- Storing large item attributes:
  - Use compression (zip, tar etc...)
  - Use S3 to store large attributes
  - Split large attributes across multiple items
- Reading:
  - Avoid scan and filter operations (very costly)
  - Use eventual consistency, this will half the cost of the read
- LSIs:
  - Use LSIs sparingly (LSI consume same capacity as table)
  - Project fewer attributes
  - Watch for expanding item collections (10 GB limit - one partition)
- GSIs:
  - Project fewer attributes
  - Can be used for eventually consistent read replicas
