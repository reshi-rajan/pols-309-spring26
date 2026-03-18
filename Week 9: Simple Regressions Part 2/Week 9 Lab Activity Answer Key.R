#### Pre-Class ####

## Do we have any questions about class?

#### Basics ####

### The first thing we do is?

### Load our Packages ### 
library(tidyverse)

### Load the Data ###
pres_vote <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%208%3A%20Simple%20Regressions/PresVote.csv")

### Create the Variables from last class ###
pres_vote <- pres_vote %>%
  mutate(inc_pres_party = ifelse(year == 1948 | year == 1952 | year == 1964 |
                                   year == 1968 | year == 1980 | year == 1996 |
                                   year == 2000 | year == 2012, 1, 0))

pres_vote <- pres_vote %>%
  mutate(winner = ifelse(year == 1948 | year == 1960 | year == 1964 |
                           year == 1976 | year == 1992 | year == 1996 |
                           year == 2008 | year == 2012, 1, 0))

#### Review ####

### Covariances, Correlations, and Regressions ###

## Last time, we talked about how covariance is really good at helping us 
## understand if two variables move together (at all).
## This is great but what about the strength of that movement -> enter correlations.
## To now understanding how much a variable moves BECAUSE of the other variable(s)
## Enter: Regression. Here we say, yeah we think these variable(s) move together,
## but how much of that can we explain vs how much can we not explain? 

## In essence, covariances are in a correlation and a correlation is in a regression
## We use a regression because it models out the unexplainable part of the world.

#### Regressions Basics ####

## From last time we stated there were three assumptions we need for a regression:
## 1. Our model is linear (everything is additive)
## 2. Our *observations* are all independent
## 3. We have exogeneity (or more descriptively, no endogeneity)

## Which of these did we say was the worst one to violate?

# We said the third one, exogeneity, was probably the worst one to violate.
# This is because exogeneity includes concepts like reverse causality and omitted variable bias,
# we do not have a natural way to fix/correct for that stuff so we make an assumption
# that we cannot really verify. 

#### Getting to the Math ####

## Anyone have a good POLS 209 definition of a regression? 

# Any 209 definition that describes OLS as a line of best fit probably worked, 
# but to understand at a deeper the levels the assumption undergirding regression
# we will need to talk about the sum of squared residuals.

## POLS 309: What are we trying to estimate? 

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
## whether the income of Americans causes them to vote for Republicans or Democrats? 
## We want to control for the year and for if the incumbent is a Democrat or Republican. 

model <- lm(winner ~ rdi4 + year + inc_pres_party, data = pres_vote)

summary(model)

#### Interpreting a Regression ####

## You probably remember from 209 that we have a somewhat standard way of interpreting
## coefficients from a regression model.

### Your Turn ###

## How do we interpret the effect of income on presidential vote share here? 

