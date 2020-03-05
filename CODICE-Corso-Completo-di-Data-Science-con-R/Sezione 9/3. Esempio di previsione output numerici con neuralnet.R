# carichiamo il pacchetto per la costruzione della rete neurale
library(neuralnet)

# carichiamo il pacchetto che contiene il dataset
library(MASS)

# creiamo un oggetto che contiene il dataset
df <- Boston

# normalizziamo creando la funzione di normalizzazione e applicandola al dataset
normalize <- function(x) { 
        return((x - min(x)) / (max(x) - min(x)))
}


dfn <- as.data.frame(lapply(Boston, normalize))


# creiamo un oggetto di train e uno di test
library(caTools)

# fissiamo un seed
set.seed(12345)

split <- sample.split(dfn$medv, SplitRatio = 0.75)
train <- subset(dfn, split == TRUE)
test <- subset(dfn, split == FALSE)

# creiamo il modello di rete neurale
coln <- names(df)
formula <- as.formula(paste("medv ~", paste(coln[!coln %in% "medv"], collapse = " + ")))

nn <- neuralnet(formula, data = train, hidden = 10, linear.output = T)

# creiamo un grafico contenente la rete neurale
plot(nn)

summary(nn)

# la funzione garson() del pacchetto NeuralNetTools 
# ci restituisce l'importanza delle variabili di input su modelli a una sola uscita

library(NeuralNetTools)

garson(nn)

plotnet(nn)

# computiamo le predizioni sull'oggetto di test
pred <- compute(nn, test[,1:13])

prediction <- pred$net.result

# computiamo la correlazione tra i dati predetti e quelli effettivi, e sotto l'errore
cor(prediction, test$medv)

library(caret)

RMSE(prediction, test$medv)



