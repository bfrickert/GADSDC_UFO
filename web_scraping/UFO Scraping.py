
# coding: utf-8

# In[117]:

import requests
from BeautifulSoup import BeautifulSoup
import pandas as pd
import time


# In[118]:

dates = ['201301', '201302', '201303', '201304', '201305', '201306', 
         '201307', '201308', '201309', '201310', '201311', '201312', 
         '201401', '201402', '201403', '201404', '201405', '201406', 
         '201407', '201408']


# In[119]:

def scrapeUFOSightings(date):
    url = "http://www.nuforc.org/webreports/ndxe{0}.html".format(date)
    response = requests.get(url)
    soup = BeautifulSoup(response.text)
    table = soup.findAll('table')
    values = []
    for row in soup.findAll('tr'):
        cells = row.findAll('td')
        #For each "tr", assign each "td" to a variable.
        if len(cells) > 0:
            sightingdt = cells[0].find(text=True)
            City = cells[1].find(text=True)
            State = cells[2].find(text=True)
            Shape = cells[3].find(text=True)
            Duration = cells[4].find(text=True)
            Summary = cells[5].find(text=True)
            values.append([sightingdt, City, State, Shape, Duration, Summary])
    df = pd.DataFrame(values)
    return df


# In[ ]:

df = pd.DataFrame()
for date in dates:
    df = df.append(scrapeUFOSightings(date))


# In[29]:

df.columns = ['SightingDate','City','State','Shape', 'Duration', 'Summary']
df.to_csv('UFO2013-4.tsv', sep='\t')

