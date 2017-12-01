# Listing 2.2



yahoo <- function(sym, current = TRUE,
                  a = 0, b = 1, c = 2000, d, e, f,
                  g = "d")
{
  library(curl)
  if(current){
    f <- as.numeric(substr(as.character(Sys.time()), start = 1, stop = 4))
    d <- as.numeric(substr(as.character(Sys.time()), start = 6, stop = 7)) - 1
    e <- as.numeric(substr(as.character(Sys.time()), start = 9, stop = 10))
  }
  deb<-as.integer( as.POSIXct( Sys.time() ) ) -31622400*3
  end<-as.integer( as.POSIXct( Sys.time() ) )
  require(data.table)
  url<-paste0("https://query1.finance.yahoo.com/v7/finance/download/",
              sym,
              "?period1=",deb,
              "&period2=",end,
              "&interval=1d",
              "&events=history&crumb=0vlktCe/gti")
#https://query1.finance.yahoo.com/v7/finance/download/ACN?period1=1509220928&period2=1511902928&interval=1d&events=history&crumb=0vlktCe/gti
#https://query1.finance.yahoo.com/v7/finance/download/MMM?period1=1509220928&period2=1511902928&interval=1d&events=history&crumb=0vlktCe/gti
#https://query1.finance.yahoo.com/v7/finance/download/ACE?period1=1509220928&period2=1511902928&interval=1d&events=history&crumb=0vlktCe/gti
  h <- new_handle(copypostfields = "moo=moomooo")
  
  # Perform the request
  req <- curl_fetch_memory("https://uk.finance.yahoo.com/quote/AAPL/history", handle = h)
  
  # Show some outputs
  cookie<-parse_headers(req$headers)[17]
  cookie<-gsub("Set-Cookie: ","",cookie)
  cookie<-strsplit(cookie, ";")[[1]][1]
  tmp <- tempfile()
  handle_setheaders(h,"cookie"=cookie)
  tryCatch(
  curl_download(url, tmp,handle=h),
  error = function(err) print(paste0("MY_ERROR:  ",err, ":'",url,"'"))
  )
  tryCatch(
  suppressWarnings(
  fread(tmp, sep = ",")),
  error = function(err) print(paste0("MY_ERROR:  ",err, ":'",url,"'"))
  )
}

