#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(here)
source(here::here('OatFX/rscript','SharedObjects.R'))

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
        
    r_activ_objs <- reactiveValues(sc = scs)
    
    chs <- reactive({
        pairings
    })
    
    observe({
        # click("refresh")
        updateSelectInput(session,"pairs",choices = pairings)
    })
    
    observeEvent(input$subscribe, {
        subscribe()
    })
    
    observeEvent(input$unsubscribe, {
        unsubscribe()
    })
    
    observeEvent(input$logout, {
        logout()
    })
    
    observeEvent(input$refresh, {
        output$corPlot <- renderPlotly({NULL})
        output$cointPlot <- renderPlotly({NULL})
        output$corPlot <- renderPlotly({corhm})
        output$cointPlot <- renderPlotly({cointhm})
    })
    
    output$corPlot <- renderPlotly({corhm})
    
    output$cointPlot <- renderPlotly({cointhm})
    
    refreshplot <- function(){
        output$corPlot <- renderPlotly({NULL})
        output$cointPlot <- renderPlotly({NULL})
        output$corPlot <- renderPlotly({corhm})
        output$cointPlot <- renderPlotly({cointhm})
        updateSelectInput(session,"pairs",choices = pairings)
        output$resPlot <- renderPlotly({NULL})
        output$resPlot <- renderPlotly({getspreadplot(input$pairs)})
        output$dpairsPlot <- renderPlotly({NULL})
        output$dpairsPlot <- renderPlotly({getpwiseplot(input$pairs)})
    }
    
    assign_function(refreshplot)
    
    output$resPlot <- renderPlotly({
        getspreadplot(input$pairs)
    })
    
    output$dpairsPlot <- renderPlotly({
        getpwiseplot(input$pairs)
    })
    
    # output$text0 <- renderText({
    #     paste("You chose", input$pairs)
    # })

})
