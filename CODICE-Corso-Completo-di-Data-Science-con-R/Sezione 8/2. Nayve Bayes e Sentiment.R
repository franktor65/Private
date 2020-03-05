library(tm)
pos <- VCorpus(DirSource(directory = "/Users/valentinaporcu/R_test/review_polarity/txt_sentoken/pos", encoding = "UTF-8"))
neg <- VCorpus(DirSource(directory = "/Users/valentinaporcu/R_test/review_polarity/txt_sentoken/neg", encoding = "UTF-8"))

rec <- c(pos, neg)

rec <- tm_map(rec, content_transformer(tolower))
rec <- tm_map(rec, removePunctuation)
rec <- tm_map(rec, removeWords, stopwords("english"))
rec <- tm_map(rec, removeNumbers)
rec <- tm_map(rec, stripWhitespace)
rec <- tm_map(rec, content_transformer(stemDocument))


tfidf <- DocumentTermMatrix(rec, control = list(weighting = function(x) weightTfIdf(x, normalize = TRUE)))
sr <- as.matrix(removeSparseTerms(tfidf, sparse = 0.7))

sent <- c(rep("pos",1000), rep("neg", 1000))
freq <- colSums(as.matrix(TermDocumentMatrix(rec)))
df <- as.data.frame(cbind(sent, freq, sr))

set.seed(12345)
random <- runif(nrow(df))
df2 <- df[order(random),]


train <- df2[1:1500, -2]
test <- df2[1501:2000, -2]


####### naive bayes
library(e1071)
class <- naiveBayes(train, as.factor(train[, 1]))
pred <- predict(class, test)

table(pred, test[,1])

library(caret)
confusionMatrix(data= pred, reference=test$sent, positive="pos")


#### secondo corpus

library(tm)
pos2 <- VCorpus(DirSource(directory = "/Users/valentinaporcu/R_test/IMDB_review/positive", encoding = "UTF-8"))
neg2 <- VCorpus(DirSource(directory = "/Users/valentinaporcu/R_test/IMDB_review/negative", encoding = "UTF-8"))
rec2 <- c(pos2, neg2)

rec2 <- tm_map(rec2, content_transformer(tolower))
rec2 <- tm_map(rec2, removePunctuation)
rec2 <- tm_map(rec2, removeWords, stopwords("english"))
rec2 <- tm_map(rec2, removeNumbers)
rec2 <- tm_map(rec2, stripWhitespace)
rec2 <- tm_map(rec2, content_transformer(stemDocument))


tfidf2 <- DocumentTermMatrix(rec2, control = list(weighting = function(x) weightTfIdf(x, normalize = TRUE)))
sr2 <- as.matrix(removeSparseTerms(tfidf2, sparse = 0.7))

sent2 <- c(rep("pos",1000), rep("neg", 1000))
freq2 <- colSums(as.matrix(TermDocumentMatrix(rec2)))
df_n <- as.data.frame(cbind(sent2, freq2, sr2))

set.seed(12345)
random2 <- runif(nrow(df_n))
df_n2 <- df[order(random2),]

dft <- df_n2[, -c(1,2)]


####### check del modello naive bayes sul secondo corpus
mod <- naiveBayes(train[,-1], as.factor(train[, 1]))
pred2 <- predict(mod, dft)

confusionMatrix(data= pred2, reference=df_n2$sent, positive="pos")


