**Mongo DB** is a **NOSQL** database, meaning that it stores data in _key_, _value_ pairs. NOSQL databases are very fast, and non relational, they are useful for large volumes of data. It connects to the three main clouds:

- AWS
- Azure
- GCP

# Index

- [Index](#index)
- [Atlas](#atlas)
	- [Clusters](#clusters)
- [Database](#database)
	- [Key terms](#key-terms)
	- [Relation to atlas](#relation-to-atlas)
	- [Document model](#document-model)

# Atlas

Atlas is mongo DB's DBMS. We need to create an account, then create users, then add IP addresses to access the DB.

## Clusters

Clustering in mongo DB allows for horizontal scaling to keep up with demand, this speeds up querying time. **Atlas cluster** is a database as a service that is fully managed by Mongo DB.

You can access a cluster using the mongo shell.

```sh
mongo "mongodb+srv://<clustername>.nupbd.mongodb.net/<dbname>" --username <username>
```

These clusters can also refer to **replica sets** which are essential for _availability_ and _data redundancy_ reduction.

# Database

Mongo DB is a general purpose document database (documents are similar to **json** objects.), documents look like this:

```json
{
  "id": 1,
  "name": {
    "first": "ben",
    "last": "wills"
  },
  "title": "legend",
  "interests": ["coding", "reading", "total war", "gym", "films", "maths"]
}
```

or this:

```yml
id:1
name:
	- first:"ben"
	- second:"wills"
title:"legend"
interests: ["coding","reading","total war", "gym", "films", "maths"]
```

Drivers are provided for mongo in many languages.

## Key terms

- **Document** - basic unit of data
- **Collection** - a grouping of documents
- **Database** - a container for collections

## Relation to atlas

Mongo DB lives within atlas.

## Document model

Documents are stored in a **BSON** format, which is a slight modification to the **JSON** that we know and love. It supports _dates,numbers,object ids_.

```json
{
	"key":value,
	"key":value,
	"key":value
}
```

**EVERY** document in mongo DB requires an _\_id_ field which acts as the primary key. If a document does not have one, mongo DB will **automatically** generate one.

```json
{
	"_id":id,
	"key":value,
	"key":value,
	"key":value
}
```

Documents may contain **different fields** which is a key difference to RDB. This is referred to as a **flexible schema**.

To make trivial changes we need to: update the classes to contain the new fields, and then just insert them, as the schema is flexible.

We can set schema validation rules, to validate that submitted documents conform to the required structure.
