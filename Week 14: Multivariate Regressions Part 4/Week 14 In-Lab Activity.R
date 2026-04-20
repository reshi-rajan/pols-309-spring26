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

#### Regressions w/ Different Types of Data ####

## Logging data is one of the most common transformations of our variables.
## We can log our outcomes, our treatments/independent variables, or both!

## When we do this, the interpretation of our outcomes changes.
## This is because logs change the scale we use, which means a one-unit increase
## does not lead to a one-unit increase in Y.

### Interpretation with Logs ### 

## There are 4 different interpretations we can think about:

          ## Y = intercept + X + error

## 1. linear-linear: This is our classic approach. Here, a one-unit increase in
##      in X leads to a [estimate] [increase/decrease] in Y, all else equal.

          ## log(Y) = intercept + X + error

## 2. log-linear: A one-unit increase in X is associated with a [estimate x100]
##      percent [increase/decrease] in Y, all else equal

          ## Y = intercept + log(X) + error

## 3. linear-log: A one-percent increase in X is associated with a [estimate/100]
##      [increase/decrease] in Y

          ## log(Y) = intercept + log(X) + error

## 4. log-log: A one-percent increase in X is associated with a [estimate] percent
##      [increase/decrease] in Y

#### Estimating Equations ####

### For this part, let's estimate the relationship between inflation and interest rates
### controlling for election time, past interest rate, and whether a 
### Democrat or a Republican is in office.

### Linear-Linear

model1 <- lm()

summary(model1)

## Interpretation?

### Log-Linear 

model2 <- lm()

summary(model2)

## Your Turn: Interpretation:

### Linear-Log

model3 <- lm()

summary(model3)

## Your Turn: Interpretation: 

### Log-Log

model4 <- lm()

summary(model4)

## Your Turn: Interpretation:


### Which of these is the best?
par(mfrow = c(2, 2))
lapply(list(model1, model2, model3, model4), function(x) plot(x, which = 1))


#### Polynomials ####

### For this, let's return to our Senate data:

### Load the Data ###
senate <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%2011%3A%20Multivariate%20Regressions%20Part%201/senate_expanded.csv")

### The Key Variables Are:

# inc_2p_share -> incumbents share of 2PP
# inc spend -> dollars spent by incumbent
# ch_spend -> dollars spent by challenger
# inc_tenure -> number of years the incumbent held office
# ch_qual -> measure of challenger quality
# ch_wealthy -> dummy variable if challenger is wealthy (1)
# inc_pos -> measure of ideology (higher = conservative)
# st_uemp -> state unemployment rate

## Maybe we have a theory that the incumbent vote share is caused by the incumbent's
## ideology, the state unemployment rate, and the quality of the challenger.

### How would we run this model?

model5 <- lm()

summary(model5)

## This model does a lot for us, but our measure of ideology has more conservative people
## closer to 1 and more liberal people closer to -1, this means moderates are near 0
## maybe we think then that people that are more moderate are more likely to win

## We could test that by squaring our values. 

## We can run the following:

model6 <- lm(inc_2p_share ~ inc_pos + I(inc_pos^2) + st_uemp + ch_qual, data = senate)

## To interpret the effect of incumbent position on vote share, the summary()
## function is no longer very helpful. Instead, we need to use the marginal effects

#install.packages('marginaleffects')
library(marginaleffects)

AME <- avg_slopes(model6,
             variables = "inc_pos")

print(c('Effect' = AME$estimate, 
        'SE' = AME$std.error, 
        't-value' = AME$statistic, 
         'p-value' = AME$p.value))

## To test this and get a p-value, we can do the following:

linearHypothesis(model6, c('inc_pos=0', 'I(inc_pos^2)=0'))
