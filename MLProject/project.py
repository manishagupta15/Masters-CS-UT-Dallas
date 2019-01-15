import tensorflow as tf
tf.enable_eager_execution()

plot = False; # plot
#plot = False; # don't plot

# specify path to training data and testing data, and number of categories

train_dataset_location = "wine_train.csv"
test_dataset_location = "wine.csv"
NUM_CATEGORIES = 3

# parse csv line. Format: feature_1 feature_2, .., feature_{n-1}, label
# n-1 features followed by one label
# features are real, label is int. Separator must be comma

# get line length and number of lines
with open(train_dataset_location) as f:
    first_line = f.readline()
LINE_LENGTH = first_line.count(',')+1
with open(train_dataset_location) as f:
  NUM_LINES = len(f.readlines())
print("CSV file info: num lines=", NUM_LINES, " line length=", LINE_LENGTH)
NUM_FEATURES = LINE_LENGTH-1


########## some things that can be adjusted #############
batch_size = 32
num_epochs = 1000
optimizer = tf.train.AdamOptimizer(learning_rate=0.02)

# (Model must be sequential. This should not be changed.)
# activation in layers
# number of hidden-layer-nodes
# add/remove layers
########################################################


def parse_csv(line, n=LINE_LENGTH):
  n1 = n-1
  default_row = [[0.]]*n1 + [[0]] # n-1 float values, 1 int value
  parsed_line = tf.decode_csv(line, record_defaults=default_row)
  features = tf.reshape(parsed_line[:-1], shape=(n1,))
  # Last field is the label
  label = tf.reshape(parsed_line[-1], shape=())
  return features, label

# read the training dataset, parse, and randomize order of records
# large buffer_size improves randomization but no need for more than numrecords
train_dataset = tf.data.TextLineDataset(train_dataset_location)
train_dataset = train_dataset.map(parse_csv)      # parse each row
train_dataset = train_dataset.shuffle(NUM_LINES)  # randomize
train_dataset = train_dataset.batch(batch_size)

# define the model

model = tf.keras.Sequential([
  # input shape is required for first layer. Must be number of features
  tf.keras.layers.Dense(10, activation="relu", input_shape=(NUM_FEATURES,)),

  tf.keras.layers.Dense(NUM_CATEGORIES)
])

def loss(model, x, y):
  predicted_y = model(x)
  return tf.losses.sparse_softmax_cross_entropy(labels=y, logits=predicted_y)


def grad(model, inputs, targets): # this will become grad(model, x, y)
  with tf.GradientTape() as tape:
    loss_value = loss(model, inputs, targets)
  return tape.gradient(loss_value, model.variables)

if plot: # keep results for plotting
  train_loss_results = []
  train_accuracy_results = []

epoch_loss_avg = tf.contrib.eager.metrics.Mean()
epoch_accuracy = tf.contrib.eager.metrics.Accuracy()

for epoch in range(num_epochs):
  # Training loop
  for x, y in train_dataset:
    # Optimize the model
    grads = grad(model, x, y)
    optimizer.apply_gradients(zip(grads, model.variables),
                              global_step=tf.train.get_or_create_global_step())

    # Track progress
    epoch_loss_avg(loss(model, x, y))  # add current batch loss
    # compare predicted label to actual label
    epoch_accuracy(tf.argmax(model(x), axis=1, output_type=tf.int32), y)
    # end epoch
    if plot:
      train_loss_results.append(epoch_loss_avg.result())
      train_accuracy_results.append(epoch_accuracy.result())

  if epoch % 50 == 0:
    print("Epoch {:03d}: Loss: {:.3f}, Accuracy: {:.3%}".format(epoch,
                                                                epoch_loss_avg.result(),
                                                                epoch_accuracy.result()))
# finished training

# plot
if plot:
  import matplotlib.pyplot as plt
  fig, axes = plt.subplots(2, sharex=True, figsize=(12, 8))
  fig.suptitle('Training Metrics')
  axes[0].set_ylabel("Loss", fontsize=14)
  axes[0].plot(train_loss_results)
  axes[1].set_ylabel("Accuracy", fontsize=14)
  axes[1].set_xlabel("Epoch", fontsize=14)
  axes[1].plot(train_accuracy_results)
  plt.show()
####### end plot

# testing

# evaluate accuracy on test data

test_accuracy = tf.contrib.eager.metrics.Accuracy()

test_dataset = tf.data.TextLineDataset(test_dataset_location)
test_dataset = test_dataset.map(parse_csv)      # parse each row with code created earlier
test_dataset = test_dataset.batch(1)            # batch size is irrelevant
for (x, y) in test_dataset:
  prediction = tf.argmax(model(x), axis=1, output_type=tf.int32)
  test_accuracy(prediction, y)

print("Test set accuracy: {:.3%}".format(test_accuracy.result()))
