- [Overview](#overview)
- [Data Types](#data-types)
  - [Strings](#strings)
  - [Numeric](#numeric)
  - [Date and Time](#date-and-time)
  - [How to use](#how-to-use)
- [Create](#create)

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

| Data type       | Description                                                                                                                                                                                                                               |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| BIT(size)       | A bit-value type with `default` of 1, can have a maximum of 64                                                                                                                                                                            |
| TINYINT(size)   | A very small integer with a signed range between `-128` and `127` and an unsigned range between `0` and `255`, size refers to the maximum allowed display width which is 255                                                              |
| BOOLEAN         | `True` and `False`                                                                                                                                                                                                                        |
| SMALLINT(size)  | A small integer with a signed range between `-32768` and `32767` and an unsigned range between `0` and `65535`, size refers to the maximum allowed display width which is 255                                                             |
| MEDIUMINT(size) | A medimum integer with a signed range between `-8,388,608` and `8,388,607` and an unsigned range between `0` and `16,777,215`, size refers to the maximum allowed display width which is 255                                              |
| INT(size)       | A medium integer with a signed range between `-2,147,483,648` and `2,147,483,647` and an unsigned range between `0` and `4,294,967,295`, size refers to the maximum allowed display width which is 255                                    |
| INTEGER(size)   | Same as int                                                                                                                                                                                                                               |
| BIGINT(size)    | A medium integer with a signed range of between `-9,223,372,036,854,775,808` and `9,223,372,036,854,775,807` and an unsigned range between `0` and `1,844,674,407,370,955`, size refers to the maximum allowed display width which is 255 |
| FLOAT(p)        | A floating point value where p (`precision`) is a parameter between `0` and `24`                                                                                                                                                          |
| DOUBLE(size,d)  | A floating point number where `size` defines the total number of digits, and `d` defines the number of digits after the decimal point                                                                                                     |
| DECIMAL(size,d) | An exact fixed point number where the total number of digits is set by `size`, and the number of digits after the decimal point is set by `d`                                                                                             |
| DEC(size,d)     | Same as DECIMAL                                                                                                                                                                                                                           |

## Date and Time

| Data type | Description                                                                                                                                                                                       |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| DATE      | A simple date in the form of `YYYY-MM-DD` with a supported range from `1000-01-01` to `9999-12-31`                                                                                                |
| DATETIME  | A date time in the form of `YYYY-MM-DD hh:mm:ss` with the same supported range as date (just with time too). Automatically sets column dates to current date by setting `DEFAULT` and `ON UPDATE` |
| TIMESTAMP | A unix timestamp that will return a value relative to the number of seconds since the `Unix Epoch` (`1970-01-01`), has a range until `2038-01-09 03:14:07`                                        |
| TIME      | A simple time in `hh:mm:ss` format                                                                                                                                                                |
| YEAR      | A year from `1901` to `2155`                                                                                                                                                                      |

## How to use

We'll see this in the creation of tables section, but we create tables by baking in the data types as follows

```sql
CREATE TABLE table_name (
	name VARCHAR(20)
);
```

# Create

- Creating tables

```sql
CREATE TABLE table_name (
	id SERIAL PRIMARY KEY,
	column_1 <Data type> NOT NULL,
	column_2 <Data type>
);
```

Here we have a few new key words 
1. `serial` - each new row we add to the table is automatically assigned an increasing id 
2. `primary key` - this column is the primary key of the table, the best practice is that this is a column that will only contain unique values. 
3. `NOT NULL` - means that this column cannot be left empty when inserting data into it