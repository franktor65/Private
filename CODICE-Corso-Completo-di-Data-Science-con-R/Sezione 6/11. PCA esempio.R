# creiamo un piccolo dataframe contenente i voti in alcuni esami di alcuni studenti
Mary <- c(22, 25, 30, 28, 27)
Laura <- c(30, 28, 29, 25, 30)
Francis <- c(28, 22, 30, 27, 20)
Dominic <- c(23, 24, 28, 22,27)
Kate <- c(30, 28, 30, 29, 25)
Simon <- c(30, 30, 29, 18, 30)
Jane <- c(25, 28, 22, 23, 23)
Robert <- c(22, 25, 27, 30, 18)
Rosie <- c(18, 22, 24, 30, 18)
Mattew <- c(25, 27, 29, 25, 23)


df <- as.data.frame(rbind(Mary, Laura, Francis, Dominic, Kate, Simon, Jane, Robert, Rosie, Mattew))
colnames(df) <- c("Stats", "Math", "Machine Learning", "Python", "R")

# abbiamo quindi 10 casi e 5 variabili
str(df)

pca <- princomp(df)

# vediamo alcuni dati relativi al modello
summary(pca)

# visualizziamo le componenti principali
unclass(pca$loadings)

pca$scores

# creiamo una rappresentazione grafica
plot(pca, col = "purple")
