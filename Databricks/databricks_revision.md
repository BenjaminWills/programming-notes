# INDEX

- [INDEX](#index)
- [Revision](#revision)
  - [SQL create statements](#sql-create-statements)
  - [Databricks job policies](#databricks-job-policies)
  - [Auto loader](#auto-loader)
  - [Jobs / pipelines / queries](#jobs--pipelines--queries)

# Revision

## SQL create statements

- GENERATED key word in table creation:
  - Delta Lake supports generated columns which are a special type of column whose values are automatically generated based on a user-specified function over other columns in the Delta table. e.g

```sql
    CREATE TABLE orders (
        orderId int,
        orderTime timestamp,
        orderdate date GENERATED ALWAYS AS (CAST(orderTime as DATE)),
        units int)
```

## Databricks job policies

- retry policy (specify number of times)

## Auto loader

- supports both directory listing and file notification but COPY INTO only supports directory  listing.
- Ingests data incrementally in 2 ways:
  1. Directory listing - list directory and maintain the state of the file
  2. File notification - use a trigger + queue to store the file notification which can
  later be used to retrieve the file - this is much more scalable than 1.

## Auto loader VS copy into

- Auto loader:
	- Incremental loading from cloud storage as files arrive
	- Structured streaming source identified as `cloudFiles`
	- Supports schema inference and evolution
	- Schema location is used to store schema inferred by AUTO LOADER, so the next time AUTO LOADER runs faster as does not need to infer the schema every single time by trying to use the last known schema
	- When to use instead of COPY INTO:
		- For locations with files in the order of millions or higher
		- It is difficult to reprocess subsets of files, can use COPY INTO in tandem with auto loader to get around this
- Copy into:
	- allows SQL users to idempotently and incrementally load data from cloud object storage into Delta Lake tables
	- When to use instead of auto loader:
		- When the number of files is less than a million
		- Easy to reprocess subsets of files 


## Data lakehouse 

- Compute and storage are `decoupled` in the lakehouse

## Jobs / pipelines / queries

- We can access these via the `control plane`