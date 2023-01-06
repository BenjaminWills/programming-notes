![[databricks_logo.png]]
**Databricks** is a spark based cloud data platform, that links to the big three cloud providers: **AWS,Azure,** and **GCP**. It is a fully managed service, that allows us to make complex queries on big datasets at high velocity. It provides auto scaling, and spark optimized cloud data processing.

# INDEX

- [INDEX](#index)
- [General Spark Architecture](#general-spark-architecture)

# General Spark Architecture

Generally a `driver program` will send an input to a `cluster manager` that will delegate the tasks to some `worker nodes` that will use *parallell processing* to complete the analysis/task. Usually the `worker nodes` are VM's in your chosen cloud.

Spark is a `query engine`, not a storage engine.

Spark unifies:
- batch processing
- interactive SQL
- real time processing
- machine learning
- deep learning
- graph processing

