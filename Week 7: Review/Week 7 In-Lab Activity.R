######## Week 7 Lab ########

#### Basics ####

### What is the first thing we do? ###

### Load the Libraries ###
library(tidyverse)

#### Data Time ####

### Load the Data ###
data <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%205%3A%20Hypothesis%20Testing/terrorism1.csv")

### Summary Statistics ###

specialized_summary <- function(df) {
    if (is.vector(df)) {
    df <- data.frame(variable = df)
  }
  
  stats <- c("Min", "Average", "Variance", "Stnd_Devtn", "Max")
  results <- data.frame(Statistic = stats)
  
  for (col in names(df)) {
    x <- df[[col]]
    
    col_stats <- c(
      min(x, na.rm = TRUE),
      mean(x, na.rm = TRUE),
      var(x, na.rm = TRUE),
      sd(x, na.rm = TRUE),
      max(x, na.rm = TRUE)
    )
    
    results[[col]] <- col_stats
  }
  
  return(results)
}


### Your Turn ###

## Your Turn: How do we calculate summary stats for domestic attacks (domAttacks) and 
## the number of civilians killed (nkill)?

specialized_summary(data$domAttacks)

specialized_summary(data$nkill)

data %>%
  select(domAttacks, nkill) %>%
  specialized_summary() %>%
  knitr::kable(
    digits = 3,
    caption = "Summary statistics",
    format = "html"
  ) %>%
  cat(file = "Week7_Summary.html")

#### t-tests ####

## When do we do a t-test? 

### How could we do a t-test to determine the relationship between the 
### year and the number of people killed? 

#### z-tests ####


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