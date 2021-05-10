#server is app logic

# Load libraries, data ------------------------------------------------
library(ggplot2)#for histogram
library(dplyr)

all_ages <- read.csv("data/all-ages.csv")

# Create server -------------------------------------------------------

server <- function(input, output) {
    
    
    
    # Generate a plot of the data ----
    # Also uses the inputs to build the plot label. Note that the
    # dependencies on the inputs and the data reactive expression are
    # both tracked, and all expressions are called in the sequence
    # implied by the dependency graph.
   output$plot <- renderPlot({
     #sort by class
     all_ages$Major <- factor(all_ages$Major,
        levels = all_ages$Major[order(all_ages$Major_category)])
     
     ggplot(data = all_ages, aes_string(x='Major', y=input$y_var, fill="Major_category")) +
       geom_bar(stat="identity",width=1) +
    labs(x="Major Category", y=input$y_var) + theme(axis.text.y = element_text(size = 10, face = "bold", hjust = 1, vjust= 1),
                                           legend.direction = "horizontal", legend.position = "bottom") + 
         theme(axis.text.x = element_text(size = 9, color = "black", face = "bold")) + 
         theme(axis.text.x = element_text(angle = 80, hjust = 1)) 
     ##+ facet_wrap(~Major_category, scales = "free_x")
       
   })
   
   # Generate a summary of the data ----
   output$summary <- renderPrint({
       summary(all_ages)
   })
   
   # Generate an HTML table view of the data ----
   output$table <- renderTable({
       all_ages
   })
}
