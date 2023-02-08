# CDP training

- [CDP training](#cdp-training)
  - [Data Life Cycle](#data-life-cycle)

`CDP` (cloud data platform), is a cloud agnostic tool. (?)

## Data Life Cycle

A data life cycle is the phases of the data that it goes through. We can split data into two types `analytical data` and `transational data`:

| Analytical                  | Transactional |
| --------------------------- | ------------- |
| Optimized to run queries on | updated daily |

The data life cycle runs as follows:

- Data creation - data is sourced from multiple sources and compiled to create data
- Data processing - data is processed and then sent through an ETL pipeline
- Data storage - both data and metadata is stored on storage
- Data usage - usage in applications downstream
- Data archiving - data is removed from active production and no longer processed
- Data destruction - data is destroyed and will be removed from the organisation


