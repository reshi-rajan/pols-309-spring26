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

## In R, suppose we want to know the correlation between being an incumbent Democratic President
## and the income of Americans. 

## Looking at our dataset, what do we need first?

## How do we create this variable? 

pres_vote <- pres_vote %>%
  mutate(Inc_Pres_Party = ifelse(year == 1948 | year == 1952 | year == 1964 |
                                   year == 1968 | year == 1980 | year == 1996 |
                                   year == 2000 | year == 2012, 1, 0))

## We can test the correlation of this using the following: 

cor.test(pres_vote$Inc_Pres_Party, pres_vote$rdi4)

# We can see here that the correlation between a Democratic incumbent and income.
# is nearly 0, suggesting that there is not a strong association between the two

## How do we create a variable that tells us who the winner is? 

pres_vote <- pres_vote %>%
  mutate(winner = ifelse(year == 1948 | year == 1960 | year == 1964 |
                           year == 1976 | year == 1992 | year == 1996 |
                           year == 2008 | year == 2012, 1, 0))

#### Simple Regressions ####

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

