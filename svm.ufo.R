#install.packages("kernlab")
library(kernlab)
randIndex <- sample(1:dim(ufo)[1])

str(ufo)
ufo_svm <- ufo[,c(10:18,28)]
trainData <- ufo[randIndex[1:200],]
testData <- ufo[randIndex[251:300],]
table(trainData$is.Round)

svmOutput <- ksvm(is.Round ~ ., data=trainData,
                  kernel="rbfdot",kpar="automatic",C=5,cross=3,prob.model=TRUE)
hist(alpha(svmOutput)[[1]])
alphaindex(svmOutput)[[1]][alpha(svmOutput)[[1]]<0.05]
trainData[90,]
svmPred <- predict(svmOutput, testData, type="votes")
table(Predicted=svmPred,Reference=testData$is.Round)
compTable <- data.frame(testData$is.Round,svmPred[1,])
table(compTable)

svmPred[1,]
