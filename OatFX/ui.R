#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(here)
# source(here::here('OatFX/rscript','SharedObjects.R'))
source('rscript/model.R')
source('rscript/SharedObjects.R')

data_menu_item1 <- fluidRow(
    box(
        actionButton("subscribe", "Stream Data"),
        
        actionButton("refresh", "Refresh Plot")
    ),
    box(
        actionButton("unsubscribe", "Stop streaming data"),
        actionButton("logout", "Log Out"),
        textOutput("erro")
    )
    )
data_menu_item2 <- fluidRow(
    box(
        plotlyOutput("corPlot")
    ),
    box(
        plotlyOutput("cointPlot")
    )
    )
    
pairs_menu_item1 <- fluidRow(
    box(
        radioButtons("corrval", label = "Positively/Negatively Correlated Pairs?",
                     selected = "neg",
                           choiceNames = list("Trade negatives", "Trade positives"), 
                           choiceValues = list("neg", "pos")),
        selectInput("pairs", "Pairs", pairings)
    ),
    box(
        textOutput("sym2"),
        checkboxInput("trdboth1", "Trade Both", FALSE),
        checkboxInput("trdsame1", "Trade PUT-PUT or CALL-CALL", FALSE),
        checkboxInput("swap1", "Swap paired asset", FALSE)
    )
    
)

pairs_menu_item2 <- fluidRow(
    tabBox(
        # title = "First tabBox",
        # The id lets us use input$tabset1 on the server to find the current tab
        id = "tabset1", width="100%",
        tabPanel("Pairwise Plot", textOutput("txt1"), plotlyOutput("dpairsPlot")),
        tabPanel("Spread/Residuals", textOutput("txt2"), plotlyOutput("resPlot")),
        tabPanel("Ratios", textOutput("txt3"), plotlyOutput("ratioPlot"))
    )  
    
)

pairs_menu_item3 <- fluidRow()


header <- dashboardHeader(title = "OatFX")


sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Data", tabName = "data"),
        menuItem("Pairwise(2 pairs)", tabName = "pairs"),
        textInput("token", "Api Token:"),
        actionButton("authorize", "Authorize"),
        box(
            width="100%", style = "color: black",
            textOutput("sym1"),
            textInput("stake1", "Stake1:"),
            textInput("duration1", "Duration1:"),
            selectInput("duration_unit1", "Duration Unit 1", 
                        c("Minutes" = "m", "Hours" = "h", "Days" = "d")),
            actionButton("put1", "PUT 1", style = "color: #fff; background-color: red"),
            actionButton("call1", "CALL 1", style = "color: #fff; background-color: green")
            
        )
    )
)


body <- dashboardBody(
    tabItems(
        tabItem(tabName = "data", data_menu_item1, data_menu_item2),
        
        tabItem(tabName = "pairs", pairs_menu_item1, pairs_menu_item2, pairs_menu_item3)
    )
)



# Define UI for application that draws a histogram
shinyUI(
    bootstrapPage(
        useShinyjs(),
        dashboardPage(header, sidebar, body, skin = "green")
    )
    
)
