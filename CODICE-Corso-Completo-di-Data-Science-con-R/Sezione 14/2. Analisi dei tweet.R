bd1 <- searchTwitter("#bigdata", n=2000, lang="en")


# estraiamo il testo dei tweets
bd2 <- sapply(bd1, function(x) x$getText())

# pacchetto tm
library(tm)

# convertiamo in corpus, in modo da poterlo trattare con tm 
bdc <- Corpus(VectorSource(bd2))

# ripuliamo il testo
bdc <- tm_map(bdc, content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')), mc.cores=1)
bdc <- tm_map(bdc, content_transformer(tolower)) 
bdc <- tm_map(bdc, removePunctuation)
bdc <- tm_map(bdc, function(x)removeWords(x,stopwords()))

# creiamo la matrice termini documenti
tdm <- TermDocumentMatrix(bdc)

# calcoliamo la frequenza dei termini
term.freq <- rowSums(as.matrix(tdm))

# eliminiamo i termini con frequenza inferiore a 20
term.freq <- subset(term.freq, term.freq >= 20)


# visualizziamo i venti termini più frequenti
findFreqTerms(tdm, lowfreq = 30)

# quali termini sono associati con “mining”?
findAssocs(tdm, "data", 0.2)

# convertiamo in matrice
matr <- as.matrix(tdm)
word_freqs <- sort(rowSums(matr), decreasing = TRUE)

# creiamo una rappresentazione dei termini tramite wordcloud. Per fare questo, dobbiamo installare e richiamare il pacchetto wordcloud

install.packages("wordcloud")
library(wordcloud)

dm <- data.frame(word = names(word_freqs), freq = word_freqs)
wordcloud(dm$word, dm$freq, random.order = FALSE , colors = brewer.pal(8,"Dark2"))

# rimuoviamo i termini meno utilizzati
tdm2 <- removeSparseTerms(tdm, sparse = 0.95)

# convertiamo la matrice Termini-Documenti in matrice semplice
mat2 <- as.matrix(tdm2)

# calcoliamo la distanza
distM <- dist(scale(mat2))
fit <- hclust(distM, method = "ward.D2")

# creiamo il dendrogramma
plot(fit)


# creiamo una seconda wordcloud ripulita dai termini meno usati
word_freqs2 <- sort(rowSums(mat2), decreasing = TRUE)
dm2 <- data.frame(word = names(word_freqs2), freq = word_freqs2)
wordcloud(dm2$word, dm2$freq, random.order = FALSE , colors = brewer.pal(8,"Dark2"))
