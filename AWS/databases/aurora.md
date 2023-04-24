# Amazon Aurora

- [Amazon Aurora](#amazon-aurora)
  - [Overview](#overview)
  - [Architecture](#architecture)
  - [Aurora parallel query](#aurora-parallel-query)
  - [Aurora serverless](#aurora-serverless)
    - [Data API](#data-api)
  - [Pricing](#pricing)
    - [Aurora serverless pricing](#aurora-serverless-pricing)
  - [Security](#security)
    - [SSL for Aurora serverless](#ssl-for-aurora-serverless)
  - [Parameter groups](#parameter-groups)
    - [Parameter groups in Aurora serverless](#parameter-groups-in-aurora-serverless)
  - [Scaling in Aurora](#scaling-in-aurora)
    - [Autoscaling in Aurora serverless](#autoscaling-in-aurora-serverless)

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

## Pricing

- Aurora costs ~10% of the cost of commercial grade RDBMS solutions
- Pricing model like RDS (pay as you go)
- 20% more expensive than RDS
- When creating an Aurora DB you choose:
  - Instance type
  - Engine type
  - DB instance class
  - Regional or Global DB
- Storage (GB/month)
- I/O (per million requests)
- Data transfers

### Aurora serverless pricing

- No charge when not running
- Database capacity (Aurora capacity unit [ACU] ~ 2GB memory)
- Database storage
- I/O
- Choose a min and max range of ACU's for autoscaling
- Pay per second model

## Security

- Aurora uses the native RDS infrastructure for network, IAM and encryption

### SSL for Aurora serverless

- Same procedure as connecting to RDS / Aurora
- With Aurora serverless can use certificates from ACM
- No need to download RDS SSL/TLS certificates

## Parameter groups

- Work like RDS engines
- In addition also has cluster parameter groups
- The DB parameter group refers to the engine config for the given DB instance
- The cluster parameter group refers to the config for all DB instances within an Aurora DB cluster
- DB parameter groups require a reboot to come into effect
- Cluster parameter groups do not require a reboot to come into effect

### Parameter groups in Aurora serverless

- Only DB cluster parameter groups, this is because there are no permanent DB instances
- Aurora manages capaciy configuration options
- Define your own DB cluster parameter group to define other options
- All parameter changes are applied immediately

## Scaling in Aurora

- We have 3 tpyes of storage in Aurora:
  - Storage:
    - Built in and automatic
    - 10 GB increments up to 64 TB
  - Compute:
    - Instance scaling:
      - Vertical scaling
      - Minimal downtie possible using replica promotion
    - Read scaling:
      - Horizontal scaling
      - Up to 15 read replicas
    - Can set higher value of `max_connections` parameter in teh instance level parameter group
  - Autoscaling:
    - You define scaling policies
    - Horizontal scaling achieved by using min and max replicas and scaling conditinos
    - Condition can be defined using a target metric - e.g CPU utilisation
    - Makes use of Cloudwatch metrics and alarms
    - You define a service-linked IAM role and cooldown period

### Autoscaling in Aurora serverless

- Scales up and down based on the load (CPU utilisation and num of connections)
- After scale up there is a 15 minute cooldown period for subsequent scale down
- After scale down there is a 310 seconds cooldown epriod for subsequent scale down
- There is **no** cooldown period for scaling up
- Scaling cannot happen if:
  - There are long running queries in progress
  - Temporary tables are in use