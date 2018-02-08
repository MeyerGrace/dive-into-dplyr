# Dive into dpylr workshop

#Load libraries
library(dplyr)
library(tabplot)

#Explore iris
head(iris)
pairs(iris)
tableplot(iris)
tableplot(iris, sortCol = Species)
str(iris)
summary(iris)


#Ex1 Select
select(iris, 1:3)
select(iris, Petal.Width, Petal.Length)
select(iris, contains("Sepal"))
select(iris, -Species)


#Ex2 Arrange
arrange(iris, Petal.Width)
arrange(iris, desc(Petal.Width))
arrange(iris, Petal.Width, Petal.Length)


#Ex3
filter(iris, Petal.Width > 1)
filter(iris, Petal.Width > 1 & Species == "versicolor")
filter(iris, Petal.Width > 1, Species == "versicolor")
filter(iris, !Species == "setosa")


# Showing how magrittr works (Rene Magritte This is not a pipe)
#Ways I would have done before- nesting or multiple variables
data1 <- filter(iris, Petal.Width > 1)
data2 <- select(data1, Species, Petal.Length)

select(
  filter(iris, Petal.Width > 1),
  Species, Petal.Length)

#using magrittr to pipe in the data variable
iris %>%
  filter(Petal.Width > 1) %>%
  select(Species, Petal.Length)



#Ex4 magrittr
iris %>%
  filter(Petal.Width > 1) %>%
  select(1:3)

iris %>%
  select(contains("Petal")) %>%
  arrange(Petal.Width)

iris %>%
  filter(Species == "setosa") %>%
  arrange(desc(Sepal.Width))

iris %>%
  filter(Petal.Width > 1) %>%
  View()

iris %>%
  filter(Species == "setosa") %>%
  select(Petal.Width) %>%
  unique()

#Ex5 mutate
iris %>%
  mutate(pwGreaterThanPL = Petal.Width > Petal.Length) %>%
  head()

iris %>%
  mutate(pwPlusSL = Petal.Width + Sepal.Length) %>%
  head()

iris %>%
  mutate(meanSL = mean(Sepal.Length),
         greaterThanMeanSL = ifelse(Sepal.Length > meanSL, 1, 0)) %>%
  head()
         
iris %>%
  mutate(slBuckets = cut(Sepal.Length, 3)) %>%
  head()

iris %>%
  mutate(pwBuckets = case_when(Petal.Width < 0.2 ~ "Low",
                               Petal.Width >= 0.2 & Petal.Width < 0.6 ~ "Med",
                               Petal.Width >= 0.6 ~ "High")) %>%
  head()


#Ex6 Group_by and summarise
iris %>%
  summarise(plMean = mean(Petal.Length),
            pwSD = sd(Petal.Width))

iris %>%
  group_by(Species) %>%
  mutate(slMean = mean(Sepal.Length))

iris %>%
  group_by(Species) %>%
  summarise(slMean = mean(Sepal.Length))

iris %>%
  group_by(Species, Petal.Length) %>%
  summarise(count = n())

#Print and save
(test <- iris %>%
  group_by(Species) %>%
  summarise(slMean = mean(Sepal.Length)))

#Rename
iris %>%
  rename(PL = Petal.Length) %>%
  head()

#Slice
iris %>%
  slice(2:7)

#ungroup
iris %>%
  group_by(Species, Petal.Length) %>%
  summarise(count = n()) %>%
  ungroup()


#Scoped verbs


#Summarise_all
iris %>%
  summarise_all(length)

iris %>%
  select(1:4) %>%
  summarise_all(mean)

iris %>%
  select(1:4) %>%
  summarise_all(funs(mean, min))

iris %>%
  summarise_all(~length(unique(.)))


#summarise_at
iris %>%
  summarise_at(vars(-Species), mean)

iris %>%
  summarise_at(vars(contains("Petal")), mean)

#summarise_if
iris %>%
  summarise_if(is.numeric, sd)

iris %>%
  summarise_if(is.factor, ~length(unique(.)))

#other verbs
iris %>%
  mutate_if(is.factor, as.character) %>%
  str()

iris %>%
  mutate_at(vars(contains("Petal")), ~ round(.))

airquality %>%
  filter_all(any_vars(is.na(.)))

airquality %>%
  filter_all(all_vars(is.na(.)))



#Links
#https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html
#https://docs.google.com/presentation/d/1tgCEXQVVPO6jyJcG1luzgt9gu6I_ZSDeYDmzasvZ2-s/edit#slide=id.g35f391192_00
#https://dcl-2017-04.github.io/curriculum/manip-scoped.html
#dive into dplyr
#https://docs.google.com/presentation/d/1ykHUxYVXtEhAuMX95gX_5x1zVlZYI_1z4I4_uB4f3gw/edit#slide=id.g35f391192_00
