#ui is app presentation

# Load libraries, Data ------------------------------------
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(vtable)
all_ages <- read.csv("data/all-ages.csv")



# Page 1 - First Tab [Introduction tab] --------------------

first_tab <- tabPanel(
  "Introduction", 
  includeMarkdown("intro.Rmd")
)


# Page  2 - Second Tab - All Ages------------begin plot tab 2------------------------------------
select_values <- colnames(all_ages <-rename(all_ages, "Employed_Full_Time_Year_Round" = "Employed_full_time_year_round", 
                    "Unemployment_Rate" = "Unemployment_rate",  "Percentile_25th" = "P25th", "Percentile_75th" = "P75th"))
select_values <- select_values[! select_values %in% c('Major_code', 'Major_category','Major')] #Removing unwanted columns

#input section top
sidebar_content1 <- sidebarPanel(
 selectInput(
    "y_var",
     label = "Y Variable",
     choices = select_values,
     selected = "Median",

 
  )
)

#plot section bottom
main_content1 <- mainPanel(width = "12",
   # plotOutput("plot"),
   # width = "10",
    # Output: Tabset w/ plot, summary, and table (UI)----
    tabsetPanel(type = "tabs", 
                tabPanel("Plot", plotOutput("plot", height='650')),
                tabPanel("Table", tableOutput("table"))
               ## tabPanel("Summary", verbatimTextOutput('summary'))   ##Using later if can figure out formatting
    )
)

#Second Panel, using top section input, below section plot
second_tab <- tabPanel(
  "Dataset Bar", 
   titlePanel("Economic Outcomes of Computer Science and Math College Majors - Dataset Bar Plot and Table"),
   includeMarkdown("bar_brief_discussion.Rmd"),
  
  sidebarLayout(
    sidebar_content1,  #top
    main_content1      #bottom
  )
)
#--------------------------------------- plot tab 2 end, begin plot tab 3-----------------------------------------------------


third_tab <- tabPanel(
  "Dataset Scatter",
  titlePanel("Economic Outcomes of Computer Science and Math College Majors - Dataset Scatter Plot"),
  includeMarkdown("scatter_brief_discussion.Rmd"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=40, max=nrow(all_ages),
                value=min(1, nrow(all_ages)), step=10, round=0),
    
    selectInput('x', 'X', names(all_ages)),
    selectInput('y', 'Y', names(all_ages), names(all_ages)[[2]]),
    selectInput('color', 'Color', c('None', names(all_ages))),
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth'),
    
    selectInput('facet_row', 'Facet Row', c(None='.', names(all_ages))),
    selectInput('facet_col', 'Facet Column', c(None='.', names(all_ages)))
  ),
  
  mainPanel(
    plotOutput('plot2')
  )
)

# Page 3 - Third Tab ----------------------------------------------------------------------------
fourth_tab <- tabPanel( 
  "Analysis I: Within Category", 
  
  titlePanel("Economic Outcomes of Computer Science and Math College Majors - Analysis I: 
             Comparing Majors within Category"),
  
  includeMarkdown("fourth_tab_analysis.html")
  


)

# Page 4 - Fourth Tab [testing] ---------------------------------------
fifth_tab <- tabPanel( 
  "Analysis II: Outside Categories", 
  
  titlePanel("Economic Outcomes of Computer Science and Math College Majors - Analysis II: Comparing Category vs Outside Categories"),
  
  #includeMarkdown("fourth_tab_analysis.html")
  includeMarkdown("maintenance.Rmd")
  
  
)

# Page 5 - Fifth Tab [testing] ---------------------------------------
#fifth_tab <- tabPanel( 
 # "Analysis III: Z", 
  
 # titlePanel("Economic Outcomes of Computer Science and Math College Majors - Analysis III: Demographic Analysis of Category"),
  
 # includeMarkdown("fourth_tab_analysis.html")
  
#)


#  All tabs used for User Interface      ---------------------------------------
ui <- navbarPage(
  "A Dickson - DACSS 601",
  first_tab,
  second_tab,
  third_tab,
  fourth_tab,
  fifth_tab

)