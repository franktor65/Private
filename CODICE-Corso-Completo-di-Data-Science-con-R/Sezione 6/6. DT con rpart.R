# carichiamo i dati
churn <- read.csv("churn.csv", na.strings = "", strip.white = TRUE, sep = "," )

# visualizziamo un riepilogo dei dati
summary(churn)

# creiamo un oggetto che contiene i nostri dati e un altro che contiene i dati completi
# la funzione rpart() permette di gestire i missing tramite l'argomento na.action, ma noi vogliamo verificare il modello sugli oggetti mancanti
topred <- churn[is.na(churn$label),]

churn <- churn[complete.cases(churn),]

# impostiamo il seed ed estraiamo, dall'oggetto con i casi completi, un oggetto di train e uno di test
set.seed(1234)
sampling <- sample(2, nrow(churn), replace=TRUE, prob=c(0.7, 0.3))
train <- churn[sampling==1,]
test <- churn[sampling==2,]


# creiamo un modello predittivo con la funzione rpart()
mod <- rpart(label ~., train)
pred <- predict(mod, test, type = "class")

# visualizziamo i risultati
table(pred, test$label)

# creiamo una rappresentazione grafica del modello tramite il pacchetto rattle e la funzione fancyRpartPlot()
fancyRpartPlot(mod)

# testiamo il modello sui dati non etichettati e visualizziamoli
pred2 <- predict(mod, topred, type = "class")

cbind(topred, pred2)

install.packages("rpart")
library(rpart)

install.packages("kernlab")
library(kernlab)
data(spam)

# mescoliamo i casi spam e quelli non spam
random <- runif(nrow(spam))
spam2 <- spam[order(random),]

# creiamo un oggetto di train e un oggetto di test
train <- spam2[1:3500,]
test <- spam2[3501:4601,]

rpes <- rpart(type ~., train)

rpes

printcp(rpes)

install.packages("rpart.plot")
library(rpart.plot)
                 
prp(rpes)

install.packages("maptree")
library(maptree)
draw.tree(rpes)


pred <- predict(rpes, test, type = "class")

table(pred, test$type)




                 

