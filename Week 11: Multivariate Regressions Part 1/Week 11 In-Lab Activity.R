#### Pre-Class ####

## Do we have any questions about class?

#### Basics ####

### The first thing we do is?

### Load our Packages ### 
library(tidyverse)
library(car)
options(scipen = 999)

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

model1 <- lm()
summary(model1)

#### Interpretation ####

### How do we interpret the effect of incumbent spending 
### per capita on incumbent party vote share?


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

### Would it have any direct or indirect effects on incumbent 2PP? 

#### Omitted Variable Bias ####

### Based on what we have established, how would excluding challenger wealth 
### influence the relationships between the other variables?

### Are there any variables in particular that would be really affected?

#### Dealing with OVB ####

### What regression should we run here based on what we have established?

model2 <- lm()

install.packages('modelsummary')
library(modelsummary)
msummary(list(model1, model2))

### Is there bias based on model1 vs model2? 