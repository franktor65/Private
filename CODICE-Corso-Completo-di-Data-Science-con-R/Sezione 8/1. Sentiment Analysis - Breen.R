# connessione a Twitter
api_key <-  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
api_secret <- "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
access_token <- "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
access_secret <- "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

# caricamento del pacchetto twitteR
library(twitteR)

# interrogazione del database di Twitter ed estrazione di 2.000 tweets per ogni azienda scelta
bd1 <- searchTwitter("Apple", n=2000, lang="en")
bd2 <- searchTwitter("Windows", n=2000, lang="en")
bd3 <- searchTwitter("Linux", n=2000, lang="en")

# carichiamo il pacchetto plyr
library(plyr)

# estraiamo il testo dai tweet
bd1a <- laply(bd1, function(t)t$getText())
bd2a <- laply(bd2, function(t)t$getText())
bd3a <- laply(bd3, function(t)t$getText())

# importiamo le liste di parole positive e negative
pos <- scan("/Users/valentinaporcu/Downloads/opinion-lexicon-English\ Folder/positive-words.txt", what = "character", comment.char = ";")
neg <- scan("/Users/valentinaporcu/Downloads/opinion-lexicon-English\ Folder/negative-words.txt", what = "character", comment.char = ";")

# possiamo anche ampliare le liste di parole con la funzione combine, c()
pos.words <- c(pos, "upgrade")
neg.words <- c(neg, "wtf", "epicfail")

# creiamo una funzione per misurare il sentiment 
score.sentiment2 <- function(sentences, pos.words, neg.words, .progress="none")
{
        require(plyr)
        require(stringr)
        
        scores = laply(sentences, function(sentence, pos.words, neg.words) {
                
                # normalizziamo il testo tramite la funzione gsub() e le espressioni regolari
                sentence <- gsub("[[:punct:]]", "", sentence)
                sentence <- gsub("[[:cntrl:]]", "", sentence)
                sentence <- gsub("\\d+", "", sentence)
                sentence <- iconv(sentence, "UTF-8", "ASCII")
                # convertiamo in minuscolo
                sentence <- tolower(sentence)
                
                # creiamo i vettori di parole
                word.list <- str_split(sentence, "\\s+")
                # delistiamo le parole
                words <- unlist(word.list)
                
                # confrontiamo le parole con le liste di parole positive e negative
                pos.matches <- match(words, pos.words)
                neg.matches <- match(words, neg.words)
                
        
                pos.matches <- !is.na(pos.matches)
                neg.matches <- !is.na(neg.matches)
                
                # creiamo un punteggio dove sommiamo le parole positive e le negative
                score <- sum(pos.matches) - sum(neg.matches)
                
                return(score)
        }, pos.words, neg.words, .progress=.progress )
        
        scores.df <- data.frame(score=scores, text=sentences)
        return(scores.df)
}


# testiamo la funzione su alcune frasi
frasi <- c("You're awesome and I love you", "I hate and hate and hate. So angry. Die!", "Impressed and amazed: you are peerless in your achievement of unparalleled mediocrity")
score.sentiment2(frasi, pos.words, neg.words)

# testiamo la funzione sui nostri tweet
result_bd1a <- score.sentiment2(bd1a, pos.words, neg.words, .progress="text")
result_bd2a <- score.sentiment2(bd2a, pos.words, neg.words, .progress="text")
result_bd3a <- score.sentiment2(bd3a, pos.words, neg.words, .progress="text")

# visualizziamo uno dei dataframe
View(result_bd1a)

# visualizziamo i risultati
hist(result_bd1a$score)
hist(result_bd2a$score)
hist(result_bd3a$score)




