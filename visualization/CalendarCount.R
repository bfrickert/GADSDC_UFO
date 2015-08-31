install.packages(c("devtools","RJSONIO", "knitr", "shiny", "httpuv"))
library(devtools)
install_github("mages/googleVis")
library(googleVis)
ufo.count.by.date <- count(ufo$Date.Date)
plot( 
  gvisCalendar(data=ufo.count.by.date, datevar="x", numvar="freq",
               options=list(
                 title="Calendar heat map of UFO Sighting Counts",
                 calendar="{cellSize:20,
                                 yearLabel:{fontSize:20, color:'#444444'},
                                 focusedCellColor:{stroke:'red'}}",
                 width=1190, height=820),
               chartid="Calendar")
)

mean(ufo.count.by.date$freq)
sd(ufo.count.by.date$freq)
var(ufo.count.by.date$freq)
median(ufo.count.by.date$freq)

