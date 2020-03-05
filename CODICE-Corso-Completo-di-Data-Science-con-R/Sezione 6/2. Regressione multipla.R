install.packages("MASS")
library(MASS)
data(Boston)


# utilizziamo solo una parte del dataset per non avere overfitting quando andiamo a predire su un nuovo dataset
# per utilizzare tutte le variabili come regressori, possiamo usare questo simbolo ~. 
ml <- lm(medv ~., data = Boston[1:400,])

# oppure scrivere tutte le variabili separate dal segno "+"
ml <- lm(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat, data = Boston)

# la funzione summary() utilizzata sul modello ci restituisce ulteriori informazioni
summary(ml)


# creiamo il modello predittivo sui dati rimanenti del dataset
pred <- predict(ml, Boston[401:506,], type = "response")

# calcoliamo il tasso di errore
val <- Boston[401:506, "medv"]
sqrt(mean((pred - val)^2))


# mettiamo a confronto con i risultati iniziali
cbind(round(pred), val)

# visualizziamo i grafici relativi ai residui
par(mfrow = c(2,2))
plot(ml)


