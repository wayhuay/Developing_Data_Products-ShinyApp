library(shiny)

shinyUI(pageWithSidebar(
  headerPanel('Developing Data Products - Course Project'),
  sidebarPanel(
    h3('How it works?'),
    p('Interactive results will be shown based on the Gross horsepower, No. of cylinders and Weight (lbs) entered.'),
    p('Please enter the values below:-'),
    numericInput('hp', 'Gross Horsepower:', 80, min = 80, max = 300, step = 10), 
    radioButtons('cyl', 'No. of Cylinders:', c('4' = 4, '6' = 6, '8' = 8), selected = '4'), 
    numericInput('wt', 'Weight (lbs):', 1500, min = 1500, max = 4000, step = 100)
    ),
  mainPanel(
    h6('Developed by Wee Way Huay'),
    h3('Miles Per Gallon (MPG) Prediction'),
    h4('Input Parameters:'),
    verbatimTextOutput("inpVal"),
    h4('Results:'),
    verbatimTextOutput("prediction"),
    h4('Graphical result view based on mtcar dataset'),
    plotOutput('plots'),
    h3('Strategy'),
    p('Linear model is used for this project based on the mtcars dataset. This study measures the Miles Per Gallon (MPG) Prediction
      based on the 3 input paramaters (Gross Horsepower, No. of Cylinders and Weight (lbs)) entered by the user.')
    )
))