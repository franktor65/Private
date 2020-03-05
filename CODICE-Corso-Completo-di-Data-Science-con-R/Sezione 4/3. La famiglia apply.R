## apply()

# creiamo la matrice 
esempio.matrice <- matrix(1:12, nrow=4)

# stampiamo la matrice
esempio.matrice


# facciamo la media delle colonne con apply() e il valore 2
apply(matrice, 2, mean)


# facciamo un secondo esempio, effettuando la media delle righe (1)
apply(matrice, 1, mean)

# quando vogliamo effettuare calcoli sulle colonne inseriamo come secondo argomento il numero 1, mentre se vogliamo calcolare ad esempio, la media per colonna, inseriamo come secondo argomento il numero 2

# ricordiamo che per effettuare la somma delle righe e delle colonne possiamo anche usare le funzioni rowSums() e colSums()

## lapply()

esempio.lista <- list(A = matrix(1:12, 4), B = 20:40, C = -10:-20, D = matrix(1:9, 3))

lapply(esempio.lista, sum)

# proviamo ad applicare lapply() al dataset precaricato iris, per ottenere le classi delle variabili

lapply(iris, class)

## sapply()

# riprendiamo la lista che abbiamo creato nell’esempio precedente
esempio.lista <- list(A = matrix(1:12, 4), B = 20:40, C = -10:-20, D = matrix(1:9, 3))

# applichiamo sapply()
sapply(esempio.lista, sum)

# applichiamolo al dataset iris: 

sapply(iris, class)

sapply(iris[,1:4], mean)

## vapply()

## mapply()

# creiamo due liste
esempio.lista1 <- list(A = matrix(1:12, 4), B = 20:40, C = -10:-20, D = matrix(1:9, 3))

esempio.lista2 <- list(A = matrix(1:12, 3), B = 20:40, C = -10:-20, D = matrix(1:9, 3))

# come si può vedere, le due liste sono quasi identiche. Utilizziamo mapply per confrontarle
mapply(identical, esempio.lista1, esempio.lista2)

# mapply() confronta elemento per elemento e ci restituisce il risultato sotto forma di vettore logico 

## tapply()

tapply(iris$Petal.Length, iris$Species, mean)

aggregate(Petal.Length ~ Species, iris, mean)


aggregate(cbind(Petal.Length, Petal.Width)~Species, iris, mean)


# na.rm = TRUE


