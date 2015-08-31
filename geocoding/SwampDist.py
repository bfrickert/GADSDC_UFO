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

swamp = pd.read_csv('../datasets/US_swamp.tsv',sep='\t',
                  header=None)

coords = []
for index, row in swamp.iterrows():
    coords.append((row[5],row[4]))

df = pd.read_csv('..\datasets\UFO_MeterologicalDist_2013-4.tsv', sep='\t')

df['SwampDist'] = 0

for index, row in df.iterrows():
    dists = []
    for item in coords:
        dists.append(distance((row['lon'], row['lat']), item))
    print str(index) + ' : ' + str(min(dists))
    df.loc[index,'SwampDist'] = min(dists)

df.to_csv('..\datasets\UFO_SwampDist_2013-4.tsv', sep='\t')

