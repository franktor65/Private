# esempio1 su dataset iris

library(e1071)

# mescoliamo i casi
random <- runif(nrow(iris))
iris2 <- iris[order(random),]

# creiamo un oggetto di train e uno di test
train <- iris2[1:100,]
test <- iris2[101:150,]

# creiamo il modello predittivo
mod <- svm(Species ~., train, method = "C-classification", kernel = "radial", cost = 10, gamma = 0.1)

# applichiamo il modello predittivo all'oggetto di test
pred <- predict(mod, test)

# mettiamo a confronto i risultati predetti con quelli effettivi
table(pred, test$Species)

# esempio2 su dataset di spam
library(kernlab)
data(spam)

random <- runif(nrow(spam))
spam2 <- spam[order(random),]


train <- spam2[1:3500,]
test <- spam2[3501:4601,]

mod <- svm(type ~., train, method = "C-classification", kernel = "radial", cost = 10, gamma = 0.1)

pred <- predict(mod, test)

table(pred, test$type)