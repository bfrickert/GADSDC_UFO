

#pretty cool
library(lattice)
xyplot(MilMet.diff + MilSw.diff ~ Day | is.Round,
       data = ufo_lm,
       type = c("p", "r"),
       col.line = c("black", "darkorange"))

xyplot(MilMet.diff ~ MilitaryDist, ufo_lm)

ggplot(ufo_lm, aes(x = Day, y = jitter(MilMet.diff), group = Month)) + 
  ggtitle("Difference in Distance from Military Installation vs. Distance from Meteorological Station (by Month)") + 
  geom_line() +
  geom_line(mapping = aes(y = jitter(MilMet.diff)), lty = "dashed", colour="red") +
  #geom_line(mapping = aes(y = MilSw.diff), lty = "dashed") +
  #geom_line(mapping = aes(y = MilMet.diff), lty="dashed" lwd = 0.3, colour = "red") +
  facet_wrap( ~ Month) +
  theme_bw() +
  theme(plot.title = element_text(lineheight=.8, face="bold"))

boxplot(MilMet.diff ~ is.Round, data=subset(ufo_lm, MilMet.diff<0))
