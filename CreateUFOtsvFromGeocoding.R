setwd('C:\\Users\\bfrickert\\Documents\\GitHub\\TheDatanomicon\\Glackel\\GADSDC\\project')
ufo <- read.csv('datasets/UFO_LibDist_2013-4.tsv', sep='\t')

ufo <- subset(ufo[,12:ncol(ufo)], lon!=0)

ufo$Shape[ufo$Shape == ''] <- "Other"

t <- strptime(ufo$SightingDate, "%m/%d/%Y %H:%M")
d <- strptime(ufo$SightingDate, "%m/%d/%Y")
#install.packages('lubridate')
library(lubridate)
t.lub <- ymd_hms(t)
ufo$Hour <- hour(t.lub)
ufo$Season <- as.factor(ifelse(month(t.lub) %in% c(1:2,12), 'Winter', 
                     ifelse(month(t.lub) %in% c(3:5), 'Spring', 
                            ifelse(month(t.lub) %in% c(6:8), 'Summer', 'Autumn'))))
ufo$Month <- month(t.lub)
ufo$Date <- d
ufo$Date <- as.Date(ufo$Date)
ufo$Year <- year(t.lub)
ufo$Day <- day(t.lub)

ufo$Date.Date <- as.Date(paste(ufo$Year + 2000, ufo$Month, ufo$Day, sep="/"))


ufo <- na.omit(ufo)

ufo <- subset(ufo, MilitaryDist < 100)
ufo <- subset(ufo, MeterologicalDist < 100)

ufo$MilSw.diff = ufo$MilitaryDist - ufo$SwampDist
ufo$MilMet.diff = ufo$MilitaryDist - ufo$MeterologicalDist
ufo$MetSw.diff = ufo$MeterologicalDist - ufo$SwampDist

ufo$is.Round <- ifelse(ufo$Shape == "Circle" | ufo$Shape == "Disk" | ufo$Shape == "Shere" | ufo$Shape == "Teardrop" | 
                               ufo$Shape == "Sphere" | ufo$Shape == "Egg" | ufo$Shape == "Fireball" | ufo$Shape == "Cigar" | ufo$Shape == "Oval"
                       , 1, 0)

ufo$Sw.Nearest <- ufo$SwampDist < ufo$MilitaryDist & ufo$SwampDist < ufo$MeterologicalDist
ufo$Met.Nearest <- ufo$MeterologicalDist < ufo$MilitaryDist & ufo$MeterologicalDist < ufo$SwampDist
ufo$Mil.Nearest <- ifelse(ufo$Sw.Nearest==0 & ufo$Met.Nearest==0, TRUE, FALSE)

ufo$mil.to.swamp.pref.rating <- ufo$SwampDist/ufo$MilitaryDist
ufo$mil.to.swamp.pref.units <- abs(ufo$MilSw.diff/ufo$MilitaryDist)
ufo$mil.to.met.pref.rating <- ufo$MeterologicalDist/ufo$MilitaryDist
ufo$mil.to.met.pref.units <- abs(ufo$MilMet.diff/ufo$MilitaryDist)


ufo$MilMet.diff.mean.by.Roundness = 0

ufo <- within(ufo, MilMet.diff.mean.by.Roundness[is.Round==0] <- mean(MilMet.diff[is.Round==0]))
ufo <- within(ufo, MilMet.diff.mean.by.Roundness[is.Round==1] <- mean(MilMet.diff[is.Round==1]))

write.table(ufo, file='datasets/ufo.tsv', sep='\t')

ufo <- subset(ufo, Shape != 'Other')
ufo_csv <- ufo
ufo_csv <- ufo_csv[,!names(ufo_csv) %in% c("Summary", "FullLocation")]
write.csv(ufo_csv, file='datasets/ufo.csv')

