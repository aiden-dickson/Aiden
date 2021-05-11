#ui is app presentation

# Load libraries, Data ------------------------------------
library(dplyr)
library(DT)
library(vtable)
all_ages <- read.csv("data/all-ages.csv")


# Page 1 - First Tab [Introduction tab] --------------------

first_tab <- tabPanel(
  "Introduction", 
  includeMarkdown("intro.Rmd")
)


# Page  2 - Second Tab - All Ages------------------------------------
select_values <- colnames(all_ages <-rename(all_ages, "Employed_Full_Time_Year_Round" = "Employed_full_time_year_round", 
                    "Unemployment_Rate" = "Unemployment_rate",  "Percentile_25th" = "P25th", "Percentile_75th" = "P75th"))
select_values <- select_values[! select_values %in% c('Major_code', 'Major_category','Major')] #Removing unwanted columns

#input section top
sidebar_content <- sidebarPanel(
 selectInput(
    "y_var",
     label = "Y Variable",
     choices = select_values,
     selected = "Median",

 
  )
)

#plot section bottom
main_content <- mainPanel(width = "12",
   # plotOutput("plot"),
   # width = "10",
    # Output: Tabset w/ plot, summary, and table (UI)----
    tabsetPanel(type = "tabs", 
                tabPanel("Plot", plotOutput("plot", height='800')),
                tabPanel("Table", tableOutput("table")),
                tabPanel("Summary", verbatimTextOutput('summary'))
    )
)

#Second Panel, using top section input, below section plot
second_tab <- tabPanel(
  "Dataset", 
   titlePanel("Economic Outcomes by College Major - Dataset"),
  p("Use the selector input below to choose which variable you would like to see."),
  
  sidebarLayout(
    sidebar_content,  #top
    main_content      #bottom
  )
)

# Page 3 - Third Tab [testing] ---------------------------------------
third_tab <- tabPanel( 
  "Analysis I: X", 
  
  titlePanel("Economic Outcomes by College Major - Analysis I: Blah of X"),
  
  includeMarkdown("testing_file.html")
  


)


#  All tabs used for User Interface      ---------------------------------------
ui <- navbarPage(
  "A Dickson - DACSS 601",
  first_tab,
  second_tab,
  third_tab
)