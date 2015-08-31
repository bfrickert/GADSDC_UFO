UFO Predictor OR UFO Recommendation Engine
=========
Not sure who my customer is yet with this one. Do I want to help those who would seek to capture our extraplanetary visitors and perform autopsies on them, or would I like to recommend places that other UFO's seem to enjoy visiting?


The Datasets
--------------
I've scraped the National UFO Reporting Center's Web Site and have captured information for each reported UFO siting since January 1, 2013. There are almost 13,000 of them.

Here's what the data looks like:

```r
SightingDate	City	State	Shape	Duration	Summary
1/31/13 23:30	Naples	FL	Light	30 seconds	Large Ball of orange light with no sound.
1/31/13 23:00	Brewton	AL	Flash	45 minutes off and on	Fireballs flashing like fireworks on the Florida/Alabama state line 1/31/13.
1/31/13 22:30	Lake Havasu City	AZ	Circle	15 minutes	What are these bright orange orbs in the sky here over Lake Havasu City, AZ????
1/31/13 22:00	Monterey	CA	Flash	25 minutes	While videoing at the Orion area I saw some large flashing lights don't no what they are. No airplanes!
1/31/13 21:00	Mount Vernon	AR	Disk	10 minutes	Extremely large with large bright strobe lights hovering just above the horizon, disappearing instantly.
1/31/13 21:00	Glenside	PA	Triangle	2-3 minutes	2 Triangular Low Flying Craft in Glenside PA.
1/31/13 19:45	Albuquerque	NM	Light	1-3 minutes	Unexplainable steady light moves horizontally then disappears.

```
Using the City and state data, I then derive the latitude and longitude with the geocoder package!

```r
from geopy.geocoders import Nominatim
geolocator = Nominatim()

df = pd.read_csv('datasets\UFO2013-4.tsv', sep='\t')

for index, row in df.iterrows():
    try:
        lon = geolocator.geocode(row['FullLocation'], timeout=60).longitude
        lat = geolocator.geocode(row['FullLocation'], timeout=60).latitude
    except AttributeError:
        lon = 0
        lat = 0
```

Next, I downloaded a shapefile of military installations from data.gov and converted it to a geojson file using mapshaper.org. That leaves me with the job of isolating all the coordinates from the file into a python list.

```r
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
```

And using this list I try to find the distance of each sighting from a military installation.

```r
def distance(origin, destination):
    lat1, lon1 = origin
    lat2, lon2 = destination
    radius = 6371 # km

    dlat = math.radians(lat2-lat1)
    dlon = math.radians(lon2-lon1)
    a = math.sin(dlat/2) * math.sin(dlat/2) + math.cos(math.radians(lat1)) \
        * math.cos(math.radians(lat2)) * math.sin(dlon/2) * math.sin(dlon/2)
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
    d = radius * c

    return d
```

That's where I am. Next up is calculating distances between the sightings and other landmarks: golf courses, self storage facilities, etc.