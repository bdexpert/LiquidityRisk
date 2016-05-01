
billiq = function(etf_sym) 
  {
  if(etf_sym == "LQD")
  {
    text = try(readLines("https://www.ishares.com/us/products/239566/LQD"))
  }
  if(etf_sym == "HYG")
  {
    text = try(readLines("https://www.ishares.com/us/products/239565/HYG"))
  }
  if(etf_sym == "CSJ")
  {
    text = try(readLines("https://www.ishares.com/us/products/239451/CSJ"))
  }
  if(etf_sym == "CFT")
  {
    text = try(readLines("https://www.ishares.com/us/products/239460/CRED"))
  }
  if(etf_sym == "CIU")
  {
    text = try(readLines("https://www.ishares.com/us/products/239463/CIU"))
  }
  if(etf_sym == "AGG")
  {
    text = try(readLines("https://www.ishares.com/us/products/239458/AGG"))
  }
  if(etf_sym == "GBF")
  {
    text = try(readLines("https://www.ishares.com/us/products/239462/GBF"))
  }
  if(etf_sym == "GVI")
  {
    text = try(readLines("https://www.ishares.com/us/products/239464/GVI"))
  }
  if(etf_sym == "MBB")
  {
    text = try(readLines("https://www.ishares.com/us/products/239465/MBB"))
  }
  if(etf_sym == "EMB")
  {
    text = try(readLines("https://www.ishares.com/us/products/239572/EMB"))
  }
  if(etf_sym == "IVV")
  {
    text = try(readLines("https://www.ishares.com/us/products/239726/IVV"))
  }
  
  NAVtext = text[setdiff(seq(1,length(text)),grep("<",text))]
#  text = text[setdiff(seq(1,length(text)),grep(">",text))]
#  text = text[setdiff(seq(1,length(text)),grep("]",text))]
#  text = text[setdiff(seq(1,length(text)),grep("}",text))]
#  text = text[setdiff(seq(1,length(text)),grep("_",text))]
#  text = text[setdiff(seq(1,length(text)),grep("\\/",text))]
  vNAV = grep("NAV", NAVtext)
  NAV = as.numeric(sub("\\$", "", NAVtext[vNAV[1] - 1]))
  vETF = grep("Mid-Point Price", text)
  ETF = as.numeric(sub(" </td>", "", text[vETF[1] + 7]))

  return(-10000 * log(NAV / (NAV + (ETF-NAV))))
}
library(quantmod)
amihud = function(ticker)
{
#ticker = "GOOG"
getSymbols(ticker)
df = get(ticker)
sp = tail(df[,6],21)
rets = diff(log(sp))
vol = tail(df[,5], 20)
A_illiq = mean(abs(rets)/vol)*1000000
return (A_illiq)
}

