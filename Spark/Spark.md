`Spark` is a technology used to handle the processing of `big data` - data files that have a size of > `32 GB`. It is an open source project on `Apache`. It is an alternative to `map reduce`.

## Spark vs map reduce

Here are the main differences:
1. `Map reduce` requires files to be stored in `HDFS` whereas `Spark` does not
2. `Spark` can perform operations up to `100x` faster than `map reduce`
3. `Map reduce` writes most data to disk after each operation, whereas `Spark` keeps the data in memory after each operation - but can spill over to disk if memory is filled

## Spark RDD

An `RDD` is a **resilient distributed dataset** which is an `object` with 4 main features:
1. Distributed collection of data
2. Fault-tolerant
3. Parallel operation - partitioned
4. Ability to use many data sources

`RDD`'s are immutable, lazily evaluated (meaning that evaluation of a statement is delayed until it is needed), and cacheable. 

The lazy evaluation means that we have 2 types of operations in Spark, a `transformation` which adds to the queue of evaluation, and an `action` which will activate the queue of evaluation.

