- [Spark SQL engine](#spark-sql-engine)
  - [Syntax](#syntax)
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

## Delta Lake

This is `spark's` answer to the `RDBMS` functionality of usual `SQL` - and to their competitors like `AWS Athena` and `Snowflake`. This allows usage of `CRUD` operations. The `Delta Lake` stores files as `parquet` files, which is `Spark's` alternative to `pickling` files.
