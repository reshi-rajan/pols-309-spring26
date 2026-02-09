######## Week 5 Lab ########

#### Basics ####

### What is the first thing we do? ###

### Load the Libraries ###
library(tidyverse)
# install.packages("BSDA")
# library(BSDA)

#### Data Time ####

### Load the Data ###
data <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%205%3A%20Hypothesis%20Testing/terrorism1.csv")

### Summary Statistics ###

specialized_summary <- function(x){
  return(c(Min = min(x, na.rm = TRUE),
           Average = mean(x, na.rm = TRUE),
           Variance = var(x, na.rm = TRUE),
           Stnd_Devtn = sd(x, na.rm = TRUE),
           Max = max(x, na.rm = TRUE)))
}

### Your Turn ###

## Your Turn: How do we calculate summary stats for domestic attacks (domAttacks) and 
## the number of civilians killed (nkill)?

specialized_summary(dataframe$variable)

data %>%
  select() %>%
  knitr::kable(digits=3,
               caption="Summary statistics",
               col.names = c(" "),
               format="html") %>%
  cat(file="Week5_Summary.html")

#### Visualizing the Data ####

## Let's make a histogram that describes the data for the domestic attacks

ggplot(data = data) +
  geom_histogram(mapping = aes(x=domAttacks),
                 fill = 'maroon', color = 'white') + 
  ylim(0,120) +
  xlim(0,575) +
  xlab('Number of Domestic Attacks') + 
  ylab('Frequency') +
  theme_bw()
  

#### Hypothesis Testing ####

### Hypotheses Basics ###
## Most statistical questions are tested using hypotheses. 

## Your Turn: What are the two components necessary for hypothesis testing? 

#### Democracies & Terrorist Attacks ####

## Suppose we are interested in the relationship between terrorist attacks 
## and being a democracy. 

## Your Turn: What are our 2 hypotheses?

## 1. 
## 2. 

### Paired Data ### 

## A paired t-test is designed to compare the means of the same group 
## under two separate scenarios. 
## An unpaired t-test compares the means of two independent or unrelated groups.
# It makes comparisons across samples.

## Your TUrn: Are our hypotheses paired or unpaired? 

### Test Statistics ### 

## A test-statistic is a quantity we get that explains how similar our observed/collected
## data is to a null hypothesis.

## It usually takes the form: coefficient/standard error

## Two common test-statistics are the t-statistic and the z-statistic.

## Your Turn: What is the difference between a t-test and a z-test? 


#### Doing a t-test ####

## To do a t-test, we can use the following command:

t.test()

## Your Turn: From 209, how could we test this hypothesis using a t-test? 

test()

#### Doing a z-test ####

## To do a z-test in R, we can do the following:

z.stat <- (Mean1 - Mean2)/SE
round(pnorm(abs(z.stat), lower = FALSE)*2,2)

## To do this here, we could do the following:

test.var <- sum(sd(data$domAttacks)/length(data$domAttacks))
SE <- sqrt(test.var)

z.stat <- (15.518189 - 2.121756)/SE
round(pnorm(abs(z.stat), lower = FALSE)*2,2)

### Your Turn: What does the p-value of 0 mean?
