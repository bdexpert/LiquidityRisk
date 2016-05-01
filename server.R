
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)


shinyServer(function(input, output) {
#  output$inputValue = renderText({paste('Liquidity Factor:',input$factor, '\n ETF:', input$etf)}) 
  
  observe({
#    if(input$factor == 'None'){
#      output$results = renderPrint({'Please select a Liquidity Factor'})
#    } 
#    if(input$etf == 'None'){
#      output$results = renderPrint({'Please select ETF'})
#    }     
    if(input$factor == "billiq"){
      if(input$etf == "LQD")
      {
        text = try(readLines("https://www.ishares.com/us/products/239566/LQD"))
      }
      if(input$etf == "HYG")
      {
        text = try(readLines("https://www.ishares.com/us/products/239565/HYG"))
      }
      if(input$etf == "CSJ")
      {
        text = try(readLines("https://www.ishares.com/us/products/239451/CSJ"))
      }
      if(input$etf == "CFT")
      {
        text = try(readLines("https://www.ishares.com/us/products/239460/CRED"))
      }
      if(input$etf == "CIU")
      {
        text = try(readLines("https://www.ishares.com/us/products/239463/CIU"))
      }
      if(input$etf == "AGG")
            {
        text = try(readLines("https://www.ishares.com/us/products/239458/AGG"))
      }
      if(input$etf == "GBF")
      {
        text = try(readLines("https://www.ishares.com/us/products/239462/GBF"))
      }
      if(input$etf == "GVI")
      {
        text = try(readLines("https://www.ishares.com/us/products/239464/GVI"))
      }
      if(input$etf == "MBB")
      {
        text = try(readLines("https://www.ishares.com/us/products/239465/MBB"))
      }
      if(input$etf == "EMB")
      {
        text = try(readLines("https://www.ishares.com/us/products/239572/EMB"))
      }
      if(input$etf == "IVV")
      {
        text = try(readLines("https://www.ishares.com/us/products/239726/IVV"))
      }
      
      NAVtext = text[setdiff(seq(1,length(text)),grep("<",text))]
      vNAV = grep("NAV", NAVtext)
      NAV = as.numeric(sub("\\$", "", NAVtext[vNAV[1] - 1]))
      vETF = grep("Mid-Point Price", text)
      ETF = as.numeric(sub(" </td>", "", text[vETF[1] + 7]))
      
      output$results = renderText({paste('Liquidity Factor:',input$factor, '\nETF:', input$etf, '\nBasis points: ',(-10000 * log(NAV / (NAV + (ETF-NAV)))))})
      
    }

    if(input$factor == 'amihud'){
      
#      output$results = 
    }
    

    return()
  })
  
  
})

