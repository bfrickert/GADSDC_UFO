import json
import math
import pandas as pd

with open('..\datasets\MILITARY_INSTALLATIONS_RANGES_TRAINING_AREAS_BND.json') as g:
    data = json.load(g)

coords = []

for feature in data['geometries']:
    for coord in feature['coordinates']:
        for c in coord:
            if len(c) == 2:
                coords.append(c)
            else:
                for b in c:
                    if len(b) == 2:
                        coords.append(b)
                    else:
                        print b

#!/usr/bin/env python

# Haversine formula example in Python
# Author: Wayne Dyck

def distance(origin, destination):
    lon1, lat1 = origin
    lon2, lat2 = destination
    radius = 6371 # km

    dlat = math.radians(lat2-lat1)
    dlon = math.radians(lon2-lon1)
    a = math.sin(dlat/2) * math.sin(dlat/2) + math.cos(math.radians(lat1)) \
        * math.cos(math.radians(lat2)) * math.sin(dlon/2) * math.sin(dlon/2)
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
    d = radius * c

    return d

df = pd.read_csv('..\datasets\UFO_geo_2013-4.tsv', sep='\t')

df['MilitaryDist'] = 0

for index, row in df.iterrows():
    dists = []
    for item in coords:
        dists.append(distance((row['lon'], row['lat']), tuple(item)))
    print str(index) + ' : ' + str(min(dists))
    df.loc[index,'MilitaryDist'] = min(dists)

df.to_csv('..\datasets\UFO_MilitaryDist_2013-4.tsv', sep='\t')