import tensorflow as tf
import tensorflow.contrib.eager as tfe
tfe.enable_eager_execution()

node1 = tf.constant(3.0)
print(node1)
print(node1.numpy())
