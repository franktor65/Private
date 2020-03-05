install.packages("nnet")
library(nnet)

set.seed(12345)
random <- runif(nrow(iris))
iris2 <- iris[order(random),]


train <- iris2[1:100,]
test <- iris2[101:150,]


nn <- nnet(Species ~., train, size = 1, rang = 0.1, maxit = 200)

summary(nn)
print(nn)

pred <- predict(nn, test, type = "class")

table(test$Species, pred)

plotnet(nn)


