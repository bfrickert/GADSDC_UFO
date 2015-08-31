

nrow(subset(ufo_model, Sw.Nearest == 0 & Met.Nearest == 0))/nrow(ufo_model)
mean(subset(ufo_model, Sw.Nearest == 0 & Met.Nearest == 0)$MilitaryDist)
mean(subset(ufo_model, Sw.Nearest == 0 & Met.Nearest == 0)$SwampDist)
mean(subset(ufo_model, Sw.Nearest == 0 & Met.Nearest == 0)$MeterologicalDist)
mean(subset(ufo_model, Sw.Nearest == 0 & Met.Nearest == 0)$is.Round)


mean(subset(ufo_model, Sw.Nearest == 0 & Met.Nearest == 1)$is.Round)

r <- ufo_model$is.Round
mean(r)
sd(r)
a <- t.test(r, alternative="two.sided", mu=0.5, conf.int=0.95)
a
xtab <- xtabs(~Mil.Nearest + is.Round, data=ufo_model)
typeof(xtab)
chi <- chisq.test(xtab)
chi
# p-value = .03685, so it is likely the case that whether or
# not a UFO is near a Military Installation is dependent
# on whether it is round or vice versa.
# There is no way they are independent.
# p-value is less than 5%, so it is unlikely the two variables
# are independent