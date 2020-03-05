install.packages("rpart")
library(rpart)

nstall.packages(“kernlab”)
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





