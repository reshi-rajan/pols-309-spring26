################### Week 10: Merging Data ###################
#### Setting Up ####
library(haven)

## Often times we need to compile data from multiple sources, this requires us
## to have multiple datasets we want to work with. To work this data all together
## we have to merged these datasets into one big dataframe in R. 

#### Merging Preliminaries ####
## The first rule of merging data is making sure it is all in the the environment 
## pane. If our data is not in the environment pane, R does not know what to merge.

## Go ahead and load the data into your global environment.
econ_data <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-209-fall24/refs/heads/main/Week%2010%3A%20Merging%20Data/Data%3A%20Booms%20%26%20Busts/booms%20and%20busts%20econ%20info%20data.csv")
pol_data <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-209-fall24/refs/heads/main/Week%2010%3A%20Merging%20Data/Data%3A%20Booms%20%26%20Busts/booms%20and%20busts%20pol%20info%20data.csv")

### NB: This data is from "Booms and Busts: How Parliamentary Governments and 
###                        Economic Context Influence Welfare Policy" 
##                         by Prof. Christine Lipsmeyer (ISQ 2011)

## The second rule of merging is the most important. We MUST have a variable in
## common between both datasets. 

## Anytime we have two datasets we are considering merging, make sure you view
## the candidate datasets using the View() function or by clicking on the dataframe
## in the environment pane.

## Do you see a potential candidate variables that we could merge between these 
## two datasets? 

## When we have to rename a variable we should use the following syntax:
## dataframe$variablename_new <- dataframe$variablename_old

## How should we do this for our common variables? 

#### Merging Basics ####
## The simplest merge command in R is within base R. It is the merge() function.

## The merge function syntax works like this: 
## Supply an 'x' dataframe (i.e. the first dataframe you want to merge)
## Supply a 'y' dataframe (i.e. the second dataframe you want to merge)

## The important thing to note, is the by = command for the merge function, 
## this is how we specify the variable to merge our dataframes by

## The syntax is as follows: 
## merged_data <-  merge(first_dataframe, second_dataframe, 
##                 by = c('overlapping_variable_1', 'overlapping_variable_2'))

## How do we do it for these two dataframes? 

#### Special Features ####

### Using by.x or by.y

## Sometimes we changing the names of our variables is too cumbersome or difficult
## when this happens we can use by.x and by.y instead as below: 

## merge(first_dataframe, second_dataframe, 
##  by.x = c('similar_x_1', 'similar_x_2'),
##  by.y = c('similar_y_1', 'similar_y_2'))

### Keeping NA values
## Often times, we know that the number of rows/observations in our datasets do
## not match (i.e. 500 in 1 dataframe and 450 in the other), when this happens
## it is best practice to preserve all observations. This can be done with
## the following: 

## merged_data <-  merge(first_dataframe, second_dataframe, 
##                 by = c('overlapping_variable_1', 'overlapping_variable_2'),
##                 incomparables = NA)

## By adding this final piece of code we are able to tell R that if an observation
## does not have a match in the complementary dataframe, create NA values for all
## the observation's new elements in the merged dataframe.
