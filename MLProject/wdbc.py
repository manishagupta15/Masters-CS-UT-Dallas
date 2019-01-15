import tensorflow as tf
import numpy as np
tf.enable_eager_execution()

VERBOSE = 2

# specify path to training data and testing data

train_dataset_location = "wdbc_train.csv"
test_dataset_location = "wdbc.csv"

# csv format: feature_0, feature_1, .., feature_{n-1}, label
# n features followed by one label
# features are real, label is int. Label values: 0..NUM_CATEGORIES-1

def read_csv(filename, shuffle=False):
    tmp_matrix = np.loadtxt(open(filename), delimiter=",")
    if shuffle:
        np.random.shuffle(tmp_matrix)
    X = tmp_matrix[:,0:-1]
    y = tmp_matrix[:,-1]
    y = np.array(y).astype("int32")
    return(X, y)

########## some of the parameters that can be adjusted #############
my_batch_size = 32
my_epochs = 1000
my_optimizer = tf.train.AdamOptimizer(learning_rate=0.2)
my_shuffle_each_epoch = True

# activation in layers
# number of hidden-layer-nodes
# add/remove layers

# Model must be sequential. This should not be changed.
# Last layer must be linear. This should not be changed.
########################################################

# define the model

my_model = tf.keras.Sequential()

# input shape is optional for first layer
# first hidden layer has 15 nodes
my_model.add(tf.keras.layers.Dense(15, activation="relu",input_shape=(30,)))

# second hidden layer has 8 nodes
my_model.add(tf.keras.layers.Dense(8, activation="relu"))

# third hidden layer has 2 nodes
my_model.add(tf.keras.layers.Dense(2, activation="relu"))

# last layer is linear, with number of nodes determined by output encoding
# in onehot encoding it is the number of categories
# add to the model once NUM_CATEGORIES is known
# my_model.add(tf.keras.layers.Dense(NUM_CATEGORIES))

# read the training dataset, determine NUM_CATEGORIES and add last layer
(X_train, y_train) = read_csv(train_dataset_location, shuffle=True)
NUM_CATEGORIES = y_train.max() + 1
my_model.add(tf.keras.layers.Dense(NUM_CATEGORIES, activation="linear"))

# compie the model
my_model.compile(optimizer=my_optimizer, loss='categorical_crossentropy',
                 metrics=['accuracy'])

# train the model
my_model.fit(x=X_train, y=y_train, batch_size=my_batch_size, epochs=my_epochs,
             verbose=VERBOSE, shuffle=my_shuffle_each_epoch)

## evaluate the model

print("evaluation on training data",
      my_model.evaluate(x=X_train, y=y_train, batch_size=my_batch_size))

# theere should not be any change below this point
# read the testing dataset and print its accuracy
(X_test, y_test) = read_csv(test_dataset_location)
print("evaluation on test data",
      my_model.evaluate(x=X_test, y=y_test, batch_size=my_batch_size))
