#### Pre-Class ####

## Do we have any questions about class?

#### Basics ####

### The first thing we do is?

setwd("~/POLS 309")

### Load our Packages ### 
library(tidyverse)
library(car)

### Load the Data ###
Congress_112 <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%2012%3A%20Multivariate%20Regressions%20Part%202/congress2011.csv")

### The Key Variables Are:

# nominate_dim1 - capturing economic policy ideology
# nominate_dim2 - capturing social policy ideology (primarily slavery & then civil rights)
# state_abbrev - the state a Congressperson represented
# chamber - House or Senate
# region - what region of the US they represented

#### Multivariate Regressions ####

### Let's suppose we want to run a regression where we are interested in if 
### being a newly elected Congressperson is more ideological? 

### To do this, let's run two separate models, one where the outcome is the
### Congressperson's economic ideology and the other is the Congressperson's 
### social ideology. We want our treatment to be whether they are newly elected.
### It is also likely that the median income of their district and region they are from 
### are likely to also influence the outcome,
### let's select on these observables and include them in the model.

### Your Turn ###

### Run these two models:

model1 <- lm(nominate_dim1 ~ newly.elected + medianIncome +region, data = Congress_112)
summary(model1)

model2 <- lm(nominate_dim2 ~ newly.elected + medianIncome + region, data = Congress_112)
summary(model2)

## What do these models tell us about the relationship between being newly elected and 
## ideological leaning on economics and social issues?

# The difference between an incumbent and a newly elected member is about a 0.03 point
# increase in conservative economic views, all else equal (not statistically signficant).

# The difference between an incumbent and a newly elected member is about a 0.033 point
# decrease (more liberal) view on social issues. 

## What does the region variable tell us?

# It tells us which region the congressional district is classified as.

#### Diagnostic Tests #### 

### VIF Scores & R^2_j Values ###

### To test if we have covariates in our model that are overlapping each other, 
### we can check the vif (variance inflation factor) level, If the leve is 
### more than 10, we likely have multi-collinearity.

vif(model1)
vif(model2)

### To get the R^2_j from the model, we can take the vif value from the code above
### and use the following formula; R^2_j = 1 - (1/vif)

### Your Turn ###
### In Model 1, what is the R^2_j for median income? 

1 - (1/1.273)

### F-Statistic ### 

## The F-Statistic represents an omnibus test that allows us to understand
## whether running our model is better than doing nothing at all. 

## The way we can check the F-Stat is looking at the bottom of our regression
## output from the summary() function:

summary(model1)

## The very last line in this output is F-statistic. 
## The p-value on this tell us whether running this model is better than no model.
## The same threshold works here where a p-value < 0.05 tell us whether
## this model is better than no model.

### Your Turn ### 

## Is model1 better than no model? 

# Yes, model1 is better than letting all the coefficents be 0.

#### Reference Categories #### 

## Suppose that we are interested in setting one of our regions to be our 
## reference category.
## This does not have to be theoretical, we might be interested in setting a 
## particular baseline because it makes more sense for us to interpret our 
## coefficients relative to a particular value. 

## For example, suppose we believe the members of the House that are from the South
## are more likely to be conservative on social issues (e.g. Southern Democrats). 
## In that case, we might want to set our reference to be every category relative
## to being in the South. 

## To do that in R, we do the following: 

factor(variable,
       levels = c('level one', 'level two',
                  'level three', 'level four'))

## Note: you put the variable you want to exclude (i.e. be the reference) first

### Your Turn ### 

## How do we rewrite model1 and model2 to where the south is excluded/reference
## category?

Congress_112$region <- factor(Congress_112$region,
       levels = c('south',
                  'northeast',
                  'midwest',
                  'west'))


model3 <- lm(nominate_dim1 ~ newly.elected + medianIncome + factor(region), data = Congress_112)
summary(model3)

model4 <- lm(nominate_dim2 ~ newly.elected + medianIncome + factor(region), data = Congress_112)
summary(model4)


#### Using Model Summary ####

install.packages('modelsummary')
install.packages('pandoc')
library(modelsummary)

## Model Summary is a great package for making pretty, publication-ready
## regression tables. 

## We can make a modelsummary table of the four regressions we ran like so:

modelsummary(list(model1, model2, model3, model4),
             coef_map = c("newly.elected"="Newly elected",
                          "medianIncome" = "Income",
                          "factor(region)midwest" = "Midwest",
                          "factor(region)northeast" = "Northeast",
                          "factor(region)south" = "South",
                          "factor(region)west" = "West",
                          "(Intercept)" = "Intercept"),
             title = "Differences in Ideology between New and Incumbent Congresspeople",
             notes = c("Standard errors in parentheses"),
             output = "week_12_example.docx", ## save the output to a file
             gof_omit = c("IC|Log|Adj"), #Only include fit measures we covered
             stars = c('*' = 0.1, '**' = 0.05, '***' = 0.001)
             )
