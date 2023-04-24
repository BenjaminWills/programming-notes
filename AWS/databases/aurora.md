# Amazon Aurora

## Overview

AWS Aurora is an RDS based RDBMS, it is MySQL and PostgreSQL compatable. It is 5x faster than MySQL, 3x faster than PostgreSQL and 10% of the cost of commmercial grade RDBMS. They can have up to 15 read replicas at one time. 

`Aurora Serverless` is an automatic self start/stop DB with autoscaling for compute and storage (from 10GB to 64TB).

Only available on RDS, maintains 6 copies across 3 AZs. Backups are stored on S3, there is a fast backtracking option for PITR (point in time recovery). Aurora is about 20% more costly than RDS but is much more efficient.

It is effectively AWS's solution for RDBMS, it is their flagship and thus has all the features and is more expensive as it is bespoke.

## Architecture
