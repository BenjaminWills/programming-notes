[[Databricks]]

# Index

- [Index](#index)
- [Magic commands](#magic-commands)
- [DBSQL](#dbsql)
  - [Time travel](#time-travel)
    - [Restoring tables](#restoring-tables)
  - [Compaction](#compaction)
  - [Cleaning workspace](#cleaning-workspace)
  - [Querying from files](#querying-from-files)
  - [Accessing nested data structures](#accessing-nested-data-structures)
  - [Structured Streaming](#structured-streaming)

# Magic commands

To define the Cell language (that is other than the deafult language) we use a `magic decorator`

```sh
%md <- markdown
%sql <- SQL
%r <- R
%python <- Python
%scala <- Scala
```

We can also use the `%run <directory>` magic command to run another notebook from this notebook.

The `%fs` magic command (`filesystem`) allows us to run file system commands.

# DBSQL

## Time travel

We can use `time travel` to return to previous instances of tables. Using either `time` or the `version number`.

```SQL
SELECT *
FROM MY_TABLE
TIMESTAMP AS OF "YYY-MM-DD"
```

Or alternatively

```SQL
SELECT *
FROM MY_TABLE
VERSION AS OF "YYY-MM-DD"
```

### Restoring tables

`Time travel` gives us the ability to `restore tables` by writing

```SQL
RESTORE MY_TABLE TO TIMESTAMP/VERSION AS OF ...
```

## Compaction

We can compact small files using the `Optimise command` to improve table performance.

```SQL
OPTIMIZE MY_TABLE
ZORDER BY column
```

`ZORDER` corresponds to an index to partition by essentially, so the compiled files will be grouped.

## Cleaning workspace

We can use the `VACUUM` command to remove files that have not been edited in x amount of days.

```SQL
VACUUM MY_TABLE [RETENTION PERIOD]
```

The default retention period is `7 days`.

## Querying from files

We can extract data directly from files using `sparkSQL`. We can query a `JSON` file by prefixing our query with a `json.` to let spark know what we want to do.

```SQL
SELECT *
FROM json.`path`;
```

The same logic applies to `csv.` files.

Alternatively we can use the `USING` syntax to avoid schema inference.

```SQL
CREATE TABLE table_name
	(#TABLE COLUMNS AND TYPES)
USING CSV
OPTIONS (
	header = "true",
	delimiter = ";"
)
LOCATION `location of file`
```

## Accessing nested data structures

Suppose that we have a `CSV` file that has a column that is a `JSON` that contains someones address. So the column looks something like this:
| id|address |
|---|---|
| 1|{street:"x",city:"y",country:"z"} |

We can access this in `sparkSQL` with the following query

```SQL
SELECT id, address:street as street,address:city as city,address:country as country
FROM table;
```

This would return:
| id| street| city|country |
|---|---|---|---|
|1 |x|y |z |

we can also use the built in `from_json` function and the `schema_of_json` function to insert a `JSON` into a table column with a `struct` data type.

```SQL
SELECT x, from_json(
	path_to_json,
	schema_of_json(insert_example_row_in_here)
	)
FROM table;
```

The `struct` datatype makes it possible to interact with a `nested object`. We can access the elements of a `struct` type column by using `.` notation. Further we can use the `*` operator to `flatten` `JSON` columns into multiple columns, abstracting one layer at a time.

```SQL
SELECT column.*
FROM table;
```

## Structured streaming

A `data stream` is any data source that will grow over time. We use `pySpark` to create a streaming df:

```python
streamDF = spark.readStream.table("input_table")
```

Then to write the stream to an output table we write

```python 
streamDF.writeStream.\
	trigger(processingTime="2 minutes").\
		option("checkpointLocation","path").\
			table("output_table")
```
