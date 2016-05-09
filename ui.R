
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)


shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Liquidity Risk of an Investment"),

  sidebarPanel(
  ),
  
  # Show the results of the computation
  mainPanel(
    tabsetPanel(
      tabPanel("Bond Illiquidity",
        h3('ETF'),
        selectInput(inputId = "etf", label = "Select an ETF: ",  choices = c('None','LQD','HYG','CSJ' ,'CFT' ,'CIU' ,'AGG' ,'GBF' ,'GVI' ,'MBB' ,'EMB', 'IVV'), selected = 'None'),
        submitButton('Submit'),
        verbatimTextOutput("results")   
       
      ),

      tabPanel("Stock Illiquidity", 
        h3('Stock'),
        textInput(inputId = "stock", label = "Select a Stock: "),
        submitButton('Submit'),
        verbatimTextOutput("stockresults")          ),       
      
      tabPanel("RUNS",
        h3('Stock RUNS'),
        textInput(inputId = "stockruns", label = "Select a Stock: "),
        submitButton('Submit'),
        verbatimTextOutput("runsresults")          )
  )
))
)
