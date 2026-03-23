#### Pre-Class ####

## Do we have any questions about class?

#### Basics ####

### The first thing we do is?

### Load our Packages ### 
library(tidyverse)
library(car)

### Load the Data ###

work_men <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%2010%3A%20Interpreting%20Regressions/WorkMen.csv")

work_women <- read.csv("https://raw.githubusercontent.com/reshi-rajan/pols-309-spring26/refs/heads/main/Week%2010%3A%20Interpreting%20Regressions/WorkWomen.csv")

### The Key Variables Are:

# Country = Country Identifier
# Hours = Average Number of Hours Worked per Year
# Divorce Rate = Divorce Rate per Thousand People
# Tax Rate = Acerage Effective Tax Rate 

#### Creating a Scatterplot ####

### To create a scatterplot, we probably need a basic skeleton in ggplot:

ggplot(data = dataframe, mapping = aes(x = , y = )) +
  geom_point() + 
  ylab("Y-Axis Title Here") + 
  xlab('X-Axis Title Here') + 
  theme_bw()

### Your Turn: If we want to plot the relationship between the hours worked
### and the divorce rate for men and women how would we do that with a ggplot()?

#### Setting Up Our Regression ####

### Your Turn: How would we run a regression where we want to know
### if there is a statistical relationship between divorce rates and hours worked?

model_men <- lm()
summary(model_men)

model_women <- lm()
summary(model_women)

#### Interpreting Our Regression Coefficients ####

### Remembering our generic formula for interpreting regressions: a one-unit of x
### increase is associated/produces a XX-units of y increase/decrease in y, all else equal. 

### How do we interpret the relationship between the number of hours worked
### and the divorce rate for men and women respectively?

#### Understanding Model Fit ####

### To understand how well our model captures the movement in Y, we have multiple
### different statistics that are called 'model fit statistics,'
### by far the most common is the R^2.
### The R^2 value captures how well the movement in Y is driven by our 
### regressors/independent variables + controls. 
### If we multiply the value of it that R spits out, we can say something like:
### Our model captures xx% of the movement in our dependent variable. 

### Your Turn: How do we interpret the R^2 of the model we just ran? 

#### Predicted Values ####

### From a regression, we can also calculate predicted values or what-if values
### that tell us what value our line would expect if we gave it a particular value(s)
### of our xs.

### To do that here, we would use the predict() function. 

### We can try it with our model_men regression first

predict(model_men, newdata = 
          data.frame(treatment = 
                       median(model_men$divorcerate, na.rm = TRUE)))

### Your Turn: How can we do this for the model_women version?



