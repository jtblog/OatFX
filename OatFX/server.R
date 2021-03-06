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
# source(here::here('OatFX/rscript','SharedObjects.R'))
source('rscript/model.R')
source('rscript/SharedObjects.R')


sym1 = ""
sym2 = ""

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
    
    current_selection <- reactiveVal(NULL)
    
    observeEvent(input$authorize, {
        login(input$token)
    })
    
    observeEvent(input$corrval, {
        setCorrCat(input$corrval)
    })
    
    # observeEvent(input$pairs, {
    #     current_selection(input$pairs)
    # })
    
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
        output$erro <- renderText({err})
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
    
    observeEvent(input$swap1, {
        output$txt1 <- renderText({input$pairs})
        output$txt2 <- renderText({input$pairs})
        output$txt3 <- renderText({input$pairs})
        if(!is.null(input$pairs) && !is.na(input$pairs)){
            if(as.logical(input$swap1) == TRUE){
                sym1 <<- unique(strsplit(input$pairs, "-")[[1]])[2]
                sym2 <<- unique(strsplit(input$pairs, "-")[[1]])[1]
            }else{
                sym1 <<- unique(strsplit(input$pairs, "-")[[1]])[1]
                sym2 <<- unique(strsplit(input$pairs, "-")[[1]])[2]
            }
            output$sym1 <- renderText({sym1})
            output$sym2 <- renderText({sym2})
        }
    })
    
    observeEvent(input$pairs, {
        output$txt1 <- renderText({input$pairs})
        output$txt2 <- renderText({input$pairs})
        output$txt3 <- renderText({input$pairs})
        if(!is.null(input$pairs) && !is.na(input$pairs)){
            if(as.logical(input$swap1) == TRUE){
                sym1 <<- unique(strsplit(input$pairs, "-")[[1]])[2]
                sym2 <<- unique(strsplit(input$pairs, "-")[[1]])[1]
            }else{
                sym1 <<- unique(strsplit(input$pairs, "-")[[1]])[1]
                sym2 <<- unique(strsplit(input$pairs, "-")[[1]])[2]
            }
            output$sym1 <- renderText({sym1})
            output$sym2 <- renderText({sym2})
        }
    })
    
    observeEvent(input$put1, {
        if(!is.null(input$pairs) && !is.na(input$pairs)){
            
            if(!is.na(as.numeric(input$stake1)) && !is.na(as.numeric(input$duration1))){
                contract_type1 = "PUT"
                contract_type2 = "CALL"
                if(as.logical(input$trdsame1) == TRUE){
                    contract_type2 = "PUT"
                }
                stake1 = input$stake1
                duration1 = input$duration1
                duration_unit1 = input$duration_unit1
                if(as.logical(input$trdboth1) == TRUE){
                    buy(stake1, contract_type1, duration1, duration_unit1, sym1)
                    buy(stake1, contract_type2, duration1, duration_unit1, sym2)
                }else{
                    buy(stake1, contract_type1, duration1, duration_unit1, sym1)
                }
                # output$sym1 <- renderText({is.numeric(stake1)})
            }
        }
    })
    
    observeEvent(input$call1, {
        if(!is.null(input$pairs) && !is.na(input$pairs)){
            if(!is.na(as.numeric(input$stake1)) && !is.na(as.numeric(input$duration1))){
                contract_type1 = "CALL"
                contract_type2 = "PUT"
                if(as.logical(input$trdsame1) == TRUE){
                    contract_type2 = "CALL"
                }
                stake1 = input$stake1
                duration1 = input$duration1
                duration_unit1 = input$duration_unit1
                if(as.logical(input$trdboth1) == TRUE){
                    buy(stake1, contract_type1, duration1, duration_unit1, sym1)
                    buy(stake1, contract_type2, duration1, duration_unit1, sym2)
                }else{
                    buy(stake1, contract_type1, duration1, duration_unit1, sym1)
                }
                # output$sym1 <- renderText({as.logical(input$swap1)})
            }
        }
    })
    
})

# library(rsconnect)
# deployApp('OatFX')
