
from pyspark.mllib.recommendation import ALS, MatrixFactorizationModel, Rating

data = sc.textFile("/FileStore/tables/ratings.dat")
ratings = data.map(lambda l: l.split('::')).map(lambda l: Rating(int(l[0]), int(l[1]), float(l[2])))



#train test split
(X_train,X_test)=ratings.randomSplit([0.6,0.4],seed=100)

 # Build the recommendation model using Alternating Least Squares
rank = 10
numIterations = 10
model = ALS.train(X_train, rank, numIterations)


    # Evaluate the model on training data
print(" training data size= " + str(X_train.count()))
train_data = X_train.map(lambda p: (p[0], p[1]))
predictions = model.predictAll(train_data).map(lambda r: ((r[0], r[1]), r[2]))
ratesAndPreds = X_train.map(lambda r: ((r[0], r[1]), r[2])).join(predictions)
MSE = ratesAndPreds.map(lambda r: (r[1][0] - r[1][1])**2).mean()
print("Mean Squared Error for training data = " + str(MSE))

# Evaluate model on test data
print(" testing data size= " + str(X_test.count()))
test_data = X_test.map(lambda p: (p[0], p[1]))
predictions = model.predictAll(test_data).map(lambda r: ((r[0], r[1]), r[2]))
ratesAndPreds = X_test.map(lambda r: ((r[0], r[1]), r[2])).join(predictions)
MSE = ratesAndPreds.map(lambda r: (r[1][0] - r[1][1])**2).mean()
print("Mean Squared Error for test data= " + str(MSE))
