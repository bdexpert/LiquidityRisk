
library(quantmod)

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
  vNAV = grep("NAV", NAVtext)
  NAV = as.numeric(sub("\\$", "", NAVtext[vNAV[1] - 1]))
  vETF = grep("Mid-Point Price", text)
  ETF = as.numeric(sub(" </td>", "", text[vETF[1] + 7]))

  return(-10000 * log(NAV / (NAV + (ETF-NAV))))
}

amihud = function(ticker)
{
  getSymbols(ticker)
  df = get(ticker)
  sp = tail(df[,6],21)
  rets = diff(log(sp))
  vol = tail(df[,5], 20)
  A_illiq = mean(abs(rets)/vol)*1000000
  return (A_illiq)
}

# RUNLENGTH(X)
# Compute run lengths of positive and negative episodes
# in a vector of values ranging from (-\infty,+\infty).
# June 8, 2009

runlength = function(x) {
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


#x = rnorm(20)
#print(runlength(x))


