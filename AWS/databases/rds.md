# AWS `RDS`

- [AWS `RDS`](#aws-rds)
  - [Overview](#overview)
  - [Why should you use it?](#why-should-you-use-it)
  - [Pricing](#pricing)
  - [Storage types](#storage-types)
  - [Storage auto scaling](#storage-auto-scaling)
  - [Parameter groups](#parameter-groups)
  - [Option groups](#option-groups)


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