from __future__ import division, print_function, unicode_literals
from scipy import sparse
import math
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pandas import ExcelFile
from numpy import genfromtxt
Path_output = 'C:/Users/Admin/Desktop/output2.xlsx'
Path_input = 'C:/Users/Admin/Desktop/input.xlsx'
Input = pd.ExcelFile(Path_input)
inputData = pd.read_excel(Input, 0, header=None)
Output = pd.ExcelFile(Path_output)
outputData = pd.read_excel(Output, 0, header=None)
Y = outputData.values.T
X = inputData[0:27].values.T
def layer_sizes(X, Y):
    print("Started with calculating layer sizes...")
    n_x = X.shape[0] # size of input layer
    n_y = Y.shape[0] # size of output layer
    print("layer_sizes :"+ str(n_x),"inputs and ",str(n_y)," outputs")
    return (n_x, n_y)

def convert_labels(y, C = 3):
    Y = sparse.coo_matrix((np.ones_like(y),
        (y, np.arange(len(y)))), shape = (C, len(y))).toarray()
    return Y

def initialize_parameters(n_x, n_h, n_y):
    print("Started with calculating parameters...")
    W1 = np.random.randn(n_h, n_x) * 0.01
    b1 = np.zeros((n_h, 1))
    W2 = np.random.randn(n_y, n_h) * 0.01
    b2 = np.zeros((n_y, 1))

    parameters = {"W1": W1,"b1": b1,"W2": W2,"b2": b2}

    return parameters
def sigmoid(x):
    s = 1/(1+np.exp(-x))
    return s

def forward_propagation(X, parameters):
    np.random.seed(2)
    W1 = parameters["W1"]
    b1 = parameters["b1"]
    W2 = parameters["W2"]
    b2 = parameters["b2"]

    Z1 = np.dot(W1, X) + b1
    A1 = np.tanh(Z1)
    Z2 = np.dot(W2, A1) + b2
    A2 = sigmoid(Z2)

    cache = {"Z1": Z1,"A1": A1,"Z2": Z2,"A2": A2}
    return A2, cache



def compute_cost(A2, Y, parameters):

    m = Y.shape[0] # number of example
    # print(A2.shape,Y.shape)
    logprobs = np.multiply(np.log(A2),Y) + ((1-Y) * np.log(1 - A2) )
    cost = - (1/m) * np.sum(logprobs)
    ### END CODE HERE ###

    cost = np.squeeze(cost)     # makes sure cost is the dimension we expect.
    return cost

def backward_propagation(parameters, cache, X, Y):

    m = X.shape[1]
    W1 = parameters["W1"]
    W2 = parameters["W2"]

    A1 = cache["A1"]
    A2 = cache["A2"]

    dZ2 = A2 - Y
    dW2 = (1/m) * np.dot(dZ2, A1.T)
    db2 = (1/m) * np.sum(dZ2, axis =1, keepdims = True)
    dZ1 = np.dot(W2.T, dZ2) * (1 - np.power(A1, 2))
    dW1 = (1/m) * np.dot(dZ1, X.T)
    db1 = (1/m) * np.sum(dZ1, axis =1, keepdims = True)

    grads = {"dW1": dW1,"db1": db1,"dW2": dW2,"db2": db2}
    return grads


def update_parameters(parameters, grads, learning_rate):

    W1 = parameters["W1"]
    b1 = parameters["b1"]
    W2 = parameters["W2"]
    b2 = parameters["b2"]

    dW1 = grads["dW1"]
    db1 = grads["db1"]
    dW2 = grads["dW2"]
    db2 = grads["db2"]

    W1 = W1 - learning_rate * dW1
    b1 = b1 - learning_rate * db1
    W2 = W2 - learning_rate * dW2
    b2 = b2 - learning_rate * db2

    parameters = {"W1": W1,"b1": b1,"W2": W2,"b2": b2}

    return parameters
def nn_model(X, Y, n_h, num_iterations, print_cost):
    n_x,n_y = layer_sizes(X, Y)
    print (" input: " + str(n_x) +" hidden_Layer: " + str(n_h) +" output: " + str(n_y))
    parameters = initialize_parameters(n_x, n_h, n_y)
    W1 = parameters["W1"]
    b1 = parameters["b1"]
    W2 = parameters["W2"]
    b2 = parameters["b2"]
    # Loop (gradient descent)
    print("Starting Neural Network...")
    for i in range(0, num_iterations):

        # Forward propagation. Inputs: "X, parameters". Outputs: "A2, cache".
        A2, cache = forward_propagation(X, parameters)
        # Cost function. Inputs: "A2, Y, parameters". Outputs: "cost".
        cost = compute_cost(A2, Y, parameters)
        # Backpropagation. Inputs: "parameters, cache, X, Y". Outputs: "grads".
        grads = backward_propagation(parameters, cache, X, Y)

        # Gradient descent parameter update. Inputs: "parameters, grads". Outputs: "parameters".
        parameters = update_parameters(parameters, grads,1)
        # Print the cost every 1000 iterations
        if print_cost and i % 1 == 0:
            #pass
            print ("Cost after iteration %i: %f" %(i, cost))
            # plt.title("Learning rate =" + str(learning_rate))
    return parameters

def predict(parameters, P):

    A2, cache = forward_propagation(P, parameters)
    # predictions = (A2 > 0.9)
    predictions = A2
    # all_predict=predictions.sum(axis=1)
    return predictions
parameters = nn_model(X, Y, 1 , 1000,True)#parameters = nn_model(X, Y, 4 , 200000,True)
print(parameters)
P=[0,0,0,0,1,0,0]
print("Prediction sequence" + str(P))
predictions = predict(parameters, P)
all=np.sum(predictions,axis=1)
all=all/np.max(all)
np.set_printoptions(formatter={'float_kind':'{:f}'.format})
#print ('Accuracy: %d' % float((np.dot(Y.T,predictions) + np.dot(1-Y.T,1-predictions))/float(Y.size)*100) + '%')
print (all)
if(all[0]>all[1]):
    print("left")
if(all [0]<all[1]):
    print("right")
A=predict(parameters, X);
B=[];
for i in range(27):
    if A[:,i][0]>0.9 and A[:,i][1]>0.9:
        B.append('straight')
    elif A[:,i][0]<0.9 and A[:,i][1]>0.9:
        B.append('right')
    else:
        B.append('left')
    
print(B)
        
#     print("right")




