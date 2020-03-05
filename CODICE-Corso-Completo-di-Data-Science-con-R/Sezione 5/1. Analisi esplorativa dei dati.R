# la funzione dim() ci rivela che abbiamo 31 casi e 3 variabili
dim(trees)

# la funzione str() ci rivela che abbiamo 31 osservazioni e tre variabili, tutte numeriche
str(trees)

# la funzione summary() ci restituisce valori minimi, massimi, media, mediana e quantili
summary(trees)

# le funzioni nrow() e ncol() ci restituiscono il numero di righe e di colonne rispettivamente
nrow(trees)

ncol(trees)

# la funzione names() ci restituisce i nomi delle variabili
names(trees)

# la funzione class() ci restituisce il tipo di oggetto
class(trees)


# le funzioni head() e tail() ci mostrano i primi e gli ultimi casi di una distribuzione
head(trees, 10)

tail(trees, 2)

# funzioni per la creazione di grafici
plot(trees$Girth, type = "b")

hist(trees$Volume)

barplot(trees$Volume)


# correlazione
cor(trees)

install.packages("corrplot2")
library(corrplot)

# salviamo la correlazione in un oggetto a parte e la utilizziamo per creare una matrice di correlazione con la funzione corrplot()
corr <- cor(trees)
corrplot(corr, method = "pie")

pairs(trees, main = "trees matrice di scatterplot", col = "blue")

# in questo modo possiamo mettere a confronto più grafici
par(mfrow = c(2,1))
plot(trees$Girth ~ trees$Volume)
plot(trees$Height ~ trees$Volume)

par(mfrow = c(2,2))
plot(iris$Sepal.Length ~ iris$Species)
plot(iris$Sepal.Width ~ iris$Species)
plot(iris$Petal.Length ~ iris$Species)
plot(iris$Petal.Width ~ iris$Species)

# sovrapporre due serie di dati
par(mar = c(5,4,4,4))
plot(trees$Girth ~ trees$Volume, col = 'blue')
par(new = T)
plot(trees$Height ~ trees$Volume, col = 'red')

