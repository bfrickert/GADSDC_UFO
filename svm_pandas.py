### Example solution to SVM exercise

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import svm, metrics, preprocessing
from sklearn.grid_search import GridSearchCV
import random

# reading data into pandas and examining it
data_pd = pd.read_csv('c:/users/bfrickert/documents/github/thedatanomicon/glackel/gadsdc/project/datasets/ufo.csv')
type(data_pd)
data_pd.describe()

# review of pandas series
data_pd.MilitaryDist
data_pd['MilitaryDist']
data_pd['MilitaryDist'][0:5]
type(data_pd.MilitaryDist)
data_pd.MilitaryDist.shape
data_pd.MilitaryDist.values
type(data_pd.MilitaryDist.values)

# review of pandas dataframes
cols = ['MilitaryDist', 'MeterologicalDist']

# creating X (2d array) and y (1d array) for sklearn
rows = random.sample(data_pd.index, len(data_pd))

train = data_pd.ix[rows[0:4000]]
test = data_pd.ix[rows[4000:6000]]


X = train[cols].values
#X = data_pd[data_pd.columns[:-1]].values
X.shape
y = train['is.Round'].values
y.shape



# plotting
colors = np.where(train['is.Round']==True, 'r', 'b')
#plt.scatter(train.MilitaryDist, train.MeterologicalDist, c=colors)

# train and predict on training set
clf = svm.SVC()
clf.fit(X, y)
predicted = clf.predict(X)
print "traning set prediction: %s" % metrics.accuracy_score(y, predicted)

# center and scale before training and predicting
X_scaled = preprocessing.scale(X)
clf.fit(X_scaled, y)
predicted = clf.predict(X_scaled)
print "training set prediction after scaling: %s" % metrics.accuracy_score(y, predicted)

# grid search for optimal parameters
C_range = 10.0 ** np.arange(-2, 5)
gamma_range = 10.0 ** np.arange(-4, 5)
param_grid = dict(C=C_range, gamma=gamma_range)
grid = GridSearchCV(clf, param_grid, scoring='accuracy')
#grid.fit(X, y)
grid.fit(X_scaled, y)
grid.grid_scores_
grid.best_score_
grid.best_estimator_
grid.best_params_


# with train data
X = test[cols].values
#X = data_pd[data_pd.columns[:-1]].values
X.shape
y = test['is.Round'].values
y.shape

X_scaled = preprocessing.scale(X)
clf.fit(X_scaled, y)
predicted = clf.predict(X_scaled)
print "test set prediction: %s" % metrics.accuracy_score(y, predicted)
