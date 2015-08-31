# -*- coding: utf-8 -*-



from sklearn import cluster
import pandas as pd

data = pd.read_csv("C:\\Users\\bfrickert\\Documents\\GitHub\\TheDatanomicon\\Glackel\\GADSDC\\project\\datasets\\UFO.tsv", sep="\t")

k = 2
kmeans = cluster.KMeans(n_clusters=k)

ufo = data[['MilitaryDist', 'MeterologicalDist']]



kmeans.fit(ufo)

labels = kmeans.labels_
centroids = kmeans.cluster_centers_

from matplotlib import pyplot
import numpy as np

for i in range(k):
    # select only data observations with cluster label == i
    ds = ufo[np.where(labels==i)]
    # plot the data observations
    pyplot.plot(ds[:,0],ds[:,1],'o')
    # plot the centroids
    lines = pyplot.plot(centroids[i,0],centroids[i,1],'kx')
    # make the centroid x's bigger
    pyplot.setp(lines,ms=15.0)
    pyplot.setp(lines,mew=2.0)
pyplot.show()