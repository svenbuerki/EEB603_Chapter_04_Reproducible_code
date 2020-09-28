########
#Arguments
########

#Object (args) provided by user with names of packages stored into a vector
pkg <- c('knitr', 'bookdown', 'ape', 'vegan', 'sabre')

#Task 1: Check if pkg are installed
print("Check if packages are installed")

#This line outputs a list of packages that are not installed
new.pkg <- pkg[!(pkg %in% installed.packages())]

#Task 2: Install missing packages
if(length(new.pkg) > 0){
  print(paste("Install missing package(s):", new.pkg, sep=' '))
  install.packages(new.pkg, dependencies = TRUE)
}

#Task 3: Load all packages
print("Load packages")

#Here we use the sapply() function to require all the packages
sapply(pkg, require, character.only = TRUE)
