# CDP training

- [CDP training](#cdp-training)
  - [Data Life Cycle](#data-life-cycle)
    - [Data creation](#data-creation)
    - [Data processing](#data-processing)
    - [Data storage](#data-storage)
    - [Data usage](#data-usage)
    - [Data archiving](#data-archiving)
    - [Data destruction](#data-destruction)
  - [Data governance](#data-governance)
    - [Metadata](#metadata)
    - [Data quality](#data-quality)
    - [Data controls](#data-controls)
    - [Data lifecyle management](#data-lifecyle-management)
      - [best practices](#best-practices)
  - [Data engineering](#data-engineering)
    - [The data pipeline](#the-data-pipeline)
    - [ETL and ELT](#etl-and-elt)
    - [ETL](#etl)
      - [ELT](#elt)
      - [ETLT](#etlt)
    - [data pipeline good practices](#data-pipeline-good-practices)
    - [Storage](#storage)
      - [Data warehouse](#data-warehouse)
      - [Data lake](#data-lake)
      - [Data lakehouse](#data-lakehouse)
  - [Modern data stack](#modern-data-stack)
    - [Data processing framework](#data-processing-framework)
    - [Data connectors](#data-connectors)
    - [Orchestration tools](#orchestration-tools)
    - [Data quality tools](#data-quality-tools)
    - [Notebooks](#notebooks)
    - [Cloud object stores](#cloud-object-stores)
    - [Storage](#storage-1)
    - [Visualisation](#visualisation)
    - [Data querying](#data-querying)
    - [Message broker](#message-broker)
    - [GitOps](#gitops)

`CDP` (cloud data platform), is a cloud agnostic tool. (?)

## Data Life Cycle

A data life cycle is the phases of the data that it goes through. We can split data into two types `analytical data` and `transational data`:

| Analytical                  | Transactional |
| --------------------------- | ------------- |
| Optimized to run queries on | updated often |

The data life cycle runs as follows:

- Data creation - data is sourced from multiple sources and compiled to create data
  - Data processing - data is processed and then sent through an ETL pipeline
    - Data storage - both data and metadata is stored on storage
      - Data usage - usage in applications downstream
        - Data archiving - data is removed from active production and no longer processed
          - Data destruction - data is destroyed and will be removed from the organisation

### Data creation

The process of creating data includes `acquisition`, `data entry` and `data capture`.

### Data processing

The process of `transforming` this data for use, usually in an ETL pipeline. note that this does **NOT** gain any benefit or insight from the data, it simply allows the data to be placed in a `consistent` and `understandable` format.

This is when data goes through processes such as:

- `cleaning`
- `integration`
- `scrubbing`
- `ETL`

### Data storage

- Before we store the data we need to consider the `structure` the data i.e `structured`,`semi-structured` and `unstructured data.
- Next we need to consider the `data protection` i.e data `encryption` at `rest` or `in transit`
- `Data backups` are also essential, to maintain `resilience` and `availability` of the data
- We have a few types of `storage`:
  - `hot` storage is easy and quick to access, and is frequently accessed.
  - `cold` storage is slower to access and is not accessed as much, usually these storage options are cheaper than `hot` storage options.

### Data usage

This is when the data is used `upstream` in various applications. We have a few levels of usage (in ascending order of processing power):

1. Reporting - using the data to find out `what happened`
2. Analysis - using the data to find out `why did it happen`
3. Diagnostig - using the data to find out `what is happening now`
4. Predictive analysis - using the data to find out `what is likely to happen`
5. Perscriptive analysis - using the data to find out `what should we do`

### Data archiving

The data is removed from all active uage, and is moved to `cold` storage. This is for a few reasons:

- `Compliance` - dependent on the companies compliance rules
- `cost savings` - `cold` storage is much cheaper than `hot` storage
- `strategic business purposes` - viewing historical data to compare and gain insights on pesent data

for example `Netflix` analysed their films usage, and moved the films to `cold` storage. This allowed them to save `$124.1k` with minimal effort.

### Data destruction

This is the final stage of the life cycle, data is `purged`. This is to save `money` and `storage space`. Data will become redundant after a certain amount of time.

## Data governance

Data governance is focused on three things:

1. People - `people` and `groups` that are assigned policies
2. Policies - `policies` allow elements of `access` to objects
3. Tools and technologies - these are the objects that `policies` allow `access` to

The main aim is to control access to data, which in turn enhances `compliance` and `data security`. It essentially watches over the `data life cycle`.

We have a few stages of data governance after `ingesting` data from various sources:

1. Data discovery and curation:
   - profiling
   - classification
   - lineage
   - prepare
   - quality
2. Data management:
   - metadata - metadata around the table, e.g last modified date
   - catalogue - an organised catalogue of data
   - master data manager - `master data` is all the data that belongs to one person, so say we have two bank accounts, it would be the combined copy of them
   - [archive](#data-archiving)
   - quality
3. Policies:
   - physical
   - encryption
   - access
   - audit - see who's done what

We can then use these stages to create users and user groups control access to specific elements.

More in depth on the `data catalogue`, it is an `inventory` of **all** the datasets that the `enterprise` has.

### Metadata

Metadata generally can be catagorised into 2 major categories:

1. `Business` metadata describes the meaning of data in the business sense.
2. `Technical` metadata represents the tecnical aspects of the data, including data types, length, lineage, results from data profiling

A lot of organisations tend to `standardise` their metadata to keep it consistent accross the databases.

### Data quality

Helps to identify if the data that we have conforms to the `organisation's` standards, i.e `non-null` constraints on `SQL` columns. We can enforce data quality.

### Data controls

This is a way of controlling how well the `data quality` standards have been followed, we put systems in place to measure `conformance` by:

- setting `thresholds` and `building reports`
- establish `service level agreements` for data controls and `define processes` to repond to issues

We can apply these in diferent levels of `granularity`.

### Data lifecyle management

This is simply the `approach` to managing and implementing the whole `life cycle` of data, `DLM` has 3 main goals:

- `confidentiality` - the data can only be accessed by those within the organisation
- `availability` - the data can be accessed when it is needed
- `integrity` - the data is consistent for all users

These goals allow us to gain control of our organisations data, which allows us to gain deeper insights as we are not wasting energy on organising our files all of the time. As well as the following benefits:

- `data usability`
- `compliance and governance`
- `controlling costs`
- `process improvement`

#### best practices

1. create and define data types
2. use consistent naming scheme
3. save new data through a disaster recovery plan
4. consider implmenting an eneterpise file sync - to allow accessibility of data
5. archive data if it is seldom used
6. clear up space by destroying data

## Data engineering

Data engineering is the practice of building systems to enable collection, cleaning and usage of data. Data engineers will create `data pipelines` that take in `raw` unprocessed data, `clean` it and then return `cleaned` data that can also have `aggregations` depending on the use case.

`ETL` is the biggest tool in data engineering and is usually what constitutes a data pipeline:

- `Extract` - extract the data from the data lake or warehouse - or data source
- `Transform` - clean the raw data e.g make all column formatting consistent, and collect data into useful groups
- `Load` - load the data in upstream applications

### The data pipeline

We have 3 types of data pipelines:

- `Batch processing` - use cases are when data is periodically collected, transformed and loaded to a cloud data warehouse
- `Streaming` - the pipeline will ingest a constant sequence of data, and will progressively update metrics, reports and summary statistics
- `Hybrid` - batch and stream processing, this combines the power of long running batch models with streaming analytics, data is still fresh and inconsitencies are removed using batch processing. Split the stream into batches

A data pipeline has a few components:

- dataflow - how will data move from one place to another
- storage - where will the different stages of the data live
- processing - data processing consists of all transformation processes
- workflow - the process sequences, and its dependencies in the pipeline
- monitoring - monitoring of pipeline health and data quality

### ETL and ELT

### ETL

ETL is the most widley used data pipeline pattern.

pros:

- suited for data warehouse workloads
- works well when complex data transformations are required
- results in one copy, no redundancies
- if all sources are not ready at the same time, ETL can ensure that the transformation will only happen once all the data is available

cons:

- Highly time consuming and has high latency
- high compute power required for complex transformations
- due to 1 and 2 it is not useful for big data
- often have vendor locking

#### ELT

ELT is preferred more frequently now to ETL as it is mcuh faster to extract and load first, and then transform.

pros:

- suitable data lake implementations
- decreased latency as data is available much sooner for processing
- all kinda of data are able to be stored

cons:

- increased duplication of data in different layers
- data quality suffers, data is exposed without deduplication and cleansing
- often ends up creating a data swamp
- people often forget to transform the data

#### ETLT

This is a hybrid of `ETL` and `ELT`

pros:

- smaller transformation, data cleaning and filtration done whilst extracting data
- very practical pipeline, solved privacy through masking
- data swamp potential is decreased due to intial T step
- enables lakehouse architecture

cons:

- limited by processsing power and latency
- still generates 2 copies of data

### data pipeline good practices

1. Determine the goal
   - what are our objectives for the `pipeline`?
   - how can we measure the performance of the `pipeline`?

2. Choose data sources
   - what are the potential `sources` of the data?
   - what `format` will the data come in?

3. Determine data ingestion strategy
   - what communication layer will collect data (e.g HTTP,MQTT,gRPC)?
   - will we use `third party integration tools` to ingest the data?

4. Design data processing plan
   - What data processing strategies will we use (`ETL`,`ELT`)?
   - are we going to be `enriching` the data with attributes?

5. Set up storage output
   - are we going to use `big data` stores, like `warehouses` or `lakes`?
   - would the data be on the `cloud` or `on premesis`?

6. Plan the data workflow
   - what downstream jobs are `dependent` on an upstream job?
   - are there jobs that can run in `parralel`?
  
7. Implement a data monitoring and governance framework
   - what needs to be `monitored`?
   - how do we ensure `data security`?

8. Plan data consumption layer
   - whats the best way to `utilise` our data?
   - do we have all the data we need for our intended use case?

### Storage

#### Data warehouse

A `data warehouse` can only store structured data, they provide `storage` and `compute` to be able to gain insights from data within it. They support `ACID` transactions

#### Data lake

These are data stores that can store both `unstructured` and `structured` data. This is very powerful as it allows us to run both `BI analytics` and `ML/AI` workflows. AWS' `S3` is an example of a data lake. They support `ACID` transactions and `time travel`.

We must be careful not to make this into a `data swamp` which is a data lake that is full of redundant data.

#### Data lakehouse

Integrates a `lakehouse` into a `warehouse`, allows for `compute` and `storage` to work together, i.e we get `compute` AND we get storage of **all** kinds of data.

providers such as `Big query`, `Snowflake` and `Redshift`.

## Modern data stack

### Data processing framework

A `framework` is a tool that is a tool that manages the transformation of data in multiple steps. Usually these steps are visually represented in a directed acyclic graph (`DAG` - which essentially just defines the order of operations). We call these steps tasks, the pipeline is controlled by an `orchestrator`, which is composed into 3 components:

- a scheduler
- an executor
- a metadata store

Examples of these frameworks are `map reduce` and `apache spark`. These usually handle the data in batches.

### Data connectors

When making a pipeline we need connections to connect the endpoints. These can be in the form of `API`'s or `UI`'s for example. It bundles up credentials and authentication in one package.

There are `cloud native` tools and `3rd party` tools that allow you to connect to the cloud/

### Orchestration tools

These are applications that can automatically manage the `configuration`, `coordination`, `integration` and `data management` of our pipeline, these are applications such as `Apache Airflow`.

### Data quality tools

Data quality tools are technologies for `identifying`, `understanding` and `correcitng flaws` to support data governance. Critical measures of quality:

- `Integrity`
- `Validity`
- `Accuracy`
- `Uniqueness`
- `Consistency`
- `Timeliness`
- `Freshness`
- `Completeness`

These are tools such as `ORACLE`.

### Notebooks

Modern vendors such as `Databricks` and `jupyter` use a notebook environment to run data engineering stacks and pipelines. These can support multiple languages including `markdown`. They are cell based files.

### Cloud object stores

This is a format for storing data in the cloud.

We can have 3 types of storage:

- `BLOCK`: splitting data into fixed size blocks
- `FILE`: data is stored in a file hierarchy
- `OBJECT`: a container for objects

### Storage

How do we query and infer the data? We can use a few technologies for this, three of interest are:

1. Search engines, they excel at text queries (`ELASTICSEARCH`)
2. Document stores (`NOSQL`), provide better schema adaptability (`MONGODB`)
3. Columnar stores, such as `SQL` queries (`REDSHIFT`)

### Visualisation

Data visualisation is a possible endpoint of a pipeline. Many cloud providers have tools to do this like `QUICKSIGHT` and `DATABRICKS`, we can also use propritary applications such as `TABLEAU` or `POWER BI`.

### Data querying

We now need to query the data, we can do his with `engines` like `SQL`, `NOSQL` and `Athena`. These engines are dependent on the type of [storage](#storage-1) that the data is kept in.

### Message broker

These take the information from the sender, format it, and then send it to hte outputs. Usually these are used for components of applications communicating with eachother. There are 2 basic messaging styles:

1. Point to point messages - these are used for `one to one` relationships, each message in the queue is only sent to one recipient and consumed only once
2. Publish/subscribe messages - the producer of each message will publish it to a topic, and then the consumer will read from the specific topic

### GitOps

This is using git for devops. it uses `IaC`, `MRs` and `CI/CS`
