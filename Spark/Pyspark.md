https://spark.apache.org/docs/

- [pySpark syntax](#pyspark-syntax)
  - [Spark session](#spark-session)


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

