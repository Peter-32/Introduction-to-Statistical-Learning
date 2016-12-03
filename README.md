# Introduction-to-Statistical-Learning

# Topics
# Basics
1) Supervised, unsupervised, reinforce
2) Matrix algebra often used due to many predictors
3) Problem: Non-linear data, use polynomial regression
4) Problem: correlated epsilons, recollect data
5) Problem: Funnel shape fitted vs residuals, Log or sqrt transform
6) Problem: outliers, consider removing if gt. 3 sd.
7) Problem: high leverage points, Hat test, remove if too far above average of (p+1)/n
8) Problem: Collinearity, a simple form of confounding (the effect of interaction) in which two predictors are highly correlated, remove one or combine them into one predictor variable
9) KNN for Qualititative or Quantitative response variable, Linear regression, logistic regression, LDA, and QDA
10) Bootstrapping is when you create multiple models based on the original data set sampled with replacement

# Model selection and model evaluation
1) Best subset of predictors
2) staircase selection (forward, backwards, or hybrid)
3) Estimate Test error with Cp, AIC, BIC, or adjusted R-squared OR use CV
4) One standard deviation rule.  It is good to choose the least flexible model that is within one standard deviation from the lowest test error estimate using CV
5) Shrinking
6) Ridge regression and lasso
7) Dimension Reduction M+1 < P+1
8) PCA
9) Always standardize PCA
10) Partial Least Squares is not worth it, use PCA or ridge regression instead

# Nonlinear
1) Basis functions, polynomial regression
2) Step functions
3) Regression splines
4) Smoothing splines, penalty term is integration of second derivative of f 
5) Local regression, bell shape
6) GAM (Generalized additive models)

# Decision Trees
1) Different levels, quantitative splits are based on minimized RSS; end condition could be five or less observations per leaf
2) CV prunes the tree and finds the optimum lambda.  Builds largest tree, then removes the weakest link one at a time to get all amounts of flexibility, then CV chooses the best one
3) Purity summation of (p)(1-p) used to help split the data for qualitative response variables because RSS won't work
4) Decision trees are good for nonlinear or complicated data
5) Bagging - uses bootstrap to get observations for 100 (configurable number) decision trees.  Average the result when predicting new data.  Qualitative response could generate the ratio and you can use a decision boundary.  Estimate test error by predicting all observations on the trees that didn't have that observation.
6) Average the variable importance of each p across the bagged decision trees to understand how much each variable plays a role.  The total RSS is reduced when split by one variable or total Gini index is decreased by splits for each p
7) random forests - improved bagging by decorrelating trees by considering a random m predictors at each split where m is approximately equal to sqrt(p), when deciding the split based on a predictor
8) Boosting decision trees - Trees grown sequentially.  Learning rate lambda and B trees found by CV, d splits per tree where d=1 works well.  Trees pop up based on previous trees and focuses on the residuals still in play.  Boosting is when model fitting learns slowly.

# Support Vectors
1) Maximal margin classifier; finds the boundary line and finds the maximum margin so everything is on the right side of the margin.
2) Support vectors.  The points near/on the margin that affect maximal margin classifier heavily
3) Support vector classifiers could be on wrong side of margin or hyperplane.  Tune C with CV.  Has less sensitivity for obs far away.
4) Support vector machines, enlargest feature space
5) Kernals, polynomial kernals and radial kernals
6) 2 classes only, compare 2 clases or one-versus-all
7) Hinge Loss - similar to ridge and lasso and is like SVM
8) Support Vector Regression

# Unsupervised Learning
1) PCA
2) Biplot
3) Scree Plot
4) K-Means clustering and heirarchical clustering
5) Vertical height of fusing important
6) Complete lnking and average linking are good
7) correlation cluster and Euclidean  distinct cluster