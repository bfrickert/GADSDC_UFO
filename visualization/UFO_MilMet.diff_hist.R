library(plyr)
less.than <- 100
fav.Mil <- subset(ufo, MilitaryDist < MeterologicalDist & abs(MilMet.diff) < less.than)
fav.Met <- subset(ufo, MilitaryDist > MeterologicalDist & abs(MilMet.diff) < less.than)
nrow(fav.Mil)
nrow(fav.Met)

fav.Mil.cnt <- count(fav.Mil$is.Round)
fav.Met.cnt <- count(fav.Met$is.Round)

fav.Mil.cnt

fav.Mil.cnt[2,2]/(fav.Mil.cnt[1,2]+fav.Mil.cnt[2,2])  -
fav.Met.cnt[2,2]/(fav.Met.cnt[1,2]+fav.Met.cnt[2,2])

cut2 <- function(x, breaks) {
  r <- range(x)
  b <- seq(r[1], r[2], length=2*breaks+1)
  brk <- b[0:breaks*2+1]
  mid <- b[1:breaks*2]
  brk[1] <- brk[1]-0.01
  k <- cut(x, breaks=brk, labels=FALSE)
  mid[k]
}
ufo$bin <- cut2(ufo$MilMet.diff,25)

hist(ufo$bin)

library(ggplot2)
ggplot(ufo, aes(x=bin, fill=as.factor(is.Round))) + 
  geom_histogram(binwidth=2.5, alpha=.5, position="identity")

ggplot(subset(ufo, abs(ufo$MilMet.diff) < less.than), aes(x=MilMet.diff, fill=as.factor(is.Round))) + 
  geom_histogram(binwidth=.5, alpha=.5, position="identity")

ggplot(subset(ufo, abs(ufo$MilMet.diff) < less.than), aes(x=bin, fill=as.factor(is.Round))) + 
  geom_histogram(binwidth=5.5, alpha=.5, position="identity")

ggplot(subset(ufo, abs(ufo$MilMet.diff) < less.than), aes(x=MilMet.diff, fill=as.factor(is.Round))) + 
  geom_density(alpha=.3) +
  theme_bw() +
  geom_vline(data=ufo, 
             aes(xintercept=MilMet.diff.mean.by.Roundness,  
                 colour=as.factor(is.Round)),
             linetype="dashed", size=1)
