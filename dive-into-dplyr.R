#as well remember rename and split


#https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html

#https://docs.google.com/presentation/d/1tgCEXQVVPO6jyJcG1luzgt9gu6I_ZSDeYDmzasvZ2-s/edit#slide=id.g35f391192_00

#dive into dplyr
#https://docs.google.com/presentation/d/1ykHUxYVXtEhAuMX95gX_5x1zVlZYI_1z4I4_uB4f3gw/edit#slide=id.g35f391192_00

library(dplyr)
library(tabplot)

head(iris)
pairs(iris)
tableplot(iris)
tableplot(iris, sortCol = Species)
str(iris)
summary(iris)


#Ex1
select(iris, 1:3)
select(iris, Petal.Width, Petal.Length)
select(iris, contains("Sepal"))
select(iris, -Species)


#Ex2
arrange(iris, Petal.Width)
arrange(iris, desc(Petal.Width))
arrange(iris, Petal.Width, Petal.Length)


#Ex3
filter(iris, Petal.Width > 1)
filter(iris, Petal.Width > 1 & Species == "versicolor")
filter(iris, Petal.Width > 1, Species == "versicolor")
filter(iris, !Species == "setosa")



select(
  filter(iris, Petal.Width > 1),
  Species, Petal.Length)


data1 <- filter(iris, Petal.Width > 1)
data2 <- select(data1, Species, Petal.Length)


iris %>%
  filter(Petal.Width > 1) %>%
  select(Species, Petal.Length)



#Ex4
iris %>%
  select()



