# Dynamo DB

- [Dynamo DB](#dynamo-db)
  - [Introduction](#introduction)
  - [Comparison of SQL to NOSQL](#comparison-of-sql-to-nosql)

## Introduction

`AWS's` non relational NOSQL key value store database. It is serverless, fast, flexible, cost effective, fault tolerant and secure. Single digit millisecond performance at any scale. 

Supports `CRUD` through APIS, with transactional support.

No direct analytical queries.

Data is stored internally as `JSON` files

## Comparison of SQL to NOSQL

| SQL  | DynamoDB  |
|---|---|
|  Tables |  Tables |
|  Rows |  Items |
|  Columns | Attributes  |
|  Primary Keys - multicolumn and optional | Primary keys - manditory, minmum of one attribute and maximum two attributes  |
| Indexes  | Local secondary indexes  |
| Views  | Global secondary indexes  |
