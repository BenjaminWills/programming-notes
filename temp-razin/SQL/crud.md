# CRUD

## Topics

- [CRUD](#crud "CRUD")
- [INSERT](#insert "INSERT")
- [SELECT](#select "SELECT")
- [UPDATE](#update "UPDATE")
- [DELETE](#delete "DELETE")

PG exercises [[=]](https://pgexercises.com)

## CRUD [^](#topics "Topics")

**C**reate rows = INSERT  
**R**ead rows = SELECT  
**U**pdate rows = UPDATE  
**D**elete rows = DELETE

## INSERT [^](#topics "Topics")

```sql
INSERT INTO table1
    (column1, column2)
VALUES
    (row1_c1, row1_c2),
    (row2_c1, row2_c2);
```

- _can exclude (columns) if using all attributes_
- _can exclude specific columns for null or default_
- _allows numerical/string operations_

## SELECT [^](#topics "Topics")

```sql
-- All columns
    SELECT * FROM table1;

-- Specific columns
    SELECT column1, column2 FROM table1;
```

`Order of Execution`

1. FROM + JOIN + Subqueries = working dataset
2. WHERE = initial filters using direct access to table
3. GROUP = reduce filtered rows by unique values in an attribute
4. HAVING = further filter reduced grouped results using direct access to table
5. SELECT = specific rows used & aliases created
6. DISTINCT = removes all duplicates
7. ORDER = sort rows
8. LIMIT + OFFSET = range

```sql
SELECT DISTINCT column1, function(col2) AS func_col2 FROM table1 t1
JOIN table2 t2 ON t2.column1 = t1.column1
WHERE condition1
GROUP BY column1 HAVING condition2
ORDER BY column1 ASC/DESC
LIMIT num OFFSET num;
```

`Distinct` = blindly remove all duplicate rows

```sql
SELECT DISTINCT * FROM table1;
```

`Alias` = refer by a different name

```sql
-- Columns
    SELECT column1 AS c1 FROM table1;

-- Tables
    SELECT column1 FROM table1 t1;
```

`Join` = connect related tables

```sql
-- Same column names
    JOIN table2 USING (column1);

-- Different column names
    JOIN table2 ON table2.column2 = table1.column1;
```

- _**Inner** = joins only one-to-one matches_
- _**Left/Right** = joins to one side even if the other does not match (uses null)_
- _**Outer** = joins both sides regardless of match (uses null)_

`Where` = filter rows

```sql
WHERE condition1;
```

```sql
-- Other conditions
    WHERE condition1 AND condtion2;
    WHERE condition1 OR condition2;

-- Check in list
    WHERE x IN (list);

-- Check in between values
    WHERE BETWEEN x AND y;
```

```sql
-- Numerical operators
    = | != | < | <= | > | =>
```

```sql
-- String operators
    = -- exact equality
    != | <> -- inequalty
    LIKE -- similar equality
```

- _% = match 0 or more characters_
- _\_ = match 0 or more characters_

`Order By` = sort alpha-numerically

```sql
ORDER BY column1 ASC/DESC;
```

`Limit` = restrict number of results

```sql
LIMIT num;
```

`Offset` = choose starting point

```sql
LIMIT num OFFSET num;
```

`Case` = if/else

```sql
CASE WHEN column1 condition1 THEN result1 ELSE result2 END
```

```sql
CASE column1
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE result3
END
```

`Aggregate Functions` = reduce

```sql
COUNT(*) -- number of rows not null
SUM(col) -- sum of rows
AVG(col) -- average of rows
Max(col) -- maximum of rows
Min(col) -- minimum of rows
```

- _for n attributes, this creates n+1 queries_

`Group By` = reduce rows by unique value

```sql
SELECT column1, function(col2) FROM table1
GROUP BY column1;
```

`Having` = filter grouped result

```sql
SELECT column1, function(col2) FROM table1
WHERE condition1
GROUP BY column1 HAVING condition2;
```

`Subqueries` = can be used anywhere in a query within ()

- _can access outer queries_

`Views` = stored subquery

```sql
CREATE VIEW view1 AS query;
```

`Union` = appends another query result only when attribute number & type are the same

```sql
SELECT column1 FROM table1
UNION
SELECT column2 FROM table2;
```

- _**union all** = include duplicates_
- _**intersect** = only includes duplicates_
- _**except** = only includes differences to second query_

## UPDATE [^](#topics "Topics")

```sql
UPDATE table1 SET
    column1=new_value1,
    column2=new_value2
WHERE id = row_id;
```

- _exclude WHERE if updating all rows_

## DELETE [^](#topics "Topics")

```sql
DELETE FROM table1
WHERE id = row_id;
```

- _exclude WHERE if deleting all rows_
