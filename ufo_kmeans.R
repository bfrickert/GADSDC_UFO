randIndex <- sample(1:dim(ufo_lm)[1])
cutPoint2_3 <- floor(2 * dim(ufo_lm)[1]/3)
train <- ufo_lm[randIndex[1:cutPoint2_3],]
test <- ufo_lm[randIndex[(cutPoint2_3+1):dim(ufo_lm)[1]],]


ufo_train = cbind(train$MilitaryDist, train$MeterologicalDist, train$SwampDist, train$MallDist, train$StorDist)
ufo_test <- cbind(test$MilitaryDist, test$MeterologicalDist, test$SwampDist, test$MallDist, test$StorDist)

party <- kmeans(ufo_train, 2)



table(cl_predict(party, ufo_test), test$is.Round)
