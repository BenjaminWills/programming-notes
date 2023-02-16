from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("sourceToLanding").getOrCreate()


if __name__ == "__main__":
    SOURCE_FILE_NAME = ""
    LANDING_FILE_NAME = ""

    df = spark.read.csv(SOURCE_FILE_NAME)
