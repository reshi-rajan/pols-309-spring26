######## Week 7 Lab ########

#### Basics ####

### What is the first thing we do? ###
setwd("C:/Users/reshi/Dropbox/POLS 309 - Polimetrics/POLS 309")

### Load the Libraries ###
library(tidyverse)

#### Data Time ####

### Load the Data ###
data <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%205%3A%20Hypothesis%20Testing/terrorism1.csv")

### Summary Statistics ###

specialized_summary <- function(df) { # the braces tell R these are all the arguments we will use 
  if (is.vector(df)) { # if tells us that if this particular structure pops up, do this process
    df <- data.frame(variable = df)
  }
  
  stats <- c("Min", "Average", "Variance", "Stnd_Devtn", "Max") # naming a set of columns 
  results <- data.frame(Statistic = stats) # create this output called results, it will be a dataframe that stores our stats
  
  for (col in names(df)) { # for each variable in the list of variables we supply, we ask R to do the following
    x <- df[[col]] # for each subset value in df, call that x; here that represents each variable in the list of things we supply
    
    col_stats <- c(
      min(x, na.rm = TRUE),
      mean(x, na.rm = TRUE),
      var(x, na.rm = TRUE),
      sd(x, na.rm = TRUE),
      max(x, na.rm = TRUE)
    ) # for each variable we supply, calculate these descriptive stats, remove NAs, and combine them into an object called col_stats
    
    results[[col]] <- col_stats # store the descriptive statistics into each row per variable in a dataframe we call results
  }
  
  return(results) # returns us these descriptive stats per variable supplied
}


### Your Turn ###

## Your Turn: How do we calculate summary stats for domestic attacks (domAttacks) and 
## the number of civilians killed (nkill)?

specialized_summary(data$domAttacks)

specialized_summary(data$nkill)

data %>% # R look at this dataframe
  select(domAttacks, nkill) %>% # specifically look at these 2 variables 
  specialized_summary() %>% # use the function we created
  knitr::kable(
    digits = 3,
    caption = "Summary statistics",
    format = "html"
  ) %>%
  cat(file = "Week7_Summary.html")

#### t-tests ####

## When do we do a t-test? 

# When we sample the population instead of using the whole population 

### How could we do a t-test to determine the relationship between the 
### domestic attacks and the number of people killed? 

t.test(domAttacks ~ demo, data = data )

#### z-tests ####

## We use a z-test when we have the whole population or approximately close to the population

#### Math to Remember ####
# 1. Bayes Theorem - P(A|B) = (P(B|A)P(A))/P(B)
# This is super useful when we need to calculate conditional probabilities 

# 2. The Binomial Coefficient - (n choose k)
# This is useful when we want to find the subset (k) of a number of items n where our ordering does not make matter
# (n choose k) = n!/(k!(n-k)!)

# 3. The Normal Distribution is really useful for random samples from a population.
# It has two values: the mean and the variance. It allows us to calculate z-scores
# once standardized meaning we can compare values that may not come from the same sample. 
# Make sure you understand how to use probability distributions, what does the area under the curve represent,
# if we want to find out the area up to a certain point, what is that?

# Remember that in tidyverse, the following commands are super useful:
# a. select() allows us to choose specific variables in our dataframe we want to use
# b. mutate() lets us create new variables from existing ones
# c. filter() allows to select *observations* based on some value: observations of a variable that are less than ten filter(variable < 10)

# 4. Remember that for tidyverse, we specify our dataframe name followed by the pipe %>% (the and sign in the R language) 
# once we have done that we don't have to use the dataframe$variable syntax, we can just write the variable name until we end the command

# 5. Review our notes on hypothesis testing --- let me know if we need slides! 