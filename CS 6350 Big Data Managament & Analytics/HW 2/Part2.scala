import org.apache.spark.sql.functions._// Importing mutual-friends.txt
val input=sc.textFile("/FileStore/tables/mutual_friends-d6c0a.txt")

// Parsing the info. Output Format:Array[(String, Array[String])]
val temp = input.map(x => x.split("\t")).filter(x => x.length == 2).map(x => (x(0), x(1).split(",")))

// Mapping. Format:Array[List[(String, List[String])]]
val mapping=temp.map(x=>
{
  val userA=x._1
  val userAFriends=x._2.toList
  for (userB <- userAFriends) yield
  {
    if(userA.toInt < userB.toInt)
    {
      (userA+","+userB -> userAFriends)
    }
    else
    {
      (userB+","+userA->userAFriends)
    }
  }
  })

//Reducing
val reduce=mapping.flatMap(identity).map(x=>(x._1,x._2)).distinct.reduceByKey((x,y)=>x.intersect(y))

// Getting the number of mutual friends for a pair
val output=reduce.map(x=>(x._1,x._2.length)).map(x=>(x._1.split(",")(0),x._1.split(",")(1),x._2))

// Making a dataframe for each pair and its mutual friends count
var pairs=output.toDF("userA_id","userB_id","mutual friend count")

// Taking the pairs with the top ten count
var topTenPairs=pairs.orderBy(desc("mutual friend count")).limit(10)

//Getting userdata.txt file
val userDataFile=sc.textFile("/FileStore/tables/userdata.txt")

// Parsing the required fields
val parseUsersInfo=userDataFile.map(x=>x.split(",")).map(x=>(x(0),x(1),x(2),x(3)))

// Making a dataframe for UserA
val userA=parseUsersInfo.toDF("userA_id","userA First Name","userA Last Name","userA Address")

// Making a dataframe for userB
val userB=parseUsersInfo.toDF("userB_id","userB First Name","userB Last Name","userB Address")

// joining top ten pairs with userA dataframe
var join1=topTenPairs.join(userA,"userA_id")

//joining above dataframe with userB dataframe
var join2=join1.join(userB,"userB_id")

// Display output
display(join2.select("mutual friend count","userA First Name","userA Last Name","userA Address","userB First Name","userB Last Name","userB Address"))
