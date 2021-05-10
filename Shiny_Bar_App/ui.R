#ui is app presentation

#Page 1 Introduction ---------------------------------------
intro_panel <- tabPanel(
  "Introduction",
  
  titlePanel("Characteristics of Mario Kart Drivers"),
  
  img(src = "MarioKart.jpg", height = 225, width = 225),
  br(),  br(),
  
  p("Template of Histogram App from a Handy Tutorial - Keep this as Boilerplate / Springboard."),  
  p(a(href = "https://www.kaggle.com/barelydedicated/mariokart8?select=characters.csv", "Data Source [Kaggle]"))
)

#User Interface      ---------------------------------------
ui <- navbarPage(
  "Mario Kart Characteristics",
  intro_panel
)