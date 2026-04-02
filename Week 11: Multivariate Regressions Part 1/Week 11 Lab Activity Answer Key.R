#### Pre-Class ####

## Do we have any questions about class?

#### Basics ####

### The first thing we do is?

setwd("~/POLS 309")

### Load our Packages ### 
library(tidyverse)
library(car)

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

#### Multivariate Regressions ####

### Your Turn: ###
## Run a regression where you regress incumbent party share of 
## two party vote on incumbent spending per capita, the amount of 
## challenger spending per capita, the number of years the incumbent is in office
## challenger quality, incumbent ideology, and the state unemployment rate

model1 <- lm(inc_2p_share ~ inc_spend + ch_spend + inc_tenure + ch_qual + 
               inc_pos + st_uemp, data = senate)
summary(model1)

#### Interpretation ####

### How do we interpret the effect of incumbent spending 
### per capita on incumbent party vote share?

# A one-unit increase in incumbent spending per capita leads to a 0.000000002 
# decrease in the incumbent's 2 party vote share, all else equal.

#### Regression Diagnostics ####

### Residuals vs Fitted Plot

plot(model1, which = 1)  

## This checks if the model is linear and homoskedastic. We want this to 
## look like there is no overall trend but is a smattering of random points.
## Any curves = non-linearity, any clusters = OVB, a funnel shape = heteroskedasticity.

### Q-Q Plot 

## This tell us if our data is distributed normally. 
## Any changes around the tails means: heavy tails, skewness, or outliers exist

plot(model1, which = 2)

### Scale-Location Plots 

## A more sensitive plot check for homoskedasticity than plot 1
## We want a flat, horizontal red line here

plot(model1, which = 3)

### Cook's Distance Plot 

## Values bigger than 1 are concerning, tells us which points are really influential

plot(model1, which = 4)


#### Backdoors ####
install.packages(c("dagitty", "ggdag"))
library(dagitty)
library(ggdag)

dag <- dagitty("
dag {
  inc_2p_share
  inc_spend
  ch_spend
  inc_tenure
  ch_qual
  inc_pos
  st_unemp

  inc_spend   <- inc_tenure
  inc_spend   <- inc_pos
  inc_spend   <- st_unemp

  ch_spend    <- ch_qual
  ch_spend    <- st_unemp

  inc_pos     <- inc_tenure

  inc_2p_share <- inc_spend
  inc_2p_share <- ch_spend
  inc_2p_share <- inc_tenure
  inc_2p_share <- ch_qual
  inc_2p_share <- inc_pos
  inc_2p_share <- st_unemp
}
")

labels <- c(
  inc_2p_share = "Incumbent\n2PP",
  inc_spend    = "Incumbent\nSpending",
  ch_spend     = "Challenger\nSpending",
  inc_tenure   = "Incumbent\nTenure",
  ch_qual      = "Challenger\nQuality",
  ch_wealthy   = "Challenger\nWealth",
  inc_pos      = "Incumbent\nIdeology",
  st_unemp     = "State\nUnemployment"
)



tidy_dag <- tidy_dagitty(dag)

ggdag(tidy_dag, text = FALSE) +
  geom_dag_point(size = 18) +  
  geom_dag_label(aes(label = labels[name]), 
                 size = 3.2, 
                 label.padding = unit(0.15, "lines")) +
  theme_dag()


### If we look at this DAG path where would challenger wealth fit into this story?

## Most likely, challenger's wealth probably influences their quality, a more 
## wealthy challenger is more likely to win and also therefore likely to influence
## the DV, incumbent vote share. So in terms of back doors, it is likely to influence
## our outcome in a way that necessitates controlling for it.

### Would it have any direct or indirect effects on incumbent 2PP? 

## Yes it would have both a direct and indirect effect on incumbent vote share.
## A candidate that can spend more probably can have more ads and show themselves
## to voters meaning it can influence the vote share. It can also lead to better 
## quality candidates because wealthy candidates are able to highlight the experiences
## and skills that made them wealthy. 

### We can visualize that here ###

dag <- dagitty("
dag {
  inc_2p_share
  inc_spend
  ch_spend
  inc_tenure
  ch_qual
  ch_wealthy
  inc_pos
  st_unemp

  inc_spend   <- inc_tenure
  inc_spend   <- inc_pos
  inc_spend   <- st_unemp

  ch_spend    <- ch_qual
  ch_spend    <- ch_wealthy
  ch_spend    <- st_unemp

  inc_pos     <- inc_tenure

  inc_2p_share <- inc_spend
  inc_2p_share <- ch_spend
  inc_2p_share <- inc_tenure
  inc_2p_share <- ch_qual
  inc_2p_share <- ch_wealthy
  inc_2p_share <- inc_pos
  inc_2p_share <- st_unemp
}
")

labels <- c(
  inc_2p_share = "Incumbent\n2PP",
  inc_spend    = "Incumbent\nSpending",
  ch_spend     = "Challenger\nSpending",
  inc_tenure   = "Incumbent\nTenure",
  ch_qual      = "Challenger\nQuality",
  ch_wealthy   = "Challenger\nWealth",
  inc_pos      = "Incumbent\nIdeology",
  st_unemp     = "State\nUnemployment"
)

tidy_dag <- tidy_dagitty(dag)

ggdag(tidy_dag, text = FALSE) +
  geom_dag_point(size = 18) +  
  geom_dag_label(aes(label = labels[name]), 
                 size = 3.2, 
                 label.padding = unit(0.15, "lines")) +
  theme_dag()

#### Omitted Variable Bias ####

### Based on what we have established, how would excluding challenger wealth 
### influence the relationships between the other variables?

## If we imagine these variables as a bunch of pipes leading to a spout,
## shutting any of these valves off builds pressure.
## So when we turn off challenger wealth in the model, it probably most affects
## challenger quality and their spending but also to a small degree 
## all the other pipes in the system.

### Are there any variables in particular that would be really affected?

## Challenger quality and challenger spending aer probably the most affected 
## in this model. 

#### Dealing with OVB ####

### What regression should we run here based on what we have established?

model2 <- lm(inc_2p_share ~ inc_spend + ch_spend + inc_tenure + ch_qual + 
               inc_pos + st_uemp + ch_wealthy, data = senate)

install.packages('modelsummary')
library(modelsummary)
msummary(list(model1, model2))

### Is there bias based on model1 vs model2? 

## There is a small amount of bias in the model. Challenger spending does not 
## seem to change at all (contrary to expectations) but challenger quality does.
## In particular, the challenger's quality when we condition on spending suggests
## it has a greater impact than previously though, which aligns with expectations.
## The other variables all have some small increases in their or no change in their
## estimates.