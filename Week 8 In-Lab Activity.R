#### Pre-Class ####

## Do we have any questions about class?

#### Basics ####

## The first thing we do is load our working directory:

### Load our Packages ### 
library(tidyverse)

### Load the Data ###
pres_vote <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%208%3A%20Simple%20Regressions/PresVote.csv")

#### Correlations ####

## Correlations are statistics that explain how related two variables are to each other.

## They have a few special properties:
## 1. They must be between -1 and 1 (with values at |1| being strongest and those near 0 being weakest)
## 2. They are functions of tht variance and covariance 

## In R, suppose we want to know the correlation between being a Democratic President
## and the income of Americans. 

## Looking at our dataset, what do we need first?

## How do we create this variable?

## We can test the correlation of this using the following: 

cor.test(pres_vote$Inc_Pres_Party, pres_vote$rdi4)

## How do we create a variable that tells us who the winner is? 

#### Regressions Basics ####

## Correlations are nice because they can tell us how two variables move together,
## but they tell us nothing about which one causes the other to move, if at all,
## whether the effect of one on the other is noise or really something,
## or if this relationship really being driven by something else.

## To get to claims about how an X -> Y, we need some assumptions about our data

## Class Assumptions:

## 1. Our model is linear (everything is additive)
## 2. Our *observations* are all independent
## 3. We have exogeneity (or more descriptively, no endogeneity)

## With these three assumptions, most models will give us claims about the world
## that are causal in nature.

## Our models are normally of the form: Y = a + b_1*X + b_2*Z + b_3*W + e

## What is going on here in this model? 

## What are we trying to estimate? 

## The sum of squared residuals is essentially a method of taking our covariates (all together)
## and moving them into the world of our dependent variable (outcome) in a way 
## where the distance between the covariates and our outcome are as small as possible.
## We often will not get exactly in to the space, but we want to get as close as possible.

#### Running a Regression ####

## To run a regression in R, we need three things:

## 1. A dependent variable (outcome)
## 2. An independent variable (treatment)
## 3. Most importantly: A dataframe

### Your Turn ###
## How do we estimate a regression in R where we are interested in the 
## whether a the income of Americans causes them to vote for Republicans or Democrats? 
## We want to control for the year and for if the incumbent is a Democrat or Republican. 