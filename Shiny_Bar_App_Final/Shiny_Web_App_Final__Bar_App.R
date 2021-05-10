
# Load Data and Libraries ---------------------------------------------------------
library("shiny")
source("ui.R")
source("server.R")

# Create Shiny Application -------------------------------------------------------
shinyApp(ui = ui, server = server)

