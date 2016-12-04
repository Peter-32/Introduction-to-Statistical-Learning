## Setup
setwd("/Users/peterjmyers/Documents/Personal/Data Science/Machine Learning/ISL/R Labs")
getwd()
source("file.r") # runs r file
rm(list=ls()) # Remove all variables
rm(x,y) # Remove x and y variables
ls() # List the variables

## Some commands
# funcname(input1, input2) to use functions
# c() to concatenate
x <- c(1,2,5)
y = c(1,4,3)
length(x)
x+y
?matrix # see help page
x=matrix(data=c(1,2,3,4), nrow=2, ncol=2)
x
sqrt(x)
x^2

## cor(), rnorm(), and set.seed()
x=rnorm(50)
y=x+rnorm(50,mean=50,sd=.1)
cor(x,y)
set.seed(1303)

## mean(), var(), and sd()
set.seed(3)
y=rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)

## plot(), pdf(), and jpeg()
?plot
x=rnorm(100)
y=rnorm(100)
plot(x,y)
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y")
plot(x,y,type="p",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # points
plot(x,y,type="l",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # lines
plot(x,y,type="b",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # both
plot(x,y,type="c",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # lines alone of b
plot(x,y,type="o",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # overplotted
plot(x,y,type="h",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # histogram
plot(x,y,type="s",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # stair steps
plot(x,y,type="S",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # other steps
plot(x,y,type="n",xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y") # no plotting
pdf("Figure.pdf")
plot(x,y,col="green")
dev.off()

## seq(), contour(), image(), and persp()
seq(1,10)
1:10
x=seq(-pi,pi,length=50)
?contour
y=x
f=outer(x,y,function(x,y)cos(y)/(1+x^2))
contour(x,y,f)
contour(x,y,f,nlevels=45,add=T)
fa=(f-t(f))/2
contour(x,y,fa,nlevels=15)
image(x,y,fa)
persp(x,y,fa)
persp(x,y,fa,theta=30)
persp(x,y,fa,theta=30,phi=20)
persp(x,y,fa,theta=30,phi=70)
persp(x,y,fa,theta=30,phi=40)

## Indexing data
A=matrix(1:16,4,4)
A
A[2,3]
A[c(1,3),c(2,4)]
A[1:3,2:4]
A[1:2,]
A[,1:2]
A[1,]
A[-c(1,3),]
dim(A)

## Loading data
Auto=read.table("Auto.txt",header=T,na.strings="?") # Read in the data
# fix(Auto) lets you update the data.frame was a spreadsheet
Auto=na.omit(Auto) # one way to remove missing data
names(Auto) # Get column names
dim(Auto) # Get observation count and column count
# write.table() # Writes the output to a file

## Using the data
attach(Auto)
plot(cylinders, mpg) # optionally can do plot(Auto$cylinders, Auto$mpg) even if not attached
cylinders=as.factor(cylinders) # Cast a column to be a factor
# Plot with categorical x-axis data will be a boxplot by default
# Boxplot:
plot(cylinders, mpg)
plot(cylinders, mpg, col="red")
plot(cylinders, mpg, col="red", varwidth=T)
plot(cylinders, mpg, col="red", varwidth=T, horizontal=T)
plot(cylinders, mpg, col="red", varwidth=T, xlab="cylinders",ylab="MPG")
# Histogram:
hist(mpg)
hist(mpg,col=2)
hist(mpg,col=2,breaks=15)
# Scatterplot:
pairs(Auto)
pairs(~ mpg + displacement + horsepower + weight + acceleration, Auto)
plot(horsepower,mpg)
identify(horsepower, mpg, name) # interactive method for identifying the value for a particular variable for points on a plot
# Summaries:
summary(Auto) # Summary of each variable in the particular data set
fivenum(mpg) # five number summary
mean(mpg)
