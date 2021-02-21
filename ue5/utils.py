import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt

def generateData() :
    np.random.seed(0)
    n = 15
    x = np.linspace(0,10,n) + np.random.randn(n)/5
    y = np.sin(x)+x/6 + np.random.randn(n)/10    
    return train_test_split(x, y, random_state=0)

def plot_data_scatter(X_train, y_train, X_test, y_test):
    plt.figure(figsize=(10,5))
    plt.scatter(X_train, y_train, label='training data')
    plt.scatter(X_test, y_test, label='test data')
    plt.legend(loc=4);


# Plottet das Ergebnis
def plot_one(X_train, y_train, X_test, y_test, degree_predictions):
    plt.figure(figsize=(10,5))
    plt.plot(X_train, y_train, 'o', label='training data', markersize=10)
    plt.plot(X_test, y_test, 'o', label='test data', markersize=10)
    for i,degree in enumerate([1,3,6,9]):
        plt.plot(np.linspace(0,10,100), degree_predictions[i], alpha=0.8, lw=2, label='degree={}'.format(degree))
    plt.ylim(-1,2.5)
    plt.legend(loc=4)    


def plot_validation_curve(mse_train, mse_test):
    plt.figure(figsize=(10,5))    
    plt.title('Validation Curve')
    plt.xlabel('Grad des Polynoms')
    plt.ylabel('MSE')
    param_range = range(0, 10, 1)
    plt.plot(param_range, mse_train, label='Training score', color='darkorange', lw=2)
    plt.plot(param_range, mse_test, label='Test score', color='navy', lw=2)    
    plt.legend(loc='best')
    plt.show()    