# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()
             
#Get CSV from URL from Federal Reserve Bank of St. Louis
download.file(url='https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1168&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=DTB3&scale=left&cosd=1995-12-20&coed=2018-12-21&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Daily&fam=avg&fgst=lin&fgsnd=2009-06-01&line_index=1&transformation=lin&vintage_date=2018-12-27&revision_date=2018-12-27&nd=1954-01-04',
              destfile='3monthTB.csv', method='curl')
dataframe = read.csv("3monthTB.csv", header = TRUE)

#Eliminate missing data (represented in file by ".") rows 
df = dataframe[dataframe$DTB3!=".", ]

#Format as dates and numeric
df$DATE = as.Date(df$DATE)
df$DTB3 = as.numeric(levels(df$DTB3))[df$DTB3]

#Plot and insert personalized X axis                    
plot(df$DATE,df$DTB3, type = "l", xlab = "Year", ylab = "Yield(%)", col = "blue3", frame = TRUE, xaxt='n')
axis.Date (1, at = seq(as.Date("1996-01-01"), as.Date("2016-01-01"), by = "+4 year"))

#Generate grid vertical and horizontal lines
abline(h = seq(0, 7, by = 1), lty = "dotted", lwd = 0.5, col = "grey")
abline(v = seq(as.Date("1996-01-01"), as.Date("2016-01-01"), by = "+4 year"), lty = "dotted", lwd = 0.5, col = "grey")

