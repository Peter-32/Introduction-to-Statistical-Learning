## install.packages installs the packages

## library loads libraries after installed
library(MASS)
library(ISLR)

## Simple Linear Regression
fix(Boston)
names(Boston)
?Boston
lm.fit=lm(medv~lstat,data=Boston)
attach(Boston)
lm.fit=lm(medv~lstat)
summary(lm.fit)
names(lm.fit)
coef(lm.fit)
confint(lm.fit)
predict(lm.fit,data.frame(lstat=c(5,10,15)),
        interval="confidence")
predict(lm.fit,data.frame(lstat=c(5,10,15)), #wider interval due to epsilons
        interval="prediction")
plot(lstat,medv)
abline(lm.fit)
