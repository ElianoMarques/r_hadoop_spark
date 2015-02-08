#1) Install Required Packages
if(!require(devtools)) {install.packages("devtools"); require(devtools)}
if(!require(httr)) {install.packages("httr"); require(httr)}
if(!require(bit64)) {install.packages("bit64"); require(bit64)}
if(!require(rjson)) {install.packages("rjson"); require(rjson)}
if(!require(twitteR)) {install_github("twitteR", username="geoffjentry"); require(twitteR)}
if(!require(httpuv)) {install.packages("httpuv"); require(httpuv)}
if(!require(ROAuth)) {install.packages("ROAuth"); require(ROAuth)}
if(!require(RCurl)) {install.packages("RCurl"); require(RCurl)}
if(!require(plyr)) {install.packages("plyr"); require(plyr)}
if(!require(stringr)) {install.packages("stringr"); require(stringr)}
if(!require(sqldf)) {install.packages("sqldf"); require(sqldf)}
if(!require(wordcloud)) {install.packages("wordcloud"); require(wordcloud)}
if(!require(tm)) {install.packages("tm"); require(tm)}
if(!require(RColorBrewer)) {install.packages("RColorBrewer"); require(RColorBrewer)}
options("scipen"=100, "digits"=8)
rm(list=c(ls()))
#1) Install Required Packages
if(!require(devtools)) {install.packages("devtools"); require(devtools)}
if(!require(httr)) {install.packages("httr"); require(httr)}
if(!require(bit64)) {install.packages("bit64"); require(bit64)}
if(!require(rjson)) {install.packages("rjson"); require(rjson)}
if(!require(twitteR)) {install_github("twitteR", username="geoffjentry"); require(twitteR)}
if(!require(httpuv)) {install.packages("httpuv"); require(httpuv)}
if(!require(ROAuth)) {install.packages("ROAuth"); require(ROAuth)}
if(!require(RCurl)) {install.packages("RCurl"); require(RCurl)}
if(!require(plyr)) {install.packages("plyr"); require(plyr)}
if(!require(stringr)) {install.packages("stringr"); require(stringr)}
if(!require(sqldf)) {install.packages("sqldf"); require(sqldf)}
if(!require(wordcloud)) {install.packages("wordcloud"); require(wordcloud)}
if(!require(tm)) {install.packages("tm"); require(tm)}
if(!require(RColorBrewer)) {install.packages("RColorBrewer"); require(RColorBrewer)}
options("scipen"=100, "digits"=8)
consumer_key="07Z3AsfvVU3bgZ7yY3snSwI45"
consumer_secret="mokxfy7poLpWvN9vMRE9AYg4HU01M7ZeJ7Hfonc7qRmps8QH88"
access_token="439584057-xeNtqHK294U5J8mwsnXDz2sIi4tWtnstKzVhPe1t"
access_secret="3LDSJs8pkkWz2KjqDXqZ5zTNmgfT8NgqdBSOHloNLO65a"
setup_twitter_oauth(consumer_key, consumer_secret,access_token,access_secret)
setup_twitter_oauth(consumer_key, consumer_secret,access_token,access_secret)
r_stats<- searchTwitter('#Factory', n=1500)
r_stats_text <- sapply(r_stats, function(x) x$getText())
#create corpus
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))
#clean up
r_stats_text_corpus=gsub('Ã©','e',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã§','c',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã ','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã¡','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã£','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ãª','e',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã¢','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã±','n',r_stats_text_corpus)
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text_corpus))
r_stats_text_corpus=tm_map(r_stats_text_corpus, function(x) iconv(enc2utf8(x), sub=""))
fix(r_stats_text_corpus)
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
fix(r_stats_text_corpus)
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))
#clean up
r_stats_text_corpus=gsub('Ã©','e',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã§','c',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã ','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã¡','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã£','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ãª','e',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã¢','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã±','n',r_stats_text_corpus)
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text_corpus))
View(r_stats_text_corpus)
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
fix(tdm)
View(tdm)
m = as.matrix(tdm)
# get word counts in decreasing order
View(m)
r_stats_text_corpus
r_stats_text_corpus[[1]]
objects(r_stats_text_corpus)
summary(r_stats_text_corpus)
r_stats_text_corpus[1]
r_stats_text_corpus(1)
class(r_stats_text_corpus)
meta(r_stats_text_corpus)[1]
inspect(r_stats_text_corpus)
inspect(r_stats)
r_stats[[1]]
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
inspect(tdm)
tdm = TermDocumentMatrix(
  r_stats,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
r_stats_text_corpus <- Corpus(VectorSource(r_stats))
r_stats_text <- sapply(r_stats, function(x) x$getText())
#create corpus
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))
tdm = TermDocumentMatrix(
  r_stats,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
r_stats_text_corpus=gsub('Ã©','e',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã§','c',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã ','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã¡','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã£','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ãª','e',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã¢','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã±','n',r_stats_text_corpus)
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text_corpus))
r_stats_text_corpus=tm_map(r_stats_text_corpus, function(x) iconv(enc2utf8(x), sub=""))
rm(list=c(ls()))
if(!require(devtools)) {install.packages("devtools"); require(devtools)}
if(!require(httr)) {install.packages("httr"); require(httr)}
if(!require(bit64)) {install.packages("bit64"); require(bit64)}
if(!require(rjson)) {install.packages("rjson"); require(rjson)}
if(!require(twitteR)) {install_github("twitteR", username="geoffjentry"); require(twitteR)}
if(!require(httpuv)) {install.packages("httpuv"); require(httpuv)}
if(!require(ROAuth)) {install.packages("ROAuth"); require(ROAuth)}
if(!require(RCurl)) {install.packages("RCurl"); require(RCurl)}
if(!require(plyr)) {install.packages("plyr"); require(plyr)}
if(!require(stringr)) {install.packages("stringr"); require(stringr)}
if(!require(sqldf)) {install.packages("sqldf"); require(sqldf)}
if(!require(wordcloud)) {install.packages("wordcloud"); require(wordcloud)}
if(!require(tm)) {install.packages("tm"); require(tm)}
if(!require(RColorBrewer)) {install.packages("RColorBrewer"); require(RColorBrewer)}
options("scipen"=100, "digits"=8)
#)2 Loggin to Twitter
consumer_key="07Z3AsfvVU3bgZ7yY3snSwI45"
consumer_secret="mokxfy7poLpWvN9vMRE9AYg4HU01M7ZeJ7Hfonc7qRmps8QH88"
access_token="439584057-xeNtqHK294U5J8mwsnXDz2sIi4tWtnstKzVhPe1t"
access_secret="3LDSJs8pkkWz2KjqDXqZ5zTNmgfT8NgqdBSOHloNLO65a"
setup_twitter_oauth(consumer_key, consumer_secret,access_token,access_secret)
#  setup_twitter_oauth(consumer_key, consumer_secret)
r_stats<- searchTwitter('factory', n=500)
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))
r_stats_text <- sapply(r_stats, function(x) x$getText())
#create corpus
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
inspect(tdm)
r_stats_text_corpus=tm_map(r_stats_text_corpus, function(x) iconv(enc2utf8(x), sub=""))
#inspect(r_stats_text_corpus)
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
inspect(tdm)
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text_corpus))
r_stats_text_corpus=tm_map(r_stats_text_corpus, function(x) iconv(enc2utf8(x), sub=""))
#inspect(r_stats_text_corpus)
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
r_stats_text_corpus=gsub('Ã©','e',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã§','c',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã ','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã¡','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã£','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ãª','e',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã¢','a',r_stats_text_corpus)
r_stats_text_corpus=gsub('Ã±','n',r_stats_text_corpus)
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text_corpus))
r_stats_text_corpus=tm_map(r_stats_text_corpus, function(x) iconv(enc2utf8(x), sub=""))
#inspect(r_stats_text_corpus)
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c("factory", "machine",'#production ','#efficiency' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    removeNumbers = TRUE, tolower = TRUE)
)
r_stats<- searchTwitter('machine learning', n=500)
#save text
r_stats_text <- sapply(r_stats, function(x) x$getText())
#create corpus
r_stats_text_corpus <- Corpus(VectorSource(r_stats_text))
tdm = TermDocumentMatrix(
  r_stats_text_corpus,
  control = list(
    removePunctuation = TRUE,
    #    stopwords = c("cristiano", "ronaldo",'#cristiano ','#ronaldo' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
    stopwords = c("machine", "learning",stopwords("english"),
                  removeNumbers = TRUE, tolower = TRUE)
  )
  inspect(tdm)
  tdm = TermDocumentMatrix(
    r_stats_text_corpus,
    control = list(
      removePunctuation = TRUE,
      #    stopwords = c("cristiano", "ronaldo",'#cristiano ','#ronaldo' ,stopwords("english"),stopwords("portuguese"),stopwords('french')),
      stopwords = c("machine", "learning",stopwords("english"),
                    removeNumbers = TRUE, tolower = TRUE)
    )
    
