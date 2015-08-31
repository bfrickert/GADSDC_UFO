randIndex <- sample(1:dim(ufo)[1])
cutPoint2_3 <- floor(2 * dim(ufo)[1]/3)
train <- ufo[randIndex[1:cutPoint2_3],]
test <- ufo[randIndex[(cutPoint2_3+1):dim(ufo)[1]],]


model <- glm(is.Round ~ MilitaryDist * Season * MeterologicalDist + SwampDist + 
               StorDist + GolfDist + Met.Nearest + Mil.Nearest + lat + lon + Hour +
               AirportDist * Month * MallDist + LibDist + HospitalDist
             , data=train, family="binomial")
model <- glm(is.Round ~ MilitaryDist + MeterologicalDist + Season + SwampDist +
               AirportDist + StorDist + MallDist + HospitalDist + Hour + LibDist + lat + lon #+ City
             , data=train, family="binomial")
model <- glm(is.Round ~ MilitaryDist + MeterologicalDist
             , data=train, family="binomial")
summary(model)

logodds <- predict(model, test)
probs <- predict(model, test, type="response")


#head(data.frame(actual=ufo$is.Round, prediction=probs))

suppressPackageStartupMessages(library('ROCR'))
pred <- prediction(predictions=probs, labels=test$is.Round)
acc <- performance(pred, measure='acc')
plot(acc)
prec <- performance(pred, measure='prec')
plot(prec)
rec <- performance(pred, measure='rec')
plot(rec)
roc <- performance(pred, 'tpr', 'fpr')
plot(roc)
auc <- performance(pred, measure='auc')
auc@y.values[[1]]

