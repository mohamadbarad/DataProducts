#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Exploring mtcars"),
    h5("The purpose of this small appliation is to explore the data set 'mtcars'.\n
      The outcome/dependent variable is chosen to be mpg (miles per gallon) and it is\n
       possible to visualise the different variable against the outcome by selecting \n
       the 'feature' from the dropdown. You can filter on the number of cylinders \n
       Finally, a linear model is fitted by, checking the box 'Model Build'"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("variable",
                        "Select Feature:",
                        choices = colnames(mtcars[,-c(1,2)]),
                        selected = colnames(mtcars[,-c(1,2)])[1]
            ),
            selectInput("cylinder",
                        "Choose # of cylinders:",
                        choices = sort(unique(mtcars$cyl)),
                        multiple = TRUE,
                        selected = sort(unique(mtcars$cyl),
                                        )
            ),
            checkboxInput("model",
                          "Model build:",
                          value = FALSE
            ),
            hr(),
            h6("The model fitted is a linear model with the following formula:"),
            h6("'lm(mpg ~ chosen variable)'"),
            hr(),
            h5("Information:"),
            h6("mpg - Miles/(US) gallon"),
            h6("cyl - Number of cylinders"),
            h6("disp - Displacement (cu.in.)"),
            h6("hp - Gross horsepower"),
            h6("drat - Rear axle ratio"),
            h6("wt - Weight (1000 lbs)"),
            h6("qsec - 1/4 mile time"),
            h6("vs - Engine (0 = V-shaped, 1 = straight)"),
            h6("am - Transmission (0 = automatic, 1 = manual)"),
            h6("gear - Number of forward gears"),
            h6("carb - Number of carburetors"),
            h6("[Source: ?mtcars]")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            fluidPage(
                plotlyOutput("Plot"),
                dataTableOutput("Table")
            )
        )
    )
))
