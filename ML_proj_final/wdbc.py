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
my_batch_size = 100
my_epochs = 200
# my_optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.01)
my_optimizer = tf.train.AdamOptimizer(0.01)

my_shuffle_each_epoch = False

# activation in layers
# number of hidden-layer-nodes
# add/remove layers

# Model must be sequential. This should not be changed.
# Last layer must be linear. This should not be changed.
########################################################

# define the model

my_model = tf.keras.Sequential()

# input shape is optional for first layer
my_model.add(tf.keras.layers.Dense(4, activation="relu"))
my_model.add(tf.keras.layers.Dense(5, activation="relu"))
my_model.add(tf.keras.layers.Dense(5, activation="sigmoid"))

# dropout layers. Recommendation: sandwitched between dense layers
# my_model.add(tf.keras.layers.Dropout(0.1)) # dropout 0.1. Retain: 0.9

# dense layers with regularization
# my_model.add(
#     tf.keras.layers.Dense(
#         5,
#         activation="relu",
#         kernel_regularizer=tf.keras.regularizers.l2(0.001),
#         bias_regularizer=tf.keras.regularizers.l2(0)
#         )
#     )
# last layer is linear, with number of nodes determined by output encoding
# in onehot encoding it is the number of categories
# add to the model once NUM_CATEGORIES is known
# my_model.add(tf.keras.layers.Dense(NUM_CATEGORIES))

# read the training dataset, determine NUM_CATEGORIES and add last layer
(X_train, y_train) = read_csv(train_dataset_location, shuffle=False)
NUM_CATEGORIES = y_train.max() + 1
my_model.add(tf.keras.layers.Dense(NUM_CATEGORIES, activation="softmax"))

# compie the model
my_model.compile(optimizer=my_optimizer, loss='sparse_categorical_crossentropy',
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
