# To support both python 2 and python 3
from __future__ import division, print_function, unicode_literals
from scipy import sparse
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pandas import ExcelFile

Path_output = 'C:/Users/Admin/Desktop/output.xlsx'
Path_input = 'C:/Users/Admin/Desktop/input.xlsx'
Input = pd.ExcelFile(Path_input)
inputData = pd.read_excel(Input, 0, header=None)
Output = pd.ExcelFile(Path_output)
outputData = pd.read_excel(Output, 0, header=None)
Y_out = outputData.values.T[0]
X = inputData[0:27].values
X = X.T
def softmax(V):
    e_V = np.exp(V - np.max(V, axis = 0, keepdims = True))
    Z = e_V / e_V.sum(axis = 0)
    return Z
def convert_labels(y, C = 3):
    Y = sparse.coo_matrix((np.ones_like(y),
        (y, np.arange(len(y)))), shape = (C, len(y))).toarray()
    return Y

# cost or loss function
def cost(Y, Yhat):
    return -np.sum(Y*np.log(Yhat))/Y.shape[1]
# d0 = 7
# d1 = h =8# size of hidden layer
# d2 = C = 3
# # initialize parameters randomly
# W1 = 0.01*np.random.randn(d0, d1)
# b1 = np.zeros((d1, 1))
# W2 = 0.01*np.random.randn(d1, d2)
# b2 = np.zeros((d2, 1))
# Y = convert_labels(Y_out, C)
# eta = 1 # learning rate

# for i in range(10000):
#     ## Feedforward
#     Z1 = np.dot(W1.T, X) + b1
#     A1 = np.maximum(Z1, 0)
#     Z2 = np.dot(W2.T, A1) + b2
#     Yhat = softmax(Z2)
#     # print loss after each 1000 iterations
#     if i %1000 == 0:
#         # compute the loss: average cross-entropy loss
#         loss = cost(Y, Yhat)
#         print("iter %d, loss: %f" %(i, loss))
#     E2 = (Yhat - Y )/h
#     dW2 = np.dot(A1, E2.T)
#     db2 = np.sum(E2, axis = 1, keepdims = True)
#     E1 = np.dot(W2, E2)
#     E1[Z1 <= 0] = 0 # gradient of ReLU
#     dW1 = np.dot(X, E1.T)
#     db1 = np.sum(E1, axis = 1, keepdims = True)
#     W1 += -eta*dW1
#     b1 += -eta*db1
#     W2 += -eta*dW2
#     b2 += -eta*db2
# Test predict
W1= np.array([[-4.26580883e-01,  2.86742365e+00,  1.63890496e-01,
        -3.09163468e-01, -2.11307471e+00,  1.89416256e-03,
         5.21862861e-01, -7.26073884e-01],
       [-6.69949425e-01,  2.30859521e+00,  1.29679706e-01,
        -4.78594130e-01, -4.94041242e+00, -5.92859090e-03,
         4.21579340e-01, -1.14872965e+00],
       [-7.06550592e-01,  1.43552905e+00, -3.62929324e-02,
        -4.94850594e-01, -4.93760440e+00, -3.42923595e-03,
        -9.09393287e-02, -1.23418574e+00],
       [-4.35131547e-01, -1.68577570e+00, -2.71486627e-01,
        -2.83869474e-01, -9.71168365e-01,  2.04903867e-03,
        -8.02486028e-01, -7.85875523e-01],
       [-3.38354204e-02, -3.01115074e+00, -3.74993961e-01,
        -3.56633416e-02,  4.95324605e+00, -1.04032698e-03,
        -1.13493561e+00, -6.56141621e-02],
       [ 2.05054727e-01, -2.89222183e+00, -3.48909886e-01,
         1.36462035e-01,  4.93993503e+00, -3.59207389e-03,
        -9.74920614e-01,  3.51385511e-01],
       [ 2.26750584e-01, -1.78391756e+00, -1.94472532e-01,
         1.62983711e-01,  5.17048893e+00, -3.53020187e-03,
        -5.98633901e-01,  4.11800287e-01]])
b1=np.array([[-0.61519462],
       [ 0.22798408],
       [-0.28945588],
       [-0.41898145],
       [ 2.62577314],
       [-0.0072134 ],
       [-0.7527441 ],
       [-1.06256207]])
W2=np.array([[ 1.44959454e-02, -1.80189345e-01,  1.66444917e-01],
       [ 2.76175208e+00, -1.54749572e+00, -1.18189968e+00],
       [ 4.47381843e-03, -4.13368502e-02,  3.22705474e-02],
       [ 1.05947472e-02, -1.26070311e-01,  1.30898653e-01],
       [-7.80916360e+00,  5.55727940e+00,  2.26381959e+00],
       [ 1.17175183e-02,  1.08239733e-02,  2.00712217e-02],
       [ 1.23297759e-01, -2.38797561e-01,  1.36750528e-01],
       [ 2.17180792e-02, -2.67897914e-01,  2.55005999e-01]])
b2=np.array([[  9.51461162],
       [-11.29518782],
       [  1.7805762 ]])

# Z1 = np.dot(W1.T, X) + b1
# A1 = np.maximum(Z1, 0)
# Z2 = np.dot(W2.T, A1) + b2
# predicted_class = np.argmax(Z2, axis=0)
# print('training accuracy: %.2f %%' % (100*np.mean(predicted_class == Y_out)))

L=np.array([[0,0,0,0,1,1,1]])
L1 = np.dot(W1.T,L.T) + b1
L2 = np.maximum(L1, 0)
L3 = np.dot(W2.T, L2) + b2
predicted_class1 = np.argmax(L3, axis=0)
print(predicted_class1)