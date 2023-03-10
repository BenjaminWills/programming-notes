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
  - [Unity catalogue](#unity-catalogue)
  - [Medallion architecture / Multi-Hop architecture](#medallion-architecture--multi-hop-architecture)
  - [Delta lakehouse](#delta-lakehouse)
  - [repositories](#repositories)
  - [Delta live tables](#delta-live-tables)
  - [Cluster pools](#cluster-pools)
  - [UI functionality](#ui-functionality)

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

- supports both directory listing and file notification but COPY INTO only supports directory listing.
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
- `delta lake` is an open source storage layer ontop of the lakehouse

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

- `temporary views` are lost once a notebook is detached and reattached

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
[{ "number": 12 }, { "number": 14 }]
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

- `CREATE STREAMING LIVE TABLE` is used when working with Streaming data sources and Incremental data

## Unity catalogue

- `SELECT` is not a privilege granted by unity
- Change table owner with `ALTER TABLE table OWNER owner`
- `Access` is granted via the `data explorer`

## Medallion architecture / Multi-Hop architecture

- This is a design pattern used to logically organise data in a `lake house` as it flows from `unclean` to `clean` data.
  - `Bronze`:
    - This is the `raw` ingestion stage in which all necessary data is loaded in and placed in `dataframes`
    - provides efficient `storage` and `querying` of full unprocessed history of data
    - No `schema` is applied at this layer
  - `Silver`:
    - This is the `cleaning` stage in which data is `cleaned`, `filtered` and `augmented` to be analysed in the `gold` stage
    - Reduces data storage `complexity`
    - Optimises `ETL` throughput and `query` performance
    - Eliminates `duplicate` records
    - production `schema` enforced
    - Data quality checks / quarantine corrupt data
  - `Gold`:
    - This is the stage at which we calculate `business level aggregates` and deliver `clean` data to `upstream` applications
    - Power `ML` applications, `reporting`, `dashboards` and `ad hoc analytics`

## Delta lakehouse

A lakehouse has the following key features:

- Transaction support: In an enterprise lakehouse many data pipelines will often be reading and writing data concurrently. Support for ACID transactions ensures consistency as multiple parties concurrently read or write data, typically using SQL.

- Schema enforcement and governance: The Lakehouse should have a way to support schema enforcement and evolution, supporting DW schema architectures such as star/snowflake-schemas. The system should be able to reason about data integrity, and it should have robust governance and auditing mechanisms.

- BI support: Lakehouses enable using BI tools directly on the source data. This reduces staleness and improves recency, reduces latency, and lowers the cost of having to operationalize two copies of the data in both a data lake and a warehouse.

- Storage is decoupled from compute: In practice this means storage and compute use separate clusters, thus these systems are able to scale to many more concurrent users and larger data sizes. Some modern data warehouses also have this property.

- Openness: The storage formats they use are open and standardized, such as Parquet, and they provide an API so a variety of tools and engines, including machine learning and Python/R libraries, can efficiently access the data directly.

- Support for diverse data types ranging from unstructured to structured data: The lakehouse can be used to store, refine, analyze, and access data types needed for many new data applications, including images, video, audio, semi-structured data, and text.

- Support for diverse workloads: including data science, machine learning, and SQL and analytics. Multiple tools might be needed to support all these workloads but they all rely on the same data repository.

- End-to-end streaming: Real-time reports are the norm in many enterprises. Support for streaming eliminates the need for separate systems dedicated to serving real-time data applications.

- How is it different than a normal data warehouse?

  - Open source
  - Builds up on standard data format
  - Optimized for cloud object storage
  - Built for scalable metadata handling

- Delta lake is not

  - Proprietary technology
  - Storage format
  - Storage medium
  - Database service or data warehouse

- All tables created in `Databricks` are `delta` by default
- Delta tables are stored in the following way:
  - data is broken down into one or many parquet files
  - log files are broken down into one or many JSON files
  - each transaction creates new data and log files

## repositories

- Can commit or push code to git repositories

## Delta live tables

- Delta live tables address and fix a few problems when it comes to ETL

  - Complexities of ETL
    - Hard to build and maintain dependencies
    - Difficult to switch between batch and stream
  - Data quality and governance
    - Difficult to monitor and enforce data quality
    - Impossible to trace data lineage
  - Difficult pipeline operations
    - Poor observability at granular data level
    - Error handling and recovery is laborious

- Tables are stored by default

```shell
dbfs:/user/hive/warehouse
```

- When dropping a delta table
  - drops table from the meta store
  - keeps metadata (delta log, history)
  - keeps data in storage
- Can use
```sql
DESCRIBE HISTORY table;
```
to show the history of operations on the `table`.

- Only 2 types of `constraints` are supported:
	- Not Null - no null values in specified columns
	- Check Constraints - boolean checks on each row

- Types of table `cloning`:
	- `Shallow cloning` - these are quick, and allow you to test queries on a copy of the table that would not effect the table
	- `Deep cloning` - fully copies data and metadata from source to target, this is an incremental operation, hence can sync changes in the source table to the target table
## Cluster pools

- Allow us to reserve VM's, when a new job cluster is created VMs are grabbed from the pool

## UI functionality

- **Control Plane**: stored in `Databricks` cloud account
  - The control plane includes backend services that `Databricks` manages
- **Data Plane**: Stored in Customer cloud account
  - This is where your cloud data resides

## Clusters

- `Standard mode` clusters are used for single users only
- `High concurrency` clusters are used for multiple users, they are a cloud usage