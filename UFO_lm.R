rmse <- function(x, y) {
  return(sqrt(mean((x-y)^2)))
}
randIndex <- sample(1:dim(ufo)[1])
cutPoint2_3 <- floor(2 * dim(ufo)[1]/3)
train <- ufo[randIndex[1:cutPoint2_3],]
test <- ufo[randIndex[(cutPoint2_3+1):dim(ufo)[1]],]

linear.fit <- lm(MeterologicalDist ~ MilitaryDist, data=train)

rmse(train$MeterologicalDist, predict(linear.fit))

summary(linear.fit)

plot(linear.fit)

plot(MeterologicalDist ~ MilitaryDist, data=train)

abline(linear.fit, col="red")

plot(MeterologicalDist - predict(linear.fit) ~ MeterologicalDist, data=train)

plot(linear.fit, 1)

plot(ufo[,c(10:18)], pch=19, col=ufo$MilitaryDist)
round(cor(ufo[,c(10:18)])^2, 2)

head(model.matrix(MeterologicalDist ~ MilitaryDist, data=train))

ggplot(train, aes(y=log(MeterologicalDist), x=log(MilitaryDist))) + geom_point()
log.fit <- lm(log(MeterologicalDist) ~ log(MilitaryDist), data=train)
summary(log.fit)

library(glmnet)
x=model.matrix(MeterologicalDist ~ MilitaryDist, data=train) 
y=train$MeterologicalDist

fit.ridge=glmnet(x, y, alpha=0)
plot(fit.ridge, xvar="lambda", label=TRUE)

set.seed(102)
cv.ridge=cv.glmnet(x, y, alpha=1, nfolds=10)
plot(cv.ridge)

fit.lasso=glmnet(x, y)
plot(fit.lasso, xvar="lambda", label=TRUE)

set.seed(42)
cv.lasso=cv.glmnet(x, y, nfolds=10)
plot(cv.lasso)
coef(cv.lasso)

cv.lasso$lambda.min
head(predict(cv.lasso,x ,s=cv.lasso$lambda.1se))
rmse(train$MeterologicalDist, predict(cv.lasso,x ,s=cv.lasso$lambda.1se))
plot(predict(cv.lasso,x ,s=cv.lasso$lambda.1se))

mean(train$MeterologicalDist - predict(cv.lasso,x ,s=cv.lasso$lambda.1se))
median(train$MeterologicalDist - predict(cv.lasso,x ,s=cv.lasso$lambda.1se))


