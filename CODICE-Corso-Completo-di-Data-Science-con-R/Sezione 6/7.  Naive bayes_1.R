library(e1071)


# impostiamo il set.seed() per rendere l’analisi replicabile
set.seed(12345)

# mescoliamo i casi
random <- runif(nrow(iris))
iris2 <- iris[order(random),]

# creiamo un oggetto di train e uno di test
train <- iris2[1:100,]
test <- iris2[101:150,]

# creiamo il modello tramite la funzione naiveBayes() del pacchetto e1071
nb <- naiveBayes(Species ~., data = train)

# creiamo la predizione sull’oggetto di test
pred <- predict(nb, test)

# mettiamo a confronto dati effettivi e dati previsti
table(pred, test$Species)
