x <- ddply(ufo_lm, .(Date), summarize, mean.Hour=mean(Hour, na.rm=TRUE))

plot(mean.Hour ~ Date, data=x)


ggplot(x, aes(x=Date, y=mean.Hour, ylab="No. of Sightings")) + 
  geom_line(data = x, aes(x=Date, y=mean.Hour, colour="green"), show_guide=FALSE)


m <- ddply(ufo_lm, .(Date), summarize, mean.MilitaryDist=mean(MilitaryDist, na.rm=TRUE), 
           mean.SwampDist=mean(SwampDist, na.rm=TRUE), 
           mean.MetDist=mean(MeterologicalDist, na.rm=TRUE))

ggplot(m, aes(x=Date, y=mean.MilitaryDist, ylab="No. of Sightings")) + 
  geom_line(data = m, aes(x=Date, y=mean.MilitaryDist - mean.MetDist, colour="blue"), show_guide=FALSE)

mean(m$mean.MilitaryDist - m$mean.MetDist)

m.round <- ddply(subset(ufo_lm, is.Round==TRUE), .(Date), summarize, mean.MilitaryDist=mean(MilitaryDist, na.rm=TRUE), 
                 mean.SwampDist=mean(SwampDist, na.rm=TRUE), 
                 mean.MetDist=mean(MeterologicalDist, na.rm=TRUE))
m.not.round <- ddply(subset(ufo_lm, is.Round==FALSE), .(Date), summarize, mean.MilitaryDist=mean(MilitaryDist, na.rm=TRUE), 
                 mean.SwampDist=mean(SwampDist, na.rm=TRUE), 
                 mean.MetDist=mean(MeterologicalDist, na.rm=TRUE))

ggplot(m.round, aes(x=Date, y=mean.MilitaryDist, ylab="No. of Sightings")) + 
  geom_line(data = m, aes(x=Date, y=mean.MilitaryDist - mean.MetDist, colour="blue"), show_guide=FALSE)

ggplot(m.not.round, aes(x=Date, y=mean.MilitaryDist, ylab="No. of Sightings")) + 
  geom_line(data = m, aes(x=Date, y=mean.MilitaryDist - mean.MetDist, colour="blue"), show_guide=FALSE)

mean(m.round$mean.MilitaryDist - m.round$mean.MetDist)
mean(m.not.round$mean.MilitaryDist - m.not.round$mean.MetDist)

m.shape <- ddply(ufo_lm, .(Shape), summarize, mean.MilitaryDist=mean(MilitaryDist, na.rm=TRUE), 
                     mean.SwampDist=mean(SwampDist, na.rm=TRUE), 
                     mean.MetDist=mean(MeterologicalDist, na.rm=TRUE))
m.shape$Difference <- m.shape$mean.MilitaryDist-m.shape$mean.MetDist
m.shape <- m.shape[order(m.shape$Difference), ]


ggplot(m.shape, aes(x=Shape, y=Difference, ylab="No. of Sightings")) + 
  geom_boxplot(aes(colour="black"), show_guide=FALSE)


ufo_lm <- ufo_lm[order(ufo_lm$is.Round), ]

m.month <- ddply(ufo_lm, .(Month), summarize, mean.MilitaryDist=mean(MilitaryDist, na.rm=TRUE), 
                 mean.SwampDist=mean(SwampDist, na.rm=TRUE), 
                 mean.MetDist=mean(MeterologicalDist, na.rm=TRUE))

ggplot(ufo_lm, aes(x=SightingDate, y=(MilMet.diff), ylab="No. of Sightings")) + 
  #geom_boxplot(aes(colour="green"), show_guide=FALSE) +
  geom_line(stat="identity", aes(color="green")) +
  theme_bw()


ggplot(subset(ufo_lm, is.Round==TRUE), aes(x=Shape, y=(MilMet.diff), ylab="No. of Sightings")) + 
  geom_boxplot(aes(colour="black"), show_guide=FALSE) +
  theme_bw()

ggplot(subset(ufo_lm, is.Round==FALSE), aes(x=Shape, y=(MilMet.diff), ylab="No. of Sightings")) + 
  geom_boxplot(aes(colour="black"), show_guide=FALSE) +
  theme_bw()


