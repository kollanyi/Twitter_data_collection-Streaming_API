# Load the necessary packages
require(streamR)
require(ROAuth)
require(stringr)

# Filter stream
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "API Key goes here"
consumerSecret <- "API Secret Key goes here" 


my_oauth <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))

for (i in 1:3000) {
  filename = paste("Filename_", i, ".json", sep = "")
  print(format(Sys.time(), "%a %b %d %X %Y"))
  print(filename)
  filterStream(file=filename, track="
               #Hashtag1, #Hashtag2, Keyword1, Keyword2", 
               timeout=21600, oauth=my_oauth)
}
