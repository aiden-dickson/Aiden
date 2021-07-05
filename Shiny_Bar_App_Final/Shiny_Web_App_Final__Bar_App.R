
# Load Data and Libraries ---------------------------------------------------------
library("shiny")
library("dplyr") 
library("RColorBrewer")
source("ui.R")
source("server.R")


# Create Shiny Application -------------------------------------------------------
shinyApp(ui = ui, server = server)

