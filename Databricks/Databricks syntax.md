[[Databricks]]
# Index
- [Index](#index)
- [Magic commands](#magic-commands)
- [DBSQL](#dbsql)
  - [placeholder](#placeholder)

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

## placeholder