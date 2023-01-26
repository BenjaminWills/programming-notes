https://spark.apache.org/docs/

- [pySpark syntax](#pyspark-syntax)
  - [Spark session](#spark-session)
  - [Dataframes](#dataframes)
    - [Creating dataframes](#creating-dataframes)
      - [Defining schema](#defining-schema)


This is the `spark's` `python` API, it allows us to run spark operations directly from a python script.

# pySpark syntax

PySpark is basically a wrapper around spark sql for python, so we can use `CRUD` operations.

## Spark session

All spark dataframes are held in a `spark session`. A spark session can be created easily:

```python
from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("Python Spark SQL basic example") \
    .config("spark.some.config.option", "some-value") \
    .getOrCreate()
```

## Dataframes

Spark has **RDD**'s (Resilient Distributed Dataframes) that contain the data and distribute it among the slave nodes when the cluster is run.

### Creating dataframes

When creating dataframes we have the option to define a `schema` or to infer one. When loading in data from `CSV`'s its easy to infer schemas, but when it comes to `Parquet` or `JSON` we may need to specify it.

#### Defining schema

We need to import `datatypes` to define a schema ([datatypes](https://spark.apache.org/docs/latest/sql-ref-datatypes.html))