# creiamo una sequenza di numeri da 1 a 50 e la chiamiamo x
x <- 1:50

# tutti i valori di x maggiori di 25
x > 25

# risposta come vettore logico

# per avere la risposta in forma numerica
# estraiamo gli elementi di x maggiori di 17
x [x 17]

# creiamo un oggetto y e gli attribuiamo gli elementi di x minori di dieci
y <- x[x<10]

# stampiamo y
y

x%in%c(58,147,22,69,49,13)

# ad esempio in questo modo, dal database iris, estraiamo solo i dati della terza colonna
iris[, 3]

# la virgola all’inizio significa che non stiamo prendendo in considerazione le righe, ma solo la terza colonna

iris[5:7,]

# subset

subset(Orange, Orange$Tree == 4)

setosa <- subset(iris, Species=="setosa")
virginica <- iris[which(iris$Species== "virginica"),]

# creiamo un vettore y dove andremo a registrare tutti gli elementi di z che sono diversi da na (not available, ossia valori mancanti)
y <- z[!is.na(z)]

# creiamo un vettore x che contiene una sequenza di numeri da venti a trenta
x <- 20:30
x

# estraiamone tutti i valori tranne il quarto e il settimo 
x[c(-4, -7)]

# oppure facciamo la stessa cosa in questa maniera
x[-c(4,7)]

# creiamo un oggetto x con la funzione rnorm che contenga 1000 elementi con media 3
x <- rnorm(1000, 3)

# creiamo un oggetto y di 500 elementi
y <- rnorm(500)

# estraiamo un campione casuale di 10 elementi con la funzione sample(), creando un altro oggetto che chiamiamo 10
z <- sample(c(x,y), 10)
z

# creiamo un vettore x
x <- c(1, 2, 2, 1, 3, 3, 1, 2, 4, 1, 3, 3, 1, 3, 3, 4, 3, 4, 1)

# adesso sostituiamo tutti gli uno con dei 5
x[x == 1] <- 5

# stampiamo il nuovo vettore x
x

campione.casuale <- iris[sample(1:nrow(iris), 50, replace=FALSE),]
campione.casuale

# usiamo la funzione attach sul dataset iris
attach(iris)

# adesso applichiamo la funzione summary a una della variabili di iris
summary(Petal.Length)

# per cancellare la funzione attach() usiamo la funzione detach()
detach(iris)

with(iris, summary(Petal.Length))


