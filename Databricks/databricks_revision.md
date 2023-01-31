# INDEX

- [INDEX](#index)
- [Revision](#revision)
  - [SQL create statements](#sql-create-statements)
  - [Databricks job policies](#databricks-job-policies)
  - [Auto loader](#auto-loader)
  - [Auto loader VS COPY INTO](#auto-loader-vs-copy-into)

# Revision

## SQL create statements

- GENERATED key word in table creation ()

## Databricks job policies

- retry policy (specify number of times)

## Auto loader

- supports both directory listing and file notification but COPY INTO only supports directory  listing.
- Ingests data incrementally in 2 ways:
  1. Directory listing - list directory and maintain the state of the file
  2. File notification - use a trigger + queue to store the file notification which can
  later be used to retrieve the file - this is much more scalable than 1.

## Auto loader VS COPY INTO
