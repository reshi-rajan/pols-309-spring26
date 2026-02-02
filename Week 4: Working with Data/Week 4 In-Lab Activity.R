#### The First Thing We Do Is Set Up A Working Directory ####
setwd("~/POLS 309")

#### Load Packages ####
## install.packages('tidyverse')
library(tidyverse) ## load this in every time you do 309 R work

#### Load in Some Data ####

## Today we will use a built-in dataset called the car package. 
library(car)
data(mtcars)
head(mtcars)

#### Descriptive Statistics ####
## The summary function from 209 is really good at seeing our data in its most
## basic form, but when we want to present data well, we might need to use 
## something different. 

summary(mtcars)

## The reframe() function is a really good built-in TidyVerse way to do that.

## Maybe we are interested in looking just at the mpg and the horsepower of cars

## Specifically, maybe we are interested in the average mpg and hp.

mtcars %>%
  reframe(
    mean_mpg = mean(mpg),
    mean_hp  = mean(hp)
  )

## Maybe we are interested in this by the number of cylinders the car has

mtcars %>%
  reframe(
    mean_mpg = mean(mpg),
    mean_hp  = mean(hp),
    .by = cyl
  )


### Your Turn ###

## How could we use reframe to get the average number of gears per cylinder type?


#### Make Your Own Functions

specialized_summary <- function(x){
  return(c(Min = min(x, na.rm = TRUE),
           Average = mean(x, na.rm = TRUE),
           Spread = var(x, na.rm = TRUE),
           Max = max(x, na.rm = TRUE)))
  }


## Find the descriptive data about car weight (1\2 ton)

specialized_summary(mtcars$wt)

### Your Turn ###

## Make your own function that calculates the mean without using the mean() function


### The Across Function ###

## Sometimes we might need information that goes across different variables
## To do this, we can use the across() function to do commands across these
## different variables. 

mtcars %>%
  summarise(
    across(c(mpg, hp), list(specialized_summary))
  )


## We have to use list here because across() works on multiple columns, 
## but reframe() spits out one row for every group we asked for

#### Presenting Descriptive Statistics ####

mtcars %>%
  select(mpg, wt, cyl, am) %>%
  knitr::kable(digits=2,
             caption="Summary statistics",
             col.names = c("Car", "MPG", "Weight",
                    "Cylinders",
                    "Transmission Type"))

#### Saving Tables ####

mtcars %>%
  select(mpg, wt, cyl, am) %>%
  knitr::kable(digits=2,
     caption="Summary statistics",
     col.names = c("Car", "MPG", "Weight",
                   "Cylinders",
                   "Transmission Type"),
     format="html") %>% # format and pipe
  cat(file="mySummaryStats.html")

#### Extra Stuff for PS 1 ####
### Making Vectors 

## To make vectors (basically a one-column dataframe), we can do the following

TV_Shows <- c("The Office", "Brooklyn 99", "Parks and Rec",
              "Cheers", "Seinfeld", "30 Rock")

## The key here is to use the c() function which means concatenate, 
## it strings together a bunch of values (like numbers or words) together 

### Q-Q Plot 

## A Q-Q Plots compare two different probability distributions by plotting 
## quantiles against each other

ggplot(mtcars, mapping = aes(sample=mpg))+ 
  stat_qq() + 
  stat_qq_line() + 
  xlab("Theoretical Quantile") + 
  ylab("Sample Quantile")
