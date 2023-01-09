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

To be completed

## Workspaces

### Notebooks

    To be completed

To be completed

[databricks test link](https://databricks.com/try-databricks)

## Pricing

[pricing info](https://databricks.com/product/pricing)

There are three tiers, **standard**,**premium** and **enterprise**. Each having their own costs assosiated with them.
