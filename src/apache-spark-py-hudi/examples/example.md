### Pyspark

/opt/spark/bin/pyspark --jars '/workspace/libs/hudi-spark3.3-bundle_2.12-0.14.0.jar'  --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer' --conf 'spark.sql.catalog.spark_catalog=org.apache.spark.sql.hudi.catalog.HoodieCatalog' --conf 'spark.sql.extensions=org.apache.spark.sql.hudi.HoodieSparkSessionExtension' --conf 'spark.sql.warehouse.dir=file:///tmp/hudi'


/opt/spark/bin/pyspark --jars '/opt/spark-extra/jars/hudi-spark3.3.x_2.12-0.13.1.jar'  --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer' --conf 'spark.sql.catalog.spark_catalog=org.apache.spark.sql.hudi.catalog.HoodieCatalog' --conf 'spark.sql.extensions=org.apache.spark.sql.hudi.HoodieSparkSessionExtension' --conf 'spark.sql.warehouse.dir=file:///tmp/hudi'



/opt/spark/bin/pyspark --jars '/opt/spark-extra/jars/hudi-spark3.3-bundle_2.12-0.13.1.jar'  --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer' --conf 'spark.sql.catalog.spark_catalog=org.apache.spark.sql.hudi.catalog.HoodieCatalog' --conf 'spark.sql.extensions=org.apache.spark.sql.hudi.HoodieSparkSessionExtension' --conf 'spark.sql.warehouse.dir=file:///tmp/hudi'

###### Create Table

d = [{'name': 'Rhea', 'age': 4}, {'name': 'Zayn', 'age': 1}]
df = spark.createDataFrame(d)


hudi

basePath = "file:///tmp/hudi/people_cow"

hudi_options = {'hoodie.table.name': 'people', 'hoodie.datasource.write.recordkey.field': 'name', 'hoodie.datasource.write.table.name': 'people', 'hoodie.datasource.write.operation': 'upsert', 'hoodie.datasource.write.partitionpath.field': '', 'hoodie.datasource.write.precombine.field': 'name', 'hoodie.metadata.enable': 'false'}


df.write.format("hudi").options(**hudi_options).mode("overwrite").save(basePath)


###### Query
basepath = 'file:///tmp/hudi/gr.db/items'
gr_items = spark.read.format("hudi").load(basepath)

gr_items.createOrReplaceTempView("items")

spark.sql("SELECT * FROM items;").show()
spark.sql("SELECT id, name, price FROM items;").show()


### Spark-sql

spark-sql --jars '/workspace/libs/hudi-spark3.3-bundle_2.12-0.14.0.jar' --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer' --conf 'spark.sql.extensions=org.apache.spark.sql.hudi.HoodieSparkSessionExtension' --conf 'spark.sql.catalog.spark_catalog=org.apache.spark.sql.hudi.catalog.HoodieCatalog' --conf 'spark.sql.warehouse.dir=file:///tmp/hudi'

/opt/spark/bin/spark-sql --jars '/opt/spark-extra/jars/hudi-spark3.3-bundle_2.12-0.13.1.jar' --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer' --conf 'spark.sql.extensions=org.apache.spark.sql.hudi.HoodieSparkSessionExtension' --conf 'spark.sql.catalog.spark_catalog=org.apache.spark.sql.hudi.catalog.HoodieCatalog' --conf 'spark.sql.warehouse.dir=file:///tmp/hudi'

##### Create database
create database wgr;

-- use
use wgr;

##### Create table item
create table items (id int, name string, price double) using hudi tblproperties (primaryKey = 'id', type = 'cow');

-- insert into items
insert into items values (1, 'shirt', 20);
insert into items values (2, 'pants', 22);