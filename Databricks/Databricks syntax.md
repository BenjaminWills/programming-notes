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
