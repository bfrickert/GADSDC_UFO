ufo <- read.csv("c:/users/bfrickert/documents/github/thedatanomicon/glackel/gadsdc/project/datasets/UFO2013-4.tsv", sep="\t", header=TRUE, fill=TRUE, as.is=TRUE)
ufo$X <- NULL

install.packages("ggmap")
library(ggmap)
#as.data.frame(ufo)

ufo.sub <- ufo[1:2,]

ufo.sub$lon <- geocode(paste(ufo$City, ufo$State, sep=", "))$lon

write.table(ufo.sub, "github/thedatanomicon/glackel/gadsdc/project/UFO_geo_2013-4.tsv", sep="\t")