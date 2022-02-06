#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    data <- data.frame(mtcars)
    data$cyl <- as.factor(mtcars$cyl)
    subdata <- reactive({
        data %>% 
            mutate(cars = rownames(mtcars)) %>% 
            select("cars","mpg","cyl",input$variable) %>%
            filter(cyl %in% input$cylinder)
    })
   
    fit <- reactive({ 
        lm(subdata()[,"mpg"] ~ subdata()[,input$variable])
    })
    
    
    
    output$Plot <- renderPlotly({
        p <- plot_ly(subdata(), x = ~subdata()[,input$variable], y = ~mpg, 
                     type = "scatter", 
                     mode = "markers",
                     color = ~cyl) %>% 
            layout(title = paste0('Miles per gallon as function of ', input$variable),
                   xaxis = list(title = paste0(input$variable))) 
         
        
        p
        
        if(input$model){
            p1 <- plot_ly(subdata(), x = ~subdata()[,input$variable], y = ~mpg, 
                          type = "scatter", 
                          mode = "markers",
                          color = ~cyl) %>%
                add_lines(x = ~subdata()[,input$variable], y = ~fitted.values(fit()),
                          mode = "lines") %>%
                layout(title = paste0('Miles per gallon as function of ', input$variable), 
                       xaxis = list(title = paste0(input$variable)))
            
            p1
        } else {
            p   
        }
        
        
    })
    
    output$Table <- renderDataTable({
        subdata()
    })
    
    
})
