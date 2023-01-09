- [Spark SQL engine](#spark-sql-engine)

# Spark SQL engine

This is the `SQL` variant that is used on [[Databricks]]. It is the most performant of the programming language options as it interracts directly with `Spark`.

	Note that `spark SQL` is not like a traditional `RDBMS` as it is `schema on read` meaning that the schema is inferred upon reading of an external file. This means that `spark` doesn't have to download the file, it just has to read through the file.