ufo_Mets <- subset(subset(ufo_model, Shape!='Other'), MeterologicalDist < SwampDist & MeterologicalDist < MilitaryDist)
mean(ufo_Mets$is.Round)

ufo_Rounds <- subset(subset(ufo_model, Shape!='Other'), is.Round == 1)
ufo_Rounds$Met.Closest <- ifelse(ufo_Rounds$MeterologicalDist < ufo_Rounds$SwampDist & ufo_Rounds$MeterologicalDist < ufo_Rounds$MilitaryDist, 1 ,0)
mean(ufo_Rounds$Met.Closest)
