## Validation Set Approach
# Good idea to use set.seed() with CV due to randomness
library(ISLR)
set.seed(1)
train=sample(392,196)
#hist(train)
lm.fit=lm(mpg~horsepower,data=Auto,subset=train)
lm.fit
attach(Auto)
mean((mpg-predict(lm.fit,Auto))[-train]^2) # 26.14
lm.fit2=lm(mpg~poly(horsepower,2),data=Auto,subset=train)
mean((mpg-predict(lm.fit2,Auto))[-train]^2)
lm.fit3=lm(mpg~poly(horsepower,3),data=Auto,subset=train)
mean((mpg-predict(lm.fit3,Auto))[-train]^2)

## Leave-One-Out Cross-Validations
# glm() without family=binomial does lm()
# There is cv.glm() available that does LOOCV
# Use the boot library for cv.glm()
glm.fit=glm(mpg~horsepower,data=Auto)
coef(glm.fit)
lm.fit=lm(mpg~horsepower,data=Auto)
coef(lm.fit)
library(boot)
glm.fit=glm(mpg~horsepower,data=Auto)
cv.err=cv.glm(Auto,glm.fit)
cv.err$delta # (1/n) * Summation of MSE from LOOCV
# Iterate five times
cv.error=rep(0,5)
for (i in 1:5) {
  glm.fit=glm(mpg~poly(horsepower,i),data=Auto)
  cv.error[i]=cv.glm(Auto,glm.fit)$delta[1]
}
cv.error

## k-Fold Cross-Validation
# cv.glm() can be used to implement k-fold CV
set.seed(17)
cv.error.10=rep(0,10)
for (i in 1:10) {
  glm.fit=glm(mpg~poly(horsepower,i),data=Auto)
  cv.error.10[i]=cv.glm(Auto,glm.fit,K=10)$delta[1]
  # for k-Fold CV the first $delta is the regular value,
  # the second $delta is the bias adjusted value
}
cv.error.10

## Bootstrap
# Two steps: 
# 1) Create a function that computers the statistics of interest
# 2) Use the boot() function in the boot library
alpha.fn=function(data,index){
  X=data$X[index]
  Y=data$Y[index]
  return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
}
alpha.fn(Portfolio,1:100)
set.seed(1)
# we could run this command many times but boot automates it
# something like: alpha.fn(Portfolio,sample(100,100,replace=T))
boot(Portfolio,alpha.fn,R=1000) ###
# Shows original, std. error is SE(alpha); bias isn't explained.
boot.fn=function(data,index)
  return(coef(lm(mpg~horsepower,data=data,subset=index)))
boot.fn(Auto,1:392)
set.seed(1)
boot.fn(Auto,sample(392,392,replace=T))
boot.fn(Auto,sample(392,392,replace=T))
boot(Auto,boot.fn,1000) ### Bootstrap estimate
coef(lm(mpg~horsepower,data=Auto)) # Standard way
boot.fn=function(data,index)
  coefficients(lm(mpg~horsepower+I(horsepower^2),data=data,subset=index))
set.seed(1)
boot(Auto,boot.fn,1000)
coef(lm(mpg~horsepower+I(horsepower^2),data=Auto)) # Standard way