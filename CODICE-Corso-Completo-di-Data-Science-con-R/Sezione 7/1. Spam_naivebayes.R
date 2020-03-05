# carichiamo il dataset
spam <- read.table("/Users/valentinaporcu/R_test/smsspamcollection/SMSSpamCollection", 
                   quote = "", 
                   sep='\t',
                   row.names = NULL, 
                   stringsAsFactors = FALSE)

# rinominiamo le colonne
colnames(spam) <- c("spam", "text")

# dividiamo il dataset in 2 parti: una di train e una di test. A ognuna delle due parti corrisponde il fattore dove è registrato se quel messaggio è "ham" o "spam"
set.seed(1234)
sampling <- sample.int(nrow(spam),as.integer(nrow(spam)*0.2),replace=F)
s_train <- spam[-sampling,]
s_test <- spam[sampling,]


f_train <- as.factor(s_train[,1])
f_test <- as.factor(s_test[,1])

t_train <- as.vector(s_train[,2])
t_test <- as.vector(s_test[,2])

# carichiamo il pacchetto tm
library(tm)

# normalizziamo l'oggetto di train
t_train <- VCorpus(VectorSource(t_train))

t_train <- tm_map(t_train,content_transformer(tolower))
t_train <- tm_map(t_train,stripWhitespace)
t_train <- tm_map(t_train,removePunctuation)
t_train <- tm_map(t_train,removeNumbers)
t_train <- tm_map(t_train,removeWords,stopwords("english"))
t_train <- tm_map(t_train,stemDocument)


# creiamo la matrice documenti-termini
t_train <- DocumentTermMatrix(t_train)

t_train <- removeSparseTerms(t_train, 0.98) 

t_train <- as.data.frame.matrix(t_train)

# normalizziamo l'oggetto di test
t_test <- VCorpus(VectorSource(t_test))

t_test <- tm_map(t_test,content_transformer(tolower))
t_test <- tm_map(t_test,stripWhitespace)
t_test <- tm_map(t_test,removePunctuation)
t_test <- tm_map(t_test,removeNumbers)
t_test <- tm_map(t_test,removeWords,stopwords("english"))
t_test <- tm_map(t_test,stemDocument)

# creiamo la matrice documenti-termini
t_test <- DocumentTermMatrix(t_test)

t_test <- removeSparseTerms(t_test, 0.98) 

t_test <- as.data.frame.matrix(t_test)

# carichiamo il pacchetto che contiene la funzione per il Naive Bayes
library(e1071)

# creiamo il modello sull'oggetto di train, utilizzando anche il fattore corrispondente
nb <- naiveBayes(t_train, f_train)

# creiamo la predizione per l'oggetto di test
pred <- predict(nb, t_test, type = "class")

table(pred, f_test)

# estraiamo dal modello predittivo nb la parte che contiene le percentuali: così possiamo vedere per ogni parola in quanti casi è collegata a messaggi che sono spam e in quanti casi è collegata a messaggi che non lo sono
tab <- nb$tables

# creiamo la funzione che estragga i punteggi dell'ham
fun_ham <- function(x){
        y <- x[1,1]
        y
}

# estraiamo i punteggi e riordiniamoli dal più grande al più piccolo
ham <- sapply(tab, fun_ham)
ham <- sort(ham, decreasing = T)

# creiamo la funzione che estragga i punteggi dello spam
fun_spam <- function(x){
        y <- x[2,1]
        y
}

# estraiamo i punteggi e riordiniamoli dal più grande al più piccolo
spam_v <- sapply(tab,fun_spam)
spam_v <- sort(spam_v, decreasing = T)

# creiamo la tabella che contenga i vari punteggi e visualizziamola
for_t <- cbind(ham, spam_v)
print.table(for_t)

View(print.table(for_t))




