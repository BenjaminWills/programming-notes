# Amazon Aurora

- [Amazon Aurora](#amazon-aurora)
  - [Overview](#overview)
  - [Architecture](#architecture)
  - [Aurora parallel query](#aurora-parallel-query)
  - [Aurora serverless](#aurora-serverless)
    - [Data API](#data-api)


## Overview

AWS Aurora is an RDS based RDBMS, it is MySQL and PostgreSQL compatable. It is 5x faster than MySQL, 3x faster than PostgreSQL and 10% of the cost of commmercial grade RDBMS. They can have up to 15 read replicas at one time. 

`Aurora Serverless` is an automatic self start/stop DB with autoscaling for compute and storage (from 10GB to 64TB).

Only available on RDS, maintains 6 copies across 3 AZs. Backups are stored on S3, there is a fast backtracking option for PITR (point in time recovery). Aurora is about 20% more costly than RDS but is much more efficient.

It is effectively AWS's solution for RDBMS, it is their flagship and thus has all the features and is more expensive as it is bespoke.

## Architecture

- One Aurora instance taskes writes, this is known as the master.
- Compute nodes on replicas do not need to write/replicate
- 6 copies of your data across 3 AZ:
  - Lock-free optimistic algorithm ([quorum model](https://en.wikipedia.org/wiki/Quorum_(distributed_computing)))
  - 4/6 copies needed for writes (data considered durable when 4/6 replicas acknowledge the write)
  - 3/6 copies needed for reads
  - Self healing with peer-to-peer replicatoin, storage is stripped across 100s of volumes
- Data is continuously backed up to S3 in real time using storage nodes

## Aurora parallel query

- Allows for faster analytical queries
- Can run queries in parallel across thousand of storage nodes
- Query processed in the Aurora storage layer
- Only available for MySQL engine and **NOT** PostgreSQL
- Some features are lost when choosing a parallel query cluster:
  - Performance insights
  - Backtrack (PITR) 
  - IAM authentication

## Aurora serverless

- Fully managed autoscaling Aurora configuration
- Supported on MySQL and PostgreSQL
- Auto shutdown when there is no load on the DB:
  - Supports automatic pause
  - Wake up takes 30 seconds
  - no compute charge when not running
- Typically results in a 40% reduction of costs as compared to RDS
- Great for infrequent or unpredictable workloads:
  - No capacity planning needed
  - Can be used for DEVtest environments

### Data API

- Queries can be run via APIs in comparison to a DB connection
- Run queries using:
  - Query editor within RDS console
  - Command line queries
  - AWS SDK
- No need for connection management
- Uses DB credentials stored in AWS secrets manager
- Good for use with Lambda functions
- Lambda needs no VPC config

