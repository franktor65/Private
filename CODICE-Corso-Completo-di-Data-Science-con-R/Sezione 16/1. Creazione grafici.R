plot(women)

# esempio1
with(women, plot(x = weight, y = height))

# esempio2
with(women, plot(weight, height))


# with(nome.dataset, plot(x,y)) 

# plot(x=nome.dataframe$nome.variabile1,y=nome.dataframe$nome.variable2)



plot(x= iris$Sepal.Length, y=iris$Sepal.Width)

plot(x= iris$Sepal.Length, y=iris$Sepal.Width, main="TEST")

plot(iris$Sepal.Length, iris$Sepal.Width,
     xlab = "Length",
     ylab = "Width",
     main = "TEST")


plot(x= iris$Sepal.Length, y=iris$Sepal.Width, main="TITOLO", sub="Sotto-titolo")

plot(x= iris$Sepal.Length, y=iris$Sepal.Width, col=3)

plot(x= iris$Sepal.Length, y=iris$Sepal.Width, col= "purple")

plot(x= iris$Sepal.Length, y=iris$Sepal.Width, col="cadetblue4", pch=11)

rug(iris$Sepal.Length)

colors()

table(women)

table(iris$Species)

eta <- c(25, 32, 44, 28, 27, 34, 36, 56, 26, 29, 32, 30, 18, 15, 27)
numero.acquisti <- c(4, 2, 1, 5, 6, 2, 7, 3, 4, 10, 5, 4,5,3,2)

# creiamo una matrice unendo le colonne con cbind()
prodotto1 <- cbind(eta, numero.acquisti)

# stampiamo la matrice
prodotto1


# creiamo un istogramma
hist(prodotto1)

barplot(eta, numero.acquisti)

barplot(eta, numero.acquisti, horiz = TRUE)

barplot(diamonds$color)

tabella1 <- table(diamonds$color)

barplot(tabella1)

barplot(tabella1, col = "red")

# come vedete tra virgolette mettiamo il nome del colore


barplot(tabella1, col = rainbow(7))

# all'interno dell'argomento col = rainbow indichiamo 7 come il numero di colonne, altrimenti R utilizzerà più volte uno stesso colore

barplot(tabella1, col = topo.colors(7))
barplot(tabella1, col = heat.colors(7))

boxplot(Temp ~ Month, airquality, xlab= "Temp", ylab="Month")

# creiamo per prima cosa un oggetto
percentuale <- c(20, 30, 10, 7, 13, 5, 4, 6, 5)

# creiamo un grafico a torta con i dati dell’oggetto creato
pie(percentuale)


pie(percentuale,main="Percentuali", col=topo.colors(length(percentuale)), 
    labels=c("20%","30%","10%","7%","13%","5%","4%", "6%", "5%"))
        
# creiamo un oggetto
frutta <- c("mele", "pere", "avocado", "kiwi", "banane", "fragole", "nespole", "mele", "mele", "mele", "pere", "pere", "pere", "pere", "kiwi",  "mele", "fragole", "banane", "banane" )

# creiamo adesso una tabella con la funzione table()
tabella <- table(frutta)

# creiamo il grafico a mosaico
mosaicplot(tabella)
                    



