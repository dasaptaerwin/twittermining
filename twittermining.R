# Code borrowed from: http://www.salemmarafi.com/code/harvesting-tweets-with-r/ and
# http://bogdanrau.com/blog/collecting-tweets-using-r-and-the-twitter-search-api/
  
install.packages("twitteR")
install.packages("RCurl")
install.packages("ROAuth")
install.packages("rvest")

library("twitteR")
library("RCurl")
library("ROAuth")
library("rvest")

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "http://api.twitter.com/oauth/authorize"

apiKey <- "wnF9e0sVO8CElyHWr1auDknpj"
apiSecret <- "fxLAapVdEbuUmYH56nNlkp7srJkYykGwEShGYzA35LCvi2uQdt"
accessToken <- "225236194-W0NY0Pu8TyZINbYBXOgqnIFGBay5kViOQlR2Mrjq"
accessTokenSecret <- "SAF4VVLfWgNCBMtysYtxqIKZa8MaeCIhZktQLAvX9JAzX"


twitCred <- OAuthFactory$new(
  consumerKey=apiKey,
  consumerSecret=apiSecret,
  requestURL=reqURL,
  accessURL=accessURL,
  authURL=authURL)

twitCred$handshake()

setup_twitter_oauth(apiKey,
                    apiSecret,
                    accessToken,
                    accessTokenSecret)

registerTwitterOAuth(twitCred)
save(list="twitCred", file="credentials")

query <- "ahok"
query <- unlist(strsplit(query,","))
tweets = list()

for(i in 1:length(query)){
  result<-searchTwitter(query[i], n=1500, geocode='-6.208763, 106.845599, 80mi')
  tweets <- c(tweets,result)
  tweets <- unique(tweets)
}

# search feeds
query = searchTwitter("ahok", 
                      n=1500, 
                      lang="id",
                      #sinceID = NULL, 
                      since="2014-02-01", until="2015-02-15"
                      geocode="-6.208763, 106.845599, 80mi",
                      retryOnRateLimit=10)

tweets <- searchTwitter("#bukitduri", 
                        n=1500, lang="id", since="2015-01-01")

tweets_papanggo <- searchTwitter("papanggo", 
                        n=1500, lang="id", since="2015-01-01")

tweets_batang <- searchTwitter("luar batang", 
                                 n=1500, lang="id", since="2015-01-01")

tweets_relokasi <- searchTwitter("relokasi",
                      n=2000, 
                      lang="id",
                      since="2015-10-01")

tweets_penggusuran <- searchTwitter("penggusuran paksa",
                                 n=2000,
                                 lang="id",
                                 since="2015-10-01")

tweets_jodoh <- searchTwitter("kali jodoh",
                                    n=2000,
                                    lang="id",
                                    since="2015-10-01")

tweets_ikan <- searchTwitter("kampung pasar ikan",
                                    n=2000,
                                    lang="id",
                                    since="2015-10-01")

tweets_ciliwung <- searchTwitter("kali ciliwung",
                             n=2000,
                             lang="id",
                             since="2015-10-01")



                      geocode="-6.208763, 106.845599, 100mi")


# Transform tweets list into a data frame
tweets.df <- twListToDF(tweets)
tweets_papanggo.df <- twListToDF(tweets_papanggo)
tweets_batang.df <- twListToDF(tweets_batang)
tweets_relokasi.df <- twListToDF(tweets_relokasi)
tweets_penggusuran.df <- twListToDF(tweets_penggusuran)
tweets_jodoh.df <- twListToDF(tweets_jodoh)
tweets_ikan.df <- twListToDF(tweets_ikan)
tweets_ciliwung.df <- twListToDF(tweets_ciliwung)
