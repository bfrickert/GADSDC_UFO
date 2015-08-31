import pandas as pd
from geopy.geocoders import Nominatim
geolocator = Nominatim()

df = pd.read_csv('datasets\UFO2013-4.tsv', sep='\t')

df['FullLocation'] = df.City.map(str) + ", " + df.State.map(str)

df = df.dropna(subset=['City'], how='all')
df = df.dropna(subset=['State'], how='all')
df = df.dropna(subset=['FullLocation'], how='all')

lon = 0
for index, row in df.iterrows():
    try:
        lon = geolocator.geocode(row['FullLocation'], timeout=60).longitude
    except AttributeError:
        lon = 0
    df.loc[index,'lon'] = lon
    print str(index) + " : " + str(lon)

df.lon.tail()

df['lat'] = 0
df.head()

lat = 0
for index, row in df.iterrows():
    try:
        lat = geolocator.geocode(row['FullLocation'], timeout=60).latitude
    except AttributeError:
        lat = 0
    df.loc[index,'lat'] = lat
    print str(index) + " : " + str(lat)

df.lat.tail()

df.to_csv('datasets\UFO_geo_2013-4.tsv', sep='\t')