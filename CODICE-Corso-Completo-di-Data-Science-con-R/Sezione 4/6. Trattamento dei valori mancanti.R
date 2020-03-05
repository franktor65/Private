x <- c(12, NA, 45, 57, 24, 48, NA)
x


is.na(x)


x <- c(12, NA, 45, 57, 24, 48, NA)
table(complete.cases(x))

x[is.na(x)]

x[!is.na(x)]

missing.di.x <- is.na(x)
missing.di.x

sum(missing.di.x)

read.csv("missing_test.csv")

read.csv("missing_test.csv", na.strings = "", strip.white = TRUE)

# per prima cosa carichiamo un secondo file di test che contiene i dati mancanti, e lo storiamo nell’oggetto ”test”
test <- read.csv("missing_test2.csv")
                  
# stampiamo l’oggetto creato
test


# creiamo un oggetto test2 dove applichiamo la funzione na.omit all’oggetto test
test2 <- na.omit(test)

# stampiamo l’oggetto test2

test2

# come si può vedere dagli ID, i casi contenenti missing values sono stati eliminati

# possiamo ottenere lo stesso risultato con la funzione na.exclude():

test3 <- na.exclude(test)
test3

# possiamo visualizzare i casi senza missing anche con la funzione complete.cases():
test[complete.cases(test),]

# o viceversa, possiamo visualizzare solo i casi contenenti missing:
test[!complete.cases(test),]

# poniamo di aver codificato tutti i dati di un vettore, e il codice 4 corrisponde a un valore mancante

# creiamo il nostro vettore x
x <- c(1, 2, 2, 1, 3, 3, 1, 2, 4, 1, 3, 3, 1, 3, 3, 4, 3, 4, 1)

# sostituiamo il valore 4 con NA, che sta per valore mancante
x[x == 4] <- NA

# stampiamo di nuovo x
x

install.packages("VIM")
library(VIM)

test <- read.csv("missing_test2.csv")

aggr(test)

matrixplot(test)

# potete caricare il dataset dal file incluso nella cartella oppure ricrearlo con questo codice
ID <- c(1,2,3,4,5,6,7,8,9)
gender <- c(f,f,f,f,m,m,m,m,m)
ex1 <- c(25,19,24,25,24,23,25,18,24)
ex2 <- c(NA,28,30,25,27,29,NA,23,27)
ex3 <- c(27,25,16,28,22,26,27,25,NA)

test <- cbind(ID, gender, ex1,ex2,ex3)
                  


