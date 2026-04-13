#### Pre-Class ####

## Do we have any questions about class?

#### Basics ####

### The first thing we do is?

### Load our Packages ### 
library(tidyverse)
library(car)

### Load the Data ###
fed_reserve <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%2013%3A%20Interaction%20Terms/clark2013_edited.csv")


### Variable Descriptions ###
### 1. FEDFUNDS = the federal reserve's interest rate 
### 2. lag_FEDFUNDS = the last quarter's federal reserve interest rate 
### 3. democrat = whether a democrat is in the WH or not
### 4. election = the number of quarters until the next election 
### 5. inflation = the inflation rate in the current quarter

##### Interaction Term Basics #####

### Often in political science, we are interested in understanding how the effect
### of an x on y is conditional on some other feature

### Examples:

### 1. The probability of war when the country has high ethnic
###    fractionalization and is poor
### 2. The effect of inflation on incumbent vote share when a country has 
###    compulsor voting
### 3. The effect of party affiliation on liberalism when a member of Congress
###    is from the south


### All of these relationships represent the effect of some x on y in the presence
### of some other variable z

### If we want to run a regression when we have this relationship between x and
### y that is conditional on a z, we run a model that has an "interaction term"

### The most generic formula for that is:

###     y = intercept + x + z + x*z + controls + error

### In simpler terms, the way we explain this relationship between x and y
### based on z is by multiplying x and z to see how it affects y

#### Interaction Term Models ####

### Suppose that we think the inflation level determines whether the Federal 
### Reserve decides to increase interest rates (a pretty normal expectation)

### Your Turn ###
### How would we model this relationship controlling for the past level of 
### interest rate? 

model1 <- lm()
summary(model1)

### How would we interpret the relationship between inflation and interest rates?

### Your Turn ###
### How would we model the effect of the inflation rate on the Fed's 
### interest rate when we have a Democrat in the White House? 

model2 <- lm()
summary(model2)

#### Interpreting Interaction Terms ####

### One of the tricky things about interaction terms is that interpretation is 
### not the same as it was prior

### We lost the ability to interpret models the way we used to.
### We can no longer say: a one-unit change in X leads to a [xx units] change
### in Y. 

### With our generic model: Y = intercept + X + Z + X*Z + controls + error,
### the way we interpret x is now: a one-unit increase in X, when Z=0, leads to a 
### [coefficient/estimate value] change in Y

### The coefficient on X*Z represents the difference in the effects when Z goes from
### 0 to 1. 

### To get the whole effect of X on Y, conditional on Z in an interaction model,
### we have to do some addition. 

### In this model: Y = intercept + X + Z + X*Z + controls + error,
### we would interpret our coefficients as something like this:
### For a one-unit increase in X, there is a [X + X*Z coefficient] increase/decrease
### in Y, when Z = 1, all else equal. 

### Your Turn ###

### Going back to model2, how do we interpret the effect of inflation when
### a President is a Democrat on interest rates?

### Is there a way to interpret the effects of inflation when a President is a 
### Republican on interest rates?

summary(model2)

#### Hypothesis Testing & Interactions ####

### Because we are adding these two coefficients together, we cannot rely on the
### stars in the summary() function, stars *could* change when we add the 
### estimates together.

### To do this, we need to rely on the linearHypothesis() function in the car
## package.

### We do this in the following way:

linearHypothesis(model, c('X + X:Z = 0'))

### Your Turn ###

### How can we test if the effect of inflation with a Democratic president 
### affects the Fed's interest rate?