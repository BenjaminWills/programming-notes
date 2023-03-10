![[databricks_logo.png]]
**Databricks** is a spark based cloud data platform, that links to the big three cloud providers: **AWS,Azure,** and **GCP**. It is a fully managed service, that allows us to make complex queries on big datasets at high velocity. It provides auto scaling, and spark optimized cloud data processing.

# INDEX

- [INDEX](#index)
- [General Spark Architecture](#general-spark-architecture)
- [Databricks](#databricks)
	- [Integration with AWS](#integration-with-aws)
	- [Clusters](#clusters)
	- [Workspaces](#workspaces)
		- [Notebooks](#notebooks)
			- [version control](#version-control)
			- [Adding code](#adding-code)
		- [Libraries](#libraries)
	- [Delta Lake](#delta-lake)
	- [Hive metastore](#hive-metastore)
	- [Jobs](#jobs)
	- [Data governance](#data-governance)
		- [Unity catalogue](#unity-catalogue)
	- [Pricing](#pricing)

# General Spark Architecture

Generally a `driver program` will send an input to a `cluster manager` that will delegate the tasks to some `worker nodes` that will use _parallell processing_ to complete the analysis/task. Usually the `worker nodes` are VM's in your chosen cloud.

Spark is a `query engine`, not a storage engine.

Spark unifies:

- batch processing
- interactive SQL
- real time processing
- machine learning
- deep learning
- graph processing

# Databricks

## Integration with AWS

Databricks spark clusters use **EC2** instances to run on the backend, and can be given read/write access to **S3** buckets.

## Clusters

A cluster is a set of nodes that work together. It consists of a `driver` node and many `worker nodes`. We can use `access control` on clusters. `Photon accelaration` can be added to speed up `SQL` queries.

We can provide the amount of time required for a cluster to `auto deactivate` in order to cut down on costs. We can also choose `auto scaling` to allow for performance to always meet demand.

When making a cluster `Databricks` shows how many `DBU`'s (databricks unit) it will use an hour, this gives the user an idea of the `pricing` of the cluster.

These clusters are made up of `virtual machines` from the respective cloud provider.

## Workspaces

[databricks test link](https://databricks.com/try-databricks)

A `workspace` is the `GUI` for databricks.

### Notebooks

[[Databricks syntax]]
When creating a `notebook` data must be uploaded, so that it can be referenced by cells inside of the `notebook`, these are then interpereted as tables via a `GUI` and can be queried using `SQL`.

`Databricks notebooks` can use **any language** as default, `Python`,`Scala`,`SQL` and `R`. We can use more than one language in one notebook.

Every notebook comes with the `dbutils` library, that allows for interaction with databricks direclty from `python`.

A `notebook` can be viewed as a **[job](#jobs)** that can be **scheduled**, and triggered by some cloud services too.

Note that we _cannot_ run any cells without a `cluster`, all data that is uploaded to a `notebook` goes to a `cluster` that the `notebook` runs on.

#### version control

We can access our notebooks previous states by clicking on the `last edit` button, then we can choose from the `previous saves`. We can also link `GIT`.

We can set up a `GIT` connection in user settings, using a `personal access token` from `github`.

#### Adding code

We can clone from `github` or other git options easily using databricks when we add a library.

### Libraries

We can use `python/scala/r` libraries that aren't baked into `Databricks` by _default_. We can install them quite easily using the library function.

**Warning**: we need to install each package on every node within our clusters, so this can be an **expensive** time **consuming** process.

## Delta Lake

This is `spark's` answer to the `RDBMS` functionality of usual `SQL` - and to their competitors like `AWS Athena` and `Snowflake`. This allows usage of `CRUD` operations. The `Delta Lake` stores files as `parquet` files, which is `Spark's` alternative to `pickling` files.

## Hive metastore

The `hive metastore` is a repository of `metadata` - each `Databricks` workspace has one. This `metastore` is stored in the path `dbfs:/user/hive/warehouse`, we can specify where in which this metadata is stored however by writing

```SQL
CREATE SCHEMA myschema
LOCATION 'dbfs:/custom/path/db_y.db';

USE db_y;
CREATE TABLE table1;
```

## Jobs

A `job` is simply a `databricks notebook` that we would like to run on a schedule or be activated by some cloud function. This is wildly useful for pipeline automation, e.g ETL pipelines. Usually we have 3 `tasks` in a `job`:

1. Extract the data
2. Transform the data
3. Load the data

These tasks can be interdependent, so that they do not execute if a condition is not met by another job.

We can set `email` notifications to notify on an event relating to a job - further we can use `IAM` to control access to the job.

## Data governance

We can use `SQL` on `Databricks` to control access to objects.

```SQL
GRANT <privilege> (like select)
ON <object> object_name (like table)
TO user_group
```

The permissible object types are:

| Object   | Scope                                         |
| -------- | --------------------------------------------- |
| CATALOG  | control access to the entire catalog          |
| SCHEMA   | control access to a database                  |
| TABLE    | control access to a managed or external table |
| VIEW     | control access to SQL views                   |
| FUNCTION | control access to a named function            |
| ANY FILE | control access to the underlying file system  |

the available privileges are:

| Privilege      | Ability                                             |
| -------------- | --------------------------------------------------- |
| SELECT         | read access to an object                            |
| MODIFY         | add, delete and modify data to or from an object    |
| CREATE         | create an object                                    |
| READ_METADATA  | view an object and it's metadata                    |
| USAGE          | required to perform any action on a database object |
| ALL PRIVILEGES | gives all privileges                                |

We can show permissions of an object by using the

```SQL
SHOW GRANTS object
```

`SQL` command.

### Unity catalogue

`Databricks` uses the `unity catalogue` to manage `data governance.`
![[Unity_catalogue.jpg]]
there are 3 types of identities in the `unity catalogue`:

1. **Users** - identified by email addresses
2. **Service Principles** - identified by application ID's
3. **Groups** - grouping of `users` and `service principles`

The syntax for using `unity` is:

```SQL
GRANT <privilege> ON <securable_object> TO principal
```

## Pricing

[pricing info](https://databricks.com/product/pricing)

There are three tiers, **standard**,**premium** and **enterprise**. Each having their own costs associated with them.
