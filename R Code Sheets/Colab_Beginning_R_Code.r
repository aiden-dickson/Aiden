

# Install these packages if you haven't already- 'Load Needed Libraries'
if (!require('colabr')) devtools::install_github('hansquiogue/colabr', force=TRUE)
if (!require('tidyverse')) install.packages('tidyverse')


# Load libraries
library(colabr)
library(tidyverse)

# You will first need to identify the link for the drive file you will be using. Downloads entire contents in class folder
download_drive("https://drive.google.com/drive/folders/1HIWfHVgDJW9JTme05PpGJOtV7URcGiFc?usp=sharing")



# Import Single File -Downloads congressional_hearings.csv by id
# Assuming file is public
system("gdown --id 1fgCjOEBnQwYkTCh4lpk8GASK3gNVF_Ut") 

#edit this command to read your data
myData <- read.csv("/content/congressional_hearings.csv", sep = ",", header=T)
data <- read.csv("congressional_hearings.csv")

column <- select(data,'CISYear')
tabl <-table(column)