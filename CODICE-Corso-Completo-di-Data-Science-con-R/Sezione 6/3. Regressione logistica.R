# generiamo un dataset casuale per la regressione logistica

set.seed(12345)

df <- data.frame(replicate(1, sample(0:500, 1000, rep=TRUE)))

colnames(df) <- "var1"


df$var2 <- ifelse(df$var1 > 250, 1, 0)
head(df)

# convertiamo la variabile var2 in fattore

df$var2 <- factor(df$var2)

# creiamo un grafico
plot(df)

# creiamo gli oggetti di train e di test

train <- df[1:700,]
test <- df[701:1000,]


# creiamo il modello predittivo
mod <- glm(var2 ~ var1, data=train, family=binomial(logit), control = list(maxit = 50))

# testiamo il modello predittivo sul dataset di test
pred <- predict(mod, test, 'response')


# verifichiamo i risultati
table(round(pred), test$var2)

# visualizziamo un riepilogo del modello
summary(mod)

# facciamo un secondo esempio con un dataset che contenga più variabili per la creazione del modello

# utilizziamo un dataset presente su UCI che registra i tassi di diabete in un particolare gruppo etnico degli Stati Uniti 
diab <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data", sep = ",")

# estraiamo un dataset di train e uno di test
train <- diab[1:500,]
test <- diab[501:768,]

# creiamo il modello predittivo. La variabile che registra la presenza o assenza di diabete, è l'ultima, la V9
mod <- glm(V9 ~., data=train, family=binomial(logit))

# testiamo il modello predittivo sul dataset di test
pred <- predict(mod, test, type='response')

# verifichiamo le differenze con i dati effettivi e misuriamo l'errore
val <- test[, 9]
sqrt(mean((pred - val)^2))

# visualizziamo una parte dei dati a confronto:
cbind(round(pred), val)

# verifichiamo un riepilogo del modello
summary(mod)

# creiamo la crosstab
table(round(pred), test$V9)

tab <- table(round(pred), test$V9)

# visualizziamo i risultati con il pacchetto caret, il cui output è di pià semplice interpretazione
library(caret)

confusionMatrix(tab)
