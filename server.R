
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(quantmod)

shinyServer(function(input, output) {
  output$inputValue = renderText({paste('\n ETF:', input$etf)}) 
  
  observe({
#    if(input$factor == 'None'){
#      output$results = renderPrint({'Please select a Liquidity Factor'})
#    } 
    if(input$etf == "None"){
      output$results = renderText({"\nPlease select ETF\n"})
    }
    else{
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
      
      output$results = renderText({paste('\nETF:', input$etf, '\nBasis points: ',(-10000 * log(NAV / (NAV + (ETF-NAV)))))})
      
    }

    if(input$stock == ""){
      output$stockresults = renderText({"\nPlease enter a Stock symbol\n"})
    }
    else{
      getSymbols(input$stock)
      df = get(input$stock)
      sp = tail(df[,6],21)
      rets = diff(log(sp))
      vol = tail(df[,5], 20)
      output$stockresults = renderText({paste('\nStock Ticker: ', input$stock, '\nBasis points: ',mean(abs(rets)/vol)*1000000)})
    }  

    if(input$stockruns == ""){
      output$runsresults = renderText({"\nPlease enter a Stock symbol\n"})
    }
    else{
      freq = matrix(0,100,1) 
      n = length(x)
      
      s = sign(x[1])
      xsum = x[1]
      len = 1
      maxrun = 1
      maxsum = -999; 
      minsum = +999; 
      for (i in 2:n) {
        xsum = xsum + x[i]
        if (xsum > maxsum) {maxsum = xsum}
        if (xsum < minsum) {minsum = xsum}
        if (sign(x[i])==s) { len = len + 1 }
        else {
          if (len > maxrun) { maxrun = len }
          freq[len] = freq[len] + 1
          s = sign(x[i])    
          len = 1	
        }
      }
      u = freq[1:maxrun]
      #print(u)
      lengths = as.matrix(1:maxrun)
      avg_rlength = sum(lengths * u)/sum(u)
      minmaxdiff = maxsum - minsum
      returnvals = c(avg_rlength,minmaxdiff,maxsum,minsum)
    }  
    
    return()
  })
  
  
})

