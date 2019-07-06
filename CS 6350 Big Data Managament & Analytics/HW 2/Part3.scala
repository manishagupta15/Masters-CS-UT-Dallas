// Getting the business.csv file
val businessDataFile=sc.textFile("/FileStore/tables/business.csv")

// Getting the review.csv the file
val reviewsDataFile=sc.textFile("/FileStore/tables/review.csv")

// Applying the condition
val businesses=businessDataFile.map(x=>x.split("::")).filter(x=>x(2).contains("Colleges & Universities")).map(x=>(x(0),x(1),x(2)))

// Getting the values
val reviews=reviewsDataFile.map(x=>x.split("::")).map(x=>(x(0),x(1),x(2),x(3)))

// Creating dataframes for the 2 datasets
var businessesDF=businesses.toDF("business_id","address","categories")
var reviewsDF=reviews.toDF("review_id","user_id","business_id","rating")

//Performing the join
var output=businessesDF.join(reviewsDF,"business_id").distinct.select("user_id","rating")

// Display the output
display(output)
