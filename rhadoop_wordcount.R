
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
par(bg = 'black')
wordcloud(words, max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, 
          colors=brewer.pal(8, 'Dark2'))
