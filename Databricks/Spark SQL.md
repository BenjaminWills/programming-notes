- [Spark SQL engine](#spark-sql-engine)
  - [Syntax](#syntax)
    - [DDL](#ddl)
  - [Delta Lake](#delta-lake)

# Spark SQL engine

This is the `SQL` variant that is used on [[Databricks]]. It is the most performant of the programming language options as it interracts directly with `Spark`.

Note that `spark SQL` is not like a traditional `RDBMS` as it is `schema on read` meaning that the schema is inferred upon reading of an external file. This means that `spark` doesn't have to download the file, it just has to read through the file.

## Syntax

The syntax is very similar to normal `SQL` in that queries such as

```sql
SELECT *
FROM table
WHERE condition = value;
```

Most functions are supported. There is no `database catalog` as `Spark` is not a `RDBMS`, it uses a `meta store` to store metadata about tables, such as column value types. It also does not support `referential integrity` which we would usually use `foreign` and `primary keys` for.

### DDL

`Data Definition Language` is supported by `sparkSQL` , that is to say: we can run `CREATE`,`DROP`,`ALTER` and `RENAME` commands. e.g

```sql
CREATE DATABASE database;
```

In `sparkSQL` we can write

```SQL
SHOW DATABASES;
```

to show all of the databases within the notebook.

We can add `properties` to a table, this is metadata in `key value` pairs that gives more information about the purpose of that table. We can access them using the `TBLPROPERTIES` command.

```sql
SHOW TBLPROPERTIES table;
```

Another useful command is:

```sql
SHOW CREATE TABLE table;
```

which shows the `SQL` command needed to create the table.

We can also create tables from `CSV` files saved in the `Cluster`.

```sql
DROP TABLE IF EXISTS table;

CREATE TABLE table USING CSV
OPTIONS (path="path to csv", header="true", inferSchema="true")
```

## Delta Lake

This is `spark's` answer to the `RDBMS` functionality of usual `SQL` - and to their competitors like `AWS Athena` and `Snowflake`. This allows usage of `CRUD` operations. The `Delta Lake` stores files as `parquet` files, which is `Spark's` alternative to `pickling` files.
