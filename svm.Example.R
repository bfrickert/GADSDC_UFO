install.packages("kernlab")
library(kernlab)
data(spam)
str(spam)
dim(spam)
table(spam$type)
randIndex <- sample(1:dim(spam)[1])
summary(randIndex)
cutPoint2_3 <- floor(2 * dim(spam)[1]/3)
trainData <- spam[randIndex[1:cutPoint2_3],]
testData <- spam[randIndex[(cutPoint2_3+1):dim(spam)[1]],]
svmOutput <- ksvm(type ~ ., data=trainData,
                  kernel="rbfdot",kpar="automatic",C=50,cross=3,prob.model=TRUE)
hist(alpha(svmOutput)[[1]])
alphaindex(svmOutput)[[1]][alpha(svmOutput)[[1]]<0.05]
trainData[90,]
svmPred <- predict(svmOutput, testData, type="votes")
compTable <- data.frame(testData[,58],svmPred[1,])
table(compTable)