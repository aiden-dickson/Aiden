# dataImportSamples.r
# Introduction to getting your data into R
#
# dr 8.7.2020
# ==================================


# =-=-=-=-=-=-=-=-=-=-=-=-=-
#   Front end material
# =-=-=-=-=-=-=-=-=-=-=-=-=-
library(tidyverse)

# =-=-=-=-=-=-=-=-=-=-=-=-=-
#   Data Import
# =-=-=-=-=-=-=-=-=-=-=-=-=-

# The key to importing data is that there is no *single* function. Data is stored in
# lots of different formats, and each requires a different function to read it in to R
# So here's a list. You will need to select the appropriate one for your data.
# And don't forget about your working directory!

myData <- read_csv("filename.csv")
myData <- read_tsv("filename.tsv")
myData <- read_delim("filename.txt", delim="-")

# if your data are in .dta format; similar code works for SPSS files (.dat)
library(haven)
myData <- read_dta("filename.dta")

# if your data are in Excel format (.xls or .xlsx)
library(readxl)
myData <- read_excel("filename.xlsx")

# once your data are in R, check to see if they need to be converted to a tibble
is(myData)

# if they are not tibble format, convert by
myData <- as.tibble(myData)

