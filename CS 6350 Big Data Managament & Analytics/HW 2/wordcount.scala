val input=sc.textFile("/FileStore/tables/text.txt")
val words=input.flatMap(x=>x.split(" "))
val wordcount=words.map(x=>(x,1)).reduceByKey((x,y)=>x+y)
val topten=wordcount.map(x=>x.swap).sortByKey(false).map(x=>x.swap).take(10)
