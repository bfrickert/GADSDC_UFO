library(plyr)
x <- count(as.Date(ufo$SightingDate, format='%m/%d/%Y %H:%M')) # count by Date
x <- data.frame(x)
colnames(x) <- c('SightingDate', 'freq')
x$Category <- 1

x <- ddply(x, "Category", transform,
      Growth=c(NA, exp(diff(log(freq)))-1))
x <- data.frame(x)

install.packages("ggplot2")
library(ggplot2)
ggplot(x, aes(x=SightingDate, y=freq, ylab="No. of Sightings")) + 
  geom_line(data = x, aes(x=SightingDate, y=((Growth * 10) + 300), colour="black"), show_guide=FALSE) +
  geom_boxplot(aes(colour="black"), show_guide=FALSE) +
  geom_bar(stat="identity", aes(colour="green"), show_guide=FALSE) +
  ylab("Number of Sightings") + 
  xlab("Sighting Dates") + 
  ggtitle("Number of Sightings From Jan, 2013 to August 2014 \n(w/ superimposed growth rate)") + 
  theme_bw() +
  theme(axis.text = element_text(colour = "red", size=rel(1.1))) +
  theme(axis.title.x = element_text(size = rel(.9), angle = 0)) +
  theme(axis.title.y = element_text(size = rel(.9), angle = 90)) +
  theme(plot.title = element_text(lineheight=.8, face="bold"))
