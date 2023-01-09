- [Overview](#overview)
- [Data Types](#data-types)
  - [Strings](#strings)
  - [Numeric](#numeric)
  - [Date and Time](#date-and-time)

# Overview

`Structured Query Language` is a method for querying `RDBMS`. The main features follow the `CRUD` acronym:

- C - `Create`
- R - `Read`
- U - `Update`
- D - `Delete`
  `SQL` databases all conform to `ACID` too:
- A - `Atomicity` each query is executed as a single query
- C - `Consistency` a transaction never half finishes, it either finishes or fails
- I - `Isolation` keeps all transactions separated from eachother until they are finished
- D - `Durability` guarentees that the database will keep track of changes so that the server can recover from an abnormal termination

# Data Types

## Strings

| Data type       | Description                                                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| CHAR(size)      | Fixed length string that can only contain letters numbers and special characters. From length 0-255 with a `default` of 1             |
| VARCHAR(size)   | Variable length string with a maximal length of 65535                                                                                 |
| BINARY(size)    | Stores binary byte strings                                                                                                            |
| TINYBLOB        | Holds binary large objects (`BLOBS`) with a maximal length of 255 bytes                                                               |
| TINYTEXT        | Holds a string with a maximum length of 255 characters - use varchar instead                                                          |
| BLOB(size)      | Holds `BLOBS` with a max length of 65535 bytes                                                                                        |
| MEDIUMBLOB      | Holds `BLOBS` with a max length of 16,777,215 bytes                                                                                   |
| LONGTEXT        | Holds a string with a max length of 4,294,967,295 characters                                                                          |
| LONGBLOB        | Holds `BLOBS` with a max length of 4,294,967,295 bytes                                                                                |
| ENUM(a,b,c,...) | A string object that has one value chosen from a list of values with a maximum of 65535 values (specifies specific allowable options) |
| SET(a,b,c,...)  | A string object that can have 0 or more values chosen from a list of values, stores up to 64 values                                   |

## Numeric

## Date and Time
