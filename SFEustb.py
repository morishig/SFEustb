import requests
import pandas as pd
import io
import matplotlib.pyplot as plt

#Get CSV from URL from Federal Reserve Bank of St. Louis and read as Panda series
r=requests.get('https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1168&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=DTB3&scale=left&cosd=1995-12-20&coed=2018-12-21&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Daily&fam=avg&fgst=lin&fgsnd=2009-06-01&line_index=1&transformation=lin&vintage_date=2018-12-28&revision_date=2018-12-28&nd=1954-01-04')
s = r.content
df = pd.read_csv(io.StringIO(s.decode('utf-8')))

#Eliminate missing data (represented in file by ".") rows
df = df[df.DTB3 != '.' ]

#Format as dates and numeric
df.DATE = pd.to_datetime(df['DATE'], format='%Y-%m-%d')
df.set_index(['DATE'],inplace=True)
df.DTB3 = pd.to_numeric(df['DTB3'])

#Level axes
plt.xlabel('Year')
plt.ylabel('Yield (%)')

#Plot, generate grid, and display plot
plt.plot(df.index,df.DTB3, color='blue')
plt.grid(linestyle='dotted')
plt.show()


