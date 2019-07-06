# Yelp-Dataset-Analysis-Spark
We use Spark (Spark, Spark dataframe, Spark sql) to solve the following problems using the Yelp dataset.

## Problem 1
Write a spark script to find total number of common friends for any possible friend pairs. The key idea is that if two people are friend then they have a lot of mutual/common friends.

For example,Alice’s friends are Bob, Sam, Sara and Nancy.  
Bob’s friends are Alice, Sam, Clara, Nancy.    
Sara’s friends are Alice, Sam, Clara, Nancy.  
As Alice and Bob are friend and so, their mutual friend list is [Sam, Nancy].  
As Sara and Bob are not friends and so, their mutual friend list is empty. (In this case you may exclude them from your output).

**Input files:**
1. soc-LiveJournal1Adj.txt

The input contains the adjacency list and has multiple lines in the following format: 
```
<User> <TAB> <Friends>
```
Here, <User> is a unique integer ID corresponding to a unique user and <Friends> is a comma-separated list of unique IDs (<User> ID) corresponding to the friends of the user. Note that the friendships are mutual (i.e., edges are undirected): if A is friend with B then B is also friend with A. The data provided is consistent with that rule as there is an explicit entry for each side of each edge. So when you make the pair, always consider (A, B) or (B, A) for user A and B but not both.

**Output:** The output should contain one line per user in the following format:
```
<User_A> <TAB> <User_B> <TAB> <Mutual/Common Friend Number>
``` 
where <User_A> & <User_B> are unique IDs corresponding to a user A and B (A and B are friend). < Mutual/Common Friend Number > is total number of common friends between user A and user B.

## Problem 2
Please answer this question by using data sets below.  
1. soc-LiveJournal1Adj.txt. 
2. userdata.txt. 

The userdata.txt consists of: 
```
column1 : userid 
column2 : firstname 
column3 : lastname 
column4 : address 
column5: city 
column6 :state
column7 : zipcode 
column8 :country 
column9 :username 
column10 : date of birth.
```
Find top-10 friend pairs by their total number of common friends. For each top-10 friend pair print detail information in decreasing order of total number of common friends. More specifically the output format can be:
```
<Total number of Common Friends> <TAB> <First Name of User A> <TAB> <Last Name of User A> <TAB> <address of User A> <TAB> <First Name of User B><TAB> <Last Name of User B> <TAB> <address of User B>
...
```

## Problem 3
**Data set info:**
The dataset files are as follows and columns are separate using ‘::’  
1. business.csv 
2. review.csv 
3. user.csv

The ***business.csv*** file contain basic information about local businesses.
Business.csv file contains the following columns:
```
"business_id"::"full_address"::"categories"
```
where 'business_id' is a unique identifier for the business, 'full_address' is the localized address,
and 'categories': is the category names.

The ***review.csv*** file contains the star rating given by a user to a business. 
Use user_id to associate this review with others by the same user. 
Use business_id to associate this review with others of the same business.  
It contains the following columns:
```
"review_id"::"user_id"::"business_id"::"stars" '
```
where review_id' is a unique identifier for the review, 'user_id' is the identifier of the authoring user,'business_id' is the identifier of the reviewed business, and
'stars': (star rating, integer 1-5),the rating given by the user to a business

The ***user.csv*** file contains aggregate information about a single user across all of Yelp user.csv file contains the following columns:
```
"user_id"::"name"::"url"
```
 where user_id' is the unique user identifier, 'name' is the name, this column has been made anonymous to preserve privacy, and 'url' is the url of the user on yelp

**Note:** :: is Column separator in the files.

List the 'user id' and 'rating' of users that reviewed businesses classified as “Colleges & Universities” in list of categories.

Required files are ***business.csv*** and ***review.csv***.

**Sample output:**
```
User id                    Rating 
0WaCdhr3aXb0G0niwTMGTg     4.0
```


## Problem 4
List the business_id , full address and categories of the Top 10 businesses located in “NY” using the average ratings.

This will require you to use ***review.csv*** and ***business.csv*** files.

Sample output:
```
business id         full address           categories                           avg rating 
xdf12344444444,     CA 91711       List['Local Services', 'Carpet Cleaning'].      5.0
