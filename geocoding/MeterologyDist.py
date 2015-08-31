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

df = pd.read_csv('..\datasets\UFO_AirportDist_2013-4.tsv', sep='\t')

coords = []
for index, row in df.iterrows():
    coords.append((row['lon'],row['lat']))

met = pd.read_csv('../datasets/US_meteorological_station.tsv',sep='\t',
                  header=None)


met_dicts = []

for index, row in met.iterrows():
    dicts = {}
    dists = []
    for item in coords:
        dists.append(distance((row[5], row[4]), item))
    j = [i for i in dists if i <=10]
    dicts['name'] = row[1]
    dicts['count'] = len(j)
    dicts['lon'] = row[5]
    dicts['lat'] = row[4]
    dicts['state'] = row[10]
    met_dicts.append(dicts)

met_df = pd.DataFrame(met_dicts)
met_df.to_csv('..\datasets\MeteorologicalCounts.tsv', sep='\t')