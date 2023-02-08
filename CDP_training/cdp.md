# CDP training

- [CDP training](#cdp-training)
  - [Data Life Cycle](#data-life-cycle)
    - [Data creation](#data-creation)
    - [Data processing](#data-processing)
    - [Data storage](#data-storage)

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

