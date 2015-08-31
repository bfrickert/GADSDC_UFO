import pandas as pd
from sklearn.cross_validation import cross_val_score
from sklearn.tree import DecisionTreeClassifier
import random
from sklearn import tree
from collections import Counter
from sklearn.ensemble import RandomForestClassifier

data = pd.read_csv("C:\\Users\\bfrickert\\Documents\\GitHub\\TheDatanomicon\\Glackel\\GADSDC\\project\\datasets\\UFO.tsv", sep="\t")

rows = random.sample(data.index, len(data))

train = data.ix[rows[0:4000]]
test = data.ix[rows[4000:6000]]

#is.Round ~ MilitaryDist * Season * MeterologicalDist + SwampDist + 
#               StorDist + GolfDist + Met.Nearest + Mil.Nearest + lat + lon + Hour +
#              AirportDist * Month

cols = ['MilitaryDist', 'MeterologicalDist']
X = train[cols].values
y = train['is.Round'].values

clf = tree.DecisionTreeClassifier()
clf.fit(X, y)

clf.predict(X)

Counter(clf.predict(X))

#vectorizer = TfidfVectorizer(stop_words='english')
#X_train = vectorizer.fit_transform(twenty_train_subset.data)



tree_model = DecisionTreeClassifier()
print cross_val_score(tree_model, X, y)

rf_model = RandomForestClassifier(n_estimators=200)
print cross_val_score(rf_model, X, y)