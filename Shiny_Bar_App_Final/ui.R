#ui is app presentation

# Load libraries, Data ------------------------------------

all_ages <- read.csv("data/all-ages.csv")


# Page 1 - Intro Panel [Introduction tab] ---------------------------------------

intro_panel <- tabPanel(
  "Introduction",
  
  titlePanel("Economic Outcomes by College Major"),
  
  img(src = "college_dorm.png", height = 400, width = 700),
  br(),  br(),
  
  p("Analysis of Economic Outcomes by College Major."),  
  
  p(a(href = "https://www.kaggle.com/tunguz/college-majors?select=majors-list.csv", "Data Source [Kaggle]"))
)

# Page  2 - Second Panel [Visualization Tab] ----------------------------------
select_values <- colnames(all_ages)
select_values <- select_values[! select_values %in% c('Major_code', 'Major_category','Major')] #Removing unwanted columns

#side section left
sidebar_content <- sidebarPanel(
 selectInput(
    "y_var",
     label = "Y Variable",
     choices = select_values,
     selected = "Median",

 
  )
)

#main section right
main_content <- mainPanel(width = "14",
   # plotOutput("plot"),
   # width = "10",
    # Output: Tabset w/ plot, summary, and table ----
    tabsetPanel(type = "tabs", 
                tabPanel("Plot", plotOutput("plot", height='800')),
                tabPanel("Summary", verbatimTextOutput("summary")),
                tabPanel("Table", tableOutput("table"))
    )
   
)

#Second Panel, using side section, main section
second_panel <- tabPanel(
  "Overview - All Ages",
   titlePanel("Economic Outcomes by College Major - All Ages"),
  p("Use the selector input below to choose which variable you would like to see."),
  
  sidebarLayout(
    sidebar_content,  
    main_content
  )
)

# Both Panels [tabs] used for User Interface      ---------------------------------------
ui <- navbarPage(
  "College Major Stats",
  intro_panel,
  second_panel
)