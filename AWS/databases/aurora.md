# Amazon Aurora

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

