library(shiny)
data(mtcars)

Model <- lm(mpg ~ hp + cyl + wt, data=mtcars)

mpg <- function(hp, cyl, wt) {
  Model$coefficients[1] + Model$coefficients[2] * hp + 
    Model$coefficients[3] * cyl + Model$coefficients[4] * wt
}

shinyServer(
  function(input, output) {
    adj_weight <- reactive({input$wt/1000})
    pred_mpg <- reactive({mpg(input$hp, as.numeric(input$cyl), adj_weight())})
    output$inpVal <- renderPrint({paste(input$hp, "horsepower, ",
                                        input$cyl, "cylinders, ",
                                        input$wt, "lbs")})
    output$prediction <- renderPrint({paste(round(pred_mpg(), 2), "Miles Per Gallon (MPG)")})
    output$plots <- renderPlot({
      par(mfrow = c(1, 3))
      # (1, 1)
      with(mtcars, plot(hp, mpg,
                        xlab='Gross Horsepower',
                        ylab='Miles Per Gallon (MPG)',
                        main='MPG by Horsepower'))
      points(input$hp, pred_mpg(), col='red', cex=3)                 
      # (1, 2)
      with(mtcars, plot(cyl, mpg,
                        xlab='No. of Cylinders',
                        ylab='Miles Per Gallon (MPG)',
                        main='MPG by Cylinders'))
      points(as.numeric(input$cyl), pred_mpg(), col='red', cex=3)  
      # (1, 3)
      with(mtcars, plot(wt, mpg,
                        xlab='Weight (lb/1000)',
                        ylab='Miles Per Gallon (MPG)',
                        main='MPG by Weight'))
      points(adj_weight(), pred_mpg(), col='red', cex=3)  
    })
  }
)