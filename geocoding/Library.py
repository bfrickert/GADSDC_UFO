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

lib = pd.read_csv('../datasets/US_library.tsv',sep='\t',
                  header=None)

coords = []
for index, row in lib.iterrows():
    coords.append((row[5],row[4]))

df = pd.read_csv('..\datasets\UFO_MallDist_2013-4.tsv', sep='\t')

df['LibDist'] = 0

for index, row in df.iterrows():
    dists = []
    for item in coords:
        dists.append(distance((row['lon'], row['lat']), item))
    print str(index) + ' : ' + str(min(dists))
    df.loc[index,'LibDist'] = min(dists)

df.to_csv('..\datasets\UFO_LibDist_2013-4.tsv', sep='\t')