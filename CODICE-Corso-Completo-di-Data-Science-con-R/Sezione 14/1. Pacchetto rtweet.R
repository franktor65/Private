# inserire callback url http://127.0.0.1:1410 nell'applicazione su app.twitter.com al tab settings

install.packages("rtweet")
library(rtweet)

twitter_tokens <- c(
        create_token(app = "nome_app",
                     consumer_key = "XXXXXXXXXXXXXXXXXXXXXXXX",
                     consumer_secret = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"))

df <- search_tweets("#MakeMeSmileIn3Words", n = 2000, type = "recent")


get_favorites("@AstroSamantha", n = 100, since_id = NULL, max_id = NULL, parse = TRUE, token = NULL)


get_followers("@AstroSamantha", n = 100, page = "-1", parse = TRUE, token = NULL)


get_friends("@AstroSamantha", page = "-1", parse = TRUE, token = NULL)


get_timeline("@AstroSamantha", n = 100, max_id = NULL, parse = TRUE, token = NULL)

get_trends(woeid = 721943, exclude = FALSE, token = NULL, parse = TRUE)



# stream tweets che menzionano la query brexit per 90 secondi
stream_tweets("brexit", timeout = 90)



statuses <- c("@HillaryClinton", "#OHHillYes","#HRCle", "#OHVotesEarly", "@potus")

df2 <- lookup_statuses(statuses)

lookup_users("@AstroSamantha", token = NULL, parse = TRUE)



f1 <- get_followers("potus", n = 75000)
page <- next_cursor(f1)
sys.Sleep(15*60)
f2 <- get_followers("potus", n = 75000, page = page)


search_users(q = "political communication", n = 1000)

trends_available(token = NULL, parse = TRUE)


ts_plot(x, by = "days", ...)
