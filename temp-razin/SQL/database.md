# Database

## Topics

- [SQL](#sql "SQL")
- [Database Setup](#database-setup "Database Setup")
- [Foreign Key](#foreign-key "Foreign Key")
- [Alter Database](#alter-database "Alter Database")
- [Indexing](#indexing "Indexing")

PG exercises [[=]](https://pgexercises.com)

## SQL [^](#topics "Topics")

SQL = structured query language

- Query searching within relational databases

SQL is an ANSI standard

- **DQL** = data query language
  - SELECT
- **DDL** = data definition language
  - CREATE | DROP | ALTER | TRUNCATE | RENAME | COMMENT
- **DML** = data manipulation language
  - INSERT | DELETE | UPDATE | LOCK | CALL | EXPLAIN
- **DCL** = data control language
  - GRANT | REVOKE

## Database Setup [^](#topics "Topics")

Create Database

```sql
CREATE DATABASE database1;
```

Create Table

```sql
CREATE TABLE table1 (
    id SERIAL PRIMARY KEY,
    column1 TYPE CONSTRAINT,
    column2 TYPE CONSTRAINT,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);
```

Types

- **SERIAL** = sequence of integers
- **INT** = integer
- **DEC** = decimal
- **TEXT** = string
- **VARCHAR(n)** = text with character limit
- **BOOL** = true/false
- **NULL** = none
- **DATE** = ‘YYYY-MM-DD’
- **TIMESTAMP** = ‘YYYY-MM-DD HH:MM:SS.nnnnnn’

Constraints

- **PRIMARY KEY** = unique identifier
- **NOT** = exclude a datatype (usually NULL)
- **DEFAULT** = upon absence of value
- **UNIQUE** = must not match value in other entries
- **CHECK (e)** = checks value against given expression

Existence Test

- **IF/IF NOT EXISTS**

## Foreign Key [^](#topics "Topics")

Foreign Key = refers to primary keys in another entity

- Prevents data mismatch to ensure data integrity

Creating Foreign Key

```sql
CREATE TABLE table1_table2 (
    id SERIAL PRIMARY,
    table1_id INT NOT NULL,
    table2_id INT NOT NULL,
    FOREIGN KEY (table1_id) REFERENCES table1(id),
    FOREIGN KEY (table2_id) REFERENCES table2(id)
);
```

Adding Foreign Key

```sql
ALTER TABLE table1_table2 ADD CONSTRAINT table1_fk FOREIGN KEY (table1_id) REFERENCES table1(id);
```

## Alter Database [^](#topics "Topics")

Reset Serial

```sql
ALTER SEQUENCE table1_column1_seq RESTART WITH 1;
```

Add Columns (attributes)

```sql
ALTER TABLE table1 ADD COLUMN column2 TYPE CONSTRAINT;
```

- _set a default to change existing rows_

Add Constraints

```sql
ALTER TABLE table1 ADD CONSTRAINT constraint_column1 CONSTRAINT (column1);
```

## Indexing [^](#topics "Topics")

```sql
CREATE INDEX table1_column1_idx ON table1(column1);
```

- _primary keys are automatically indexed_
- _limit number of indexed columns, otherwise memory is wasted making index useless_
