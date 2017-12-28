library(streamR)
library(rjson)
library(ggplot2)
library(magrittr)

setwd("...........")
tweets = parseTweets("file.json")
dated_tweets <- as.POSIXct(tweets$created_at, format = "%a %b %d %H:%M:%S +0000 %Y")

bins1 <- format(dated_tweets, "%H") %>% 
  as.numeric() %>%
  cut(breaks=c(0,6,12,18,24), include.lowest = TRUE)
hTags <- data.frame(tag="#1", bins=bins1)
ggplot(data=hTags, aes(x=bins, fill=tag)) + geom_bar(position="dodge")

