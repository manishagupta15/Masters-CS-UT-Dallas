import org.apache.spark.sql.functions._

// Getting the business.csv file
val businessDataFile=sc.textFile("/FileStore/tables/business.csv")

// Getting the review.csv the file
val reviewsDataFile=sc.textFile("/FileStore/tables/review.csv")

// Getting the businesses located in NY
val businesses=businessDataFile.map(x=>x.split("::")).filter(x=>x(1).contains("NY")).map(x=>(x(0),x(1),x(2)))

// Getting the avrage rating for each business
val reviews=reviewsDataFile.map(x=>x.split("::")).map(x=>(x(2),(x(3).toDouble,1))).reduceByKey((x,y)=>(x._1+y._1,x._2+y._2)).map(x=>(x._1,x._2._1/x._2._2)).sortBy(-_._2)


// Creating dataframes for the businesses and reviews datasets
var businessesDF=businesses.toDF("business_id","address","categories")
var reviewsDF=reviews.toDF("business_id","avg rating")

//Performing the join
var join=reviewsDF.join(businessesDF,"business_id")

// Taking the top 10 businesses based on average rating in NY
var final_output=join.distinct.orderBy(desc("avg rating")).limit(10).select("business_id","address","categories","avg rating")



display(final_output)
