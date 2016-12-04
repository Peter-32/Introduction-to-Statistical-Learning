## Stock Market Data
library(ISLR)
names(Smarket)
dim(Smarket)
head(Smarket)
summary(Smarket)
cor(Smarket) # Error, all predictors must be numeric
cor(Smarket[,-9])
attach(Smarket)

## Logistic Regression
# glm() fits generalized linear models
# We must pass in argument family=binomial
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,
            data=Smarket, family=binomial)
contrasts(Direction) # Up 1, down 0
summary(glm.fit) # lowest p-value is Lag1
# negative coefficient here means up/down, down/up relationship Lag1 vs Direction
coef(glm.fit) # Better than running summary
summary(glm.fit)$coef # More calculations required
summary(glm.fit)$coef[,4] # More calculations required
glm.probs=predict(glm.fit,Smarket.2005,type="response") # type="response gives Prob(Y|X)
# Without type="response" it gives log-odds for family=binomial
glm.probs[1:10]
contrasts(Direction) # Up 1, down 0
glm.pred=rep("Down",1250)
glm.pred[glm.probs>.5]="Up"  # we predict up if higher than 50% prediction probability for Up
table(Direction,glm.pred)

printDiagnosticTable2Class <- function(response,pred) {
  diagnosticTable = table(response,pred)
  print(diagnosticTable)
  print("False Pos. Rate:")
  print(diagnosticTable[1,2]/(diagnosticTable[1,1]+diagnosticTable[1,2]))
  print("True Pos. Rate:")
  print(diagnosticTable[2,2]/(diagnosticTable[2,1]+diagnosticTable[2,2]))
  print("Pos. Pred. Value:")
  print(diagnosticTable[2,2]/(diagnosticTable[1,2]+diagnosticTable[2,2]))
  print("Accuracy Rate:")
  print((diagnosticTable[1,1]+diagnosticTable[2,2])/sum(diagnosticTable))
}

printDiagnosticTable2Class(glm.pred,Direction)
mean(glm.pred==Direction)

## Training and Test Set
train=(Year<2005)
Smarket.2005=Smarket[!train,]
dim(Smarket.2005)
Direction.2005=Direction[!train]
summary(Direction.2005)
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,
            data=Smarket, family=binomial,subset=train)
#Now we check the test set below
checkTestSetBinomial <- function(fit,testSet,responseVar) {
  glm.probs=predict(fit,testSet,type="response")
  glm.pred=rep("Down",252)
  glm.pred[glm.probs>.5]="Up"
  printDiagnosticTable2Class(responseVar,glm.pred)
# rate correct: mean(glm.pred==Direction.2005)
  print("Error Rate:")
  print(mean(glm.pred!=responseVar))
}

checkTestSetBinomial(glm.fit,Smarket.2005,Direction.2005)

# Training with less variables below
glm.fit2=glm(Direction~Lag1+Lag2,
            data=Smarket, family=binomial,subset=train)
checkTestSetBinomial(glm.fit2,Smarket.2005,Direction.2005)
# Predict new data
predict(glm.fit2,newdata=data.frame(Lag1=c(1.2,1.5),
                                   Lag2=c(1.1,-0.8)),type="response")
anova(glm.fit,glm.fit2)

## Linear Discriminant Analysis (LDA)
library(MASS)
lda.fit=lda(Direction~Lag1+Lag2,data=Smarket,subset=train)
lda.fit
plot(lda.fit)
lda.pred=predict(lda.fit, Smarket.2005)
lda.pred
# Use something like this to predict class only if probability above a threshold like .1 instead of .5
length(Direction.2005[lda.pred$posterior[,2]>.60])
# lda.pred gives the prediction with 50% rule, probabilities, and the computation of the
# coefficients multiplied by the predictors added together.  If above 0 then predict positive class for 2 class.
# In multi-class, the Bayes classifier assigns an observation to the class in which the equation is the largest.
sum(lda.pred$posterior[,1]>.9)

## Quadratic Discriminant Analysis
# implemented identical to lda in R
qda.fit=qda(Direction~Lag1+Lag2,data=Smarket,subset=train)
qda.fit
# predict works the same as lda
qda.class=predict(qda.fit, Smarket.2005)$class
table(Direction.2005,qda.class)
mean(qda.class==Direction.2005)

## K-Nearest Neighbors
# Four inputs required for knn()
# train and test x, train response, and K
library(class)
train.X=cbind(Lag1,Lag2)[train,]
test.X=cbind(Lag1,Lag2)[!train,]
train.Direction=Direction[train]
set.seed(1)
knn.pred=knn(train.X,test.X,train.Direction,k=3)
printDiagnosticTable2Class(Direction.2005,knn.pred)

## Caravan Insurance Example
# 6% of pople purchased caravan insurance
dim(Caravan)
attach(Caravan)
summary(Purchase)
348/5822
standardized.X=scale(Caravan[,-86])
var(Caravan[,1])
var(Caravan[,2])
var(standardized.X[,1])
var(standardized.X[,2])
# split into training and test sets
test=1:1000
train.X=standardized.X[-test,]
test.X=standardized.X[test,]
train.Y=Purchase[-test]
test.Y=Purchase[test]
set.seed(1)
knn.pred=knn(train.X,test.X,train.Y,k=1)
mean(test.Y!=knn.pred)
mean(test.Y!="No")
knn.pred2=knn(train.X,test.X,train.Y,k=3)
knn.pred3=knn(train.X,test.X,train.Y,k=5)
# Diagnostic tabs
printDiagnosticTable2Class(test.Y,knn.pred)
printDiagnosticTable2Class(test.Y,knn.pred2)
printDiagnosticTable2Class(test.Y,knn.pred3)

## Using Logistic Regression on the Caravan Dataset
glm.fit=glm(Purchase~.,data=Caravan,family=binomial,subset=-test)
glm.probs=predict(glm.fit,Caravan[test,],type="response")
glm.pred=rep("No",1000)
glm.pred[glm.probs>.5]="Yes"
printDiagnosticTable2Class(test.Y,glm.pred)
glm.pred2=rep("No",1000)
glm.pred2[glm.probs>.25]="Yes"
printDiagnosticTable2Class(test.Y,glm.pred2)
