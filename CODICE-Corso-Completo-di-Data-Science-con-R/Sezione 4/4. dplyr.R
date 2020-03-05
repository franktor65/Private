install.packages("dplyr")
library(dplyr)

## select()

# selezioniamo tutte le variabili mettendo il nome di ognuna
select(iris, Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species)

# selezioniamo le stesse variabili con il simbolo “:”
select(iris, Sepal.Length:Species)

select(iris, Species:Sepal.Length)

select(iris, -Species)

select(iris, -(Petal.Length:Sepal.Length))


## mutate()


# creiamo un dataset che presenta il totale passeggeri di una compagnia aerea negli ultimi 6 anni

anno <- c(2010, 2011, 2012, 2013, 2014, 2015)
primo.trim <- c(3400, 2900, 3000, 3500, 2800, 3000)
secondo.trim <- c(4500, 4700, 4400, 5000, 5600, 5700)
terzo.trim <- c(7100, 7800, 6500, 6000, 6400, 7000)
quarto.trim <- c(3700, 4000, 4500, 2900, 3000, 2500)

# creiamo un dataframe con i vettori creati e cbind()
passeggeri <- as.data.frame(cbind(anno, primo.trim, secondo.trim, terzo.trim, quarto.trim))

# sommiamo il totale passeggeri e creiamo con mutate una nuova variabile che contenga tutti i passeggeri per ogni anno
mutate(passeggeri, totale.passeggeri = primo.trim+secondo.trim+terzo.trim+quarto.trim)


# se vogliamo includere la nuova variabile totale.passeggeri, ricordiamo sempre che dobbiamo sovrascrivere il vecchio dataset o crearne uno nuovo. In questo caso, per non confonderci nei passaggi, creiamone uno nuovo:
passeggeri2 <- mutate(passeggeri, totale.passeggeri = primo.trim+secondo.trim+terzo.trim+quarto.trim)

# sempre con mutate, creiamo una nuova variabile che calcoli la media di passeggeri per ogni mese 
mutate(passeggeri2, media.anno=totale.passeggeri/12)

## filter()

filter(iris, Species== "setosa")


# ad esempio, estraiamo tutti i casi dal dataset iris che non sono etichettati come “setosa”
senza.setosa <- filter(iris, Species!="setosa")

senza.setosa

# in questo caso abbiamo usato l’operatore !=

# potremo anche restringere ad altri sottogruppi, ad esempio estraendo da una variabile solo i casi maggiori di o minori di un valore
virginica <- filter(iris, Species=="virginica", Petal.Length <= 5)
virginica

## arrange()

# ad esempio, organizziamo il dataset iris in base alla variabile Sepal.Length

arrange(iris, Sepal.Length)

arrange(iris, Sepal.Length, Petal.Width)

arrange(iris, desc(Sepal.Length))

## group_by()

# creiamo un oggetto leggendo da un file .csv nella working directory e stampiamolo 
studenti <- read.csv("studenti.csv", header=TRUE)
studenti

group_by(studenti, genere)

studenti %>% select(genere, voto3) %>% print

## summarise()

summarise(studenti, media1 = mean(voto1), media2 = mean(voto2), media3 = mean(voto3))

summarise(studenti, mediana1 = median(voto1), mediana2 = median(voto2), mediana3 = median(voto3))

summarise(studenti, minimo = min(c(voto1, voto2, voto3)), massimo = max(c(voto1, voto2, voto3)))


## glimpse()

glimpse(iris)



