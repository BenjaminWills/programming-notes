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
      - [Adding code](#adding-code)
    - [Libraries](#libraries)
  - [Jobs](#jobs)
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

To define the Cell language (that is other than the deafult language) we use a `magic decorator`

```sh
%md <- markdown
%sql <- SQL
%r <- R
%python <- Python
%scala <- Scala
```

We can also use the `%run <directory>` magic command to run another notebook from this notebook.

A `notebook` can be viewed as a **[job](#jobs)** that can be **scheduled**, and triggered by some cloud services too.

Note that we _cannot_ run any cells without a `cluster`, all data that is uploaded to a `notebook` goes to a `cluster` that the `notebook` runs on.

#### Adding code

We can clone from `github` or other git options easily using databricks when we add a library.

### Libraries

We can use `python/scala/r` libraries that aren't baked into `Databricks` by _default_. We can install them quite easily using the library function.

**Warning**: we need to install each package on every node within our clusters, so this can be an **expensive** time **consuming** process.

## Jobs

A `job` is simply a databricks `notebook` that we would like to run on a schedule or be activated by some cloud function. This is wildly useful for pipeline automation, e.g ETL pipelines.

## Pricing

[pricing info](https://databricks.com/product/pricing)

There are three tiers, **standard**,**premium** and **enterprise**. Each having their own costs assosiated with them.
