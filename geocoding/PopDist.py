import math
import pandas as pd

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

pop = pd.read_csv('../datasets/US_populated_place.tsv',sep='\t',
                  header=None)
#print pop.head()

coords = []
for index, row in pop.iterrows():
    coords.append((row[5],row[4]))

df = pd.read_csv('..\datasets\UFO_MeterologicalDist_2013-4.tsv', sep='\t')

df['PopDist'] = 0

for index, row in df.iterrows():
    dists = []
    for item in coords:
        dists.append(distance((row['lon'], row['lat']), item))
    print str(index) + ' : ' + str(min(dists))
    df.loc[index,'PopDist'] = min(dists)

df.to_csv('..\datasets\UFO_PopDist_2013-4.tsv', sep='\t')