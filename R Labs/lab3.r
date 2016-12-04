## install.packages installs the packages

## library loads libraries after installed
library(MASS)
library(ISLR)
library(car)

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

## Plots
plot(lstat,medv)
abline(lm.fit)
abline(lm.fit,lwd=3)
abline(lm.fit,lwd=3,col="red")
plot(lstat,medv,col="red")
plot(lstat,medv,pch=20)
plot(lstat,medv,pch="+")
plot(lstat,medv,pch=1:20)
par(mfrow=c(2,2))
plot(lm.fit)
plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))

## Multiple Linear Regression
lm.fit=lm(medv~lstat+age,data=Boston)
summary(lm.fit)
lm.fit=lm(medv~.,data=Boston) # fit all other columns as predictors
summary(lm.fit)
names(summary(lm.fit))
summary(lm.fit)$r.sq
summary(lm.fit)$sig
lm.fit1=lm(medv~.-age,data=Boston) # fit all other columns as predictors but one
summary(lm.fit1)

## VIF and hat values
vif(lm.fit) # from library(car)
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))

## Interaction Terms 
# lstat:block includes an interaction term
# lstat*block includes an interaction term and the individual terms
summary(lm(medv~lstat*age,data=Boston))

## Non-linear Transformations of the Predictors
# I() is needed because ^ has a special meaning in a formula
lm.fit2=lm(medv~lstat+I(lstat^2))
summary(lm.fit2) # suggests it is an improved model
lm.fit=lm(medv~lstat)
anova(lm.fit,lm.fit2)
# anova is a statistical test to see if the model has improved
# Null hypothesis: Both models fit the data equally well
# Alternative hypothesis: The second model fits the data better
# The F value of 135 provides clear evidence that model 2 is far superior to model 1.

## Polynomial fit to the fifth power shortcut:
lm.fit5=lm(medv~poly(lstat,5))
summary(lm.fit5)
anova(lm.fit2,lm.fit5)

## Qualitative Predictors
names(Carseats)
head(Carseats)
dim(Carseats)
# dummy variables are made by default for multi-class predictors
attach(Carseats)
contrasts(ShelveLoc) # shows the dummy variables R uses
?contrasts

## Creating our own functions
LoadLibraries = function(){
  library(ISLR)
  library(MASS)
  print("The libraries have been loaded.")
}

LoadLibraries
