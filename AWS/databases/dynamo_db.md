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
