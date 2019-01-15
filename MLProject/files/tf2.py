import tensorflow as tf
X = tf.constant([[1,1,1],[2,2,2]])
print(X)
XtX = tf.matmul(tf.transpose(X),X)
print(XtX)


sess = tf.Session()
print(sess.run(XtX))
