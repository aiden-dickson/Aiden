#ui is app presentation

#Page 1 Introduction ---------------------------------------
intro_panel <- tabPanel(
  "Intro Yo",
  
  titlePanel("Characteristics of Mario Kart Drivers"),
  
  img(src = "MarioKart.jpg", height = 225, widtth = 225),
  br(),  br(),
  
  p("This is a test run."),  
  p(a(href = "https://www.kaggle.com/barelydedicated/mariokart8?select=characters.csv", "Data Source [Kaggle]"))
)

#User Interface      ---------------------------------------
ui <- navbarPage(
  "Mario Kart Characteristics",
  intro_panel
)