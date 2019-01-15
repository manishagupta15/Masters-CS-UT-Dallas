import tensorflow as tf
import tensorflow.contrib.eager as tfe
tfe.enable_eager_execution()

X = tf.constant([[1,1,1],[2,2,2]])
print(X)

XtX = tf.matmul(tf.transpose(X),X)
print(XtX)
