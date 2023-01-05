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
	- [Connecting to DB](#connecting-to-db)
- [Querying Syntax](#querying-syntax)

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

## Connecting to DB

We can now use the command line to connect to our mongo DB database. We can provide a **DNS** server list to our connection string - this allows us to refer to it by our own chosen name.

caveat: to install mongoDB shell,

```sh
brew install mongosh
```

then to connect to the database we write:

```sh
mongosh "mongodb://<username>:<password>@host:port/defaultauthdb?options
```

**breakdown**:

```sh
mongodb://
```

is the neccessary prefix to any connection string.

```sh
<username>:<password>
```

**optional** - authorisation credentials to access the DB

```sh
host:port
```

The host is the person connecting, so if your IP is in the trusted list you will be allowed in, the default port for mongoDB is `27017`.

```sh
/defaultauthdb
```

The database you are trying to access with the login credentials - if left blank mongosh will assume you want to access the `admin` database

```sh
?<options>
```

In classic API form, we have the options block in `<key1>=<value1>&<key2>=<value2>`.

We can find this in the atlas GUI quite easily - similar to github cloning or AWS ECS URI.

# Querying Syntax

MongoDB is a NOSQL database! So the querying language differs from usual SQL engine syntax. The syntax is very object oriented, calling chained methods. I have abstracted this to another markdown document as it is mega long. [[Mongo DB Querying Syntax]]