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
source(here::here('OatFX/rscript','SharedObjects.R'))

data_menu_item1 <- fluidRow(
    box(
        actionButton("subscribe", "Stream Data"),
        actionButton("unsubscribe", "Stop streaming data"),
        actionButton("refresh", "Refresh Plot")
    ),
    box(
        actionButton("logout", "Log Out")#,
        # textAreaInput("err", "ERROR", "No error", rows = 18, width = "100%", resize = "none")
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
    

pairs_menu_item <- fluidRow(
    tabBox(
        # title = "First tabBox",
        # # The id lets us use input$tabset1 on the server to find the current tab
        # id = "tabset1", height = "250px",
        # tabPanel("Tab1", "First tab content"),
        # tabPanel("Tab2", "Tab content 2")
    )
)

header <- dashboardHeader(title = "OatFX")


sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Data", tabName = "data"),
        menuItem("Pairwise(2 pairs)", tabName = "pairs"),
        textInput("token", "Api Token:"),
        actionButton("authorize", "Authorize")
    )
)


body <- dashboardBody(
    tabItems(
        tabItem(tabName = "data", data_menu_item1, data_menu_item2),
        
        tabItem(tabName = "pairs", pairs_menu_item)
    )
)



# Define UI for application that draws a histogram
shinyUI(
    bootstrapPage(
        useShinyjs(),
        dashboardPage(header, sidebar, body, skin = "green")
    )
    
)
