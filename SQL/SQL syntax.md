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
