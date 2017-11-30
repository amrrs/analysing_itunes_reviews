library(itunesr)

#Latest (Page 1) Uber Reviews for the Country: US
uber_reviews <- getReviews(368677368,'us',1)

#Displaying the column names 
names(uber_reviews)

#Ratings count from the 50 Reviews
table(uber_reviews$Rating)


#Ratings Trend

library(highcharter)
library(dplyr)
library(lubridate)

dt <- uber_reviews

dt$Date <- as.Date(dt$Date)

dt$Rating <- as.numeric(dt$Rating)    

dt <- dt %>% select(Date,Rating) %>% group_by(Date) %>% summarise(Rating = round(mean(Rating),2))

highchart() %>%   hc_add_series_times_values(dt$Date,dt$Rating, name = 'Average Rating')



#Sentiment Analysis 

library(sentimentr)

reviews_only <- as.character(uber_reviews$Review)

sentiment_scores <- reviews_only %>% sentiment_by(by=NULL)

highchart() %>% hc_xAxis(sentiment_scores$element_id) %>% hc_add_series(sentiment_scores$ave_sentiment, name = 'Reviews Sentiment Scores')

