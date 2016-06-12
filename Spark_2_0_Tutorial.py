
# coding: utf-8

# In[89]:

from pyspark import SQLContext, SparkConf, SQLContext, sql
from pyspark.sql import functions
import matplotlib.pyplot as mpy 
mpy.style.use('ggplot')
get_ipython().magic(u'matplotlib inline')
from plotly.offline import download_plotlyjs, init_notebook_mode, iplot
from plotly.offline import plot
from plotly.graph_objs import *
import plotly.offline as py
import plotly.graph_objs as go
init_notebook_mode()
import pandas as pd
import requests
import cufflinks as cf
import numpy as np
import random
from pyspark.ml.feature import StringIndexer


# In[23]:

import sys
print (sys.version)
import pip
installed_packages = pip.get_installed_distributions()
installed_packages_list = sorted(["%s==%s" % (i.key, i.version)
     for i in installed_packages])
print(installed_packages_list)


# In[33]:

df = spark.read.csv("/Users/EM186023/Documents/Tools/Spark/spark-2.0.0-preview-bin-hadoop2.7/data/mllib/sample_tree_data.csv")
df_beers = spark.read.csv("/Users/EM186023/Documents/Tools/Spark/spark-2.0.0-preview-bin-hadoop2.7/data/mllib/beer_reviews.csv", header='true')
df_gdp_pd = pd.read_csv('https://plot.ly/~etpinard/191.csv')
#df_gdp = spark.createDataFrame(df_gdp_pd)

df_beers.count()
df.count()


# In[38]:

#f_gdp = spark.createDataFrame(df_gdp_pd,)
df_gdp_pd.dtypes
#df_gdp_pd[continent+'_Life Expentancy [in years]']


# In[4]:

print(type(df_beers))
df_beers.printSchema()
df_beers.take(3)


# In[4]:

df_1 = df_beers.where(df_beers.review_overall.isNotNull()).select(df_beers.review_overall)
df_1.printSchema()
df_to_pandas = df_1.groupBy("review_overall").count().orderBy("review_overall").toPandas()
string_indexer = StringIndexer(inputCol='review_overall', outputCol='review_overall_num')
df_2 = string_indexer.fit(df_1).transform(df_1)
df_2.printSchema()
df_beers = string_indexer.fit(df_beers).transform(df_beers)
df_beers.printSchema()


# In[6]:

#df_beers = df_beers.where(df_beers.review_overall.isNotNull()).select(df_beers.review_overall)
df_beers.createOrReplaceTempView("df_beers")
df_beers_pd = spark.sql("select beer_name,avg(review_overall_num) as avg_review_overall from df_beers                            group by beer_name").toPandas()
df_beers.select("beer_name").show()
df_beers.select("review_overall_num").show()
df_beers_pd2 = df_beers.groupBy("beer_name")                 .avg("review_overall_num")                 .withColumnRenamed("avg(review_overall_num)","avg_review_overall")                .toPandas()
df_beers_pd.describe()
df_beers_pd


# In[10]:

iplot(cf.datagen.lines().iplot(asFigure=True,
                               kind='scatter',xTitle='Dates',yTitle='Returns',title='Returns'))


# In[17]:

df = pd.read_csv('https://plot.ly/~etpinard/191.csv')
df.head(3)


# In[18]:

iplot({
    'data': [
        Scatter(x=df[continent+'_Life Expentancy [in years]'],
                y=df[continent+'_Gross Domestic Product per Capita [in USD of the year 2000]'],
                text=df[continent+'_text'],
                marker=Marker(size=df[continent+'_marker.size'], sizemode='area', sizeref=131868,),
                mode='markers',
                name=continent) for continent in ['Africa', 'Americas', 'Asia', 'Europe', 'Oceania']
    ],
    'layout': Layout(xaxis=XAxis(title='Life Expectancy'), yaxis=YAxis(title='GDP per Capita', type='log'))
}, show_link=False)


# In[9]:

data = Data([Histogram(x=df_2.toPandas()['review_overall'])])
py.iplot(data)


# In[41]:

iplot([Box(y = np.random.randn(50), showlegend=False) for i in range(45)], show_link=False)


# In[55]:

import urllib2
import json
#req = urllib2.Request("https://raw.githubusercontent.com/anabranch/Interactive-Graphs-with-Plotly/master/btd2.json")
#opener = urllib2.build_opener()
#f = opener.open(req)
#json = json.loads(f.read())
btd = spark.read.csv("babs_open_data_year_2/201508_trip_data.csv",header='true')
print(type(btd))
btd.count()


# In[52]:

btd.printSchema()
btd.registerTempTable("trips_df")
df2 = spark.sql("SELECT Duration as d1 from trips_df where Duration < 7200")
df2_df = btd.filter("Duration < 7200").select("Duration").alias("d1")


# In[60]:

data = Data([Histogram(x=df2.toPandas()['d1'])])
py.iplot(data)


# In[100]:

df3 = btd.filter("Duration < 2000").select("Duration").withColumnRenamed("Duration","d1")


# In[101]:

s1 = df2.sample(False, 0.05, 20)
s2 = df3.sample(False, 0.05, 2500)
data = Data([
        Histogram(x=s1.toPandas()['d1'], name="Large Sample"),
        Histogram(x=s2.toPandas()['d1'], name="Small Sample")
    ])


# In[103]:

py.iplot(data)


# In[105]:

dep_stations = btd.groupBy(btd['Start Station']).count().toPandas().sort_values('count', ascending=False)
dep_stations


# In[108]:

def transform_df(df):
    df['counts'] = 1
    df['Start Date'] = df['Start Date'].apply(pd.to_datetime)
    return df.set_index('Start Date').resample('D').sum()
pop_stations = [] # being popular stations - we could easily extend this to more stations
for station in dep_stations['Start Station'][:3]:
    temp = transform_df(btd.where(btd['Start Station'] == station).select("Start Date").toPandas())
    pop_stations.append(
        Scatter(
        x=temp.index,
        y=temp.counts,
        name=station
        )
    )
data = Data(pop_stations)
py.iplot(data)


# In[ ]:

trace0 = Scatter(
    x= df_beers_pd['beer_name'],
    y=df_beers_pd['avg_review_overall'],
    mode='markers',
    marker=dict(
        size=df_beers_pd['avg_review_overall'],
    )
)
data = [trace0]
py.iplot(data)


# In[ ]:

trace0 = Bar(
    x= df_beers_pd['beer_name'],
    y=df_beers_pd['avg_review_overall']
)
data = [trace0]
py.iplot(data)


# In[8]:

import squarify

x = 0.
y = 0.
width = 100.
height = 100.

values = [500, 433, 78, 25, 25, 7]

normed = squarify.normalize_sizes(values, width, height)
rects = squarify.squarify(normed, x, y, width, height)

# Choose colors from http://colorbrewer2.org/ under "Export"
color_brewer = ['rgb(166,206,227)','rgb(31,120,180)','rgb(178,223,138)',
                'rgb(51,160,44)','rgb(251,154,153)','rgb(227,26,28)',
                'rgb(253,191,111)','rgb(255,127,0)','rgb(202,178,214)',
                'rgb(106,61,154)','rgb(255,255,153)','rgb(177,89,40)']
shapes = []
annotations = []
counter = 0

for r in rects:
    shapes.append( 
        dict(
            type = 'rect', 
            x0 = r['x'], 
            y0 = r['y'], 
            x1 = r['x']+r['dx'], 
            y1 = r['y']+r['dy'],
            line = dict( width = 2 ),
            fillcolor = color_brewer[counter]
        ) 
    )
    annotations.append(
        dict(
            x = r['x']+(r['dx']/2),
            y = r['y']+(r['dy']/2),
            text = values[counter],
            showarrow = False
        )
    )
    counter = counter + 1
    if counter >= len(color_brewer):
        counter = 0

# For hover text
trace0 = go.Scatter(
    x = [ r['x']+(r['dx']/2) for r in rects ], 
    y = [ r['y']+(r['dy']/2) for r in rects ],
    text = [ str(v) for v in values ], 
    mode = 'text',
)
        
layout = dict(
    height=700, 
    width=700,
    xaxis=dict(showgrid=False,zeroline=False),
    yaxis=dict(showgrid=False,zeroline=False),
    shapes=shapes,
    annotations=annotations,
    hovermode='closest'
)

# With hovertext
figure = dict(data=[trace0], layout=layout)
#data = [trace0]
py.iplot(figure)
# Without hovertext
# figure = dict(data=[Scatter()], layout=layout)


# In[10]:

type(rects)


# In[13]:

rects


# In[15]:

import pylab
from matplotlib.patches import Rectangle
class Treemap:
    def __init__(self, tree, iter_method, size_method, color_method):
        """create a tree map from tree, using itermethod(node) to walk tree,
        size_method(node) to get object size and color_method(node) to get its 
        color"""

        self.ax = pylab.subplot(111,aspect='equal')
        pylab.subplots_adjust(left=0, right=1, top=1, bottom=0)
        self.ax.set_xticks([])
        self.ax.set_yticks([])

        self.size_method = size_method
        self.iter_method = iter_method
        self.color_method = color_method
        self.addnode(tree)

    def addnode(self, node, lower=[0,0], upper=[1,1], axis=0):
        axis = axis % 2
        self.draw_rectangle(lower, upper, node)
        width = upper[axis] - lower[axis]
        try:
            for child in self.iter_method(node):
                upper[axis] = lower[axis] + (width * float(size(child))) / size(node)
                self.addnode(child, list(lower), list(upper), axis + 1)
                lower[axis] = upper[axis]

        except TypeError:
            pass

    def draw_rectangle(self, lower, upper, node):
        print lower, upper
        r = Rectangle( lower, upper[0]-lower[0], upper[1] - lower[1],
                   edgecolor='k',
                   facecolor= self.color_method(node))
        self.ax.add_patch(r)


if __name__ == '__main__':
    # example using nested lists, iter to walk and random colors

    size_cache = {}
    def size(thing):
        if isinstance(thing, int):
            return thing
        if thing in size_cache:
            return size_cache[thing]
        else:
            size_cache[thing] = reduce(int.__add__, [size(x) for x in thing])
            return size_cache[thing]
    import random
    def random_color(thing):
        return (random.random(),random.random(),random.random())
    
tree= ((5,(3,5)), 4, (5,2,(2,3,(3,2,2)),(3,3)), (3,2) )
Treemap(tree, iter, size, random_color)
pylab.show()


# In[ ]:



