library(streamR)
library(rjson)
library(magrittr)
library(ggplot2)
install.packages("ggplot2")

setwd("/Users/hanaanber/Dropbox/Thesis/Datasets/ZamalekMayrterHashtag/Data")
ZamalekTweets = parseTweets("zamalekmartyr.json")
setwd("/Users/hanaanber/Dropbox/Thesis/Datasets/Enkezo_Internet/Data")
internet = parseTweets("internet.json")
setwd("/Users/hanaanber/Dropbox/Thesis/Datasets/RihamSaed/Data")
RihamTweets = parseTweets("RihamSaeed.json")
setwd("/Users/hanaanber/Dropbox/Thesis/Datasets/AtaloElmasry/Data")
elmasry = parseTweets("ataloElmasry.json")


dated_ZamalekTweets <- as.POSIXct(ZamalekTweets$created_at, format = "%a %b %d %H:%M:%S +0000 %Y")
dated_internet <- as.POSIXct(internet$created_at, format = "%a %b %d %H:%M:%S +0000 %Y")
dated_RihamTweets <-  as.POSIXct(RihamTweets$created_at, format = "%a %b %d %H:%M:%S +0000 %Y")
dated_elmasry <- as.POSIXct(elmasry$created_at, format = "%a %b %d %H:%M:%S +0000 %Y")

bins1 <- format(dated_ZamalekTweets, "%H") %>% 
  as.numeric() %>%
  cut(breaks=c(0,6,12,18,24), include.lowest = TRUE)
hTags <- data.frame(tag="Shohadaa El Zamalek", bins=bins1)

bins2 <- format(dated_internet, "%H") %>%
  as.numeric() %>%
  cut(breaks=c(0,6,12,18,24), include.lowest = TRUE)
hTags <-  rbind(hTags, data.frame(tag= "Enkezo el internet", bins=bins2)) 

bins3 <- format(dated_RihamTweets, "%H") %>%
  as.numeric() %>%
  cut(breaks=c(0,6,12,18,24), include.lowest = TRUE)
hTags <- rbind(hTags, data.frame(tag= "Riham Saeed", bins=bins3))

bins4 <- format(dated_elmasry, "%H") %>%
  as.numeric() %>%
  cut(breaks=c(0,6,12,18,24), include.lowest = TRUE)
hTags <- rbind(hTags, data.frame(tag="atalo el masry", bins=bins4))

ggplot(data=hTags, aes(x=bins, fill=tag)) + geom_bar(position="dodge", aes(y= (..count..)/ sum(..count..)))
