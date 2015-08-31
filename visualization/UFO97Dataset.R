ufo <- read.table(".\\datasets\\ufo_awesome.tsv", sep="\t", fill=TRUE, as.is=TRUE)
names(ufo) <- c("sighted_at","reported_at", "location", "shape", "duration", "description")
ufo <- cbind(ufo, substring(as.character(ufo$sighted_at),1,4))
colnames(ufo)[7] <- "year"
ufo97 <- subset(ufo, year == 1997) # creates a subset of those UFO sightings reported in 1997
states <- substr(as.character(ufo97$location), nchar(as.character(ufo97$location))-2+1, nchar(as.character(ufo97$location)))
ufo97 <- cbind(ufo97, states)
ufo97$month <- as.numeric(substr(ufo97$sighted_at, 5, 6))
ufo97$day <- as.numeric(substr(ufo97$sighted_at, 7, 8))
ufo97[order(ufo97$reported_at),]$location
ufo97$sighted_dt <- as.Date(paste(as.character(ufo97$month), paste(as.character(ufo97$day), as.character(ufo97$year), sep="/"), sep="/"), "%m/%d/%Y")

#install.packages("plyr")
library(plyr)
x <- count(ufo97$states) # count by state
x <- x[order(x$freq, decreasing=TRUE),]
x <- subset(x, x!='),' & x!='a,')

# 1407 Total in 1997
# 7081 Total in 2013

install.packages("ggmap")
library(ggmap)
as.data.frame(x)
colnames(x)[1] <- "statecode"
x$lon <- geocode(as.character(x$statecode))$lon
x$lat <- geocode(as.character(x$statecode))$lat
usmap <- qmap('united states', zoom=4,extent='panel')
usmap+geom_point(aes(x=lon, y=lat, size=freq, color=freq), data=x, alpha=1, zoom=13)
