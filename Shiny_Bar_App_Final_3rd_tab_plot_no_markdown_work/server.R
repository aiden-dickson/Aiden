#server is app logic

# Load libraries, data ------------------------------------------------
library(ggplot2)#for histogram
library(dplyr)
library(DT)
library(vtable)
library(shiny)
library(ggplot2)

# Create server -------------------------------------------------------

server <- function(input, output) {

    all_ages <- read.csv("data/all-ages.csv")
    all_ages <- rename(all_ages, "Employed_Full_Time_Year_Round" = "Employed_full_time_year_round", 
                       "Unemployment_Rate" = "Unemployment_rate", "Percentile_25th" = "P25th", "Percentile_75th" = "P75th")
    
    
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
       geom_bar(stat="identity", width=1, color="black") +
    labs(x="Major", y=input$y_var) + theme(axis.text.y = element_text(size = 10, face = "bold", hjust = 1, vjust= 1),
                                           legend.direction = "horizontal", legend.position = "top") + 
         theme(axis.text.x = element_text(size = 6, color = "black", face = "bold")) + 
         theme(axis.text.x = element_text(angle = 75, hjust = 1))  
         ##scale_y_continuous(breaks = round(seq(min(all_ages$y), max(all_ages$y), by = 2000),1))
     ##+ scale_color_manual(values = c("#000000"))
     ##+ facet_wrap(~Major_category, scales = "free_x")
       
   })
   
   # Generate a summary of the data (Server)----
   output$summary <- renderPrint({
       summary(all_ages)
     
   })
   
   # Generate an HTML table view of the data ----
   output$table <- renderTable({
       all_ages
   })
   #---------------------------------End plot, table, summary for tab 2, start plot tab 3 -----------
   dataset <- reactive({
       all_ages[sample(nrow(all_ages), input$sampleSize),]
   })
   
   output$plot2 <- renderPlot({
       
       p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point() + theme(axis.text.y = element_text(size = 10, face = "bold", hjust = 1, vjust= 1),
                                                                                       legend.direction = "horizontal", legend.position = "bottom") + 
           theme(axis.text.x = element_text(size = 6, color = "black", face = "bold")) + 
           theme(axis.text.x = element_text(angle = 75, hjust = 1)) 
       
       if (input$color!= 'None')
           p <- p + aes_string(color=input$color)
       
       facets <- paste(input$facet_row, '~', input$facet_col)
       if (facets != '. ~ .')
           p <- p + facet_grid(facets)
       
       if (input$jitter)
           p <- p + geom_jitter()
       if (input$smooth)
           p <- p + geom_smooth()
       
       print(p)
       
   }, height=700)
   
}
