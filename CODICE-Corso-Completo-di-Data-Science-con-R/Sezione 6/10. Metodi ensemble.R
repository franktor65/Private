# bagging

install.packages("adabag")
library(adabag)

install.packages("kernlab")
library(kernlab)
data(spam)

## mescoliamo i casi del dataset spam, perché se andate a visualizzarlo, tramite View(spam), potrete notare che ci sono prima tutti i casi classificati come spam, e poi tutti quelli non spam

## mettiamo il set.seed() in modo che i nostri risultati siano replicabili
set.seed(12345)
random <- runif(nrow(spam))
spam2 <- spam[order(random),]

## creiamo un oggetto di train
## creiamo un oggetto di test
train <- spam2[1:3500,]
test <- spam2[3501:4601,]

## creiamo il modello di bagging
adbg <- bagging(type~., data = train)

## visualizziamo qualche informazione sul modello creato
summary(adbg)


## utilizziamo il modello predittivo per inferire la classificazione degli item nell'oggetto test
pred <- predict(adbg, test, type = "class")

## se stampiamo pred possiamo visualizzare la matrice di confusione e il tasso di errore

pred

pred$confusion


# boosting

install.packages("ada")
library(ada)

# creiamo il modello
ada_test <- ada(type ~., train, loss = "logistic")

# visualizziamo il modello creato
ada_test

# prediciamo la classe dell'oggetto di test
pred <- predict(ada_test, test)

# creiamo la matrice di confusione per visualizzare i risultati
table(pred, test$type)

# random forest

install.packages("randomForest")
library(randomForest)

rf <- randomForest(type ~., data = train)

importance(rf)

varImpPlot(rf)

pred_rf <- predict(rf, test, type = "class")

table(pred_rf, test$type)

# caret

install.packages('caret')
library(caret)

confusionMatrix(pred$class, test$type)

confusionMatrix(pred2, test$type)

confusionMatrix(pred3, test$type)
