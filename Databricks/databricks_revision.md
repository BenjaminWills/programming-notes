# INDEX

- [INDEX](#index)
- [Revision](#revision)
  - [SQL create statements](#sql-create-statements)
  - [Databricks job policies](#databricks-job-policies)
  - [Auto loader](#auto-loader)
  - [ Auto loader VS copy into](#auto-loader-vs-copy-into)
  - [ Data lakehouse](#data-lakehouse)
  - [Jobs / pipelines / queries](#jobs--pipelines--queries)
  - [Streaming](#streaming)

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

##  Auto loader VS copy into

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

##  Data lakehouse

- Compute and storage are `decoupled` in the lakehouse
- Does not support `stored procedures` (thats a `unity` thing)

## Jobs / pipelines / queries

- We can access these via the `control plane`
- Anytime a table is created using the LOCATION keyword it is considered an external table, below is the current syntax.

```sql
CREATE TABLE table_name ( column column_data_type…) 
USING format LOCATION "dbfs:/" 
```

where format $\in \{\text{DELTA}, \text{JSON}, \text{CSV}, \text{PARQUET}, \text{TEXT}\}$

- To make a `delta table` (a table that supports time travel) use the `USING DELTA` key word

```sql
CREATE TABLE table_name ( column column_data_type…) 
USING DELTA LOCATION "dbfs:/" 
```

- `temporary views` are lost once a notebook is detatched and reattatched

There are two types of `temporary views` that can be created, Session scoped and Global

- A `local/session scoped` `temporary view is` only available with a spark session, so another notebook in the same cluster can not access it. if a notebook is detached and reattached local `temporary view` is lost.

- A `global` `temporary view` is available to all the notebooks in the cluster, if a cluster restarts global `temporary view` is lost.

- When creating `UDF`s the syntax follows:

```sql
    CREATE FUNCTION udf_convert(temp DOUBLE, measure STRING)
    RETURNS DOUBLE
    RETURN CASE WHEN measure == ‘F’ then (temp * 9/5) + 32
            ELSE (temp – 33 ) * 5/9
           END
```

- When selecting from a `struct type` in `SQL` when there are multiple entries in a column, it will combine the entries into a `list` when calling with `.` notation, i.e if we have a table with a column that contains:
  
```json
[{"number":12},{"number":14}]
```

if we query:

```sql
SELECT column.number as number
FROM table;
```

we would get:

```python
[12,14]
```

## Streaming

- To create a `view` ontop of a `stream` in `sparkSQL`

```python
Spark.readStream.table("sales").createOrReplaceTempView("streaming_vw") 
```

Here the `readStream` keyword is important.

- For fault tolerance in structured streaming we have:
  - checkpointing - this records the offset range of data being processed at each trigger interval
  - idempotent sinks - this ensures that no duplicates are added to the table in the streaming process


