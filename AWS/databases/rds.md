# AWS `RDS`

- [AWS `RDS`](#aws-rds)
  - [Overview](#overview)
  - [Why should you use it?](#why-should-you-use-it)
  - [Pricing](#pricing)
  - [Storage types](#storage-types)
  - [Storage auto scaling](#storage-auto-scaling)
  - [Parameter groups](#parameter-groups)
  - [Option groups](#option-groups)
  - [Security](#security)
    - [Network](#network)
    - [IAM](#iam)
      - [IAM authentication](#iam-authentication)
    - [Rotating DB credentials](#rotating-db-credentials)
    - [Encryption in transit](#encryption-in-transit)
    - [RDS encryption at rest](#rds-encryption-at-rest)
    - [RDS backups](#rds-backups)
      - [ Backups vs snapshots](#backups-vs-snapshots)
      - [Restoring from a snapshot](#restoring-from-a-snapshot)
      - [PITR with RDS](#pitr-with-rds)
      - [RDS recovery strategies](#rds-recovery-strategies)
    - [Scaling in RDS](#scaling-in-rds)

## Overview

AWS `Relational database service` provides relational databases that support the following engines:
  
- `PostgreSQL`
- `MySQL`
- `MariaDB`
- `Oracle`
- `Microsoft SQL Server`
- `Aurora`

It is a managed DB service. `RDS` is usually launched within a `VPC` and network access is controlled via security groups

Storage is sorted by `EBS` which can increase volume size with autoscaling

Snapshots can be made across regions.

## Why should you use it?

Removes issues of self managing databases, and allows scalable storage. AWS manages everything i.e hardware, software and the application.

This is why it is preferable to host on `RDS` rather than `EC2`:

- Automated provisioning and OS patching
- Continuous backups
- Monitoring dashboards
- Read replicas for faster read performance
- Multi AZ sertup for disaster recovery
- Maintenance windows for upgrades
- Scaling capacity
- Storage backed by EBS

The downside is that we **CANNOT** ssh into the underlying db instance for `RDS`.

## Pricing

We choose a few things to begin with:

- Instance type (on demand / spot)
- Engine type
- DB instance class (based on memory and CPU):
  - Standard
  - Memory optimized
  - Burstable peformance

`RDS` uses the  pay as you go model.

## Storage types

- General purpose:
  - storage size
  - baseline performance of 3 IOPS/GB
  - volumes below 1 TB can burst to 3000 IOPS
  - use with variable worklaods
  - used for small/medium dbs and dev/test envs
- Provisioned IOPS
  - choose storage size and required IOPS
  - fast and predictable performance
  - up to 32,000 IOPs max per DB instance
  - use with consistent high IOPS are required
  - well suited for write heavy workloads

If an instance runs out of storage, it is not available until more storage is allocated.

## Storage auto scaling

This feature allows storage to dynamically scale up or down based on workload. No downtime during these operations.

## Parameter groups

These are specific to the selected DB engine.

- The default parameter group cannot be edited
- These can be applied to any instances in aws region
- `Dynamic` parameters are applied immediately ( causes downtime)
- `Static` paramaters are applied during a manual reboot

## Option groups

These are optional features offered by the DB engines

- The default option group cannot be edited
- These can be applied to instances in any aws region

## Security

### Network

- Launch within `VPC` to restrict internet access to the `RDS` instance. Usually we would have the application in a public subnet and then the database within a private subnet of this `VPC`.
- Cannot change the `VPC` of the `RDS` instance once it has been created
- `RDS` uses security groups to control access at all levels.

### IAM

- Manage access to `RDS` db resources
- Traditional username and password can be used to log into the databse
- IAM based auth can be used for mySQL and postgreSQL
- Best practices:
  - IAM policies control who can and cannot CRUD db resources
  - Grant least privilege to groups/users/roles
  - Use MFA for sensitive operations
  - Use policy conditions to restrict access to specfic IP addresses

#### IAM authentication

- This works for postgreSQ and mySQL
- Get an authentication token that can be obtained through IAM and `RDS` api calls
- Auth token ahs a lifetime of 15 minutes
- Benefits:
  - Network in/out must be encrypted using SSL
  - IAM to centrally manage users instead of DB
  - Can leverage IAM roles and EC2 instance profiles for easy integration
- To use IAM authentication we msut use a policy that looks like:

```json
{
    "Version":"2012-10-17",
    "Statement":{
        "Effect":"Allow",
        "Action":[
            "rds-db: connect" <---- this is the important bit
        ],
        "Resource": [
            "arn of RDS instance"
        ]
    }
}
```

### Rotating DB credentials

- Use AWS secrets manager to store credentials separately
- Secret manager can automatically rotate secrets
- Can connect to Lambda and automatically replace the key ARN

### Encryption in transit

- Use SSl/TLS connections for encryption in transit

### RDS encryption at rest

- RDS supports [AES-256](https://www.ipswitch.com/blog/use-aes-256-encryption-secure-data) encryption.
- Keys managed through [KMS](https://aws.amazon.com/kms/)
- Can encrypt both master and read replicas
- Encryption must be defined at RDS launch time

### RDS backups

- RDS has automatic backups
- Capures transaction logs in real time
- Enabled by default with a 7-days retention period (0 = disable)
- Can provide backup window and backup retention period
- First backup is a full backup, others are incremental
- Data is stored in an s3 bucket (owned and managed by RDS)
- Multi AZ is recommended to avoid performance issues
- Integrates with AWS backup service

####  Backups vs snapshots

|  backups |  snapshots |
|---|---|
|  automated |  manually triggered |
| incremental  |  full backups |
|  retention period up to 35 days |  retained as long as you wish |
|  good for unexpected failures |  great for known events such as upgrades |
|   | can use lambda functions to take periodic backups  |

#### Restoring from a snapshot

- Can only restore to a new instance
- Cant restore from a shared and encrypted snapshot directly (copy first and then restore from copy)
- Cant restore from another region directly (copy first then restore)
- Can restore from a snapshot of a DB instance from outside a VPC to inside (but not visa versa)
- The restored cluster gets applied with:
  - A new security group
  - Default parameter group
  - Option group that was associated with the snapshot

#### PITR with RDS

- Point in time recovery
- Can only restore to a new instance
- Backup retention period controls the PITR window
- RDS uploads DB transaction logs to S3 every 5 minutes, so PITR may have a >=5 minute lag.

#### RDS recovery strategies

There are 2 key metrics to consider when thinking about disaster recovery:

- RTO (recovery time objective)
  - How long it takes you to recover
  - Expressed in hours
- RPO (recovery point objective)
  - How much data is lost
  - Expressed in data lost per hour

So PITR gives you an RPO of 5 mins. In general the best data recovery strategy is read replicas - but these are expensive. Automated backups can be good for low cost recovery.

### Scaling in RDS

- Vertical scaling
  - Single AZ instances will be unavailable during scale up
  - Multi AZ instances will have minimal downtime
- Horizontal scaling
  - Useful for read heavy workloads
  - Use read replicas
  - Can be used for disaster recovery
- Sharding
  - Horizontal partitioning of databases
  - Maps out a section of the data to a new database
  - Expensive though

### Monitoring in RDS