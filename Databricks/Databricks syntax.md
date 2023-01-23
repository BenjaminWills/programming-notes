[[Databricks]]
# Index
- [Index](#index)
- [Magic commands](#magic-commands)
- [DBSQL](#dbsql)
  - [Time travel](#time-travel)
    - [Restoring tables](#restoring-tables)
  - [Compaction](#compaction)

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
```

