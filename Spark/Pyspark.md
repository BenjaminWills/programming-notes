https://spark.apache.org/docs/

[Great spark document](https://github.com/cartershanklin/pyspark-cheatsheet/blob/master/cheatsheet.ipynb)

- [pySpark syntax](#pyspark-syntax)
  - [Spark session](#spark-session)
  - [Dataframes](#dataframes)
    - [Creating dataframes](#creating-dataframes)
      - [Defining schema](#defining-schema)
      - [Loading from a file](#loading-from-a-file)
    - [Querying dataframes](#querying-dataframes)
    - [Joining dataframes](#joining-dataframes)
    - [Aggregates](#aggregates)
    - [Window functions](#window-functions)
      - [Ranking functions](#ranking-functions)
      - [Analytic functions](#analytic-functions)
      - [Aggregate functions](#aggregate-functions)
  - [Streaming](#streaming)
  - [UDF](#udf)
  - [IDK](#idk)

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

```python
from pyspark.sql.types import *
fields = [StructField(field_name, StringType(), nullable=True)]
schema = StructType(fields)
spark.createDataFrame(data, schema)
```

This will define a `schema`, to police column data types.

#### Loading from a file

We can [load data](https://spark.apache.org/docs/latest/sql-data-sources-load-save-functions.html) into spark from the follwing formats:

- `CSV` - `spark.read.csv(csv_path, schema)`
- `JSON` - `spark.read.json(json_path, schema)`
- `TEXT` - `spark.read.text(text_path, schema)`
- `Parquet` - `spark.read.load(parquet_path, schema)`

if no `schema` is defined, then it will be inferred from the data by spark.

### Querying dataframes

`Pyspark` uses its [functions library](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html) in place of `WHEN` statements and more.

- Showing a dataframe

```python
df.show()
```

- We can select data from the table by writing

```python
from pyspark.sql import functions as F

df.select(
    column_1,
    df[column_2].alias(name),
    F.Col(column_3).alias(name)
)
```

- Select columns with an `alias`

```python
df.select(
	F.col(column).alias(new_name)
)
```

- Add columns to a dataframe

```python
df = df.withColumn(new_column_name,column_value)
```

This will add the new column to the dataframe

- Update column name

```python
df = df.withColumnRenamed(old_name, new_name)
```

- Drop a column

```python
df = df.drop(column_1,column_2)
```

- Group by

```python
df = df.groupBy(column)
```

- Filter

```python
df = df.filter(column > x)
```

### Joining dataframes

[[SQL Syntax]]

`joins` in `pySpark` are quite easy:

- Join by column name (inner join by default)

```python
df_3 = df_1.join(df_2,column_name)
```

- Join by expression

```python
df_3 = df_1.join(df_2, df_1.column == df_2.column)
```

- Left (outer) join

```python
df_3 = df_1.join(df_2,column_name,"left")
```

- Right (outer) join

```python
df_3 = df_1.join(df_2,column_name,"right")
```

- Full join

```python
df_3 = df_1.join(df_2,column_name,"full")
```

- Cross join

```python
df_2 = df_1.crossjoin(df_1)
```

- Concatenate two `dataframes` (put one atop of the other)

```python
df_3 = df_1.union(df_2)
```

### Aggregates

We can also use `aggregate` functions too, the syntax is the same as `SQL` as we can group by specific columns.

```python
aggregated_df = df.groupBy(column).aggregate()
```

We can also use **multiple** aggregate functions in one single query

```python
multi_aggregated_df = df.\
	groupBy(column).\
		agg(
		{
		column_1:'agg',
		column_2:'agg'
		}
	)
```

### Window functions

`Window functions` operate on a `parition` of rows and return a single value. There are 3 types of `window functions`:

1. Ranking functions
2. Analytic functions
3. Aggregate functions

```python
from pyspark.sql.window import Window
```

#### Ranking functions

- `row_number()`

```python
from pyspark.sql.functions import row_number

window_spec = Window.partitionBy("x").orderBy("y")

df.withColumn("row_number", row_number().over(window_spec))
```

This gives the `partition` row number of each column.

- `rank()`

```python
from pyspark.sql.functions import rank

df.withColumn("rank", rank().over(window_spec))
```

This will give the rank of the row in either ascending or descending order.

- `dense_rank()`

```python
from pyspark.sql.functions import dense_rank

df.withColumn("dense_rank",dense_rank().over(window_spec))
```

This is essentially the same as `rank` but instead of skipping ranks on ties, it just carries on counting.

- `percent_rank`

```python
from pyspark.sql.functions import percent_rank

df.withColumn("percent_rank",percent_rank().over(window_spec))
```

This will squish the rank into the range `0-1`, the meaning of this is dependent on the `orderBy` clause.

- `ntile`

```python
from pyspark.sql.functions import ntile

df.withColumn("ntile",ntile(n).over(window_spec))
```

This function will split the rows in each `partition` into equally sized groups and return the group that each row falls in to.

#### Analytic functions

- `cume_dist()`

```python
from pyspark.sql.functions import cume_dist

df.withColumn("cumulative distribution",cume_dist().over(window_spec))
```

This function will find the cumulative distribution of values within a `partition` - i.e the probability of seeing a value less than or equal to that number within the `partition`.

- `lag`

```python
from pyspark.sql.functions import lag

df.withColumn("lag",lag(column,n).over(window_spec))
```

This function will return an offset value in the partitioned column depending on the value of $n$.

- lead window function

```python
from pyspark.sql.functions import lead

df.withColumn("lead",lead(column,n).over(window_spec))
```

This function is the opposite of lag, just ahead by $n$ rather than behind.

#### Aggregate functions

In the case of `aggregate functions` we need not use an order by, as that does not matter. Thus we must change the definition of the `window_spec`

```python
window_spec = Window.partitionBy(column)
```

Now we can use all the usual aggregate functions like:

- `min`
- `max`
- `avg`
- `sum`

## Streaming

We can handle live data streams with `pySpark`. All we need to do is connect to the `Spark Session` with a `Streaming Session` and then we can process data live.

[pySpark live stream docs](https://spark.apache.org/docs/latest/streaming-programming-guide.html)

## UDF

To define a `user defined function` we use the `@udf` decorator upon function definition

```python

@udf(returnType = StringType()) # Where StringType can be any datatype in general
def capitalise(word:str) -> str:
	try:
		capiatlised_list = [
		letter.upper() for letter
		in list(word)
		]

		capitalised_word = ''.join(capiatlised_list)

		return capitalised_word
	except:
		return None
```

Then we can call this function on the `dataframe`:

```python
df.withColumn("capitalised names", capitalise(col("name")))
```

**DISCLAIMER**: in general we should avoid using `UDF`s as they are not `optimised` for `pySpark`, instead we should opt for built in functions.

## IDK
