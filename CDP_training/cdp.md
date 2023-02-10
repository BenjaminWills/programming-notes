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
