- Listing all DB's
```mongosh
show dbs
```
- To switch to a DB
```mongosh
use <DB NAME>
```
Worth noting that if that DB does not exist, it will be created with this statement and it will be empty
- To drop a db
```mongosh
db.dropDatabase()
```
When in the correct database.
- To clear screen
```mongosh
cls
```
- To exit
```
exit
```
- To make a new `collection`
```mongosh
db.<collection_name>.insertOne(<record>)
```
- SELECT becomes find, so to select all from a db:
```sh
db.<collection_name>.find()
```