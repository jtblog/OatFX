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
        # output$resPlot <- renderPlotly({NULL})
        # output$resPlot <- renderPlotly({getspreadplot(input$pairs)})
        # output$dpairsPlot <- renderPlotly({NULL})
        # output$dpairsPlot <- renderPlotly({getpwiseplot(input$pairs)})
        # output$ratioPlot <- renderPlotly({NULL})
        # output$ratioPlot <- renderPlotly({getSRatioplot(input$pairs)})
    }
    
    assign_function(refreshplot)
    
    output$resPlot <- renderPlotly({
        getspreadplot(input$pairs)
    })
    
    output$dpairsPlot <- renderPlotly({
        getpwiseplot(input$pairs)
    })
    
    output$ratioPlot <- renderPlotly({
        getSRatioplot(input$pairs)
    })
    
    observeEvent(input$pairs, {
        if(!is.null(input$pairs)){
            sym1 = unique(strsplit(input$pairs, "-")[[1]])[1]
            output$sym1 <- renderText({sym1})
            sym2 = unique(strsplit(input$pairs, "-")[[1]])[2]
            output$sym2 <- renderText({sym2})
        }
    })
    
    observeEvent(input$purchase1, {
        if(!is.null(input$pairs)){
            sym1 = unique(strsplit(input$pairs, "-")[[1]])[1]
            if(!is.na(as.numeric(input$stake1)) && !is.na(as.numeric(input$duration1))){
                stake1 = input$stake1
                duration1 = input$duration1
                duration_unit1 = input$duration_unit1
                # output$sym1 <- renderText({is.numeric(stake1)})
            }
        }
    })
    
    observeEvent(input$purchase2, {
        if(!is.null(input$pairs)){
            sym2 = unique(strsplit(input$pairs, "-")[[1]])[2]
            if(!is.na(as.numeric(input$stake2)) && !is.na(as.numeric(input$duration2))){
                stake2 = input$stake2
                duration2 = input$duration2
                duration_unit2 = input$duration_unit2
                # output$sym2 <- renderText({is.numeric(stake2)})
            }
        }
    })
    

})
