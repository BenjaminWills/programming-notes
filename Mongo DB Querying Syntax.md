https://www.mongodb.com/docs/manual/tutorial/query-documents/
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
- To make a new `collection` and insert a `document`
```mongosh
db.<collection_name>.insertOne(<record>)
```
- SELECT becomes find, so to select all from a db:
```sh
db.<collection_name>.find()
```
- to insert many `documents` into a `collection`
```mongosh
db.<collection_name>.insertMany([<records>])
```
Where records is a comma separated list of BSON's.
- Limit findings by writing
```mongosh
db.<collection_name>.find().limit(n)
```
Will limit the output to $n$ documents.
- To sort through specific ids
```mongosh
db.<collection_name>.find().sort({key:value,key2:value2,...})
```
Where the key is a key of the BSONs that you're sorting, the value can be 1 or -1, one for ascending, -1 for descending.
- To skip the first few entries when finding we can write
```mongosh
db.<collection_name>.find().skip(n)
```
Will skip the first $n$ entries.
- Specifying what we want to find by
```mongosh
db.<collection_name>.find({key:value})
```
e.g `{name:"ben"}` would find all `documents` with that key value pair.
- Where clauses
```mongosh
db.<collection_name>.find({key:value},{key2:1|0,key3:1|0})
```
This will return an object with only keys 2 and 3 showing. so if we find the following BSON on my name, and only want the name and not the age,
```json
{name:"Ben",age:21}
```
We would write `db.<collection_name>.find({name:"Ben"},{name:1,_id: 0})`. This would return
```json
{name:"Ben"}
```
- To execute complex queries we use the `$` in the find method.
	- `$eq` - equal to
	- `$ge` - greater than or equal to
	- `$gt` - greater than
	- `$lt` - less than

We call these as follows:
``` mongosh
db.<collection_name>.find({key : { $operation: value }})
```
- `AND` operation
We can chain commands using:
```mongosh
db.<collection_name>.find({key : { $operation1: value1, $operation2: value2 }})
```
The comma acts as an `AND`. Or we can explicitly state the statement with `$and`

WHAT TO MENTION:
CDP
SNOWFLAKE
DATABRICKS
MONGODB

UDEMY COURSE ON SNOWFLAKE
PHIZER